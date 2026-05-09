lib.locale()

Config = {}

Config.Debug = false
Config.LogWebhook = ""


Config.BoatModel = `dinghy`

Config.ChanceForAlert = 100

Config.ChanceForGuards = 100
Config.GuardsBoat = `dinghy5`
Config.BoatsCount = 2
Config.GuardsCount = 5 -- max 5

Config.Mission = {
    name = "sea_battle",
    timeout = 60,
    cooldown = 60,
    label = locale("SEABATTLE_MISSION_LABEL"),
    desc = locale("SEABATTLE_MISSION_DESC"),
    gpsRemoving = 300, -- seconds
    policeRequired = Config.Debug and 0 or 1,
    concurrentMissions = 1,
    minimalGroupSize = Config.Debug and 1 or 2,
    requiredItem = {
        name = "seabattle_start",
        count = 1
    }
}

Config.StartingNpc = {
    models = { `a_m_y_salton_01` },
    randomLocation = false,
    scenario = 'WORLD_HUMAN_AA_SMOKE',
    locations = {
        vec4(-48.0871, -2171.2671, 6.8117, 84.3380),
    }
}

Config.ContactNumber = "555-0100"

Config.MissionLoadout = {
    {
        name = "sb_boat_rope",
        count = 1,
    },
    {
        name = "weapon_pistol",
        count = 1,
        metaData = {
            scratchedSerial = true
        }
    },
    {
        name = "ammo_pistol",
        count = 10,
    }
}

Config.ExcludeLoadout = {
    ["phone"] = true,
    ["tablet"] = true,
    ["sim_card"] = true,
    ["radio"] = true,
    ["radio_shitty"] = true,
    ["radio_upgraded"] = true,
}

Config.GuardModels = {
    `a_m_m_og_boss_01`,
    `a_m_m_hillbilly_02`
}

Config.MissionLoot = {
    lootTableRolls = 6,
    lootTable = {
        COMMON = {
            { name = "metalscrap",     min = 3, max = 5 },
            { name = "plastic",        min = 2, max = 4 },
            { name = "rubber",         min = 2, max = 4 },
            { name = "glass",          min = 1, max = 3 },
            { name = "moneyband",      min = 1, max = 2 },
        },
        RARE = {
            { name = "warehouse_entry",  min = 1, max = 1 },
            { name = "iron",             min = 1, max = 3 },
            { name = "copper",           min = 1, max = 2 },
            { name = "electronickit",    min = 1, max = 2 },
            { name = "steel",            min = 1, max = 3 },
            { name = "repairkit",        min = 1, max = 1 },
            { name = "advancedlockpick", min = 1, max = 1 },
            { name = "cleaningkit",      min = 1, max = 1 },
            { name = "radio",            min = 1, max = 1 },
            { name = "copper",           min = 1, max = 3 },
            { name = "moneyband",        min = 2, max = 6 },
        },
        EPIC = {
            { name = "moneyband",    min = 5,  max = 10 },
            { name = "thermite",     min = 1,  max = 1 },
            { name = "drill",        min = 1,  max = 1 },
            { name = "diamond_ring", min = 1,  max = 1 },
            { name = "goldchain",    min = 1,  max = 1 },
            { name = "cryptostick",  min = 1,  max = 1 },
            { name = "trojan_usb",   min = 1,  max = 1 },
            { name = "armour",       min = 1,  max = 1 },
            { name = "binoculars",   min = 1,  max = 1 },
        },
        LEGENDARY = {
            { name = "moneyband", min = 12, max = 24 },
            { name = "goldbar",   min = 1,  max = 1 },
            { name = "rolex",     min = 1,  max = 1 },
            { name = "laptop",    min = 1,  max = 1 },
            { name = "diamond",   min = 1,  max = 1 },
            { name = "gold",      min = 1,  max = 1 },
        },
    },
    guaranteedRarities = {
        RARE = 2,
    }
}
Config.CrateLoot = {
    lootTableRolls = 10,
    lootTable = {
        COMMON = {
            { name = "metalscrap",     min = 3, max = 5 },
            { name = "lockpick",       min = 1, max = 3 },
            { name = "plastic",        min = 2, max = 5 },
            { name = "screwdriverset", min = 1, max = 2 },
            { name = "moneyband",      min = 1, max = 2 },
        },
        RARE = {
            { name = "warehouse_entry",  min = 1, max = 1 },
            { name = "iron",             min = 2, max = 3 },
            { name = "steel",            min = 1, max = 3 },
            { name = "electronickit",    min = 1, max = 2 },
            { name = "copper",           min = 1, max = 3 },
            { name = "advancedlockpick", min = 1, max = 1 },
            { name = "repairkit",        min = 1, max = 1 },
            { name = "cleaningkit",      min = 1, max = 1 },
            { name = "radio",            min = 1, max = 1 },
            { name = "moneyband",        min = 2, max = 6 },
        },
        EPIC = {
            { name = "moneyband",    min = 5, max = 10 },
            { name = "thermite",     min = 1, max = 2 },
            { name = "drill",        min = 1, max = 1 },
            { name = "goldchain",    min = 1, max = 1 },
            { name = "diamond_ring", min = 1, max = 1 },
            { name = "cryptostick",  min = 1, max = 1 },
            { name = "trojan_usb",   min = 1, max = 1 },
            { name = "binoculars",   min = 1, max = 1 },
            { name = "armour",       min = 1, max = 1 },
        },
        LEGENDARY = {
            { name = "moneyband", min = 12, max = 24 },
            { name = "goldbar",   min = 1,  max = 1 },
            { name = "rolex",     min = 1,  max = 1 },
            { name = "laptop",    min = 1,  max = 1 },
            { name = "gold",      min = 1,  max = 1 },
            { name = "diamond",   min = 1,  max = 1 },
        },
    },
    guaranteedRarities = {
        RARE = 2,
    }
}

Config.CrateModels = {
    closed = `pr_fcrate_weave`,
    open = `pr_fcrate_weave_open`,
}

-- Config.InfoNPCs = {
--     {
--         pos = vector4(-2687.2, 2510.0, -0.1, 156.1),
--         model = `s_m_y_dealer_01`,
--     },
-- }

-- Config.BoatNPCs = {
--     {
--         npcPos = vector4(-2697.9, 2557.3, -0.1, 154.6),
--         boatPos = vector4(-2693.0, 2574.7, -0.9, 62.1),
--         npcModel = `s_m_y_dealer_01`,
--     }
-- }

Config.Crates = {
    {
        cratePos = vector3(-4443.1, 2385.2, 0.0),
        buoyPos = vector3(-4445.4, 2382.0, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-3571.9, 3641.4, 0.0),
        buoyPos = vector3(-3573.9, 3642.4, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-2204.4, 5712.1, 0.0),
        buoyPos = vector3(-2206.9, 5713.4, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-3715.9, 1806.7, 0.0),
        buoyPos = vector3(-3717.9, 1807.7, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-2748.706, 6591.009, 0.0),
        buoyPos = vector3(-2744.853, 6580.144, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-1368.433, 7870.512, 0.0),
        buoyPos = vector3(-1360.376, 7868.865, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(1611.935, 8839.654, 0.0),
        buoyPos = vector3(1613.943, 8829.073, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(4633.204, 6454.588, 0.0),
        buoyPos = vector3(4630.989, 6447.511, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(6236.363, 3568.169, 0.0),
        buoyPos = vector3(6230.577, 3563.109, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(5376.050, -822.161, 0.0),
        buoyPos = vector3(5370.393, -826.334, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(2672.558, -3550.671, 0.0),
        buoyPos = vector3(2667.501, -3548.920, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(332.270, -5683.404, 0.0),
        buoyPos = vector3(327.131, -5684.219, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-2995.373, -5126.293, 0.0),
        buoyPos = vector3(-3002.479, -5124.634, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-4876.922, -1744.701, 0.0),
        buoyPos = vector3(-4872.525, -1742.268, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-5117.849, 603.555, 0.0),
        buoyPos = vector3(-5119.830, 608.710, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-6025.972, 2059.359, 0.0),
        buoyPos = vector3(-6023.063, 2062.949, -1.5),
        type = "buoy",
    },
    {
        cratePos = vector3(-6303.600, 4626.974, 0.0),
        buoyPos = vector3(-6297.131, 4629.892, -1.5),
        type = "buoy",
    },
}

Config.DeliveryNPCs = {
    {
        npc = {
            pos = vector4(-2772.6, 2543.7, 1.3, 20.3),
            model = `s_m_y_dealer_01`,
            boatPos = vector4(-2781.4, 2561.5, 0.3, 28.6),
        },
        cratePos = vector4(-2770.7, 2531.0, 1.6, 12.2),
        crateNpc = {
            pos = vector4(-2770.9, 2532.3, 1.6, 189.3),
            model = `s_m_y_dealer_01`,
        },
    },
    -- {
    --     npc = {
    --         pos = vector4(-3125.0, 3341.4, 0.4, 79.03),
    --         model = `s_m_y_dealer_01`,
    --         boatPos = vector4(-3145.8, 3342.6, 0.1, 86.5),
    --     },
    --     cratePos = vector4(-3097.2,3337.4,3.2,130.6),
    --     crateNpc = {
    --         pos = vector4(-3098.0, 3336.8, 3.0, 308.6),
    --         model = `s_m_y_dealer_01`,
    --     },
    -- },



    {
        npc = {
            pos = vector4(-1604.667969, 5256.791992, 1.075101, 305.534424),
            model = `s_m_y_dealer_01`,
            boatPos = vector4(-1602.118042, 5258.798828, 0.118299, 20.847713),
        },
        cratePos = vector4(-1607.175903, 5255.104980, 2.974099, 22.192686),
        crateNpc = {
            pos = vector4(-1607.817505, 5256.456543, 2.974099, 212.383026),
            model = `s_m_y_dealer_01`,
        },
    },
    {
        npc = {
            pos = vector4(3857.997803, 4459.342773, 0.822195, 94.796661),
            model = `s_m_y_dealer_01`,
            boatPos = vector4(3855.003906, 4454.570312, 0.119416, 265.274048),
        },
        cratePos = vector4(3866.522217, 4463.647461, 1.727216, 89.066360),
        crateNpc = {
            pos = vector4(3865.018555, 4463.562500, 1.723984, 268.690369),
            model = `s_m_y_dealer_01`,
        },
    },
    {
        npc = {
            pos = vector4(2843.851562, -621.991943, 0.262669, 267.491119),
            model = `s_m_y_dealer_01`,
            boatPos = vector4(2852.567871, -625.672180, 0.119501, 286.332336),
        },
        cratePos = vector4(2837.300049, -625.783325, 0.642653, 167.094437),
        crateNpc = {
            pos = vector4(2837.029297, -627.052734, 0.692311, 343.915680),
            model = `s_m_y_dealer_01`,
        },
    },
    {
        npc = {
            pos = vector4(11.304255, -2782.299561, 1.525950, 2.279524),
            model = `s_m_y_dealer_01`,
            boatPos = vector4(5.786190, -2786.832764, 0.165161, 176.815506),
        },
        cratePos = vector4(15.070208, -2785.160156, 1.525951, 178.352936),
        crateNpc = {
            pos = vector4(15.047312, -2786.442871, 1.525953, 8.155412),
            model = `s_m_y_dealer_01`,
        },
    },
    {
        npc = {
            pos = vector4(-3306.490723, 963.106445, 1.042222, 138.284241),
            model = `s_m_y_dealer_01`,
            boatPos = vector4(-3317.631592, 955.515991, 0.078649, 126.929672),
        },
        cratePos = vector4(-3301.661377, 960.007935, 1.074544, 217.373703),
        crateNpc = {
            pos = vector4(-3300.623779, 958.819824, 1.121074, 45.446701),
            model = `s_m_y_dealer_01`,
        },
    },
}
