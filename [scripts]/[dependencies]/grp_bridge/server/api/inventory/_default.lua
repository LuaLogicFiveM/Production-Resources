local DefaultInventoryAPI = {}

local registeredStashes = {}
local registeredShops = {}

local function validatePlayer(src)
    if not src then
        DebugPrint("Invalid player source provided", "error")
        return false
    end
    return true
end

local function validateItemParams(item, count, operation)
    if not item or not count then
        DebugPrint(string.format("Invalid %s parameters: item=%s, count=%s", operation, tostring(item), tostring(count)), "error")
        return false
    end

    if type(count) ~= "number" or count <= 0 then
        DebugPrint(string.format("Invalid count for %s: %s", operation, tostring(count)), "error")
        return false
    end

    return true
end

local function notifyInventoryUpdate(src, updateData)
    if not src or not updateData then return end
    TriggerClientEvent('grp_bridge:client:inventory:update', src, updateData)
end

DefaultInventoryAPI.GetResourceName = function()
    return "default"
end

DefaultInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not validatePlayer(src) or not validateItemParams(item, count, "AddItem") then return false end

    local success
    if Framework and Framework.AddItem then
        success = Framework.AddItem(src, item, count, slot, metadata)
    else
        DebugPrint("Framework AddItem function not available", "error")
        return false
    end

    if success then
        notifyInventoryUpdate(src, {
            action = "add",
            item = item,
            count = count,
            slot = slot,
            metadata = metadata
        })
    end

    return success
end

DefaultInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not validatePlayer(src) or not validateItemParams(item, count, "RemoveItem") then return false end

    local success
    if Framework and Framework.RemoveItem then
        success = Framework.RemoveItem(src, item, count, slot, metadata)
    else
        DebugPrint("Framework RemoveItem function not available", "error")
        return false
    end

    if success then
        notifyInventoryUpdate(src, {
            action = "remove",
            item = item,
            count = count,
            slot = slot,
            metadata = metadata
        })
    end

    return success
end

DefaultInventoryAPI.HasItem = function(src, item, requiredCount)
    if not validatePlayer(src) or not item then return false end
    requiredCount = requiredCount or 1

    if Framework and Framework.HasItem then
        return Framework.HasItem(src, item, requiredCount)
    end

    return false
end

DefaultInventoryAPI.CanCarryItem = function(src, item, count)
    if not validatePlayer(src) or not item or not count then return false end

    DebugPrint("CanCarryItem check not available in default inventory, assuming true", "warning")
    return true
end

DefaultInventoryAPI.GetItemInfo = function(item)
    if not item then return {} end

    if Framework and Framework.GetItemInfo then
        return Framework.GetItemInfo(item)
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        local itemData = Framework.Shared.Items[item]
        if itemData then
            return {
                name = itemData.name,
                label = itemData.label,
                weight = itemData.weight,
                stack = itemData.unique,
                description = itemData.description,
                image = DefaultInventoryAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

DefaultInventoryAPI.Items = function()
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    if Framework and Framework.ItemList then
        local itemList = Framework.ItemList()
        return itemList and itemList.Items or {}
    end

    return {}
end

DefaultInventoryAPI.GetItemCount = function(src, item, metadata)
    if not validatePlayer(src) or not item then return 0 end

    if Framework and Framework.GetItemCount then
        return Framework.GetItemCount(src, item, metadata)
    end

    return 0
end

DefaultInventoryAPI.GetPlayerInventory = function(src)
    if not validatePlayer(src) then return {} end

    if Framework and Framework.GetPlayerInventory then
        return Framework.GetPlayerInventory(src)
    end

    return {}
end

DefaultInventoryAPI.GetItemBySlot = function(src, slot)
    if not validatePlayer(src) or not slot then return {} end

    if Framework and Framework.GetItemBySlot then
        return Framework.GetItemBySlot(src, slot)
    end

    return {}
end

DefaultInventoryAPI.SetMetadata = function(src, item, slot, metadata)
    if not validatePlayer(src) or not item or not slot or not metadata then return false end

    if Framework and Framework.SetMetadata then
        return Framework.SetMetadata(src, item, slot, metadata)
    end

    DebugPrint("SetMetadata not available in default inventory", "warning")
    return false
end

DefaultInventoryAPI.GetImagePath = function(item)
    if not item then return "" end

    item = DefaultInventoryAPI.StripImageExtension(item)

    if GetResourceState('qb-inventory') == 'started' then
        local resourceFile = LoadResourceFile("qb-inventory", string.format("html/images/%s.png", item))
        if resourceFile then
            return string.format("nui://qb-inventory/html/images/%s.png", item)
        end
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

DefaultInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    item = string.gsub(item, "%.png$", "")
    item = string.gsub(item, "%.jpg$", "")
    item = string.gsub(item, "%.jpeg$", "")
    item = string.gsub(item, "%.webp$", "")
    return item
end

DefaultInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not validatePlayer(src) or not stashId then return false end

    local stashData = registeredStashes[stashId]
    if not stashData then
        DebugPrint(string.format("Stash %s not registered", stashId), "warning")
        return false
    end

    DebugPrint("Stash opening not available in default inventory system", "warning")
    return false
end

DefaultInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not stashId then return false end

    registeredStashes[stashId] = {
        id = stashId,
        label = label or stashId,
        slots = slots or 20,
        weight = weight or 5000,
        owner = owner,
        groups = groups,
        coords = coords
    }

    if config.Debug then
        DebugPrint(string.format("Registered stash: %s", stashId), "info")
    end

    return true
end

DefaultInventoryAPI.AddStashItems = function(stashId, items)
    DebugPrint("AddStashItems not available in default inventory system", "warning")
    return false
end

DefaultInventoryAPI.RemoveStashItems = function(stashId, items)
    DebugPrint("RemoveStashItems not available in default inventory system", "warning")
    return false
end

DefaultInventoryAPI.ClearStash = function(stashId, stashType)
    if registeredStashes[stashId] then
        registeredStashes[stashId] = nil
        if config.Debug then
            DebugPrint(string.format("Cleared stash: %s", stashId), "info")
        end
    end
    return true
end

DefaultInventoryAPI.AddTrunkItems = function(vehiclePlate, items)
    DebugPrint("AddTrunkItems not available in default inventory system", "warning")
    return false
end

DefaultInventoryAPI.OpenShop = function(src, shopId)
    if not validatePlayer(src) or not shopId then return false end

    DebugPrint("Shop opening not available in default inventory system", "warning")
    return false
end

DefaultInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not shopId or not inventory then return false end

    if registeredShops[shopId] then
        if config.Debug then
            DebugPrint(string.format("Shop %s already registered", shopId), "info")
        end
        return true
    end

    registeredShops[shopId] = {
        id = shopId,
        inventory = inventory,
        coords = coords,
        groups = groups
    }

    if config.Debug then
        DebugPrint(string.format("Registered shop: %s", shopId), "info")
    end

    return true
end

DefaultInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    DebugPrint("UpdatePlate not available in default inventory system", "warning")
    return false
end

DefaultInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not validatePlayer(src) or not validatePlayer(targetSrc) then return false end

    DebugPrint("OpenPlayerInventory not available in default inventory system", "warning")
    return false
end

if config.Debug then
    DebugPrint("Loaded default inventory API", "info")
end

return DefaultInventoryAPI
