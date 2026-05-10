---@diagnostic disable: duplicate-set-field
if GetResourceState('Renewed-Vehiclekeys') == 'missing' then return end

local RenewedVehicleKeysAPI = {}

function RenewedVehicleKeysAPI.GetResourceName()
    return "Renewed-Vehiclekeys"
end

function RenewedVehicleKeysAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['Renewed-Vehiclekeys']:addKey(plate)
end

function RenewedVehicleKeysAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['Renewed-Vehiclekeys']:removeKey(plate)
end

return RenewedVehicleKeysAPI