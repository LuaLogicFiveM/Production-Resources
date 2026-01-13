Config.FarmLocation = vector3(-492.22, 37.78, 38.67)
Config.FarmRadius = 50.0

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
        pos = vector3(-514.72, 51.89, 44.59),
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
        pos = vector3(-493.7, 37.32, 38.31),
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
    }
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
    vector4(-503.09, 43.79, 38.67, 84.67),
    vector4(-513.62, 49.73, 44.59, 263.48)
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
	vector3(-491.06, 33.50, 37.66),
	vector3(-489.35, 36.66, 37.77),
	vector3(-492.10, 32.64, 37.66),
	vector3(-492.97, 32.92, 37.66),
	vector3(-492.38, 33.63, 37.66),
	vector3(-490.31, 36.77, 37.77),
	vector3(-493.17, 33.79, 37.66),
	vector3(-483.39, 35.11, 37.76),
	vector3(-480.40, 37.88, 37.76),
	vector3(-480.56, 36.89, 37.76),
	vector3(-493.45, 32.05, 37.66),
	vector3(-489.67, 38.02, 37.65),
	vector3(-491.12, 32.47, 37.66),
	vector3(-490.09, 39.52, 37.77),
	vector3(-494.10, 31.79, 37.66),
	vector3(-491.68, 31.88, 37.66),
	vector3(-489.04, 39.29, 37.82),
	vector3(-488.51, 36.51, 37.77),
	vector3(-492.60, 31.48, 37.66),
	vector3(-480.02, 39.82, 37.76),
	vector3(-487.41, 37.66, 37.65),
	vector3(-487.38, 36.41, 37.77),
	vector3(-482.98, 38.38, 37.76),
	vector3(-491.16, 31.10, 37.66),
	vector3(-487.87, 39.23, 37.77),
	vector3(-486.75, 37.67, 37.65),
	vector3(-486.55, 36.22, 37.77),
	vector3(-485.76, 36.09, 37.77),
	vector3(-485.76, 38.84, 37.77),
	vector3(-483.18, 37.23, 37.76),
	vector3(-483.75, 38.24, 37.65),
	vector3(-496.96, 34.03, 37.82),
	vector3(-495.64, 33.89, 37.82),
	vector3(-483.85, 42.78, 37.73),
	vector3(-495.67, 32.67, 37.67),
	vector3(-497.56, 34.12, 37.82),
	vector3(-496.58, 32.76, 37.67),
	vector3(-498.47, 34.43, 37.82),
	vector3(-483.83, 43.81, 37.73),
	vector3(-496.34, 31.09, 37.79),
	vector3(-495.56, 31.18, 37.79),
	vector3(-499.09, 34.51, 37.82),
	vector3(-492.55, 44.48, 37.65),
	vector3(-493.63, 44.03, 37.65),
	vector3(-497.33, 31.50, 37.82),
	vector3(-492.47, 42.77, 37.65),
	vector3(-498.98, 32.96, 37.67),
	vector3(-498.04, 31.54, 37.82),
	vector3(-500.15, 34.61, 37.82),
	vector3(-494.67, 43.22, 37.65),
	vector3(-498.87, 31.59, 37.82),
	vector3(-500.05, 33.11, 37.67),
	vector3(-492.67, 43.66, 37.65),
	vector3(-499.73, 31.67, 37.82),
	vector3(-494.90, 44.00, 37.65),
	vector3(-485.05, 42.91, 37.73),
	vector3(-484.91, 42.11, 37.73),
	vector3(-483.24, 42.07, 37.73),
	vector3(-484.97, 43.81, 37.73),
	vector3(-493.60, 45.17, 37.65),
	vector3(-492.44, 45.20, 37.65),
	vector3(-500.65, 31.74, 37.82),
	vector3(-494.99, 44.78, 37.65),
	vector3(-494.96, 45.45, 37.65),
	vector3(-485.95, 42.53, 37.81),
	vector3(-484.81, 44.68, 37.73),
	vector3(-483.39, 44.55, 37.73),
	vector3(-481.97, 43.69, 37.73),
	vector3(-482.73, 42.87, 37.73),
	vector3(-496.61, 36.74, 37.66),
	vector3(-488.19, 33.41, 37.82),
	vector3(-497.43, 36.83, 37.66),
	vector3(-489.07, 33.61, 37.82),
	vector3(-496.67, 38.80, 37.66),
	vector3(-497.33, 38.73, 37.66),
	vector3(-498.31, 36.92, 37.66),
	vector3(-499.20, 36.96, 37.66),
	vector3(-498.13, 38.82, 37.66),
	vector3(-489.12, 32.19, 37.53),
	vector3(-488.66, 43.02, 37.82),
	vector3(-486.82, 31.47, 37.66),
	vector3(-498.95, 38.93, 37.72),
	vector3(-487.20, 33.29, 37.82),
	vector3(-499.68, 38.96, 37.72),
	vector3(-489.12, 30.93, 37.45),
	vector3(-490.15, 43.16, 37.82),
	vector3(-489.52, 43.08, 37.82),
	vector3(-487.90, 43.02, 37.82),
	vector3(-485.93, 33.11, 37.82),
	vector3(-488.07, 30.64, 37.45),
	vector3(-486.81, 30.41, 37.66),
	vector3(-488.45, 44.33, 37.82),
	vector3(-490.46, 45.40, 37.82),
	vector3(-488.21, 45.29, 37.82),
	vector3(-489.40, 45.41, 37.82),
}
