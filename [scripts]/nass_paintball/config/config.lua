Config = {}
Config.locale = Locales["en"] -- en | es | fr | de | it | pt | ru| zh

Config.defaultSettings = {
    ["maxPlayers"] = 15,
    ["mode"] = "FFA", -- Teams/FFA
    ["numberOfTeams"] = 2,
    ["weapon"] = "nass_paintball_gun",--"nass_paintball_gun",
    ["wager"] = 500,
    ["lives"] = 3, -- If changed, must be in Config.lives
    ["map"] = "Rust",-- If changed, must be in Config.maps
    ["allowSpectate"] = true, -- Config.spectate.enabled must be true
    ["timeLimit"] = 10, --In Minutes/If changed, must be in Config.timeLimits
    ["privateLobby"] = false,
    ["maxScore"] = 10,-- If changed, must be in Config.scores
}

Config.leaveLobby = {
    enabled = true,
    commandName = "paintball_leave",
}

Config.setupLocations = {
    {
        coords = vector4(-266.3095, -2017.1084, 30.1456, 233.2725),
        blip = {
            enabled = true,
            label = Config.locale["blip_name"],
            sprite = 160,
            scale = 0.65,
            shortrange = true,
        },
        ped = {
            enabled = true,
            model = 'cs_siemonyetarian',
            frozen = true,
            blockNonTemp = true,
            invincible = true,
        }
    },
    --[[{
        coords = vector4(-282.1599, -2031.2577, 30.1457, 297.5033),
        blip = {
            enabled = true,
            label = Config.locale["blip_name"],
            sprite = 160,
            scale = 0.65,
            shortrange = true,
        },
        ped = {
            enabled = true,
            model = 'cs_siemonyetarian',
            frozen = true,
            blockNonTemp = true,
            invincible = true,
        }
    },]]
}
Config.defaultHealth = 100 --Personally would leave this(Cannot be less than 2)

Config.wagering = true -- Setting this to false will disable bettings
Config.checkCash = true --Checks player cash before creating/joining lobby
Config.wagerAccount = "cash" --cash | bank

Config.useRPName = false --Will use RP name for lobby list
Config.infiniteStamina = false --If maps are large and players are running out of stamina, would recommend this

Config.loadMaps = false --If you want to allow players to pre-load maps from the menu
Config.waitForRespawn = true -- Add a timer to respawn after a player death
Config.respawnTime = 5 -- In Seconds
Config.spawnProtection = true -- Give player spawn protection when they respawn
Config.spawnProtectionTimer = 5 --Timer in seconds for length of spawn protection
Config.setTransparent = true -- Set the player semi-transparent to indicate that they have spawn protection currently on | Config.SpawnProtection must be true
Config.resetHealth = true -- Reset player health when they get a kill

Config.mapSpawning = {
    enabled = true, -- Wait for waitTime specified below before spawning the players in the arena.
    waitTime = 4500, -- Time in seconds
}

Config.infniteAmmo = false -- If you are having issues with your anticheat, set this to false
Config.ammoAmount = 200 -- Default ammount of bullets given with the weapon

--Enable this if you would like your radio to add players on a team to a radio channel.
Config.radio = {
    enabled = true,
}

Config.target = {-- Supports "ox_target" | "qtarget" | "qb-target" natively
    enabled = true, --Setting to false will use normal helptext prompt
    size = {x=3.0,y=3.0,z=3.0},
    distance = 3,
    icon = "fa-solid fa-gun",
    label = Config.locale["target_label"],
}

Config.leaderboard = {
    enabled = true,
    name = "paintball_leaderboard",
    keybind = "z",
}

-- Time limits for the dropdown menu in the lobby creation UI
Config.timeLimits = { 
    --Time in minutes
    3,
    5,
    10,
    15,
    20,
    "Unlimited",
}

Config.lives = {
    "1",
    "3",
    "5",
    "10",
}

-- Max Scores for CTF, Dog Tags, and Team Deathmatch
Config.scores = {
    "3",
    "5",
    "10",
    "15",
    "20",
    "30",
    "50",
    "100",
    "150",
    "250",
}

Config.spectate = {
    enabled = true,
    controls = { -- https://docs.fivem.net/docs/game-references/controls/#controls
        cancel = {194, "INPUT_FRONTEND_RRIGHT"}, --Backspace
        left = {189, "INPUT_FRONTEND_LEFT"}, -- Left Arrow
        right = {190, "INPUT_FRONTEND_RIGHT"}, -- Right Arrow
    }
}

Config.animationDicts = {
    [1] = {dict = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5"},
    [2] = {dict = "misscommon@response", anim = "bring_it_on"},
    [3] = {dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center"},
    [4] = {dict = "anim@mp_player_intcelebrationfemale@shadow_boxing" , anim = "shadow_boxing"},
    [5] = {dict = "anim@mp_player_intcelebrationfemale@knuckle_crunch", anim = "knuckle_crunch"},
    [6] = {dict = "anim@mp_player_intcelebrationfemale@thumbs_up", anim = "thumbs_up"},
    [7] = {dict = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b_enter"},
    [8] = {dict = "move_clown@p_m_two_idles@", anim = "fidget_adjust_nose"},
    [9] = {dict = "anim@mp_player_intcelebrationfemale@cut_throat", anim = "cut_throat"},
    [10] = {dict = "anim@mp_player_intcelebrationfemale@finger", anim = "finger"},
    [11] = {dict = "anim@arena@celeb@flat@paired@no_props@", anim = "laugh_a_player_a"},
    [12] = {dict = "anim@mp_player_intcelebrationfemale@mind_blown", anim = "mind_blown"},
    [13] = {dict = "anim@mp_player_intcelebrationfemale@raining_cash", anim = "raining_cash"},
    [14] = {dict = "anim@mp_player_intcelebrationfemale@raise_the_roof", anim = "raise_the_roof"},
    [15] = {dict = "anim@mp_player_intcelebrationfemale@shush", anim = "shush"},
    [16] = {dict = "anim@mp_player_intcelebrationfemale@thumb_on_ears", anim = "thumb_on_ears"},
    [17] = {dict = "anim@mp_player_intcelebrationfemale@uncle_disco", anim = "uncle_disco"},
    [18] = {dict = "anim@mp_player_intcelebrationfemale@wave", anim = "wave"},
    [19] = {dict = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"},
    [20] = {dict = "anim@mp_player_intcelebrationmale@blow_kiss", anim = "blow_kiss"},
    [21] = {dict = "anim@mp_player_intcelebrationmale@chicken_taunt", anim = "chicken_taunt"},
    [22] = {dict = "anim@mp_player_intcelebrationmale@karate_chops", anim = "karate_chops"},
    [23] = {dict = "anim@mp_player_intcelebrationmale@slow_clap", anim = "slow_clap"},
    [24] = {dict = "anim@mp_player_intcelebrationmale@wank", anim = "wave"},
    [25] = {dict = "anim@mp_player_intcelebrationpaired@m_m_fist_bump", anim = "fist_bump_left"},
    [26] = {dict = "anim@mp_player_intcelebrationpaired@f_f_sarcastic", anim = "sarcastic_left"},
}

Config.deathAnimation = {
    dict = "mini@cpr@char_b@cpr_def",
    anim = "cpr_pumpchest_idle",
}


Config.checkPermFunction = false -- Added by request. Turn this on to use the permCheck function in the server/unlocked.lua