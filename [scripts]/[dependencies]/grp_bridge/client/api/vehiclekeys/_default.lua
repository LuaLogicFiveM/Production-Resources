local DefaultVehicleKeysAPI = {}

function DefaultVehicleKeysAPI.GetResourceName()
    return "default"
end

function DefaultVehicleKeysAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end
    SetVehicleDoorsLocked(vehicle, 1)
end

function DefaultVehicleKeysAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end
end

return DefaultVehicleKeysAPI