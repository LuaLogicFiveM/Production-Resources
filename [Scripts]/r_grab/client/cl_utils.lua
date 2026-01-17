-- [[ Compatibility Initialization ]]

local ESX = nil
local QBCore = nil

-- Initialize framework based on the configuration
if Config.Framework.ESX.enabled then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework.QB.enabled then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- [[ Functions ]]

-- Function to verify if the player's job matches the allowed jobs in the script configuration
function verifyPlayerJob()
    if Config.Framework.ESX.enabled then
        local playerData = ESX.GetPlayerData()

        for _, job in ipairs(Config.Framework.ESX.jobs) do
            if playerData.job and playerData.job.name == job then
                return true
            end
        end
    elseif Config.Framework.QB.enabled then
        local playerData = QBCore.Functions.GetPlayerData()

        for _, job in ipairs(Config.Framework.QB.jobs) do
            if playerData.job and playerData.job.name == job then
                return true
            end
        end
    else
        return true -- No framework is enabled, default to allowing access
    end

    return false -- Player's job is not authorized
end

-- Function to display a notification
function showHint(message)
    AddTextEntry('r_grab', message)
    BeginTextCommandDisplayHelp('r_grab')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

-- Function to disable certain player controls (e.g., while being dragged)
function disablePlayerControls()
    local disabledControls = {
        24, 25, 14, 15, 23, 37, 44, 140, 141, 142, 257, 263, 264
    }
    
    for _, id in ipairs(disabledControls) do
        DisableControlAction(0, id, true)
    end
end

-- [[ Commands ]]

-- Register a command to grab a player
RegisterCommand(Config.CommandSystem.Grab, function()
    if verifyPlayerJob() then
        grabPlayer(getPedInFront())
    end
end)

-- Command to put the grabbed player into a vehicle
RegisterCommand(Config.CommandSystem.PutPlayer, function()
    if verifyPlayerJob() then
        putPlayerInVehicle(true)
    end
end)

-- Command to remove the player from a vehicle
RegisterCommand(Config.CommandSystem.RemovePlayer, function()
    if verifyPlayerJob() then
        fExitCar(true)
    end
end)

if not Config.CommandSystem.Enabled and not Config.TargetSystem.UseOXTarget and not Config.TargetSystem.UseQBTarget and not Config.TargetSystem.CustomTarget then
    -- Key mapping for grab functionality if commands and target system are disabled
    RegisterKeyMapping(Config.CommandSystem.Grab, 'Grab Ped Key', 'keyboard', 'F2')
end

-- [[ Events ]]

-- Event to grab or release a player.
-- @param targetId integer The server ID of the target player to grab.
RegisterNetEvent('r_grab:client:grabPlayer', function()
    local pid = lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.0, false)
    if not pid then return end
    local serverId = GetPlayerServerId(pid)
    grabPlayer(serverId)
end)

-- Handles placing the grabbed player into a vehicle.
RegisterNetEvent('r_grab:client:putPlayerInVehicle', function()
    putPlayerInVehicle(true)
end)

-- Handles removing a grabbed player from a vehicle.
RegisterNetEvent('r_grab:client:removePlayerFromVehicle', function()
    removePlayerFromVehicle(true)
end)