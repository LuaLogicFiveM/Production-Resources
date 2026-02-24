---@diagnostic disable: duplicate-set-field
if GetResourceState('esx-sna-fuel') == 'missing' then return end

local EsxSnaFuelAPI = {}

function EsxSnaFuelAPI.GetResourceName()
    return "esx-sna-fuel"
end

function EsxSnaFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return exports['esx-sna-fuel']:GetFuel(vehicle) or 0.0
end

function EsxSnaFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    exports['esx-sna-fuel']:SetFuel(vehicle, fuel)
end

function EsxSnaFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return EsxSnaFuelAPI
