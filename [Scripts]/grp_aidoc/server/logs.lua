local WEBHOOK_URL = 'https://discord.com/api/webhooks/1369868353426030693/TQ6Rx-V-mkdqFtkFJrrUbvMYmT09quiULVz02UxXY8MpJaRb3V0mtvB9gaM-RKXl3gNY'

local COLORS = {
    EMS_CALL = 16711680,  -- Red
    REVIVE = 65280,       -- Green
    INFO = 255            -- Blue
}

local function debugPrint(message)
    if Config.Debug then
        print('[GRP AI Doctor Logs - Debug] ' .. message)
    end
end

local function GetPlayerInfo(source)
    local firstname, lastname = GRP.GetPlayerName(source)
    if not firstname or not lastname then 
        debugPrint('Failed to get player info for source: ' .. source)
        return nil 
    end

    debugPrint('Got player info for: ' .. firstname .. ' ' .. lastname)
    return {
        name = firstname .. ' ' .. lastname,
        citizenid = GRP.GetIdentifier(source),
        source = source
    }
end

local function FormatLocation(coords)
    if not coords then return "Unknown" end
    return string.format("X: %.2f, Y: %.2f, Z: %.2f", coords.x, coords.y, coords.z)
end

local function SendToDiscord(title, description, color)
    debugPrint('Sending Discord webhook: ' .. title)
    
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = " I Doctor V2 | " .. os.date("%Y-%m-%d %H:%M:%S")
            },
            ["thumbnail"] = {
                ["url"] = "https://r2.fivemanage.com/LDQTygtOvrin949qtfwJG/grp_store.png"
            }
        }
    }

    PerformHttpRequest(WEBHOOK_URL, function(err, text, headers)
        if err == 204 then
            debugPrint('Webhook sent successfully (Status: 204 No Content)')
        elseif err then
            debugPrint('Error sending webhook - Status: ' .. tostring(err) .. (text and ' Response: ' .. text or ''))
        else
            debugPrint('Webhook sent successfully')
        end
    end, 'POST', json.encode({
        username = "AI Doctor",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

local function LogEMSCall(source, vehicleType, payment, paymentMethod)
    debugPrint('Logging EMS call for source: ' .. source)
    
    local playerInfo = GetPlayerInfo(source)
    if not playerInfo then return end

    local coords = GetEntityCoords(GetPlayerPed(source))
    local location = FormatLocation(coords)

    local description = string.format(
        "**Player Information**\n" ..
        "Name: %s\n" ..
        "Citizen ID: %s\n" ..
        "Server ID: %s\n\n" ..
        "**Call Details**\n" ..
        "Vehicle Type: %s\n" ..
        "Location: %s\n\n" ..
        "**Payment Details**\n" ..
        "Amount: $%s\n" ..
        "Method: %s",
        playerInfo.name,
        playerInfo.citizenid,
        playerInfo.source,
        vehicleType,
        location,
        payment,
        paymentMethod
    )

    SendToDiscord("AI EMS Call", description, COLORS.EMS_CALL)
end

local function LogRevive(source, payment, paymentMethod)
    debugPrint('Logging revive for source: ' .. source)
    
    local playerInfo = GetPlayerInfo(source)
    if not playerInfo then return end

    local coords = GetEntityCoords(GetPlayerPed(source))
    local location = FormatLocation(coords)

    local description = string.format(
        "**Player Information**\n" ..
        "Name: %s\n" ..
        "Citizen ID: %s\n" ..
        "Server ID: %s\n\n" ..
        "**Location**\n" ..
        "%s\n\n" ..
        "**Payment Details**\n" ..
        "Amount: $%s\n" ..
        "Method: %s",
        playerInfo.name,
        playerInfo.citizenid,
        playerInfo.source,
        location,
        payment,
        paymentMethod
    )

    SendToDiscord("AI EMS Revive", description, COLORS.REVIVE)
end

exports('LogEMSCall', LogEMSCall)
exports('LogRevive', LogRevive) 