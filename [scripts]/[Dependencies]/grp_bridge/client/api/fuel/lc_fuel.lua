---@diagnostic disable: duplicate-set-field
if GetResourceState('lc_fuel') == 'missing' then return end

local LcFuelAPI = {}

function LcFuelAPI.GetResourceName()
    return "lc_fuel"
end

function LcFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['lc_fuel']:GetFuel(vehicle) or 0.0
end

function LcFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['lc_fuel']:SetFuel(vehicle, fuel)
end

function LcFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return LcFuelAPI
