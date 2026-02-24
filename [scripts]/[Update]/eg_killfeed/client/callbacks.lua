RegisterNUICallback('close', function(_, cb)
    UI.CloseEditor()
    cb('ok')
end)

RegisterNUICallback('savePreferences', function(data, cb)
    if not data then cb(false) return end
    local result = lib.callback.await('eg_killfeed:server:savePreferences', false, data)
    cb(result)
end)

RegisterNUICallback('getPreferences', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:getPreferences', false)
    cb(result)
end)

RegisterNUICallback('resetStats', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:resetStats', false)
    cb(result)
end)

RegisterNUICallback('testKill', function(_, cb)
    ExecuteCommand('testkill')
    cb('ok')
end)

RegisterNUICallback('getInitialData', function(_, cb)
    if UI.cachedPreferences then
        cb({ preferences = UI.cachedPreferences, stats = UI.cachedStats })
    else
        local result = lib.callback.await('eg_killfeed:server:getInitialData', false)
        cb(result)
    end
end)

RegisterNUICallback('createClan', function(data, cb)
    local result = lib.callback.await('eg_killfeed:server:createClan', false, data.tag, data.name, data.icon, data.color, data.isPrivate)
    cb(result)
end)

RegisterNUICallback('getAllClans', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:getAllClans', false)
    cb(result)
end)

RegisterNUICallback('getClanMembers', function(clanId, cb)
    local result = lib.callback.await('eg_killfeed:server:getClanMembers', false, clanId)
    cb(result)
end)

RegisterNUICallback('getPlayerClan', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:getPlayerClan', false)
    cb(result)
end)

RegisterNUICallback('joinClan', function(clanId, cb)
    local result = lib.callback.await('eg_killfeed:server:joinClan', false, clanId)
    cb(result)
end)

RegisterNUICallback('leaveClan', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:leaveClan', false)
    cb(result)
end)

RegisterNUICallback('removeMember', function(identifier, cb)
    local result = lib.callback.await('eg_killfeed:server:removeMember', false, identifier)
    cb(result)
end)

RegisterNUICallback('updateClan', function(data, cb)
    local result = lib.callback.await('eg_killfeed:server:updateClan', false, data)
    cb(result)
end)

RegisterNUICallback('deleteClan', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:deleteClan', false)
    cb(result)
end)

RegisterNUICallback('getOnlinePlayers', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:getOnlinePlayers', false)
    cb(result)
end)

RegisterNUICallback('invitePlayer', function(targetServerId, cb)
    local result = lib.callback.await('eg_killfeed:server:invitePlayer', false, targetServerId)
    cb(result)
end)

RegisterNUICallback('getMyInvitations', function(_, cb)
    local result = lib.callback.await('eg_killfeed:server:getMyInvitations', false)
    cb(result)
end)

RegisterNUICallback('acceptInvitation', function(invitationId, cb)
    local result = lib.callback.await('eg_killfeed:server:acceptInvitation', false, invitationId)
    cb(result)
end)

RegisterNUICallback('declineInvitation', function(invitationId, cb)
    local result = lib.callback.await('eg_killfeed:server:declineInvitation', false, invitationId)
    cb(result)
end)
