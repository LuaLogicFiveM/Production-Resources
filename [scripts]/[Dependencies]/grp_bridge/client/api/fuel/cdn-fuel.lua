---@diagnostic disable: duplicate-set-field
if GetResourceState('cdn-fuel') == 'missing' then return end

local CdnFuelAPI = {}

function CdnFuelAPI.GetResourceName()
    return "cdn-fuel"
end

function CdnFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['cdn-fuel']:GetFuel(vehicle) or 0.0
end

function CdnFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['cdn-fuel']:SetFuel(vehicle, fuel)
end

function CdnFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return CdnFuelAPI
