Bridge = Bridge or {}
local BridgeExport = nil

CreateThread(function()
    local attempts = 0
    while not BridgeExport and attempts < 30 do
        local ok, result = pcall(function()
            return exports['community_bridge']:Bridge()
        end)
        if ok and result then
            BridgeExport = result
        else
            attempts = attempts + 1
            Wait(1000)
        end
    end
end)

function Bridge.Notify(message, type)
    if BridgeExport then
        pcall(BridgeExport.Framework.Notify, message, type or 'info', 5000)
    end
end

RegisterNetEvent('eg_killfeed:client:notify', function(message, type)
    Bridge.Notify(message, type)
end)
