RegisterCommand(Config.commandMute, function(source, args, rawCommand)
    Muted = not Muted
    TriggerEvent("EVO:evo_sound:client:streamerMode", Muted)
    if Muted then
        TriggerEvent('chat:addMessage', { args = { "^1[".. GetTranslationKey('scriptname') .."]", GetTranslationKey('chat:muted') } })
    else
        TriggerEvent('chat:addMessage', { args = { "^1[".. GetTranslationKey('scriptname') .."]", GetTranslationKey('chat:unmuted') } })
    end
end, false)