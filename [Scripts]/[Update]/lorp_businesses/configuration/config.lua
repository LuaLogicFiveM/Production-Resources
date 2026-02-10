Config = {}

Config.checkForUpdates = false -- Check for updates?
Config.DrawMarkers = true -- draw markers when nearby?

Config.Shops = {
    ['pizza_pier'] = { -- Postal: 687
        label = 'Pizza This',
        stash = {
            string = '[E] - Access Inventory',
            coords = vec3(-1518.6053, -902.6624, 10.1822),
            range = 2.0
        },
        shop = {
            string = '[E] - Access Shop',
            coords = vec3(-1523.6642, -906.2525, 10.1822),
            range = 2.0
        }
    },
}