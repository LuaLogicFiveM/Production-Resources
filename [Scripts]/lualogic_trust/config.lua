return {
    core = {
        debug = 'info', -- info/error/warning/false debug prints in console
        framework = 'esx', -- auto/esx/ox/qbox/qb/nd/custom
        database = 'ox', -- auto/ox/mysql/custom
        notification = 'ox', -- auto/framework/ox/okok/wasabi/custom
        auto_sql = true, -- automatically intert sql table into database
    },
    cache = {
        identifier = 'license', -- framework/discord/license/license2/ip/steam/fivem
        names = true, -- saves most recent name in database to view in menu 
        txadmin = true, -- saves at every txadmin scheduled restart
        interval = "* */1 * * *", -- every hour example
    },
    transfer = {
        enabled = false, -- enable/disable the transfering data feature from other trust systems
        system = 'old', -- old = badgers free trust system | new = badgers paid trust system
        command = 'transfer_vehicles',
    },
    modules = {
        menu = {
            enabled = true, -- enable/disable the menus as a whole (maybe you want commands only? idk, i would suggest using the menu.)
            command = 'vehicles',
            permission = false, -- ace perm or false for everyone
        },
        system = {
            enabled = true, -- toggle the system options in menu.
            admin = {
                enabled = true, -- enable/disable admin options as a whole, can be changed live through console command.
                command_disable = 'trust_admin_disable', -- only usable through console
                menu = {
                    enabled = true, -- enable/disable admin menu as a whole, can be changed live through console command.
                    permission = false, -- ace perm or false for everyone
                }
            },
            states = {
                enabled = true,
                permission = '1413587611179683890', -- ace perm or false for everyone
            },
            missing = {
                enabled = true, -- enable/disable copy missing vehicle spawn codes of owned/trusted vehicles
                type = 'owned', -- owned/trusted/all which vehicles to copy the spawn code of that are missing
                command = 'missing_vehicles',
                permission = false, -- ace perm or false for everyone
            },
            search = {
                enabled = true, -- enable/disable the search options as a whole
                name = {
                    enabled = true, -- enable/disable player name search to view their data, can be changed live through admin panel.
                    command = 'search_name',
                    permission = '1413587611179683890', -- ace perm or false for everyone
                },
                vehicle = {
                    enabled = true, -- enable/disable vehicle model search to view who has access, can be changed live through admin panel.
                    command = 'search_vehicle',
                    permission = false, -- ace perm or false for everyone
                },
                identifier = {
                    enabled = true, -- enable/disable player name search to view their data, can be changed live through admin panel.
                    command = 'search_identifier',
                    permission = '1413587611179683890', -- ace perm or false for everyone
                }
            },
        },
        owner = {
            enabled = true, -- enable/disable the owned vehicles in menu.
            spawn = {
                enabled = true,
                permission = false, -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            set = {
                enabled = true,-- default state of setting ownership, can be changed live through admin panel.
                command = 'owner_set',
                permission = '1413587733095514132', -- ace perm or false for everyone
                limits = {
                    enabled = true,
                    count = 20, -- default limit for owned vehicles
                    exempt = {
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
                permission = false, -- ace perm or false for everyone
                admin = { -- admin menu system/command to remove ownership from a player
                    enabled = true,
                    command = 'owner_remove_admin',
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
                permission = '1413588031285362749', -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            transfer = {
                enabled = true,
                command = 'owner_transfer',
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
                permission = '1413588090911461457', -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            },
            give = {
                enabled = true,
                command = 'trust_give',
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
                admin = { -- admin menu system/command to remove trust from a player even if the admin doesnt have ownership
                    enabled = true,
                    command = 'trust_remove_admin',
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
                permission = '1413588178794844160', -- ace perm or false for everyone
            },
            trade = {
                enabled = true,
                command = 'trust_trade',
                permission = '1413588193231507579', -- ace perm or false for everyone
                locations = {
                    enabled = false,
                    zones = { }
                }
            }
        }
    },
}