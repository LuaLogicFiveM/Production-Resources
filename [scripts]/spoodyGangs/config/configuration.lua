ESX = exports['es_extended']:getSharedObject()

Configuration = {
    Settings = {
        InventoryImgPath = 'nui://ox_inventory/web/images', --- IMPORTANT: This is for inventory images to work within the resource.
        Debug = false, --- Enable this for debug
        Framework = false, --- Enable this if you use a custom framework.

        Ranks = {
            Min = 3, --- Minimum amount of roles a gang can have
            Max = 10, --- Maximum amount of roles a gang could have
        },

        Strikes = {
            Enabled = true, --- Enable the strike system for certain restrictions?
            Max = 5, --- The max amount of strikes a gang can have at a time.

            Restrictions = {
                Withdraw = 3, --- If they have 3 strikes, they cannot withdraw
                Turfs = 4, --- If they have 4 strikes, they cannot participate in turfs
                Wars = 3, --- If they have 3 strikes, they cannot participate in gang wars
                Recruit = 4, --- If they have 4 strikes, they cannot recruit players 
            }
        },

        --- Color of the marker to start turfs
        StartMarker = {
            r = 255,
            g = 255,
            b = 255,
            a = 150,
        },

        --- The color of the turf zones
        TurfMarker = {
            r = 255,
            g = 0,
            b = 0,
            a = 70,
        },

        TurfBlip = {
            ID = 491, --- Blip ID
            Color = 1, --- Blip Color
            Scale = 0.75, --- Blip Scale
            Prefix = '~r~Turf War~w~:', --- The prefix that comes before the turf name (Example: Turf War: Grove St)
        },

        TurfSeason = true, --- Enable the option to create turf seasons?
        MaxTurfs = 3, --- The max amount of turfs a gang can start at a time
        DefaultManagement = vec3(-268.0753, -957.9583, 31.2231), --- The default management location for gang leaders
        ManagementBlip = true, --- Enable the management blip for gang members?

        TimerHUD = {
            Enabled = true, --- Enable the built in timer system?
            Style = 'countdown', ---@type 'countdown' | 'strip' | 'ring' | 'block' | 'float' | 'chip'
        },

        BlockHUD = {
            Enabled = true, --- Enable the built in block HUD when entering a gang's territory?
            Style = 'float', ---@type 'chip' | 'pill' | 'strip' | 'float' | 'tag' | 'mono'
        },

        Alerts = {
            Enabled = true, --- Enable the built in alerts system?
            Style = 'card', ---@type 'banner' | 'card' | 'chip' | 'float'

            Timers = {
                Turfs = 5, --- Turf alerts show for 10 seconds
            }
        }
    },

    Menu = {
        Enabled = true, --- Enable the built in gang admin menu?
        Command = 'gangadmin',
        Permission = 'gangs.setgang',
    },

    Hud = {
        Enabled = true, --- Enable the gang hud?
        Style = 'float', ---@type 'simple' | 'advanced' | 'tag' | 'chip' | 'split' | 'bar' | 'float' | 'capsule' | 'mono'
        Position = { x = 2, y = 94 },
        --- 2x92 = Bottom Right
        --- 1x2 = Top Right
    },

    Commands = {
        --- Set Gang Command
        SetGang = {
            Enabled = true,
            Command = 'setgang',
            Permission = 'gangs.setgang',
            Suggestion = "Set a player's gang & rank",
        },

        --- Gang creator command
        Creator = {
            Enabled = true,
            Command = 'gangcreator',
            Permission = 'gangs.create',
            Suggestion = 'Create and set a gang',
        },

        --- NEW: Gang tablet command allows gang managers to open their management portal anywhere
        GangTablet = {
            Enabled = true,
            Command = 'gangtablet',
            Suggestion = 'Open the gang management tablet'
        },

        --- Gang Admin faction drop command
        FDrops = {
            Enabled = true,
            Command = 'fdrop',
            Permission = 'gangs.fdrop',
            Suggestion = 'Send a faction drop to a gang',
        },

        --- Turf history command
        Turfs = {
            Enabled = true,
            Command = 'turfs',
            Suggestion = 'View active turfs and history',
        },

        --- Leave gang command
        LeaveGang = {
            Enabled = true,
            Command = 'leavegang',
            Suggestion = 'Leave your current gang',
        },

        --- Gang invitations
        Invites = {
            Enabled = true,
            Command = 'ganginvites',
            Suggestion = 'View your current gang invitations',
        },

        --- Gang leaderboard command
        Leaderboard = {
            Enabled = true,
            Command = 'ganglb',
            Suggestion = 'Open the gang leaderboard',
        },
    },

    FactionDrops = {
        Enabled = true,

        Pool = {
            [1] = {
                label = 'Example Tier',
                money = 50000, --- Add money into their treasury?

                --- List of items
                items = {
                    { item = 'item_name', count = 1 },
                    { item = 'item_name2', count = 2 }
                }
            },
        }
    },

    GangWars = {
        Enabled = true,

        Settings = {
            Requirements = { min = 1, max = 15 }, --- Minimum/Maximum amount of players each gang can have at the starting point of a gang war
            FriendlyFire = false, --- Allow gang members to hurt their own teamate? (suggested: false to prevent team killing)

            --- Draw System
            DisplayEnemies = true, --- Draw a symbol above enemies?
            DisplayDist = 17.5, --- The distance where the enemy/friendly must be to draw the marker above their head?
        },
    },

    --- Configure gang blocks here
    Blocks = {
        ['cbfw'] = {
            label = "CBFW's Neighborhood", --- The label of the gang block
            debug = false, --- Enable debug zone? (only devs should use this)

            coords = vec3(489.8100, -1754.8235, 28.4494),
            radius = 50.0,

            blip = {
                enabled = true, --- Enable the blip?
                blipId = 229, --- Blip ID
                color = 3, --- Color of the blip
                scale = 0.7, --- Scale of the blip
                drawRadius = true, --- Include the radius of the block?
            }
        }
    },

    --- Configure turf wars here
    Turfs = {
        --- Example turf war (If you don't want any turf wars, just make this table empty)
        ['Grove St'] = {
            coordinates = {
                start = vec3(104.6446, -1940.1545, 20.8037), --- The coordinates where players interact to start the turf.
                radius = 30.0, --- The radius of the turf

                --- The coordinates in which dead players, or forced-exited players will be teleported to.
                exitPoints = {
                    vec3(75.9291, -1915.6008, 21.2892),
                    vec3(70.7958, -1901.0531, 21.4784),
                    vec3(66.2661, -1914.7328, 21.4374),
                }
            },

            rewards = {
                money = 2500, --- Amount of money sent to the gang treasury if won

                --- Items added to the gang storage if won
                items = {
                    ['meth'] = 5,
                }
            },

            settings = {
                blip = true, --- Enable the blip on the map?

                timers = {
                    captureTimer = 120, --- 120 seconds to capture this turf.
                    countdown = 10, --- 10 seconds until the turf starts from the point of interaction. [num or false]
                    cooldown = 150, --- The cooldown timer before the turf can be started again
                },

                toggles = {
                    disarmOnEnd = true, --- Immediately disarm all players on turf end to prevent accidental killing?

                    --- 'remove' = Teleport the player and the vehicle outside of turf together
                    --- 'delete' = Completely delete the vehicle upon entering
                    vehicles = 'delete',
                },

                weapons = {
                    weaponWhitelist = false, --- Only allow these weapons to be used? (or false)
                    weaponBlacklist = { 'WEAPON_MINIGUN' }, --- Blacklist certain weapons from being used?
                },

                death = {
                    --- 'elimination' = The player fully dies
                    --- 'respawn' = The player is able to respawn outside of the turf after a set time
                    deathMode = 'respawn', ---@type 'respawn' | 'elimination'

                    --- Only edit these *if* deathmode is on 'respawn'
                    delay = 10, --- 10 seconds until they can automatically respawn? (if enabled)
                    maxRespawns = 2, --- the amount of respawns the player gets before fully dying
                },

                syphon = {
                    enabled = true, --- Enable syphon?
                    health = 50, --- Add 50 HP per elimination
                    armor = 20, --- Add 20 Armor points per elimination
                },
            }
        }
    },
}