---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-fuel') == 'missing' then return end

local QBFuelAPI = {}

function QBFuelAPI.GetResourceName()
    return "qb-fuel"
end

function QBFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['qb-fuel']:GetFuel(vehicle) or 0.0
end

function QBFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['qb-fuel']:SetFuel(vehicle, fuel)
end

function QBFuelAPI.GetFuelCapacity(vehicle)
    -- qb-fuel default capacity
    return 65.0
end

return QBFuelAPI