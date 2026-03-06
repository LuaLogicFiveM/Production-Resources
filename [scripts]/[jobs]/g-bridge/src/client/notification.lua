NOTIFICATION = function(message, type, duration)
    if not type then
        type = "success"
    end
    if not duration then
        duration = 5000
    end

    if not _G.NotificationDetected then
        _G.DetectNotificationSystem()
    end

    local notifType = _G.Notification or _G.DetectNotificationSystem()

    if notifType == "g-notifications" then
        exports["g-notifications"]:Notify({
            title = "Notification",
            description = message,
            type = type,
            duration = duration,
            position = "top-right"
        })
    elseif notifType == "okokNotify" then
        exports.okokNotify:Alert(type, message, duration, type, false)
    elseif notifType == "qbox" then
        if type == "info" then
            type = "primary"
        end
        if QBCore and QBCore.Functions then
            QBCore.Functions.Notify(message, type, duration)
        else
            exports["qbox"]:Notify(message, type, duration)
        end
    elseif notifType == "qb-notify" then
        exports["qb-notify"]:Notify(message, type, duration)
    elseif notifType == "ox-lib" then
        exports["ox_lib"]:notify({
            title = "Notification",
            description = message,
            type = type,
            duration = duration,
            position = "top-right"
        })
    elseif notifType == "mythic_notify" then
        exports["mythic_notify"]:SendAlert(type, message, duration)
    elseif notifType == "esx" then
        if ESX then
            ESX.ShowNotification(message)
        else
            AddTextEntry("g_bridge", message)
            BeginTextCommandThefeedPost("g_bridge")
            EndTextCommandThefeedPostTicker(false, true)
        end
    elseif notifType == "lation_ui" then
        exports.lation_ui:notify({
            title = "Notification",
            message = message,
            type = type or "success",
            duration = duration,
            position = 'top-right'
        })
    elseif notifType == "wasabi_notify" then
        exports.wasabi_notify:notify("Notification", message, duration, type)
    elseif notifType == "gta-default" then
        AddTextEntry("g_bridge", message)
        BeginTextCommandThefeedPost("g_bridge")
        EndTextCommandThefeedPostTicker(false, true)
    else
        AddTextEntry("g_bridge", message)
        BeginTextCommandThefeedPost("g_bridge")
        EndTextCommandThefeedPostTicker(false, true)
    end
end
