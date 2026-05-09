Config = {}

Config.CaptureSpeed = MainConfig.Debug and 1 or 0.1 -- speed at which the point is captured when one team is present (1 = 10 seconds)
Config.ContestSpeed = MainConfig.Debug and 1 or 0.1 -- speed at which the point is contested when both teams are present
Config.PrepTime = MainConfig.Debug and 15 or 300 -- time in seconds to get to the starting point
Config.NeededToWin = 4 -- number of points needed to win

Config.TimeForWin = MainConfig.Debug and 25 or 120 -- time in seconds to win if you are in the lead

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
        -- TEMPORARY LOCATION FOR TESTING
        vector4(-453.3623, -1056.7443, 51.4761, 77.5718)
        -- vector4(576.4706, 2790.6145, 41.2009, 7.5290),
        -- vector4(-1798.7573, 3104.3516, 31.8418, 64.8927),
        -- vector4(-1663.8402, 158.3043, 60.7490, 112.3142)
    }
}

Config.Items = {
    controlCrate = 'point_control_crate',
}

Config.Mission = {
    name = "point-control",
    timeout = 60,
    cooldown = 60,
    label = locale("POINT_CONTROL_MISSION_LABEL"),
    desc = locale("POINT_CONTROL_MISSION_DESC"),
    minimalPlayersToStart = 1,
    policeRequired = 0,
    concurrentMissions = 1,

    startItem = "point_control_contract",

    loot = {
        rolls = 16,
        table = {
            COMMON = {
                {name = "moneyband",      min = 15, max = 35},
                {name = "lockpick",       min = 1,  max = 3},
                {name = "glass",          min = 2,  max = 4},
                {name = "metalscrap",     min = 3,  max = 5},
                {name = "plastic",        min = 2,  max = 5},
                {name = "rubber",         min = 2,  max = 4},
                {name = "screwdriverset", min = 1,  max = 2},
            },
            RARE = {
                {name = "electronickit",    min = 1,  max = 2},
                {name = "advancedlockpick", min = 1,  max = 1},
                {name = "moneyband",        min = 25, max = 40},
                {name = "repairkit",        min = 1,  max = 1},
                {name = "radio",            min = 1,  max = 1},
                {name = "copper",           min = 1,  max = 3},
                {name = "iron",             min = 1,  max = 3},
                {name = "steel",            min = 1,  max = 3},

            },
            EPIC = {
                {name = "cryptostick",  min = 1, max = 1},
                {name = "trojan_usb",   min = 1, max = 1},
                {name = "goldchain",    min = 1, max = 1},
                {name = "armour",       min = 1, max = 2},
                {name = "binoculars",   min = 1, max = 1},
            },
            LEGENDARY = {
                {name = "goldbar",   min = 1,  max = 1},
                {name = "moneyband", min = 50, max = 80},
                {name = "diamond",   min = 1,  max = 1},
            },
        }
    }
}

Config.TestingCommand = {
    enabled = true,
    command = "startrace",
    restricted = 'group.owner'
}

Config.CRATE_MODEL = `bkr_prop_crate_set_01a`

Config.Locations = {
    default = {
        start = {
            {
                coords = vector3(-2296.496, 373.492, 174.602),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(-2289.02, 373.05, 173.48),
                    rot = vec3(0.00, 0.00, 358.00),
                }
            },
            {
                coords = vector3(2492.539, -384.487, 94.000),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(2488.14, -388.94, 92.62),
                    rot = vec3(0.00, 0.00, 53.00),
                }
            }
        },

        points = {
            {
                coords = vector3(-1530.916, 82.213, 56.715),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(-1531.79, 79.39, 55.63),
                    rot = vec3(-0.00, 0.05, 76.64),
                }
            },
            {
                coords = vector3(-1205.433, -1795.399, 3.909),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(-1205.08, -1792.78, 2.79),
                    rot = vec3(0.00, 0.00, 78.00),
                }
            },
            {
                coords = vector3(1415.872, -731.974, 67.398),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(1415.59, -732.43, 66.31),
                    rot = vec3(0.00, 0.43, 181.30),
                }
            },
            {
                coords = vector3(-279.492, -1917.233, 29.946),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(-278.04, -1919.16, 28.83),
                    rot = vec3(0.00, 0.00, 138.00),
                }
            },
            {
                coords = vector3(490.128, -1332.490, 29.331),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(492.52, -1338.45, 28.19),
                    rot = vec3(0.00, 0.04, -2.31),
                }
            },
            {
                coords = vector3(1730.529, -1619.056, 112.431),

                crate = {
                    model = `bkr_prop_crate_set_01a`,

                    pos = vec3(1734.83, -1603.62, 111.39),
                    rot = vec3(-0.00, 0.00, 67.65),
                }
            }
        }
    },
    north = {
        start = {
            {
                coords = vector3(418.463, 6463.898, 28.820), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(418.463, 6463.898, 28.820),
                    rot = vec3(0.00, 0.00, 129.571),
                }
            },
            {
                coords = vector3(3162.052, 5347.326, 20.481), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(3162.052, 5347.326, 20.481),
                    rot = vec3(0.00, 0.00, 231.874),
                }
            }
        },
        points = {
            {
                coords = vector3(-486.376, 6130.359, 13.926), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-486.376, 6130.359, 13.926),
                    rot = vec3(0.00, 0.00, 113.309),
                }
            },
            {
                coords = vector3(-481.973, 5516.245, 80.001), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-481.973, 5516.245, 80.001),
                    rot = vec3(0.00, 0.00, 7.528),
                }
            },
            {
                coords = vector3(-414.232, 4009.986, 80.930), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-414.232, 4009.986, 80.930 ),
                    rot = vec3(0.00, 0.00, 282.357),
                }
            },
            {
                coords = vector3(1345.887, 3352.854, 38.211), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(1345.887, 3352.854, 38.211),
                    rot = vec3(0.00, 0.00, 248.442),
                }
            },
            {
                coords = vector3(2765.312, 4238.126, 48.479), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(2765.312, 4238.126, 48.479),
                    rot = vec3(0.00, 0.00, 34.594),
                }
            },
            {
                coords = vector3(2684.894, 4891.018, 34.249), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(2684.894, 4891.018, 34.249),
                    rot = vec3(0.00, 0.00, 225.583),
                }
            }
        }
    },
    mid = {
        start = {
            {
                coords = vector3(-3068.666, 150.034, 10.977), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-3068.666, 150.034, 10.977),
                    rot = vec3(0.00, 0.00, 86.208),
                }
            },
            {
                coords = vector3(1918.177, 680.422, 189.593), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(1918.177, 680.422, 189.593),
                    rot = vec3(0.00, 0.00, 285.323),
                }
            }
        },
        points = {
            {
                coords = vector3(-3157.644, 1129.310, 20.846), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-3157.644, 1129.310, 20.846),
                    rot = vec3(0.00, 0.00, 27.704),
                }
            },
            {
                coords = vector3(-2579.991, 1919.459, 167.275), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-2579.991, 1919.459, 167.275),
                    rot = vec3(0.00, 0.00, 37.086),
                }
            },
            {
                coords = vector3(-1092.037, 2712.897, 19.035), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-1092.037, 2712.897, 19.035),
                    rot = vec3(0.00, 0.00, 254.059),
                }
            },
            {
                coords = vector3(-127.439, 2796.921, 53.108), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(-127.439, 2796.921, 53.108),
                    rot = vec3(0.00, 0.00, 14.726),
                }
            },
            {
                coords = vector3(858.859, 2115.231, 52.243), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(858.859, 2115.231, 52.243),
                    rot = vec3(0.00, 0.00, 292.889),
                }
            },
            {
                coords = vector3(1489.193, 1150.127, 114.331), 
                crate = {
                    model = `bkr_prop_crate_set_01a`,
                    pos = vec3(1489.193, 1150.127, 114.331),
                    rot = vec3(0.00, 0.00, 3.157),
                }
            }
        }
    },
}

Config.ConvertPed = {
    model = `g_m_m_armgoon_01`,
    requiredItem = "point_control_plans",
    coords = vector4(1136.054, -789.389, 57.600 - 1.0, 148.343),
    itemPoints = {
        weed_brick_1a = 5,
        weed_brick_1b = 5,
        weed_brick_2a = 5,
        weed_brick_2b = 5,
        weed_brick_2c = 5,
        meth_brick_medium = 5,
        meth_brick_perfect = 5,
        meth_brick_good = 5,
        meth_brick_dirty = 5,
        meth_brick_death = 5,
        cocaine_mission_brick = 20,
        crystal_meth_mission_brick = 20,
        mdma_brick = 20,
    },
    requiredPoints = 160,
    rewardItem = "point_control_contract"
}


Config.TurnOnMission = {
    requiredItem = "point_control_map",
    target = {
        coords = vec3(1276.0, -1710.5, 55.0),
        size = vec3(1.5, 1.5, 13.5),
        rotation = 300.0,
    },
}

Config.MapColours = {
    weave = {
        blip = 26,
        radius = 18
    },
    apex = {
        blip = 17,
        radius = 47
    },
    neutral = {
        blip = 55,
        radius = 62
    }
}