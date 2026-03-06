---@diagnostic disable: duplicate-set-field
if GetResourceState("es_extended") ~= "started" then
    return
end
ESX = exports.es_extended:getSharedObject()
local jobLabelCache = {}
local playerInfoCache = {}

G = {}

function G.GetCore()
    return ESX
end
function G.GetPlayer(src)
    return ESX.GetPlayerFromId(src)
end

function G.GetPlayers()
    return ESX.GetExtendedPlayers()
end

AddEventHandler('esx:setJob', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        playerInfoCache[xPlayer.identifier] = nil
    end
end)

function G.GetPlayerName(src)
    local xPlayer = G.GetPlayer(src)
    if xPlayer then
        return xPlayer.variables.firstName .. " " .. xPlayer.variables.lastName
    end
    return nil
end

function G.GetIdentifier(src)
    local xPlayer = G.GetPlayer(src)
    if xPlayer then
        return xPlayer.identifier
    end
    return nil
end

function G.AddItem(src, name, count, metadata)
    local xPlayer = G.GetPlayer(src)
    xPlayer.addInventoryItem(name, count, metadata)
end
function G.RemoveItem(src, name, count)
    local xPlayer = G.GetPlayer(src)
    xPlayer.removeInventoryItem(name, count)
end

function G.PlayerJobinfo(src)
    local xPlayer = G.GetPlayer(src)
    if not xPlayer then
        return nil
    end
    local j = xPlayer.getJob()
    if not j then
        return nil
    end
    local jb = {
        name = j.name,
        label = j.label,
        grade = j.grade,
        gradeLabel = j.grade_label
    }
    return jb
end

function G.AddMoney(src, type, count)
    type = string.lower(type)
    local xPlayer = G.GetPlayer(src)
    local accountTypes = {
        cash = "cash",
        bank = "bank",
        blackmoney = "black_money"
    }
    local account = accountTypes[type]

    if not xPlayer then
        return false
    end

    if not account then
        return false
    end

    count = tonumber(count) or 0
    if count <= 0 then
        return false
    end

    if account == "cash" then
        xPlayer.addMoney(count)
        -- xPlayer.addInventoryItem('cash',1000) -- uncomment this line if you want to add cash in inventory
        return true
    else
        xPlayer.addAccountMoney(account, count)
        return true
    end
end

function G.GetInventoryItem(src, itemName)
    local xPlayer = G.GetPlayer(src)
    if not xPlayer then
        return nil
    end
    local item = xPlayer.getInventoryItem(itemName)
    if item and item.count > 0 then
        return {
            name = item.name,
            amount = item.count
        }
    else
        return nil
    end
end

function G.NormalizeItem(item)
    return {
        name = item.name or item.item,
        amount = item.amount or item.count or 1
    }
end

function G.GetInformationByIdentifier(identifier)
    if not identifier then
        return nil
    end

    if playerInfoCache[identifier] then
        return playerInfoCache[identifier]
    end

    local user = MySQL.single.await("SELECT * FROM users WHERE identifier = ? LIMIT 1", {identifier})

    if not user then
        return nil
    end

    local jobKey = user.job .. ":" .. user.job_grade
    local jobLabel = jobLabelCache[jobKey]

    if not jobLabel then
        local row = MySQL.single.await([[
			SELECT j.label AS job_label, g.label AS grade_label
			FROM jobs j
			JOIN job_grades g ON j.name = g.job_name AND g.grade = ?
			WHERE j.name = ?
			LIMIT 1
		]], {user.job_grade, user.job})

        jobLabel = row and (row.job_label .. " " .. row.grade_label) or "Unknown"
        jobLabelCache[jobKey] = jobLabel
    end

    local data = {
        firstName = user.firstname,
        lastName = user.lastname,
        identifier = user.identifier,
        job = {
            name = user.job,
            grade = user.job_grade
        },
        job_label = jobLabel,
        sex = user.sex == "m" and "male" or "female",
        ph = user.phone_number or 0,
        dob = user.dateofbirth or "N/A"
    }

    playerInfoCache[identifier] = data

    return data
end

function G.isPlayerOnlineAndOnduty(identifier)
    local xPlayers = ESX.GetExtendedPlayers()
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.identifier == identifier then
            local job = xPlayer.getJob()
            return job.onDuty == true
        end
    end
    return false
end

function G.SetJob(src, onDuty)
    local xPlayer = G.GetPlayer(src)
    if not xPlayer then
        return
    end

    local job = xPlayer.getJob()
    local jobName, grade = job.name, job.grade

    xPlayer.setJob(jobName, grade, onDuty)
    Wait(100)

    local newJob = xPlayer.getJob()
    DebugLog(("[g-dutyV2] %s is now %s duty as %s (Grade %s)"):format(GetPlayerName(src),
        newJob.onDuty and "ON" or "OFF", newJob.label, newJob.grade_label))
end

function G.isOnDuty(src)
    local xPlayer = G.GetPlayer(src)
    if not xPlayer then
        return false
    end
    local job = xPlayer.getJob()
    return job.onDuty
end

function G.isAllowed(src)
    local xPlayer = G.GetPlayer(src)
    if not xPlayer then
        return false
    end

    local job = xPlayer.getJob()
    local jobName = job.name
    local myGrade = job.grade

    if not Config.DutySystem[jobName] then
        return false
    end

    local stationConfig = Config.DutySystem[jobName].Station
    if not stationConfig or not stationConfig.boss then
        return false
    end

    local allowedGrades = stationConfig.boss.allowedGrades or {}
    for _, grade in ipairs(allowedGrades) do
        if grade == myGrade then
            return true
        end
    end
    return false
end
-- don't worry about this function its for testing
-- function G.SetPlayerJobServer(src, identifier, jobName, jobGrade)
-- 	if not identifier or not jobName or type(jobGrade) ~= "number" then
-- 		return
-- 	end

-- 	if not ESX.Jobs[jobName] then
-- 		return
-- 	end

-- 	local xPlayer = ESX.GetPlayerFromId(src)
-- 	if xPlayer then
-- 		MySQL.update("UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?", { jobName, jobGrade, identifier })
-- 	end
-- end

function G.SetPlayerJobServer(src, identifier, jobName, jobGrade)
    if not identifier or not jobName or type(jobGrade) ~= "number" then
        return
    end

    if not ESX.Jobs[jobName] then
        return
    end

    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.update("UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?", {jobName, jobGrade, identifier})
        playerInfoCache[identifier] = nil
    end
end

AddEventHandler('playerDropped', function()
    local src = source
    local identifier = G.GetIdentifier(src)
    if identifier then
        playerInfoCache[identifier] = nil
    end
end)
