---@diagnostic disable: duplicate-set-field, undefined-field
if GetResourceState("qb-core") ~= "started" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

local isDead

FRAMEWORKS.CLIENT.playerData = FRAMEWORKS.CLIENT.playerData or {}
FRAMEWORKS.CLIENT.playerLoaded = FRAMEWORKS.CLIENT.playerLoaded or false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(1500)
    FRAMEWORKS.CLIENT.playerLoaded = true
    local playerData = QBCore.Functions.GetPlayerData()
    if playerData then
        FRAMEWORKS.CLIENT.playerData = playerData
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    FRAMEWORKS.CLIENT.playerLoaded = false
    FRAMEWORKS.CLIENT.playerData = {}
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(data)
    if data then
        FRAMEWORKS.CLIENT.playerData.job = data
    end
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(playerData)
    if playerData then
        FRAMEWORKS.CLIENT.playerData = playerData
        local metadata = playerData.metadata or {}
        isDead = metadata.isdead or metadata.inlaststand or false
    end
end)

function FRAMEWORKS.CLIENT.GetCore()
    return QBCore
end

function FRAMEWORKS.CLIENT.GetPlayerData()
    return FRAMEWORKS.CLIENT.playerData
end

function FRAMEWORKS.CLIENT.isPlayerDead()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.metadata then
        return isDead or false
    end
    return playerData.metadata.isdead or playerData.metadata.inlaststand or false
end

function FRAMEWORKS.CLIENT.GetPlayerJob()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.job then
        return nil
    end

    local job = playerData.job
    local grade = job.grade or {}

    return {
        name = job.name,
        label = job.label,
        grade_name = grade.name,
        grade_label = grade.name,
        grade_salary = nil,
        grade = grade.level,
        isboss = job.isboss or false,
        onduty = job.onduty ~= nil and job.onduty or true,
        isGang = false
    }
end

function FRAMEWORKS.CLIENT.GetPlayerGang()
    local xPlayer = FRAMEWORKS.CLIENT.GetPlayerData()
    if not xPlayer or not xPlayer.gang then
        return nil
    end
    return xPlayer.gang.name
end

function FRAMEWORKS.CLIENT.GetIdentifier()
    local playerData = QBCore.Functions.GetPlayerData()
    return playerData and playerData.citizenid or nil
end

function FRAMEWORKS.CLIENT.GetPlayerName()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.charinfo then
        return "Unknown"
    end

    local firstname = playerData.charinfo.firstname or ""
    local lastname = playerData.charinfo.lastname or ""
    local full = (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")

    if full == "" then
        return firstname ~= "" and firstname or (lastname ~= "" and lastname or "Unknown")
    end

    return full
end

function FRAMEWORKS.CLIENT.GetBalance(account)
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.money then
        return 0
    end

    if account == 'money' then
        account = 'cash'
    end

    local balance = playerData.money[account] or 0
    return tonumber(balance) or 0
end
