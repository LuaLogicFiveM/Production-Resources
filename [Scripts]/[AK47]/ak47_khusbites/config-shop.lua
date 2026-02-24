Config.format = {
    currency = 'USD',                               -- This is the format of the currency, so that your currency sign appears correctly
    location = 'en-US'                              -- This is the location of your country, to format the decimal places according to your standard
}

Config.Default = {
    stock = 10,
    price = 500
}

Config.ManagementRank = {                           -- Minimum job rank who can update item price & stock form shop management
    stock = 2,
    price = 2
}

Config.AutoStock = {         -- auto stock for shop items
    enable = true,
    slots = 50,             -- container size
    regeneration = 30,       -- regenerate item every 10 minutes
    add = math.random(1, 3),                -- add 1 item to the stock
}

Config.BossActions = vector3(-516.15, 50.31, 44.60)    --Boss action menu location. esx_society required

Config.Shop = {
    blip = {enable = false, pos = vector3(-519.97, 39.7, 44.59), name = 'KhusBites', sprite = 469, color = 32, size = 1.0, radius = 0.0, radius_color = 32},                                                           -- job name
    management = vector3(-537.09, 41.31, 44.58),
    sell_coords = {                                    -- The coordinates where customes will buy things on this store (coordinates composed of x, y, z)
        {
            pos = vector3(-522.97, 39.16, 44.83),
            pages = {
                [0] = {name = "Flavours", icon = 'fa-cookie-bite'},
                [1] = {name = "Backwoods", icon = 'fa-cookie-bite'},
                [2] = {name = "Joints", icon = 'fa-cookie-bite'},
                [3] = {name = "Vape", icon = 'fa-cookie-bite'},
                [4] = {name = "Utilities", icon = 'fa-cookie-bite'},
            }
        },
        {
            pos = vector3(-529.45, 39.74, 44.83),
            pages = {
                [0] = {name = "Flavours", icon = 'fa-cookie-bite'},
                [1] = {name = "Backwoods", icon = 'fa-cookie-bite'},
                [2] = {name = "Joints", icon = 'fa-cookie-bite'},
                [3] = {name = "Vape", icon = 'fa-cookie-bite'},
                [4] = {name = "Utilities", icon = 'fa-cookie-bite'},

            }
        },
        {
            pos = vector3(-528.15, 30.63, 44.83),
            pages = {
                [0] = {name = "Flavours", icon = 'fa-cookie-bite'},
                [1] = {name = "Backwoods", icon = 'fa-cookie-bite'},
                [2] = {name = "Joints", icon = 'fa-cookie-bite'},
                [3] = {name = "Vape", icon = 'fa-cookie-bite'},
                [4] = {name = "Utilities", icon = 'fa-cookie-bite'},
            }
        },
    },
    edibles = {
        {
            pos = vector3(-517.51, 35.14, 44.3),
            boxHeading = 355.0,
            boxSize = vector3(1.0, 1.0, 3.0),
            refillHunger = 30,
            refillThirst = 30,
            relieveStress = 30,
            consumeDelay = 10,
            item = {
                name = "kushkrisps",
                label = "Kush Krisps",
                placement = {
                    prop = 'prop_kushkrisps',
                    bone = 28422,
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
                placement2 = {
                    prop = 'prop_kushkrisps_plate',
                    bone = 60309,
                    pos = vector3(-0.05, 0.1, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
            },
        },{
            pos = vector3(-517.47, 36.18, 44.3),
            boxHeading = 355.0,
            boxSize = vector3(1.0, 1.0, 3.0),
            refillHunger = 30,
            refillThirst = 30,
            relieveStress = 30,
            consumeDelay = 10,
            item = {
                name = "herbaldelightgummies",
                label = "Herbal Delight Gummies",
                placement = {
                    prop = 'prop_herbaldelightgummies',
                    bone = 28422,
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
                placement2 = {
                    prop = 'prop_herbaldelightgummies_plate',
                    bone = 60309,
                    pos = vector3(-0.05, 0.1, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
            },
        },{
            pos = vector3(-517.28, 37.45, 44.3),
            boxHeading = 355.0,
            boxSize = vector3(1.0, 1.0, 3.0),
            refillHunger = 30,
            refillThirst = 30,
            relieveStress = 30,
            consumeDelay = 10,
            item = {
                name = "blazebites",
                label = "Blaze Bites",
                placement = {
                    prop = 'prop_blazebites',
                    bone = 28422,
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
                placement2 = {
                    prop = 'prop_blazebites_plate',
                    bone = 60309,
                    pos = vector3(0.1, 0.1, 0.0),
                    rot = vector3(0.0, 180.0, 180.0),
                },
            },
        },{
            pos = vector3(-517.05, 39.89, 44.3),
            boxHeading = 355.0,
            boxSize = vector3(1.0, 1.0, 3.0),
            refillHunger = 30,
            refillThirst = 30,
            relieveStress = 30,
            consumeDelay = 10,
            item = {
                name = "chroniccrunchcookies",
                label = "Chronic Crunch Cookies",
                placement = {
                    prop = 'prop_chroniccrunchcookies',
                    bone = 28422,
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 180.0, 0.0),
                },
                placement2 = {
                    prop = 'prop_chroniccrunchcookies_plate',
                    bone = 60309,
                    pos = vector3(0.1, 0.1, 0.0),
                    rot = vector3(0.0, 180.0, 180.0),
                },
            },
        },{
            pos = vector3(-516.93, 41.04, 44.3),
            boxHeading = 355.0,
            boxSize = vector3(1.0, 1.0, 3.0),
            refillHunger = 30,
            refillThirst = 30,
            relieveStress = 30,
            consumeDelay = 10,
            item = {
                name = "hightimebrownies",
                label = "Hightime Brownies",
                placement = {
                    prop = 'prop_hightimebrownies',
                    bone = 28422,
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
                placement2 = {
                    prop = 'prop_hightimebrownies_plate',
                    bone = 60309,
                    pos = vector3(0.1, 0.1, 0.0),
                    rot = vector3(0.0, 180.0, 180.0),
                },
            },
        },
        {
            pos = vector3(-517.17, 38.64, 44.3),
            boxHeading = 355.0,
            boxSize = vector3(1.0, 1.0, 3.0),
            refillHunger = 30,
            refillThirst = 30,
            relieveStress = 30,
            consumeDelay = 10,
            item = {
                name = "kushkrisps",
                label = "Kush Krisps",
                placement = {
                    prop = 'prop_kushkrisps',
                    bone = 28422,
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
                placement2 = {
                    prop = 'prop_kushkrisps_plate',
                    bone = 60309,
                    pos = vector3(-0.05, 0.1, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                },
            },
        },
    },
    managepages = {
        [0] = {name = "Flavours", icon = 'fa-cookie-bite'},
        [1] = {name = "Backwoods", icon = 'fa-cookie-bite'},
        [2] = {name = "Joints", icon = 'fa-cookie-bite'},
        [3] = {name = "Vape", icon = 'fa-cookie-bite'},
        [4] = {name = "Utilities", icon = 'fa-cookie-bite'},
        [5] = {name = "Edibles", icon = 'fa-cookie-bite'},
    },
    data = {
        market_items = {                    -- Here you configure the items definitions
            backwoods_grape = {             -- The item ID
                name = "Backwoods Grape",   -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            backwoods_honey = {             -- The item ID
                name = "Backwoods Honey",   -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            backwoods_russian_cream = {             -- The item ID
                name = "Backwoods Russian Cream",   -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            grabba_leaf = {                 -- The item ID
                name = "Grabba Leaf",       -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            paxton_pearl_cigars = {                 -- The item ID
                name = "Paxton Pearl Cigars",       -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            banana_backwoods = {                 -- The item ID
                name = "Banana Backwoods",       -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            raw_cone_king = {                 -- The item ID
                name = "Raw Cone King",       -- The item display name
                page = 0,                    -- Set on which page this item will appear
            },
            
            cake_mix = {                    -- The item ID
                name = "Cake Mix",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            cereal_milk = {                 -- The item ID
                name = "Cereal Milk",       -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            cheetah_piss = {                -- The item ID
                name = "Cheetah Piss",      -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            gary_payton = {                 -- The item ID
                name = "Hary Payton",       -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            gelatti = {                     -- The item ID
                name = "Gelatti",           -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            georgia_pie = {                 -- The item ID
                name = "Georgia Pie",       -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            jefe = {                        -- The item ID
                name = "Jefe",              -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            white_runtz = {                 -- The item ID
                name = "White Runtz",       -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            whitecherry_gelato = {          -- The item ID
                name = "Whitecherry Gelato",-- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            blueberry_cruffin = {           -- The item ID
                name = "Blueberry Cruffin", -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            snow_man = {                    -- The item ID
                name = "Snow Man",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            fine_china = {                    -- The item ID
                name = "Fine China",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            pink_sandy = {                    -- The item ID
                name = "Oink Sandy",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            zushi = {                    -- The item ID
                name = "Zushi",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            apple_gelato = {                    -- The item ID
                name = "Apple Gelato",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            biscotti = {                    -- The item ID
                name = "Biscotti",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            collins_ave = {                    -- The item ID
                name = "Collins AVE",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            marathon = {                    -- The item ID
                name = "Marathon",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            oreoz = {                    -- The item ID
                name = "Oreoz",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            pirckly_pear = {                    -- The item ID
                name = "Pirckly Pear",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            runtz_og = {                    -- The item ID
                name = "Runtz OG",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            blue_tomyz = {                    -- The item ID
                name = "Blue Tomyz",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            ether = {                    -- The item ID
                name = "Ether",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            froties = {                    -- The item ID
                name = "Froties",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            gmo_cookies = {                    -- The item ID
                name = "GMO Cookies",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            ice_cream_cake_pack = {                    -- The item ID
                name = "Ice Cream Cake Pack",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            khalifa_kush = {                    -- The item ID
                name = "Khalifa Kush",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            la_confidential = {                    -- The item ID
                name = "LA Confidential",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            marshmallow_og = {                    -- The item ID
                name = "Marshmallow OG",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            moon_rock = {                    -- The item ID
                name = "Moon Rock",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            sour_diesel = {                    -- The item ID
                name = "Sour Diesel",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            tahoe_og = {                    -- The item ID
                name = "Tahoe OG",          -- The item display name
                page = 1,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                        ['pooch_bag'] = 1,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            
            cake_mix_joint = {                    -- The item ID
                name = "Cake Mix Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            cereal_milk_joint = {                 -- The item ID
                name = "Cereal Milk Joint",       -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            cheetah_piss_joint = {                -- The item ID
                name = "Cheetah Piss Joint",      -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            gary_payton_joint = {                 -- The item ID
                name = "Hary Payton Joint",       -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            gelatti_joint = {                     -- The item ID
                name = "Gelatti Joint",           -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            georgia_pie_joint = {                 -- The item ID
                name = "Georgia Pie Joint",       -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            jefe_joint = {                        -- The item ID
                name = "Jefe Joint",              -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            white_runtz_joint = {                 -- The item ID
                name = "White Runt Jointz",       -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            whitecherry_gelato_joint = {          -- The item ID
                name = "Whitecherry Gelato Joint",-- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            blueberry_cruffin_joint = {           -- The item ID
                name = "Blueberry Cruffin Joint", -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            snow_man_joint = {                    -- The item ID
                name = "Snow Man Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            fine_china_joint = {                    -- The item ID
                name = "Fine China Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            pink_sandy_joint = {                    -- The item ID
                name = "Pink Sandy Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            zushi_joint = {                    -- The item ID
                name = "Zushi Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            apple_gelato_joint = {                    -- The item ID
                name = "Apple Gelato Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            biscotti_joint = {                    -- The item ID
                name = "Biscotti Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            collins_ave_joint = {                    -- The item ID
                name = "Collins AVE Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            marathon_joint = {                    -- The item ID
                name = "Marathon Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            oreoz_joint = {                    -- The item ID
                name = "Oreoz Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            pirckly_pear_joint = {                    -- The item ID
                name = "Pirckly Pear Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            runtz_og_joint = {                    -- The item ID
                name = "Runtz OG Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            blue_tomyz_joint = {                    -- The item ID
                name = "Blue Tomyz Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            ether_joint = {                    -- The item ID
                name = "Ether Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            froties_joint = {                    -- The item ID
                name = "Froties Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            gmo_cookies_joint = {                    -- The item ID
                name = "GMO Cookies Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            ice_cream_cake_pack_joint = {                    -- The item ID
                name = "Ice Cream Cake Pack Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            khalifa_kush_joint = {                    -- The item ID
                name = "Khalifa Kush Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            la_confidential_joint = {                    -- The item ID
                name = "LA Confidential Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            marshmallow_og_joint = {                    -- The item ID
                name = "Marshmallow OG Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            moon_rock_joint = {                    -- The item ID
                name = "Moon Rock Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            sour_diesel_joint = {                    -- The item ID
                name = "Sour Diesel Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            tahoe_og_joint = {                    -- The item ID
                name = "Tahoe OG Joint",          -- The item display name
                page = 2                    -- Set on which page this item will appear
            },
            
            blueberry_jam_cookie = {                    -- The item ID
                name = "Blueberry Jam Cookie",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            butter_cookie = {                    -- The item ID
                name = "Butter Cookie",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            cookie_craze = {                    -- The item ID
                name = "Cookie Craze",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            get_figgy = {                    -- The item ID
                name = "Get Figgy",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            key_lime_cookie = {                    -- The item ID
                name = "Key Lime Cookie",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            marshmallow_crisp = {                    -- The item ID
                name = "Marshmallow Crisp",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            no_99 = {                    -- The item ID
                name = "NO 99",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            paris_fog = {                    -- The item ID
                name = "Paris Fog",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            pogo = {                    -- The item ID
                name = "Pogo",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            pumpkin_cookie = {                    -- The item ID
                name = "Pumpkin Cookie",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            shamrock_cookie = {                    -- The item ID
                name = "Shamrock Cookie",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            strawberry_jam_cookie = {                    -- The item ID
                name = "Strawberry Jam Cookie",          -- The item display name
                page = 3                    -- Set on which page this item will appear
            },
            
            lighter = {                     -- The item ID
                name = "Lighter",           -- The item display name
                page = 4                    -- Set on which page this item will appear
            },
            cheap_lighter = {               -- The item ID
                name = "Cheap Lighter",     -- The item display name
                page = 4                    -- Set on which page this item will appear
            },
            vape = {               -- The item ID
                name = "Vape",     -- The item display name
                page = 4                    -- Set on which page this item will appear
            },

            kushkrisps = {               -- The item ID
                name = "Kush Krisps",     -- The item display name
                page = 5,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            herbaldelightgummies = {               -- The item ID
                name = "Herbal Delight Gummies",     -- The item display name
                page = 5,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            blazebites = {               -- The item ID
                name = "Blaze Bites",     -- The item display name
                page = 5,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            chroniccrunchcookies = {               -- The item ID
                name = "Chronic Crunch Cookies",     -- The item display name
                page = 5,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            hightimebrownies = {               -- The item ID
                name = "HighTime Brownies",     -- The item display name
                page = 5,                    -- Set on which page this item will appear
                process = {
                    required = {
                        ['weed_leaf'] = 10,
                    },
                    processTime = 10000,
                    reward = 1,
                }
            },
            
        },
    }
}