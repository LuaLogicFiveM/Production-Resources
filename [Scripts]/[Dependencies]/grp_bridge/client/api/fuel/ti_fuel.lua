---@diagnostic disable: duplicate-set-field
if GetResourceState('ti_fuel') == 'missing' then return end

local TIFuelAPI = {}

function TIFuelAPI.GetResourceName()
    return "ti_fuel"
end

function TIFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['ti_fuel']:getFuel(vehicle) or 0.0
end

function TIFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    fuelType = fuelType or "RON91"
    exports['ti_fuel']:setFuel(vehicle, fuel, fuelType)
end

function TIFuelAPI.GetFuelCapacity(vehicle)
    return exports['ti_fuel']:getCapacity(vehicle) or 65.0
end

return TIFuelAPI