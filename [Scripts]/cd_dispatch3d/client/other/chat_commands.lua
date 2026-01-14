if Config.small_ui.ENABLE then
    RegisterKeyMapping(Config.small_ui.command, Locale('dispatchsmall_description'), 'keyboard', Config.small_ui.key)
    TriggerEvent('chat:addSuggestion', '/' .. Config.small_ui.command, Locale('dispatchsmall_description'))
    RegisterCommand(Config.small_ui.command, function()
        TriggerEvent('cd_dispatch:KEY_smallui')
    end, false)
end

if Config.large_ui.ENABLE then
    RegisterKeyMapping(Config.large_ui.command, Locale('dispatchlarge_description'), 'keyboard', Config.large_ui.key)
    TriggerEvent('chat:addSuggestion', '/' .. Config.large_ui.command, Locale('dispatchlarge_description'))
    RegisterCommand(Config.large_ui.command, function()
        TriggerEvent('cd_dispatch:KEY_largeui')
    end, false)
end

if Config.respond.ENABLE then
    RegisterKeyMapping(Config.respond.command, Locale('respond_description'), 'keyboard', Config.respond.key)
    TriggerEvent('chat:addSuggestion', '/' .. Config.respond.command, Locale('respond_description'))
    RegisterCommand(Config.respond.command, function()
        TriggerEvent('cd_dispatch:KEY_responding')
    end, false)
end

if Config.small_ui_left.ENABLE then
    RegisterKeyMapping(Config.small_ui_left.command, Locale('scrollleft_description'), 'keyboard', Config.small_ui_left.key)
    TriggerEvent('chat:addSuggestion', '/' .. Config.small_ui_left.command, Locale('scrollleft_description'))
    RegisterCommand(Config.small_ui_left.command, function()
        DecreaseCount()
    end, false)
end

if Config.small_ui_right.ENABLE then
    RegisterKeyMapping(Config.small_ui_right.command, Locale('scrollright_description'), 'keyboard', Config.small_ui_right.key)
    TriggerEvent('chat:addSuggestion', '/' .. Config.small_ui_right.command, Locale('scrollright_description'))
    RegisterCommand(Config.small_ui_right.command, function()
        IncreaseCount()
    end, false)
end

RegisterKeyMapping('canceltracking', Locale('canceltracking_description'), 'keyboard', 'back')
TriggerEvent('chat:addSuggestion', '/' .. 'canceltracking', Locale('canceltracking_description'))
RegisterCommand('canceltracking', function()
    TriggerServerEvent('cd_dispatch:CancelTracking')
end, false)