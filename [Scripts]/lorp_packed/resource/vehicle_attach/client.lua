RegisterCommand("attach", function(source, args)
    local targetModel = args[1]
    if not targetModel then
        lib.notify({title = 'Vehicle Attach', description = "The command was used incorrectly, use /attach [model]", type = 'error', position = 'top'})
        return
    end

    local playerPos = GetEntityCoords(cache.ped)
    local attachVeh = 0

    if cache.vehicle then
        attachVeh = cache.vehicle
    else
        local vehicles = GetGamePool('CVehicle')
        for _, veh in pairs(vehicles) do
            local pos = GetEntityCoords(veh)
            if #(playerPos - pos) < 5.0 then
                attachVeh = veh
                break
            end
        end

        if attachVeh == 0 then
            return lib.notify({title = 'Vehicle Attach', description = 'There is no nearby vehicle to attach', type = 'error', position = 'top'})
        end
    end

    local vehicles = GetGamePool('CVehicle')
    local closestVeh = nil
    local closestDistSq = 50.0 * 50.0

    for _, veh in pairs(vehicles) do
        if veh ~= attachVeh then
            local vehPos = GetEntityCoords(veh)
            local distSq = #(playerPos - vehPos)^2
            if distSq < closestDistSq then
                local model = GetEntityModel(veh)
                if GetDisplayNameFromVehicleModel(model):lower() == targetModel:lower() then
                    closestVeh = veh
                    closestDistSq = distSq
                end
            end
        end
    end

    if closestVeh then
        local offset = GetOffsetFromEntityGivenWorldCoords(closestVeh, GetEntityCoords(attachVeh))
        local rotOffset = GetEntityRotation(attachVeh, 2) - GetEntityRotation(closestVeh, 2)

        SetEntityCollision(attachVeh, false, false)
        AttachEntityToEntity(attachVeh, closestVeh, -1, offset.x, offset.y, offset.z, rotOffset.x, rotOffset.y, rotOffset.z, false, false, false, false, 2, true)

        lib.notify({title = 'Vehicle Attach', description = 'Successfully attached '..targetModel, type = 'success', position = 'top'})

        CreateThread(function()
            Wait(500)
            SetEntityCollision(attachVeh, true, true)
            FreezeEntityPosition(attachVeh, false)
        end)
    else
        lib.notify({title = 'Vehicle Attach', description = 'There was no '..targetModel..' found within 30 units', type = 'error', position = 'top'})
    end
end, false)

RegisterCommand("detach", function()
    if cache.vehicle and IsEntityAttached(cache.vehicle) then
        DetachEntity(cache.vehicle, true, true)
        return lib.notify({title = 'Vehicle Attach', description = 'Successfully detached the vehicle', type = 'success', position = 'top'})
    end

    local playerPos = GetEntityCoords(cache.ped)
    local vehicles = GetGamePool('CVehicle')

    for _, veh in pairs(vehicles) do
        if IsEntityAttached(veh) then
            local pos = GetEntityCoords(veh)
            if #(playerPos - pos) < 5.0 then
                DetachEntity(veh, true, true)
                TaskWarpPedIntoVehicle(cache.ped, veh, -1)
                FreezeEntityPosition(veh, true)
                Wait(100)
                FreezeEntityPosition(veh, false)
                return lib.notify({title = 'Vehicle Attach', description = 'Detached nearby vehicle and entered it', type = 'success', position = 'top'})
            end
        end
    end

    lib.notify({title = 'Vehicle Attach', description = 'There is no nearby vehicle to detach', type = 'error', position = 'top'})
end, false)
