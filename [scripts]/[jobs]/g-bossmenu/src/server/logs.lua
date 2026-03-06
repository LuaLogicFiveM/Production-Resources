LOGS = {}
function LogToDiscord(title, description, color, webhook, footer, fields, author)
    if not webhook or webhook == "CHANGEME" or webhook == "" then
        if Config.SystemSettings.Debug then
            print("^3[g-bossmenu]^7 " .. (LAN("no_webhookk") or "Webhook not configured. Skipping log."))
        end
        return
    end

    local embed = {
        {
            title = title,
            description = description,
            color = color or 16777215,
            footer = {
                text = footer or os.date("%Y-%m-%d %H:%M:%S"),
            },
            fields = fields or {},
            author = author or nil,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        },
    }

    PerformHttpRequest(
        webhook,
        function(err, text, headers)
            if err ~= 204 and err ~= 200 then
                print("^1[g-bossmenu]^7 Error sending webhook: " .. err)
            end
        end,
        "POST",
        json.encode({
            username = "Groot Logs",
            embeds = embed,
        }),
        {
            ["Content-Type"] = "application/json",
        }
    )
end

function LOGS.VEHICLE_PURCHASE(src, plate, vehicleData, jobInfo)
    local player = G.Server.GetPlayer(src)
    if not player then return end

    local identifier = G.Server.GetIdentifier(src)
    local playerName = G.Server.GetPlayerName(src)

    local logConfig = SV_CONFIG.DiscordLogs.Logs['VEHICLE_PURCHASE'][jobInfo.name]
    if not logConfig or not logConfig.enable then return end

    local webhook = logConfig.webhook
    if not webhook or webhook == "CHANGEME" or webhook == "" then
        return
    end

    local fields = {
        {
            name = "**Vehicle Model**",
            value = vehicleData.label or "Unknown",
            inline = true
        },
        {
            name = "**Plate**",
            value = plate or "Unknown",
            inline = true
        },
        {
            name = "**Price**",
            value = Config.BossMenuSettings.CurrencySymbol .. (vehicleData.price or 0),
            inline = true
        },
        {
            name = "**Player Name**",
            value = playerName or "Unknown",
            inline = true
        },
        {
            name = "**Grade**",
            value = jobInfo.gradeLabel or jobInfo.grade or "Unknown",
            inline = true
        }
    }

    local title = LAN("log_vehicle_purchased_title")
    local description = LAN("log_vehicle_purchased_description", playerName, jobInfo.label or jobInfo.name)

    LogToDiscord(title, description, 3066993, webhook, nil, fields, nil)
end

function LOGS.TRANSACTIONS(logData)
    local logConfig = SV_CONFIG.DiscordLogs.Logs['TRANSACTIONS'][logData.job]
    if not logConfig or not logConfig.enable then return end

    local webhook = logConfig.webhook
    if not webhook or webhook == "CHANGEME" or webhook == "" then
        return
    end

    local fields = {
        {
            name = "**" .. LAN("log_transactions_type") .. "**",
            value = logData.type or "Unknown",
            inline = true
        },
        {
            name = "**" .. LAN("log_transactions_amount") .. "**",
            value = Config.BossMenuSettings.CurrencySymbol .. (logData.amount or 0),
            inline = true
        },
        {
            name = "**" .. LAN("log_transactions_performed_by") .. "**",
            value = logData.performed_by or "Unknown",
            inline = true
        },
        {
            name = "**" .. LAN("log_transactions_notes") .. "**",
            value = logData.notes or "no notes",
            inline = true
        }
    }
    local title = LAN("log_transactions_title")
    LogToDiscord(title, "", 3066993, webhook, nil, fields, nil)
end

function LOGS.EMPLOYEE_ACTIONS(logData)
    local logConfig = SV_CONFIG.DiscordLogs.Logs['EMPLOYEE_ACTIONS'][logData.job]
    if not logConfig or not logConfig.enable then return end
    local webhook = logConfig.webhook
    if not webhook or webhook == "CHANGEME" or webhook == "" then
        return
    end

    local actionType = logData.type or "Unknown"
    local titleKey = "log_employee_actions_title_" .. actionType
    local descKey = "log_employee_actions_description_" .. actionType

    local fields = {
        {
            name = "**" .. LAN("log_employee_actions_type") .. "**",
            value = actionType:gsub("^%l", function(c) return string.upper(c) end) or "Unknown",
            inline = true
        },
        {
            name = "**" .. LAN("log_employee_actions_name") .. "**",
            value = logData.name or "Unknown",
            inline = true
        },
        {
            name = "**" .. LAN("log_employee_actions_performed_by") .. "**",
            value = logData.performed_by or "Unknown",
            inline = true
        }
    }

    if actionType == "hire" or actionType == "promote" then
        table.insert(fields, {
            name = "**" .. LAN("log_employee_actions_grade") .. "**",
            value = logData.grade_name or "Unknown",
            inline = true
        })
    end

    local title = LAN(titleKey) or LAN("log_employee_actions_title")
    local description = ""

    if actionType == "hire" then
        description = LAN(descKey, logData.performed_by, logData.name, logData.grade_name) or
            string.format("**%s** hired %s to grade %s", logData.performed_by or "Unknown", logData.name or "Unknown",
                logData.grade_name or "Unknown")
    elseif actionType == "fire" then
        description = LAN(descKey, logData.performed_by, logData.name) or
            string.format("**%s** fired %s", logData.performed_by or "Unknown", logData.name or "Unknown")
    elseif actionType == "promote" then
        description = LAN(descKey, logData.performed_by, logData.name, logData.grade_name) or
            string.format("**%s** promoted %s to grade %s", logData.performed_by or "Unknown", logData.name or "Unknown",
                logData.grade_name or "Unknown")
    else
        description = LAN("log_employee_actions_description", logData.performed_by, logData.name) or
            string.format("**%s** performed action on %s", logData.performed_by or "Unknown", logData.name or "Unknown")
    end

    LogToDiscord(title, description, 3066993, webhook, nil, fields, nil)
end
