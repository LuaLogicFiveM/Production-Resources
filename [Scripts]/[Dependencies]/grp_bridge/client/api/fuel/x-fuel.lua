---@diagnostic disable: duplicate-set-field
if GetResourceState('x-fuel') == 'missing' then return end

local XFuelAPI = {}

function XFuelAPI.GetResourceName()
    return "x-fuel"
end

function XFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['x-fuel']:GetFuel(vehicle) or 0.0
end

function XFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['x-fuel']:SetFuel(vehicle, fuel)
end

function XFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return XFuelAPI