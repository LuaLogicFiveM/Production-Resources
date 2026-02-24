---@diagnostic disable: duplicate-set-field
if GetResourceState('okokGasStation') == 'missing' then return end

local OkokGasAPI = {}

function OkokGasAPI.GetResourceName()
    return "okokgasstation"
end

function OkokGasAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['okokGasStation']:GetFuel(vehicle) or 0.0
end

function OkokGasAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['okokGasStation']:SetFuel(vehicle, fuel)
end

function OkokGasAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return OkokGasAPI
