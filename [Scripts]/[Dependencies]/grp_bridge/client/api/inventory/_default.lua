local DefaultInventoryClientAPI = {}

local function validateItem(item, operation)
    if not item then
        DebugPrint(string.format("%s: Item parameter required", operation), "error")
        return false
    end
    return true
end

DefaultInventoryClientAPI.GetResourceName = function()
    return "default"
end

DefaultInventoryClientAPI.GetItemInfo = function(item)
    if not validateItem(item, "GetItemInfo") then return {} end

    if Framework and Framework.Shared and Framework.Shared.Items then
        local itemData = Framework.Shared.Items[item]
        if itemData then
            return {
                name = itemData.name,
                label = itemData.label,
                stack = itemData.unique ~= true,
                weight = itemData.weight,
                description = itemData.description,
                image = DefaultInventoryClientAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

DefaultInventoryClientAPI.Items = function()
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end
    return {}
end

DefaultInventoryClientAPI.HasItem = function(item, requiredCount)
    if not validateItem(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    if Framework and Framework.HasItem then
        return Framework.HasItem(item, requiredCount)
    end
    return false
end

DefaultInventoryClientAPI.GetItemCount = function(item)
    if not validateItem(item, "GetItemCount") then return 0 end

    if Framework and Framework.GetItemCount then
        return Framework.GetItemCount(item)
    end
    return 0
end

DefaultInventoryClientAPI.GetPlayerInventory = function()
    if Framework and Framework.GetPlayerInventory then
        return Framework:GetPlayerInventory()
    end
    return {}
end

DefaultInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = DefaultInventoryClientAPI.StripImageExtension(item)
    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

DefaultInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

DefaultInventoryClientAPI.CanCarryItem = function(item, count)
    if not validateItem(item, "CanCarryItem") or not count then return false end

    return true
end

DefaultInventoryClientAPI.GetInventoryWeight = function()
    return 0
end

DefaultInventoryClientAPI.GetInventoryMaxWeight = function()
    return 100000
end

if config.Debug then
    DebugPrint("Loaded default inventory client API", "info")
end

return DefaultInventoryClientAPI
