-- init locales
lib.locale()

Config = Config or {}

Config.Job = {}

---@type JobOptions
Config.Job.Lumberjack = {
    id = "Lumberjack",
    name = locale("LUMBERJACK_JOB_LABEL"),
    vehicleRent = 100,
    customRep = {
        { label = locale("RANK_LABEL", "1"),  value = 1000 },
        { label = locale("RANK_LABEL", "2"),  value = 2000 },
        { label = locale("RANK_LABEL", "3"),  value = 3000 },
        { label = locale("RANK_LABEL", "4"),  value = 4000 },
        { label = locale("RANK_LABEL", "5"),  value = 5000 },
        { label = locale("RANK_LABEL", "6"),  value = 6000 },
        { label = locale("RANK_LABEL", "7"),  value = 7000 },
        { label = locale("RANK_LABEL", "8"),  value = 8000 },
        { label = locale("RANK_LABEL", "9"),  value = 9000 },
        { label = locale("RANK_LABEL", "10"), value = 10000 },
    },
    doublePayChance = {
        [0] = 0,
        [1] = 0.05,
        [2] = 0.05,
        [3] = 0.1,
        [4] = 0.1,
        [5] = 0.15,
        [6] = 0.15,
        [7] = 0.2,
        [8] = 0.2,
        [9] = 0.25,
        [10] = 0.25,
    },
    speedIncrease = {
        [0] = 0,
        [1] = 0,
        [2] = 0.04,
        [3] = 0.04,
        [4] = 0.08,
        [5] = 0.08,
        [6] = 0.12,
        [7] = 0.12,
        [8] = 0.16,
        [9] = 0.16,
        [10] = 0.2,
    },
    lumberCenter = {
        pedCoords = vector4(-567.281738, 5253.177734, 69.466843, 74.070129),
        pedModel = "s_m_y_construct_01",
        vehSpawns = {
            vector4(-572.247314, 5243.109863, 70.444855, 65.541389)
        }
    },
    vehicleModel = 'bison',
    sawmill = {
        pedCoords = vector4(-560.6910, 5282.8120, 72.0508, 163.0500),
        pedModel = "s_m_y_construct_02",
        processTime = 12000,
    },
}

---@type table<string, { enabled?: boolean, sprite?: number, color?: number, scale?: number, radiusColor?: number }>
Config.Blips = {
    center  = { enabled = true, sprite = 85,  color = 2, scale = 1.2 },
    sawmill = { enabled = true, sprite = 365, color = 2, scale = 1.2 },
    zone    = { sprite = 836, color = 2, scale = 1.2, radiusColor = 2 },
}

-- Distance (in metres) at which the job NPCs render. Increase for faster streaming when players approach.
Config.PedRenderDistance = 75.0

-- Distance (in metres) at which the player can target/interact with the job NPCs.
Config.PedTargetDistance = 2.5

-- Max distance from the rental spawn point at which a rental truck can be returned.
Config.VehicleReturnDistance = 10.0

-- Toggle built-in features. Disable these if you want to replace them with your own script.
Config.Features = {
    sellShop = true, -- Lumber Center sell shop (planks)
    rentals  = true, -- Lumber Center vehicle rent/return
}

Config.RequiredRepLevel = {
    ["weapon_battleaxe"] = 0,
    ["weapon_chainsaw"] = 0,
}


Config.LumberjackWeapons = {
    [`WEAPON_BATTLEAXE`] = {
        damage = {
            ["oak"] = 10,
            ["cedar"] = 10,
            ["pine"] = 10,
            ["olive"] = 10,
            ["forest_tree"] = 10,
        },
        durabilityDrain = 1,
        debounce = 0
    },
    [`WEAPON_CHAINSAW`] = {
        damage = {
            ["oak"] = 1,
            ["cedar"] = 1,
            ["pine"] = 1,
            ["olive"] = 1,
            ["forest_tree"] = 1,
        },
        durabilityDrain = 0.0025,
        debounce = 300
    }
}

Config.Trees = {
    ["oak"] = {
        label = locale("LOW_SOFTWOOD_LABEL"),
        logLabel = locale("LOW_SOFTWOOD_LOG_LABEL"),
        weight = 10.0,
        health = 100,
        rarity = "COMMON",
        gameModel = `prop_tree_eng_oak_cr2_fit`,
        model = `prop_tree_eng_oak_cr2_log`,
        barkModel = `prop_tree_eng_oak_cr2_bark`,
        cooldown = 300,
        requiredRepLevel = 0,
        reputationReward = 50,
    },
    ["cedar"] = {
        label = locale("MEDIUM_SOFTWOOD_LABEL"),
        logLabel = locale("MEDIUM_SOFTWOOD_LOG_LABEL"),
        weight = 10.0,
        health = 100,
        rarity = "COMMON",
        gameModel = `prop_tree_eng_oak2_cr2_fit`,
        model = `prop_tree_eng_oak2_cr2_log`,
        barkModel = `prop_tree_eng_oak2_cr2_bark`,
        cooldown = 300,
        requiredRepLevel = 0,
        reputationReward = 50,
    },
    ["pine"] = {
        label = locale("HIGH_SOFTWOOD_LABEL"),
        logLabel = locale("HIGH_SOFTWOOD_LOG_LABEL"),
        weight = 10.0,
        health = 100,
        rarity = "COMMON",
        gameModel = `prop_tree_eng_oak3_cr2_fit`,
        model = `prop_tree_eng_oak3_cr2_log`,
        barkModel = `prop_tree_eng_oak3_cr2_bark`,
        cooldown = 300,
        requiredRepLevel = 0,
        reputationReward = 50,
    },
    ["olive"] = {
        label = locale("HARDWOOD_LABEL"),
        logLabel = locale("HARDWOOD_LOG_LABEL"),
        weight = 10.0,
        health = 100,
        rarity = "COMMON",
        gameModel = `prop_tree_eng_oak4_cr2_fit`,
        model = `prop_tree_eng_oak4_cr2_log`,
        barkModel = `prop_tree_eng_oak4_cr2_bark`,
        cooldown = 300,
        requiredRepLevel = 0,
        reputationReward = 50,
    },
    ["forest_tree"] = {
        label = locale("HARDWOOD_LABEL"),
        logLabel = locale("HARD_HARDWOOD_LOG_LABEL"),
        weight = 10.0,
        health = 100,
        rarity = "COMMON",
        gameModel = `prop_tree_eng_oak5_cr2_fit`,
        model = `prop_tree_eng_oak5_cr2_log`,
        barkModel = `prop_tree_eng_oak5_cr2_bark`,
        cooldown = 300,
        requiredRepLevel = 0,
        reputationReward = 50,
    },
}

ModelToTree = {}
for k, v in pairs(Config.Trees) do
    ModelToTree[v.gameModel] = k
end

Config.InventoryItems = {
    WEAPON_CHAINSAW = {
        label = locale("CHAINSAW_ITEM_LABEL"),
        rarity = "COMMON",
        weaponHash = `WEAPON_CHAINSAW`,
        weight = 5.0,
        model = `w_prp_chainsaw`,
        defaultMetaData = {
            durability = 100
        },
        type = 2,
        price = 100,
        noSerial = true,
        stackable = false,
    },
    oak_plank = {
        label = locale("OAK_PLANK_LABEL"),
        rarity = "UNCOMMON",
        stackable = 50,
        weight = 0.1,
        model = `pr_fp_oakplank`,
        sellPrice = 5,
    },
    cedar_plank = {
        label = locale("CEDAR_PLANK_LABEL"),
        rarity = "UNCOMMON",
        stackable = 50,
        weight = 0.1,
        model = `pr_fp_cedarplank`,
        sellPrice = 7,
    },
    pine_plank = {
        label = locale("PINE_PLANK_LABEL"),
        rarity = "RARE",
        stackable = 50,
        weight = 0.1,
        model = `pr_fp_pineplank`,
        sellPrice = 7,
    },
    olive_plank = {
        label = locale("OLIVE_PLANK_LABEL"),
        rarity = "RARE",
        stackable = 50,
        weight = 0.1,
        model = `pr_fp_oliveplank`,
        sellPrice = 7,
    },
    forest_tree_plank = {
        label = locale("FOREST_TREE_PLANK_ITEM_LABEL"),
        rarity = "EPIC",
        stackable = 50,
        weight = 0.1,
        model = `pr_fp_forestplank`,
        sellPrice = 7,
    },
}

Config.AttachOffsets = {
    [`lumber`] = {
        ["log_1"] = {
            offset = vector3(-0.8, -1.8, 0.6),
            rot = vector3(0.0, 0.0, 0.0),
            bone = 0,
        },
        ["log_2"] = {
            offset = vector3(0.1, -1.8, 0.6),
            rot = vector3(0.0, 0.0, 0.0),
            bone = 0,
        },
        ["log_3"] = {
            offset = vector3(1.0, -1.8, 0.6),
            rot = vector3(0.0, 0.0, 0.0),
            bone = 0,
        },
        ["log_4"] = {
            offset = vector3(-0.3, -1.8, 1.35),
            rot = vector3(0.0, 0.0, 0.0),
            bone = 0,
        },
        ["log_5"] = {
            offset = vector3(0.5, -1.8, 1.35),
            rot = vector3(0.0, 0.0, 0.0),
            bone = 0,
        },
    },
}

for k, v in pairs(Config.Trees) do
    Config.InventoryItems[("%s_log"):format(k)] = {
        label = v.logLabel,
        rarity = v.rarity,
        weight = v.weight,
        price = v.price,
        model = v.model,
        animation = {
            dictionary = "reck@jobs@carrylog",
            animation = "carrylog",
            prop = {
                hash = v.model,
                bone = 57005,
                position = vector3(0.115, -0.275, -0.01),
                rotation = vector3(19.0, 0.0, 17.5),
            },

            disableEnteringVehicle = true
        }
    }
    Config.InventoryItems[k] = v
end

Config.WhitelistedVehModels = {
    [`lumber`] = 6,
    [`kalahari`] = 6,
    [`bison`] = 6,
    [`bison2`] = 6,
    [`bison3`] = 6,
    [`bobcatxl`] = 6,
    [`everon`] = 6,
    [`sandking`] = 6,
    [`sandking2`] = 6,
    [`onx_sandking`] = 6,
    [`onx_sandking2`] = 6,
    [`onx_sandking3`] = 6,
    [`onx_sandking4`] = 6,
    [`onx_sandking5`] = 6,
    [`onx_sandking6`] = 6,
    [`rebel`] = 6,
    [`rebel2`] = 6,
    [`caracara2`] = 6,
    [`contender`] = 6,
    [`yosemite`] = 6,
    [`yosemite2`] = 6,
    [`yosemite3`] = 6,
    [`yosemite1500`] = 6,
    [`guardian`] = 6,
    [`sadler`] = 6,
    [`sandstorm`] = 6,
    [`sandstormxl`] = 6,
    [`nsandstorm`] = 6,
    [`nsandstorm2`] = 6,
    [`dloader`] = 6,
    [`hellenstorm`] = 6,
    [`l35`] = 6,
    [`squaddie`] = 6,
    [`caracaran`] = 6,
    [`kamacho`] = 6,
    [`dubsta3`] = 6,
    [`duneloader`] = 6,
    [`bodhi2`] = 6,
    [`firebolt`] = 6,
    [`boor`] = 6,
    [`patriot3`] = 6,
    [`riata`] = 6,
    [`gblod4`] = 6,
    [`warrener2`] = 6,
    [`tfbison`] = 6,
    [`tfbison2`] = 6,
    [`tfbison3`] = 6,
    [`tfbison4`] = 6,
    [`gbbisonstx`] = 6, 
    [`gbbisonhf`] = 6,
    [`gbmojave`] = 6,
}

Config.TreeZones = {
    {
        coords = vector3(309.5211, 4306.257, 45.33699),
        renderDist = 250.0,
        trees = {
            { c = vector3(309.5211, 4306.257, 45.33699), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(292.864, 4315.905, 45.33633), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(294.905, 4298.198, 43.75401), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(325.4183, 4312.785, 46.40088), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(321.8138, 4297.5, 45.06376), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(310.735, 4282.585, 42.98911), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(329.1046, 4283.616, 41.88378), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(344.4193, 4301.153, 44.24271), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(341.2435, 4318.232, 46.75657), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(312.8772, 4324.288, 47.29768), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(297.621, 4335.603, 47.84205), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(270.6646, 4313.105, 43.96828), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(291.1911, 4277.586, 40.84402), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(331.908, 4332.083, 48.20864), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(316.2792, 4351.671, 49.55358), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(277.329, 4331.497, 45.99826), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(299.2802, 4364.973, 49.32304), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(366.3701, 4312.656, 43.99834), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
            { c = vector3(281.4245, 4347.277, 47.12092), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak_cr2_fit` },
        },
    },
    {
        coords = vector3(493.4173, 790.0287, 203.0496),
        renderDist = 250.0,
        trees = {
            { c = vector3(493.4173, 790.0287, 203.0496), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(492.7446, 809.5849, 202.0589), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(487.4243, 837.326, 198.7027), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(466.7128, 831.7816, 197.4248), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(467.7013, 814.3441, 197.9836), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(474.9473, 788.1735, 198.8999), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(508.8362, 791.9612, 205.9324), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(457.1702, 771.0933, 193.9288), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(446.541, 807.5396, 195.5818), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(445.3141, 828.6734, 195.4398), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(433.3553, 773.4304, 190.3789), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(471.3029, 766.1599, 197.2791), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(496.1829, 770.4042, 203.0368), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(507.1385, 824.1061, 202.2878), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(527.4384, 802.608, 201.9042), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(438.2796, 757.1021, 191.5998), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(455.2405, 792.7987, 195.532), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
            { c = vector3(410.8195, 769.2756, 187.868), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak2_cr2_fit` },
        }
    },
    -- {
    --     coords = vector3(121.4604, 6755.575, 30.92246),
    --     renderDist = 250.0,
    --     trees = {
    --         { c = vector3(121.4604, 6755.575, 30.92246), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(139.7727, 6745.823, 33.53043), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(126.3018, 6728.467, 37.70397), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(142.4655, 6722.343, 38.22922), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(116.4881, 6705.529, 38.84382), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(110.6413, 6720.793, 40.28886), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(107.2035, 6758.042, 32.43774), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(82.22047, 6736.583, 38.60623), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(82.93019, 6715.735, 38.83038), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(131.4809, 6708.884, 39.5322), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(86.34399, 6698.207, 37.88227), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(97.07359, 6710.877, 40.17728), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(98.58212, 6737.244, 38.66926), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(114.5025, 6740.006, 37.05522), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(86.5751, 6754.544, 35.89518), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(66.14718, 6725.169, 36.3382), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(53.98355, 6708.324, 35.94373), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --         { c = vector3(105.5909, 6690.047, 37.60195), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak3_cr2_fit` },
    --     }
    -- },
    {
        coords = vector3(1174.539, 1961.552, 63.00645),
        renderDist = 250.0,
        trees = {
            { c = vector3(1174.539, 1961.552, 63.00645), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1159.266, 1976.535, 61.40048), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1152.555, 1954.053, 61.15149), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1177.041, 1981.666, 61.87784), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1198.869, 1963.253, 65.89328), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1166.365, 1941.587, 64.7366), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1141.838, 1969.301, 59.87572), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1160.236, 1994.29, 59.8681), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1142.999, 1988.889, 59.53981), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1146.406, 2006.331, 58.88994), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1187.75, 1945.065, 67.36911), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1196.702, 1979.277, 65.28129), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1190.194, 1995.781, 63.40611), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1127.329, 2000.976, 58.01178), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1125.033, 1978.353, 58.49712), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1126.683, 1957.983, 58.64357), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1147.687, 1929.656, 63.65696), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
            { c = vector3(1180.35, 1924.948, 68.78635), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak4_cr2_fit` },
        }
    },
    {
        coords = vector3(3317.633, 5040.275, 21.14013),
        renderDist = 250.0,
        trees = {
            { c = vector3(3317.633, 5040.275, 21.14013), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3332.597, 5030.116, 20.50227), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3297.258, 5043.197, 21.81569), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3335.373, 5045.189, 18.85522), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3309.04, 5057.767, 21.10842), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3285.138, 5030.577, 21.99535), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3302.988, 5028.942, 22.30966), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3318.756, 5022.604, 22.80627), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3324.036, 5053.296, 18.41592), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3345.895, 5034.354, 18.89554), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3350.04, 5015.556, 20.11244), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3331.317, 5014.921, 20.32474), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3342.148, 4998.183, 21.51871), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3324.704, 4998.632, 23.62709), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3306.792, 5006.836, 23.21056), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3290.794, 5014.762, 22.58517), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3275.046, 5043.783, 21.42083), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
            { c = vector3(3284.922, 5061.654, 21.90726), q = vector4(0, 0, 0, 1), m = `prop_tree_eng_oak5_cr2_fit` },
        }
    },
}

for k, v in pairs(Config.TreeZones) do
    for i, tree in pairs(v.trees) do
        tree.treeName = ModelToTree[tree.m]
        tree.treeId = i
        tree.zone = k
        tree.health = Config.Trees[tree.treeName].health
    end
end