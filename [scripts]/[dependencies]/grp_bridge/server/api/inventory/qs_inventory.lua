---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-inventory') == 'missing' then return end

local QsInventoryAPI = {}

local invExport
local inventoryStorage = {}
local isInitialized = false

local function initializeQsInventory()
    if isInitialized then return true end
    if GetResourceState('qs-inventory') ~= 'started' then
        DebugPrint("Tgiann-Inventory resource is not started", "error")
        return false
    end

    invExport = exports['qs-inventory']
    if not invExport then
        DebugPrint("Failed to get qs-inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("QS-Inventory initialized successfully", "success")
    end
    isInitialized = true
    return true
end

local function validateOperation(src, item, count, operation)
    if not src or not item then
        DebugPrint(string.format("%s: Invalid parameters", operation), "error")
        return false
    end
    return true
end

QsInventoryAPI.GetResourceName = function()
    return "qs-inventory"
end

QsInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeQsInventory() then return false end
    if not validateOperation(src, item, count, "AddItem") then return false end

    count = count or 1
    local success = invExport:AddItem(src, item, count, slot, metadata)
    if success then
        TriggerClientEvent('grp_bridge:client:inventory:update', src, {
            action = "add", item = item, count = count, slot = slot, metadata = metadata
        })
    end
    return success
end

QsInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeQsInventory() then return false end
    if not validateOperation(src, item, count, "RemoveItem") then return false end

    count = count or 1
    local success = invExport:RemoveItem(src, item, count, slot, metadata)
    if success then
        TriggerClientEvent('grp_bridge:client:inventory:update', src, {
            action = "remove", item = item, count = count, slot = slot, metadata = metadata
        })
    end
    return success
end

QsInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeQsInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1
    return invExport:HasItem(src, item, requiredCount)
end

QsInventoryAPI.CanCarryItem = function(src, item, count)
    if not src or not item or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(src, item, count)
    end
    return true
end

QsInventoryAPI.GetItemInfo = function(item)
    if not initializeQsInventory() then return nil end
    if not item then return {} end

    if invExport.GetItemInfo then
        local itemData = invExport:GetItemInfo(item)
        if itemData then
            return {
                name = itemData.name or item,
                label = itemData.label or item:gsub("^%l", string.upper),
                stack = itemData.stack or itemData.unique ~= true,
                weight = itemData.weight or 0,
                description = itemData.description or "",
                image = QsInventoryAPI.GetImagePath(item)
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
                image = QsInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

QsInventoryAPI.Items = function()
    if not initializeQsInventory() then return {} end
    if invExport.GetItems then return invExport:GetItems() end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

QsInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeQsInventory() then return 0 end
    if not src or not item then return 0 end
    if invExport and invExport.GetItemCount then
        return invExport:GetItemCount(src, item, metadata)
    end
    return 0
end

QsInventoryAPI.GetPlayerInventory = function(src)
    if not initializeQsInventory() then return {} end
    if not src then return {} end
    if invExport.GetPlayerInventory then return invExport:GetPlayerInventory(src) end
    if Framework and Framework.GetPlayerInventory then return Framework.GetPlayerInventory(src) end
    return {}
end

QsInventoryAPI.GetItemBySlot = function(src, slot)
    if not src or not slot then return {} end
    if invExport.GetSlot then return invExport:GetSlot(src, slot) end
    return {}
end

QsInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not src or not item or not slot or not metadata then return false end
    if invExport.SetMetadata then
        invExport:SetMetadata(src, slot, metadata)
        return true
    end
    return false
end

QsInventoryAPI.GetImagePath = function(item)
    if not item then return "" end
    item = QsInventoryAPI.StripImageExtension(item)

    local resourcePath = GetResourceState('qs-inventory') == 'started' and
        LoadResourceFile("qs-inventory", string.format("images/%s.png", item))

    if resourcePath then
        return string.format("nui://qs-inventory/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

QsInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

QsInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not src or not stashId then return false end
    if invExport.OpenStash then
        invExport:OpenStash(src, stashId)
        return true
    end
    return false
end

QsInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not stashId then return false end
    inventoryStorage[stashId] = {id = stashId, label = label or stashId, slots = slots or 30, weight = weight or 50000}
    if config.Debug then DebugPrint(string.format("Registered QS stash: %s", stashId), "info") end
    return true
end

QsInventoryAPI.AddStashItems = function(stashId, items)
    DebugPrint("AddStashItems not implemented for QS-Inventory", "warning")
    return false
end

QsInventoryAPI.RemoveStashItems = function(stashId, items)
    DebugPrint("RemoveStashItems not implemented for QS-Inventory", "warning")
    return false
end

QsInventoryAPI.ClearStash = function(stashId, stashType)
    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then DebugPrint(string.format("Cleared QS stash: %s", stashId), "info") end
    end
    return true
end

QsInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    DebugPrint("AddTrunkItems not implemented for QS-Inventory", "warning")
    return false
end

QsInventoryAPI.OpenShop = function(src, shopId)
    if not src or not shopId then return false end
    if invExport.OpenShop then
        invExport:OpenShop(src, shopId)
        return true
    end
    return false
end

QsInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not shopId or not inventory then return false end
    DebugPrint("RegisterShop not implemented for QS-Inventory", "warning")
    return false
end

QsInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    DebugPrint("UpdatePlate not implemented for QS-Inventory", "warning")
    return false
end

QsInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not src or not targetSrc then return false end
    if invExport.OpenPlayerInventory then
        invExport:OpenPlayerInventory(src, targetSrc)
        return true
    end
    return false
end

return QsInventoryAPI
