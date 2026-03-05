---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- PLATE FLIPPER ----------------------------------------------------------
-- INSTALL GUIDE:
-- The plate flipper script visually changes the license plate while keeping the original text intact. 
-- This prevents other scripts from malfunctioning, as you can still retrieve the genuine licence plate data through the
-- GetVehicleNumberPlateText native. 

-- The script also includes an exported function that can be used to retrieve the license plate. 
-- If the plate isn't flipped, the function returns the normal plate, but if it is flipped, it returns an empty string.

-- To use the plate flipper script, we recommend replacing the GetVehicleNumberPlateText() Native function 
-- in any script where you don't want the license plate text to be returned if the license plate is flipped. 
-- For example, you may want to do this for police radars or speed cameras.

-- To replace the function, use the following code:
-- exports["pd_plate_flipper"]:GetVehiclePlate(vehicle)

-- To replace the function in your script, you can run a find-and-replace query:
    
-- Find:
-- GetVehicleNumberPlateText(
    
-- Replace with:
-- exports["pd_plate_flipper"]:GetVehiclePlate(


-- Please note that you only need to do this for scripts where you want an empty string to be returned
-- instead of the actual license plate text if the plate is flipped.

-- Execute pd_extra_table.sql on your database and if you're using an item framework, execute esx_install.sql from _esx_install folder
-- if using ESX or follow the instructions in _qb_setup



-- This script uses the north yankton plate as the stealth plate. If the north yankton plate shows up in LS Customs, make sure to remove it.

----------------------------------------------------------------------------------------------------------------------------------


-- DEFAULT KEYBIND FOR THE FLIPPER IS "K". This can be changed in the fivem keybind settings in game

Config = {}
Config.Locale = 'en'
Config.debug = false

Config.ESX = {
    enabled = true,
    useNewESXExport = true
}

Config.QBCore = {
    enabled = false,
}

Config.sqlDriver = "oxmysql" -- options: "mysql" (for esx) or "oxmysql" (for QBCore)
Config.extremeBlackout = true -- flattens out the text to decrease readability

Config.defaultKeyBind = "RCONTROL"

-- Requires Either ESX or QBCore
Config.requiresInstalledMod = true

Config.useAZERTYKeyboard = false
Config.keyBindsIn = {"S", "D", "W", "A"}
Config.keyBindsOut = {"W", "D", "S", "A"}
Config.minigameLength = 20 -- amount of keypresses
Config.removalMessedUpDuration = 5

-- This is the default of nothing for the line is setup in the config.
-- The display type for each individual line can be modified in "locales/en.lua"
Config.displayText = "3DText" -- options: "3DText", "subtitles", "topRightDisplay"
Config.useKey = {
    key = 'G',
    TextDisplay3d = "~g~[~w~G~g~]~w~",
    inputIcon = "~INPUT_DETONATE~", --https://docs.fivem.net/docs/game-references/controls/
}
Config.cancelKey = {
    key = 'X', 
    TextDisplay3d = "~r~[~w~X~r~]~w~",
    inputIcon = "~INPUT_VEH_DUCK~"--https://docs.fivem.net/docs/game-references/controls/
}

Config.flipperInstall = {
    requiresInstall = true,
    requiresJob = false,
    itemEnabled = true,
    command = "flipper",
    jobName = "mechanic_example",
    itemName = "pd_licence_plate_flipper",
    requiresScrewdriver = true,
    screwdriverName = "pd_screwdriver",
    policeCanCheckForInstalledFlipper = {
        enabled = true,
        requiresJob = true,
        command = "flippercheck", -- What command to use to check for a plate
        jobNames = {"bcso", "sasp", "gov"},
        searchTime = 5, -- in seconds,
        findChance = 100,
        requiresScrewdriverTorRemove = true,
    }
}



Config.blankPlateIndex = 5 -- don't change this unless instructed