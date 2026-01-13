---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-inventory') == 'missing' then return end

local QBInventoryClientAPI = {}

local qbInventoryExport
local inventoryVersion


local function validateItem(item, operation)
    if not item then
        DebugPrint(string.format("%s: Item parameter required", operation), "error")
        return false
    end
    return true
end

QBInventoryClientAPI.GetResourceName = function()
    return "qb-inventory"
end

QBInventoryClientAPI.GetItemInfo = function(item)
    if not validateItem(item, "GetItemInfo") then return {} end

    local itemData = Framework.Shared.Items[item]
    if itemData then
        return {
            name = itemData.name,
            label = itemData.label,
            stack = itemData.unique,
            weight = itemData.weight,
            description = itemData.description,
            image = QBInventoryClientAPI.GetImagePath(itemData.image or itemData.name)
        }
    end

    return {}
end

QBInventoryClientAPI.Items = function()
    return Framework.Shared.Items
end

QBInventoryClientAPI.HasItem = function(item, requiredCount)
    if not validateItem(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return qbInventoryExport:HasItem(item, requiredCount)
end

QBInventoryClientAPI.GetItemCount = function(item)
    if not validateItem(item, "GetItemCount") then return 0 end

    return qbInventoryExport:GetItemCount(item)
end

QBInventoryClientAPI.GetPlayerInventory = function()
    if qbInventoryExport.GetPlayerInventory then
        return qbInventoryExport:GetPlayerInventory()
    end

    if Framework and Framework.GetPlayerInventory then
        return Framework:GetPlayerInventory()
    end

    return {}
end

QBInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = QBInventoryClientAPI.StripImageExtension(item)
    local file = LoadResourceFile("qb-inventory", string.format("html/images/%s.png", item))
    local imagePath = file and string.format("nui://qb-inventory/html/images/%s.png", item)
    return imagePath or "https://avatars.githubusercontent.com/u/47620135"
end

QBInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    item = string.gsub(item, "%.png$", "")
    item = string.gsub(item, "%.jpg$", "")
    item = string.gsub(item, "%.jpeg$", "")
    item = string.gsub(item, "%.webp$", "")
    return item
end

QBInventoryClientAPI.CanCarryItem = function(item, count)
    if not validateItem(item, "CanCarryItem") or not count then return false end

    if inventoryVersion then
        return qbInventoryExport:CanAddItem(item, count)
    end

    return true
end

QBInventoryClientAPI.GetInventoryWeight = function()
    if qbInventoryExport.GetInventoryWeight then
        return qbInventoryExport:GetInventoryWeight()
    end

    return 0
end

QBInventoryClientAPI.GetInventoryMaxWeight = function()
    if qbInventoryExport.GetInventoryMaxWeight then
        return qbInventoryExport:GetInventoryMaxWeight()
    end

    return 100000
end

return QBInventoryClientAPI
