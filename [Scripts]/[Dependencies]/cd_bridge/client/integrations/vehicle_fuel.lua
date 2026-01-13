--- @param vehicle number       The vehicle entity.
--- @param plate string         The vehicle plate.
--- @return number|nil          --The fuel level of the vehicle, 0.0-100.0.
function GetFuel(vehicle, plate) -- This gets triggered just before you store your vehicle.
    local fuelResource = Cfg.VehicleFuel
    if fuelResource == 'BigDaddy-Fuel' then
        return exports['BigDaddy-Fuel']:GetFuel(vehicle)

    elseif fuelResource == 'cdn-fuel' then
        return exports['cdn-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'esx-sna-fuel' then
        return exports['esx-sna-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'FRFuel' then
        return math.ceil((100 / GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fPetrolTankVolume')) * math.ceil(GetVehicleFuelLevel(vehicle)))

    elseif fuelResource == 'lc_fuel' then
        return exports['lc_fuel']:GetFuel(vehicle)

    elseif fuelResource == 'LegacyFuel' then
        return exports['LegacyFuel']:GetFuel(vehicle)

    elseif fuelResource == 'lj-fuel' then
        return exports['lj-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'lyre_fuel' then
        exports['lyre_fuel']:GetFuel(vehicle)

    elseif fuelResource == 'mnr_fuel' then
        return GetVehicleFuelLevel(vehicle)

    elseif fuelResource == 'myFuel' then
        return exports['myFuel']:GetFuel(vehicle)

    elseif fuelResource == 'ND_Fuel' then
        return DecorGetFloat(vehicle, '_ANDY_FUEL_DECORE_')

    elseif fuelResource == 'okokGasStation' then
        return exports['okokGasStation']:GetFuel(vehicle)

    elseif fuelResource == 'ox_fuel' then
        return GetVehicleFuelLevel(vehicle)

    elseif fuelResource == 'ps-fuel' then
        return exports['ps-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'qb-sna-fuel' then
        return exports['qb-sna-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'qs-fuelstations' then
        return exports['qs-fuelstations']:GetFuel(vehicle)

    elseif fuelResource == 'rcore_fuel' then
        return exports['rcore_fuel']:GetVehicleFuelPercentage(vehicle)

    elseif fuelResource == 'Renewed-Fuel' then
        return Entity(vehicle).state.fuel

    elseif fuelResource == 'ti_fuel' then
        return exports['ti_fuel']:getFuel(vehicle)

    elseif fuelResource == 'x-fuel' then
        return exports['x-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'qb-fuel' then
        return exports['qb-fuel']:GetFuel(vehicle)

    elseif fuelResource == 'other' then
        --- Implement other fuel get method here.
        return 100.0

    elseif fuelResource == 'none' then
        return nil
    end
end

--- @param vehicle number        The vehicle entity.
--- @param fuel_level number     The fuel level to set, 0.0-100.0.
function SetFuel(vehicle, plate, fuel_level) -- This gets triggered after you spawn your vehicle.
    local fuel_level = fuel_level+0.0
    local fuelResource = Cfg.VehicleFuel

    if fuelResource == 'BigDaddy-Fuel' then
        exports['BigDaddy-Fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'cdn-fuel' then
        exports['cdn-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'esx-sna-fuel' then
        exports['esx-sna-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'FRFuel' then
        SetVehicleFuelLevel(vehicle, fuel_level)

    elseif fuelResource == 'lc_fuel' then
        exports['lc_fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'LegacyFuel' then
        exports['LegacyFuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'lj-fuel' then
        exports['lj-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'lyre_fuel' then
        exports['lyre_fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'mnr_fuel' then
        Entity(vehicle).state.fuel = fuel_level

    elseif fuelResource == 'myFuel' then
        exports['myFuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'ND_Fuel' then
        SetVehicleFuelLevel(vehicle, fuel_level)
        DecorSetFloat(vehicle, '_ANDY_FUEL_DECORE_', fuel_level)

    elseif fuelResource == 'okokGasStation' then
        exports['okokGasStation']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'ox_fuel' then
        Entity(vehicle).state.fuel = fuel_level

    elseif fuelResource == 'ps-fuel' then
        exports['ps-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'qb-fuel' then
        exports['qb-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'qb-sna-fuel' then
        exports['qb-sna-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'qs-fuelstations' then
        exports['qs-fuelstations']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'rcore_fuel' then
        exports['rcore_fuel']:SetVehicleFuel(vehicle, fuel_level)

    elseif fuelResource == 'Renewed-Fuel' then
        exports['Renewed-Fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'ti_fuel' then
        exports['ti_fuel']:setFuel(vehicle, fuel_level, 'RON91')

    elseif fuelResource == 'x-fuel' then
        exports['x-fuel']:SetFuel(vehicle, fuel_level)

    elseif fuelResource == 'other' then
        --- Implement other fuel set method here.

    elseif fuelResource == 'none' then

    end
end