---@diagnostic disable: duplicate-set-field
if GetResourceState('mk_vehiclekeys') == 'missing' then return end

local MKVehicleKeysAPI = {}

function MKVehicleKeysAPI.GetResourceName()
    return "mk_vehiclekeys"
end

function MKVehicleKeysAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['mk_vehiclekeys']:AddKey(plate)
end

function MKVehicleKeysAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['mk_vehiclekeys']:RemoveKey(plate)
end

return MKVehicleKeysAPI