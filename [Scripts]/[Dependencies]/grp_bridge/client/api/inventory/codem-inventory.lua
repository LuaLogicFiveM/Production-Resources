---@diagnostic disable: duplicate-set-field
if GetResourceState('codem-inventory') == 'missing' then return end

local CodemInventoryClientAPI = {}

local codemInventoryExport
local isInitialized = false

local function initializeCodemInventoryClient()
    if isInitialized then return true end

    if GetResourceState('codem-inventory') ~= 'started' then
        return false
    end

    codemInventoryExport = exports['codem-inventory']
    if not codemInventoryExport then
        return false
    end

    isInitialized = true
    if config and config.Debug then
        DebugPrint("Codem-Inventory client initialized", "success")
    end

    return true
end

local function validateItem(item, operation)
    if not item then
        if config and config.Debug then
            DebugPrint(string.format("%s: Item parameter required", operation), "error")
        end
        return false
    end
    return true
end

CodemInventoryClientAPI.GetResourceName = function()
    return "codem-inventory"
end

CodemInventoryClientAPI.GetItemInfo = function(item)
    if not initializeCodemInventoryClient() then return {} end
    if not validateItem(item, "GetItemInfo") then return {} end

    if codemInventoryExport.GetItemInfo then
        local itemData = codemInventoryExport:GetItemInfo(item)
        if itemData then
            return {
                name = itemData.name or item,
                label = itemData.label or item:gsub("^%l", string.upper),
                stack = itemData.stack or itemData.unique ~= true,
                weight = itemData.weight or 0,
                description = itemData.description or "",
                image = CodemInventoryClientAPI.GetImagePath(item)
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
                image = CodemInventoryClientAPI.GetImagePath(item)
            }
        end
    end

    return {}
end

CodemInventoryClientAPI.Items = function()
    if not initializeCodemInventoryClient() then return {} end

    if codemInventoryExport.GetItems then
        return codemInventoryExport:GetItems()
    end

    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    return {}
end

CodemInventoryClientAPI.HasItem = function(item, requiredCount)
    if not initializeCodemInventoryClient() then return false end
    if not validateItem(item, "HasItem") then return false end

    requiredCount = requiredCount or 1
    return codemInventoryExport:HasItem(item, requiredCount)
end

CodemInventoryClientAPI.GetItemCount = function(item)
    if not initializeCodemInventoryClient() then return 0 end
    if not validateItem(item, "GetItemCount") then return 0 end

    return codemInventoryExport:GetItemCount(item)
end

CodemInventoryClientAPI.GetPlayerInventory = function()
    if not initializeCodemInventoryClient() then return {} end

    if codemInventoryExport.GetPlayerInventory then
        return codemInventoryExport:GetPlayerInventory()
    end

    if Framework and Framework.GetPlayerInventory then
        return Framework:GetPlayerInventory()
    end

    return {}
end

CodemInventoryClientAPI.GetImagePath = function(item)
    if not item then return "" end

    item = CodemInventoryClientAPI.StripImageExtension(item)

    if GetResourceState('codem-inventory') == 'started' then
        local resourceFile = LoadResourceFile("codem-inventory", string.format("images/%s.png", item))
        if resourceFile then
            return string.format("nui://codem-inventory/images/%s.png", item)
        end
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

CodemInventoryClientAPI.StripImageExtension = function(item)
    if not item then return "" end
    return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "")
end

CodemInventoryClientAPI.CanCarryItem = function(item, count)
    if not initializeCodemInventoryClient() then return true end
    if not validateItem(item, "CanCarryItem") or not count then return false end

    return codemInventoryExport:CanCarry(item, count)
end

CodemInventoryClientAPI.GetInventoryWeight = function()
    if not initializeCodemInventoryClient() then return 0 end
    return codemInventoryExport:GetWeight()
end

CodemInventoryClientAPI.GetInventoryMaxWeight = function()
    if not initializeCodemInventoryClient() then return 100000 end
    return codemInventoryExport:GetMaxWeight()
end

return CodemInventoryClientAPI
