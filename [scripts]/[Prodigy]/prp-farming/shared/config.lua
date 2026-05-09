Config = {}
Config.Debug = false

Config.Items = {
    smallPot = "farm_pot_small",
    mediumPot = "farm_pot_medium",
    largePot = "farm_pot_large",
    waterCan = "farm_water_can",
    fertilizer = "farm_fertilizer",

    lettuceSeeds = "seeds_lettuce",
    lettuceCrop = "farm_lettuce",

    tomatoSeeds = "seeds_tomato",
    tomatoCrop = "farm_tomato",

    strawberrySeeds = "seeds_strawberry",
    strawberryCrop = "farm_strawberry",

    grapeSeeds = "seeds_grape",
    grapeCrop = "farm_grape",

    cucumberSeeds = "seeds_cucumber",
    cucumberCrop = "farm_cucumber",

    eggplantSeeds = "seeds_eggplant",
    eggplantCrop = "farm_eggplant",

    onionSeeds = "seeds_onion",
    onionCrop = "farm_onion",

    potatoSeeds = "seeds_potato",
    potatoCrop = "farm_potato",

    watermelonSeeds = "seeds_watermelon",
    watermelonCrop = "farm_watermelon",

    bananaSeeds = "seeds_banana",
    bananaCrop = "farm_banana",

    appleSeeds = "seeds_apple",
    appleCrop = "farm_apple",

    wheatSeeds = "seeds_wheat",
    wheatCrop = "farm_wheat",

    soySeeds = "seeds_soy",
    soyCrop = "farm_soy",
}

-- do you want job starting via world NPC or manual trigger yourself?
Config.StartByNPC = true

Config.Peds = {
    main = {
        pos = vector4(2429.202148, 4973.687012, 44.950649, 51.305962),
        model = `a_m_m_farmer_01`,
    },
    vehicle = {
        pos = vector4(2419.552979, 4989.656250, 45.094460, 123.907272),
        model = `a_m_m_hillbilly_02`,
        vehSpawn = vector4(2409.484863, 4990.218262, 45.531601, 123.907272),
    }
}

Config.Job = {
    id = "Farming",
    name = locale("FARMING_JOB_LABEL"),
    maxMembers = 2,
    limit = 50,
    salary = 0
}

Config.FencesCooldown = {
    maxTasks = 3, -- max tasks to do in a row but if somebody does other task then count is removed by 1
    resetAfter = 3, -- reset cooldown after doing this many tasks
    timeCooldown = 15*60, -- in seconds
}

Config.StatusMultipliers = {
    ["green"] = 1.25,
    ["yellow"] = 1.05,
    ["red"] = 1.0,
}

Config.Health = {
    decreaseAfter = 30*60, -- in seconds
    defaultHealth = 100.0, -- percentage of default health
    maxHealth = 150.0, -- percentage of max health

    decreaseEvery = 2*60*60, -- decrease health every x seconds
    decreaseAmount = 10, -- decrease %

    increaseAmount = 2.5, -- increase % per done task
}

Config.Activities = {
    ["milking_cows"] = {
        label = locale("MILKING_COWS_ACTIVITY_LABEL"),
        requiredLevel = 2,
        affectedAreas = "milk_prod",
        maxPlayers = 4,
        taskCount = 5,
        changeSpotAfter = 4,
        avgTime = 300,
        salary = math.random(3500, 7500),

    },
    ["farm_cleaning"] = {
        label = locale("FARM_CLEANING_ACTIVITY_LABEL"),
        requiredLevel = 2,
        affectedAreas = "farm",
        maxPlayers = 4,
        taskCount = 5,
        subTasks = true,
        avgTime = 200,
        -- SALARY IS DEFINED IN config_spots.lua, Config.CleaningTasks
    },
    --[[["farm_crops"] = {
        label = locale("GATHER_CROPS_BLIP_LABEL"),
        requiredLevel = 2,
        affectedAreas = "fields",
        maxPlayers = 4,
        taskCount = 5,
        avgTime = 360,
        salary = 50,
    },]]
}

Config.Vehicles = {
    ["orchard"] = {
        spawnName = `rebel`,
        label = "Rebel",
    },
    ["milking_cows"] = {
        spawnName = `rebel`,
        label = "Rebel",
    },
    ["farm_cleaning"] = {
        spawnName = `rebel`,
        label = "Rebel",
    },
    ["farm_crops"] = {
        spawnName = `rebel`,
        label = "Rebel",
    },
}

Config.VehAttachCrops = {
    bone = 37,
    offsets = {
        { -0.38, -1.91, -0.375, 0, 0, -91 },
        { 0.355, -1.895, -0.37, 0, 0, 90 },
        { -0.27, -2.52, -0.38, 0, 0, 0 },
        { -0.51, -3.175, -0.365, 0, 0, 0 },
        { -0.005, -3.205, -0.355, 0, 0, -1.5 },
        { 0.26, -2.54, -0.36, 0, 0, 0 },
        { 0.475, -3.215, -0.36, 0.5, 0, -1.5 },
    },
    models = {
        ["lettuce"] = `prp_farming_box_lettuce`,
        ["watermelon"] = `prp_farming_box_watermelon`,
    }
}

Config.VehAttachMilk = {
    bone = 37,
    offsets = {
        { 0.35, -2.24, -0.495, 0, 0, 0 },
        { 0.02, -2.255, -0.495, 0, 0, 0 },
        { 0.19, -1.87, -0.495, 0, 0, 0 },
        { -0.195, -1.86, -0.495, 0, 0, 0 },
        { 0.545, -1.875, -0.495, 0, 0, 0 },
        { -0.56, -1.87, -0.495, 0, 0, 0 },
        { -0.32, -2.25, -0.495, 0, 0, 0 },
    },
}

Config.MilkDropOff = {
    coords = vector3(2433.98, 5011.18, 46.85),
    size = vector3(6.2, 1.0, 3.0),
    rotation = 135,
    debug = false -- show the zone in debug mode
}

Config.HoldingProps = {
    ["milk_bucket"] = {
        animDict = "rcmepsilonism8",
        anim = "bag_handler_idle_a",
        flag = 49,
        prop = `prop_bucket_02a`,
        bone = 57005,
        pos = vector3(0.58, 0, -0.02),
        rot = vector3(0, -86.5, 0),
    },
    ["weeds_bag"] = {
        animDict = "rcmepsilonism8",
        anim = "bag_handler_idle_a",
        flag = 49,
        prop = `prop_ld_rub_binbag_01`,
        bone = 57005,
        pos = vector3(0.46, 0.025, 0.035),
        rot = vector3(0, -95, 0),
    },
    ["lettuce"] = {
        animDict = "anim@heists@box_carry@",
        anim = "idle",
        flag = 49,
        prop = `prp_farming_box_lettuce`,
        bone = 57005,
        pos = vector3(0.31, -0.175, -0.23),
        rot = vector3(107, -11.5, -137.5),
    },
    ["watermelon"] = {
        animDict = "anim@heists@box_carry@",
        anim = "idle",
        flag = 49,
        prop = `prp_farming_box_watermelon`,
        bone = 57005,
        pos = vector3(0.29, 0.165, -0.205),
        rot = vector3(-99, -14, 33),
    },
}
