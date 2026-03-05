Config = {}
Config.Debug = false

Config.Target = false
Config.CustomTargetResource = "" -- if you have a custom target resource name set it here

-- Help us translate!
--  You can contribute by improving existing translations or adding translations for new languages
--  https://localazy.com/p/mxc
Config.Language = "en"

Config.Intimidation = {
    label = "intimidation_bar", -- Edit Config.Translations
    addEveryS = 0.05, -- (%) add every 1 second to the intimidation (lower to increase the time it takes to fill up)
    animationCooldown = 0 -- (ms) cooldown between "pain" animations and sounds (this will not modify the logic behavior)
}

Config.Bars = {
    -- Offsets for text and bar (intimidation + shutters health)
    -- Text offset is relative to the bar (so 0.0 is the default position, - is left and + is right)

    -- values: 0.0 to 1.0
    -- x axis: left to right
    -- y axis: top to bottom
    barOffset = vec2(0.85, 0.938),
    textOffset = vec2(0.0, 0.0)
}

Config.Interactions = {
    ["hack_panel_vault"] = {
        label = "hack_vault_target", -- Edit Config.Translations
        icon = "fas fa-laptop",

        distance = 2.0
    },

    ["trolly_loot"] = {
        label = "trolly_loot_target", -- Edit Config.Translations
        icon = "fas fa-sack-dollar",

        distance = 2.0
    },

    -- For key pickup interaction
    ["key_pickup"] = {
        label = "key_pickup_target", -- Edit Config.Translations
        icon = "fas fa-key",

        distance = 2.0
    }
}

-- Uncomment only if you want to ovverride the default translations provided by localazy
Config.Translations = {
    --["shutters_health_bar"] = "SHUTTERS HEALTH",
    --["intimidation_bar"] = "INTIMIDATION",

    --["key_required"] = "A key is required to open this door",
    --["open_antechamber_door"] = "Press {E} to unlock the antechamber door",

    -- If no targets are found (ox_target or qb-target) then this will be used
    --["key_pickup_vanilla"] = "Press {E} to pickup the antechamber keys",
    --["key_pickup_target"] = "Pickup Key",

    -- If no targets are found (ox_target or qb-target) then this will be used
    --["hack_vault_vanilla"] = "Press {E} to hack the vault",
    --["hack_vault_target"] = "Hack",

    --["hack_vault_cant_start"] = "~r~You don't have the required item to hack the vault.",
    
    --["on_key_pickup"] = "Key for the ~y~vault antechamber~w~ collected",

    --["bomb_required"] = "A bomb is required to open this door",

    --["robbery_started_notify"] = "An alarm went off at a bank!",
    --["robbery_cant_start_notify"] = "~r~You cannot start a robbery here.",
    --["robbery_cooldown_notify"] = "~r~The bank robbery is in cooldown.",

    --["shutters_toggling"] = "Toggling shutters in the nearest bank.",
    --["shutters_no_near_bank"] = "~r~There is no bank near you.",

    --["trolly_begin_looting"] = "Press {E} to begin looting the trolly",
    --["trolly_repeatedly_press"] = "Repeatedly press ~INPUT_SCRIPT_RDOWN~ to grab faster",
}

Config.ResetTime = 10 -- (minutes) Time for which the bank, when being robbed must remain empty (no players inside it) to be resetted
Config.Cooldown = 30 -- (minutes) Time between each robbery (this will start after the reset time)

Config.MinCops = 0 -- Minimum cops in order to start the robbery (edit the config_functions.lua for more info)

-- This will require: ESX or QBCore
Config.BombItem = "bomb_big" 
Config.VaultHackingItem = "" -- Set to an empty to string to disable it, its the item required to start the vault hacking interaction

Config.BagAfterHacking = 45 -- Set to nil to disable the bag persistance after the animation

Config.ShuttersManagement = {
    enabled = true,

    -- This will require: ESX or QBCore
    item = "screwdriver_bank", -- Set to nil or an empty to string to disable it
    
    -- This will be a restricted command, so make sure to give ACE permissions to a group/identifier that can use it
    command = "shutters", -- Set to nil or an empty to string to disable it
    
    distance = 30.0,
}

-- The blip that will be created when someone robs the bank, as soon as the player approaches it will be automatically deleted; 
-- You can customize when and how it is triggered from the config_functions.lua file. 
Config.RobberyBlip = {
    name = "Bank Robbery",
    sprite = 586,
    color = 1,
    scale = 1.0,

    duration = 30000 -- If the player does not approach the blip after this time it will be eliminated, set to -1 to disable
}

Config.Banks = {
    -- Dont change the order
    --[[[1] = {
        type = "blaine_branche",
        interior = { -- Interior infos, used for offsets calculation
            pos = vec3(1702.620483, 3783.718994, 34.763325),
            rot = vec3(-0.000000, 0.000000, 33.999973)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(1697.2170, 3786.4980, 34.1345),
                    vec3(1695.7720, 3787.5842, 35.5373),
                    vec3(1703.3497, 3787.2090, 36.0351),
                    vec3(1700.2557, 3787.3711, 35.9956),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },]]
    [2] = {
        type = "blaine_branche",
        interior = {
            pos = vec3(1687.899292, 4853.409668, 42.100876),
            rot = vec3(0.000000, 0.000000, -82.00000)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(1694.5414, 4857.8970, 42.9374),
                    vec3(1692.4832, 4857.3105, 42.4911),
                    vec3(1692.1604, 4853.9512, 43.6367),
                    vec3(1690.6746, 4851.2715, 43.4203),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [3] = {
        type = "blaine_branche",
        interior = {
            pos = vec3(576.676208, 2674.623779, 41.880859),
            rot = vec3(0.000000, 0.000000, -172.000000)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(581.1383, 2668.2275, 42.5814),
                    vec3(580.5016, 2670.0251, 42.1442),
                    vec3(574.4494, 2671.8772, 43.0783),
                    vec3(577.1849, 2670.5120, 43.4273),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [4] = {
        type = "blaine_branche",
        interior = {
            pos = vec3(2554.959229, 407.952393, 108.481224),
            rot = vec3(0.000000, 0.000000, 89.000008)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(2548.0977, 404.4348, 109.3146),
                    vec3(2549.7883, 404.8145, 108.8830),
                    vec3(2552.5266, 410.5005, 109.8189),
                    vec3(2550.7751, 408.0982, 110.0416),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [5] = {
        type = "blaine_branche",
        interior = {
            pos = vec3(-3147.442139, 1133.893921, 20.750801),
            rot = vec3(0.000000, 0.000000, 65.810402)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(-3155.2610, 1133.5093, 21.4413),
                    vec3(-3153.3896, 1133.0834, 21.0276),
                    vec3(-3148.6270, 1137.2262, 22.0948),
                    vec3(-3151.2827, 1135.6768, 22.3722),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },

    -- Vanilla banks
    [6] = {
        type = "vanilla_fleecas",
        interior = {
            pos = vec3(-2962.591309, 478.238037, 14.766895),
            rot = vec3(0.000000, 0.000000, -92.457939)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(-2957.8767, 476.6254, 16.1616),
                    vec3(-2964.1606, 476.9272, 15.8754),
                    vec3(-2961.6742, 479.5033, 17.2320),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [7] = {
        type = "vanilla_fleecas",
        interior = {
            pos = vec3(-1216.761597, -333.000763, 36.850842),
            rot = vec3(0.000000, 0.000000, -153.136261)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(-1215.9502, -337.8992, 38.0980),
                    vec3(-1218.4000, -333.0513, 36.6492),
                    vec3(-1215.1915, -333.1597, 39.0273),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [8] = {
        type = "vanilla_fleecas",
        interior = {
            pos = vec3(-355.435852, -48.532600, 48.106384),
            rot = vec3(-0.000000, 0.000000, 160.859818)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(-358.4232, -52.4788, 49.3965),
                    vec3(-356.6274, -47.3894, 48.1332),
                    vec3(-354.3916, -49.8072, 50.1787),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [9] = {
        type = "vanilla_fleecas",
        interior = {
            pos = vec3(145.416824, -1039.276978, 28.437883),
            rot = vec3(-0.000000, 0.000000, 159.846176)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(142.3405, -1043.2736, 29.7464),
                    vec3(144.2142, -1038.1548, 28.3684),
                    vec3(146.4453, -1040.4027, 31.0356),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [10] = {
        type = "vanilla_fleecas",
        interior = {
            pos = vec3(309.746460, -277.644165, 53.234596),
            rot = vec3(-0.000000, 0.000000, 159.865967)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(306.4988, -281.3663, 54.4678),
                    vec3(310.2994, -274.8074, 53.2795),
                    vec3(310.6675, -278.9382, 55.2958),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
    [11] = {
        type = "vanilla_fleecas",
        interior = {
            pos = vec3(1179.744751, 2706.985107, 37.157841),
            rot = vec3(0.000000, 0.000000, 0.000000)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing

            keys = {
                enabled = true,

                spawnpoints = {
                    vec3(1181.4700, 2711.6165, 38.3248),
                    vec3(1171.7141, 2704.3491, 37.2119),
                    vec3(1173.0905, 2707.8040, 39.1713),
                }
            },

            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },

            vault_hacking = {
                enabled = true
            },

            -- This will require: ESX or QBCore
            bomb = {
                enabled = true
            },

            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    },
}

if GetResourceState("cfx-fm-fleeca-banks-v2") == "started" or GetResourceState("cfx-fm-fleeca-banks-v2") == "starting" then
    Config.Banks[6] = {
        type = "fm_fleeca_banks",
        interior = {
            pos = vec3(-2962.575928, 478.253510, 14.767796),
            rot = vec3(0.000000, 0.000000, -92.153816)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing
    
            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },
    
            vault_hacking = {
                enabled = true
            },
    
            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    }
    Config.Banks[7] = {
        type = "fm_fleeca_banks",
        interior = {
            pos = vec3(-1216.761597, -333.000763, 36.850842),
            rot = vec3(0.000000, 0.000000, -153.136261)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing
    
            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },
    
            vault_hacking = {
                enabled = true
            },
    
            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    }
    Config.Banks[8] = {
        type = "fm_fleeca_banks",
        interior = {
            pos = vec3(-355.435852, -48.532600, 48.106384),
            rot = vec3(-0.000000, 0.000000, 160.859818)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing
    
            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },
    
            vault_hacking = {
                enabled = true
            },
    
            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    }
    Config.Banks[9] = {
        type = "fm_fleeca_banks",
        interior = {
            pos = vec3(145.416824, -1039.276978, 28.437883),
            rot = vec3(-0.000000, 0.000000, 159.846176)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing
    
            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },
    
            vault_hacking = {
                enabled = true
            },
    
            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    }
    Config.Banks[10] = {
        type = "fm_fleeca_banks",
        interior = {
            pos = vec3(309.746460, -277.644165, 53.234596),
            rot = vec3(-0.000000, 0.000000, 159.865967)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing
    
            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },
    
            vault_hacking = {
                enabled = true
            },
    
            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    }
    Config.Banks[11] = {
        type = "fm_fleeca_banks",
        interior = {
            pos = vec3(1179.744751, 2706.985107, 37.157841),
            rot = vec3(0.000000, 0.000000, 0.000000)
        },
        config = {
            hostages = true, -- This also includes players having to manage hostages to keep the shutters from closing
    
            trollies = {
                enabled = true,
                amountPerBundle = {25, 50} -- [min, max] amount of money per single bundle
            },
    
            vault_hacking = {
                enabled = true
            },
    
            shutters_breaking = {
                enabled = true,
                hits = 100
            }
        }
    }
end

Config.BankTypes = {
    ["vanilla_fleecas"] = {
        coords =  vec3(-4.433463, 1.932738, 0),
        hostagesRoom = vec3(-3.553580, -1.278331, 0),

        insideDistance = 9.0,
        nearDistance = 40.0,

        In = function(self, bankId)

        end,
        Out = function(self, bankId)

        end,

        trollies = {
            {
                type = "cash",
                coords = vec4(-5.213802, 9.745816, 0.008445, 180.0),   
            },
            {
                type = "cash",
                coords = vec4(-7.768878, 9.745816, 0.008519, 180.0),   
            },
        },

        doors = {
            vault = {
                model = "v_ilev_gb_vauldr",

                closed = 90.000027,
                opened = 90.000027 + -89
            },
            prevault = {
                model = "mxc_bank_prop_fleecadoor",
                exploded = "mxc_bank_prop_fleecabrokendoor"
            },
            shutters = {
                models = {
                    frame = "mxc_bank_prop_fleecashutterframe",
                    main = "mxc_bank_prop_fleecashutter",
                },

                spawnOffsets = {
                    frame = vec3(-4.53064251, -3.23411417, 3.03984833),
                    main = vec3(-4.530681, -3.22333574, 3.03984833)
                },

                main = {
                    up = 3.07,
                    down = 0.03
                }
            },
        },

        peds = {
            {
                group = "GUARDS", 
                model = "s_m_m_armoured_01", 
                coords = vec4(-6.297279, -2.851790, 0.930272, 362.161039),
                weapons = {"WEAPON_PISTOL"},
                idleAnim = {'amb@world_human_stand_guard@male@base', 'base'}
            },
            {
                group = "GUARDS", 
                model = "s_m_m_armoured_01", 
                coords = vec4(-2.774246, -2.532683, 0.930028, 362.161039), 
                weapons = {"WEAPON_PISTOL"},
                idleAnim = {'amb@world_human_stand_guard@male@base', 'base'}
            },
            {
                model = "a_m_m_stlat_02", 
                coords = vec4(-4.566186, -0.450759, 0.930144, 367.245161), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_b", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_intro", 500},
                    {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop_underfire", 3000},
                idleAnim = {'rcmjosh1@impatient', 'idle_b'}
            },

            {
                model = "a_f_y_bevhills_01", 
                coords = vec4(-1.927018, -0.850759, 0.930144, 57.245161), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_d", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_intro", 300},
                    {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop_underfire", 2500},
                idleAnim = {'friends@fra@ig_1', 'impatient_idle_a'}
            },
            {
                model = "a_m_m_skater_01", 
                coords = vec4(-2.867592, -0.775887, 0.930144, 30.6181), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_h", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_intro", 1200},
                    {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop_underfire", 3000},
                idleAnim = {'friends@frf@ig_1', 'impatient_idle_c'}
            },
        }
    },
    ["fm_fleeca_banks"] = {
        coords =  vec3(-2.299532, 3.995014, 0.439083),
        hostagesRoom = vec3(-1.594554, 0.467259, 1.240799),

        hostagesDistance = 6.0,
        insideDistance = 9.0,
        nearDistance = 40.0,

        In = function(self, bankId)

        end,
        Out = function(self, bankId)

        end,

        trollies = {
            {
                type = "cash",
                coords = vec4(-1.449070, 9.794257, 0.070355, 177.8356),   
            },
            {
                type = "cash",
                coords = vec4(0.860582, 8.565495, 0.070354, 58.3546),   
            },
        },

        doors = {
            vault = {
                model = "fm_fleeca_vault_door",

                closed = 0,
                opened = 80
            },
            shutters = {
                models = {
                    frame = "mxc_bank_prop_fleecashutterframe",
                    main = "mxc_bank_prop_fleecashutter",
                },

                spawnOffsets = {
                    frame = vec3(-4.53064251, -3.23411417, 2.83984833),
                    main = vec3(-4.530681, -3.22333574, 3.03984833)
                },

                main = {
                    up = 2.33,
                    down = -0.45
                }
            },
        },

        peds = {
            {
                group = "GUARDS", 
                model = "s_m_m_armoured_01", 
                coords = vec4(-6.297279, -2.851790, 0.930272, 362.161039),
                weapons = {"WEAPON_PISTOL"},
                idleAnim = {'amb@world_human_stand_guard@male@base', 'base'}
            },
            {
                group = "GUARDS", 
                model = "s_m_m_armoured_01", 
                coords = vec4(-1.873680, -2.313929, 0.930272, 362.161039), 
                weapons = {"WEAPON_PISTOL"},
                idleAnim = {'amb@world_human_stand_guard@male@base', 'base'}
            },
            {
                model = "a_m_m_stlat_02", 
                coords = vec4(-1.561337, 2.534909, 0.930144, 367.245161), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_b", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_intro", 500},
                    {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop_underfire", 3000},
                idleAnim = {'rcmjosh1@impatient', 'idle_b'}
            },

            {
                model = "a_f_y_bevhills_01", 
                coords = vec4(0.355503, 0.011106, 0.930144, 57.245161), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_d", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_intro", 300},
                    {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop_underfire", 2500},
                idleAnim = {'friends@fra@ig_1', 'impatient_idle_a'}
            },
            {
                model = "a_m_m_skater_01", 
                coords = vec4(-4.615097, 1.428882, 0.930144, 10.6181), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_h", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_intro", 1200},
                    {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop_underfire", 3000},
                idleAnim = {'friends@frf@ig_1', 'impatient_idle_c'}
            },
        }
    },
    ["blaine_branche"] = {
        coords = vec3(0.71510130167007, 2.5376198291779, 0.091175079345703),
        hostagesRoom = vec3(-0.47828477621078, -0.71192497014999, 0.091175079345703),

        insideDistance = 7.0,
        nearDistance = 40.0,

        In = function(self, bankId)

        end,
        Out = function(self, bankId)

        end,

        trollies = {
            {
                type = "cash",
                coords = vec4(-1.4990739822388, 6.4408826828003, 0.086074829101562, 316.034527),   
            },
            {
                type = "cash",
                coords = vec4(-1.5764389038086, 8.0241022109985, 0.085975646972656, 228.885827),   
            },
        },

        doors = {
            vault = {
                model = "v_ilev_cbankvauldoor01",

                closed = 90.000027,
                opened = 90.000027 + 89
            },
            prevault = {
                model = "mxc_ltownbank_prop_door1a",
                exploded = "mxc_ltownbank_prop_brokendoor"
            },
            shutters = {
                models = {
                    main = "mxc_ltownbank_prop_mainshutter",
                    desk = "mxc_ltownbank_prop_deskshutter",
                },

                desk = {
                    up = 1.05,
                    down = -0.10
                },
                main = {
                    up = 2.57,
                    down = -0.08
                }
            },
        },

        peds = {
            {
                group = "GUARDS", 
                model = "s_m_m_armoured_01", 
                coords = vec4(-1.5275871753693, -3.8757789134979, 0.091175079345703, 4.394027),
                weapons = {"WEAPON_PISTOL"},
                idleAnim = {'amb@world_human_stand_guard@male@base', 'base'}
            },
            {
                group = "GUARDS", 
                model = "s_m_m_armoured_01", 
                coords = vec4(1.6376440525055, -3.9193077087402, 0.091175079345703, 4.394027), 
                weapons = {"WEAPON_PISTOL"},
                idleAnim = {'amb@world_human_stand_guard@male@base', 'base'}
            },
            {
                model = "a_m_m_stlat_02", 
                coords = vec4(-0.60773348808289, 0.01148048043251, 0.091175079345703, -0.057873), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_b", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_intro", 500},
                    {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop_underfire", 3000},
                idleAnim = {'rcmjosh1@impatient', 'idle_b'}
            },
            {
                model = "a_f_y_bevhills_01", 
                coords = vec4(-3.84219622612, -1.55890417099, 0.091175079345703, 243.596027), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_d", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_intro", 300},
                    {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop_underfire", 2500},
                idleAnim = {'friends@fra@ig_1', 'impatient_idle_a'}
            },
            {
                model = "a_m_m_skater_01", 
                coords = vec4(0.81586992740631, -1.2034821510315, 0.091175079345703, 24.040727), 
                anims = {
                    {"anim@heists@ornate_bank@hostages@intro", "intro_ped_h", 7000},
                    {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_intro", 1200},
                    {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop"}
                },
                underfire = {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop_underfire", 3000},
                idleAnim = {'friends@frf@ig_1', 'impatient_idle_c'}

            },
        }
    }
}