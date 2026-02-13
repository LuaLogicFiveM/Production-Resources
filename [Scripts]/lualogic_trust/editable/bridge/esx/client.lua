if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports.es_extended:getSharedObject()

function GetJob()
    local playerData = ESX.GetPlayerData()
    return playerData and playerData.job and {name = playerData.job.name, grade = playerData.job.grade} or false
end

--[[RegisterNetEvent("esx:setJob") 
AddEventHandler('esx:setJob', function(job, lastJob)
    if not LocalPlayer.state.trustZone then return end
    zonePermissionReset(job)
end)]]

--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    lib.registerContext({
        id = 'Trust_Main_Menu',
        title = 'Vehicle Trust System',
        options = {
            {
                title = 'Owned Vehicles',
                description = 'This will list your owned vehicles',
                icon = 'warehouse',
                iconColor = 'green',
                arrow = true,
                onSelect = function()
                    OwnedVehiclesMenu()
                end,
            },
            {
                title = 'Trusted Vehicles',
                description = 'This will list your trusted vehicles',
                icon = 'key',
                iconColor = 'gold',
                arrow = true,
                onSelect = function()
                    TrustedVehiclesMenu()
                end,
            },
            {
                title = 'Transfer Data',
                description = 'This will transfer your old owned & trusted vehicles',
                icon = 'link',
                iconColor = 'lime',
                disabled = lib.callback.await('lualogic_trust:server:checkTransfer', false),
                onSelect = function()
                    ExecuteCommand('transferdata')
                end,
            },
        }
    })
end)]]