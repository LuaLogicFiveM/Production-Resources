---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_fuel') == 'missing' then return end

local OxFuelAPI = {}

function OxFuelAPI.GetResourceName()
    return "ox_fuel"
end

function OxFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return Entity(vehicle).state.fuel or 0.0
end

function OxFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    local state = Entity(vehicle).state
    state.fuel = fuel
end

function OxFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return OxFuelAPI