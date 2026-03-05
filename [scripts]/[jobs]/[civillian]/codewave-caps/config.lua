--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### CAPCITY SCRIPT ### ---

Config = {}
Config.Framework = 'ESX' -- 'ESX' or 'QBCore' (case sensitive)
Config.InteractionType = 'ox_target' -- ox_target | 3dtext
Config.UseOxTargetForNpc = true -- Set to true to enable ox_target, false to use key press interaction
Config.TimeToCraft = 15000 -- Time it takes to make a hat/cap
Config.DebugMode = false  -- Set to true to enable debug messages

---- ## QB OX INVENTORY (ENABLE THIS IF USING OX INVENTORY ON QB CORE, DO NOT ENABLE IF USING ESX)

-- Enable this if you are using **ox_inventory with QBCore**
Config.UseOxInventory = true


Config.CapBoxPropName = "prop_cap_01" -- ### YOU MAY NEED TO CHANGE THIS PROP, HEAD TO PLEB MASTER & SEARCH FOR Capbox AND USE ANOTHER PROP ###

-- Change the commands if you wish
Config.StopSellingCommand = 'stopsellingcaps'
Config.StartSellingCommand = 'sellcaps'


Config.OnlyMales = false  -- Enable or disable the restriction to only allow male peds (You can also just put female peds here)
Config.MalePedModels = {
    ``,  -- Male freemode character
}


Config.RequireJob = false -- Does the player need a JOB?

-- List of allowed jobs that can access the menu (only checked if RequireJob = true)
-- The jobs below are default jobs, if you wish to add your own jobs remove these & place your own in.
Config.AllowedJobs = {
    ["police"] = true,       -- Police job
    ["ambulance"] = true,    -- EMS/Paramedic job
    ["mechanic"] = true,     -- Mechanic job
    ["taxi"] = true          -- Taxi job
}


Config.NPC = {
    Model = "a_m_m_soucent_03", -- Change to your desired NPC model
    Coords = vector3(450.1989, -711.7684, 26.3584), -- Change to your desired NPC spawn location
    Heading = 271.0, -- Adjust the heading as needed
    BlipEnabled = true,  -- New option to enable/disable blip
    BlipSprite = 58,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 0.8,
    BlipColour = 67,
    BlipName = "Cap City"
}


-- Add anything you want here (For example if you want a new required item you can add it here for them to purchase!)
Config.Items = {
    { name = "Cotton Assortment", id = "cotton_assortment", img = "image/cotton_assortment.png", price = math.random(25, 35) }, -- You don't really need too touch anything apart from PRICE
    { name = "Sewing Kits - Caps", id = "sewing_kits_caps", img = "image/sewing_kits_caps.png", price = math.random(50, 70) },
    { name = "Cap City Client Phone", id = "cap_client_phone", img = "image/cap_client_phone.png", price = math.random(750, 1000) },
    { name = "Cap City Work Table", id = "capcity_table", img = "image/capcity_table.png", price = math.random(150, 200) }
}


Config.CraftingRecipes = {
    { name = "LA Black Cap", id = "la_black_cap", img = "image/la_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "LS Black Cap", id = "ls_black_cap", img = "image/ls_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 3 }, { id = "sewing_kits_caps", quantity = 2 } }, yield = 2 },
    { name = "Corkers Black Cap", id = "corkers_black_cap", img = "image/corkers_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Swingers Black Cap", id = "swingers_black_cap", img = "image/swingers_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Packers Black Cap", id = "packers_black_cap", img = "image/packers_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 3 }, { id = "sewing_kits_caps", quantity = 2 } }, yield = 2 },
    { name = "Bandits Black Cap", id = "bandits_black_cap", img = "image/bandits_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 3 }, { id = "sewing_kits_caps", quantity = 2 } }, yield = 2 },
    { name = "Red Cap", id = "red_cap", img = "image/red_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Black Cap", id = "black_cap", img = "image/black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 3 }, { id = "sewing_kits_caps", quantity = 2 } }, yield = 2 },
    { name = "Blue Cap", id = "blue_cap", img = "image/blue_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 3 }, { id = "sewing_kits_caps", quantity = 2 } }, yield = 2 },
    { name = "Orange Cap", id = "orange_cap", img = "image/orange_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Quality Black Cap", id = "quality_black_cap", img = "image/quality_black_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Quality Purple Cap", id = "quality_purple_hat", img = "image/quality_purple_hat.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Quality Blue Cap", id = "quality_blue_cap", img = "image/quality_blue_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 2 }, { id = "sewing_kits_caps", quantity = 1 } }, yield = 1 },
    { name = "Quality Green Cap", id = "quality_green_cap", img = "image/quality_green_cap.png", requiredItems = { { id = "cotton_assortment", quantity = 3 }, { id = "sewing_kits_caps", quantity = 2 } }, yield = 2 }
}


Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True


Config.CapTableItem = 'capcity_table' --- The table item (Don't touch this as it may break the script for some)
Config.PropItemName = 'prop_table_04' -- ## IMPORTANT, SOME GAME BUILDS?/SERVERS DON'T SUPPORT THIS PROP, CHANGE IT IF THE PROP DON'T SPAWN.



-- ONLY FOR NPC SALES.
Config.MinItemsToSell = 1 
Config.MaxItemsToSell = 3
-- NPC SALES USING COMMAND PRICES, Min/Max Values
Config.RequiredItems = {
    { item = 'ls_black_cap', priceMin = 10, priceMax = 15 },
    { item = 'la_black_cap', priceMin = 8, priceMax = 18 },
    { item = 'corkers_black_cap', priceMin = 12, priceMax = 17 },
    { item = 'swingers_black_cap', priceMin = 10, priceMax = 22 },
    { item = 'packers_black_cap', priceMin = 12, priceMax = 16 },
    { item = 'bandits_black_cap', priceMin = 10, priceMax = 20 },
    { item = 'red_cap', priceMin = 15, priceMax = 25 },
    { item = 'black_cap', priceMin = 18, priceMax = 20 },
    { item = 'blue_cap', priceMin = 5, priceMax = 20 },
    { item = 'orange_cap', priceMin = 12, priceMax = 30 },
    { item = 'quality_black_cap', priceMin = 20, priceMax = 30 },
    { item = 'quality_purple_hat', priceMin = 35, priceMax = 50 },
    { item = 'quality_blue_cap', priceMin = 15, priceMax = 20 },
    { item = 'quality_green_cap', priceMin = 18, priceMax = 25 }
}


--- ### DISCORD.GG/CODEWAVE ### ---

--### THIS IS IMPORTANT IF YOU WANT ITEMS TO WORK ###--
--## PROP ID NEEDS TO REMAIN 0!!! DRAWABLE ID IS THE CAP YOU WANT THE ITEM TO USE, EG IF YOU WANT HAT 102 TO BE EQUIP WITH LA_BLACK_CAP YOU NEED TO PUT DRAWABLE ID 102 ## --
--# If you do not understand this, Make a ticket & codewave will do it for you free # --
Config.capsSlots = {
    la_black_cap = {propId = 0, drawableId = 1, textureId = 0},
    ls_black_cap = {propId = 0, drawableId = 4, textureId = 0},
    corkers_black_cap = {propId = 0, drawableId = 224, textureId = 0},
    swingers_black_cap = {propId = 0, drawableId = 250, textureId = 0},
    packers_black_cap = {propId = 0, drawableId = 261, textureId = 0},
    bandits_black_cap = {propId = 0, drawableId = 271, textureId = 0},
    red_cap = {propId = 0, drawableId = 270, textureId = 0},
    black_cap = {propId = 0, drawableId = 260, textureId = 0},
    blue_cap = {propId = 0, drawableId = 50, textureId = 0},
    orange_cap = {propId = 0, drawableId = 35, textureId = 0},
    quality_black_cap = {propId = 0, drawableId = 100, textureId = 0},
    quality_purple_hat = {propId = 0, drawableId = 200, textureId = 0},
    quality_blue_cap = {propId = 0, drawableId = 211, textureId = 0},
    quality_green_cap = {propId = 0, drawableId = 199, textureId = 0},
}
-- ## This script automatically clears props after the item has been removed ## --