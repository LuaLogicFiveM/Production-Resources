Framework = {}

local ESX = exports.es_extended:getSharedObject()

function Framework.GetPlayer(source)
    return ESX.GetPlayerFromId(source) or nil
end

function Framework.GetPlayerIdentifier(player)
    return player and player.identifier or nil
end

function Framework.Notify(source, title, message, type, duration)
    duration = duration or 5000
    TriggerClientEvent('ox_lib:notify', source, {
        title = title,
        description = message,
        type = type,
        duration = duration
    })
end

function Framework.RegisterCallback(name, callback)
    ESX.RegisterServerCallback(name, callback)
end

function Framework.TriggerCallback(name, callback, ...)
    ESX.TriggerServerCallback(name, callback, ...)
end

function Framework.GetPlayerName(source)
    return GetPlayerName(source)
end

function Framework.HasPermission(source, permission)
    local player = Framework.GetPlayer(source)
    return player and player.getGroup() == 'owner' or false
end