---@diagnostic disable: duplicate-set-field, undefined-field
if GetResourceState("es_extended") ~= "started" then
    return;
end
ESX = exports.es_extended:getSharedObject();

local isDead

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer, isNew, skin)
    FRAMEWORKS.CLIENT.playerData = xPlayer
    FRAMEWORKS.CLIENT.playerLoaded = true
    
    local playerData = ESX.GetPlayerData()
    if playerData then
        FRAMEWORKS.CLIENT.playerData = playerData
    end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    FRAMEWORKS.CLIENT.playerData.job = job
    ESX.PlayerData = job
end)

AddEventHandler("esx:onPlayerDeath", function(data)
    isDead = true
end)

AddEventHandler("esx:onPlayerSpawn", function(noAnim)
    isDead = nil
    local playerData = ESX.GetPlayerData()
    if playerData then
        FRAMEWORKS.CLIENT.playerData = playerData
    end
end)

RegisterNetEvent("esx:onPlayerLogout")
AddEventHandler("esx:onPlayerLogout", function()
    FRAMEWORKS.CLIENT.playerLoaded = false
    FRAMEWORKS.CLIENT.playerData = {}
end)

function FRAMEWORKS.CLIENT.GetCore()
    return ESX
end

function FRAMEWORKS.CLIENT.GetPlayerData()
    return FRAMEWORKS.CLIENT.playerData
end

function FRAMEWORKS.CLIENT.isPlayerDead()
    return isDead
end

function FRAMEWORKS.CLIENT.GetPlayerJob()
    local playerData = ESX.GetPlayerData()
    if not playerData or not playerData.job then
        return nil
    end
    return {
        name = playerData.job.name,
        label = playerData.job.label,
        grade_name = playerData.job.grade_name,
        grade_label = playerData.job.grade_label,
        grade_salary = playerData.job.grade_salary,
        grade = playerData.job.grade,
        isboss = playerData.job.grade_name == "boss" or false,
        onduty = (playerData.job and playerData.job.onDuty ~= nil) and playerData.job.onDuty or true,
        isGang = false
    }
end

function FRAMEWORKS.CLIENT.GetPlayerGang()
    return nil
end

function FRAMEWORKS.CLIENT.GetIdentifier()
    return ESX.GetPlayerData().identifier
end

function FRAMEWORKS.CLIENT.GetPlayerName()
    local playerData = ESX.GetPlayerData()
    if not playerData then
        return "Unknown"
    end

    if playerData.firstName and playerData.lastName then
        return playerData.firstName .. " " .. playerData.lastName
    end

    if playerData.name then
        return playerData.name
    end

    return "Unknown"
end

function FRAMEWORKS.CLIENT.GetBalance(account)
    local playerData = ESX.GetPlayerData()
    if not playerData or not playerData.accounts then
        return 0
    end

    if account == 'cash' then
        account = 'money'
    end

    for _, acc in ipairs(playerData.accounts) do
        if acc.name == account then
            local balance = tonumber(acc.money) or 0
            return balance
        end
    end

    return 0
end
