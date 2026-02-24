---@diagnostic disable: duplicate-set-field
if GetResourceState('rcore_fuel') == 'missing' then return end

local RcoreFuelAPI = {}

function RcoreFuelAPI.GetResourceName()
    return "rcore_fuel"
end

function RcoreFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['rcore_fuel']:GetVehicleFuelPercentage(vehicle) or 0.0
end

function RcoreFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['rcore_fuel']:SetVehicleFuel(vehicle, fuel)
end

function RcoreFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return RcoreFuelAPI
