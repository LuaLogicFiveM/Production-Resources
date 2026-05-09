SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

InventoryHooks = {}

CreateThread(function()
    GenerateOutposts()

    InventoryHooks[#InventoryHooks+1] = bridge.inv.registerSwapItemsHook(function(payload)
        if type(payload.fromSlot) == "table" then
            return lib.table.contains(SvConfig.MoneyItems, payload.fromSlot.name)
        elseif type(payload.toSlot) == "table" then
            return lib.table.contains(SvConfig.MoneyItems, payload.toSlot.name)
        end

        return true
    end, {
        inventoryFilter = {
            "^OUTPOST_DEALER_OUTPUT_[%w]+"
        }
    })

    InventoryHooks[#InventoryHooks + 1] = bridge.inv.registerCreateItemHook(function(payload)
        if not payload.metadata then
            payload.metadata = {}
        end

        if not payload.metadata.durability then
            payload.metadata.durability = 100
        end

        local playerPed = GetPlayerPed(payload.inventoryId)
        if not playerPed or not DoesEntityExist(playerPed) then
            return false
        end

        local playerCoords = GetEntityCoords(playerPed)
        local isCloseToOutpost, data = GetClosestOutpost(playerCoords)
        if not isCloseToOutpost or not data then
            return false
        end

        payload.metadata.outpost = isCloseToOutpost
        payload.metadata.label = data.label
        payload.metadata.description = data.description
        payload.metadata.image = data.image

        return payload.metadata
    end, {
        itemFilter = {
            [Config.Items.exchangeCard] = true
        }
    })
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= cache.resource then return end
    for i = 1, #InventoryHooks do
        bridge.inv.removeHooks(InventoryHooks[i])
    end
end)
