Config = {}
Config.Debug = false
Config.Target = false
Config.CustomTargetResource = "" -- if you have a custom target resource name set it here

Config.ResprayDoorEnabled = true
Config.ResprayDoor = {
    target = {
        label = "Toggle respray doors",
        icon = "fa-solid fa-spray-can",
    },
    native = {
        notify = "Press {E} to toggle the respray doors",
    }
}

Config.CarLiftsEnabled = true
Config.CarLifts = {
    target = {
        label = "Toggle car lift",
        icon = "fa-solid fa-car",
    },
    native = {
        notify = "Press {E} to toggle the car lift",
    }
}