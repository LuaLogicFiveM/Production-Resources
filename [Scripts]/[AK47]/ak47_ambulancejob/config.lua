Config = {}
Config.Locale = 'en'
Config.Debug = false

Config.DisableDeathScreen = false --enable if you want to use custom death screen
Config.DeathScreenKillerName = true -- Set to false to hide Killer Name on the death screen

Config.DisableFadeAfterRevive = false

Config.JobNames = { ['ems'] = true }

Config.UseDiscordLog = false -- if log is not working in your country, you can disable here

Config.MaxHealth = 200
Config.BleedOutTime = 60 * 1 --seconds
Config.BrainDeadTime = 60 * 20 --seconds
Config.ForceRespawnWait = 60 * 2 --seconds
Config.AutoRespawnAfterBrainDead = false

Config.CrawlEnabled = false --crawl when down
Config.MuteDeadPlayer = true
Config.KeepDeadPlayerInsideVehicle = true

Config.SetCrutchAfterCheckin = true -- require ak47_crutch
Config.CrutchTimer = 5 -- 5 minutes

Config.Blips = {
    {label = 'Route 68 Hospital', pos = vector3(1102.0262, 2724.5833, 38.7120), sprite = 61, size = 1.0, color = 2},
    {label = 'Paleto Hospital', pos = vector3(-256.2788, 6331.0859, 32.4272), sprite = 61, size = 1.0, color = 2},
}

Config.DisableForceRespawnWhenOnlineEms = 3

Config.CombatLogAutoRespawn = false
Config.CombatLogPunishment = { --after relog
    RemoveMoney         = false,
    RemoveBlackMoney    = false,
    RemoveItems         = true,
    RemoveWeapons       = false,
    IgnoreItemList = {
        money       = true,
        black_money = true,
        id_card       = true,
        driver_license       = true,
        weapons_license       = true,
        medical_license       = true,
        boating_license       = true,
        hunting_license       = true,
        fishing_license       = true,
        commercial_license       = true,
        WEAPON_STUNGUN       = true,
        taser_cartridge = true,
        WEAPON_FLASHLIGHT = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_P90 = true,
        WEAPON_SIG516 = true,
        WEAPON_LBRS = true,
        WEAPON_KS1 = true,
        WEAPON_M870 = true,
        WEAPON_HK417 = true,
        WEAPON_FM1_BENELLIM4 = true,
        WEAPON_FBIARB = true,
        WEAPON_GLOCK20 = true,
        WEAPON_GLOCK19GEN4 = true,
        WEAPON_SIG_SAUCER = true,
        WEAPON_ANTIDOTE = true,
        WEAPON_PEPPERSPRAY = true,
        WEAPON_BOLAWRAP = true,
        WEAPON_PROLASER4 = true,
        handcuffs = true,
        tintmeter = true,
        tracking_bracelet = true,
        tablet = true,
        alcohol_tester = true,
        armour = true,
        dashcam = true,
        bodycam = true,
    },
    IgnoreLoadoutList = { },
}

Config.ForceRespawnPunishment = { --hold E to respawn
    RemoveMoney         = false,
    RemoveBlackMoney    = false,
    RemoveItems         = true,
    RemoveWeapons       = false,
    IgnoreItemList = {
        money       = true,
        black_money = true,
        id_card       = true,
        driver_license       = true,
        weapons_license       = true,
        medical_license       = true,
        boating_license       = true,
        hunting_license       = true,
        fishing_license       = true,
        commercial_license       = true,
        WEAPON_STUNGUN       = true,
        taser_cartridge = true,
        WEAPON_FLASHLIGHT = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_P90 = true,
        WEAPON_SIG516 = true,
        WEAPON_LBRS = true,
        WEAPON_KS1 = true,
        WEAPON_M870 = true,
        WEAPON_HK417 = true,
        WEAPON_FM1_BENELLIM4 = true,
        WEAPON_FBIARB = true,
        WEAPON_GLOCK20 = true,
        WEAPON_GLOCK19GEN4 = true,
        WEAPON_SIG_SAUCER = true,
        WEAPON_ANTIDOTE = true,
        WEAPON_PEPPERSPRAY = true,
        WEAPON_BOLAWRAP = true,
        WEAPON_PROLASER4 = true,
        handcuffs = true,
        tintmeter = true,
        tracking_bracelet = true,
        tablet = true,
        alcohol_tester = true,
        armour = true,
        dashcam = true,
        bodycam = true,
    },
    IgnoreLoadoutList = { },
}

Config.AutoRespawnPunishment = { --after brain dead
    RemoveMoney         = false,
    RemoveBlackMoney    = false,
    RemoveItems         = true,
    RemoveWeapons       = false,
    IgnoreItemList = {
        money       = true,
        black_money = true,
        id_card       = true,
        driver_license       = true,
        weapons_license       = true,
        medical_license       = true,
        boating_license       = true,
        hunting_license       = true,
        fishing_license       = true,
        commercial_license       = true,
        WEAPON_STUNGUN       = true,
        taser_cartridge = true,
        WEAPON_FLASHLIGHT = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_P90 = true,
        WEAPON_SIG516 = true,
        WEAPON_LBRS = true,
        WEAPON_KS1 = true,
        WEAPON_M870 = true,
        WEAPON_HK417 = true,
        WEAPON_FM1_BENELLIM4 = true,
        WEAPON_FBIARB = true,
        WEAPON_GLOCK20 = true,
        WEAPON_GLOCK19GEN4 = true,
        WEAPON_SIG_SAUCER = true,
        WEAPON_ANTIDOTE = true,
        WEAPON_PEPPERSPRAY = true,
        WEAPON_BOLAWRAP = true,
        WEAPON_PROLASER4 = true,
        handcuffs = true,
        tintmeter = true,
        tracking_bracelet = true,
        tablet = true,
        alcohol_tester = true,
        armour = true,
        dashcam = true,
        bodycam = true,
    },
    IgnoreLoadoutList = { },
}

Config.RespawnOptions = {
    {
        Name = 'Route 68 Hospital',
        Description = 'Transport Fee: $250 | Medical Fee: $250',
        TotalCost = 500,
        Transport = false,
        Vehicle = 'amrfreightliner',
        Offset = vector3(0.0, -3.0, 0.4), --attach offset
        Gps = vector3(1091.3740, 2728.2476, 38.6723),
        TransportTimeOut = 60 * 15,
    },
    {
        Name = 'Paleto Hospital',
        Description = 'Transport Fee: $250 | Medical Fee: $250',
        TotalCost = 500,
        Transport = false,
        Vehicle = 'amrfreightliner',
        Offset = vector3(0.0, -3.0, 0.4), --attach offset
        Gps = vector3(-241.7159, 6336.9185, 32.3441),
        TransportTimeOut = 60 * 15,
    },
}

Config.PlayForTask = {
    revive      = math.random(200, 500),
    cpr         = math.random(200, 500),
    cpradvanced = math.random(200, 500),
    bandage     = math.random(100, 150),
    neckbrace   = math.random(100, 150),
    bodybandage = math.random(100, 150),
    armbrace    = math.random(100, 150),
    legbrace    = math.random(100, 150),
    morphine30  = math.random(100, 150),
    saline      = math.random(100, 150),
    firstaid    = math.random(100, 150),
    medikit     = math.random(100, 150),
}

Config.IgnoreAnims = { --death & down animation will be skiped if player using animations below
    {dir = 'missfinale_c2mcs_1', anim = 'fin_c2_mcs_1_camman'}, --carry
    {dir = 'move_injured_ground', anim = 'front_loop'}, --crawl
}


