---@diagnostic disable: duplicate-set-field
if GetResourceState('qbx_vehiclekeys') == 'missing' then return end

local QBXVehicleKeysAPI = {}

function QBXVehicleKeysAPI.GetResourceName()
    return "qbx_vehiclekeys"
end

function QBXVehicleKeysAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", plate)
end

function QBXVehicleKeysAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    TriggerEvent("qb-vehiclekeys:client:RemoveKeys", plate)
end

return QBXVehicleKeysAPI