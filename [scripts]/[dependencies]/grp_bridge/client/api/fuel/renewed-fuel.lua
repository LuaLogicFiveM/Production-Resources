---@diagnostic disable: duplicate-set-field
if GetResourceState('Renewed-Fuel') == 'missing' then return end

local RenewedFuelAPI = {}

function RenewedFuelAPI.GetResourceName()
    return "renewed-fuel"
end

function RenewedFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['Renewed-Fuel']:GetFuel(vehicle) or 0.0
end

function RenewedFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['Renewed-Fuel']:SetFuel(vehicle, fuel)
end

function RenewedFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return RenewedFuelAPI