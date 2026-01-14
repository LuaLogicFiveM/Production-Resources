local isCooldown = false -- Add this variable to track cooldown status
local Config = {
    RollingBurnout = true,
    Limiter = true,
    Cars = {
        --[GetHashKey("vehicle spawn name")] = {launchrpm = rpm the vehicle launches at, tractionControlValue = traction loss number(higher the number, higher the traction loss), lowSpeedTractionControlValue = low speed traction loss value(higher the number, higher the traction loss)
        [GetHashKey("comet7")] = {launchrpm = 5000, tractionControlValue = 3, lowSpeedTractionControlValue = 1.5},
    }
}


local function Notify(type, title, msg, time)
    if GetResourceState('nass_notifications') == 'started' then
        exports["nass_notifications"]:ShowNotification(type, title, msg, time)
    elseif GetResourceState('17mov_Hud') == 'started' then
        if type == "checkmark" or "alert" then
            type = "success"
        end
        exports["17mov_Hud"]:ShowNotification(msg, type, title, 7500)
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandThefeedPostTicker(0, 1)
    end
end


local function LaunchControl()
    local shouldBreak = false
    if cache.vehicle then
        local rpmlim = 0.8
        local model = GetEntityModel(cache.vehicle)
        if Config.Cars[model] then
            rpmlim = (Config.Cars[model].launchrpm / 10000)
        end
        local savedVehTraction = GetVehicleHandlingFloat(cache.vehicle,'CHandlingData','fLowSpeedTractionLossMult')
        SendNUIMessage({event = "launchControlEBrake"})
        Wait(500)
        
        while not IsControlPressed(0, 22) do
            Wait(10)
            if (not IsControlPressed(0, 22) and IsControlPressed(0, 71)) or (cache.vehicle == nil) then
                Notify("error", "Launch Control", "Launch Control Failed", 5000)
                SendNUIMessage({event = "launchControlFailed"})
                SetVehicleHandlingFloat(cache.vehicle, "CHandlingData","fLowSpeedTractionLossMult", savedVehTraction)
                shouldBreak = true
                break
            end
        end

        SendNUIMessage({event = "launchControlPressGas"})

        while GetVehicleCurrentRpm(cache.vehicle) < rpmlim - 0.02 do
            Wait(10)
            if (not IsControlPressed(0, 22) and IsControlPressed(0, 71)) or (cache.vehicle == nil) then
                Notify("error", "Launch Control", "Launch Control Failed", 5000)
                SendNUIMessage({event = "launchControlFailed"})
                SetVehicleHandlingFloat(cache.vehicle, "CHandlingData","fLowSpeedTractionLossMult", savedVehTraction)
                shouldBreak = true
                break
            end
        end

        local time = 850
        while time > 1 do
            Wait(1)
            SetVehicleCurrentRpm(cache.vehicle, rpmlim)
            time = time - 7
            if shouldBreak or GetVehicleCurrentRpm(cache.vehicle) < rpmlim - 0.02 or not IsControlPressed(0, 71) or not IsControlPressed(0, 22) then
                shouldBreak = false
                break
            end
        end
        
        Notify("checkmark", "Launch Control", "Launch Control Ready", 5000)

        if IsControlPressed(0, 22) and IsControlPressed(0, 71) then
            SetHornEnabled(cache.vehicle, false)
            SendNUIMessage({event = "bump"})
            while IsControlPressed(0, 22) and IsControlPressed(0, 71) do
                if IsControlPressed(0, 38) then -- Check if "E" key is pressed
                    SetVehicleCurrentRpm(cache.vehicle, rpmlim)
                    local forwardForce = 120.0 -- Adjust this value as needed for the desired force
                    ApplyForceToEntity(cache.vehicle, 0, 0.00, forwardForce, 0.0, 0.0, 0.0, 0.0, true, true, true, true, true, true)
                    Wait(100) -- Adjust this wait time as needed
                    DisableControlAction(0, 38, true)
                    Citizen.Wait(100)
                    DisableControlAction(0, 38, true)
                end
                Wait(1)
                SetVehicleCurrentRpm(cache.vehicle, rpmlim)
            end
        end

        Wait(1000)
        SetHornEnabled(cache.vehicle, true)
        SetVehicleHandlingFloat(cache.vehicle, "CHandlingData","fLowSpeedTractionLossMult", savedVehTraction)
        SendNUIMessage({event = "launchControlFailed"})
    else
        Notify("error", "Missing Vehicle", "You must be in a vehicle", 3000)
    end
end

local function LineLock()
    if isCooldown then -- Check if cooldown is active
        Notify("error", "LineLock", 'Tires are still cooling down', 5000)
        return -- Exit the function if cooldown is active
    end

    if not cache.vehicle then
        Notify("error", "LineLock", 'You need to be in a vehicle to perform this action', 5000)
        return
    end

    local rpmlim = 0.8
    local model = GetEntityModel(cache.vehicle)

    if Config.Cars[model] then
        rpmlim = Config.Cars[model].launchrpm / 10000
    end

    local savedVehTraction = GetVehicleHandlingFloat(cache.vehicle, 'CHandlingData', 'fLowSpeedTractionLossMult')
    SendNUIMessage({event = "burnout"})
    Wait(500)

    Citizen.CreateThread(function()
        -- Wait until "W" key is pressed
        while true do
            if IsControlPressed(0, 32) then -- 32 is the control code for the "W" key
                SetVehicleBurnout(cache.vehicle, true)
                SetVehicleCurrentRpm(cache.vehicle, rpmlim) -- Set RPM here
                break -- Exit the loop once the "W" key is pressed
            end
            Wait(0)
        end

        -- Timer loop starts only after "W" key is pressed
        local time = 1000
        local shouldBreak = false
        while time > 1 do
            if shouldBreak then
                shouldBreak = false
                break
            end

            Wait(1)
            SetVehicleCurrentRpm(cache.vehicle, rpmlim)
            time = time - 1

            if Config.RollingBurnout then
                if time == 800 then
                    if Config.Limiter then
                        rpmlim = 1 -- Disable RPM here
                    end
                    SetVehicleHandlingFloat(cache.vehicle, "CHandlingData", "fLowSpeedTractionLossMult", 3.0)
                    SetVehicleBurnout(cache.vehicle, false)
                end
            end

            if time == 700 then 
                Notify("success", "LineLock", 'Tires are Hot and Sticky', 5000)
            end

            if time >= 700 and IsControlJustReleased(0, 32) then
                Notify("error", "Linelock", 'Tires still cold', 7500)
                SetVehicleBurnout(cache.vehicle, false)
                shouldBreak = true
            elseif time <= 700 and IsControlJustReleased(0, 32) then
                shouldBreak = true
                isCooldown = true -- Set cooldown status to true
                SetVehicleHandlingFloat(cache.vehicle, "CHandlingData", "fLowSpeedTractionLossMult", 0.0)
                SetVehicleBurnout(cache.vehicle, false)
                Wait(40000)
                Notify("info", "Linelock", 'Tires cooled down', 7500)
                isCooldown = false -- Reset cooldown status
            end

            SetVehicleHandlingFloat(cache.vehicle, "CHandlingData","fLowSpeedTractionLossMult", savedVehTraction)
        end
    end)
end

RegisterCommand('linelock', function()
    LineLock()
end, false)

RegisterCommand('launch', function()
    LaunchControl()
end, false)