local CB_SEQ = 0
local PENDING = {}

RegisterNetEvent('cd_bridge:Callback', function(id, success, data, error_message)
    if Cfg.BridgeDebug then
        Citizen.Trace(('cd_bridge:Callback reply | id=%s | success=%s | data=%s (%s)\n'):format(tostring(id), tostring(success), tostring(data), type(data)))
    end

    local entry = PENDING[id]
    if not entry then return end
    if entry.cancel then entry.cancel() end

    PENDING[id] = nil
    entry.promise:resolve({ success = success, data = data, error_message = error_message })
end)

local function setTimeout(ms, fn)
    local active = true
    CreateThread(function()
        local t = GetGameTimer() + ms
        while active and GetGameTimer() < t do
            Wait(0)
        end
        if active then fn() end
    end)
    return function() active = false end
end

function Callback(action, ...)
    CB_SEQ = CB_SEQ + 1
    local id = CB_SEQ

    local p = promise.new()
    local cancel = setTimeout(5000, function()
        if PENDING[id] then
            local pr = PENDING[id].promise
            PENDING[id] = nil
            pr:resolve({
                success = false,
                data = nil,
                error_message = 'timed_out_after_5000ms',
            })
        end
    end)

    PENDING[id] = { promise = p, cancel = cancel }
    TriggerServerEvent('cd_bridge:Callback', id, action, ...)

    local result = Citizen.Await(p)

    if not result.success then
        local err = result.error_message or 'unknown'
        ERROR('1201', 'Callback Failed: ('..action..') - '..err)
        return nil
    end

    return result.data
end