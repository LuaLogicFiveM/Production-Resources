lib.locale()

Config = {}

Config.Debug = false
Config.LogWebhook = ""

Config.Mission = {
    name = "aerial",
    timeout = 60,
    cooldown = 60,
    label = locale("AERIAL_MISSION_LABEL"),
    desc = locale("AERIAL_MISSION_DESC"),
    minimalGroupSize = Config.Debug and 0 or 4,
    maximalGroupSize = 8,
    policeRequired = Config.Debug and 0 or 2,
    concurrentMissions = 3,
    startItem = "ar_start_item",
    crateCount = 3,
    crateOpenTime = 5 * 60
}

Config.StartingNpc = {
    models = { `s_m_y_ammucity_01`, `s_m_y_blackops_02`, `s_m_y_prisoner_01` },
    -- Setting to true, on server start, random location will be choosen, other wise NPC will spawn in every location
    randomLocation = false,
    scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
    -- anim = {
    --     dict = 'anim@heists@box_carry@',
    --     name = 'idle',
    --     flag = 1,
    -- },
    locations = {
        vector4(-1323.3483, -1234.7263, 3.6234, 207.9791)
    }
}

Config.PlaneModel = `streamer216`
Config.ParachuteItem = "parachute"

Config.Testing = {
    enabled = true,
    command = "startaerial",
    restricted = "group.owner"
}

Config.ConvertPed = {
    locations = {
        {
            coords = vector4(2763.2, 1465.4, 15.7, 23.9),
            model = `weave_soldier_2`,
        },
        {
            coords = vector4(-1623.0, 3103.3, 20.3, 106.5),
            model = `apex_soldier_2`,
        },
        {
            coords = vector4(457.8, 5575.7, 780.2, 274.7),
            model = `mp_m_exarmy_01`,
        }
    },
    exchanges = {
        {
            requiredItem = {
                "ar_pendrive_b",
            },
            label = locale("EXCHANGE_ITEMS"),
            itemPoints = {
                pure_meth_brick_medium = 5,
                pure_meth_brick_perfect = 15,
                pure_meth_brick_good = 10,
                pure_meth_brick_dirty = 5,
                pure_meth_brick_death = 5,
                cocaine_mission_brick = 30,
                mdma_brick = 30,
            },
            requiredPoints = 90,
            rewardItem = "ar_start_item",
        },
        {
            requiredItem = "ar_pendrive_b",
            label = locale("EXCHANGE_ITEMS_2"),
            itemPoints = {
                pure_meth_brick_medium = 5,
                pure_meth_brick_perfect = 15,
                pure_meth_brick_good = 10,
                pure_meth_brick_dirty = 5,
                pure_meth_brick_death = 5,
                cocaine_mission_brick = 30,
                mdma_brick = 30,
            },
            requiredPoints = 60,
            rewardItem = "ar_start_item",
        },
        {
            rewardItem = "SNITCH",
            label = "BUY_SNITCH",
            requiredItem = "money",
            requiredCount = 5000,
            addAmount = true
        },
    },
    aditionalDialogOptions = {}
}


Config.Dispatch = {
    jobs = { 'gsp' },
    icon = "fas fa-parachute-box",
    code = "10-XX",
    title = locale("UNAUTHORIZED_AIR_DROPS"),
    description = locale("UNAUTHORIZED_AIR_DROPS_DESC"),
    blip = {
        icon = 496,
        size = 1.5,
        color = 25,
        duration = 10 * 60,
        flashing = true,
    },
}

Config.Locations = {
    {
        areaCoords = vector3(4464.097, -4499.894, 5.737),
        areaRadius = 400.0,
        caseCoords = {
            vec3(251.8, 6755.8, 15.1),
            vec3(299.3, 6794.0, 15.2),
            vec3(443.3, 6707.8, 7.4),
        },
        planeCoords = vec4(4464.097, -4499.894, 5.737, 114.093),
        planePed = {
            coords = vec4(4448.5, -4479.2, 3.3, 196.1),
            model = `s_m_m_pilot_01`,
        },
    },
    {
        areaCoords = vector3(-1713.6, 2613.7, 2.1),
        areaRadius = 500.0,
        caseCoords = {
            vec3(-1711.4, 2615.8, 1.9),
            vec3(-1686.4, 2654.3, 1.3),
            vec3(-1766.7, 2575.9, 2.4),
            vec3(-1924.7, 2546.3, 1.8),
            vec3(-1926.3, 2690.4, 2.2),
            vec3(-1698.3, 2561.1, 1.9),
            vec3(-1541.2, 2682.4, 2.6)
        },
        planeCoords = vec4(4464.097, -4499.894, 5.737, 114.093),
        planePed = {
            coords = vec4(4448.5, -4479.2, 3.3, 196.1),
            model = `s_m_m_pilot_01`,
        },
    },
    {
        areaCoords = vector3(1524.0, 1651.7, 109.9),
        areaRadius = 500.0,
        caseCoords = {
            vec3(1524.0, 1651.7, 109.9),
            vec3(1581.5, 1557.3, 104.6),
            vec3(1521.8, 1497.3, 106.2),
            vec3(1547.8, 1418.1, 105.2),
            vec3(1616.6, 1754.8, 105.7),
            vec3(1519.3, 1877.0, 105.1),
            vec3(1386.0, 1664.8, 97.6)
        },
        planeCoords = vec4(4464.097, -4499.894, 5.737, 114.093),
        planePed = {
            coords = vec4(4448.5, -4479.2, 3.3, 196.1),
            model = `s_m_m_pilot_01`,
        },
    },
}

Config.CrateLoot = {
    policeReward = 50000,
    lootTableRolls = 6,
    lootTable = {
        COMMON = {
            { name = "moneyband",      min = 15, max = 35 },
            { name = "lockpick",       min = 1,  max = 3 },
            { name = "phone",          min = 1,  max = 1 },
            { name = "metalscrap",     min = 3,  max = 5 },
            { name = "plastic",        min = 3,  max = 5 },
            { name = "rubber",         min = 2,  max = 4 },
            { name = "screwdriverset", min = 1,  max = 2 },
        },
        RARE = {
            { name = "electronickit",    min = 1,  max = 2 },
            { name = "advancedlockpick", min = 1,  max = 1 },
            { name = "moneyband",        min = 25, max = 40 },
            { name = "repairkit",        min = 1,  max = 1 },
            { name = "cleaningkit",      min = 1,  max = 1 },
            { name = "copper",           min = 1,  max = 3 },
            { name = "iron",             min = 1,  max = 3 },
            { name = "steel",            min = 1,  max = 3 },

        },
        EPIC = {
            { name = "cryptostick",   min = 1, max = 1 },
            { name = "trojan_usb",    min = 1, max = 1 },
            { name = "thermite",      min = 1, max = 2 },
            { name = "drill",         min = 1, max = 1 },
            { name = "diamond_ring",  min = 1, max = 2 },
        },
        LEGENDARY = {
            { name = "goldbar",  min = 1,  max = 1 },
            { name = "moneyband", min = 50, max = 80 },
            { name = "rolex",    min = 1,  max = 1 },
        },
    },
    guaranteedRarities = {
        COMMON = 1,
        RARE = 1,
    }
}

Config.Decrypt = {
    target = {
        coords = vec3(-1056.5, -232.5, 44.0),
        size = vec3(1.25, 1.0, 3.0),
        rotation = 297.5,
    },
    requiredItem = "ar_pendrive_a",
    rewardItem = "ar_pendrive_b",
    decryptTime = 2 * 60,
    minigame = {
        name = "keyBuilder",
        blockSize = 0.2,
        blockCount = 15,
        speed = 0.5,
        speedup = 0.025,
    }
}
