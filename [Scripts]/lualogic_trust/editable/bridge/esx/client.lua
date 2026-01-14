if GetResourceState('es_extended') ~= 'started' then return end

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