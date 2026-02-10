local ROUTES = {}

function RegisterServerCallback(action, fn)
    ROUTES[action] = fn
end

RegisterNetEvent('cd_bridge:Callback', function(id, action, ...)
    local src = source
    local handler = ROUTES[action]
    local function respond(success, data, error_message)
        TriggerClientEvent('cd_bridge:Callback', src, id, success, data, error_message)
    end

    if not handler then
        respond(false, nil, 'callback_not_registered')
        return
    end

    local ok_exec, result = pcall(handler, src, ...)
    if not ok_exec then
        respond(false, nil, ('error_in_handler - %s'):format(result))
    else
        respond(true, result, nil)
    end
end)

RegisterServerCallback('cd_bridge:GetSharedVehicles', function(src, ...)
    return GetSharedVehicles()
end)

RegisterServerCallback('cd_bridge:GetAdminPerms', function(src, ...)
    return GetAdminPerms(src)
end)

RegisterServerCallback('cd_bridge:HasAdminPerms', function(src, ...)
    return HasAdminPerms(src, ...)
end)

RegisterServerCallback('cd_bridge:GetCharacterName', function(src, ...)
    return GetCharacterName(src)
end)

RegisterServerCallback('cd_bridge:KickOutPlayersInVehicle', function(src, ...)
    local players, netID = ...
    local entID = NetworkGetEntityFromNetworkId(netID)
    local vehicle = entID and DoesEntityExist(entID) and entID or nil
    for _, source in pairs(players) do
        if source and source ~= 0 then
            local ped = GetPlayerPed(source)
            if vehicle then
                TaskLeaveVehicle(ped, vehicle, 256)
                TaskLeaveAnyVehicle(ped, 0, 0)
            else
                local coords = GetEntityCoords(ped)
                SetEntityCoords(ped, coords.x, coords.y, coords.z + 5.0)
            end
        end
    end
    return true
end)