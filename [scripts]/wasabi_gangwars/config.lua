-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

Config = {}

-- Locale Options are
-- 'en' (English)
-- 'fr' (French)
-- 'cn' (Chinese Simplified)
-- 'tw' (Chinese Traditional)
-- 'de' (German)
-- 'it' (Italian)
-- 'jp' (Japanese)
-- 'ko' (Korean)
-- 'pl' (Polish)
-- 'pt' (Portuguese)
-- 'es' (Spanish)
-- 'hi' (Hindi)
-- 'nl' (Dutch)
-- 'da' (Danish)
-- 'cs' (Czech)
-- If you would like us to add a language, join our discord and create a ticket!
-- All locale strings can be found in /locales/
Config.Locale = 'en'

Config.MaxGangMembers = 20 -- Maximum players in a gang
Config.DisplayEnemyDistance = 100.0 -- From how far the players in active wars sees the enemy visibilities
Config.DisplayEnemyMarker = true -- Display enemy markers on the map
Config.DisplayEnemyTitle = true -- Display enemy titles above their heads

Config.CheckForUpdates = true                    -- Check for updates (Recommended, if you want to be notified when a new version is released)

-- Gang System to sync
-- Options: false (Will enable Config.AdminMode for staff to use) / 'qb' (QBCore gangs) / 'rcore' (RCore Gangs) / 'esx' (esx_gangs - see docs for small change needed) 'custom' (Custom gang system added in modules/server/sync/custom)
-- Check customGangs.md in server/sync for a detailed template and instructions on integrating your custom gang system
Config.GangSystem = false -- Set to false if want to use staff panel only without syncing gangs
-- Use qb-gangs? ^ Put this setting to 'qb' to keep in sync
-- Use rcore? ^ put this setting to 'rcore' to keep in sync
-- Use esx? ^ Put this setting to 'esx' an also make changes on our docs: https://docs.wasabiscripts.com



Config.Wager = {
    min = 1, -- Minimum wager amount
    max = 10000000, -- Maximum wager amount
}

Config.KillsToWin = {
    min = 1, -- Minimum kills to win
    max = 100, -- Maximum kills to win
}

Config.OpenPanels = {
    gangWarsPanel = {
        item = {
            enabled = true,
            name = 'wartablet', -- Name of the item to use to open the panel
        },
        command = {
            enabled = true,  -- Enable/disable both command & keybind
            cmd = 'gangwars', -- /gangwars | Open the gang wars panel
            keybind = 'F4',   -- F4 | Open the gang wars panel | Remove or set to false to disable
        }
    },
}

Config.MoneyTypes = {
    withdraw = 'bank',
    deposit = 'bank',
}

Config.Commands = {
    openStaffPanel = 'gw:admin', -- /gw:admin | Open the gang wars staff panel
    acceptInvite = 'gw:accept', -- /gw:accept | Accept a gang war invite
    declineInvite = 'gw:decline', -- /gw:decline | Decline a gang war invite
}

--[[
    YOU CAN USE ACE PERMISSIONS TO ALLOW CERTAIN PLAYERS/GROUPS TO ACCESS THE STAFF PANEL
    EXAMPLE:
        add_ace group.admin gangwars.staff allow
        add_ace identifier.fivem:1432744 gangwars.staff allow #Rejox

    OR YOU CAN USE THE STAFF GROUPS BELOW
--]]
Config.StaffGroups = {
    'owner',
    'manager',
}

Config.UI = {
    color = {
        primary = { -- Different shades of primary color
            [50] = "#8CF5D2",
            [100] = "#79F3CB",
            [200] = "#53F0BC",
            [300] = "#2EEDAE",
            [400] = "#13DF9B",
            [500] = "#10B981",
            [600] = "#0C855D",
            [700] = "#075239",
            [800] = "#031E15",
            [900] = "#000000",
            [950] = "#000000",

            -- [50] = "#FEDDE9",
            -- [100] = "#FCBAD3",
            -- [200] = "#FA76A6",
            -- [300] = "#F7317A",
            -- [400] = "#D80955",
            -- [500] = "#95063B",
            -- [600] = "#76052E",
            -- [700] = "#580423",
            -- [800] = "#3B0217",
            -- [900] = "#1D010C",
            -- [950] = "#0F0106",
        },
    }
}

--[[
    ONLY CHANGE THIS PART IF YOU HAVE RENAMED SCRIPTS SUCH AS FRAMEWORK, TARGET, INVENTORY ETC
    RENAME THE SCRIPT NAME TO THE NEW NAME
--]]
---@type table Only change these if you have changed the name of a resource
Resources = {
    OXTarget = { name = 'ox_target', export = 'all' },
    QBTarget = { name = 'qb-target', export = 'all' },
}
IgnoreScriptFoundLogs = false
AmbulanceIntegratedDeathEvent = false -- Set this to true if you have integrated the death event in your ambulance job to prevent things like double deaths