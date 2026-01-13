---@diagnostic disable: duplicate-set-field
if GetResourceState('ps-fuel') == 'missing' then return end

local PSFuelAPI = {}

function PSFuelAPI.GetResourceName()
    return "ps-fuel"
end

function PSFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports["ps-fuel"]:GetFuel(vehicle) or 0.0
end

function PSFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports["ps-fuel"]:SetFuel(vehicle, fuel)
end

function PSFuelAPI.GetFuelCapacity(vehicle)
    -- ps-fuel supports different capacities
    return exports["ps-fuel"]:GetFuelCapacity(vehicle) or 65.0
end

return PSFuelAPI