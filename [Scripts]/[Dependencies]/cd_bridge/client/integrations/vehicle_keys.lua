--- @param plate string         The vehicle plate.
--- @param vehicle number       The vehicle entity.
function GiveVehicleKeys(plate, vehicle) -- Triggered when giving keys to a vehicle (vehicle may be nil)
    local keysResource = Cfg.VehicleKeys
    if keysResource == 'cd_garage' then
        TriggerEvent('cd_garage:AddKeys', plate)

    elseif keysResource == 'ak47_qb_vehiclekeys' then
        exports['ak47_qb_vehiclekeys']:GiveKey(plate, false)

    elseif keysResource == 'ak47_vehiclekeys' then
        exports['ak47_vehiclekeys']:GiveKey(plate, false)

    elseif keysResource == 'F_RealCarKeysSystem' then
        TriggerServerEvent('F_RealCarKeysSystem:generateVehicleKeys', plate)

    elseif keysResource == 'fivecode_carkeys' then
        exports.fivecode_carkeys:GiveKey(vehicle, false, true)

    elseif keysResource == 'mk_vehiclekeys' then
        exports['mk_vehiclekeys']:AddKey(vehicle)

    elseif keysResource == 'MrNewbVehicleKeys' then
        exports['MrNewbVehicleKeys']:GiveKeysByPlate(plate)

    elseif keysResource == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(plate, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), true)

    elseif keysResource == 'stasiek_vehiclekeys' then
        if vehicle then
            DecorSetInt(vehicle, 'owner', GetPlayerServerId(PlayerId()))
        end

    elseif keysResource == 't1ger_keys' then
        exports['t1ger_keys']:GiveTemporaryKeys(plate, GetLabelText(GetDisplayNameFromVehicleModel(vehicle)), type)

    elseif keysResource == 'tgiann-hotwire' then
        exports['tgiann-hotwire']:GiveKeyPlate(plate, true)

    elseif keysResource == 'ti_vehicleKeys' then
        exports['ti_vehicleKeys']:addTemporaryVehicle(plate)

    elseif keysResource == 'vehicles_keys' then
        TriggerServerEvent('vehicles_keys:selfGiveVehicleKeys', plate)

    elseif keysResource == 'wasabi_carlock' then
        exports['wasabi_carlock']:GiveKey(plate)

    elseif keysResource == 'xd_locksystem' then
        --exports['xd_locksystem']:givePlayerKeys(plate) -- v1
        exports['xd_locksystem']:SetVehicleKey(plate) -- v2

    elseif keysResource == 'qbx_vehiclekeys' then
        TriggerServerEvent('qbx_vehiclekeys:server:tookKeys', NetworkGetNetworkIdFromEntity(vehicle))

    elseif keysResource == 'qb-vehiclekeys' then
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)

    elseif keysResource == 'other' then
        --- Implement other vehicle keys give method here.

    elseif keysResource == 'none' then

    end
end