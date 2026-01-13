function setVehicleFuel(vehicle, fuel)
    local fuel = fuel or 100
    if GetResourceState('LegacyFuel') == 'started' then
        exports['LegacyFuel']:SetFuel(vehicle, tonumber(fuel) + 0.0)
    elseif GetResourceState('ps-fuel') == 'started' then
        exports['ps-fuel']:SetFuel(vehicle, tonumber(fuel) + 0.0)
    elseif GetResourceState('rcore_fuel') == 'started' then
        exports['rcore_fuel']:SetFuel(vehicle, tonumber(fuel) + 0.0)
    else
        --custom fuel code here
        SetVehicleFuelLevel(vehicle, 100.0)
    end
end

function givekey(vehicle, plate)
    -- give vehicle key here
    if GetResourceState('ak47_vehiclekeys') == 'started' then
        exports['ak47_vehiclekeys']:GiveKey(plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports['wasabi_carlock']:GiveKey(plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveKeys(plate, GetEntityModel(vehicle))
    elseif GetResourceState('cd_garage') == 'started' then
        TriggerEvent('cd_garage:AddKeys', plate)
    elseif GetResourceState('keys') == 'started' then
        TriggerServerEvent('keys:giveTemporaryKeys', plate, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), 'garage')
    else
        --custom code here
    end
end

function removekey(plate, model)
    -- remove vehicle key here
    if GetResourceState('ak47_vehiclekeys') == 'started' then
        exports['ak47_vehiclekeys']:RemoveKey(plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:RemoveKeys(plate, GetDisplayNameFromVehicleModel(model))
    end
end