---@diagnostic disable: duplicate-set-field
if GetResourceState('BigDaddy-Fuel') == 'missing' then return end

local BigDaddyFuelAPI = {}

function BigDaddyFuelAPI.GetResourceName()
    return "bigdaddy-fuel"
end

function BigDaddyFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['BigDaddy-Fuel']:GetFuel(vehicle) or 0.0
end

function BigDaddyFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['BigDaddy-Fuel']:SetFuel(vehicle, fuel)
end

function BigDaddyFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return BigDaddyFuelAPI
