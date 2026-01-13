---@diagnostic disable: duplicate-set-field
if GetResourceState('core_inventory') == 'missing' then return end

local CoreInventoryAPI = {}

local invExport
local inventoryStorage = {}
local isInitialized = false

local function initializeCoreInventory()
    if isInitialized then return true end
    if GetResourceState('core_inventory') ~= 'started' then
        DebugPrint("Core-Inventory resource is not started", "error")
        return false
    end

    invExport = exports['core_inventory']
    if not invExport then
        DebugPrint("Failed to get core_inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("Core-Inventory initialized successfully", "success")
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

CoreInventoryAPI.GetResourceName = function()
    return "core_inventory"
end

CoreInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeCoreInventory() then return false end
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

CoreInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeCoreInventory() then return false end
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

CoreInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeCoreInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1
    return invExport:HasItem(src, item, requiredCount)
end

CoreInventoryAPI.CanCarryItem = function(src, item, count)
    if not initializeCoreInventory() then return false end
    if not src or not item or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(src, item, count)
    end
    return true
end

CoreInventoryAPI.GetItemInfo = function(item)
    if not initializeCoreInventory() then return nil end
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
                image = CoreInventoryAPI.GetImagePath(item)
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
                image = CoreInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

CoreInventoryAPI.Items = function()
    if not initializeCoreInventory() then return {} end
    if invExport.GetItems then return invExport:GetItems() end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

CoreInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeCoreInventory() then return 0 end
    if not src or not item then return 0 end
    if invExport and invExport.GetItemCount then
        return invExport:GetItemCount(src, item, metadata)
    end
    return 0
end

CoreInventoryAPI.GetPlayerInventory = function(src)
    if not initializeCoreInventory() then return {} end
    if not src then return {} end
    if invExport.GetPlayerInventory then return invExport:GetPlayerInventory(src) end
    if Framework and Framework.GetPlayerInventory then return Framework.GetPlayerInventory(src) end
    return {}
end

CoreInventoryAPI.GetItemBySlot = function(src, slot)
    if not initializeCoreInventory() then return nil end
    if not src or not slot then return {} end
    if invExport.GetSlot then return invExport:GetSlot(src, slot) end
    return {}
end

CoreInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not initializeCoreInventory() then return false end
    if not src or not item or not slot or not metadata then return false end
    if invExport.SetMetadata then
        invExport:SetMetadata(src, slot, metadata)
        return true
    end
    return false
end

CoreInventoryAPI.GetImagePath = function(item)
    if not item then return "" end
    item = CoreInventoryAPI.StripImageExtension(item)

    local resourcePath = GetResourceState('core_inventory') == 'started' and
        LoadResourceFile("core_inventory", string.format("images/%s.png", item))

    if resourcePath then
        return string.format("nui://core_inventory/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

CoreInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

CoreInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializeCoreInventory() then return false end
    if not src or not stashId then return false end
    if invExport.OpenStash then
        invExport:OpenStash(src, stashId)
        return true
    end
    return false
end

CoreInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializeCoreInventory() then return false end
    if not stashId then return false end
    inventoryStorage[stashId] = {id = stashId, label = label or stashId, slots = slots or 30, weight = weight or 50000}
    if config.Debug then DebugPrint(string.format("Registered Core stash: %s", stashId), "info") end
    return true
end

CoreInventoryAPI.AddStashItems = function(stashId, items)
    if not initializeCoreInventory() then return false end
    DebugPrint("AddStashItems not implemented for Core-Inventory", "warning")
    return false
end

CoreInventoryAPI.RemoveStashItems = function(stashId, items)
    if not initializeCoreInventory() then return false end
    DebugPrint("RemoveStashItems not implemented for Core-Inventory", "warning")
    return false
end

CoreInventoryAPI.ClearStash = function(stashId, stashType)
    if not initializeCoreInventory() then return false end
    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then DebugPrint(string.format("Cleared Core stash: %s", stashId), "info") end
    end
    return true
end

CoreInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    if not initializeCoreInventory() then return false end
    DebugPrint("AddTrunkItems not implemented for Core-Inventory", "warning")
    return false
end

CoreInventoryAPI.OpenShop = function(src, shopId)
    if not initializeCoreInventory() then return false end
    if not src or not shopId then return false end
    if invExport.OpenShop then
        invExport:OpenShop(src, shopId)
        return true
    end
    return false
end

CoreInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not initializeCoreInventory() then return false end
    if not shopId or not inventory then return false end
    DebugPrint("RegisterShop not implemented for Core-Inventory", "warning")
    return false
end

CoreInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    if not initializeCoreInventory() then return false end
    DebugPrint("UpdatePlate not implemented for Core-Inventory", "warning")
    return false
end

CoreInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not initializeCoreInventory() then return false end
    if not src or not targetSrc then return false end
    if invExport.OpenPlayerInventory then
        invExport:OpenPlayerInventory(src, targetSrc)
        return true
    end
    return false
end

return CoreInventoryAPI
