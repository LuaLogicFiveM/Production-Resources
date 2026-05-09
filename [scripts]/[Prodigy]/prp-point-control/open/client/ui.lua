ui = {}

---@param app string
---@param action string
---@param payload any
local function sendMessage(app, action, payload)
    SendNUIMessage({
        event = "sendAppEvent",
        app = app,
        action = action,
        payload = payload or {},
    })
end

function ui.setVisible(visible)
    sendMessage("pointControl", "setVisible", visible)
end

function ui.setTeams(teams)
    sendMessage("pointControl", "setTeams", teams)
end

function ui.setPoints(points)
    sendMessage("pointControl", "setPoints", points)
end

function ui.setNotification(message)
    sendMessage("pointControl", "setNotification", message)
end