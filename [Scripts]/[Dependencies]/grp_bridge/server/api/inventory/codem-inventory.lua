---@diagnostic disable: duplicate-set-field
if GetResourceState('codem-inventory') == 'missing' then return end

local CodemInventoryAPI = {}

local codemInventoryExport
local inventoryStorage = {}
local isInitialized = false

local function initializeCodemInventory()
    if isInitialized then return true end
    if GetResourceState('codem-inventory') ~= 'started' then
        DebugPrint("Codem-Inventory resource is not started", "error")
        return false
    end

    codemInventoryExport = exports['codem-inventory']
    if not codemInventoryExport then
        DebugPrint("Failed to get codem-inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("Codem-Inventory initialized successfully", "success")
    end
    isInitialized = true
    return true
end

local function validateOperationParameters(src, item, count, operation)
    if not src then
        DebugPrint(string.format("%s: Player source is required", operation), "error")
        return false
    end

    if not item then
        DebugPrint(string.format("%s: Item name is required", operation), "error")
        return false
    end

    if count and (type(count) ~= "number" or count < 0) then
        DebugPrint(string.format("%s: Invalid count parameter", operation), "error")
        return false
    end

    return true
end

local function searchItemWithMetadata(src, item, metadata)
    if not src or not item then return false, nil end

    local playerInventory = Framework.GetPlayerInventory and Framework.GetPlayerInventory(src)
    if not playerInventory then return false, nil end

    for slot, itemData in pairs(playerInventory) do
        if itemData.name == item then
            if not metadata or (itemData.info and Bridge.Tables.DeepEquals(itemData.info, metadata)) then
                return true, slot
            end
        end
    end

    return false, nil
end

local function sendInventoryNotification(src, operationData)
    if not src or not operationData then return end

    TriggerClientEvent('grp_bridge:client:inventory:update', src, operationData)
end

CodemInventoryAPI.GetResourceName = function()
    return "codem-inventory"
end

CodemInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeCodemInventory() then return false end
    if not validateOperationParameters(src, item, count, "AddItem") then return false end

    count = count or 1
    local success = codemInventoryExport:AddItem(src, item, count, slot, metadata)

    if success then
        sendInventoryNotification(src, {
            action = "add",
            item = item,
            count = count,
            slot = slot,
            metadata = metadata
        })
    end

    return success
end

CodemInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeCodemInventory() then return false end
    if not validateOperationParameters(src, item, count, "RemoveItem") then return false end

    count = count or 1

    if metadata and not slot then
        local hasItem, foundSlot = searchItemWithMetadata(src, item, metadata)
        if hasItem then
            slot = foundSlot
        end
    end

    local success = codemInventoryExport:RemoveItem(src, item, count, slot, metadata)

    if success then
        sendInventoryNotification(src, {
            action = "remove",
            item = item,
            count = count,
            slot = slot,
            metadata = metadata
        })
    end

    return success
end

CodemInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeCodemInventory() then return false end
    if not validateOperationParameters(src, item, requiredCount, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return codemInventoryExport:HasItem(src, item, requiredCount)
end

CodemInventoryAPI.CanCarryItem = function(src, item, count)
    if not initializeCodemInventory() then return false end
    if not validateOperationParameters(src, item, count, "CanCarryItem") then return false end

    count = count or 1
    return codemInventoryExport:CanCarry(src, item, count)
end

CodemInventoryAPI.GetItemInfo = function(item)
    if not initializeCodemInventory() then return nil end
    if not item then return {} end

    if codemInventoryExport.GetItemInfo then
        local itemData = codemInventoryExport:GetItemInfo(item)
        if itemData then
            return {
                name = itemData.name or item,
                label = itemData.label or item:gsub("^%l", string.upper),
                stack = itemData.unique ~= true,
                weight = itemData.weight or 0,
                description = itemData.description or "",
                image = CodemInventoryAPI.GetImagePath(item)
            }
        end
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        local itemData = Framework.Shared.Items[item]
        if itemData then
            return {
                name = itemData.name,
                label = itemData.label,
                stack = itemData.unique ~= true,
                weight = itemData.weight,
                description = itemData.description,
                image = CodemInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

CodemInventoryAPI.Items = function()
    if not initializeCodemInventory() then return {} end
    if codemInventoryExport.GetItems then
        return codemInventoryExport:GetItems()
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    return {}
end

CodemInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeCodemInventory() then return 0 end
    if not validateOperationParameters(src, item, nil, "GetItemCount") then return 0 end

    -- Try codem_inventory export first
    if codemInventoryExport.GetItemCount then
        local result = codemInventoryExport:GetItemCount(src, item, metadata)
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

CodemInventoryAPI.GetPlayerInventory = function(src)
    if not initializeCodemInventory() then return {} end
    if not src then return {} end

    if codemInventoryExport.GetPlayerInventory then
        return codemInventoryExport:GetPlayerInventory(src)
    end

    if Framework and Framework.GetPlayerInventory then
        return Framework.GetPlayerInventory(src)
    end

    return {}
end

CodemInventoryAPI.GetItemBySlot = function(src, slot)
    if not initializeCodemInventory() then return nil end
    if not validateOperationParameters(src, nil, slot, "GetItemBySlot") then return {} end

    if codemInventoryExport.GetSlot then
        return codemInventoryExport:GetSlot(src, slot)
    end

    return {}
end

CodemInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not initializeCodemInventory() then return false end
    if not validateOperationParameters(src, item, nil, "SetMetadata") or not slot or not metadata then return false end

    if codemInventoryExport.SetMetadata then
        codemInventoryExport:SetMetadata(src, slot, metadata)
        return true
    end

    return false
end

CodemInventoryAPI.GetImagePath = function(item)
    if not item then return "" end

    item = CodemInventoryAPI.StripImageExtension(item)

    if GetResourceState('codem-inventory') == 'started' then
        local resourceFile = LoadResourceFile("codem-inventory", string.format("html/itemimages/%s.png", item))
        if resourceFile then
            return string.format("nui://codem-inventory/html/itemimages/%s.png", item)
        end
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

CodemInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

CodemInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializeCodemInventory() then return false end
    if not src or not stashId then return false end

    stashType = stashType or "stash"

    if codemInventoryExport.OpenStash then
        codemInventoryExport:OpenStash(src, stashId)
        return true
    end

    return false
end

CodemInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializeCodemInventory() then return false end
    if not stashId then return false end

    inventoryStorage[stashId] = {
        id = stashId,
        label = label or stashId,
        slots = slots or 30,
        weight = weight or 50000,
        owner = owner,
        groups = groups,
        coords = coords
    }

    if config.Debug then
        DebugPrint(string.format("Registered Codem stash: %s", stashId), "info")
    end

    return true
end

CodemInventoryAPI.AddStashItems = function(stashId, items)
    if not initializeCodemInventory() then return false end
    if not stashId or not items or type(items) ~= "table" then return false end

    if codemInventoryExport.AddStashItems then
        return codemInventoryExport:AddStashItems(stashId, items)
    end

    -- Fallback implementation when export doesn't exist
    local repackedItems = {}
    for _, itemData in ipairs(items) do
        table.insert(repackedItems, {
            item = itemData.item or itemData.name,
            amount = itemData.count or itemData.amount or 1,
            info = itemData.metadata or itemData.info or {},
            unique = itemData.unique or itemData.stack or false,
            description = itemData.description or "none",
            weight = itemData.weight or 0,
            type = 'item',
            slot = #repackedItems + 1
        })
    end

    if codemInventoryExport.UpdateStash then
        codemInventoryExport:UpdateStash(stashId, repackedItems)
        return true
    end

    DebugPrint("AddStashItems not available in Codem-Inventory", "warning")
    return false
end

CodemInventoryAPI.RemoveStashItems = function(stashId, items)
    if not initializeCodemInventory() then return false end
    if not stashId or not items or type(items) ~= "table" then return false end

    if codemInventoryExport.RemoveStashItems then
        return codemInventoryExport:RemoveStashItems(stashId, items)
    end

    DebugPrint("RemoveStashItems not available in Codem-Inventory", "warning")
    return false
end

CodemInventoryAPI.ClearStash = function(stashId, stashType)
    if not initializeCodemInventory() then return false end
    if not stashId then return false end

    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then
            DebugPrint(string.format("Cleared Codem stash: %s", stashId), "info")
        end
    end

    return true
end

CodemInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    if not initializeCodemInventory() then return false end
    DebugPrint("AddTrunkItems not implemented for Codem-Inventory", "warning")
    return false
end

CodemInventoryAPI.OpenShop = function(src, shopId)
    if not initializeCodemInventory() then return false end
    if not src or not shopId then return false end

    if codemInventoryExport.OpenShop then
        codemInventoryExport:OpenShop(src, shopId)
        return true
    end

    return false
end

CodemInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not initializeCodemInventory() then return false end
    if not shopId or not inventory then return false end

    if codemInventoryExport.RegisterShop then
        codemInventoryExport:RegisterShop(shopId, inventory, coords, groups)
        return true
    end

    DebugPrint("RegisterShop not available in Codem-Inventory", "warning")
    return false
end

CodemInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    if not initializeCodemInventory() then return false end
    DebugPrint("UpdatePlate not implemented for Codem-Inventory", "warning")
    return false
end

CodemInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not initializeCodemInventory() then return false end
    if not src or not targetSrc then return false end

    if codemInventoryExport.OpenPlayerInventory then
        codemInventoryExport:OpenPlayerInventory(src, targetSrc)
        return true
    end

    return false
end

return CodemInventoryAPI
