---@diagnostic disable: duplicate-set-field
if GetResourceState('LegacyFuel') == 'missing' then return end

local LegacyFuelAPI = {}

function LegacyFuelAPI.GetResourceName()
    return "legacyfuel"
end

function LegacyFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['LegacyFuel']:GetFuel(vehicle) or 0.0
end

function LegacyFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['LegacyFuel']:SetFuel(vehicle, fuel)
end

function LegacyFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return LegacyFuelAPI