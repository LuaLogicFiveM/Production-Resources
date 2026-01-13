function InVehicle()
    return IsPedInAnyVehicle(PlayerPedId(), false)
end

function GetVehicleModelHash(value)
    if not value or value == 0 then return nil end

    if type(value) == 'string' then
        local hash = joaat(value)
        if IsModelValid(hash) and IsModelAVehicle(hash) then
            return hash
        end
        return nil
    end

    if type(value) ~= 'number' then
        return nil
    end

    if IsModelValid(value) and IsModelAVehicle(value) then
        return value
    end

    local entityType = GetEntityType(value)
    if entityType == 2 then
        local model = GetEntityModel(value)
        if model and model ~= 0 and IsModelValid(model) and IsModelAVehicle(model) then
            return model
        end
    end

    return nil
end

function GetClosestVehicle(maxDistance)
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped, false) then
        return GetVehiclePedIsIn(ped, false)
    end

    local pedCoords = GetEntityCoords(ped)
    local closestVeh, closestDist = nil, maxDistance or 1000

    local vehicles = GetGamePool('CVehicle')

    for cd = 1, #vehicles do
        local veh = vehicles[cd]

        if DoesEntityExist(veh) then
            local vehCoords = GetEntityCoords(veh)
            local dist = #(pedCoords - vehCoords)

            if dist < closestDist then
                closestDist = dist
                closestVeh = veh
            end
        end
    end

    return closestVeh or false
end

function GetVehiclesInArea(maxDistance)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local vehiclesInArea = {}

    local maxDistSq = (maxDistance or 1000)^2

    for _, veh in ipairs(GetGamePool('CVehicle')) do
        if DoesEntityExist(veh) then
            local distSq = #(pedCoords - GetEntityCoords(veh))^2

            if distSq <= maxDistSq then
                vehiclesInArea[#vehiclesInArea + 1] = veh
            end
        end
    end

    return vehiclesInArea
end

function GetDefaultVehicleLabel(value)
    local model = GetVehicleModelHash(value)

    if not model then
        return Locale('vehicle')
    end

    local label = GetDisplayNameFromVehicleModel(model)
    if not label or label == 'NULL' then
        return Locale('vehicle')
    end

    label = label:lower()
    if label == 'null' or label == 'carnotfound' then
        return Locale('vehicle')
    end

    local text = GetLabelText(label)
    if text and text ~= 'NULL' and text ~= label then
        return CapitalizeFirst(text)
    end

    return CapitalizeFirst(label)
end

function IsVehicleEmpty(vehicle)
    if not DoesEntityExist(vehicle) or not IsEntityAVehicle(vehicle) then
        return false
    end

    return GetVehicleNumberOfPassengers(vehicle) == 0 and IsVehicleSeatFree(vehicle, -1)
end
