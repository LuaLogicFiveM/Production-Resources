Config = {}
Config.Language = "en"
Config.Debug = false -- This enables debugging prints.
Config.RenderDistance = 100.0
Config.InteractDistance = 5.0
Config.UseTarget = true -- This enables the use of the target system when available.
Config.ImageDirectory = "nui://ox_inventory/web/images/"
Config.WeaponsAreItems = true -- This enables the use of weapons as items. If set to false, weapons will be treated as items and not as weapons.
Config.RandomDropCommand = "airdrop" -- Command to spawn a random drop. /airdrop <dropTemplate>

Config.FrameworkSettings = {
    dirtyMoney = "DEFAULT",
}

Config.IsPlayerDead = function()
    return exports['ak47_ambulancejob']:IsPlayerDead(cache.playerId) or exports['ak47_ambulancejob']:IsPlayerDown(cache.playerId)
end

Config.GiveKeys = function(vehicle, plate)
    Entity(vehicle).state.saveEntity = true
end

Config.Airdrops = {
    planeSpeed = 2.0, -- Speed of the plane.
    dropSpeed = 0.5, -- Speed of the airdrop package.
    skyHeight = 200.0, -- Height of the plane in the sky.
    announceScheduledDrops = true, -- This enables the announcement of scheduled drops.
    defaultUnlockTime = 60, -- Default time in seconds to unlock the airdrop container.
    defaultItemCaptureTime = 5, -- Default time to capture an item from the airdrop.
}

Config.Currency = {
    currency = "USD",
    countryCode = "en-US",
}

Config.CurrencyItems = {
    -- These are the items that will be used for images from your inventory.
    ["money"] = "money",
    ["dirty_money"] = "black_money",
}

Config.RandomDropZones = {
    -- Radius will affect the randomization of the drop zone around the coordinates. Set to 0.0 to set the drop zone to the exact coordinates.
    { coords = vector3(-1666.8334, -899.7947, 7.4796), radius = 50.0 },
    { coords = vector3(-1138.2551, -2.0392, 47.9821), radius = 50.0 },
    { coords = vector3(1369.0424, -649.6426, 72.5967), radius = 50.0 },
    { coords = vector3(-1182.7700, 1999.9226, 139.9793), radius = 50.0 },
    { coords = vector3(-688.9169, 2712.5376, 43.0909), radius = 50.0 },
    { coords = vector3(255.2160, 2031.3654, 125.4136), radius = 50.0 },
    { coords = vector3(466.2745, 2976.5947, 40.9611), radius = 50.0 },
    { coords = vector3(2473.0603, 3587.1338, 84.2647), radius = 50.0 },
    { coords = vector3(2616.0908, 4524.3184, 36.6859), radius = 50.0 },
    { coords = vector3(183.8240, 6821.5898, 25.4825), radius = 50.0 },
    { coords = vector3(-466.3978, -173.8800, 37.8887), radius = 50.0 },
    { coords = vector3(-1728.2072, -195.7474, 58.1760), radius = 50.0 },
    { coords = vector3(81.4691, -397.3310, 40.6912), radius = 50.0 },
    { coords = vector3(1366.8295, -738.6635, 67.1944), radius = 50.0 },
}

Config.RadiusBlip = {
    color = 1,
    alpha = 127,
}

Config.AirdropTemplates = {
    ["aidrop_weapons"] = {
        image =  "nui://pickle_airdrops/nui/images/crate.png", -- Image of the airdrop shown on the interact.
        label = "Airdrop - Weapons", -- Label of the airdrop.
        --cronSchedule = "0 0/5 * * * ?", -- Cron job to spawn the airdrop. This is in the format of "minute hour day month dayOfWeek". Example: "0 0/5 * * * ?" will spawn every 5 minutes.
        item = "airdrop_weapons", -- This is the item that will be used by players to spawn the airdrop at their position.
        radius = 50.0, --- The radius of the airdrop drop zone.
        spawnRadiusMultiplier = 0.5, -- 1.0 is to spawn objects to the fullest extent, 0.1 is to spawn objects in a small area in the center.
        dropBlipEnabled = true, -- This enables the drop blip on the map.
        radiusBlipEnabled = true, -- This enables the radius blip on the map.
        dropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop container.
        minidropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop containers that appear when the airdrop contains multiple containers.
        unlockTime = 60, -- Time in seconds to unlock the airdrop container. If set to 0, it will use the default unlock time in Config.Airdrops.
        items = { 
            -- If an item's capture time is not specified, it will use the default capture time in Config.Airdrops.
            -- If an item's itemType is not specified, it will interpret it as a item. Types: "item", "weapon", "money".
            -- The higher an item's chance, the more likely it is to spawn in the airdrop container. 
            {chance = 2, itemType = "item", name = "WEAPON_AUTOMATICPISTOL", count = 1}, -- Range is the randomization of how much of the item is spawned in the slot.
            {chance = 5, itemType = "item", name = "WEAPON_G41", count = 1},
            {chance = 5, itemType = "item", name = "WEAPON_G26SWITCH", count = 1},
            {chance = 5, itemType = "item", name = "WEAPON_PLR", count = 1},
            {chance = 5, itemType = "item", name = "WEAPON_DRACO", count = 1},
            {chance = 5, itemType = "item", name = "WEAPON_SCARSC", count = 1},
            {chance = 10, itemType = "item", name = "black_money", range = {1000, 5000}},
            {chance = 10, itemType = "item", name = "money", range = {1000, 5000}},
        },
        itemRange = {1, 3}, -- The range of items that can be spawned in the airdrop container.
    },
    ["airdrop_crafting"] = {
        image =  "nui://pickle_airdrops/nui/images/crate.png", -- Image of the airdrop shown on the interact.
        label = "Airdrop - Crafting", -- Label of the airdrop.
        --cronSchedule = "0 0/5 * * * ?", -- Cron job to spawn the airdrop. This is in the format of "minute hour day month dayOfWeek". Example: "0 0/5 * * * ?" will spawn every 5 minutes.
        item = "airdrop_crafting", -- This is the item that will be used by players to spawn the airdrop at their position.
        radius = 50.0, --- The radius of the airdrop drop zone.
        spawnRadiusMultiplier = 0.5, -- 1.0 is to spawn objects to the fullest extent, 0.1 is to spawn objects in a small area in the center.
        dropBlipEnabled = true, -- This enables the drop blip on the map.
        radiusBlipEnabled = true, -- This enables the radius blip on the map.
        dropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop container.
        minidropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop containers that appear when the airdrop contains multiple containers.
        unlockTime = 60, -- Time in seconds to unlock the airdrop container. If set to 0, it will use the default unlock time in Config.Airdrops.
        items = {
            {chance = 20, itemType = "item", name = "ls_copper_ingot", range = {5, 15}}, -- Range is the randomization of how much of the item is spawned in the slot.
            {chance = 20, itemType = "item", name = "ls_iron_ingot", range = {5, 15}},
            {chance = 20, itemType = "item", name = "ls_silver_ingot", range = {5, 15}},
            {chance = 20, itemType = "item", name = "ls_gold_ingot", range = {5, 15}},
            {chance = 20, itemType = "item", name = "scrap_metal", range = {50, 100}},
        },
        itemRange = {1, 3}, -- The range of items that can be spawned in the airdrop container.
    },
    ["airdrop_ammo"] = {
        image =  "nui://pickle_airdrops/nui/images/crate.png", -- Image of the airdrop shown on the interact.
        label = "Airdrop - Ammo", -- Label of the airdrop.
        --cronSchedule = "0 0/5 * * * ?", -- Cron job to spawn the airdrop. This is in the format of "minute hour day month dayOfWeek". Example: "0 0/5 * * * ?" will spawn every 5 minutes.
        item = "airdrop_ammo", -- This is the item that will be used by players to spawn the airdrop at their position.
        radius = 50.0, --- The radius of the airdrop drop zone.
        spawnRadiusMultiplier = 0.5, -- 1.0 is to spawn objects to the fullest extent, 0.1 is to spawn objects in a small area in the center.
        dropBlipEnabled = true, -- This enables the drop blip on the map.
        radiusBlipEnabled = true, -- This enables the radius blip on the map.
        dropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop container.
        minidropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop containers that appear when the airdrop contains multiple containers.
        unlockTime = 60, -- Time in seconds to unlock the airdrop container. If set to 0, it will use the default unlock time in Config.Airdrops.
        items = {
            {chance = 15, itemType = "item", name = "ammo-9", range = {200, 300}},
            {chance = 15, itemType = "item", name = "ammo-45", range = {200, 300}},
            {chance = 15, itemType = "item", name = "ammo-40", range = {200, 300}},
            {chance = 15, itemType = "item", name = "ammo-556", range = {150, 300}},
            {chance = 15, itemType = "item", name = "ammo-762", range = {100, 250}},
            {chance = 15, itemType = "item", name = "ammo-57", range = {100, 200}},
        },
        itemRange = {1, 3}, -- The range of items that can be spawned in the airdrop container.
    },
    ["airdrop_scamming"] = {
        image =  "nui://pickle_airdrops/nui/images/crate.png", -- Image of the airdrop shown on the interact.
        label = "Airdrop - Scamming", -- Label of the airdrop.
        --cronSchedule = "0 0/5 * * * ?", -- Cron job to spawn the airdrop. This is in the format of "minute hour day month dayOfWeek". Example: "0 0/5 * * * ?" will spawn every 5 minutes.
        item = "airdrop_scamming", -- This is the item that will be used by players to spawn the airdrop at their position.
        radius = 50.0, --- The radius of the airdrop drop zone.
        spawnRadiusMultiplier = 0.5, -- 1.0 is to spawn objects to the fullest extent, 0.1 is to spawn objects in a small area in the center.
        dropBlipEnabled = true, -- This enables the drop blip on the map.
        radiusBlipEnabled = true, -- This enables the radius blip on the map.
        dropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop container.
        minidropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop containers that appear when the airdrop contains multiple containers.
        unlockTime = 60, -- Time in seconds to unlock the airdrop container. If set to 0, it will use the default unlock time in Config.Airdrops.
        items = {
            {chance = 15, itemType = "item", name = "printer", count = 1},
            {chance = 15, itemType = "item", name = "msr", count = 1},
            {chance = 15, itemType = "item", name = "blank", range = {20, 30}},
            {chance = 15, itemType = "item", name = "laptop", count = 1},
            {chance = 15, itemType = "item", name = "simcard", range = {20, 30}},
            {chance = 15, itemType = "item", name = "burnerphone", count = 1},
        },
        itemRange = {1, 3}, -- The range of items that can be spawned in the airdrop container.
    },
    ["airdrop_item"] = {
        image =  "nui://pickle_airdrops/nui/images/crate.png", -- Image of the airdrop shown on the interact.
        label = "Airdrop - items", -- Label of the airdrop.
        --cronSchedule = "0 0/5 * * * ?", -- Cron job to spawn the airdrop. This is in the format of "minute hour day month dayOfWeek". Example: "0 0/5 * * * ?" will spawn every 5 minutes.
        item = "airdrop_items", -- This is the item that will be used by players to spawn the airdrop at their position.
        radius = 50.0, --- The radius of the airdrop drop zone.
        spawnRadiusMultiplier = 0.5, -- 1.0 is to spawn objects to the fullest extent, 0.1 is to spawn objects in a small area in the center.
        dropBlipEnabled = true, -- This enables the drop blip on the map.
        radiusBlipEnabled = true, -- This enables the radius blip on the map.
        dropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop container.
        minidropModel = `sm_prop_smug_crate_01a`, -- Model of the airdrop containers that appear when the airdrop contains multiple containers.
        unlockTime = 60, -- Time in seconds to unlock the airdrop container. If set to 0, it will use the default unlock time in Config.Airdrops.
        items = {
            {chance = 15, itemType = "item", name = "switch", range = {1, 5}},
            {chance = 15, itemType = "item", name = "percocet_pill", range = {5, 10}},
            {chance = 15, itemType = "item", name = "ecstasy_pill", range = {5, 10}},
            {chance = 15, itemType = "item", name = "hightimebrownies", range = {5, 10}},
            {chance = 15, itemType = "item", name = "blazebites", range = {5, 10}},
            {chance = 15, itemType = "item", name = "kushkrisps", range = {5, 10}},
            {chance = 15, itemType = "item", name = "chroniccrunchcookies", range = {5, 10}},
            {chance = 15, itemType = "item", name = "herbaldelightgummies", range = {5, 10}},
        },
        itemRange = {1, 3}, -- The range of items that can be spawned in the airdrop container.
    },
    --[[["aidrop_vehicles"] = {
        image =  "nui://pickle_airdrops/nui/images/crate.png", -- Image of the airdrop shown on the interact.
        label = "Airdrop - Vehicle", -- Label of the airdrop.
        --cronSchedule = "0 0/5 * * * ?", -- Cron job to spawn the airdrop. This is in the format of "minute hour day month dayOfWeek". Example: "0 0/5 * * * ?" will spawn every 5 minutes.
        dropType = "vehicle", -- This is the type of the airdrop. It can be "vehicle" or "container". If set to "vehicle", the airdrop will spawn a vehicle.
        item = "airdrop_vehicles", -- This is the item that will be used by players to spawn the airdrop at their position.
        radius = 50.0, --- The radius of the airdrop drop zone.
        spawnRadiusMultiplier = 0.5, -- 1.0 is to spawn objects to the fullest extent, 0.1 is to spawn objects in a small area in the center.
        dropBlipEnabled = true, -- This enables the drop blip on the map.
        radiusBlipEnabled = true, -- This enables the radius blip on the map.
        unlockTime = 60, -- Time in seconds to unlock the airdrop container. If set to 0, it will use the default unlock time in Config.Airdrops.
        vehicles = { 
            -- If an item's capture time is not specified, it will use the default capture time in Config.Airdrops.
            -- The higher an item's chance, the more likely it is to spawn in the airdrop container. 
            {chance = 2, label = "Mercedes GLS", model = "ikx3gls60021", captureTime = 60, image = "https://docs.fivem.net/vehicles/adder.webp"},
            {chance = 10, label = "Camaro Exorcist", model = "exorcist", image = "https://docs.fivem.net/vehicles/dominator.webp"},
            {chance = 15, label = "2025 Corvette", model = "rev_corvette25", image = "https://docs.fivem.net/vehicles/sanchez.webp"},
        },
    },]]
}

Config.RandomDrops = {
    announceScheduledDrops = true, -- This enables the announcement of scheduled drops.
    cronSchedule = "0 */3 * * * ?", -- Cron job to spawn the airdrop. Set to nil to disable.
    airdropTemplates = {
        {id = "airdrop_weapons", chance = 5, containers = 1}, -- This is the default airdrop template. The chance is the chance of the airdrop spawning.
        {id = "airdrop_crafting", chance = 10, containers = 1}, -- This is the default airdrop template. The chance is the chance of the airdrop spawning.
        {id = "airdrop_scamming", chance = 15, containers = 1}, -- This is the default airdrop template. The chance is the chance of the airdrop spawning.
        {id = "airdrop_ammo", chance = 20, containers = 1}, -- This is the default airdrop template. The chance is the chance of the airdrop spawning.
        {id = "airdrop_items", chance = 25, containers = 1}, -- This is the default airdrop template. The chance is the chance of the airdrop spawning.
        --{id = "airdrop_vehicles", chance = 10, containers = 1}, -- This is the default airdrop template. The chance is the chance of the airdrop spawning.
    }
}

Config.Blips = {
    ["airdrop_plane_blip"] = {
        sprite = 307,
        color = 0,
        scale = 1.0,
        display = 8,
    },
    ["airdrop_container_blip"] = {
        sprite = 478,
        color = 0,
        scale = 1.0,
        display = 8,
    },
}