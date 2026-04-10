--        _     _            _                         _        _
--  _ __ | |__ | | __ _  ___| | ___ __ ___   __ _ _ __| | _____| |_
-- | '__|| '_ \| |/ _` |/ __| |/ / '_ ` _ \ / _` | '__| |/ / _ \ __|
-- | |   | |_) | | (_| | (__|   <| | | | | | (_| | |  |   <  __/ |_
-- |_|___|_.__/|_|\__,_|\___|_|\_\_| |_| |_|\__,_|_|  |_|\_\___|\__|
--  |_____|
--
--  Need support? Join our Discord server for help: https://discord.gg/TR38cZFdQk
--
Cfg = {}

Cfg.Language = 'en'     -- Languages: 'en': English, 'es': Spanish, 'fr': French, 'de': German, 'pt': Portuguese, 'zh': Chinese
Cfg.NuiColor = 'violet' -- Colors: 'dark', 'gray', 'red', 'pink', 'grape', 'violet', 'indigo', 'blue', 'cyan', 'teal', 'green', 'lime', 'yellow', 'orange'
Cfg.VersionCheck = true -- Intermittent version checking (boolean)
Cfg.Debug = false        -- Debug prints, not recommended for live servers (boolean)

Cfg.NightOnly = true          -- Enable night only operation of the black market (boolean)
Cfg.ItemNeeded = false        -- Require a specific item to access the black market (string or false)
Cfg.MoveInterval = 30         -- Time in minutes between the van changing locations (number)
Cfg.CurrencyType = 'account'  -- Type of currency used for transactions in the black market ('account' or 'item')
Cfg.Currency = 'black_money'  -- Name of the currency or item used for transactions in the black market (string)
Cfg.LicensePlate = 'BLK MRKT' -- License plate text for the black market van (string)

Cfg.Blip = {
    enabled = true, -- Enable or disable the blip for the black market van (boolean)
    sprite = 110,   -- Blip sprite (https://docs.fivem.net/docs/game-references/blips)
    color = 1,      -- Blip color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
    scale = 0.5,    -- Blip scale (float)
}

Cfg.Locations = { -- Locations where the black market van can spawn (vec4)
    vec4(235.9342, 3164.6233, 42.6178, 104.1081),
    vec4(-138.1597, -31.5596, 58.0673, 175.0),
    vec4(166.1195, -1929.2626, 21.0126, 232.2999),
    vec4(945.9032, -255.1279, 67.5305, 150.9437),
    vec4(17.8651, 6507.9990, 31.5144, 43.8171),
}

Cfg.Categories = { -- Black market item categories
    { name = 'handgun', label = 'Handguns',    icon = 'gun' },
    { name = 'arp', label = 'AR Pistols',    icon = 'gun' },
    { name = 'smg', label = 'SMGs',    icon = 'gun' },
    { name = 'rifle', label = 'Rifles',    icon = 'gun' },
    { name = 'ammo',   label = 'Ammunition',       icon = 'box' },
    { name = 'item',   label = 'Items',      icon = 'handcuffs' },
}

Cfg.Items = {
    { category = 'item',   item = 'lockpick',            price = 125,  multiple = true,  prop = false },
    { category = 'handgun', item = 'WEAPON_GLOCK17',     price = math.random(50000, 75000), multiple = false, prop = 'w_pi_glock17' },
    { category = 'handgun', item = 'WEAPON_FNX45',     price = math.random(50000, 75000), multiple = false, prop = 'w_pi_fnx45' },
    { category = 'handgun', item = 'WEAPON_FIVESEVEN',     price = math.random(50000, 75000), multiple = false, prop = 'w_pi_fiveseven' },
    { category = 'handgun', item = 'WEAPON_GHOSTGLOCK',     price = math.random(50000, 75000), multiple = false, prop = 'w_pi_ghostglock' },
    { category = 'handgun', item = 'WEAPON_APPISTOL',     price = math.random(50000, 75000), multiple = false, prop = 'w_pi_appistol' },
    { category = 'handgun', item = 'WEAPON_COMBATPISTOL',     price = math.random(50000, 75000), multiple = false, prop = 'w_pi_combatpistol' },
    { category = 'arp', item = 'WEAPON_ARPISTOL', price = math.random(100000, 125000), multiple = false, prop = 'w_ar_arpistol' },
    { category = 'arp', item = 'WEAPON_ARPISTOLSUB', price = math.random(100000, 125000), multiple = false, prop = 'w_ar_arpistolsub' },
    { category = 'arp', item = 'WEAPON_GHOSTARP', price = math.random(100000, 125000), multiple = false, prop = 'w_ar_ghostarp' },
    { category = 'arp', item = 'WEAPON_PLR', price = math.random(100000, 125000), multiple = false, prop = 'w_ar_plr' },
    { category = 'smg', item = 'WEAPON_MP9A', price = math.random(100000, 135000), multiple = false, prop = 'w_sb_mp9a' },
    { category = 'smg', item = 'WEAPON_MPX', price = math.random(100000, 135000), multiple = false, prop = 'w_ar_mpx' },
    { category = 'smg', item = 'WEAPON_MP5SDFM', price = math.random(100000, 135000), multiple = false, prop = 'mp5sd_fm' },
    { category = 'rifle', item = 'WEAPON_AK47DRUM', price = math.random(150000, 200000), multiple = false, prop = 'w_ar_ak47drum' },
    { category = 'rifle', item = 'WEAPON_HK416B', price = math.random(150000, 200000), multiple = false, prop = 'w_ar_hk416b' },
    { category = 'rifle', item = 'WEAPON_SCARSC', price = math.random(150000, 200000), multiple = false, prop = 'scarsc' },
    { category = 'ammo',   item = 'ammo-9',         price = 5,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-10',         price = 6,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-40',         price = 7,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-45',         price = 7,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-357',         price = 8,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-5.7',         price = 8,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-44',         price = 8,    multiple = true,  prop = 'prop_ld_ammo_pack_01' },
    { category = 'ammo',   item = 'ammo-556',         price = 10,    multiple = true,  prop = 'prop_ld_ammo_pack_03' },
    { category = 'ammo',   item = 'ammo-762',         price = 13,    multiple = true,  prop = 'prop_ld_ammo_pack_03' },
    { category = 'ammo',   item = 'ammo-12',         price = 15,    multiple = true,  prop = 'prop_ld_ammo_pack_02' },
}

Cfg.DispatchResource = 'cd_dispatch' -- Dispatch system (linden_outlawalert, ps-dispatch, cd_dispatch, rcore_dispatch, custom)
Cfg.DispatchOdds = 15                       -- Percent chance of a dispatch alert being triggered (number or false)
Cfg.PoliceJobs = {                          -- Police jobs that will recieve dispatch alerts
    'bcso',
    'sasp',
}

-- Logging configuration can be set in:
--              core/server/logging.lua
