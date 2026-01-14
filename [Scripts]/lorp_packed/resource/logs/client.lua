lib.onCache('vehicle', function(vehicle)
    if vehicle then
        local vehicleMass = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fMass')
        local vehicleForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveForce')
        if vehicleMass > 8000 and vehicleForce > 0.8 then
            local gameName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            local data = {force = vehicleForce, mass = vehicleMass, model = gameName}
            TriggerServerEvent('lorp_packed:server:handling', data)
        end
    end
end)

lib.callback.register('lorp_packed:client:requestVehicleModel', function(vehicle)
    local gameName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    return gameName or 'Couldn\'t find model'
end)