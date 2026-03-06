---@diagnostic disable: duplicate-set-field, undefined-field
if GetResourceState("qbx_core") ~= "started" then
    return
end

local QBox = exports.qbx_core

function FRAMEWORKS.SERVER.GetCore()
    return QBox
end

function FRAMEWORKS.SERVER.GetPlayer(src)
    return QBox:GetPlayer(src)
end

function FRAMEWORKS.SERVER.GetPlayers()
    local qbPlayers = QBox:GetQBPlayers()
    local players = {}
    for src, player in pairs(qbPlayers) do
        if player then
            players[#players + 1] = player
        end
    end
    return players
end

function FRAMEWORKS.SERVER.GetPlayerSources()
    local sources = {}
    local qbPlayers = QBox:GetQBPlayers()
    for src, _ in pairs(qbPlayers) do
        sources[#sources + 1] = src
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
        gradeLabel = grade.name,
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
    -- this below from community_bridge
    local func = function(src, itemName, itemData)
        itemData = itemData or itemName
        itemData.metadata = itemData.metadata or itemData.info or {}
        itemData.slot = itemData.id or itemData.slot
        cb(src, itemData)
    end
    return QBox:CreateUseableItem(item, func)
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

    return player.Functions.AddMoney(type, amount, reason or "")
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

    if not FRAMEWORKS.SERVER.HasMoney(src, type, amount) then
        return false
    end

    type = string.lower(type or "")
    if type == 'money' then
        type = 'cash'
    end

    return player.Functions.RemoveMoney(type, amount, reason or "")
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

    local qbPlayers = QBox:GetQBPlayers()
    for src, player in pairs(qbPlayers) do
        if player and player.PlayerData and player.PlayerData.citizenid == identifier then
            return player.PlayerData.source or src
        end
    end

    return nil
end

function FRAMEWORKS.SERVER.isPlayerOnlineAndOnduty(identifier)
    if not identifier then
        return false
    end

    local qbPlayers = QBox:GetQBPlayers()
    for src, player in pairs(qbPlayers) do
        local pd = player and player.PlayerData
        if pd and pd.citizenid == identifier and pd.job and pd.job.onduty then
            return true
        end
    end

    return false
end

function FRAMEWORKS.SERVER.GetAllJobData()
    local jobs = QBox.GetJobs()
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
    local qbPlayers = QBox:GetQBPlayers()

    for src, player in pairs(qbPlayers) do
        local pd = player and player.PlayerData
        if pd then
            local charinfo = pd.charinfo or {}
            local firstname = charinfo.firstname or ""
            local lastname = charinfo.lastname or ""
            local fullname = (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")

            users[#users + 1] = {
                id = pd.source or src,
                name = fullname ~= "" and fullname or GetPlayerName(src),
                identifier = pd.citizenid
            }
        end
    end

    return users
end

function FRAMEWORKS.SERVER.GetDBPlayerBasicDataByIdentifier(identifier)
    if not identifier then
        return nil
    end

    local result = MySQL.single.await([[
            SELECT
                citizenid,
                job,
                job_grade,
                charinfo,
                money
            FROM players
            WHERE citizenid = ?
        ]], {identifier})

    if not result then
        return nil
    end

    local charinfo = result.charinfo and json.decode(result.charinfo) or {}
    local money = result.money and json.decode(result.money) or {}

    return {
        identifier = result.citizenid,
        job = result.job,
        job_grade = result.job_grade,
        firstname = charinfo.firstname,
        lastname = charinfo.lastname,
        fullname = string.format('%s %s', charinfo.firstname or '', charinfo.lastname or ''),
        dob = charinfo.birthdate,
        sex = charinfo.gender,
        accounts = {
            money = money.cash or 0,
            bank = money.bank or 0
        }
    }
end
