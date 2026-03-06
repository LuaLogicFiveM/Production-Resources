---@diagnostic disable: duplicate-set-field, undefined-field
if GetResourceState("es_extended") ~= "started" then
    return;
end
ESX = exports.es_extended:getSharedObject();

function FRAMEWORKS.SERVER.GetCore()
    return ESX;
end

function FRAMEWORKS.SERVER.GetPlayer(src)
    return ESX.GetPlayerFromId(src);
end

function FRAMEWORKS.SERVER.GetPlayers()
    return ESX.GetExtendedPlayers();
end

function FRAMEWORKS.SERVER.GetPlayerSources()
    local sources = {};
    for _, player in ipairs(FRAMEWORKS.SERVER.GetPlayers()) do
        table.insert(sources, player.source);
    end
    return sources;
end

function FRAMEWORKS.SERVER.GetPlayerName(src)
    local xPlayer = FRAMEWORKS.SERVER.GetPlayer(src);
    if xPlayer then
        return xPlayer.variables.firstName .. " " .. xPlayer.variables.lastName;
    end
    return nil;
end

function FRAMEWORKS.SERVER.GetIdentifier(src)
    local xPlayer = FRAMEWORKS.SERVER.GetPlayer(src);
    if xPlayer then
        return xPlayer.identifier;
    end
    return nil;
end

function FRAMEWORKS.SERVER.GetPlayerJobinfo(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return nil;
    end
    local j = xPlayer.getJob();
    if not j then
        return nil;
    end
    return {
        name = j.name,
        label = j.label,
        grade = j.grade,
        gradeLabel = j.grade_label,
    };
end

function FRAMEWORKS.SERVER.GetBalance(source, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or not type then
        return 0
    end

    type = string.lower(type)

    if type == 'cash' then
        return tonumber(xPlayer.getMoney()) or 0
    end

    if type == 'bank' or type == 'black_money' then
        local acc = xPlayer.getAccount(type)
        return acc and tonumber(acc.money) or 0
    end

    return 0
end


function FRAMEWORKS.SERVER.HasMoney(src, type, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end

    local accountTypes = {
        cash = "money",
        bank = "bank",
        black_money = "black_money"
    }

    local account = accountTypes[type]
    if not account then
        return false
    end

    amount = tonumber(amount) or 0
    if amount <= 0 then
        return false
    end

    if account == "money" then
        return xPlayer.getMoney() >= amount
    else
        local acc = xPlayer.getAccount(account)
        if not acc or acc.money == nil then
            return false
        end
        return acc.money >= amount
    end
end

function FRAMEWORKS.SERVER.RegisterUsableItem(item, cb)
    ESX.RegisterUsableItem(item, cb)
end

local ACCOUNT_MAP = {
    cash = 'money',
    bank = 'bank',
    black_money = 'black_money'
}

function FRAMEWORKS.SERVER.AddMoney(src, type, amount, reason)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end

    amount = tonumber(amount)
    if not amount or amount <= 0 then
        return false
    end

    type = string.lower(type)
    local account = ACCOUNT_MAP[type]
    if not account then
        return false
    end

    reason = reason or ''

    if account == 'money' then
        xPlayer.addMoney(amount)
    else
        xPlayer.addAccountMoney(account, amount)
    end

    return true
end

function FRAMEWORKS.SERVER.RemoveMoney(src, type, amount, reason)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end

    amount = tonumber(amount)
    if not amount or amount <= 0 then
        return false
    end

    type = string.lower(type)
    local account = ACCOUNT_MAP[type]
    if not account then
        return false
    end

    reason = reason or ''

    if account == 'money' then
        if xPlayer.getMoney() < amount then
            return false
        end
        xPlayer.removeMoney(amount)
    else
        local acc = xPlayer.getAccount(account)
        if not acc or acc.money < amount then
            return false
        end
        xPlayer.removeAccountMoney(account, amount)
    end

    return true
end

function FRAMEWORKS.SERVER.isOnDuty(src)
    local xPlayer = FRAMEWORKS.SERVER.GetPlayer(src);
    if not xPlayer then
        return false;
    end
    local job = xPlayer.getJob();
    return job and job.onDuty == true;
end

function FRAMEWORKS.SERVER.HasMoneyAndRemove(src, type, count)
    local xPlayer = FRAMEWORKS.SERVER.GetPlayer(src)
    local accountTypes = {
        cash = "money",
        bank = "bank"
    }
    local account = accountTypes[type]

    count = tonumber(count)
    if not xPlayer or not account or not count or count <= 0 then
        return false
    end

    if account == "money" then
        if xPlayer.getMoney() >= count then
            xPlayer.removeMoney(count)
            return true
        end
    else
        local acc = xPlayer.getAccount(account)
        local playerMoney = acc and acc.money or 0
        if playerMoney >= count then
            xPlayer.removeAccountMoney(account, count)
            return true
        end
    end

    return false
end

function FRAMEWORKS.SERVER.GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier).playerId;
end

function FRAMEWORKS.SERVER.isPlayerOnlineAndOnduty(identifier)
    local xPlayers = ESX.GetExtendedPlayers()
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.identifier == identifier then
            local job = xPlayer.getJob()
            return job.onDuty == true
        end
    end
    return false
end

function FRAMEWORKS.SERVER.GetAllJobData()
    local jobs = ESX.GetJobs()
    local jobData = {}

    for _, job in pairs(jobs) do
        local grades = {}

        for gradeIndex, gradeInfo in pairs(job.grades) do
            table.insert(grades, {
                grade = tonumber(gradeIndex),
                name = gradeInfo.name,
                label = gradeInfo.label,
                salary = gradeInfo.salary,
                isBoss = nil
            })
        end

        table.insert(jobData, {
            name = job.name,
            label = job.label,
            grades = grades
        })
    end

    return jobData
end

function FRAMEWORKS.SERVER.GetAllFrameworkUsers()
    local xPlayers = ESX.GetExtendedPlayers()

    local frameworkUsers = {}
    for _, xPlayer in pairs(xPlayers) do
        table.insert(frameworkUsers, {
            id = xPlayer.source,
            name = xPlayer.name,
            identifier = xPlayer.identifier
        })
    end
    return frameworkUsers
end

-- Db functions
function FRAMEWORKS.SERVER.GetDBPlayerBasicDataByIdentifier(identifier)
    if not identifier then
        return nil
    end

    local result = MySQL.single.await([[
            SELECT
                identifier,
                job,
                job_grade,
                firstname,
                lastname,
                dateofbirth,
                sex,
                accounts
            FROM users
            WHERE identifier = ?
        ]], {identifier})

    if not result then
        return nil
    end

    local decoded = result.accounts and json.decode(result.accounts) or {}

    local accounts = {
        money = 0,
        bank = 0
    }

    for _, acc in ipairs(decoded) do
        if acc.name == 'money' then
            accounts.money = acc.money or 0
        elseif acc.name == 'bank' then
            accounts.bank = acc.money or 0
        end
        -- if more type needed add here
    end

    return {
        identifier = result.identifier,
        job = result.job,
        job_grade = result.job_grade,
        firstname = result.firstname,
        lastname = result.lastname,
        fullname = string.format('%s %s', result.firstname or '', result.lastname or ''),
        dob = result.dateofbirth,
        sex = result.sex,
        accounts = accounts
    }
end
