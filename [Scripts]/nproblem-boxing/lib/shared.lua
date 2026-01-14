NMConfig = {}

NMConfig['Framework'] = 'esx' -- Specifies the framework type: 'esx' or 'qb'. Here, 'qb' is selected.

NMConfig['SQL'] = { -- Specifies which SQL resource to use. The one marked as true will be used.
    ['oxmysql'] = true,
    ['ghmattimysql'] = false,
}

NMConfig['Target'] = {
    targetType = 'ox', -- Select target system: 'qb' or 'ox'
}

NMConfig['General'] = {

    currentNotifyResource = 'ox', -- Selects the notification system to be used. Options: 'ox' (ox_lib), 'native' (default GTA notifications), 'qb' (QBCore built-in), or 'okok' (okokNotification).

    logWebhook = '', -- Discord webhook URL for sending logs related to fight club actions.

    currentLocaleLanguage = 'en', -- Language for the locale system. Currently, only English ('en') is supported.

    playerCanChangeOdds = true, -- Allow fight club owners to adjust the betting odds for their matches. These changes are detailed recorded through the discord webhook.

    getYourCidCommand = 'getid', -- Command that allows players to print their own Character ID (CID) to F8 console. Usable by everyone.

    startMatchCommand = 'boxingstart', -- Command that allows authorized users to view and start scheduled matches.

    isAllowedToSeeActiveBets = true, -- If true, players can view and withdraw their bets from upcoming matches. If false, the “past bets” section will be hidden and bets cannot be withdrawn before the match.

    reviveDeadBoxerAfterMatch = true, -- If true, the losing boxer will be automatically revived after the match ends. If false, they remain unconscious.

    roundDuration = 60, -- Duration of each round in seconds. (e.g., 180 = 3 minutes)

    payWinPoolAutomatically = true, -- Automatically transfers the win pool amount from the club’s account to the winning player after a match ends.

    defaultPunchDamage = 0.5, -- Base punch damage dealt in the ring, without any enhancements like doping.

    takeBetBack = 25, -- Percentage deducted from the bet amount when a player chooses to withdraw their bet before the match starts. (0–100)

    -- Moderation
    createClubCommand = 'boxingcreate', -- Admin-only command to create a new boxing club.

    openClubListCommand = 'boxingclubs', -- Admin-only command to view and edit details of all registered boxing clubs.

    adminCharIDs = { -- List of character IDs allowed to use admin commands related to boxing club management.
        'char1:2115fa2798864acfda3811076702979c3d8cd594'
    },

    -- Knockouts
    MinRoll = 1,              -- Minimum RNG value for knockout logic.
    MaxRoll = 500,            -- Maximum RNG value for knockout logic.
    KOValue = 2,              -- Knockout occurs if RNG result matches this value, depending on the comparison method below.
    Comparison = "equal",     -- Method of comparing RNG result with KOValue. Options: "less", "greater", or "equal".
    knockoutScreenEffect = 'MinigameTransitionOut', -- Visual screen effect that plays when a knockout occurs. (See: https://wiki.rage.mp/wiki/Screen_FX)

    -- Doping
    dopingItemName = 'boxerdoping', -- The item name used for doping boosts.

    dopingEffectTime = '24hr', -- Duration of the doping effect. Format: [number][unit] (e.g., '24hr', '15min', '2d').

    dopingCheckJobs = {'sheriff', 'sahp', 'ems'}, -- Jobs allowed to perform doping checks on fighters.

    dopingCheckItem = 'boxerDopingCheck', -- The item used by authorized jobs to conduct a doping check.

    DopingDamageIncrease = 0.1, -- Additional punch damage added when the boxer is under doping effect.

    -- Stamina
    gymStatsEffectsToStamina = true, -- If true, stats gained from training at the gym will affect stamina in the ring.

    staminaRecoveryRate = 0.1, -- Rate at which stamina regenerates per 0,1 second under normal conditions.

    dopingStaminaRecoveryRate = 0.2, -- Faster stamina regeneration rate when under the effect of doping.

    recoveryThreshold = 1500, -- Time in milliseconds after which stamina starts to recover if no punches are thrown. (e.g., 1500 = 1.5 seconds)

    staminaLossAmountNormal = 15, -- On each punch, a random stamina value between 1 and this number will be deducted (when not using doping).

    staminaLossAmountDoping = 10, -- On each punch, a random stamina value between 1 and this number will be deducted (when using doping).

    -- Animations
    selectFavAnimCommand = 'boxinganim', -- Command that allows players to select their favorite boxing animations.

    Animations = {
        ['WinAnimations'] = {
            {
                label = "Victory Dance",
                description = "A celebratory boxing dance inspired by a beach nightclub atmosphere.",
                dict = "anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@",
                idle = "med_right_down",
            },
            {
                label = "Fanatic Cheer",
                description = "Celebrate with the energy and excitement of a true fan!",
                dict = "rcmfanatic1celebrate",
                idle = "celebrate",
            },
            {
                label = "Angry Clap",
                description = "A slow, sarcastic clap with a touch of attitude.",
                dict = "anim@arena@celeb@flat@solo@no_props@",
                idle = "angry_clap_a_player_a",
            },
            {
                label = "Push Up End",
                description = "Finishes a push-up routine and rests in position.",
                dict = "amb@world_human_push_ups@male@idle_a",
                idle = "idle_d",
            },
            {
                label = "Victory Slide",
                description = "A stylish ground slide as a form of celebration.",
                dict = "anim@arena@celeb@flat@solo@no_props@",
                idle = "slide_a_player_a",
            },
        },
        ['ReadyAnimations'] = {
            {
                label = "Combat Idle",
                description = "A basic unarmed idle stance ready for combat.",
                dict = "melee@unarmed@streamed_core_fps",
                idle = "idle"
            },
            {
                label = "Intro Pose A",
                description = "A traditional unarmed pose when entering a match.",
                dict = "anim@deathmatch_intros@unarmed",
                idle = "intro_male_unarmed_e",
            },
            {
                label = "Intro Pose B",
                description = "An alternative version of the classic intro pose.",
                dict = "anim@deathmatch_intros@unarmed",
                idle = "intro_male_unarmed_e",
            },
            {
                label = "Knuckle Crunch",
                description = "An intimidating pose featuring a knuckle cracking animation.",
                dict = "anim@mp_player_intcelebrationmale@knuckle_crunch",
                idle = "knuckle_crunch",
            },
        }
    }
}

NMConfig['GYM'] = {
    isAllowedToUseGymMachines = true, -- If set to false, all gym functionalities will be completely disabled in the script.
    useSkillBar = true, -- If true, skill bars will be used during gym exercises to simulate timing-based interactions.

    Benches = {
        {
            targetCoord = vector3(-1207.161, -1560.77, 4),
            plyCoord = vector3(-1206.9447, -1561.1111, 3.1063),
            plyHeading = 218.0
        },
        {
            targetCoord = vector3(-1200.577, -1562.077, 4),
            plyCoord = vector3(-1200.6911, -1562.18, 3.1063),
            plyHeading = 126.4908
        },
        {
            targetCoord = vector3(-1198.056, -1568.316, 4),
            plyCoord = vector3(-1197.78, -1568.1, 3.1063),
            plyHeading = 304.49
        },
        {
            targetCoord = vector3(-1201.322, -1574.971, 4),
            plyCoord = vector3(-1201.2, -1575.15, 3.1063),
            plyHeading = 218.0
        }
    },

    Cardios = {
        {
            targetCoord = vector3(-1209.3685, -1562.9207, 4),
            plyCoord = vector3(-1209.3424, -1562.9297, 4.1328),
            plyHeading = 124.9282
        },
        {
            targetCoord = vector3(-1208.1075, -1564.7186, 4),
            plyCoord = vector3(-1208.1075, -1564.7186, 4.1328),
            plyHeading = 123.3604
        },
        {
            targetCoord = vector3(-1196.1495, -1570.3285, 4),
            plyCoord = vector3(-1196.1278, -1570.3947, 4.1328),
            plyHeading = 304.7292
        },
        {
            targetCoord = vector3(-1194.8844, -1572.1680, 4),
            plyCoord = vector3(-1194.8844, -1572.1680, 4.1328),
            plyHeading = 308.8647
        },
    },

    Pullups = {
        {
            targetCoord = vector3(-1204.9618, -1563.9692, 4.6),
            plyCoord = vector3(-1204.7554, -1564.3160, 3.6085),
            plyHeading = 34.3727
        },
        {
            targetCoord = vector3(-1199.74, -1571.52, 4.6),
            plyCoord = vector3(-1199.8259, -1571.3915, 3.6085),
            plyHeading = 34.3727
        },
        {
            targetCoord = vector3(-1225.21, -1600.26, 4.5),
            plyCoord = vector3(-1225.21, -1600.36, 3.16),
            plyHeading = 266.72
        },
        {
            targetCoord = vector3(-1240.3, -1599.5, 4.16),
            plyCoord = vector3(-1240.35, -1599.4, 3.1),
            plyHeading = 215.6
        },
        {
            targetCoord = vector3(-1244.85, -1613.88, 4.14),
            plyCoord = vector3(-1244.85, -1613.99, 3.1),
            plyHeading = 214.89
        },
    },


    Situps = {
        vector3(-1231.24, -1609.28, 3.09),
        vector3(-1236.18, -1604.18, 3.04),
        vector3(-1244.62, -1595.84, 3.1),
        vector3(-1248.87, -1602.96, 3.09),
        vector3(-1254.97, -1608.03, 3.09),
        vector3(-1252.24, -1615.61, 3.09)
    },

    OneHandCurl = {
        vector3(-1210.02, -1558.45, 4.5),
        vector3(-1203.26, -1573.62, 4.5),
        vector3(-1197.61, -1564.64, 4.5)
    },

    BarbellCurl = {
        vector3(-1203.005, -1565.04, 4.5),
        vector3(-1210.743, -1561.23, 4.5),
        vector3(-1196.7904, -1573.1229, 4.5),
        vector3(-1198.748, -1574.898, 4.5)
    }, 

    Pushups = {
        vector3(-1239.92, -1604.11, 3.04),
        vector3(-1238.95, -1591.7, 3.11),
        vector3(-1247.6, -1587.06, 3.09),
        vector3(-1254.48, -1590.17, 3.09),
        vector3(-1260.58, -1594.21, 3.1),
        vector3(-1261.31, -1603.43, 3.06)
    }, 
}