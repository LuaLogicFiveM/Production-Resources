local bridgeName = GetCurrentResourceName()

local dependantResources = {
    'cd_dispatch3d',
    'cd_doorlock',
    'cd_eventcalendar',
    'cd_garage',
    'cd_vipshop'
}

local function safeStartResource(resName)
    local state = GetResourceState(resName)
    if Cfg.BridgeDebug then
        Citizen.Trace(('[%s] %s state: %s\n'):format(bridgeName, resName, state))
    end

    if state == 'missing' then
        if Cfg.BridgeDebug then
            Citizen.Trace(('[%s] %s is missing, not starting.\n'):format(bridgeName, resName))
        end
        return
    end

    if state ~= 'started' then
        local ok = StartResource(resName)
        if Cfg.BridgeDebug then
            Citizen.Trace(('[%s] StartResource(%s) -> %s\n'):format(bridgeName, resName, tostring(ok)))
        end
    end
end

AddEventHandler('onResourceStart', function(resName)
    if resName ~= bridgeName then return end

    CreateThread(function()
        Wait(500)

        for _, res in ipairs(dependantResources) do
            safeStartResource(res)
        end
    end)
end)
