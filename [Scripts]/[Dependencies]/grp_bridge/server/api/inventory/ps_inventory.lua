---@diagnostic disable: duplicate-set-field
if GetResourceState('ps-inventory') == 'missing' then return end

local PsInventoryAPI = {}

local invExport
local inventoryStorage = {}
local isInitialized = false

local function initializePsInventory()
    if isInitialized then return true end
    if GetResourceState('ps-inventory') ~= 'started' then
        DebugPrint("PS-Inventory resource is not started", "error")
        return false
    end

    invExport = exports['ps-inventory']
    if not invExport then
        DebugPrint("Failed to get ps-inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("PS-Inventory initialized successfully", "success")
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

PsInventoryAPI.GetResourceName = function()
    return "ps-inventory"
end

PsInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializePsInventory() then return false end
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

PsInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializePsInventory() then return false end
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

PsInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializePsInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1
    return invExport:HasItem(src, item, requiredCount)
end

PsInventoryAPI.CanCarryItem = function(src, item, count)
    if not src or not item or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(src, item, count)
    end
    return true
end

PsInventoryAPI.GetItemInfo = function(item)
    if not initializePsInventory() then return nil end
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
                image = PsInventoryAPI.GetImagePath(item)
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
                image = PsInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

PsInventoryAPI.Items = function()
    if not initializePsInventory() then return {} end
    if invExport.GetItems then return invExport:GetItems() end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

PsInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializePsInventory() then return 0 end
    if not src or not item then return 0 end
    if invExport and invExport.GetItemCount then
        return invExport:GetItemCount(src, item, metadata)
    end
    return 0
end

PsInventoryAPI.GetPlayerInventory = function(src)
    if not initializePsInventory() then return {} end
    if not src then return {} end
    if invExport.GetPlayerInventory then return invExport:GetPlayerInventory(src) end
    if Framework and Framework.GetPlayerInventory then return Framework.GetPlayerInventory(src) end
    return {}
end

PsInventoryAPI.GetItemBySlot = function(src, slot)
    if not src or not slot then return {} end
    if invExport.GetSlot then return invExport:GetSlot(src, slot) end
    return {}
end

PsInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not src or not item or not slot or not metadata then return false end
    if invExport.SetMetadata then
        invExport:SetMetadata(src, slot, metadata)
        return true
    end
    return false
end

PsInventoryAPI.GetImagePath = function(item)
    if not item then return "" end
    item = PsInventoryAPI.StripImageExtension(item)

    local resourcePath = GetResourceState('ps-inventory') == 'started' and
        LoadResourceFile("ps-inventory", string.format("images/%s.png", item))

    if resourcePath then
        return string.format("nui://ps-inventory/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

PsInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

PsInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializePsInventory() then return false end
    if not src or not stashId then return false end
    if invExport.OpenStash then
        invExport:OpenStash(src, stashId)
        return true
    end
    return false
end

PsInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializePsInventory() then return false end
    if not stashId then return false end
    inventoryStorage[stashId] = {id = stashId, label = label or stashId, slots = slots or 30, weight = weight or 50000}
    if config.Debug then DebugPrint(string.format("Registered PS stash: %s", stashId), "info") end
    return true
end

PsInventoryAPI.AddStashItems = function(stashId, items)
    DebugPrint("AddStashItems not implemented for PS-Inventory", "warning")
    return false
end

PsInventoryAPI.RemoveStashItems = function(stashId, items)
    DebugPrint("RemoveStashItems not implemented for PS-Inventory", "warning")
    return false
end

PsInventoryAPI.ClearStash = function(stashId, stashType)
    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then DebugPrint(string.format("Cleared PS stash: %s", stashId), "info") end
    end
    return true
end

PsInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    DebugPrint("AddTrunkItems not implemented for PS-Inventory", "warning")
    return false
end

PsInventoryAPI.OpenShop = function(src, shopId)
    if not initializePsInventory() then return false end
    if not src or not shopId then return false end
    if invExport.OpenShop then
        invExport:OpenShop(src, shopId)
        return true
    end
    return false
end

PsInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not initializePsInventory() then return false end
    if not shopId or not inventory then return false end
    DebugPrint("RegisterShop not implemented for PS-Inventory", "warning")
    return false
end

PsInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    DebugPrint("UpdatePlate not implemented for PS-Inventory", "warning")
    return false
end

PsInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not src or not targetSrc then return false end
    if invExport.OpenPlayerInventory then
        invExport:OpenPlayerInventory(src, targetSrc)
        return true
    end
    return false
end

return PsInventoryAPI
