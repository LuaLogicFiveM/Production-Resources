return {
    core = {
        debug = 'info', -- info/error/warning/false debug prints in console
        framework = 'esx', -- auto/esx/ox/qbox/qb/nd/custom
        discord = 'custom', -- auto/badger/custom
        database = 'ox', -- auto/ox/mysql/custom
        notification = 'ox', -- auto/framework/ox/okok/wasabi/custom
        auto_sql = true, -- automatically intert sql table into database
        retention = '90', -- automatically delete a players ownerrship and trust profile after this many days
    },
    cache = {
        identifier = 'framework', -- framework/discord/license/license2/ip/steam/fivem
        names = true, -- saves most recent name in database to view in menu 
        txadmin = true, -- saves at every txadmin scheduled restart
        interval = "* */1 * * *", -- every hour example
    },
    transfer = {
        enabled = false, -- enable/disable the transfering data feature from other trust systems
        system = 'old', -- old = badgers free trust system | new = badgers paid trust system
        command = 'transfer_vehicles',
    },
    zones = {
        enabled = true,
        locations = {
            { -- Roxwood
                debug = false,
                thickness = 500,
                permissions = {
                    enabled = false,
                    ['default'] = {
                        ['spawn'] = true,
                        ['preview'] = true,
                        ['trust_give'] = true,
                        ['trust_trade'] = true,
                        ['trust_remove'] = true,
                        ['owner_trade'] = true,
                        ['owner_transfer'] = true,
                        ['owner_remove'] = true,
                    }
                },
                points = {
                    vec(730.2391, 6776.8145, 80.0),
                    vec(1028.1685, 6867.9937, 80.0),
                    vec(-1190.8450, 9885.4629, 80.0),
                    vec(-3368.4697, 9084.2139, 80.0),
                    vec(-4445.4199, 9662.8848, 80.0),
                    vec(-6540.4502, 8413.9854, 80.0),
                    vec(-3863.2163, 5862.8364, 80.0),
                    vec(-3333.1313, 5811.3364, 80.0),
                    vec(-665.5718, 6586.6934, 80.0),
                    vec(-469.9490, 6557.2524, 80.0),
                    vec(-161.8474, 6903.6997, 80.0),
                    vec(-11.7041, 7502.3965, 80.0),
                },
                blip = {
                    enabled = true,
                    coords = vec3(-565.8764, 7352.7822, 50.0),
                    label = '[Trust Zone] - Roxwood',
                    sprite = 474,
                    scale = 1.0,
                    color = 30
                },
                radius = {
                    enabled = true,
                    opacity = 85,
                    radius = 600.0,
                    color = 30
                }
            }
        }
    },
    modules = {
        preview = {
            enabled = false,
            limit = 5,
            alpha = 150, -- set to false to disable
            freeze = true,
            lock = true,
            godmode = true,
        },
        menu = {
            enabled = true, -- enable/disable the menus as a whole (maybe you want commands only? idk, i would suggest using the menu.)
            command = 'vehicles',
            permissionType = 'group', -- group/discord
            permission = false, -- ace perm or false for everyone
        },
        system = {
            enabled = true, -- toggle the system options in menu.
            admin = {
                enabled = true, -- enable/disable admin options as a whole, can be changed live through console command.
                command_disable = 'trust_admin_disable', -- only usable through console
                menu = {
                    enabled = true, -- enable/disable admin menu as a whole, can be changed live through console command.
                    permissionType = 'group', -- group/discord
                    permission = false, -- ace perm or false for everyone
                }
            },
            states = {
                enabled = true,
                permissionType = 'group', -- group/discord
                permission = '1413587611179683890', -- ace perm or false for everyone
            },
            missing = {
                enabled = true, -- enable/disable copy missing vehicle spawn codes of owned/trusted vehicles
                type = 'owned', -- owned/trusted/all which vehicles to copy the spawn code of that are missing
                command = 'missing_vehicles',
                permissionType = 'group', -- group/discord
                permission = false, -- ace perm or false for everyone
            },
            search = {
                enabled = true, -- enable/disable the search options as a whole
                name = {
                    enabled = true, -- enable/disable player name search to view their data, can be changed live through admin panel.
                    command = 'search_name',
                    permissionType = 'discord', -- group/discord
                    permission = '1413587611179683890', -- ace perm or false for everyone
                },
                vehicle = {
                    enabled = true, -- enable/disable vehicle model search to view who has access, can be changed live through admin panel.
                    command = 'search_vehicle',
                    permissionType = 'group', -- group/discord
                    permission = false, -- ace perm or false for everyone
                },
                identifier = {
                    enabled = true, -- enable/disable player name search to view their data, can be changed live through admin panel.
                    command = 'search_identifier',
                    permissionType = 'discord', -- group/discord
                    permission = '1413587611179683890', -- ace perm or false for everyone
                }
            },
        },
        owner = {
            enabled = true, -- enable/disable the owned vehicles in menu.
            spawn = {
                enabled = true,
                limit = 5, -- limit the amount of owned vehicles that can be spawned
                permissionType = 'group', -- group/discord
                permission = false, -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            set = {
                enabled = true,-- default state of setting ownership, can be changed live through admin panel.
                command = 'owner_set',
                permissionType = 'discord', -- group/discord
                permission = '1413587733095514132', -- ace perm or false for everyone
                limits = {
                    enabled = false,
                    count = 20, -- default limit for owned vehicles
                    whitelistType = '', -- group/discord/identifier
                    whitelist = {
                        [150] = '1261189800950628383', -- Emerald
                        [100] = '1249230974986747914', -- Diamond
                        [50] = '1249230929252057118', -- Platinum
                        [40] = '1249230896868102195', -- Gold
                        [30] = '1249230828622581873', -- Silver
                        [25] = '1249230750893473792', -- Bronze
                    }
                },
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            remove = {
                enabled = true, -- default state of deleting ownership, can be changed live through admin panel.
                owner = true, -- only owner can delete ownership from players, if false anyone that has access to the command can delete ownership of a vehicle. (Admin use only)
                command = 'owner_remove',
                permissionType = 'group', -- group/discord
                permission = false, -- ace perm or false for everyone
                admin = { -- admin menu system/command to remove ownership from a player
                    enabled = true,
                    command = 'owner_remove_admin',
                    permissionType = 'discord', -- group/discord
                    permission = '1413587797591199894', -- ace perm or false for everyone
                },
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            clear = {
                enabled = true, -- default state of clearing ownership, can be changed live through admin panel.
                command = 'owner_clear',
                permissionType = 'discord', -- group/discord
                permission = '1413588031285362749', -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            transfer = {
                enabled = false,
                command = 'owner_transfer',
                permissionType = 'group', -- group/discord
                permission = false, -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = {
                        {
                            coords = vec3(-741.9594, 5876.9243, 16.6307), -- 013
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 013 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 35.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(687.1113, 122.9281, 80.7689), -- 592
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 592 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 35.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-2028.7458, -505.7975, 12.2131), -- 685
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 685 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 30.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(2012.3130, 4593.3228, 41.3755), -- 111
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 111 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 30.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(2713.6323, 1354.2872, 24.4846), -- Chemical Plant
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = true,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 80.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(3543.8979, 3780.9490, 29.9480), -- Humane Labs
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = true,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-1652.6110, -900.0988, 8.6405), -- Pier
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = true,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 80.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-799.5960, -1295.7426, 4.9958), -- Marina
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = true,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 75.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(929.6118, -3169.9707, 5.9007), -- Docks
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = true,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(660.2947, 630.0790, 128.9108), -- Vinewood Bowl
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = true,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        }
                    }
                }
            },
            trade = {
                enabled = true,
                command = 'owner_trade',
                permissionType = 'group', -- group/discord
                permission = false, -- ace perm or false for everyone
                locations = {
                    enabled = true,
                    zones = {
                        {
                            coords = vec3(-741.9594, 5876.9243, 16.6307), -- 013
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 013 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 35.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(687.1113, 122.9281, 80.7689), -- 592
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 592 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 35.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-2028.7458, -505.7975, 12.2131), -- 685
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 685 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 30.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(2012.3130, 4593.3228, 41.3755), -- 111
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 111 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 30.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(2713.6323, 1354.2872, 24.4846), -- Chemical Plant
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(3543.8979, 3780.9490, 29.9480), -- Humane Labs
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-1652.6110, -900.0988, 8.6405), -- Pier
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-799.5960, -1295.7426, 4.9958), -- Marina
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(929.6118, -3169.9707, 5.9007), -- Docks
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(660.2947, 630.0790, 128.9108), -- Vinewood Bowl
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        }
                    }
                }
            }
        },
        trust = {
            enabled = true, -- default state of the trust module, can be changed live through admin panel.
            spawn = {
                enabled = true,
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            set = {
                enabled = true,-- default state of setting trust, can be changed live through admin panel.
                command = 'trust_set',
                permissionType = 'discord', -- group/discord
                permission = '1413588090911461457', -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            give = {
                enabled = true,
                command = 'trust_give',
                permissionType = 'group', -- group/discord
                permission = false, -- ace perm or false for everyone
                locations = {
                    enabled = true,
                    zones = {
                        {
                            coords = vec3(-741.9594, 5876.9243, 16.6307), -- 013
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 013 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 35.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(687.1113, 122.9281, 80.7689), -- 592
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 592 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 35.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-2028.7458, -505.7975, 12.2131), -- 685
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 685 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 30.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(2012.3130, 4593.3228, 41.3755), -- 111
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'MLO 111 Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = true,
                                opacity = 85,
                                radius = 30.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(2713.6323, 1354.2872, 24.4846), -- Chemical Plant
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(3543.8979, 3780.9490, 29.9480), -- Humane Labs
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-1652.6110, -900.0988, 8.6405), -- Pier
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(-799.5960, -1295.7426, 4.9958), -- Marina
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(929.6118, -3169.9707, 5.9007), -- Docks
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        },
                        {
                            coords = vec3(660.2947, 630.0790, 128.9108), -- Vinewood Bowl
                            jobs = false, -- false or {['job_name'] = 0}
                            blip = {
                                enable = false,
                                label = 'Owner & Trust Zone',
                                sprite = 474,
                                scale = 0.5,
                                color = 30
                            },
                            radius = {
                                enable = false,
                                opacity = 85,
                                radius = 100.0,
                                color = 30
                            }
                        }
                    }
                }
            },
            remove = {
                enabled = true,
                command = 'trust_remove',
                permission = false, -- ace perm or false for everyone
                permissionType = 'group', -- group/discord
                admin = { -- admin menu system/command to remove trust from a player even if the admin doesnt have ownership
                    enabled = true,
                    command = 'trust_remove_admin',
                    permissionType = 'discord', -- group/discord
                    permission = '1413588118845657088', -- ace perm or false for everyone
                },
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            clear = { -- clears the vehicles trust and ownership
                enabled = true, -- default state of deleting ownership, can be changed live through admin panel.
                command = 'trust_clear',
                permissionType = 'discord', -- group/discord
                permission = '1413588178794844160', -- ace perm or false for everyone
            },
            trade = {
                enabled = true,
                command = 'trust_trade',
                permissionType = 'discord', -- group/discord
                permission = '1413588193231507579', -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            }
        }
    },
}