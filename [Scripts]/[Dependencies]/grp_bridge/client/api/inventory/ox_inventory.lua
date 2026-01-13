---@diagnostic disable: duplicate-set-field
if GetResourceState('ox_inventory') == 'missing' then return end

local OXInventoryClientAPI = {}

local oxInventoryExport


local function validateItemParameter(item, operation)
    if not item then
        DebugPrint(string.format("Invalid %s parameter: item is nil", operation), "error")
        return false
    end
    return true
end

OXInventoryClientAPI.GetResourceName = function()
    return "ox_inventory"
end

OXInventoryClientAPI.GetItemInfo = function(item)
    if not validateItemParameter(item, "GetItemInfo") then return {} end

    local itemData = oxInventoryExport:Items(item)
    if not itemData then return {} end

    return {
        name = itemData.name or item,
        label = itemData.label or item:gsub("^%l", string.upper),
        stack = itemData.stack ~= false,
        weight = itemData.weight or 0,
        description = itemData.description or "",
        image = itemData.client and itemData.client.image and
                string.format("nui://ox_inventory/web/images/%s", itemData.client.image) or
                OXInventoryClientAPI.GetImagePath(item)
    }
end

OXInventoryClientAPI.Items = function()
    return oxInventoryExport:Items()
end

OXInventoryClientAPI.HasItem = function(item, requiredCount)
    if not validateItemParameter(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return oxInventoryExport:GetItemCount(item, false) >= requiredCount
end

OXInventoryClientAPI.GetItemCount = function(item)
    if not validateItemParameter(item, "GetItemCount") then return 0 end

    return oxInventoryExport:GetItemCount(item, false)
end

OXInventoryClientAPI.GetPlayerInventory = function()
    return oxInventoryExport:GetPlayerItems()
end

OXInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = OXInventoryClientAPI.StripImageExtension(item)
    return string.format("nui://ox_inventory/web/images/%s.png", item)
end

OXInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

OXInventoryClientAPI.CanCarryItem = function(item, count)
    if not validateItemParameter(item, "CanCarryItem") or not count then return false end

    return oxInventoryExport:CanCarryItem(item, count)
end

OXInventoryClientAPI.GetInventoryWeight = function()
    return oxInventoryExport:GetPlayerWeight()
end

OXInventoryClientAPI.GetInventoryMaxWeight = function()
    return oxInventoryExport:GetPlayerMaxWeight()
end

return OXInventoryClientAPI
