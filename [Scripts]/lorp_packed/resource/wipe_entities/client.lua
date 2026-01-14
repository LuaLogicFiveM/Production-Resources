RegisterNetEvent('lualogic_wipes:client:requestManager', function(wipes)
    lib.registerContext({
        id = 'wipes_manager',
        title = 'Wipes Manager',
        options = {
            {
                title = 'Vehicle Wipe',
                description = 'Last Ran: '..GlobalState.VehiclesWipedLast..' | Vehicles Wiped: '..GlobalState.VehiclesWiped,
                icon = 'car',
                iconColour = 'yellow',
                onSelect = function()
                    ExecuteCommand('wipes 1')
                end,
            },
            {
                title = 'Object Wipe',
                description = 'Last Ran: '..GlobalState.ObjectsWipedLast..' | Vehicles Wiped: '..GlobalState.ObjectsWiped,
                icon = 'box',
                iconColour = 'yellow',
                onSelect = function()
                    ExecuteCommand('wipes 2')
                end,
            },
            {
                title = 'Ped Wipe',
                description = 'Last Ran: '..GlobalState.PedsWipedLast..' | Vehicles Wiped: '..GlobalState.PedsWiped,
                icon = 'person',
                iconColour = 'yellow',
                onSelect = function()
                    ExecuteCommand('wipes 3')
                end,
            },
        }
    })

    lib.showContext('wipes_manager')
end)