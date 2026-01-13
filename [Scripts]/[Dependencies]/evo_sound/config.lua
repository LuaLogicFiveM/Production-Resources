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
Config.verbosity = 0 -- Log verbosity level, 0 prints nothing, 1 prints errors, 2 prints error + warning, 3 prints error + warning + info
Config.useEventSecurity = true -- Use EVOLabs event security?
Config.interactSoundFile = "ogg" -- interactSound file format
Config.checkTime = 500 -- How often check for close music. between 100 and 1000. def: 500
Config.positionCheckDistance = 35 -- Distance from sound range to start performing positions checks. between 10 and 100. def: 35
Config.interactSoundEnable = true -- enable interactSound compatibility?
Config.defaultVolumeMode = 'user' -- default volume mode. 'game' or 'user'. def: 'game'
Config.updateInterval = 200 -- between 500 and 100, def: 200
Config.commandMute = 'streamermode' -- mute aka 'streamermode' command
Config.commandMenu = 'volume' -- menu command 
Config.volumeProfileSetting = 306 -- volume profile setting ref https://docs.fivem.net/docs/game-references/profile-settings/
Config.disabledControlActions = { -- Please check https://docs.fivem.net/docs/game-references/controls/#controls for reference
    1, 2, 4, 6, 14, 15, 16, 17, 22, 24, 25, 37, 69, 70, 92, 99, 200, 257
}


-------------------------
-- 3D SOUND CONFIG
-------------------------
Config.tridimensional = {}
Config.tridimensional.algorithm = 'linear' -- distance algorithm. 'linear', 'exp' or 'sqrt'. def: 'linear'
Config.tridimensional.defaultDistance = 20 -- default sound distance
Config.tridimensional.noLossPercentage = 0.1 -- no loss zone. eg. sound range 20, noLossPercentage 0.1 => first 2 meters have no sound reduction. between 0 and 1. def 0.1


-------------------------
-- SPATIAL SOUND CONFIG
-------------------------
Config.spatial = {}
Config.spatial.enabled = true -- spatial sound enabled by default on PlayUrlPos? true or false. def: true
Config.spatial.stereoMul = 0.75 -- Stereo multiplier, stereo pan is a value in range [-1, 1]. between 1 and 0. def: 0.75


-------------------------
-- SOUND FILTER
-------------------------
Config.filter = {}
Config.filter.enabled = true -- filter enabled by default on PlayUrlPos? true or false. def: true
Config.filter.filterWater = true -- filter freq when listener is diving. true or false. def: true
Config.filter.filterInterior = true -- filter freq when source in interior and listener out or viceversa. true or false. def: true
Config.filter.baseFreq = 22000 -- base freq filter. between 20000 and 30000. def: 22000
Config.filter.waterFreq = 200 -- freq filter for water. between 50 and 30000. def: 200
Config.filter.interiorFreq = 200 -- freq filter for interiors. between 50 and 30000. def: 200
Config.filter.transitionTime = 0 -- filter transition time. between 0 and 2000. def: 0
Config.filter.transitionMode = 'exponential' -- filter transition mode. 'exponential' or 'linear'. def: 'linear'
Config.filter.volReduction = 0.75 -- volume will be multiplied by this value when filtered. between 0 and 1. def: 0.75