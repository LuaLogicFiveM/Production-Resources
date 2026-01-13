function ShowNotification(text)
    local notifType = Config.NotificationType or "default"
    
    if notifType == "custom" then
        -- Custom notification (from your notify.lua)
        exports['notify']:CustomNotify(text)
    
    elseif notifType == "esx" then
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification(text)
        else
            print("[ERROR] ESX Notification system not available!")
        end

    elseif notifType == "qbcore" then
        if QBCore and QBCore.Functions.Notify then
            -- You can adjust the type ("inform", "error", "success", etc.) and duration as needed
            QBCore.Functions.Notify(text, "inform", 3000)
        else
            print("[ERROR] QBCore Notification system not available!")
        end

    elseif notifType == "pNotify" then
        -- Example for pNotify. Adjust the parameters if needed.
        exports['pNotify']:SendNotification({
            text = text,
            type = "info",
            timeout = 3000,
            layout = "bottomCenter"
        })

    elseif notifType == "mythic_notify" then
        -- Example for mythic_notify.
        exports['mythic_notify']:DoCustomHudText('inform', text, 5000)

    elseif notifType == "okokNotify" then
        -- Example for okokNotify.
        exports['okokNotify']:Alert("Notification", text, 5000, 'info')

    elseif notifType == "ox_lib" then
        -- Example for ox_lib.
        if lib and lib.notify then
            lib.notify({
                title = "Notification",
                description = text,
                type = "inform",
                duration = 3000
            })
        else
            print("[ERROR] ox_lib notification system not available!")
        end

    else
        -- Default GTA V notification
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        DrawNotification(false, false)
    end
end
