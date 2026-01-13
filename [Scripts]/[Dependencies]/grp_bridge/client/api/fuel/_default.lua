local DefaultFuelAPI = {}

function DefaultFuelAPI.GetResourceName()
    return "default"
end

function DefaultFuelAPI.GetFuel(vehicle)
    if not DoesEntityExist(vehicle) then return 0.0 end
    return GetVehicleFuelLevel(vehicle)
end

function DefaultFuelAPI.SetFuel(vehicle, fuel, fuelType)
    if not DoesEntityExist(vehicle) then return end
    SetVehicleFuelLevel(vehicle, fuel)
end

function DefaultFuelAPI.GetFuelCapacity(vehicle)
    return 65.0
end

return DefaultFuelAPI