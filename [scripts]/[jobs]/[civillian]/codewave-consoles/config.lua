--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### Console BUSINESSES ### ---

Config = {}
Config.Framework = 'ESX' -- 'ESX' or 'QBCore' OR 'QBOX' (case sensitive)
Config.InteractionType = 'ox_target' -- ox_target | 3dtext | qb-target


-- ONLY ONE OF THESE CAN BE TRUE, SO READ CAREFULLY.
Config.UseOxTargetForNpc = true -- Set to true to enable ox_target, false to use key press interaction
Config.UseQbTargetForNpc = false  -- Set to true to use qb-target for NPC interaction

Config.TimeToCraft = 15000
Config.DebugMode = false  -- Set to true to enable debug messages

-- "custom", "esx", "qbcore", "pNotify", "mythic_notify", "okokNotify", "default", "ox_lib"
Config.NotificationType = "ox_lib"

-- ONLY FOR NPC SALES.
Config.MinItemsToSell = 1 
Config.MaxItemsToSell = 3
-- Change the commands if you wish
Config.StopSellingCommand = 'stopsellingconsoles'
Config.StartSellingCommand = 'sellconsoles'
Config.ComputerBoxPropName = "gkms_prop_box" -- ### YOU MAY NEED TO CHANGE THIS PROP, HEAD TO PLEB MASTER & SEARCH FOR Computerbox AND USE ANOTHER PROP ###



Config.AC = {
    enabled = true,                  -- master toggle (false = completely off)
    strikes = 2,                     -- how many invalid calls before action
    dropPlayer = true,               -- if false, never DropPlayer (still logs/notifies if you want)
    dropMessage = "Anti-cheat: You have triggered the anti-cheat system, Discord.gg/insert_discord_link.",
}

Config.OnlyMales = false  -- Enable or disable the restriction to only allow male peds
Config.MalePedModels = {
    GetHashKey("mp_m_freemode_01"),  -- Male freemode character
}

Config.Jobs = {
    Enabled = false,
    AllowedJobs = { "mechanic", "doctor" } -- YOU MUST ADD YOUR OWN JOB ROLES FOR THIS (EG Computer_seller or whatever you want it to be)
}


Config.NPC = {
    Model = "a_m_m_soucent_03", -- Change to your desired NPC model
    Coords = vector3(1126.8661, -968.6973, 46.5868), -- Change to your desired NPC spawn location
    Heading = 276.0, -- Adjust the heading as needed
    BlipEnabled = true,  -- New option to enable/disable blip
    BlipSprite = 58,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 0.85,
    BlipColour = 67,
    BlipName = "[TechWorkz Consoles] - Store"
}


Config.XP = {
    Enabled = true,
    -- XP per successful sale:
    BasePerSale = math.random(10, 15),

    -- Optional: scale XP by money earned (e.g. +1 XP per $250)
    MoneyDivisor = 250, -- set nil/0 to disable

    -- Level formula:
    -- Required XP for next level = 250 + (level-1)*150 (example)
    BaseLevelXP = 250,
    PerLevelXP = 150,
    MaxLevel = 100
}

-- Important
Config.ReceiveJailBreakChance = 5 -- percent chance (0-100) (5 percent by default - meaning 1 in 20 exchanges will give the jailbreak item, you can adjust as needed)
Config.ReceiveJailBreakItem   = 'workz_usb'
Config.ReceiveJailBreakAmount = 1


-- Add anything you want here (For example if you want a new required item you can add it here for them to purchase!)
Config.Items = {
    { name = "TechWorkz Station", id = "techworkz_station", img = "image/techworkz_station.png", price = math.random(450, 500) },
    { name = "Vortex X Shell", id = "vortex_x_shell", img = "image/vortex_x_shell.png", price = math.random(25, 35) },
    { name = "Prodigy 5 Shell", id = "prodigy_5_shell", img = "image/prodigy_5_shell.png", price = math.random(25, 35) },
    { name = "Nova Deck Shell", id = "novadeck_shell", img = "image/novadeck_shell.png", price = math.random(10, 15) },
    { name = "Phantom Shell", id = "phantom_shell", img = "image/phantom_shell.png", price = math.random(10, 15) },

    { name = "LCD Screen", id = "lcd_screen", img = "image/lcd_screen.png", price = math.random(25, 50) },
    { name = "Console Motherboard", id = "console_motherboard", img = "image/console_motherboard.png", price = math.random(100, 125) },
    { name = "Power Unit", id = "power_unit", img = "image/power_unit.png", price = math.random(200, 225) },
    { name = "Cooling Kit", id = "cooling_kit", img = "image/cooling_kit.png", price = math.random(50, 75) },
    { name = "Storage Module", id = "storage_module", img = "image/storage_module.png", price = math.random(50, 75) },
    { name = "Disc Drive", id = "disc_drive", img = "image/disc_drive.png", price = math.random(50, 75) },
    { name = "Network Module", id = "network_module", img = "image/network_module.png", price = math.random(100, 125) },

    { name = "Vortex X Controller Parts", id = "vortex_x_controller_parts", img = "image/vortex_x_controller_parts.png", price = math.random(50, 75) },
    { name = "Prodigy 5 Controller Parts", id = "prodigy_5_controller_parts", img = "image/prodigy_5_controller_parts.png", price = math.random(50, 75) },
    { name = "Vortex X Battery", id = "vortex_x_battery", img = "image/vortex_x_battery.png", price = math.random(25, 50) },
    { name = "Prodigy 5 Battery", id = "prodigy_5_battery", img = "image/prodigy_5_battery.png", price = math.random(25, 50) }
}


Config.CraftingRecipes = {
    -- Consoles
    { name = "Vortex X", id = "vortex_x", img = "image/vortex_x.png",
      requiredItems = {
        { id = "vortex_x_shell", quantity = 1 },
        { id = "console_motherboard", quantity = 2 },
        { id = "power_unit", quantity = 1 },
        { id = "cooling_kit", quantity = 1 },
        { id = "storage_module", quantity = 1 },
        { id = "disc_drive", quantity = 1 },
        { id = "network_module", quantity = 1 },
      },
      yield = 1
    },

    { name = "Prodigy 5", id = "prodigy_5", img = "image/prodigy_5.png",
      requiredItems = {
        { id = "prodigy_5_shell", quantity = 1 },
        { id = "console_motherboard", quantity = 2 },
        { id = "power_unit", quantity = 1 },
        { id = "cooling_kit", quantity = 1 },
        { id = "storage_module", quantity = 1 },
        { id = "disc_drive", quantity = 1 },
        { id = "network_module", quantity = 1 },
      },
      yield = 1
    },

        { name = "Nova Deck", id = "novadeck", img = "image/novadeck.png",
      requiredItems = {
        { id = "novadeck_shell", quantity = 1 },
        { id = "console_motherboard", quantity = 2 },
        { id = "lcd_screen", quantity = 1 },
        { id = "storage_module", quantity = 1 },
        { id = "disc_drive", quantity = 1 },
        { id = "network_module", quantity = 1 },
      },
      yield = 1
    },

    { name = "Phantom", id = "phantom", img = "image/phantom.png",
      requiredItems = {
        { id = "phantom_shell", quantity = 1 },
        { id = "console_motherboard", quantity = 2 },
        { id = "lcd_screen", quantity = 1 },
        { id = "storage_module", quantity = 1 },
        { id = "disc_drive", quantity = 1 },
        { id = "network_module", quantity = 1 },
      },
      yield = 1
    },

    -- Controllers
    { name = "Vortex X Controller", id = "vortex_x_controller", img = "image/vortex_x_controller.png",
      requiredItems = {
        { id = "vortex_x_controller_parts", quantity = 1 },
        { id = "vortex_x_battery", quantity = 1 },
      },
      yield = 1
    },

    { name = "Prodigy 5 Controller", id = "prodigy_5_controller", img = "image/prodigy_5_controller.png",
      requiredItems = {
        { id = "prodigy_5_controller_parts", quantity = 1 },
        { id = "prodigy_5_battery", quantity = 1 },
      },
      yield = 1
    },
}

Config.JailBreak = {
    Coords = vector3(1132.5645, -965.1564, 42.0953), -- Replace with your desired coordinates
    Heading = 98.0, 
    Model = "A_M_Y_BusiCas_01", -- Replace with your desired NPC model
    BlipEnabled = true,
    BlipSprite = 280,
    BlipColour = 2,
    BlipName = "[TechWorkz Consoles] - Transfer NPC"
}


Config.JailBreakConsoles = {
    { name = "Vortex X JailBreak",           id = "vortex_x_jailbreak",           img = "image/vortex_x_jailbreak.png",           requiredItems = { { id = "vortex_x", quantity = 1 }, { id = "workz_usb", quantity = 1 } } },
    { name = "Phantom Jailbreak",           id = "phantom_jailbreak",           img = "image/phantom_jailbreak.png",           requiredItems = { { id = "phantom", quantity = 1 }, { id = "workz_usb", quantity = 1 } } },
    { name = "Prodigy 5 JailBreak",          id = "prodigy_5_jailbreak",          img = "image/prodigy_5_jailbreak.png",          requiredItems = { { id = "prodigy_5", quantity = 1 }, { id = "workz_usb", quantity = 1 } } },
    { name = "Nova Deck JailBreak",          id = "novadeck_jailbreak",          img = "image/novadeck_jailbreak.png",          requiredItems = { { id = "novadeck", quantity = 1 }, { id = "workz_usb", quantity = 1 } } },
}





Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True


Config.ComputerTableItem = 'techworkz_station' --- The table item
Config.PropItemName = 'gkms_prop_pctable' -- You can change this if you want (to basically any prop, make it make sense though!)

Config.RequiredItems = {
    { item = 'vortex_x', priceMin = 180, priceMax = 220 },
    { item = 'prodigy_5', priceMin = 180, priceMax = 220 },
    { item = 'prodigy_5_controller', priceMin = 180, priceMax = 220 },
    { item = 'vortex_x_controller', priceMin = 180, priceMax = 220 },
    { item = 'novadeck', priceMin = 180, priceMax = 220 },
    { item = 'phantom', priceMin = 180, priceMax = 220 },

    { item = 'vortex_x_jailbreak', priceMin = 180, priceMax = 220 },
    { item = 'phantom_jailbreak', priceMin = 180, priceMax = 220 },
    { item = 'novadeck_jailbreak', priceMin = 180, priceMax = 220 },  
    { item = 'prodigy_5_jailbreak',    priceMin = 180, priceMax = 220 }
}



Config.SaleModels = {
    -- Female civilians
    'a_f_y_business_01',
    'a_f_y_business_02',
    'a_f_y_hipster_01',
    'a_f_y_hipster_02',
    'a_f_y_smartcaspat_01',
    'a_f_y_tourist_01',
    'a_f_y_vinewood_01',

    -- Male civilians
    'a_m_y_business_01',
    'a_m_y_business_02',
    'a_m_y_hipster_01',
    'a_m_y_hipster_02',
    'a_m_y_smartcaspat_01',
    'a_m_y_tourist_01',
    'a_m_y_vinewood_01'
}