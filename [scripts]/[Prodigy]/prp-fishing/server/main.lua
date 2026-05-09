SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Debug and "debug" or "info")

lib.callback.register("prp-fishing:getItemData", function(_, itemName)
    return bridge.inv.getItemData(itemName)
end)

local function startup()
    Wait(100)
    TriggerEvent("prp-fishing:server:ready")
end
SetTimeout(0, startup)
