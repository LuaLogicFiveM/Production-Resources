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
        respond(false, nil, ('handler_error - %s'):format(result))
    else
        respond(true, result, nil)
    end
end)

RegisterServerCallback('cd_bridge:GetSharedVehicles', function(source)
    return GetSharedVehicles()
end)