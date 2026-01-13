Config = {}
Config.Locale = 'en'

Config.SharedObjectName = 'esx:getSharedObject'  --Change if you Shared Object Name is different
Config.TargetScript = 'qtarget'                  --⚠️ Don't change if you are using ox target
Config.CheckCanCarryItem = true                  --Enable to check inventory limit/weight
Config.UseProgressBar = true                     --Set your progress bar in utils.lua then enable this
Config.DebugPoly = false 
Config.Session3dText = true

Config.BossActions = vector3(-429.11, 50.27, 46.5)    --Boss action menu location. esx_society required

Config.Volume = 0.3

Config.Controls = {
    smoke = 23,
    exit = 47,
}

Config.Blip = {
    status = true,
    name = 'Hookah Lounge',
    pos = vector3(-423.37, 37.49, 46.29),
    id = 96,
    color = 1,
    size = 0.9,
    radius = 0.0,
}

Config.ColesReduction = {
    onDelay = 0.02,              -- every 1 minute
    onUse = 0.3,                -- every use
}

Config.tobacoReduction = {
    onDelay = 0.02,              -- every 1 minute
    onUse = 0.5,                -- every use
}

Config.foilDamage = {
    onDelay = 0.02,              -- every 1 minute
    onUse = 0.2,                -- every use
}

Config.hoseDamage = {
    onUse = 0.1,                -- every use
}

Config.waterDamage = {
    onUse = 0.2,                -- every use
}

Config.Tables = {
    {
        pos = vector3(-429.7198, 25.01167, 45.79498),
        radius = 2.5,
    },
    {
        pos = vector3(-432.7663, 25.27895, 45.79498),
        radius = 2.5,
    },
    {
        pos = vector3(-431.561, 39.30583, 45.76477),
        radius = 2.5,
    },
    {
        pos = vector3(-431.1369, 43.493, 45.76477),
        radius = 2.5,
    },
    {
        pos = vector3(-416.8923, 34.02761, 46.34373),
        radius = 2.5,
    },
    {
        pos = vector3(-417.5594, 26.42476, 46.34373),
        radius = 2.5,
    },
    {
        pos = vector3(-408.3299, 33.27639, 46.34373),
        radius = 2.5,
    },
    {
        pos = vector3(-416.9445, 24.42319, 52.37025),
        radius = 2.5,
    },
    {
        pos = vector3(-411.8679, 25.57309, 52.37025),
        radius = 2.5,
    },
    {
        pos = vector3(-408.4438, 28.97672, 52.37025),
        radius = 2.5,
    },
    {
        pos = vector3(-438.2141, 26.51341, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-443.4902, 26.95226, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-449.2318, 27.43082, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-454.8505, 27.91408, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-460.4385, 28.41891, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-459.5103, 38.73854, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-454.2342, 38.29975, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-448.4926, 37.82122, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-442.874, 37.33789, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-437.286, 36.83302, 52.35322),
        radius = 2.5,
    },
    {
        pos = vector3(-431.7938, 36.36623, 52.35322),
        radius = 2.5,
    },
}

Config.HeaterModel = 'prop_cooker_03'
Config.Heaters = {
    {
        pos = vector3(-404.665, 35.977, 45.3),
        heading = -95.0,
        heatDelay = 3, -- in minute
        spawnProp = true,
    },
    {
        pos = vector3(-404.791, 34.465, 45.3),
        heading = -95.0,
        heatDelay = 3, -- in minute
        spawnProp = true,
    },
}

Config.Tobacos = {
    [1] =  {name = '4play',                 label = '4Play Fantasia'},
    [2] =  {name = '2005_blueberry',        label = '2005 Blueberry Tangiers'},
    [3] =  {name = '50_below',              label = '50 Below Nirvana Dokha'},
    [4] =  {name = 'social_smoke',          label = 'Social Smoke Absolute Zero'},
    [5] =  {name = 'zomo_cream',            label = 'Acai Cream Zomo'},
    [6] =  {name = 'spades_fantasia',       label = 'Ace of Spades Fantasia'},
    [7] =  {name = 'mofo_fantasia',         label = 'Adios Mofo Fantasia'},
    [8] =  {name = 'zomo_lemon',            label = 'Zomo Lemon Mint'},
    [9] =  {name = 'cane_mint',             label = 'Tangiers Cane Mint'},
    [10] = {name = 'blue_mist',             label = 'Starbuzz Blue Mist'},
    [11] = {name = 'double_apple',          label = 'Nakhla Double Apple'},
    [12] = {name = 'gummi_bear',            label = 'Fumari White Gummi Bear'},
    [13] = {name = 'peppermint_shake',      label = 'Trifecta Blonde Peppermint Shake'},
    [14] = {name = 'al_fakher',             label = 'Al Fakher Two Apples'},
    [15] = {name = 'el_patron',             label = 'Chaos El Patron'},
    [16] = {name = 'adalya_love',           label = 'Adalya Love 66'},
}

Config.ShopItems = {
    {
        pos = vector3(-432.48, 52.95, 46.05),
        size = vector3(1.5, 1.5, 1.0),
        heading = 85.0,
        items = {
            ['4play'] = {
                name = '4Play Fantasia',                        -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['2005_blueberry'] = {
                name = '2005 Blueberry Tangiers',                       -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['50_below'] = {
                name = '50 Below Nirvana Dokha',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['social_smoke'] = {
                name = 'Social Smoke Absolute Zero',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['zomo_cream'] = {
                name = 'Acai Cream Zomo',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['spades_fantasia'] = {
                name = 'Ace of Spades Fantasia',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['mofo_fantasia'] = {
                name = 'Adios Mofo Fantasia',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['adalya_love'] = {
                name = 'Adalya Love 66',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['zomo_lemon'] = {
                name = 'Zomo Lemon Mint',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cane_mint'] = {
                name = 'Tangiers Cane Mint',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['blue_mist'] = {
                name = 'Starbuzz Blue Mist',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['double_apple'] = {
                name = 'Nakhla Double Apple',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['gummi_bear'] = {
                name = 'Fumari White Gummi Bear',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['peppermint_shake'] = {
                name = 'Trifecta Blonde Peppermint Shake',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['al_fakher'] = {
                name = 'Al Fakher Two Apples',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['el_patron'] = {
                name = 'Chaos El Patron',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['coals'] = {
                name = 'Shisha Coals',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['hose'] = {
                name = 'Shisha Hose',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['foil'] = {
                name = 'Foil Paper',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['foil_poker'] = {
                name = 'Foil Poker',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['foil_poker'] = {
                name = 'Foil Poker',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['water'] = {
                name = 'Water',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
        }
    },
    {
        pos = vector3(-413.63, 30.55, 46.29),
        size = vector3(2.5, 2.5, 1.0),
        heading = -5.0,
        items = {
            ['cafe_vodka'] = {
                name = 'Vodka',                                 -- item name
                price = 50,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_bluecuracao'] = {
                name = 'Blue Curacao',                          -- item name
                price = 30,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_lemonade'] = {
                name = 'Lemonade',                              -- item name
                price = 20,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_shaker'] = {
                name = 'Shaker',                                -- item name
                price = 100,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_champagne'] = {
                name = 'Champagne',                                -- item name
                price = 50,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_whiterum'] = {
                name = 'White Rum',                                -- item name
                price = 50,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_redwine'] = {
                name = 'Redwine',                                -- item name
                price = 50,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_whitewine'] = {
                name = 'Whitewine',                                -- item name
                price = 50,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_whisky'] = {
                name = 'Whisky',                                -- item name
                price = 50,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_limejuice'] = {
                name = 'Lime juice',                                -- item name
                price = 10,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_mintleaves'] = {
                name = 'Mint Leaves',                                -- item name
                price = 2,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_sodawater'] = {
                name = 'Soda Water',                                -- item name
                price = 20,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cafe_tequila'] = {
                name = 'Tequila',                                -- item name
                price = 50,                                    -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                    -- container size
                available = 100,                                -- available in stock
                regeneration = 60,                              -- in second
            },
        }
    },
    {
        pos = vector3(-410.58, 33.1, 45.32),
        size = vector3(1.0, 1.5, 1.0),
        heading = -5.0,
        items = {
            ['cafe_icecube'] = {
                name = 'Ice Cube',                              -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                     -- container size
                available = 100,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
        }
    },
}