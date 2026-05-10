
local function sendUI(action, data)
    SendNUIMessage({ action = action, data = data })
end

local function setFocus(on, keepInput)
    SetNuiFocus(on, on)
    SetNuiFocusKeepInput(keepInput or false)
end

local widgetOn   = true
local interacting = false

CreateThread(function()
    sendUI('config',    { widgetMax = (Config.Widget and Config.Widget.MaxOptions) or 5 })
    sendUI('setWidget', { on = widgetOn })

    local active = lib.callback.await('lorp_polls:getActive', false)
    sendUI('syncVotes', { data = active or {} })
end)

RegisterNetEvent('lorp_polls:push', function(payload)
    if type(payload) ~= 'table' then return end
    if not lib.callback.await('lorp_polls:validatePush', false, payload) then return end

    local kind = payload.kind

    if kind == 'state' and payload.vote then
        sendUI('syncVote', { data = payload.vote })
        if widgetOn then sendUI('setWidget', { on = true }) end

    elseif kind == 'announce' and payload.text then
        sendUI('announce', { text = payload.text, ts = payload.ts })

    elseif kind == 'ended' then
        interacting = false
        setFocus(false, false)
        sendUI('setInteract', { on = false })
        sendUI('hideWidget', {})

    elseif kind == 'visibility' then
        widgetOn = payload.on and true or false
        sendUI('setWidget', { on = widgetOn })

    elseif kind == 'openCreate' then
        setFocus(true, false)
        sendUI('openCreate', {})

    elseif kind == 'interact' then
        if not lib.callback.await('lorp_polls:canInteract', false) then return end
        interacting = not interacting
        if interacting then
            if not widgetOn then
                widgetOn = true
                sendUI('setWidget', { on = widgetOn })
            end
            setFocus(true, false)
            sendUI('setInteract', { on = true })
        else
            setFocus(false, false)
            sendUI('setInteract', { on = false })
        end

    elseif kind == 'toggle' then
        widgetOn = not widgetOn
        sendUI('setWidget', { on = widgetOn })
    end
end)

RegisterNUICallback('submitVote', function(data, cb)
    if type(data) ~= 'table' or not data.id or not data.option then cb({}) return end
    lib.callback.await('lorp_polls:submit', false, data)
    setFocus(false, false)
    sendUI('setInteract', { on = false })
    interacting = false
    cb({})
end)

RegisterNUICallback('createVote', function(data, cb)
    if type(data) ~= 'table' or type(data.options) ~= 'table' or #data.options < 2 then cb({}) return end
    lib.callback.await('lorp_polls:create', false, data)
    setFocus(false, false)
    sendUI('closeAll', {})
    cb({})
end)

RegisterNUICallback('close', function(_, cb)
    setFocus(false, false)
    sendUI('closeAll', {})
    cb({})
end)

RegisterNUICallback('hoverOn',  function(_, cb) cb({}) end)
RegisterNUICallback('hoverOff', function(_, cb) cb({}) end)