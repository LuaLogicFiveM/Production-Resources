---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-inventory') == 'missing' then return end

local QsInventoryClientAPI = {}

local invExport
local isInitialized = false

local function initializeQsInventoryClient()
    if isInitialized then return true end

    if GetResourceState('qs-inventory') ~= 'started' then
        return false
    end

    invExport = exports['qs-inventory']
    if not invExport then
        return false
    end

    isInitialized = true
    if config and config.Debug then
        DebugPrint("QS-Inventory client initialized", "success")
    end

    return true
end

local function validateItem(item, operation)
    if not item then
        DebugPrint(string.format("%s: Item parameter required", operation), "error")
        return false
    end
    return true
end

QsInventoryClientAPI.GetResourceName = function()
    return "qs-inventory"
end

QsInventoryClientAPI.GetItemInfo = function(item)
    if not initializeQsInventoryClient() then return {} end
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
                image = QsInventoryClientAPI.GetImagePath(item)
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
                image = QsInventoryClientAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

QsInventoryClientAPI.Items = function()
    if not initializeQsInventoryClient() then return {} end

    if invExport.GetItems then
        return invExport:GetItems()
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    return {}
end

QsInventoryClientAPI.HasItem = function(item, requiredCount)
    if not initializeQsInventoryClient() then return false end
    if not validateItem(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return invExport:HasItem(item, requiredCount)
end

QsInventoryClientAPI.GetItemCount = function(item)
    if not initializeQsInventoryClient() then return 0 end
    if not validateItem(item, "GetItemCount") then return 0 end

    return invExport:GetItemCount(item)
end

QsInventoryClientAPI.GetPlayerInventory = function()
    if not initializeQsInventoryClient() then return {} end

    if invExport.GetPlayerInventory then
        return invExport:GetPlayerInventory()
    end

    if Framework and Framework.GetPlayerInventory then
        return Framework:GetPlayerInventory()
    end

    return {}
end

QsInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = QsInventoryClientAPI.StripImageExtension(item)

    if GetResourceState('qs-inventory') == 'started' then
        local resourceFile = LoadResourceFile("qs-inventory", string.format("images/%s.png", item))
        if resourceFile then
            return string.format("nui://qs-inventory/images/%s.png", item)
        end
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

QsInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

QsInventoryClientAPI.CanCarryItem = function(item, count)
    if not initializeQsInventoryClient() then return true end
    if not validateItem(item, "CanCarryItem") or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(item, count)
    end
    return true
end

QsInventoryClientAPI.GetInventoryWeight = function()
    if not initializeQsInventoryClient() then return 0 end
    if invExport and invExport.GetWeight then
        return invExport:GetWeight()
    end
    return 0
end

QsInventoryClientAPI.GetInventoryMaxWeight = function()
    if not initializeQsInventoryClient() then return 100000 end
    if invExport and invExport.GetMaxWeight then
        return invExport:GetMaxWeight()
    end
    return 100000
end

return QsInventoryClientAPI
