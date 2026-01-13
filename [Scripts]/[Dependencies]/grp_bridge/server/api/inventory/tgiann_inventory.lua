---@diagnostic disable: duplicate-set-field
if GetResourceState('tgiann-inventory') == 'missing' then return end

local TgiannInventoryAPI = {}

local invExport
local inventoryStorage = {}
local isInitialized = false

local function initializeTgiannInventory()
    if isInitialized then return true end
    if GetResourceState('tgiann-inventory') ~= 'started' then
        DebugPrint("Tgiann-Inventory resource is not started", "error")
        return false
    end

    invExport = exports['tgiann-inventory']
    if not invExport then
        DebugPrint("Failed to get tgiann-inventory export", "error")
        return false
    end

    if config.Debug then
        DebugPrint("Tgiann-Inventory initialized successfully", "success")
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

TgiannInventoryAPI.GetResourceName = function()
    return "tgiann-inventory"
end

TgiannInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeTgiannInventory() then return false end
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

TgiannInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeTgiannInventory() then return false end
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

TgiannInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeTgiannInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1
    return invExport:HasItem(src, item, requiredCount)
end

TgiannInventoryAPI.CanCarryItem = function(src, item, count)
    if not src or not item or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(src, item, count)
    end
    return true
end

TgiannInventoryAPI.GetItemInfo = function(item)
    if not initializeTgiannInventory() then return nil end
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
                image = TgiannInventoryAPI.GetImagePath(item)
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
                image = TgiannInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

TgiannInventoryAPI.Items = function()
    if not initializeTgiannInventory() then return {} end
    if invExport.GetItems then return invExport:GetItems() end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

TgiannInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeTgiannInventory() then return 0 end
    if not src or not item then return 0 end
    if invExport and invExport.GetItemCount then
        return invExport:GetItemCount(src, item, metadata)
    end
    return 0
end

TgiannInventoryAPI.GetPlayerInventory = function(src)
    if not initializeTgiannInventory() then return {} end
    if not src then return {} end
    if invExport.GetPlayerInventory then return invExport:GetPlayerInventory(src) end
    if Framework and Framework.GetPlayerInventory then return Framework.GetPlayerInventory(src) end
    return {}
end

TgiannInventoryAPI.GetItemBySlot = function(src, slot)
    if not src or not slot then return {} end
    if invExport.GetSlot then return invExport:GetSlot(src, slot) end
    return {}
end

TgiannInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not src or not item or not slot or not metadata then return false end
    if invExport.SetMetadata then
        invExport:SetMetadata(src, slot, metadata)
        return true
    end
    return false
end

TgiannInventoryAPI.GetImagePath = function(item)
    if not item then return "" end
    item = TgiannInventoryAPI.StripImageExtension(item)

    local resourcePath = GetResourceState('tgiann-inventory') == 'started' and
        LoadResourceFile("tgiann-inventory", string.format("images/%s.png", item))

    if resourcePath then
        return string.format("nui://tgiann-inventory/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

TgiannInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

TgiannInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not src or not stashId then return false end
    if invExport.OpenStash then
        invExport:OpenStash(src, stashId)
        return true
    end
    return false
end

TgiannInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not stashId then return false end
    inventoryStorage[stashId] = {id = stashId, label = label or stashId, slots = slots or 30, weight = weight or 50000}
    if config.Debug then DebugPrint(string.format("Registered Tgiann stash: %s", stashId), "info") end
    return true
end

TgiannInventoryAPI.AddStashItems = function(stashId, items)
    DebugPrint("AddStashItems not implemented for Tgiann-Inventory", "warning")
    return false
end

TgiannInventoryAPI.RemoveStashItems = function(stashId, items)
    DebugPrint("RemoveStashItems not implemented for Tgiann-Inventory", "warning")
    return false
end

TgiannInventoryAPI.ClearStash = function(stashId, stashType)
    if inventoryStorage[stashId] then
        inventoryStorage[stashId] = nil
        if config.Debug then DebugPrint(string.format("Cleared Tgiann stash: %s", stashId), "info") end
    end
    return true
end

TgiannInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    DebugPrint("AddTrunkItems not implemented for Tgiann-Inventory", "warning")
    return false
end

TgiannInventoryAPI.OpenShop = function(src, shopId)
    if not src or not shopId then return false end
    if invExport.OpenShop then
        invExport:OpenShop(src, shopId)
        return true
    end
    return false
end

TgiannInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not shopId or not inventory then return false end
    DebugPrint("RegisterShop not implemented for Tgiann-Inventory", "warning")
    return false
end

TgiannInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    DebugPrint("UpdatePlate not implemented for Tgiann-Inventory", "warning")
    return false
end

TgiannInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not src or not targetSrc then return false end
    if invExport.OpenPlayerInventory then
        invExport:OpenPlayerInventory(src, targetSrc)
        return true
    end
    return false
end

return TgiannInventoryAPI
