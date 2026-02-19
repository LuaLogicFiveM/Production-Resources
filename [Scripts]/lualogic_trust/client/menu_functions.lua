function GetStatus(status)
    if status == 'owner_set' then
        if GlobalState.owner_set then
            return 'lock-open', 'green'
        else
            return 'lock', 'red'
        end
    elseif status == 'owner_trade' then
        if GlobalState.owner_trade then
            return 'lock-open', 'green'
        else
            return 'lock', 'red'
        end
    elseif status == 'owner_remove' then
        if GlobalState.owner_remove then
            return 'lock-open', 'green'
        else
            return 'lock', 'red'
        end
    elseif status == 'owner_clear' then
        if GlobalState.owner_clear then
            return 'lock-open', 'green'
        else
            return 'lock', 'red'
        end
    elseif status == 'trust_set' then
        if GlobalState.trust_set then
            return 'lock-open', 'gold'
        else
            return 'lock', 'red'
        end
    elseif status == 'trust_give' then
        if GlobalState.trust_give then
            return 'lock-open', 'gold'
        else
            return 'lock', 'red'
        end
    elseif status == 'trust_remove' then
        if GlobalState.trust_remove then
            return 'lock-open', 'gold'
        else
            return 'lock', 'red'
        end
    elseif status == 'trust_clear' then
        if GlobalState.trust_clear then
            return 'lock-open', 'gold'
        else
            return 'lock', 'red'
        end
    elseif status == 'trust_trade' then
        if GlobalState.trust_trade then
            return 'lock-open', 'gold'
        else
            return 'lock', 'red'
        end
    elseif status == 'search_name' then
        if GlobalState.search_name then
            return 'lock-open', 'lightblue'
        else
            return 'lock', 'red'
        end
    elseif status == 'search_vehicle' then
        if GlobalState.search_vehicle then
            return 'lock-open', 'lightblue'
        else
            return 'lock', 'red'
        end
    elseif status == 'search_identifier' then
        if GlobalState.search_identifier then
            return 'lock-open', 'lightblue'
        else
            return 'lock', 'red'
        end
    end
end

function SpawnVehicle(vehicleModel, coords, heading, networked)
    local model = type(vehicleModel) == 'number' and vehicleModel or joaat(vehicleModel)
    local vector = type(coords) == "vector3" and coords or false
    local isnetworked = networked == nil and true or networked

    local playerCoords = GetEntityCoords(cache.ped)
    if not vector or not playerCoords then return end

    local dist = #(playerCoords - vector)
    if dist > 424 then
        return DebugPrint("Tried to spawn vehicle on the client but the position is too far away (Out of onesync range).")
    end

    CreateThread(function()
        if not IsModelInCdimage(model) then
            return Notify('This vehicle is not in the server, please make a ticket if this was in the server previously.', 'error')
        end

        lib.requestModel(model, 15000)

        local vehicle = CreateVehicle(model, vector.x, vector.y, vector.z, heading, isnetworked, true)

        if isnetworked then
            SetEntityAsMissionEntity(vehicle, true, true)
        end

        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetModelAsNoLongerNeeded(model)
        SetVehRadioStation(vehicle, 'OFF')
        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)

        RequestCollisionAtCoord(vector.x, vector.y, vector.z)
        while not HasCollisionLoadedAroundEntity(vehicle) do
            Wait(0)
        end
    end)
end