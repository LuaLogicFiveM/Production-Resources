---@diagnostic disable: duplicate-set-field, undefined-field
if GetResourceState("qb-core") ~= "started" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

function FRAMEWORKS.SERVER.GetCore()
    return QBCore
end

function FRAMEWORKS.SERVER.GetPlayer(src)
    return QBCore.Functions.GetPlayer(src)
end

function FRAMEWORKS.SERVER.GetPlayers()
    local qbPlayers = QBCore.Functions.GetPlayers()
    local players = {}
    for _, src in pairs(qbPlayers) do
        local player = QBCore.Functions.GetPlayer(src)
        if player then
            players[#players + 1] = player
        end
    end
    return players
end

function FRAMEWORKS.SERVER.GetPlayerSources()
    local sources = {}
    local qbPlayers = QBCore.Functions.GetPlayers()
    for _, src in pairs(qbPlayers) do
        table.insert(sources, src)
    end
    return sources
end

function FRAMEWORKS.SERVER.GetPlayerName(src)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player or not player.PlayerData or not player.PlayerData.charinfo then
        return nil
    end

    local charinfo = player.PlayerData.charinfo
    local firstname = charinfo.firstname or ""
    local lastname = charinfo.lastname or ""
    local full = (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")

    return full ~= "" and full or nil
end

function FRAMEWORKS.SERVER.GetIdentifier(src)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player or not player.PlayerData then
        return nil
    end
    return player.PlayerData.citizenid
end

function FRAMEWORKS.SERVER.GetPlayerJobinfo(src)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player or not player.PlayerData or not player.PlayerData.job then
        return nil
    end

    local job = player.PlayerData.job
    local grade = job.grade or {}

    return {
        name = job.name,
        label = job.label,
        grade = grade.level,
        gradeLabel = grade.name
    }
end

function FRAMEWORKS.SERVER.GetBalance(source, type)
    local player = FRAMEWORKS.SERVER.GetPlayer(source)
    if not player or not player.PlayerData or not player.PlayerData.money then
        return 0
    end

    type = string.lower(type or "")
    if type == 'money' then
        type = 'cash'
    end

    local balance = player.PlayerData.money[type] or 0
    return tonumber(balance) or 0
end

function FRAMEWORKS.SERVER.HasMoney(src, type, amount)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player then
        return false
    end

    amount = tonumber(amount) or 0
    if amount <= 0 then
        return false
    end

    return FRAMEWORKS.SERVER.GetBalance(src, type) >= amount
end

function FRAMEWORKS.SERVER.RegisterUsableItem(item, cb)
    local func = function(src, itemName, itemData)
        itemData = itemData or itemName
        itemData.metadata = itemData.metadata or itemData.info or {}
        itemData.slot = itemData.id or itemData.slot
        cb(src, itemData)
    end
    return QBCore.Functions.CreateUseableItem(item, func)
end

function FRAMEWORKS.SERVER.AddMoney(src, type, amount, reason)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player then
        return false
    end

    amount = tonumber(amount)
    if not amount or amount <= 0 then
        return false
    end

    type = string.lower(type or "")
    if type == 'money' then
        type = 'cash'
    end

    return player.Functions.AddMoney(type, amount)
end

function FRAMEWORKS.SERVER.RemoveMoney(src, type, amount, reason)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player then
        return false
    end

    amount = tonumber(amount)
    if not amount or amount <= 0 then
        return false
    end

    type = string.lower(type or "")
    if type == 'money' then
        type = 'cash'
    end

    return player.Functions.RemoveMoney(type, amount)
end

function FRAMEWORKS.SERVER.isOnDuty(src)
    local player = FRAMEWORKS.SERVER.GetPlayer(src)
    if not player or not player.PlayerData or not player.PlayerData.job then
        return false
    end
    return player.PlayerData.job.onduty == true
end

function FRAMEWORKS.SERVER.HasMoneyAndRemove(src, type, count)
    return FRAMEWORKS.SERVER.RemoveMoney(src, type, count)
end

function FRAMEWORKS.SERVER.GetPlayerFromIdentifier(identifier)
    if not identifier then
        return nil
    end

    local qbPlayers = QBCore.Functions.GetPlayers()
    for _, src in pairs(qbPlayers) do
        local player = QBCore.Functions.GetPlayer(src)
        if player and player.PlayerData and player.PlayerData.citizenid == identifier then
            return player.PlayerData.source
        end
    end

    return nil
end

function FRAMEWORKS.SERVER.isPlayerOnlineAndOnduty(identifier)
    if not identifier then
        return false
    end

    local qbPlayers = QBCore.Functions.GetPlayers()
    for _, src in pairs(qbPlayers) do
        local player = QBCore.Functions.GetPlayer(src)
        local pd = player and player.PlayerData
        if pd and pd.citizenid == identifier and pd.job and pd.job.onduty then
            return true
        end
    end

    return false
end

function FRAMEWORKS.SERVER.GetAllJobData()
    local jobs = QBCore.Shared.Jobs
    local jobData = {}

    for jobName, job in pairs(jobs) do
        local grades = {}

        if job.grades then
            for gradeLevel, gradeInfo in pairs(job.grades) do
                table.insert(grades, {
                    grade = tonumber(gradeLevel),
                    name = gradeInfo.name,
                    label = gradeInfo.name,
                    salary = gradeInfo.payment,
                    isBoss = nil
                })
            end
        end

        table.insert(jobData, {
            name = jobName,
            label = job.label,
            grades = grades
        })
    end

    return jobData
end

function FRAMEWORKS.SERVER.GetAllFrameworkUsers()
    local users = {}
    local qbPlayers = QBCore.Functions.GetPlayers()

    for _, src in pairs(qbPlayers) do
        local player = QBCore.Functions.GetPlayer(src)
        local pd = player and player.PlayerData
        if pd then
            local charinfo = pd.charinfo or {}
            local firstname = charinfo.firstname or ""
            local lastname = charinfo.lastname or ""
            local fullname = (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")

            users[#users + 1] = {
                id = pd.source,
                name = fullname ~= "" and fullname or GetPlayerName(pd.source),
                identifier = pd.citizenid
            }
        end
    end

    return users
end

local function ProcessPlayerResult(result)
    if not result then
        return nil
    end

    local charinfo = {}
    if result.charinfo and result.charinfo ~= '' then
        local success, decoded = pcall(function()
            return json.decode(result.charinfo)
        end)
        if success and decoded then
            charinfo = decoded
        end
    end

    local money = {}
    if result.money and result.money ~= '' then
        local success, decoded = pcall(function()
            return json.decode(result.money)
        end)
        if success and decoded then
            money = decoded
        end
    end

    local job = {}
    local jobGrade = nil
    if result.job and result.job ~= '' then
        local success, decoded = pcall(function()
            return json.decode(result.job)
        end)
        if success and decoded then
            job = decoded
            if job.grade and job.grade.level then
                jobGrade = job.grade.level
            end
        end
    end

    local firstname = charinfo.firstname or ''
    local lastname = charinfo.lastname or ''
    local fullname = string.format('%s %s', firstname, lastname):gsub("^%s+", ""):gsub("%s+$", "")
    
    if fullname == '' and result.name and result.name ~= '' then
        fullname = result.name
        local nameParts = {}
        for part in result.name:gmatch("%S+") do
            table.insert(nameParts, part)
        end
        if #nameParts >= 2 then
            firstname = nameParts[1]
            lastname = table.concat(nameParts, " ", 2)
        elseif #nameParts == 1 then
            firstname = nameParts[1]
            lastname = ''
        end
    elseif fullname == '' then
        fullname = nil
    end

    return {
        identifier = result.citizenid,
        job = result.job,
        job_grade = jobGrade,
        firstname = firstname ~= '' and firstname or nil,
        lastname = lastname ~= '' and lastname or nil,
        fullname = fullname,
        dob = charinfo.birthdate,
        sex = charinfo.gender,
        accounts = {
            money = money.cash or 0,
            bank = money.bank or 0
        }
    }
end

function FRAMEWORKS.SERVER.GetDBPlayerBasicDataByIdentifier(identifier)
    if not identifier then
        return nil
    end

    local result = MySQL.single.await([[
            SELECT
                citizenid,
                name,
                job,
                charinfo,
                money
            FROM players
            WHERE citizenid = ?
        ]], {identifier})

    if not result then
        return nil
    end

    return ProcessPlayerResult(result)
end
