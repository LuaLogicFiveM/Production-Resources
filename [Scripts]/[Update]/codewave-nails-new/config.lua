--- ######################### ---
--- ## DISCORD.GG/CODEWAVE ## ---
--- ######################### ---


--- ### nailS & BUNDLES ### ---

Config = {}
Config.Framework = 'ESX' -- 'ESX' or 'QBCore' (case sensitive)
Config.InteractionType = 'ox_target' -- ox_target | 3dtext
Config.UseOxTargetForNpc = true -- Set to true to enable ox_target, false to use key press interaction
Config.TimeToCraft = 8000
Config.DebugMode = false  -- Set to true to enable debug messages

-- ONLY FOR NPC SALES.
Config.MinItemsToSell = 1 
Config.MaxItemsToSell = 3
-- Change the commands if you wish
Config.StopSellingCommand = 'stopsellingnails'
Config.StartSellingCommand = 'sellnails'


Config.OnlyFemales = false  -- Enable or disable the restriction to only allow male peds
Config.FemalePedModels = {
    `mp_f_freemode_01`,
}

Config.NPC = {
    Model = "a_f_m_soucentmc_01", -- Change to your desired NPC model
    Coords = vector3(225.8059, -1539.3204, 28.3218), -- Change to your desired NPC spawn location
    Heading = 304.0, -- Adjust the heading as needed
    BlipEnabled = true,  -- New option to enable/disable blip
    BlipSprite = 621,        -- Example blip icon, see https://wiki.rage.mp/index.php?title=Blips for blip IDs
    BlipScale = 0.8,
    BlipColour = 8,
    BlipName = "Nails & Sets"
}

Config.Items = {
    { name = "Acrylic Liquid", id = "acrylic-liquid", img = "image/acrylic-liquid.png", price = 100 }, -- You don't really need too touch anything apart from PRICE
    { name = "Acrylic Powder", id = "acrylic-powder", img = "image/acrylic-powder.png", price = 200 },
    { name = "Acrylic Nails", id = "acrylic-nails", img = "image/acrylic-nails.png", price = 300 },
    { name = "Nail Work Phone", id = "nailphone", img = "image/nailphone.png", price = 1000 },
    { name = "Nail Table", id = "nailtable", img = "image/acrylic-table.png", price = 1200 }
}



-- Quantity is the amount of that item required to craft.
Config.CraftingRecipes = {
    { name = "Set Of Coffin Nails", id = "cfn-nails", img = "image/coffin-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Stiletto Nails", id = "sti-nails", img = "image/stiletto-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-nails", quantity = 1 } } },
    { name = "Set Of Almond Nails", id = "alm-nails", img = "image/almond-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Lipstick Nails", id = "lip-nails", img = "image/lipstick-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Ballerina Nails", id = "bal-nails", img = "image/ballerina-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Square Nails", id = "squ-nails", img = "image/square-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } },
    { name = "Set Of Flare Nails", id = "fla-nails", img = "image/flare-nail.png", requiredItems = { { id = "acrylic-liquid", quantity = 2 }, { id = "acrylic-nails", quantity = 2 }, { id = "acrylic-powder", quantity = 1 } } }
}

Config.PlayMusicWhileUIIsOpen = false --- True = music plays, False = music doesn't. (YOU CAN CHANGE MUSIC IN SOUNDS FILE)
Config.MusicVolume = 0.05 --- Music volume in the menu, Only applies if above is set to True

Config.nailTableItem = 'nailtable' --- The table item
Config.PropItemName = 'prop_ven_market_table1' -- You can change this if you want (to basically any prop, make it make sense though!)

Config.RequiredItems = {
    { item = 'cfn-nails', priceMin = 800, priceMax = 1200 },
    { item = 'sti-nails', priceMin = 800, priceMax = 1200 },
    { item = 'alm-nails', priceMin = 800, priceMax = 1200 },
    { item = 'lip-nails', priceMin = 800, priceMax = 1200 },
    { item = 'bal-nails', priceMin = 800, priceMax = 1200 },
    { item = 'squ-nails', priceMin = 800, priceMax = 1200 },
    { item = 'fla-nails', priceMin = 800, priceMax = 1200 }
}

