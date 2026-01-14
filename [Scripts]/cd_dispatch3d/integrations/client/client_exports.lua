function GetPlayerInfo()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    -- Retrieve street names
    local streetNames = GetStreetNames(coords)
    local street_1 = streetNames.street1
    local street_2 = streetNames.street2 or ""

    -- Ped sex ('male'/'female'/'person')
    local sex = GetPedSex(ped)

    -- Prepare default vehicle data
    local vehicle, vehicle_label, vehicle_colour, vehicle_plate = nil, nil, nil, nil
    local heading_str, speed = nil, 0.0

    -- Check if ped is in a vehicle
    if IsPedInAnyVehicle(ped, false) then
        vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle and vehicle ~= 0 then
            vehicle_label  = GetVehicleLabel(vehicle)
            vehicle_colour = GetVehicleColour(vehicle)
            vehicle_plate  = GetPlate(vehicle)
            heading_str    = GetHeading(GetEntityHeading(ped))
            speed          = GetEntitySpeed(vehicle) * 2.236936 -- m/s to mph
        end
    else
        -- If not in a vehicle, see if one is nearby
        vehicle = GetClosestVehicle(5.0)
        if vehicle then
            vehicle_label  = GetVehicleLabel(vehicle)
            vehicle_colour = GetVehicleColour(vehicle)
            vehicle_plate  = GetPlate(vehicle)
        end
    end

    return {
        ped            = ped,
        coords         = coords,
        street_1       = street_1,
        street_2       = street_2,
        street         = street_1 .. ', ' .. street_2,
        sex            = sex,
        vehicle        = vehicle,
        vehicle_label  = vehicle_label,
        vehicle_colour = vehicle_colour,
        vehicle_plate  = vehicle_plate,
        heading        = heading_str,
        speed          = speed
    }
end

function GetConfig()
    return Config
end

function GetAllDispatchNotifications()
    return self
end

function GetPlayersDispatchData()
    return PlayerData
end