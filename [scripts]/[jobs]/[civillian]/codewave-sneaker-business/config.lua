--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### SNEAKER BUSINESSES ### ---

Config = {}
Config.Framework = 'ESX' -- 'ESX' or 'QBCore' (case sensitive)
Config.InteractionType = 'ox_target' -- ox_target | 3dtext | qb-target


-- ONLY ONE OF THESE CAN BE TRUE, SO READ CAREFULLY.
Config.UseOxTargetForNpc = true -- Set to true to enable ox_target, false to use key press interaction
Config.UseQbTargetForNpc = false  -- Set to true to use qb-target for NPC interaction

Config.TimeToCraft = 15000
Config.DebugMode = false  -- Set to true to enable debug messages

-- "custom", "esx", "qbcore", "pNotify", "mythic_notify", "okokNotify", "default", "ox_lib"
Config.NotificationType = "ox_lib"

Config.ShoeBoxPropName = "v_res_fa_shoebox2" -- ### YOU MAY NEED TO CHANGE THIS PROP, HEAD TO PLEB MASTER & SEARCH FOR shoebox AND USE ANOTHER PROP ###

-- ONLY FOR NPC SALES.
Config.MinItemsToSell = 1
Config.MaxItemsToSell = 3
-- Change the commands if you wish
Config.StopSellingCommand = 'stopsellingshoes'
Config.StartSellingCommand = 'sellshoes'


Config.OnlyMales = false  -- Enable or disable the restriction to only allow male peds
Config.MalePedModels = {
    GetHashKey("mp_m_freemode_01"),  -- Male freemode character
    GetHashKey("some_other_male_ped_model")  -- Add other male ped models here
}

-- 12/07/2024 update
Config.Jobs = {
    Enabled = false,
    AllowedJobs = { "mechanic", "doctor" } -- YOU MUST ADD YOUR OWN JOB ROLES FOR THIS (EG shoe_seller or whatever you want it to be)
}


Config.NPC = {
    Model = "a_m_m_soucent_03", -- Change to your desired NPC model
    Coords = vector3(26.7491, -169.0047, 54.5266), -- Change to your desired NPC spawn location
    Heading = 341.0, -- Adjust the heading as needed
    BlipEnabled = true,  -- New option to enable/disable blip
    BlipSprite = 58,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 0.8,
    BlipColour = 67,
    BlipName = "[Shoe Job] - Sole Street"
}


-- Add anything you want here (For example if you want a new required item you can add it here for them to purchase!)
Config.Items = {
    { name = "Assortment Of leather materials", id = "leather_materials", img = "image/leather_materials.png", price = math.random(100, 150) }, -- You don't really need too touch anything apart from PRICE
    { name = "Shoe foam", id = "shoe_foam", img = "image/shoe_foam.png", price = math.random(50, 75) },
    { name = "Cloth Materials", id = "clothe_materials", img = "image/cloth_materials.png", price = math.random(50, 100) },
    { name = "Work Station", id = "work_station", img = "image/work_station.png", price = math.random(250, 500) },
    { name = "Work Phone", id = "shoe_phone", img = "image/shoe_phone.png", price = math.random(750, 1000) }
}



Config.CraftingRecipes = {
    { name = "Sky Gliders Plus", id = "sky_gliders_plus", img = "image/sky_gliders_plus.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Breeze Bangs", id = "breeze_bangs", img = "image/breeze_bangs.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Tiger Mediums", id = "tiger_mediums", img = "image/tiger_mediums.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Galaxy X", id = "galaxy_x", img = "image/galaxy_x.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 2 } }, yield = 1 },
    { name = "Sky Walkers", id = "sky_walkers", img = "image/sky_walkers.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Sky Pilots", id = "sky_pilots", img = "image/sky_pilots.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Sky Flyers", id = "sky_flyers", img = "image/sky_flyers.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Sky Gliders", id = "sky_gliders", img = "image/sky_gliders.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Fast Runners", id = "fastrunner_2000", img = "image/fastrunner_2000.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Speedster 300", id = "speedster_300", img = "image/speedster_300.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 1 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Runner Prime", id = "runner_prime", img = "image/runner_prime.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Breeze 95s", id = "breeze_95s", img = "image/breeze_95s.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Breeze 100s", id = "breeze_100s", img = "image/breeze_100s.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
    { name = "Breeze 90s", id = "breeze_90s", img = "image/breeze_90s.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Sky Walkers Red", id = "sky_walkers_red", img = "image/sky_walkers_red.png", requiredItems = { { id = "leather_materials", quantity = 2 }, { id = "shoe_foam", quantity = 3 }, { id = "clothe_materials", quantity = 2 } }, yield = 2 },
    { name = "Shadow Yellows", id = "shadow_yellows", img = "image/shadow_yellows.png", requiredItems = { { id = "leather_materials", quantity = 1 }, { id = "shoe_foam", quantity = 2 }, { id = "clothe_materials", quantity = 1 } }, yield = 1 },
}


Config.TransferNPC = {
    Coords = vector3(101.5902, -222.4904, 53.6352), -- Replace with your desired coordinates
    Heading = 69.0, 
    Model = "a_m_y_eastsa_02", -- Replace with your desired NPC model
    BlipEnabled = true,
    BlipSprite = 280,
    BlipColour = 2,
    BlipName = "[Shoe Job] - Transfer NPC"
}


Config.AuthTransfers = {
    { name = "Breeze 90s",           id = "breeze_90s_verified",           img = "image/breeze_90s_verified.png",           requiredItems = { { id = "breeze_90s",           quantity = 1 } } },
    { name = "Breeze 95s",           id = "breeze_95s_verified",           img = "image/breeze_95s_verified.png",           requiredItems = { { id = "breeze_95s",           quantity = 1 } } },
    { name = "Breeze 100s",          id = "breeze_100s_verified",          img = "image/breeze_100s_verified.png",          requiredItems = { { id = "breeze_100s",          quantity = 1 } } },
    { name = "Breeze Bangs",         id = "breeze_bangs_verified",         img = "image/breeze_bangs_verified.png",         requiredItems = { { id = "breeze_bangs",         quantity = 1 } } },
    { name = "Fastrunner 2000",      id = "fastrunner_2000_verified",      img = "image/fastrunner_2000_verified.png",      requiredItems = { { id = "fastrunner_2000",      quantity = 1 } } },
    { name = "Galaxy X",             id = "galaxy_x_verified",             img = "image/galaxy_x_verified.png",             requiredItems = { { id = "galaxy_x",             quantity = 1 } } },
    { name = "Runner Prime",         id = "runner_prime_verified",         img = "image/runner_prime_verified.png",         requiredItems = { { id = "runner_prime",         quantity = 1 } } },
    { name = "Shadow Yellows",       id = "shadow_yellows_verified",       img = "image/shadow_yellows_verified.png",       requiredItems = { { id = "shadow_yellows",       quantity = 1 } } },
    { name = "Sky Flyers",           id = "sky_flyers_verified",           img = "image/sky_flyers_verified.png",           requiredItems = { { id = "sky_flyers",           quantity = 1 } } },
    { name = "Sky Gliders Plus",     id = "sky_gliders_plus_verified",     img = "image/sky_gliders_plus_verified.png",     requiredItems = { { id = "sky_gliders_plus",     quantity = 1 } } },
    { name = "Sky Gliders",          id = "sky_gliders_verified",          img = "image/sky_gliders_verified.png",          requiredItems = { { id = "sky_gliders",          quantity = 1 } } },
    { name = "Sky Pilots",           id = "sky_pilots_verified",           img = "image/sky_pilots_verified.png",           requiredItems = { { id = "sky_pilots",           quantity = 1 } } },
    { name = "Sky Walkers Red",      id = "sky_walkers_red_verified",      img = "image/sky_walkers_red_verified.png",      requiredItems = { { id = "sky_walkers_red",      quantity = 1 } } },
    { name = "Sky Walkers",          id = "sky_walkers_verified",          img = "image/sky_walkers_verified.png",          requiredItems = { { id = "sky_walkers",          quantity = 1 } } },
    { name = "Speedster 300",        id = "speedster_300_verified",        img = "image/speedster_300_verified.png",        requiredItems = { { id = "speedster_300",        quantity = 1 } } },
    { name = "Tiger Mediums",        id = "tiger_mediums_verified",        img = "image/tiger_mediums_verified.png",        requiredItems = { { id = "tiger_mediums",        quantity = 1 } } },
}





Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True


Config.ShoeTableItem = 'work_station' --- The table item
Config.PropItemName = 'prop_table_03' -- You can change this if you want (to basically any prop, make it make sense though!)

Config.RequiredItems = {
    { item = 'sky_gliders_plus', priceMin = 18, priceMax = 28 },
    { item = 'breeze_bangs', priceMin = 15, priceMax = 25 },
    { item = 'tiger_mediums', priceMin = 29, priceMax = 42 },
    { item = 'galaxy_x', priceMin = 25, priceMax = 32 },
    { item = 'sky_walkers', priceMin = 12, priceMax = 46 },
    { item = 'sky_pilots', priceMin = 16, priceMax = 18 },
    { item = 'sky_flyers', priceMin = 15, priceMax = 28 },
    { item = 'sky_gliders', priceMin = 17, priceMax = 35 },
    { item = 'fastrunner_2000', priceMin = 17, priceMax = 25 },
    { item = 'speedster_300', priceMin = 12, priceMax = 15 },
    { item = 'runner_prime', priceMin = 20, priceMax = 30 },
    { item = 'breeze_95s', priceMin = 18, priceMax = 25 },
    { item = 'breeze_100s', priceMin = 14, priceMax = 20 },
    { item = 'breeze_90s', priceMin = 10, priceMax = 19 },
    { item = 'sky_walkers_red', priceMin = 12, priceMax = 20 },
    { item = 'shadow_yellows', priceMin = 15, priceMax = 25 },

    --- We reccommend increasing the verified shoes.
    { item = 'breeze_90s_verified',       priceMin = 29, priceMax = 35 },
    { item = 'breeze_95s_verified',       priceMin = 25, priceMax = 30 },
    { item = 'breeze_100s_verified',      priceMin = 15, priceMax = 20 },
    { item = 'breeze_bangs_verified',     priceMin = 19, priceMax = 25 },
    { item = 'fastrunner_2000_verified',  priceMin = 15, priceMax = 35 },
    { item = 'galaxy_x_verified',         priceMin = 15, priceMax = 40 },
    { item = 'runner_prime_verified',     priceMin = 24, priceMax = 30 },
    { item = 'shadow_yellows_verified',   priceMin = 28, priceMax = 32 },
    { item = 'sky_flyers_verified',       priceMin = 22, priceMax = 28 },
    { item = 'sky_gliders_plus_verified', priceMin = 25, priceMax = 35 },
    { item = 'sky_gliders_verified',      priceMin = 24, priceMax = 35 },
    { item = 'sky_pilots_verified',       priceMin = 21, priceMax = 27 },
    { item = 'sky_walkers_red_verified',  priceMin = 22, priceMax = 30 },
    { item = 'sky_walkers_verified',      priceMin = 20, priceMax = 28 },
    { item = 'speedster_300_verified',    priceMin = 25, priceMax = 30 },
    { item = 'tiger_mediums_verified',    priceMin = 35, priceMax = 45 }
}


--- ### DISCORD.GG/CODEWAVE ### ---

-- ### Remember to remove your shoe slots from your clothing menu (if you want too anyway)
-- ### first value for exmaple "breeze_bangs" is the item name, don't change COMPONENT ID (this is the shie)
-- ### drawableID is the slot of the shoe, texture id is the texture of the shoe
Config.SneakersSlots = {
    breeze_bangs = {componentId = 6, drawableId = 234, textureId = 0},
    sky_gliders_plus = {componentId = 6, drawableId = 12, textureId = 0},
    tiger_mediums = {componentId = 6, drawableId = 15, textureId = 0},
    galaxy_x = {componentId = 6, drawableId = 250, textureId = 0},
    sky_walkers = {componentId = 6, drawableId = 261, textureId = 0},
    sky_pilots = {componentId = 6, drawableId = 271, textureId = 0},
    sky_flyers = {componentId = 6, drawableId = 270, textureId = 0},
    sky_gliders = {componentId = 6, drawableId = 12, textureId = 0},
    fastrunner_2000 = {componentId = 6, drawableId = 50, textureId = 0},
    speedster_300 = {componentId = 6, drawableId = 35, textureId = 0},
    breeze_100s = {componentId = 6, drawableId = 100, textureId = 0},
    breeze_90s = {componentId = 6, drawableId = 200, textureId = 0},
    sky_walkers_red = {componentId = 6, drawableId = 211, textureId = 0},
    shadow_yellows = {componentId = 6, drawableId = 199, textureId = 0},

}

-- Default drawable ID when the shoe is removed, You may need to change this to your own slot number
Config.sneakerdrawableids = {
    [6] = 34, -- 34 is the slot that will be given to the player if they have NO shoes item
}

