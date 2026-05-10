---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-vehiclekeys') == 'missing' then return end

local QBVehicleKeysAPI = {}

function QBVehicleKeysAPI.GetResourceName()
    return "qb-vehiclekeys"
end

function QBVehicleKeysAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", plate)
end

function QBVehicleKeysAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    TriggerEvent("qb-vehiclekeys:client:RemoveKeys", plate)
end

return QBVehicleKeysAPI