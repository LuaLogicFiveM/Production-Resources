Config = {}
for c, d in pairs(Cfg) do
    Config[c] = d
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            IMPORTANT                             │
-- └──────────────────────────────────────────────────────────────────┘

Config.AutoInsertSQL = true -- If true, automatically inserts the necessary SQL tables. Set to false if you've already done this.
Config.Debug = false -- Set to true to enable debug prints (for troubleshooting and development purposes).
Config.EnableTestCommand = false -- (/dispatchtest) Set to true to enable the test command (for troubleshooting and development purposes).

Config.AllowedJobs = { --Jobs who are allowed to use the dispatch.
    -- Jobs are grouped together.
    -- Jobs within the same group can:
    --  • See each other on the dispatch UI
    --  • See each other on the pause menu and minimap blips

    {'sheriff', 'sahp', 'ems'}, -- Police & Ambulance share one dispatch group
    {'dot'},            -- Mechanic-only dispatch group
    -- {'job1', 'job2'},      -- Add more job groups as needed
}

Config.Perms = {
    Dispatcher = { --The permissions table for those who can be a dispatcher, based off jobs and job grades.
        ['sahp'] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        ['sheriff'] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        ['ems'] = { 0, 1, 2, 3, 4, 5 },
        ['dot'] = { 0, 1, 2, 3, 4, 5 },
    },

    Planner = { --The permissions table for those who can use the planner, based off jobs and job grades.
        ['sahp'] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        ['sheriff'] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
        ['ems'] = { 0, 1, 2, 3, 4, 5 },
    },
}

Config.AntiCheat = {
    ENABLE = true, --Enable or Disable all of the built in anti cheat features?
    
    BannedWords = { --This feature will kick and send a message in your discord if any banned words are detected in a notification or /911 call.
        ENABLE = true, --Enable or Disable this feature?
        discord_tag_everyone = false, --Tag @ everyone who has access to your discord webhook channel?
        banned_words = {'fuck', 'shit', 'bitch', 'cunt', 'nig'} --A table of banned words.
    },

    EventSpam = { --This feature will detect events being spammed by lua injectors or mod menus.
        ENABLE = true, --Enable or Disable this feature?
        discord_tag_everyone = false, --Tag @ everyone who has access to your discord webhook channel?
        threshold = { --If x amount of 'events' are triggered within x amount of 'time' this player will be flagged for modding.
            events = 10, --(amount of events)
            time = 3 --(in seconds)
        }
    }
}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                             MAIN                                 │
-- └──────────────────────────────────────────────────────────────────┘

Config.Dispatcher = {
    ENABLE = true, --Do you want to use the build in dispatcher system? (this is optional)
    notify_activity = true, --Do you want players to be notified when a dispatcher comes online/goes offline?
    VoipResource = 'pmavoice' ---[ 'toko' / 'mumble' / 'pmavoice' / 'other' ] Choose your servers voip resource.
}

Config.Ping = {
    ENABLE = true, --Do you want to allow players who have access to the dispatch to ping their location to other players of the same job?
    command = 'dispatchping', --The chat command.
    key = '', --The key press. You can choose other keys here - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/.
    cooldown = 10, --(in seconds) This cooldown is to prevent a player spamming pings.
}

Config.PanicButton = {
    ENABLE = true, --Do you want to allow dispatch users to use the built-in panic button?
    command = 'panic', --The chat command.
    key = '', --The key press. This is not used by default. You can choose keys here - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/.
    job_table = {'sheriff', 'sahp', 'ems'}, --A list of jobs who can use the panic button. (every job in this list will be notified if a panic button is pressed).
    cooldown = 10, --(in seconds) This cooldown is to prevent a player spamming the panic button.
    play_sound_in_distance = true --Do you want the panic button sound to play to all nearby players?
}

Config.GpsTracker = { -- Used for kidnapping scenarios, if the gps tracker item is removed from a players inventory they will no longer have access to use the dispatch features and their player blips will be hidden from others view.
    ENABLE = false, -- Enable or disable the GPS tracker feature.
    item_name = 'tablet', -- The name of the inventory item.
    item_check_timer = 10, -- Time in seconds to check for the item in the inventory.
    AllowedJobs = { -- Jobs that are allowed to use the GPS tracker features.
        'sheriff',
        'sahp',
        'ems'
    }
}

Config.UpdateDistanceToCall = { -- This will update the distance from the player to the call location automatically every x amount of seconds.
    ENABLE = true, --Do you want to use auto update distance?
    time = 2 --(in seconds) How often the distance should be updated.
}

Config.AutoUpdatePlayerCoordinates = { -- This will update players coordinates on the UI map automatically every x amount of seconds. Only updates when a player is using the ui.
    ENABLE = true, --Do you want to use auto update player blips?
    time = 5, --(in seconds) How often the blips should be updated.
}

Config.FollowPlayer = { -- In the main dispatch UI, you can to follow a players movements.
    ENABLE = true, --Do you want to use the follow player feature?
    time = 500, --(in ms) How often the coordinates for the 1 player you are following should be updated. Lower is smoother but uses more resources. Max recommended is 1000.
}

Config.WaypointTracking = { --Waypoint tracking feature on the mini-map, this will allow you to track a player by automatically setting a waypoint to them.
    update_timer = 1, --(in seconds) How often the waypoint should be updated.
    auto_cancel_distance = 30, --(in meters) If you are within x distance the tracking will be canceled.
}

Config.HeatMap = { -- This will show the most active areas on the map (where most calls are made).
    ENABLE = true, --Do you want to use the heat map feature?
    limit_calls = 100, --The amount of calls to store in the heat map.
}

Config.AfkTimer = {  -- This will set a player's status to AFK if they are not moving for a certain amount of time.
    ENABLE = true, --Do you want to use the AFK timer?
    time = 5, --(in minutes) How often the player should be checked for AFK status.
}

Config.NotifyStatusChange = true --Do you want players to be notified when another player changes their status? (eg., from Available to Unavailable).
Config.DispatchCallExpiryTime = 60 --(in minutes) How long a call should last before it expires.

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              BLIPS                               │
-- └──────────────────────────────────────────────────────────────────┘

Config.PauseMenuBlips = {
    ENABLE = true, --Do you want to use the built in player blips (on the pause menu & mini-map)?
    data_update_timer = 5, --(in seconds) How many seconds should the blip data from the server side be sent to the client side to be updated?
    blip_type = 'auto', --You can choose 3 different methods for displaying the player blips.
    --'static' = Players will all have the same standard player blip.
    --'auto' = Blips will change automatically depending on the vehicle type. (CAN CAUSE HIGH RESOURCE USAGE!).
    flashing_blips = true, --Do you want blips to flash when a player's vehicle has it's emergancy lights enabled?
    bundle_blips = true, --Do you want to bundle the blips together so they do not spam the pause menu legend?
    radiochannel_on_blips = true, --Do you want a players radio chanel to be displayed on blips?
    minimize_longdistance_blips = true, --Do you want long distance blips to be minimized(smaller size) on the mini-map instead of them being hidden?
    
    blip_sprites = { --These are the blip sprites (icons). More blips can be found here - https://docs.fivem.net/docs/game-references/blips.
        ['static']       = 1,
        ['foot']         = 1,
        ['car']          = 56,
        ['motorcycle']   = 226,
        ['helicopter']   = 43,
        ['boat']         = 427,
    },

    blip_colours = { --If you add more jobs, you need to add them here too. More colours can be found at the bottom of this page - https://docs.fivem.net/docs/game-references/blips.
        --pausemenu_blip_colour: The colour of the player blips on the gta mini-map and pause menu. The 1st one is the default colour and the 2nd one is the flashing colour.
        ['sahp']      = {3, 1},
        ['sheriff']     = {3, 1},
        ['ems']   = {1, 0},
        ['dot']    = {2, 0},
    }
}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                        JOB CALL COMMANDS                         │
-- └──────────────────────────────────────────────────────────────────┘

Config.JobCallCommands = { 
    ENABLE = true,--Do you want to use the job chat commands eg., /911 to send a notification to the police.

    --label: The job display label.
    --command: The chat command.
    --job_table: The jobs who can see the calls. (you can add multiple).
    Civilian_Commands = {
        { command = '911',          job_label = 'Police',       job_table = {'sahp', 'sheriff'} },
        { command = '911ems',       job_label = 'Ambulance',    job_table = {'ems'} },
        { command = 'dot',       job_label = 'DOT',    job_table = {'dot'} },
    },

    JobReply_Command = 'reply' --The chat command for the jobs above^ to reply to incomming calls.
}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          KEYS & COMMANDS                         │
-- └──────────────────────────────────────────────────────────────────┘

Config.small_ui = {
    ENABLE = true, --Do you want to enable the small UI?
    command = 'dispatchsmall', --The chat command.
    key = 'u' --The key press. You can choose other keys here - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/.
}

Config.large_ui = {
    ENABLE = true, --Do you want to enable the large map UI?
    command = 'dispatchlarge',
    key = 'l'
}

Config.respond = {
    ENABLE = true, --Do you want to enable the units responding feature?
    command = 'dispatchrespond',
    key = 'g'
}

Config.small_ui_left = {
    ENABLE = true, --Do you want to enable the small UI left scroll?
    command = 'dispatchscrollleft',
    key = 'left'
}

Config.small_ui_right = {
    ENABLE = true, --Do you want to enable the small UI right scroll?
    command = 'dispatchscrollright',
    key = 'right'
}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          POLICE ALERTS                           │
-- └──────────────────────────────────────────────────────────────────┘

Config.PoliceAlerts = {
    ENABLE = false, --Do you want to use the built in police alerts?
    police_jobs = {'sheriff', 'sahp'}, --The jobs who will be notified from these police alerts.
    whitelisted_jobs = {'sheriff', 'sahp', 'ems', }, --These jobs will NOT trigger these police alerts.
    add_bolos = false, --(requires cd_radar) Do you want to add a bolo for the vehicle that was used in the crime?

    WitnessPeds = {
        ENABLE = true, --Do you want npc/peds to call the police on crimes?
        radius = 50, -- The distance a witness ped must be from the player to call the police.
        time_to_kill_caller = 10, -- (in seconds) You have x amount of seconds to kill/injure the ped(s) to stop them calling the police.
        max_callers = 1, -- The maximum amount of witness peds that can call the police at once.
        BlacklistedPedModels = { `s_m_y_valet_01`}, -- A list of ped models that will NOT call the police.
        NoSnitchingZones = { -- Zones that DO NOT trigger witness peds to call the police.
            [1] = {coords = vector3(30.01, -1847.60, 24.51), radius = 150}, --grove street 1.
            [2] = {coords = vector3(-187.22, -1627.70, 33.61), radius = 100}, --grove street 2.
            [3] = {coords = vector3(333.38, -2037.74, 21.07), radius = 80}, --vagos barrio.
            --[4] = {coords = vector3(0, 0, 0), radius = 20},
        },
    },

    CarCrash = {
        ENABLE = true, -- Do you major car crashes to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
        minimum_crash_speed = 50, --(in mph) Only count crashes at or above this speed.
    },

    CarJacking = {
        ENABLE = true, -- Do you want carjackings to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
    },

    Explosion = {
        ENABLE = true, -- Do you want explosions to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
        max_distance_from_player = 200.0, -- Maximum radius from player for an explosion to trigger an alert.
        WhitelistedZones = { -- Zones that DO NOT trigger "explosion" alerts.
            [1] = {coords = vector3(0, 0, 0), radius = 20},
            --[2] = {coords = vector3(0, 0, 0), radius = 20},
        },
    },

    GunPointCarJacking = {
        ENABLE = true, -- Do you want gunpoint carjackings to alert police?
        random_chance = 100, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 45, -- (in seconds) Prevents spam.
        max_distance = 20, -- (in meters) Maximum distance from player to vehicle to trigger alert.
    },

    GunShots = {
        ENABLE = true, -- Do you want gunshots to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.

        BurstShots = { -- Burst rule: require X shots in Y ms to al,ert the police.
            min_shots_in_burst = 3, -- Minimum shots in burst to trigger alert.
            burst_gap_ms = 700, -- Maximum time between shots to still count as same burst.
            burst_settle_ms = 2000, -- Time to wait after burst before sending alert (allows for final shots to be included).
        },

        WhitelistedZones = { -- Zones that DO NOT trigger "gunshot" alerts.
            [1] = {coords = vector3(13.98, -1098.05, 29.8), radius = 20}, -- Legion gunrange.
            [2] = {coords = vector3(821.09, -2163.46, 78.67), radius = 20}, -- Cypress Flats gunrange.
            --[3] = {coords = vector3(0, 0, 0), radius = 10},
        },
        WhitelistedWeapons = { `WEAPON_FLARE`, `WEAPON_FLAREGUN`, `WEAPON_FIREEXTINGUISHER`, `WEAPON_PETROLCAN`, `WEAPON_STUNGUN`, `WEAPON_MUSKET`, `WEAPON_SNOWBALL`, `WEAPON_ACIDPACKAGE`  }, -- A list of weapon hashes that will NOT trigger gunshot alerts.
    },

    MeleeFight = {
        ENABLE = true, -- Do you want melee fights to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
    },

    RecklessDriving = {
        ENABLE = true, -- Do you want reckless driving to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
        min_speed = 30, --(in mph) Minimum speed the vehicle must be going to trigger an alert.
    },

    --[[SPEEDTRAP CONFIG]]--
    SpeedTrap = {
        ENABLE = true, --Do you want speeding vehicles to alert police?
        cooldown = 30, --(in seconds) Prevents spam.
        check_owner_for_fine = true, --Only fine players if they own the vehicle? (if enabled, players in stolen cars will not be fined).
        speed_unit = 'mph', --Choose between 'mph' or 'kmh' for speed limit checks and notifications.
        enable_blip = true, --Do you want to show blips for the speed trap locations?

        Locations = {
            --coords: The location of the speed trap.
            --distance: The distance a player must be from the 'coords^' to alert the speed trap. 
            --speed_limit: The minimum speed to alert the speed trap (in MPH). 
            --fine_amount: The amount the player will be fined (set to 0 to not fine a player).
            [1] = {coords = vector3(1051.42, 331.11, 84.00), distance = 9, speed_limit = 150, fine_amount = 500 }, --LS Freeway.
            [2] = {coords = vector3(544.43, -373.24, 33.14), distance = 9, speed_limit = 150, fine_amount = 5000 }, --Into Legion.
            [3] = {coords = vector3(-2612.10, 2940.81, 16.67), distance = 15, speed_limit = 150, fine_amount = 1000 }, --Zancuda.
            [4] = {coords = vector3(287.94, -517.44, 42.89), distance = 15, speed_limit = 100, fine_amount = 500 }, --Pillbox.
            [5] = {coords = vector3(2792.73, 4407.68, 48.44), distance = 24, speed_limit = 150, fine_amount = 1000 }, --Sandy Freeway.
            [6] = {coords = vector3(577.11, -1028.32, 37.07), distance = 15, speed_limit = 100, fine_amount = 1000 }, --Mission Row.
            [7] = {coords = vector3(114.83, -797.89, 30.97), distance = 15, speed_limit = 100, fine_amount = 2000 }, --Legion Square.
            [8] = {coords = vector3(74.33, -163.30, 54.67), distance = 15, speed_limit = 100, fine_amount = 4000 }, --Pink Cage.
            [9] = {coords = vector3(28.19, -971.05, 28.96), distance = 15, speed_limit = 100, fine_amount = 1000 }, --PDM.
            --[10] = {coords = vector3(0, 0, 0), distance = 15, speed_limit = 50, fine_amount = 1000 },
        }
    },

    VehicleAlarm = {
        ENABLE = true, -- Enable vehicle alarm alerts?
        random_chance = 50, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
    },

    VehicleAssault = {
        ENABLE = true, -- Do you want vehicle assaults to alert police?
        random_chance = 75, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
        min_speed_mph = 20, --(in mph) Minimum speed the vehicle must be going to trigger an alert.
    },

    WeaponDrawn = {
        ENABLE = true, -- Do you want weapon drawn to alert police?
        random_chance = 50, -- (in percentage) The random chance to call the police. 100 = always call, 0 = never call.
        cooldown = 30, -- (in seconds) Prevents spam.
        WhitelistedWeapons = { `WEAPON_UNARMED`, `WEAPON_FLASHLIGHT`, `WEAPON_FIREEXTINGUISHER`, `WEAPON_PETROLCAN`, `WEAPON_HAZARDCAN`, `WEAPON_STUNGUN`, `WEAPON_FLARE`, `WEAPON_FLAREGUN`, `WEAPON_NIGHTSTICK`, `WEAPON_POOLCUE`, `WEAPON_GOLFCLUB`  },
    }
}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                             OTHER                                │
-- └──────────────────────────────────────────────────────────────────┘

function GetMultiJob(job)
    for cd = 1, #Config.AllowedJobs do
        for c, d in pairs(Config.AllowedJobs[cd]) do
            if d == job then
                return Config.AllowedJobs[cd]
            end
        end
    end
    return false
end

function SortDisplayName(callsign, name)
    if callsign and callsign ~= '' then
        return string.format('[%s] %s', callsign, name)
    else
        return name
    end
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          AUTO DETECT                             │
-- └──────────────────────────────────────────────────────────────────┘

if Config.AntiCheat.ENABLE == false then
    Config.AntiCheat.BannedWords.ENABLE = false
    Config.AntiCheat.BannedWords.EventSpam = false
end

-----DO NOT TOUCH ANYTHING ABOVE THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----