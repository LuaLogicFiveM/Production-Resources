Config = {}
Config.Locale = 'en'
Config.Debug = false

Config.DisableDeathScreen = false --enable if you want to use custom death screen
Config.DeathScreenKillerName = true -- Set to false to hide Killer Name on the death screen

Config.DisableFadeAfterRevive = false

Config.JobNames = {
    ['safd'] = true,
}

Config.UseDiscordLog = true -- if log is not working in your country, you can disable here

Config.MaxHealth = 200
Config.BleedOutTime = 60 * 4 --seconds
Config.BrainDeadTime = 60 * 10 --seconds
Config.ForceRespawnWait = 1 * 3 --seconds
Config.AutoRespawnAfterBrainDead = true

Config.CrawlEnabled = false --crawl when down
Config.MuteDeadPlayer = true
Config.KeepDeadPlayerInsideVehicle = true

Config.SetCrutchAfterCheckin = true -- require ak47_crutch
Config.CrutchTimer = 5 -- 5 minutes

Config.Blips = {
    {label = 'Pillbox Hill Hospital', pos = vector3(1758.9010, 3628.6184, 34.5832), sprite = 61, size = 1.0, color = 2},
    {label = 'Sandy Shores Hospital', pos = vector3(1758.9010, 3628.6184, 34.5832), sprite = 61, size = 1.0, color = 2},
    {label = 'Paleto Bay Hospital', pos = vector3(-256.5107, 6331.3242, 32.4273), sprite = 61, size = 1.0, color = 2},
}

Config.DisableForceRespawnWhenOnlineEms = 5

Config.CombatLogAutoRespawn = false
Config.CombatLogPunishment = { --after relog
    RemoveMoney         = false,
    RemoveBlackMoney    = false,
    RemoveItems         = true,
    RemoveWeapons       = true,
    IgnoreItemList = {
        money = true,
        black_money = true
    },
    IgnoreLoadoutList = {
        WEAPON_PROLASER4 = true,
        WEAPON_BOLAWRAP = true,
        WEAPON_PEPPERSPRAY = true,
        WEAPON_ANTIDOTE = true,
        WEAPON_FLASHBANG = true,
        WEAPON_AIRSOFTR870 = true,
        WEAPON_AIRSOFTM4 = true,
        WEAPON_AIRSOFTGLOCK20 = true,
        WEAPON_SIG_SAUCER = true,
        WEAPON_GLOCK19GEN4 = true,
        WEAPON_GLOCK20 = true,
        WEAPON_FBIARB = true,
        WEAPON_FM1_BENELLIM4 = true,
        WEAPON_M870 = true,
        WEAPON_HK417 = true,
        WEAPON_LWRC = true,
        WEAPON_KS1 = true,
        WEAPON_LBRS = true,
        WEAPON_SIG516 = true,
        WEAPON_P90 = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_STUNGUN = true,
        WEAPON_FLASHLIGHT = true,
        WEAPON_BEANBAG = true,
    },
}

Config.ForceRespawnPunishment = { --hold E to respawn
    RemoveMoney         = false,
    RemoveBlackMoney    = false,
    RemoveItems         = false,
    RemoveWeapons       = true,
    IgnoreItemList = {
        money = true,
        black_money = true
    },
    IgnoreLoadoutList = {
        WEAPON_PROLASER4 = true,
        WEAPON_BOLAWRAP = true,
        WEAPON_PEPPERSPRAY = true,
        WEAPON_ANTIDOTE = true,
        WEAPON_FLASHBANG = true,
        WEAPON_AIRSOFTR870 = true,
        WEAPON_AIRSOFTM4 = true,
        WEAPON_AIRSOFTGLOCK20 = true,
        WEAPON_SIG_SAUCER = true,
        WEAPON_GLOCK19GEN4 = true,
        WEAPON_GLOCK20 = true,
        WEAPON_FBIARB = true,
        WEAPON_FM1_BENELLIM4 = true,
        WEAPON_M870 = true,
        WEAPON_HK417 = true,
        WEAPON_LWRC = true,
        WEAPON_KS1 = true,
        WEAPON_LBRS = true,
        WEAPON_SIG516 = true,
        WEAPON_P90 = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_STUNGUN = true,
        WEAPON_FLASHLIGHT = true,
        WEAPON_BEANBAG = true,
    },
}

Config.AutoRespawnPunishment = { --after brain dead
    RemoveMoney         = false,
    RemoveBlackMoney    = false,
    RemoveItems         = false,
    RemoveWeapons       = true,
    IgnoreItemList = {
        money = true,
        black_money = true
    },
    IgnoreLoadoutList = {
        WEAPON_PROLASER4 = true,
        WEAPON_BOLAWRAP = true,
        WEAPON_PEPPERSPRAY = true,
        WEAPON_ANTIDOTE = true,
        WEAPON_FLASHBANG = true,
        WEAPON_AIRSOFTR870 = true,
        WEAPON_AIRSOFTM4 = true,
        WEAPON_AIRSOFTGLOCK20 = true,
        WEAPON_SIG_SAUCER = true,
        WEAPON_GLOCK19GEN4 = true,
        WEAPON_GLOCK20 = true,
        WEAPON_FBIARB = true,
        WEAPON_FM1_BENELLIM4 = true,
        WEAPON_M870 = true,
        WEAPON_HK417 = true,
        WEAPON_LWRC = true,
        WEAPON_KS1 = true,
        WEAPON_LBRS = true,
        WEAPON_SIG516 = true,
        WEAPON_P90 = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_STUNGUN = true,
        WEAPON_FLASHLIGHT = true,
        WEAPON_BEANBAG = true,
    },
}

Config.RespawnOptions = {
    {
        Name = 'Pillbox Hill Hospital',
        Description = 'Transport Fee: $500 | Medical Fee: $2500',
        TotalCost = 3000,
        Transport = false,
        IsPrison = false,
        Vehicle = 'ambulance',
        Offset = vector3(0.0, -2.5, -0.4), --attach offset
        Gps = vector3(361.6413, -592.5845, 28.6671),
        TransportTimeOut = 60 * 10,
    },
    {
        Name = 'Sandy Shores Hospital',
        Description = 'Transport Fee: $500 | Medical Fee: $2500',
        TotalCost = 3000,
        Transport = false,
        IsPrison = false,
        Vehicle = 'ambulance',
        Offset = vector3(0.0, -2.5, -0.4), --attach offset
        Gps = vector3(1782.5702, 3650.5354, 34.2913),
        TransportTimeOut = 60 * 10,
    },
    {
        Name = 'Paleto Bay Hospital',
        Description = 'Transport Fee: $500 | Medical Fee: $2500',
        TotalCost = 3000,
        Transport = false,
        IsPrison = false,
        Vehicle = 'ambulance',
        Offset = vector3(0.0, -2.5, -0.4), --attach offset
        Gps = vector3(-239.2750, 6334.0234, 32.4026),
        TransportTimeOut = 60 * 10,
    },
}

Config.PlayForTask = {
    revive      = 1000,
    cpr         = 1000,
    cpradvanced = 500,
    bandage     = 200,
    neckbrace   = 200,
    bodybandage = 200,
    armbrace    = 200,
    legbrace    = 200,
    morphine30  = 200,
    saline      = 100,
    firstaid    = 100,
    medikit     = 100,
}

Config.IgnoreAnims = { --death & down animation will be skiped if player using animations below
    {dir = 'missfinale_c2mcs_1', anim = 'fin_c2_mcs_1_camman'}, --carry
    {dir = 'move_injured_ground', anim = 'front_loop'}, --crawl
}


