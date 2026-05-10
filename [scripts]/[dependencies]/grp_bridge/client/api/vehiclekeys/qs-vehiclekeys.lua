---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-vehiclekeys') == 'missing' then return end

local QSVehicleKeysAPI = {}

function QSVehicleKeysAPI.GetResourceName()
    return "qs-vehiclekeys"
end

function QSVehicleKeysAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['qs-vehiclekeys']:GiveKeys(plate)
end

function QSVehicleKeysAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['qs-vehiclekeys']:RemoveKeys(plate)
end

return QSVehicleKeysAPI