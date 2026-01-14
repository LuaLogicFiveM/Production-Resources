--  
--         EEEEEEEEEEEEEEEEEE  VVVVV        VVVVVVV   OOOOOOOOOOOOOOOOO  
--        EEEEEEEEEEEEEEEEEE   VVVVVV      VVVVVVV  OOOOOOOOOOOOOOOOOOOO 
--       EEEEEE                VVVVVV    VVVVVVVV  OOOOOOO        OOOOOO 
--      EEEEEE                 VVVVVV   VVVVVVV   OOOOOOO        OOOOOO  
--     EEEEEEEEEEEEEEEEEE      VVVVVV VVVVVVVV   OOOOOOO        OOOOOO
--     EEEEEEEEEEEEEEEEE       VVVVVVVVVVVVV    OOOOOOO        OOOOOO
--    EEEEEE                   VVVVVVVVVVV      OOOOOO        OOOOOO
--   EEEEEEEEEEEEEEEEEE        VVVVVVVVVV      OOOOOOOOOOOOOOOOOOOO
--   EEEEEEEEEEEEEEEEEEE       VVVVVVVV         OOOOOOOOOOOOOOOOO
--
-- https://discord.com/invite/Cffzs4NaRU
-- https://evo.tebex.io/
--

-------------------------
-- MAIN CONFIG
-------------------------
Config = {}

Config.locale = 'en-US' -- Locale, file must exist inside locale folder
Config.debug = false -- Always set this value to false in production
Config.framework = 'auto' -- 'auto', 'QBCore', 'Qbox', 'ESX', 'ND_Core' or 'Standalone'
Config.verbosity = 0 -- Log verbosity level, 0 prints nothing, 1 prints errors, 2 prints error + warning, 3 prints error + warning + info
Config.useEventSecurity = true -- Use EVOLabs event security?
Config.resourceName = 'evo_sound' -- Set to your evo_sound script name, should be xSound or evo_sound
Config.defaultVolume = 0.5 -- Default UI volume. Goes from 0 to 1 
Config.defaultLoop = false -- Loop by default?
Config.useSQL = true -- Use SQL? Enables playlists feature, also requires framework to be qbcore or esx to be able to identify the player
Config.saveInterval = 5 -- db save interval in minutes
Config.UIBetterInput = true -- improved ui input functionallity. This causes +0.01ms and disables INPUT_VEH_MOUSE_CONTROL_OVERRIDE when using 'Raw/Simple' mouse input 
Config.audioStreams = { -- Default radios. Add at least title and url
    {title = 'LOS40', subtitle = 'Los40 Spain', url = 'https://20133.live.streamtheworld.com/LOS40_SC', thumbnail = 'https://cdn.discordapp.com/attachments/1212572315481800745/1266338982619385859/F0sShT0.png?ex=66a4c994&is=66a37814&hm=ff4c8a12ed381a2d86685751488f0b5182ad0a8ef0129d3f01b72674f46b86d4&'},
    {title = 'MAGIC FM', url = 'https://live.magicfm.ro/magicfm.aacp'},
    {title = 'TechnoBase.FM', url = 'https://listener1.mp3.tb-group.fm/tb.mp3'},
    {title = 'Techno 4 Ever', url = 'https://rautemusik-de-hz-fal-stream11.radiohost.de/club'},
    {title = 'Radio Ibiza (Napoli)', url = 'https://kisskiss.fluidstream.eu/ibiza.aac'},
    {title = 'Hardcore Power Radio', url = 'https://hardcorepower.beheerstream.nl/8012/stream'},
}
Config.disabledControlActions = { -- Please check https://docs.fivem.net/docs/game-references/controls/#controls for reference
    1, 2, 4, 6, 14, 15, 16, 17, 22, 24, 25, 37, 69, 70, 92, 99, 200, 257
}
Config.carLogs = false


--------------------------
-- CAR RADIO
--------------------------
Config.radio = {}
Config.radio.enabled = true -- true/false
Config.radio.command = 'carradio' -- car radio command
Config.radio.mapping = { description = 'Car Radio', defaultMapper = 'keyboard', defaultParameter = '' } -- car radio mapping
Config.radio.allowedSeats = 'front' -- 'driver' (only driver), 'front' (both driver and co-pilot) or 'any' (any player in car)
Config.radio.distance = 15 -- car radio sound distance in meters
Config.radio.baseVolume = 0.5 -- car radio base volume. From 0 to 1. This value will be multiplied by volume in the UI
Config.radio.outsideMultiplier = 0.5 -- outside multiplier. From 0 to 1. Will be multiplied by volume when player is outside of the vehicle
Config.radio.filterVolMultiplier = 0.75 -- filter volume multiplier. From 0 to 1. Will be multiplied by volume when audio is filtered
Config.radio.filterDisMultiplier = 0.75 -- filter distance multiplier. From 0 to 1. Will be multiplied by distance when audio is filtered
Config.radio.filterFreq = 300 -- lowpass filter max frequency
Config.radio.disabledModels = {
    -- 'sultan', 'entityxf'
}
Config.radio.modelOverrides = {
    -- {model = 'pbus2', baseVolume = 1, distance = 40},
}


--------------------------
-- BOOMBOX
--------------------------
Config.boombox = {}
Config.boombox.model = 'prop_boombox_01'
Config.boombox.command = 'boombox' -- boombox command. use nil to disable
Config.boombox.distance = 15 -- boombox sound distance
Config.boombox.baseVolume = 0.25 -- base volume. From 0 to 1. This value will be multiplied by volume in the UI
Config.boombox.useItem = true
Config.boombox.itemData = {
    name = 'boombox',
    label = 'Boombox',
    weight = 1,
    type = 'item',
    image = 'boombox.png',
    unique = false,
    useable = true,
    description = 'Boombox'
}


--------------------------
-- SOUND ZONES
--------------------------
Config.zones = {}
Config.zones.command = 'music'
Config.zones.list = { -- requiredJob and requiredGrade are optional, remvoe them if you want anyone to use the zone music
    {id = 'sandy_penthouse_1', coords = vector3(-801.76, 182.34, 72.61), baseVolume = 1, distance = 50}
}