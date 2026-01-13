Config.FarmLocation = vector3(-1712.5562, -1120.8379, 13.2389)
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

Config.FarmingMultiItems = {
    [1] = {
        pos = vector3(-1722.8741, -1110.5530, 13.2242),
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
    }
}

Config.FarmingItems = {
    [1] = {
        pos = vector3(-1719.8146, -1109.9929, 13.2242), 
        item = 'weed_fertilizer',                       -- item name
        price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
        slots = 20,                                     -- container size
        available = 10,                                 -- available in stock
        regeneration = 60,                              -- in second
        msg = '~g~[E]~s~ - ~b~Fertilizer~s~',
        msgtarget = 'Fertilizer',
    },
    [2] = {
        pos = vector3(-1723.3876, -1131.2366, 17.4032), 
        item = 'weed_pot',                              -- item name
        price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
        slots = 20,                                     -- container size
        available = 10,                                 -- available in stock
        regeneration = 60,                              -- in second
        msg = '~g~[E]~s~ - ~b~Weed Pot~s~',
        msgtarget = 'Weed Pot',
    },
    [3] = {
        pos = vector3(-1722.2422, -1129.9580, 17.4032), 
        item = 'seed_weed',                             -- item name
        price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
        slots = 20,                                     -- container size
        available = 10,                                 -- available in stock
        regeneration = 30,                              -- in second
        msg = '~g~[E]~s~ - ~b~Weed Seed~s~',
        msgtarget = 'Weed Seed',
    },
    [4] = {
        pos = vector3(-1720.6892, -1128.1488, 17.3862), 
        item = 'weed_spray',                            -- item name
        price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
        slots = 20,                                     -- container size
        available = 10,                                 -- available in stock
        regeneration = 30,                              -- in second
        msg = '~g~[E]~s~ - ~b~Weed Spray~s~',
        msgtarget = 'Weed Spray',
    },
    [5] = {
        pos = vector3(-1719.2163, -1126.4639, 17.3862), 
        item = 'pooch_bag',                             -- item name
        price = 10,                                     -- price of the item. set it 0 if you don't want to buy with society money
        slots = 20,                                     -- container size
        available = 10,                                 -- available in stock
        regeneration = 30,                              -- in second
        msg = '~g~[E]~s~ - ~b~Pooch Bag~s~',
        msgtarget = 'Pooch Bag',
    },
}

Config.ProcessLocation = {
    pos = vector3(-1721.3284, -1109.5800, 13.2242),
    heading = 52.5086,
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
	vector3(-1712.2368, -1122.2168, 13.2191),
	vector3(-1713.0074, -1121.5848, 13.2395),
	vector3(-1711.8007, -1121.3167, 13.2200),
	vector3(-1731.4131, -1120.6832, 13.2754),
	vector3(-1730.8135, -1121.1587, 13.2754),
	vector3(-1731.3274, -1122.2488, 13.2707),
	vector3(-1721.1842, -1133.1238, 13.2526),
	vector3(-1720.4724, -1132.3064, 13.2526),
	vector3(-1723.0006, -1131.6934, 13.2707),
}
