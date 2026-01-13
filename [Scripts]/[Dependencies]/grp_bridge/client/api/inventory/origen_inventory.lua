---@diagnostic disable: duplicate-set-field
if GetResourceState('origen_inventory') == 'missing' then return end

local OrigenInventoryClientAPI = {}

local invExport

local function validateItem(item, operation)
    if not item then
        DebugPrint(string.format("%s: Item parameter required", operation), "error")
        return false
    end
    return true
end

OrigenInventoryClientAPI.GetResourceName = function()
    return "origen_inventory"
end

OrigenInventoryClientAPI.GetItemInfo = function(item)
    if not validateItem(item, "GetItemInfo") then return {} end

    if invExport.GetItemInfo then
        local itemData = invExport:GetItemInfo(item)
        if itemData then
            return {
                name = itemData.name or item,
                label = itemData.label or item:gsub("^%l", string.upper),
                stack = itemData.stack or itemData.unique ~= true,
                weight = itemData.weight or 0,
                description = itemData.description or "",
                image = OrigenInventoryClientAPI.GetImagePath(item)
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
                image = OrigenInventoryClientAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

OrigenInventoryClientAPI.Items = function()
    if invExport.GetItems then
        return invExport:GetItems()
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    return {}
end

OrigenInventoryClientAPI.HasItem = function(item, requiredCount)
    if not validateItem(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return invExport:HasItem(item, requiredCount)
end

OrigenInventoryClientAPI.GetItemCount = function(item)
    if not validateItem(item, "GetItemCount") then return 0 end

    return invExport:GetItemCount(item)
end

OrigenInventoryClientAPI.GetPlayerInventory = function()
    if invExport.GetPlayerInventory then
        return invExport:GetPlayerInventory()
    end

    if Framework and Framework.GetPlayerInventory then
        return Framework:GetPlayerInventory()
    end

    return {}
end

OrigenInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = OrigenInventoryClientAPI.StripImageExtension(item)

    if GetResourceState('origen_inventory') == 'started' then
        local resourceFile = LoadResourceFile("origen_inventory", string.format("images/%s.png", item))
        if resourceFile then
            return string.format("nui://origen_inventory/images/%s.png", item)
        end
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

OrigenInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

OrigenInventoryClientAPI.CanCarryItem = function(item, count)
    if not validateItem(item, "CanCarryItem") or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(item, count)
    end
    return true
end

OrigenInventoryClientAPI.GetInventoryWeight = function()
    if invExport and invExport.GetWeight then
        return invExport:GetWeight()
    end
    return 0
end

OrigenInventoryClientAPI.GetInventoryMaxWeight = function()
    if invExport and invExport.GetMaxWeight then
        return invExport:GetMaxWeight()
    end
    return 100000
end

return OrigenInventoryClientAPI
