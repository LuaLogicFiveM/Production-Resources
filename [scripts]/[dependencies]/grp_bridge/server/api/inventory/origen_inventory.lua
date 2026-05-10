---@diagnostic disable: duplicate-set-field
if GetResourceState('origen_inventory') == 'missing' then return end

local OrigenInventoryAPI = {}

local invExport
local inventoryStorage = {}
local isInitialized = false

local function initializeOrigenInventory()
    if isInitialized then return true end
    if GetResourceState('origen_inventory') ~= 'started' then
        DebugPrint("Origen-Inventory resource is not started", "error")
        return false
    end

    invExport = exports['origen_inventory']
    if not invExport then
        DebugPrint("Failed to get origen_inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("Origen-Inventory initialized successfully", "success")
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

OrigenInventoryAPI.GetResourceName = function()
    return "origen_inventory"
end

OrigenInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeOrigenInventory() then return false end
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

OrigenInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeOrigenInventory() then return false end
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

OrigenInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeOrigenInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1
    return invExport:HasItem(src, item, requiredCount)
end

OrigenInventoryAPI.CanCarryItem = function(src, item, count)
    if not src or not item or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(src, item, count)
    end
    return true
end

OrigenInventoryAPI.GetItemInfo = function(item)
    if not initializeOrigenInventory() then return nil end
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
                image = OrigenInventoryAPI.GetImagePath(item)
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
                image = OrigenInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

OrigenInventoryAPI.Items = function()
    if not initializeOrigenInventory() then return {} end
    if invExport.GetItems then return invExport:GetItems() end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

OrigenInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeOrigenInventory() then return 0 end
    if not src or not item then return 0 end
    if invExport and invExport.GetItemCount then
        return invExport:GetItemCount(src, item, metadata)
    end
    return 0
end

OrigenInventoryAPI.GetPlayerInventory = function(src)
    if not initializeOrigenInventory() then return {} end
    if not src then return {} end
    if invExport.GetPlayerInventory then return invExport:GetPlayerInventory(src) end
    if Framework and Framework.GetPlayerInventory then return Framework.GetPlayerInventory(src) end
    return {}
end

OrigenInventoryAPI.GetItemBySlot = function(src, slot)
    if not src or not slot then return {} end
    if invExport.GetSlot then return invExport:GetSlot(src, slot) end
    return {}
end

OrigenInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not src or not item or not slot or not metadata then return false end
    if invExport.SetMetadata then
        invExport:SetMetadata(src, slot, metadata)
        return true
    end
    return false
end

OrigenInventoryAPI.GetImagePath = function(item)
    if not item then return "" end
    item = OrigenInventoryAPI.StripImageExtension(item)

    local resourcePath = GetResourceState('origen_inventory') == 'started' and
        LoadResourceFile("origen_inventory", string.format("images/%s.png", item))

    if resourcePath then
        return string.format("nui://origen_inventory/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

OrigenInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

OrigenInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializeOrigenInventory() then return false end
    if not src or not stashId then return false end
    if invExport.OpenStash then
        invExport:OpenStash(src, stashId)
        return true
    end
    return false
end

OrigenInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializeOrigenInventory() then return false end
    if not stashId then return false end
    inventoryStorage[stashId] = {id = stashId, label = label or stashId, slots = slots or 30, weight = weight or 50000}
    if config.Debug then DebugPrint(string.format("Registered Origen stash: %s", stashId), "info") end
    return true
end

OrigenInventoryAPI.AddStashItems = function(stashId, items)
    DebugPrint("AddStashItems not implemented for Origen-Inventory", "warning")
    return false
end

OrigenInventoryAPI.RemoveStashItems = function(stashId, items)
    DebugPrint("RemoveStashItems not implemented for Origen-Inventory", "warning")
    return false
end

OrigenInventoryAPI.ClearStash = function(stashId, stashType)
    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then DebugPrint(string.format("Cleared Origen stash: %s", stashId), "info") end
    end
    return true
end

OrigenInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    DebugPrint("AddTrunkItems not implemented for Origen-Inventory", "warning")
    return false
end

OrigenInventoryAPI.OpenShop = function(src, shopId)
    if not initializeOrigenInventory() then return false end
    if not src or not shopId then return false end
    if invExport.OpenShop then
        invExport:OpenShop(src, shopId)
        return true
    end
    return false
end

OrigenInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not initializeOrigenInventory() then return false end
    if not shopId or not inventory then return false end
    DebugPrint("RegisterShop not implemented for Origen-Inventory", "warning")
    return false
end

OrigenInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    DebugPrint("UpdatePlate not implemented for Origen-Inventory", "warning")
    return false
end

OrigenInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not src or not targetSrc then return false end
    if invExport.OpenPlayerInventory then
        invExport:OpenPlayerInventory(src, targetSrc)
        return true
    end
    return false
end

return OrigenInventoryAPI
