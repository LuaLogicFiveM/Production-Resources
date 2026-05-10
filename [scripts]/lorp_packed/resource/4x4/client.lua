local oldvehiclemode
local enabled = false -- Default to 4x4 off
local vehicle_classes = {
    [2] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [18] = true,
    [20] = true,
}

function IsSUVOrVanOrOffroad(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    return vehicle_classes[vehicleClass] or false
end

function Toggle4x4Mode()
    if cache.vehicle then
        if (GetPedInVehicleSeat(cache.vehicle, -1) == cache.ped) then
            enabled = not enabled
            if enabled then
                Apply4x4Effects(cache.vehicle)
                TriggerEvent("chatMessage", "^2[Info]^7 4x4 mode is ^2ON^7")
            else
                Apply2WDEffects(cache.vehicle)
                TriggerEvent("chatMessage", "^2[Info]^7 4x4 mode is ^1OFF^7")
            end
        end
    end
end

function Apply2WDEffects(vehicle)
    local newHandling = oldvehiclemode
    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveBiasFront', newHandling)
end

function Apply4x4Effects(vehicle)
    local newHandling = 0.500000
    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveBiasFront', newHandling)
end

RegisterCommand("4x4", function(source, args, rawCommand)
    oldvehiclemode = GetVehicleHandlingFloat(cache.vehicle, 'CHandlingData', 'fDriveBiasFront')
    Toggle4x4Mode()
end, false)