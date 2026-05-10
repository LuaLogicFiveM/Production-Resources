---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-fuelstations') == 'missing' then return end

local QSFuelAPI = {}

function QSFuelAPI.GetResourceName()
    return "qs-fuelstations"
end

function QSFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['qs-fuelstations']:GetFuel(vehicle) or 0.0
end

function QSFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['qs-fuelstations']:SetFuel(vehicle, fuel)
end

function QSFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return QSFuelAPI