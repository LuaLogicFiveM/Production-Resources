--[[
    Start tgiann-core script after es_extented/qb-core/oxmysql script and before tgiann-* scripts
    Adjust the tgiann-core config file according to the framework you are using

    - If you are having any problems, please check the channels on my discord. If your problem is not resolved, open a ticket.
    - Discord: http://discord.gg/9SEg2WNf7Y
    - Docs: https://tgiann.gitbook.io/tgiann
    - Core Exports: https://docs.tgiann.com/scripts/tgiann-core
]]

configCore = {}
config = {}

-- All my scripts work with this language setting. You can also change the language using the language command.
-- This value is stored in the database tgiann_core_lang table, and even if you change this config value, it will not change in the player database value.
-- If you delete the en.lua files in your script, your language setting will be saved as en. The game may encounter an error when attempting to set the language to en.
-- If you experience such a situation, change your language using the /language command.
config.lang = "en" -- "en" - "tr"

config.locale = {
    timeLocale = "en-EN",
    moneyLocale = "en-EN",
    moneyCurrency = "USD",
}

-- number of online police needed to control
config.policeJobs = {
    "police",
}

config.defaultColor = { background = "#36ff9f", color = "#252525" } -- Changes the main hud color of tgiann scripts.
config.autoCreateDatabase = true                                    -- If true, the database will be created automatically. If false, you must create the database manually.

configCore.textUiLocation = "right"                                 -- "left"   |   "right"
configCore.tgiannDrawText3D = true                                  -- Use tgiann's drawtext3d function instead of QB and ESX
configCore.checkArtifactVersion = true                              -- Check the artifact version of the server
configCore.playerMaxOwnableLocations = 1                            -- The maximum number of places the player can buy in scripts like garage, clothing

-- It checks if a player's bucket value has changed. If the bucket value changes, it send the tgiann scripts.
configCore.bucketCheckerInterval = 3000 -- miliseconds

configCore.commands = {
    changeLang = { -- it helps to change language in TGIANN scripts.
        name = "language",
        help = "changeLanguageDesc",
    },
    removeOwnableLocation = { -- it helps to remove ownable locations in TGIANN scripts.
        name = "removeOwnableLocation",
        help = "company.command.removeOwnableLocationDesc",
        perm = "group.admin"
    }
}

configCore.frameworkConfig = {
    esxScriptName = "es_extended",                  -- https://github.com/esx-framework/esx_core/tree/main/%5Bcore%5D/es_extended
    qbScriptName = "qb-core",                       -- https://github.com/qbcore-framework/qb-core
    qbxScriptName = "qbx_core",                     -- https://github.com/Qbox-project/qbx_core
    tgiannInventoryScriptName = "tgiann-inventory", -- https://store.tgiann.com/package/6251398
    oxInventoryScriptName = "ox_inventory",         -- https://github.com/overextended/ox_inventory
    codemInventoryScriptName = "codem-inventory",
    origenInventoryScriptName = "origen_inventory",
    coreInventoryScriptName = "core_inventory",
    oxMysqlScriptName = "oxmysql", -- https://github.com/overextended/oxmysql
    esxService = "esx_service",    -- https://github.com/esx-framework/esx_service
    wasabiAmbulance = "wasabi_ambulance",
    oxTarget = "ox_target",
    qbTarget = "qb-target",
}

-- Shows the location of the menus created when the button is pressed.
configCore.showClosestMenuKey = "LMENU"
-- The distance at which the closest menu will be shown when the button is pressed.
configCore.showClosestMenuDistance = 20

configCore.custom = {
    -- If you set this to true, you need to edit the files in folder client\inventory\custom\main.lua and server\inventory\custom\main.lua.
    customInventory = false,
    drawText = {
        active = false,
        ---@param uniqName string Unique name for the text
        ---@param button string Button text to display
        ---@param text string Text to display
        ---@diagnostic disable-next-line: unused-local
        openFunc = function(uniqName, button, text)
            lib.showTextUI(text)
        end,
        ---@param uniqName string Unique name for the text
        ---@diagnostic disable-next-line: unused-local
        closeFunc = function(uniqName)
            lib.hideTextUI()
        end
    },
    notif = {
        active = false, -- If you are using a different notify system, set active to true and edit the notify function
        ---@param msg string
        ---@param msgType? "primary" | "success" | "error"
        ---@param time? number
        ---@diagnostic disable-next-line: unused-local
        func = function(msg, msgType, time)
            if not msgType or msgType == "primary" then msgType = "info" end
            lib.notify({
                title = 'Notification',
                description = msg,
                type = msgType,
                duration = time or 5000,
            })
        end
    },
    uiDrawText3D = {
        active = false,           -- If you want to use something other than tgiann 3d draw text, you can activate this. (When true, some problems may arise!!!)
        triggerEveryTick = false, -- When true, the openFunc function is triggered every tick.
        ---@param uniqName string Unique name for the text
        ---@param data [string, string][] -- Data to display, where each item is a table with two strings: [1] = key, [2] = text
        ---@param coord vector3
        ---@param screenPos { x: number, y: number }
        ---@diagnostic disable-next-line: unused-local
        openFunc = function(uniqName, data, coord, screenPos)
            local text = ""
            local length = #data
            for i = 1, length do
                text = ("[%s] %s%s"):format(data[i][1], data[i][2], i < length and " " or "")
            end
            lib.showTextUI(text)
        end,
        ---@param uniqName string Unique name for the text
        ---@diagnostic disable-next-line: unused-local
        closeFunc = function(uniqName)
            lib.hideTextUI()
        end
    },
    deadReviveEvent = {
        active = false,                        -- if you are using a different ambulance script, make it true and edit the events (-- also u can change event from client/main.lua)
        deadEvent = "baseevents:onPlayerDied", -- https://docs.fivem.net/docs/resources/baseevents/events/onPlayerDied/
        reviveEvent = "playerSpawned",         -- https://docs.fivem.net/docs/resources/spawnmanager/events/playerSpawned/
    }
}

config.test = false         -- Dont touch this
config.tgiannServer = false -- Dont touch this

configCore.langs = {}

exports("getConfig", function()
    return config
end)
