Config.FarmLocation = vector3(159.65, -245.49, 44.63)
Config.FarmRadius = 25.0

Config.FarmingRequiredItem = true

Config.FarmGetItem = {
    name = 'weed_leaf',             -- item that you will get after harvest
    max = 25,                        -- maximum per harvest * 5
    min = 12,                        -- minimum per harvest * 5
}
Config.FarmingFertilize = {         
    item = 'weed_fertilizer',       -- item required to fertilize the plant
    quantity = 1,                   -- quantity that required to fertilize
    damageChance = 5,               -- 5% chance will require fertilizer
}
Config.FarmingSpray = {
    item = 'weed_spray',            -- item required to spray the plant
    quantity = 1,                   -- quantity that required to fertilize
    damageChance = 5,               -- 5% chance will require spray
}

Config.FarmingRequired = {          --  required items to plant a new pot
    [1] = {
        item = 'weed_fertilizer',   -- item name
        quantity = 1,               -- item quantity
    },
    [2] = {
        item = 'weed_pot',          -- item name
        quantity = 1,               -- item quantity
    },
    [3] = {
        item = 'seed_weed',         -- item name
        quantity = 1,               -- item quantity
    },
}

Config.StockItems = {
    {
        pos = vector3(184.23, -265.65, 53.97),
        size = 1.0,
        items = {
            ['lighter'] = {
                name = 'Lighter',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cheap_lighter'] = {
                name = 'Cheap Lighter',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['grabba_leaf'] = {
                name = 'Grabba Leaf',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['backwoods_honey'] = {
                name = 'Backwoods Honey',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['backwoods_grape'] = {
                name = 'Backwoods Grape',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['backwoods_russian_cream'] = {
                name = 'Backwoods Russian Cream',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['paxton_pearl_cigars'] = {
                name = 'Paxton Pearl Cigars',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['banana_backwoods'] = {
                name = 'Banana Backwoods',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['raw_cone_king'] = {
                name = 'Raw Cone King',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['blueberry_jam_cookie'] = {
                name = 'Blueberry Jam Cookie',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['butter_cookie'] = {
                name = 'Butter Cookie',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['cookie_craze'] = {
                name = 'Cookie Craze',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['get_figgy'] = {
                name = 'Get Figgy',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['key_lime_cookie'] = {
                name = 'Key Lime Cookie',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['marshmallow_crisp'] = {
                name = 'Marshmallow Crisp',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['no_99'] = {
                name = 'NO 99',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['paris_fog'] = {
                name = 'Paris Fog',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['pogo'] = {
                name = 'Pogo',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['pumpkin_cookie'] = {
                name = 'Pumpkin Cookie',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['shamrock_cookie'] = {
                name = 'Shamrock Cookie',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['strawberry_jam_cookie'] = {
                name = 'Strawberry Jam Cookie',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['vape'] = {
                name = 'Vape',                      -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            
        }
    },
    {
        pos = vector3(160.97, -245.14, 44.68),
        size = 2.5,
        items = {
            ['weed_fertilizer'] = {
                name = 'Fertilizer',                            -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['weed_pot'] = {
                name = 'Weed Pot',                            -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['seed_weed'] = {
                name = 'Weed Seed',                            -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['pooch_bag'] = {
                name = 'Plastic Bag',                            -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
            ['weed_spray'] = {
                name = 'Weed Spray',                            -- item name
                price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 20,                                     -- container size
                available = 20,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
        }
    },
    {
        pos = vector3(192.8, -234.45, 53.44),
        size = 1.0,
        items = {
            ['cafe_coffeebean'] = {
                name = 'Coffee bean',                              -- item name
                price = 5,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                     -- container size
                available = 100,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
        }
    },
    {
        pos = vector3(190.715, -233.9595, 53.5),
        size = 1.0,
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
    {
        pos = vector3(190.9, -237.1, 53.5),
        size = 1.5,
        items = {
            ['cafe_khusbloom'] = {
                name = 'Dry Khus Bloom',                              -- item name
                price = 50,                                     -- price of the item. set it 0 if you don't want to buy with society money
                slots = 100,                                     -- container size
                available = 100,                                 -- available in stock
                regeneration = 60,                              -- in second
            },
        }
    },
    {
        pos = vector3(187.3021, -235.292, 54.09071),
        size = 1.0,
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
}

Config.FarmingItems = {
    -- [1] = {
    --     pos = vector3(-926.52, -1172.31, -1.86), 
    --     item = 'weed_fertilizer',                       -- item name
    --     price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
    --     slots = 20,                                     -- container size
    --     available = 10,                                 -- available in stock
    --     regeneration = 60,                              -- in second
    --     msg = '~g~[E]~s~ - ~b~Fertilizer~s~',
    --     msgtarget = 'Fertilizer',
    -- },
}


Config.ProcessLocations = {
    vector4(167.89, -253.53, 44.63, 248.6)
}

Config.Objects = {
    [1] = "bkr_prop_weed_01_small_01c",
    [2] = "bkr_prop_weed_01_small_01b",
    [3] = "bkr_prop_weed_01_small_01a",
    [4] = "bkr_prop_weed_med_01a",
    [5] = "bkr_prop_weed_med_01b",
    [6] = "bkr_prop_weed_lrg_01a",
    [7] = "bkr_prop_weed_lrg_01b",
    --There is no stage 8. So don't add any prop here
}

Config.SageTimer = {
    [1] = 1, --got to next stage in minute
    [2] = 1, --got to next stage in minute
    [3] = 1, --got to next stage in minute
    [4] = 1, --got to next stage in minute
    [5] = 1, --got to next stage in minute
    [6] = 1, --got to next stage in minute
    [7] = 1, --got to next stage in minute
    --There is no stage 8. So don't add any stage here
}

Config.Plants = {
    vector3(157.01, -245.64, 43.75),
    vector3(156.09, -245.08, 43.79),
    vector3(154.99, -244.66, 43.74),
    vector3(154.05, -244.10, 43.74),
    vector3(153.11, -243.63, 43.74),
    vector3(153.97, -241.02, 43.74),
    vector3(154.68, -241.39, 43.74),
    vector3(155.41, -241.83, 43.74),
    vector3(156.45, -242.28, 43.74),
    vector3(157.20, -242.68, 43.74),
    vector3(158.08, -243.09, 43.74),
    vector3(155.04, -243.03, 43.63),
    vector3(157.08, -244.08, 43.62),
    vector3(154.41, -242.83, 43.62),
    vector3(151.39, -242.44, 43.62),
    vector3(150.36, -242.45, 43.74),
    vector3(148.32, -241.04, 43.74),
    vector3(148.78, -240.16, 43.74),
    vector3(147.35, -242.77, 43.72),
    vector3(151.16, -241.30, 43.74),
    vector3(152.03, -239.35, 43.74),
    vector3(159.81, -240.22, 43.64),
    vector3(160.20, -239.26, 43.64),
    vector3(160.91, -238.88, 43.64),
    vector3(160.66, -237.98, 43.64),
    vector3(161.91, -238.78, 43.64),
    vector3(159.78, -252.78, 43.63),
    vector3(160.02, -252.16, 43.63),
    vector3(160.33, -251.46, 43.63),
    vector3(160.58, -250.74, 43.63),
    vector3(158.68, -252.14, 43.63),
    vector3(159.12, -251.09, 43.63),
    vector3(157.47, -251.76, 43.63),
    vector3(157.79, -251.12, 43.63),
    vector3(158.16, -250.38, 43.63),
    vector3(158.53, -249.58, 43.63),
    vector3(150.51, -248.94, 43.71),
    vector3(150.81, -248.11, 43.71),
    vector3(151.16, -247.28, 43.71),
    vector3(151.48, -246.56, 43.72),
    vector3(149.22, -245.70, 43.71),
    vector3(150.06, -246.78, 43.71),
    vector3(148.98, -246.49, 43.67),
    vector3(148.27, -248.22, 43.71),
    vector3(149.32, -248.65, 43.73),
    vector3(149.72, -247.75, 43.71),
    vector3(163.83, -241.86, 43.74),
    vector3(164.77, -242.27, 43.72),
    vector3(165.56, -242.60, 43.72),
    vector3(166.38, -243.26, 43.72),
    vector3(167.30, -243.69, 43.72),
    vector3(169.15, -241.57, 43.72),
    vector3(168.31, -241.16, 43.72),
    vector3(167.58, -240.89, 43.72),
    vector3(166.77, -240.45, 43.72),
    vector3(165.92, -240.01, 43.72),
    vector3(164.78, -239.50, 43.72),
    vector3(162.87, -239.23, 43.64),
    vector3(161.78, -241.03, 43.65),
    vector3(160.87, -240.73, 43.64),
    vector3(148.64, -247.29, 43.67),
    vector3(163.18, -247.03, 43.64),
    vector3(164.14, -247.44, 43.64),
    vector3(165.07, -247.85, 43.64),
    vector3(165.99, -248.24, 43.64),
    vector3(166.91, -246.11, 43.64),
    vector3(165.99, -245.72, 43.64),
    vector3(165.15, -245.36, 43.64),
    vector3(164.10, -244.90, 43.65),
    vector3(156.55, -249.08, 43.63),
    vector3(155.50, -248.72, 43.64),
    vector3(154.72, -248.29, 43.67),
    vector3(153.67, -247.87, 43.68),
    vector3(153.30, -249.65, 43.64),
    vector3(154.30, -250.08, 43.65),
    vector3(155.01, -250.40, 43.71),
    vector3(155.85, -250.74, 43.64),
    vector3(157.96, -239.67, 43.64),
    vector3(157.07, -239.30, 43.64),
    vector3(156.29, -238.94, 43.63),
    vector3(155.43, -238.62, 43.64),
    vector3(156.18, -236.96, 43.65),
    vector3(157.07, -237.38, 43.66),
    vector3(157.79, -237.64, 43.64),
    vector3(158.62, -238.05, 43.63),
    vector3(154.38, -235.20, 43.65),
    vector3(154.01, -235.93, 43.64),
    vector3(153.67, -236.62, 43.67),
    vector3(153.30, -237.63, 43.64),
    vector3(152.58, -234.12, 43.63),
    vector3(152.11, -235.13, 43.63),
    vector3(151.73, -235.93, 43.65),
    vector3(151.41, -236.88, 43.64),
}
