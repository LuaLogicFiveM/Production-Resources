bridge.fw.registerCommand(SvConfig.Mail.adminMenu.command, locale("commands.mail.admin.help"), {}, SvConfig.Mail.adminMenu.permission, function(source)
    TriggerClientEvent("prp-pettycrime:client:adminMailMenu", source)
end)

lib.callback.register('prp-pettycrime:server:adminMailGetData', function(playerId)
    if not bridge.fw.isAdmin(playerId) then
        return
    end

    return GetMailNpcLocation()
end)

RegisterNetEvent('prp-pettycrime:server:adminMailNextLocation', function()
    local playerId = source

    if not bridge.fw.isAdmin(playerId) then
        return
    end

    NextLetterNPCLocation()
end)
