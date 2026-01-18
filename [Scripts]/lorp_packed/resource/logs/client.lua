local ignored_models = {
    ['kosatka'] = true,
    ['tug'] = true,
}

local limitations = {
    mass = 5000,
    force = 0.7,
    inertia = 1.0,
}

lib.onCache('vehicle', function(vehicle)
    if vehicle then
        local vehicleMass = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fMass')
        local vehicleDriveForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveForce')
        local vehicleBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
        local vehicleInertia = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveInertia')

        if vehicleMass > limitations.mass or vehicleDriveForce > limitations.force or vehicleInertia > limitations.inertia then
            local gameName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

            if not ignored_models[gameName] then
                local data = {driveForce = vehicleDriveForce, brakeForce = vehicleBrakeForce, mass = vehicleMass, model = gameName}
                TriggerServerEvent('lorp_packed:server:handling', data)
            end
        end
    end
end)

lib.callback.register('lorp_packed:client:requestVehicleModel', function(vehicle)
    local gameName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    return gameName or 'Couldn\'t find model'
end)