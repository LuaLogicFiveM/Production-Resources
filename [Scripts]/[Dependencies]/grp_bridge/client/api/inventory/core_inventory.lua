---@diagnostic disable: duplicate-set-field
if GetResourceState('core_inventory') == 'missing' then return end

local CoreInventoryClientAPI = {}

local invExport
local isInitialized = false

local function initializeCoreInventoryClient()
    if isInitialized then return true end

    if GetResourceState('core_inventory') ~= 'started' then
        return false
    end

    invExport = exports['core_inventory']
    if not invExport then
        return false
    end

    isInitialized = true
    if config and config.Debug then
        DebugPrint("Core-Inventory client initialized", "success")
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

CoreInventoryClientAPI.GetResourceName = function()
    return "core_inventory"
end

CoreInventoryClientAPI.GetItemInfo = function(item)
    if not initializeCoreInventoryClient() then return {} end
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
                image = CoreInventoryClientAPI.GetImagePath(item)
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
                image = CoreInventoryClientAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

CoreInventoryClientAPI.Items = function()
    if not initializeCoreInventoryClient() then return {} end

    if invExport.GetItems then
        return invExport:GetItems()
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    return {}
end

CoreInventoryClientAPI.HasItem = function(item, requiredCount)
    if not initializeCoreInventoryClient() then return false end
    if not validateItem(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return invExport:HasItem(item, requiredCount)
end

CoreInventoryClientAPI.GetItemCount = function(item)
    if not initializeCoreInventoryClient() then return 0 end
    if not validateItem(item, "GetItemCount") then return 0 end

    return invExport:GetItemCount(item)
end

CoreInventoryClientAPI.GetPlayerInventory = function()
    if not initializeCoreInventoryClient() then return {} end

    if invExport.GetPlayerInventory then
        return invExport:GetPlayerInventory()
    end

    if Framework and Framework.GetPlayerInventory then
        return Framework:GetPlayerInventory()
    end

    return {}
end

CoreInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = CoreInventoryClientAPI.StripImageExtension(item)

    if GetResourceState('core_inventory') == 'started' then
        local resourceFile = LoadResourceFile("core_inventory", string.format("images/%s.png", item))
        if resourceFile then
            return string.format("nui://core_inventory/images/%s.png", item)
        end
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

CoreInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

CoreInventoryClientAPI.CanCarryItem = function(item, count)
    if not validateItem(item, "CanCarryItem") or not count then return false end
    if invExport and invExport.CanCarryItem then
        return invExport:CanCarryItem(item, count)
    end
    return true
end

CoreInventoryClientAPI.GetInventoryWeight = function()
    if invExport and invExport.GetWeight then
        return invExport:GetWeight()
    end
    return 0
end

CoreInventoryClientAPI.GetInventoryMaxWeight = function()
    if invExport and invExport.GetMaxWeight then
        return invExport:GetMaxWeight()
    end
    return 100000
end

return CoreInventoryClientAPI
