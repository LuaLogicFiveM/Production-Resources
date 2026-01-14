Language = "en"

Config = {}

Config.Units = {
    unit = "mph", -- mph/kph
}

Config.DefaultKeys = {
    ["up"] = "UP", -- change value up
    ["down"] = "DOWN", -- change value down
    ["left"] = "LEFT", -- move to left
    ["right"] = "RIGHT", -- move to right
    ["change_plate_direction"] = "I", -- change plate direction
    ["togglecfg"] = "RMENU", -- Switch to config mode
    ["toggle_camera"] = "U",
    ["radar_toggle"] = "F12",
    ["scrambler_sound"] = "G", -- toggle scrambler sound
}

Config.GizmoKeys = {
    ["translate"] = "1",
    ["rotate"] = "2"
}

Config.ModelMode = true -- automatically gives radar to configured models, it set to false you need to use GiveRadarToVehicle and RemoveRadarFromVehicle

Config.DevMode = true -- enabled dev commands, remember to set it to false on your main server 

Config.DisableProp = false

-- permissions for vehicle seats:

-- viewing normal UI in third person
Config.ViewPermissions = {
    [-1] = true,
    [0] = true,
    [1] = false,
    [2] = false
}

-- access to changing settings on the radar 
Config.CfgPermissions = {
    [-1] = true,
    [0] = true,
    [1] = false,
    [2] = false
}

Config.DefaultFast = 80 -- default fast speed

Config.AlwaysOn = false -- Radar is always on if set to false you need to toggle it using radar_toggle key

Config.MaxSyncDist = 20.0 -- radar sync distance outside of the vehicle

Config.MaxDistance = 100.0 -- maximum radar distance

Config.LoadingTime = 1500 -- loading radar time on startup

Config.LockFastPlate = true -- locks plate if the target is exceeding the speed

Config.AutoBoloCheck = true -- automatically check for bolo plates and lock them 

Config.StandaloneCommands = true -- standalone commands for adding/removing radar/scrambler

Config.DisableScramblerSound = false -- disable scrambler sound

Config.ScramblerLogic = {
    changePlate = true, -- randomizes some plate letters
    showErr = false, -- show err on radar upon detection
    -- here you can change logic for randomization of the speed (it's in m/s)
    speedCallback = function(vehicle)
        local speed = GetEntitySpeed(vehicle)/2 - math.random(1, 10)
        if (speed < 0) then
            return 0
        end
        return speed
    end,
}