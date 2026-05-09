Config = {}

Config.Debug = false
Config.LogWebhook = ""

Config.Mission = {
    name = "drug-drops",
    timeout = 60,
    cooldown = 60,
    label = locale("DRUG_DROPS_MISSION_LABEL"),
    desc = locale("DRUG_DROPS_MISSION_DESC"),
    group = {
        min = not Config.Debug and 2 or 0,
        max = 3
    },
    policeRequired = not Config.Debug and 4 or 0,
    concurrentMissions = 1,
}

Config.TimeToRemoveCompletedDropPoint = 10 * 60   -- seconds
Config.TimeBeforeRewardCrateGetsRemoved = 10 * 60 -- seconds
Config.ThresholdForCancelingRun = 60 * 60         -- in seconds

Config.StartingNpc = {
    models = { `s_m_y_ammucity_01`, `s_m_y_blackops_02`, `s_m_y_prisoner_01` },
    -- Setting to true, on server start, random location will be choosen, other wise NPC will spawn in every location
    randomLocation = false,
    scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
    -- anim = {
    --     dict = 'anim@heists@box_carry@',
    --     name = 'idle',
    --     flag = 1,
    -- },
    locations = {
        vector4(-897.0804, -1312.9518, 5.4152, 151.8303)
    }
}

Config.Alert = {
    jobs = {'gsp'},
    code = '10-90',
    icon = 'fas fa-box',
    blip = {
        sprite = 478,
        size = 1.5,
        color = 25,
        duration = 60 * 5,
        flash = true
    }
}

Config.Requirements = {
    requiredPoints = 60,
    itemPoints = {
        pure_meth_brick_perfect = 5,
        pure_meth_brick_good = 5,
        pure_meth_brick_dirty = 2,
        pure_meth_brick_death = 2,
        cocaine_mission_brick = 10,
        cocaine_brick = 10,
        mdma_brick = 15,
    }
}

Config.DropItem = {
    id = 'drug_drops_box',
    weight = 8,
    label = locale('DROP_BOX_ITEM_LABEL'),
    rarity = 'UNIQUE',
    animation = {
        priority = 1,
        dictionary = 'anim@heists@box_carry@',
        animation = 'idle',
        prop = {
            hash = `prop_mp_drug_pack_red`,
            bone = 28422,
            position = vector3(-0.02, -0.086, 0.056),
            rotation = vector3(65.65, 79.06, 12.1),
        },
    },
    buttons = {
        {
            label = locale('DROP_BOX_ITEM_UNBOX'),
            event = "prp-drug-drops:server:openDrugBox",
        }
    }
}

Config.Messages = {
    contactName = locale("DROPS_PHONE_CONTACT"),
    contactNumber = '555-132-482',
}

Config.Rewards = {
    lootPool = {
        COMMON = {
            { name = "moneyband", min = 5, max = 12 },

        },
        RARE = {
            { name = "moneyband",        min = 8, max = 16 },
            { name = "electronickit",    min = 1, max = 1 },
            { name = "copper",           min = 1, max = 2 },
            { name = "advancedlockpick", min = 1, max = 1 },
        },
        EPIC = {
            { name = "moneyband",    min = 8, max = 16 },
            { name = "cryptostick",  min = 1, max = 1 },
            { name = "trojan_usb",   min = 1, max = 1 },
            { name = "goldchain",    min = 1, max = 1 },
            { name = "thermite",     min = 1, max = 1 },
            { name = "drill",        min = 1, max = 1 },
        },
        LEGENDARY = {
            { name = "goldbar",  min = 1, max = 1 },
            { name = "rolex",    min = 1, max = 1 },
            { name = "laptop",   min = 1, max = 1 },
            { name = "diamond",  min = 1, max = 1 },
            { name = "gold",     min = 1, max = 1 },
        },
    },
    byCompletion = {
        fast = {
            items = 10,
            guarantees = {
                COMMON = 4,
                RARE = 2,
                EPIC = 1,
                LEGENDARY = 1,
            }
        },
        normal = {
            items = 7,
            guarantees = {
                COMMON = 3,
                RARE = 1,
            }
        },
        slow = {
            items = 5,
            guarantees = {
                COMMON = 5,
            }
        }
    }
}

Config.ChanceForNextDropAlert = 0.8 -- 80%
Config.Runs = {
    default = {
        name = "Los Santos County",
        starting = {
            -- for dialog, start mission, cancel mission?
            npc = {
                model = `s_m_m_dockwork_01`,
                coords = vector4(39.0534, -1023.7131, 28.5238, 25.2223),
                scenario = "WORLD_HUMAN_STAND_IMPATIENT",
            },
            -- For putting drugs into, and taking replacement later?
            crate = {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(39.1227, -1020.4761, 28.4889),
                rotation = vector3(0.0, 0.0, 90.0),
            },
            -- vehicle spawns
            vehicle = {
                models = { `bison`  },
                coords = {
                    vector4(30.2349, -1026.9403, 29.4552, 255.2580),
                    vector4(29.5068, -1029.4808, 29.4536, 252.5219),
                    vector4(28.3890, -1031.9324, 29.4097, 252.4946),
                    vector4(30.8773, -1024.3188, 29.4546, 250.0301)
                }
            }
        },
        routes = {
            {
                completionTime = {
                    fast = 300,   -- in seconds
                    normal = 360, -- in seconds
                    slow = 420,   -- in seconds
                },
                locations = {
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(-463.6012, -63.3638, 43.5133),
                        rotation = vector3(0.0, 0.0, 2.547),
                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(131.8163, 317.1177, 111.6368),
                        rotation = vector3(0.0, 0.0, 280.6032),

                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(584.7958, -472.6907, 24.2405),
                        rotation = vector3(0.0, 0.0, 284.7698),
                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(511.8158, -1814.3572, 28.0149),
                        rotation = vector3(0.0, 0.0, 0.0)
                    }
                }
            }
            -- more points
            -- [2] == { ... }
        },
        rewardPickups = {
            {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(575.5675, -1436.7711, 18.6038),
                rotation = vector3(0.0, 0.0, 0.0),

            },
            {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(127.8632, -1184.3910, 28.4973),
                rotation = vector3(0.0, 0.0, 0.0),

            },
            {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(-940.3232, -2033.1703, 8.5119),
                rotation = vector3(0.0, 0.0, 0.0),

            }
        }
    },
    ls = {
        name = "Beach run",
        starting = {
            -- for dialog, start mission, cancel mission?
            npc = {
                model = `s_m_m_dockwork_01`,
                coords = vector4(926.0721, -2530.9192, 27.3027, 153.6489),
                scenario = "WORLD_HUMAN_STAND_IMPATIENT",
            },
            -- For putting drugs into, and taking replacement later?
            crate = {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(922.0283, -2532.2559, 27.3027),
                rotation = vector3(0.0, 0.0, 90.0),
            },
            -- vehicle spawns
            vehicle = {
                models = { `gbarcherpro2`, `gbargento7fs`, `gbcyphergts`, `gbimpalerdlx`, `gbmochi`, `gbvigerorat`  },
                coords = {
                    vector4(936.3011, -2533.3640, 28.3027, 172.7872),
                    vector4(913.9525, -2536.0122, 28.3046, 114.5838),
                    vector4(906.6035, -2536.7014, 28.3030, 175.2926)
                }
            }
        },
        routes = {
            {
                completionTime = {
                    fast = 240,   -- in seconds
                    normal = 300, -- in seconds
                    slow = 360,   -- in seconds
                },
                locations = {
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(849.9610, -3097.4348, 4.9008),
                        rotation = vector3(0.0, 0.0, 330.6230),
                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(-1169.3057, -2024.9520, 12.1605),
                        rotation = vector3(0.0, 0.0, 258.5997),
                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(-316.7225, -2624.8428, 5.0004),
                        rotation = vector3(0.0, 0.0, 316.1633),
                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(-1203.3571, -1799.3903, 2.9086),
                        rotation = vector3(0.0, 0.0, 86.0805)
                    },
                    {
                        model = `bkr_prop_crate_set_01a`,
                        coords = vector3(-1570.1373, -431.5620, 36.9655),
                        rotation = vector3(0.0, 0.0, 166.0524)
                    },
                }
            }
            -- more points
            -- [2] == { ... }
        },
        rewardPickups = {
            {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(-1159.5952, -506.1568, 34.0082),
                rotation = vector3(0.0, 0.0, 0.0),

            },
            {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(-263.5103, 176.1009, 78.1248),
                rotation = vector3(0.0, 0.0, 71.7138),

            },
            {
                model = `bkr_prop_crate_set_01a`,
                coords = vector3(-18.7251, -210.3844, 45.1770),
                rotation = vector3(0.0, 0.0, 251.3989),

            }
        }
    },
    -- sandy = {...}
}

Config.Commands = {
    testRun = {
        enabled = false,
        command = "testdrugdrops",
        description = locale('TEST_COMMAND_DESC'),
    },
}
