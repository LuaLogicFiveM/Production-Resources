ui = {}

local function nuiMessage(action, payload)
    SendNuiMessage(json.encode({
        event = "sendAppEvent",
        app = 'horde',
        action = action,
        payload = payload
    }))
end

function ui.setFocus(hasFocus, hasCursor)
    SetNuiFocus(hasFocus, hasCursor)
end

function ui.setNotification(payload)
    nuiMessage('setNotification', payload)
end

function ui.sendNUIMessage(payload)
    SendNUIMessage(payload)
end