Config = {}

-- do you want to enable target? (Recommended)
Config.Target = 'ox_target' -- 'autodetect', 'ox_target', 'qb-target', 'none'

-- do you want to use text ui? (Check fxmanifest.lua)
Config.Notify = 'none' -- 'ox_lib', 'qb', 'esx', 'none'

-- do you want to use text ui?
Config.TextUI = 'ox_lib' -- 'ox_lib', 'none'

-- do you want to enable text interactions?
Config.EnableTextInteractions = true -- [true = enable it, false = disable it]

-- do you want the carried able to uncarry themself?
Config.CanCarriedPersonCancel = true -- [true = carried person can uncarry themself, false = carried person cannot uncarry themself]

-- do you want to require acceptance from the player being carried?
Config.RequireAcceptance = true -- [true = require acceptance, false = immediate carry]

-- how long should the player have to accept the carry request?
Config.AcceptanceTimeout = 10000 -- 10 seconds to respond

-- do you want to use generic name for the player being carried?
Config.AcceptanceGenericName = false -- [true = use generic name, false = use player name]

-- allow carrying dead players and also putting in trunk
Config.DisallowDead = false -- [true: will not allow, false: will allow]

-- do you want to carry peds? [Check bridge/carryped.lua]
Config.EnableCarryPed = false

-- do you want to put carried person in vehicle seat?
Config.EnablePutInSeat = true -- [true = enable it, false = disable it]

-- allow putting player in driver seat
Config.AllowPutInDriverSeat = false -- [true: will allow, false: will not allow]

-- at what distance should you check to carry person
Config.CarryDistance = 2.0

-- at what distance should you check to put person in seat
Config.VehicleDistance = 2.0

-- do you want the vehicle to check for locks?
Config.CheckVehicleLocked = true

-- doo you want to allow multiple people in trunk?
Config.AllowMultipleInTrunk = true

-- do you want to put carried person in vehicle trunk?
Config.EnablePutInTrunk = true -- [true = enable it, false = disable it]

-- do you want to enable commands for /carry, /removetrunk, /removeseat, /cancelcarry
-- NOTE: this also enabled keybinds for each command mentioned above
Config.EnableCommands = true -- [true = enable it, false = disable it]

-- do you want to enable screen fadein/fadeout?
Config.EnableScreenFade = false -- [true = enable it, false = disable it]

-- what is your trunk doorNo [Default: 5]
Config.DefaultVehicleTrunkNo = 5

-- what is your trunk doorNo by vehicle model (This is for custom vehicles)
Config.VehicleTrunkModels = {
    -- [`VEHICLE_MODEL`] = DOOR_INDEX,
    [`sultan`] = 5,
}

-- specified animations for the person carrying, carried, intrunk, etc
Config.Animations = {
    ['carrying'] = {
        animDict = "missfinale_c2mcs_1",
        anim = "fin_c2_mcs_1_camman",
        flag = 49,
    },
    ['carried'] = {
        animDict = "nm",
        anim = "firemans_carry",
        attachX = 0.27,
        attachY = 0.15,
        attachZ = 0.63,
        flag = 33,
    },
    ['intrunk'] = {
        animDict = "timetable@floyd@cryingonbed@base",
        anim = "base",
        xPos = 0.0,
        yPos = -2.2,
        zPos = 0.5,
        xRot = 0.0,
        yRot = 0.0,
        zRot = 0.0,
        fixedRot = true,
    }
}

-- list of all blaclisted vehicle for trunk
Config.BlacklistVehicles = {
    [`ardent`] = true,
    [`zentorno`] = true,
    [`surge`] = true,
    [`iwagen`] = true,
    [`voltic`] = true,
    [`voltic2`] = true,
    [`raiden`] = true,
    [`cyclone`] = true,
    [`tezeract`] = true,
    [`neon`] = true,
    [`omnisegt`] = true,
    [`caddy`] = true,
    [`caddy2`] = true,
    [`caddy3`] = true,
    [`airtug`] = true,
    [`rcbandito`] = true,
    [`imorgon`] = true,
    [`dilettante`] = true,
    [`khamelion`] = true,
    [`wheelchair`] = true,
    [`bmx`] = true,
    [`tribike3`] = true,
    [`fixter`] = true,
    [`cruiser`] = true,
    [`scorcher`] = true,
    [`tribike2`] = true,
    [`tribike`] = true,
}

-- disable controls for the task mentioned
--[[ Note: if you want to enable driving while carrying just remove the appropriate control actions below ]]
Config.DisableControls = {
    ['carrying'] = function() -- [[ THE PERSON CARRYING ]]
        DisableControlAction(0, 24, true)   -- Attack
        DisableControlAction(0, 257, true)  -- Attack 2
        DisableControlAction(0, 25, true)   -- Aim
        DisableControlAction(0, 263, true)  -- Melee Attack 1
        DisableControlAction(0, 45, true)   -- Reload
        DisableControlAction(0, 44, true)   -- Cover
        DisableControlAction(0, 37, true)   -- Select Weapon
        DisableControlAction(0, 26, true)   -- Disable looking behind
        DisableControlAction(0, 73, true)   -- Disable clearing animation
        DisableControlAction(2, 199, true)  -- Disable pause screen
        DisableControlAction(0, 59, true)   -- Disable steering in vehicle
        DisableControlAction(0, 71, true)   -- Disable driving forward in vehicle
        DisableControlAction(0, 72, true)   -- Disable reversing in vehicle
        DisableControlAction(2, 36, true)   -- Disable going stealth
        DisableControlAction(0, 47, true)   -- Disable weapon
        DisableControlAction(0, 264, true)  -- Disable melee
        DisableControlAction(0, 257, true)  -- Disable melee
        DisableControlAction(0, 140, true)  -- Disable melee
        DisableControlAction(0, 141, true)  -- Disable melee
        DisableControlAction(0, 142, true)  -- Disable melee
        DisableControlAction(0, 143, true)  -- Disable melee
        DisableControlAction(0, 29, true)   -- B
        DisableControlAction(0, 26, true)   -- C
        DisableControlAction(0, 21, true)   -- LEFT Shift
        DisableControlAction(0, 47, true)   -- G
        DisableControlAction(0, 74, true)   -- H
        DisableControlAction(0, 311, true)  -- K
        DisableControlAction(0, 7, true)    -- L
        DisableControlAction(0, 301, true)  -- M
        DisableControlAction(0, 199, true)  -- P
        DisableControlAction(0, 44, true)   -- Q
        DisableControlAction(0, 45, true)   -- R
        DisableControlAction(0, 0, true)    -- v
        DisableControlAction(0, 77, true)   -- X
        DisableControlAction(0, 246, true)  -- Y
        DisableControlAction(0, 20, true)   -- Z
        DisableControlAction(0, 39, true)   -- [
        DisableControlAction(0, 27, true)   -- UpArr
        DisableControlAction(0, 173, true)  -- DownArr
        DisableControlAction(0, 174, true)  -- LeftArr
        DisableControlAction(0, 175, true)  -- RightArr
        DisableControlAction(0, 19, true)   -- LftAlt
        DisableControlAction(0, 168, true)  -- F7
        DisableControlAction(0, 288, true)  -- F1
        DisableControlAction(0, 289, true)  -- F2
        DisableControlAction(0, 170, true)  -- F3
        DisableControlAction(0, 166, true)  -- F5
        DisableControlAction(0, 167, true)  -- F6
        DisableControlAction(0, 175, true)  -- F7
        DisableControlAction(0, 56, true)   -- F9
        DisableControlAction(0, 57, true)   -- F10
        DisableControlAction(0, 344, true)  -- F11
        DisableControlAction(26, 37, true)  -- TAB
        DisableControlAction(0, 349, true)  -- TAB
        DisableControlAction(26, 157, true) -- 1
        DisableControlAction(26, 158, true) -- 2
        DisableControlAction(26, 160, true) -- 3
        DisableControlAction(26, 164, true) -- 4
        DisableControlAction(26, 165, true) -- 5
        DisableControlAction(26, 159, true) -- 6
        DisableControlAction(26, 161, true) -- 7
        DisableControlAction(26, 162, true) -- 8
    end,
    ['carried'] = function() -- [[ THE PERSON BEING CARRIED ]]
        DisableControlAction(0, 24, true)   -- Attack
        DisableControlAction(0, 257, true)  -- Attack 2
        DisableControlAction(0, 25, true)   -- Aim
        DisableControlAction(0, 263, true)  -- Melee Attack 1
        DisableControlAction(0, 45, true)   -- Reload
        DisableControlAction(0, 44, true)   -- Cover
        DisableControlAction(0, 37, true)   -- Select Weapon
        DisableControlAction(0, 26, true)   -- Disable looking behind
        DisableControlAction(0, 73, true)   -- Disable clearing animation
        DisableControlAction(2, 199, true)  -- Disable pause screen
        DisableControlAction(0, 59, true)   -- Disable steering in vehicle
        DisableControlAction(0, 71, true)   -- Disable driving forward in vehicle
        DisableControlAction(0, 72, true)   -- Disable reversing in vehicle
        DisableControlAction(2, 36, true)   -- Disable going stealth
        DisableControlAction(0, 47, true)   -- Disable weapon
        DisableControlAction(0, 264, true)  -- Disable melee
        DisableControlAction(0, 257, true)  -- Disable melee
        DisableControlAction(0, 140, true)  -- Disable melee
        DisableControlAction(0, 141, true)  -- Disable melee
        DisableControlAction(0, 142, true)  -- Disable melee
        DisableControlAction(0, 143, true)  -- Disable melee
        DisableControlAction(0, 29, true)   -- B
        DisableControlAction(0, 26, true)   -- C
        DisableControlAction(0, 21, true)   -- LEFT Shift
        DisableControlAction(0, 23, true)   -- F
        DisableControlAction(0, 49, true)   -- F
        DisableControlAction(0, 47, true)   -- G
        DisableControlAction(0, 74, true)   -- H
        DisableControlAction(0, 311, true)  -- K
        DisableControlAction(0, 7, true)    -- L
        DisableControlAction(0, 301, true)  -- M
        DisableControlAction(0, 199, true)  -- P
        DisableControlAction(0, 44, true)   -- Q
        DisableControlAction(0, 45, true)   -- R
        DisableControlAction(0, 0, true)    -- v
        DisableControlAction(0, 77, true)   -- X
        DisableControlAction(0, 246, true)  -- Y
        DisableControlAction(0, 20, true)   -- Z
        DisableControlAction(0, 39, true)   -- [
        DisableControlAction(0, 27, true)   -- UpArr
        DisableControlAction(0, 173, true)  -- DownArr
        DisableControlAction(0, 174, true)  -- LeftArr
        DisableControlAction(0, 175, true)  -- RightArr
        DisableControlAction(0, 19, true)   -- LftAlt
        DisableControlAction(0, 168, true)  -- F7
        DisableControlAction(0, 288, true)  -- F1
        DisableControlAction(0, 289, true)  -- F2
        DisableControlAction(0, 170, true)  -- F3
        DisableControlAction(0, 166, true)  -- F5
        DisableControlAction(0, 167, true)  -- F6
        DisableControlAction(0, 175, true)  -- F7
        DisableControlAction(0, 56, true)   -- F9
        DisableControlAction(0, 57, true)   -- F10
        DisableControlAction(0, 344, true)  -- F11
        DisableControlAction(26, 37, true)  -- TAB
        DisableControlAction(0, 349, true)  -- TAB
        DisableControlAction(26, 157, true) -- 1
        DisableControlAction(26, 158, true) -- 2
        DisableControlAction(26, 160, true) -- 3
        DisableControlAction(26, 164, true) -- 4
        DisableControlAction(26, 165, true) -- 5
        DisableControlAction(26, 159, true) -- 6
        DisableControlAction(26, 161, true) -- 7
        DisableControlAction(26, 162, true) -- 8
    end,
    -- ['intrunk'] = function()  -- [[ THE PERSON IN TRUNK ]]
    --     -- Add your controls here which you want to disable
    -- end
}
