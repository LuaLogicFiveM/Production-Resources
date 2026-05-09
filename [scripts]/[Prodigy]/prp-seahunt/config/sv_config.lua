Config = Config or {}

Config.Debug = false

Config.Mission = {
    name = "sea_hunt",
    label = locale("SEAHUNT_MISSION_LABEL"),
    description = locale("SEAHUNT_MISSION_DESCRIPTION"),
    minimalGroupSize = Config.Debug and 1 or 0,
    policeRequired = 0,
    timeout = 35,
    concurrentMissions = 1,
    cooldown = 1,
    requiredItem = {
        name = "sea_hunt_start",
        count = 1
    }
}

Config.StartingNpc = {
    models = { `a_m_y_salton_01` },
    randomLocation = false,
    scenario = 'WORLD_HUMAN_AA_SMOKE',
    locations = {
        vec4(803.2399, -493.3851, 29.6049, 6.4219),
    }
}

Config.DropTables = {
    ["car_low"] = {
        itemCount = 1,
        items = {
            { name = "WEAPON_GHOSTG30", count = 1, metaData = {registered = false} },
            { name = "ammo-9", count = 500, metaData = {} }
        },
    },
    ["car_medium"] = {
        itemCount = 1,
        items = {
            { name = "water", count = 2, metaData = {} }
        },
    },
    ["car_high"] = {
        itemCount = 1,
        items = {
            { name = "water", count = 2, metaData = {} }
        },
    },
}