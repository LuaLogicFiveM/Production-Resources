---@diagnostic disable: duplicate-set-field
if GetResourceState('jpr-inventory') == 'missing' then return end

local JprInventoryAPI = {}

local invExport
local inventoryStorage = {}
local isInitialized = false

local function initializeJprInventory()
    if isInitialized then return true end
    if GetResourceState('jpr-inventory') ~= 'started' then
        DebugPrint("JPR-Inventory resource is not started", "error")
        return false
    end

    invExport = exports['jpr-inventory']
    if not invExport then
        DebugPrint("Failed to get jpr-inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("JPR-Inventory initialized successfully", "success")
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

JprInventoryAPI.GetResourceName = function()
    return "jpr-inventory"
end

JprInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeJprInventory() then return false end
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

JprInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeJprInventory() then return false end
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

JprInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeJprInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1
    return invExport:HasItem(src, item, requiredCount)
end

JprInventoryAPI.CanCarryItem = function(src, item, count)
    if not initializeJprInventory() then return false end
    if not src or not item or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(src, item, count)
    end
    return true
end

JprInventoryAPI.GetItemInfo = function(item)
    if not initializeJprInventory() then return nil end
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
                image = JprInventoryAPI.GetImagePath(item)
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
                image = JprInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

JprInventoryAPI.Items = function()
    if not initializeJprInventory() then return {} end
    if invExport.GetItems then return invExport:GetItems() end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

JprInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeJprInventory() then return 0 end
    if not src or not item then return 0 end
    if invExport and invExport.GetItemCount then
        return invExport:GetItemCount(src, item, metadata)
    end
    return 0
end

JprInventoryAPI.GetPlayerInventory = function(src)
    if not initializeJprInventory() then return {} end
    if not src then return {} end
    if invExport.GetPlayerInventory then return invExport:GetPlayerInventory(src) end
    if Framework and Framework.GetPlayerInventory then return Framework.GetPlayerInventory(src) end
    return {}
end

JprInventoryAPI.GetItemBySlot = function(src, slot)
    if not initializeJprInventory() then return nil end
    if not src or not slot then return {} end
    if invExport.GetSlot then return invExport:GetSlot(src, slot) end
    return {}
end

JprInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not initializeJprInventory() then return false end
    if not src or not item or not slot or not metadata then return false end
    if invExport.SetMetadata then
        invExport:SetMetadata(src, slot, metadata)
        return true
    end
    return false
end

JprInventoryAPI.GetImagePath = function(item)
    if not item then return "" end
    item = JprInventoryAPI.StripImageExtension(item)

    local resourcePath = GetResourceState('jpr-inventory') == 'started' and
        LoadResourceFile("jpr-inventory", string.format("images/%s.png", item))

    if resourcePath then
        return string.format("nui://jpr-inventory/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

JprInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

JprInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializeJprInventory() then return false end
    if not src or not stashId then return false end
    if invExport.OpenStash then
        invExport:OpenStash(src, stashId)
        return true
    end
    return false
end

JprInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializeJprInventory() then return false end
    if not stashId then return false end
    inventoryStorage[stashId] = {id = stashId, label = label or stashId, slots = slots or 30, weight = weight or 50000}
    if config.Debug then DebugPrint(string.format("Registered JPR stash: %s", stashId), "info") end
    return true
end

JprInventoryAPI.AddStashItems = function(stashId, items)
    if not initializeJprInventory() then return false end
    DebugPrint("AddStashItems not implemented for JPR-Inventory", "warning")
    return false
end

JprInventoryAPI.RemoveStashItems = function(stashId, items)
    if not initializeJprInventory() then return false end
    DebugPrint("RemoveStashItems not implemented for JPR-Inventory", "warning")
    return false
end

JprInventoryAPI.ClearStash = function(stashId, stashType)
    if not initializeJprInventory() then return false end
    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then DebugPrint(string.format("Cleared JPR stash: %s", stashId), "info") end
    end
    return true
end

JprInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    if not initializeJprInventory() then return false end
    DebugPrint("AddTrunkItems not implemented for JPR-Inventory", "warning")
    return false
end

JprInventoryAPI.OpenShop = function(src, shopId)
    if not initializeJprInventory() then return false end
    if not src or not shopId then return false end
    if invExport.OpenShop then
        invExport:OpenShop(src, shopId)
        return true
    end
    return false
end

JprInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not initializeJprInventory() then return false end
    if not shopId or not inventory then return false end
    DebugPrint("RegisterShop not implemented for JPR-Inventory", "warning")
    return false
end

JprInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    if not initializeJprInventory() then return false end
    DebugPrint("UpdatePlate not implemented for JPR-Inventory", "warning")
    return false
end

JprInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not initializeJprInventory() then return false end
    if not src or not targetSrc then return false end
    if invExport.OpenPlayerInventory then
        invExport:OpenPlayerInventory(src, targetSrc)
        return true
    end
    return false
end

return JprInventoryAPI
