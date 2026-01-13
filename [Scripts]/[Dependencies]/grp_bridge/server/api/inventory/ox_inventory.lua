---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_inventory') == 'missing' then return end

local OXInventoryAPI = {}

local oxInventoryExport
local inventoryContainers = {}
local isInitialized = false

local function initializeOXInventory()
    if isInitialized then return true end
    if GetResourceState('ox_inventory') ~= 'started' then
        DebugPrint("OX-Inventory resource is not started", "error")
        return false
    end

    oxInventoryExport = exports.ox_inventory
    if not oxInventoryExport then
        DebugPrint("Failed to get ox_inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("OX-Inventory initialized successfully", "success")
    end
    isInitialized = true
    return true
end

local function validatePlayerAndItem(src, item, count, operation)
    if not src or not item then
        DebugPrint(string.format("Invalid %s parameters: src=%s, item=%s", operation, tostring(src), tostring(item)), "error")
        return false
    end

    if count and type(count) ~= "number" then
        DebugPrint(string.format("Invalid count type for %s: %s", operation, type(count)), "error")
        return false
    end

    return true
end

local function processInventoryNotification(src, operation, item, count, slot, metadata)
    if not src then return end

    local notificationData = {
        operation = operation,
        item = item,
        count = count or 1,
        slot = slot,
        metadata = metadata,
        timestamp = os.time()
    }

    TriggerClientEvent('grp_bridge:client:inventory:update', src, notificationData)
end

local function handleContainerOperation(containerId, items, operation)
    if not containerId or not items or type(items) ~= "table" then
        DebugPrint("Invalid container operation parameters", "error")
        return false
    end

    local processedItems = 0
    for _, itemData in ipairs(items) do
        if operation == "deposit" then
            local success = oxInventoryExport:AddItem(containerId, itemData.item or itemData.name, itemData.count or 1, itemData.metadata)
            if success then processedItems = processedItems + 1 end
        elseif operation == "withdraw" then
            local success = oxInventoryExport:RemoveItem(containerId, itemData.item or itemData.name, itemData.count or 1, itemData.metadata)
            if success then processedItems = processedItems + 1 end
        end
    end

    return processedItems > 0
end

OXInventoryAPI.GetResourceName = function()
    return "ox_inventory"
end

OXInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeOXInventory() then return false end
    if not validatePlayerAndItem(src, item, count, "AddItem") then return false end

    count = count or 1
    if count <= 0 then return false end

    if not oxInventoryExport:CanCarryItem(src, item, count, metadata) then
        if config.Debug then
            DebugPrint(string.format("Player %s cannot carry %d %s", src, count, item), "warning")
        end
        return false
    end

    local success = oxInventoryExport:AddItem(src, item, count, metadata, slot)
    if success then
        processInventoryNotification(src, "add", item, count, slot, metadata)
    end

    return success
end

OXInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeOXInventory() then return false end
    if not validatePlayerAndItem(src, item, count, "RemoveItem") then return false end

    count = count or 1
    if count <= 0 then return false end

    local success = oxInventoryExport:RemoveItem(src, item, count, metadata, slot)
    if success then
        processInventoryNotification(src, "remove", item, count, slot, metadata)
    end

    return success
end

OXInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeOXInventory() then return false end
    if not validatePlayerAndItem(src, item, requiredCount, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return oxInventoryExport:GetItemCount(src, item, nil, false) >= requiredCount
end

OXInventoryAPI.CanCarryItem = function(src, item, count)
    if not initializeOXInventory() then return false end
    if not validatePlayerAndItem(src, item, count, "CanCarryItem") then return false end

    count = count or 1
    return oxInventoryExport:CanCarryItem(src, item, count)
end

OXInventoryAPI.GetItemInfo = function(item)
    if not initializeOXInventory() then return nil end
    if not item then return {} end

    local itemData = oxInventoryExport:Items(item)
    if not itemData then return {} end

    return {
        name = itemData.name or item,
        label = itemData.label or item:gsub("^%l", string.upper),
        stack = itemData.stack ~= false,
        weight = itemData.weight or 0,
        description = itemData.description or "",
        image = itemData.client and itemData.client.image and
                string.format("nui://ox_inventory/web/images/%s", itemData.client.image) or
                string.format("nui://ox_inventory/web/images/%s.png", item)
    }
end

OXInventoryAPI.Items = function()
    if not initializeOXInventory() then return {} end
    return oxInventoryExport:Items()
end

OXInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeOXInventory() then return 0 end
    if not validatePlayerAndItem(src, item, nil, "GetItemCount") then return 0 end

    -- Try ox_inventory export first
    if oxInventoryExport.GetItemCount then
        local result = oxInventoryExport:GetItemCount(src, item, metadata, false)
        if result ~= nil then
            return result
        end
    end

    -- Fallback: use framework player data
    local Player = Framework.Functions.GetPlayer(src)
    if not Player then return 0 end

    local total = 0
    if Player.PlayerData and Player.PlayerData.items then
        for _, it in pairs(Player.PlayerData.items) do
            if it and it.name == item then
                if not metadata or (it.info and Bridge.Tables.DeepEquals(it.info, metadata)) then
                    total = total + (it.amount or 0)
                end
            end
        end
    end
    return total
end

OXInventoryAPI.GetPlayerInventory = function(src)
    if not initializeOXInventory() then return {} end
    if not src then return {} end

    -- Try ox_inventory export first
    if oxInventoryExport.GetInventoryItems then
        local result = oxInventoryExport:GetInventoryItems(src, false)
        if result then
            return result
        end
    end

    -- Fallback: use framework player data
    local Player = Framework.Functions.GetPlayer(src)
    return Player and Player.PlayerData.items or {}
end

OXInventoryAPI.GetItemBySlot = function(src, slot)
    if not src or not slot then return {} end

    local slotData = oxInventoryExport:GetSlot(src, slot)
    if slotData then
        return {
            name = slotData.name,
            label = slotData.label,
            weight = slotData.weight,
            slot = slotData.slot,
            count = slotData.count,
            metadata = slotData.metadata,
            stack = slotData.stack,
            description = slotData.description
        }
    end

    return {}
end

OXInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not validatePlayerAndItem(src, item, nil, "SetMetadata") or not slot or not metadata then return false end

    oxInventoryExport:SetMetadata(src, slot, metadata)
    return true
end

OXInventoryAPI.GetImagePath = function(item)
    if not item then return "" end

    item = OXInventoryAPI.StripImageExtension(item)
    return string.format("nui://ox_inventory/web/images/%s.png", item)
end

OXInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

OXInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializeOXInventory() then return false end
    if not src or not stashId then return false end

    stashType = stashType or "stash"
    oxInventoryExport:forceOpenInventory(src, stashType, stashId)
end

OXInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializeOXInventory() then return false end
    if not stashId then return false end

    inventoryContainers[stashId] = {
        id = stashId,
        label = label or stashId,
        slots = slots or 50,
        weight = weight or 100000,
        owner = owner,
        groups = groups,
        coords = coords
    }

    oxInventoryExport:RegisterStash(stashId, label, slots, weight, owner, groups, coords)

    if config.Debug then
        DebugPrint(string.format("Registered OX stash: %s", stashId), "info")
    end

    return true
end

OXInventoryAPI.AddStashItems = function(stashId, items)
    return handleContainerOperation(stashId, items, "deposit")
end

OXInventoryAPI.RemoveStashItems = function(stashId, items)
    return handleContainerOperation(stashId, items, "withdraw")
end

OXInventoryAPI.ClearStash = function(stashId, stashType)
    if not stashId then return false end

    if inventoryContainers[stashId] then
        inventoryContainers[stashId] = nil
        if config.Debug then
            DebugPrint(string.format("Cleared OX stash: %s", stashId), "info")
        end
    end

    return true
end

OXInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    if not vehiclePlate or not items then return false end

    local trunkId = string.format("trunk-%s", vehiclePlate)
    return handleContainerOperation(trunkId, items, "deposit")
end

OXInventoryAPI.OpenShop = function(src, shopId)
    if not initializeOXInventory() then return false end
    if not src or not shopId then return false end

    if oxInventoryExport.openInventory then
        oxInventoryExport.openInventory('shop', {id = shopId, type = 'shop'})
        return true
    end

    return false
end

OXInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not initializeOXInventory() then return false end
    if not shopId or not inventory then return false end

    local shopData = {
        id = shopId,
        name = shopId,
        inventory = {},
        locations = coords and {coords, 1.0} or nil,
        groups = groups
    }

    for _, itemData in pairs(inventory) do
        table.insert(shopData.inventory, {
            name = itemData.name,
            price = itemData.price or 0,
            count = itemData.count or 1000,
            metadata = itemData.metadata or {}
        })
    end

    if oxInventoryExport.RegisterShop then
        oxInventoryExport.RegisterShop(shopId, shopData)
    end

    if config.Debug then
        DebugPrint(string.format("Registered OX shop: %s", shopId), "info")
    end

    return true
end

OXInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    if not oldPlate or not newPlate then return false end

    DebugPrint("Plate update not implemented for OX-Inventory", "warning")
    return false
end

OXInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not src or not targetSrc then return false end

    if oxInventoryExport.openInventory then
        oxInventoryExport.openInventory('player', targetSrc)
        return true
    end

    return false
end

return OXInventoryAPI
