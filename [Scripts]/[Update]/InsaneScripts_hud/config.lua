cfg = {}

-- [ FRAMEWORK SETTINGS ]
cfg.framework = 'ESX' -- Options: QBCore, Qbox, ESX, or Standalone.

-- [ DEBUGGING TOOLS ]
cfg.devMode = false -- Developer Mode: Enables extra logging and testing features. Set to false.
cfg.debuggingMode = false -- Set to true to print debug info in the F8 console.
cfg.radarVisibilityDebuger = false -- Set to true ONLY if the minimap flickers or disappears due to conflicts with other resources.
cfg.bigMapDebugger = false -- Set to true if the Big Map gets stuck on screen (fixes the expand glitch).

---------------------

-- [ MENU & INTERACTION ]
cfg.openCommand = 'hud' -- Command to open the HUD settings menu (e.g., /Hud).
cfg.keyMapping = true -- If set to true, allows players to bind the menu key in GTA settings.
cfg.keyMappingDesc = 'Open HUD Menu.' -- Description shown in GTA V Key Bindings section.
cfg.key = 'f11' -- Default key to open the menu.
cfg.onlyOwnersCanUseOpenCommand = false -- If true, only players listed in 'ownerLicense' can use the command.
cfg.onlyOwnersCanUseEditMode = false -- If true, only owners can use Edit Mode to move UI elements.

-- [ PERFORMANCE ]
cfg.UpdateTimeInterval = 1000 -- Data refresh rate in ms. Do not change (affects performance).
cfg.hideHudComponents = false -- Hides default GTA HUD components. Saves 0.01-0.02ms resmon when enabled.
cfg.hudComponentsList = {9,7,6,2} -- List of default GTA HUD ID's to hide.

-- [ VISUALS ]
cfg.enableTriggerBlurOnHudSettings = false -- Blurs background when menu is open. May drop FPS on low-end PCs.

-- [ SONAR SYSTEM ]
cfg.sonar = true -- Enable/Disable sonar for underwater/submarine usage.
cfg.sonarInterval = 2500 -- Time in ms between sonar pings.
cfg.sonarMaxDistance = 250 -- Maximum detection distance.

-- [ RADAR & SPEEDOMETER VISIBILITY ]
cfg.radarVisibleOnlyInCar = false -- If true, minimap is hidden when on foot.
cfg.showSpeedometerOnlyAsDriver = false -- If true, passengers won't see the speedometer.

-- [ OXYGEN ]
cfg.maxOxygenTime = 10.0 -- Default oxygen time. Adjust if using diving scripts that extend lung capacity.

-- [ PERMISSIONS / OWNERS ]
-- Add license keys here for full access (bypass restrictions, use admin commands).
cfg.ownerLicense = {
    --'YOURLICENSE' -- Format: license:xxxxxxxxxxxxxxxxxxxx
}

-- [ NOTIFICATIONS ]
cfg.notify = true -- Enable notifications for saving/resetting settings.
cfg.notifyPos = 'center' -- Notification position.

-- [ LANGUAGE ]
cfg.lang = 'EN'
cfg.langCfg = {
    ['EN'] = {
        -- Notifications --
        configurationSaved = 'Configuration has been saved.',
        resetConfiguration = 'Configuration has been reset to default.',
        setConfigurationAsDefault = 'Configuration has been set as default.',
        ----
        disconnectMessage = 'You have been disconnected from the server. Your HUD configuration has been restored.'
    },
}

-- [ WEAPON CONFIGURATION ]
-- Mapping weapon hashes to image names. Add custom weapons here.
cfg.weapons  = {
    [`WEAPON_404ARP`] = '404 ARP',
    [`WEAPON_SNOWBALL`] = 'Snowball',
    [`WEAPON_3DGLOCK`] = '3D Printed Glock',
    [`WEAPON_300BO`] = '300 Blackout',
    [`WEAPON_357SNUB`] = 'S&W .357 Snubnose',
    [`WEAPON_AR15S`] = 'AR-15 Special',
    [`WEAPON_AKCATCHER`] = 'AK-47 CQC Shellcatcher',
    [`WEAPON_BAGGLOCK`] = 'Bagged Glock',
    [`WEAPON_SWPBLACKARP`] = 'ARP Black Flag',
    [`WEAPON_BLACKKNIFE`] = 'Knife Black Flag',
    [`WEAPON_BLACKSWITCH`] = 'Glock 18 Black Switch',
    [`WEAPON_SWPBLUEARP`] = 'ARP Blue Flag',
    [`WEAPON_BLUEKNIFE`] = 'Knife Blue Flag',
    [`WEAPON_BLUESWITCH`] = 'Glock 18 Blue Switch',
    [`WEAPON_FN57B`] = 'FN-57 Binary',
    [`WEAPON_FN509HUNT`] = 'FN-509',
    [`WEAPON_GRAYARP`] = 'ARP Gray Flag',
    [`WEAPON_GRAYKNIFE`] = 'Knife Gray Flag',
    [`WEAPON_GRAYSWITCH`] = 'Glock 18 Gray Switch',
    [`WEAPON_GREENARP`] = 'ARP Green Flag',
    [`WEAPON_GREENKNIFE`] = 'Knife Green Flag',
    [`WEAPON_GREENSWITCH`] = 'Glock 18 Green Switch',
    [`WEAPON_G19BEAM`] = 'Glock 19 with Beam',
    [`WEAPON_G22`] = 'Glock 22',
    [`WEAPON_G22B`] = 'Glock 22 Binary',
    [`WEAPON_G43X`] = 'Glock 43X',
    [`WEAPON_GHOSTG30`] = 'Glock 30 Ghost Custom',
    [`WEAPON_GP80C`] = 'Glock P80 Custom Switch',
    [`WEAPON_KTECPLR`] = 'Kel-Tec PLR-16',
    [`WEAPON_LILUZI`] = 'Uzi',
    [`WEAPON_MARP`] = 'Micro ARP',
    [`WEAPON_MDRACO`] = 'Micro Draco',
    [`WEAPON_MP5C`] = 'MP5 CQC',
    [`WEAPON_OPPSLUGGER`] = 'Opp Slugger Bat',
    [`WEAPON_ORANGEARP`] = 'ARP Orange Flag',
    [`WEAPON_ORANGEKNIFE`] = 'Knife Orange Flag',
    [`WEAPON_ORANGESWITCH`] = 'Glock 18 Orange Switch',
    [`WEAPON_PTX22`] = 'Taurus TX22 Pink',
    [`WEAPON_PINKARP`] = 'ARP Pink Flag',
    [`WEAPON_PINKKNIFE`] = 'Knife Pink Flag',
    [`WEAPON_SWPPINKSWITCH`] = 'Glock 18 Pink Switch',
    [`WEAPON_PURPLEARP`] = 'ARP Purple Flag',
    [`WEAPON_PURPLEKNIFE`] = 'Knife Purple Flag',
    [`WEAPON_PURPLESWITCH`] = 'Glock 18 Purple Switch',
    [`WEAPON_SWPREDARP`] = 'ARP Red Flag',
    [`WEAPON_REDKNIFE`] = 'Knife Red Flag',
    [`WEAPON_SWPREDSWITCH`] = 'Glock 18 Red Switch',
    [`WEAPON_R580`] = 'Remington 580',
    [`WEAPON_SCORPIONX9`] = 'Scorpion X9 Evo',
    [`WEAPON_SCREWD`] = 'Rusty Screwdriver',
    [`WEAPON_SLEDGEH`] = 'Sledgehammer',
    [`WEAPON_STREETSWEEP`] = 'Street Sweeper',
    [`WEAPON_SW357`] = 'S&W .357 Revolver',
    [`WEAPON_SWMP9`] = 'S&W M&P9',
    [`WEAPON_T247`] = 'Taurus 247',
    [`WEAPON_TANGLOCK`] = 'Glock 17',
    [`WEAPON_UGLOCK`] = 'Unauthorized Glock',
    [`WEAPON_WHITEARP`] = 'ARP White Flag',
    [`WEAPON_WHITEKNIFE`] = 'Knife White Flag',
    [`WEAPON_WHITESWITCH`] = 'Glock 18 White Switch',
    [`WEAPON_WOODAXE`] = 'Wooden Axe',
    [`WEAPON_YELLOWARP`] = 'ARP Yellow Flag',
    [`WEAPON_YELLOWKNIFE`] = 'Knife Yellow Flag',
    [`WEAPON_YELLOWSWITCH`] = 'Glock 18 Yellow Switch',

    [`WEAPON_MINIUZI`] = 'Mini Uzi',
    [`WEAPON_G36`] = 'G36',
    [`WEAPON_P320A`] = 'P-320A',
    [`WEAPON_GLOCK19X2`] = 'Glock 19x',
    [`WEAPON_HKUSP`] = 'HK USP',
    [`WEAPON_AK74`] = 'AK-74',
    [`WEAPON_FADEBFKNIFE`] = 'Fade BF Knife',
    [`WEAPON_L5`] = 'Deagle',
    [`WEAPON_USP`] = 'USP',
    [`WEAPON_PINK`] = 'Pink Glock',
    [`WEAPON_YAKUZASMG`] = 'Dragon SMG',
    [`WEAPON_KOIFISH`] = 'Koi ARP',
    [`WEAPON_BK_AP`] = 'BK AP',
    [`WEAPON_BK_MPX`] = 'BK MPX',
    [`WEAPON_MK18`] = 'MK-18',

    [`WEAPON_REDARP`] = 'ARP Red',
    [`WEAPON_GLOCK19BEAMSTICKSWITCH`] = 'Glock 19 w/ Beam',
    [`WEAPON_BLUEGLOCKSWITCH`] = 'Blue Glock Switch',
    [`WEAPON_GLOCK18C`] = 'Glock 18c',
    [`WEAPON_ARP300`] = 'ARP 300',
    [`WEAPON_COLTM45`] = 'Colt M45',
    [`WEAPON_GLOCK27WHITE`] = 'Glock 27 White',
    [`WEAPON_M4A1`] = 'M4-A1',
    [`WEAPON_CANDYAXE`] = 'Candy Axe',
    [`WEAPON_FIREAXE`] = 'Fire Axe',
    [`WEAPON_GLOCK19TANSWITCHDRUM`] = 'Glock 19 w/ Switch',
    [`WEAPON_GLOCK17STICK`] = 'Glock 17 Stick',
    [`WEAPON_FN509`] = 'FN-509',
    [`WEAPON_FIVESEVEN`] = 'Five Seven',
    [`WEAPON_P890`] = 'P-890',
    [`WEAPON_MAKAROV`] = 'Makarov',
    [`WEAPON_GLOCK40SWITCH`] = 'Glock 40 w/ Switch',
    [`WEAPON_SHOVEL`] = 'Shovel',
    [`WEAPON_DESERTEAGLE`] = 'Desert Eagle',
    [`WEAPON_AK47`] = 'AK-47',
    [`WEAPON_AR15`] = 'AR-15',
    [`WEAPON_BLUEGANG`] = 'Blue Gang',
    [`WEAPON_SR16`] = 'SR-16',
    [`WEAPON_GLOCK19TAN`] = 'Glock 19 Tan',
    [`WEAPON_SAWNOFFV2`] = 'Sawn Off',
    [`WEAPON_GLOCK26`] = 'Glock 26',

    [`WEAPON_BEANBAG`] = 'Bean Bag Shotgun',
    [`WEAPON_MEGAPHONE`] = 'Megaphone',
    [`WEAPON_COMBATPISTOL`] = 'Combat Pistol',
    [`WEAPON_APPISTOL`] = 'AP Pistol',
    [`WEAPON_FLASHBANG`] = 'K-J4 Flashbang',
    [`WEAPON_LASER`] = 'Laser Gun 1',
    [`WEAPON_LASER2`] = 'Laser Gun 2',
    [`WEAPON_AIRSOFTR870`] = 'R-870 (Training)',
    [`WEAPON_AIRSOFTM4`] = 'M4 (Training)',
    [`WEAPON_AIRSOFTGLOCK20`] = 'Glock 20 (Training)',
    [`WEAPON_PROLASER4`] = 'Pro Laser 4',
    [`WEAPON_BOLAWRAP`] = 'Remote Restraint',
    [`WEAPON_REVOLVER_MK2`] = 'Revolver',
    [`WEAPON_FISH`] = 'Fish',
    [`WEAPON_RPG`] = 'RPG',
    [`WEAPON_MUSKET`] = 'Musket',

    [`WEAPON_AUTOMATICPISTOL`] = 'Automatic Pistol',
    [`WEAPON_TANFNX45`] = 'FNX 45 (Tan)',
    [`WEAPON_RUGER57`] = 'Ruger 5.7',
    [`WEAPON_SIG`] = 'SIG M18 Tan',
    [`WEAPON_M9`] = 'Beretta M9',
    [`WEAPON_HIPOINT`] = 'Hi Point',
    [`WEAPON_HELLCAT`] = 'Hellcat (Black)',
    [`WEAPON_G41`] = 'Glock 41',
    [`WEAPON_G26SWITCH`] = 'Glock 26 Switch',
    [`WEAPON_G26EXT`] = 'Glock 26 Stick',
    [`WEAPON_G19XTAN`] = 'Glock 19x (Tan)',
    [`WEAPON_G19SWITCH`] = 'Glock 19 Switch',
    [`WEAPON_G19BLACK`] = 'Glock 19 (Black)',
    [`WEAPON_G17TAN`] = 'Glock 17 (Tan)',

    [`WEAPON_UDP9`] = 'UDP 9mm',
    [`WEAPON_PLR`] = 'Kel-Tec PLR',
    [`WEAPON_MICRODRACO`] = 'Micro Draco',
    [`WEAPON_DRACO`] = 'Mini Draco',
    [`WEAPON_MPX`] = 'MPX Drum',
    [`WEAPON_MP5SDFM`] = 'MP5',
    [`WEAPON_MP9A`] = 'MP9A',

    [`WEAPON_SR47`] = 'SR-47',
    [`WEAPON_SCARSC`] = 'Scar SC',
    [`WEAPON_M6IC`] = 'M6-IC',

    [`WEAPON_GLOCK17`] = 'Glock 17 Switch',
    [`WEAPON_G17STAINLESS`] = 'Glock 17 Stainless Stick',
    [`WEAPON_G17GREEN`] = 'Glock 17 (Green)',
    [`WEAPON_G17EXT`] = 'Glock 17 Stick',
    [`WEAPON_G17BLACK`] = 'Glock 17 (Black)',
    [`WEAPON_FNX45`] = 'FNX 45 (Black)',
    [`WEAPON_ARPISTOL`] = 'ARP Drum',
    [`WEAPON_ARPISTOLSUB`] = 'ARP Sub',
    [`WEAPON_AK47DRUM`] = 'AK47',
    [`WEAPON_HK416B`] = 'HK-416B',
    [`WEAPON_GHOSTGLOCK`] = 'Ghost Glock',
    [`WEAPON_GHOSTARP`] = 'Ghost ARP',
    [`WEAPON_AR15BLACK`] = 'AR-15 (Black)',
    [`WEAPON_AR15BLUE`] = 'AR-15 (Blue)',
    [`WEAPON_AR15GREEN`] = 'AR-15 (Green)',
    [`WEAPON_AR15PURPLE`] = 'AR-15 (Purple)',
    [`WEAPON_AR15RED`] = 'AR-15 (Red)',
    [`WEAPON_AR15WHITE`] = 'AR-15 (White)',
    [`WEAPON_AR15YELLOW`] = 'AR-15 (Yellow)',
    [`WEAPON_AR15ORANGE`] = 'AR-15 (Orange)',

    [`WEAPON_KNUCKLE`] = 'Knuckle Dusters',
    [`WEAPON_SCREWDRIVER`] = 'Screwdriver',
    [`WEAPON_TRIDAGGER`] = 'Tri-Dagger',
    [`WEAPON_RUSTYSHANK`] = 'Rusty Shank',
    [`WEAPON_KITCHENKNIFE`] = 'Kitchen Knife',
    [`WEAPON_KNIFE`] = 'Knife',
    [`WEAPON_FURYNAILBAT`] = 'Nail Bat',
    [`WEAPON_GAS`] = 'Galaxy Gas',
    [`WEAPON_GLIZZY`] = 'Glizzy',

    [`WEAPON_PAINTBALL`] = 'Paintball Gun',
    [`WEAPON_ACIDPACKAGE`] = 'Newspaper',
    [`WEAPON_SPRAYGUN`] = 'Spray Gun',

    [`WEAPON_PEPPERSPRAY`] = 'Pepper Spray',
    [`WEAPON_ANTIDOTE`] = 'Pepper Spray Antidote',
    [`WEAPON_BATON`] = 'Baton',
    [`WEAPON_FLASHLIGHT`] = 'Flashlight',
    [`WEAPON_HEAVYSNIPER`] = 'Heavy Sniper',
    [`WEAPON_SNIPERRIFLE`] = 'Sniper Rifle',
    [`WEAPON_M870`] = 'M870 Modular',
    [`WEAPON_FBIARB`] = 'LEO Rifle',
    [`WEAPON_FM1_BENELLIM4`] = 'Benelli M4',
    [`WEAPON_HK417`] = 'HK-417',
    [`WEAPON_KS1`] = 'KAC KS-1',
    [`WEAPON_LBRS`] = 'LBRS',
    [`WEAPON_LWRC`] = 'LW-RC',
    [`WEAPON_P90`] = 'P-90',
    [`WEAPON_SIG516`] = 'Sig 516',
    [`WEAPON_SIG_SAUCER`] = 'Sig Saucer',
    [`WEAPON_GLOCK19GEN4`] = 'Glock 19 Gen 4',
    [`WEAPON_GLOCK20`] = 'Glock 20',
    [`WEAPON_STUNGUN`] = 'Tazer',

    [`WEAPON_FIREEXTINGUISHER`] = 'Fire Extinguisher',
    [`WEAPON_PETROLCAN`] = 'Gas Can',

    [`WEAPON_SWITCHBLADE`] = 'Switchblade',

}

-- ADMIN COMMANDS -- 
-- /clearHudData [Server ID or License] [disconnect] 
-- Resets a player's HUD configuration to default.