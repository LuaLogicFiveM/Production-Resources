-- [[ Compatibility Initialization ]]

local ESX = exports["es_extended"]:getSharedObject()

-- [[ Functions ]]

local jobs = { ['sheriff'] = 0, ['sahp'] = 0 }

function verifyPlayerJob()
    local playerData = ESX.GetPlayerData()
    return playerData and jobs[playerData.job.name] or false
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
end, false)

-- Command to put the grabbed player into a vehicle
RegisterCommand(Config.CommandSystem.PutPlayer, function()
    if verifyPlayerJob() then
        putPlayerInVehicle(true)
    end
end, false)

-- Command to remove the player from a vehicle
RegisterCommand(Config.CommandSystem.RemovePlayer, function()
    if verifyPlayerJob() then
        fExitCar(true)
    end
end, false)

--if not Config.CommandSystem.Enabled and not Config.TargetSystem.UseOXTarget and not Config.TargetSystem.UseQBTarget and not Config.TargetSystem.CustomTarget then
    -- Key mapping for grab functionality if commands and target system are disabled
    RegisterKeyMapping(Config.CommandSystem.Grab, '[LEO] - Escort Ped', 'keyboard', 'V')
--end

-- [[ Events ]]

-- Event to grab or release a player.
-- @param targetId integer The server ID of the target player to grab.
RegisterNetEvent('r_grab:client:grabPlayer', function()
    if verifyPlayerJob() then
        grabPlayer(getPedInFront())
    end
    --ExecuteCommand('grab')
    --[[local closestPlayer = lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.0)
    grabPlayer(closestPlayer)]]
end)

-- Handles placing the grabbed player into a vehicle.
RegisterNetEvent('r_grab:client:putPlayerInVehicle', function()
    if verifyPlayerJob() then
        putPlayerInVehicle(true)
    end
end)

-- Handles removing a grabbed player from a vehicle.
RegisterNetEvent('r_grab:client:removePlayerFromVehicle', function()
    if verifyPlayerJob() then
        removePlayerFromVehicle(true)
    end
end)

RegisterNetEvent('r_grab:client:init', function()
    if verifyPlayerJob() then
        --local player = lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.0, false)
        --exports.ox_inventory:openInventory('player', player)
        exports.ox_inventory:openNearbyInventory()
    end
end)