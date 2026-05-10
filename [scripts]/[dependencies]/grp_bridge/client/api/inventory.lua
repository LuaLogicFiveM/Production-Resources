local InventoryAPI = {}
local inventoryProvider -- The actual loaded module
local inventorySystem = "default"

---@param system string
---@return table|nil
local function loadInventorySystem(system)
    local res = GetCurrentResourceName()

    if system == "default" then
        return {
            GetResourceName = function() return "default" end,
            GetItemInfo = function() return {} end,
            Items = function() return {} end,
            HasItem = function() return false end,
            GetItemCount = function() return 0 end,
            GetPlayerInventory = function() return {} end,
            GetImagePath = function() return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png" end,
            StripImageExtension = function(item) return item:gsub("%.png$", ""):gsub("%.jpg$", ""):gsub("%.jpeg$", ""):gsub("%.webp$", "") end,
            CanCarryItem = function() return true end,
            GetItemBySlot = function() return {} end,
            GetInventoryWeight = function() return 0 end,
            GetInventoryMaxWeight = function() return 100000 end,
        }
    end

    local path = ('client/api/inventory/%s.lua'):format(system)
    local src = LoadResourceFile(res, path)
    if src then
        -- Create sandboxed environment to prevent global pollution
        local env = {
            DebugPrint = DebugPrint,
            GetResourceState = GetResourceState,
            exports = exports,
            Framework = Framework
        }
        setmetatable(env, { __index = _G })

        local chunk, err = load(src, ('=@%s'):format(path), "t", env)
        if chunk then
            local success, mod = pcall(chunk)
            if success and type(mod) == 'table' and mod.GetResourceName then
                if config.Debug then
                    DebugPrint(('Inventory module loaded: %s'):format(system), "debug")
                end
                return mod
            elseif success and mod == nil then
                -- Module returned nil (likely because resource is missing)
                if config.Debug then
                    DebugPrint(('Inventory module %s returned nil (resource not available)'):format(system), "debug")
                end
                return nil
            elseif not success then
                if config.Debug then
                    DebugPrint(('Error loading inventory module %s: %s'):format(system, mod), "error")
                end
            end
        else
            if config.Debug then
                DebugPrint(('Failed to load inventory file %s: %s'):format(path, err), "error")
            end
        end
    end

    return nil
end

-- Inventory systems priority list
local inventorySystems = {
    "ox_inventory",      -- Priority 1
    "qb-inventory",      -- Priority 2
    "ps_inventory",      -- Priority 3
    "qs_inventory",      -- Priority 4
    "tgiann_inventory",  -- Priority 5
    "codem-inventory",   -- Priority 6
    "origen_inventory",  -- Priority 7
    "jpr_inventory",     -- Priority 8
    "core_inventory"     -- Priority 9
}

if config.Debug then
    DebugPrint("Initializing inventory system detection...", "debug")
end

-- Simplified detection: check resource states first, then load
local function detectInventorySystem()
    local configuredInventory = config.Inventory or "auto"

    -- If specific system configured, check if it's running first
    if configuredInventory ~= "auto" then
        local state = GetResourceState(configuredInventory)
        if state == 'started' or state == 'starting' then
            local mod = loadInventorySystem(configuredInventory)
            if mod then
                inventoryProvider = mod
                inventorySystem = configuredInventory
                if config.Debug then
                    DebugPrint(("Inventory system loaded from config: %s"):format(configuredInventory), "success")
                end
                return
            end
        end
        if config.Debug then
            DebugPrint(("Configured inventory system '%s' not available (state: %s), falling back to auto-detection"):format(configuredInventory, state), "warning")
        end
    end

    -- Auto-detection: check each system if its resource is running
    for _, system in ipairs(inventorySystems) do
        local state = GetResourceState(system)
        if state == 'started' or state == 'starting' then
            local mod = loadInventorySystem(system)
            if mod then
                inventoryProvider = mod
                inventorySystem = system
                if config.Debug then
                    DebugPrint("Inventory system loaded via auto-detection: " .. system, "success")
                end
                return
            end
        end
    end

    -- Fallback to default
    inventoryProvider = loadInventorySystem("default")
    inventorySystem = "default"
    if config.Debug then
        DebugPrint("No inventory system loaded, using default framework inventory", "warning")
    end
end

detectInventorySystem()

local inventorySystem = getInventorySystem()

local function validateSystem()
    return inventoryProvider ~= nil and inventoryProvider.GetResourceName ~= nil
end

InventoryAPI.GetResourceName = function()
    return inventorySystem
end

InventoryAPI.GetItemInfo = function(item)
    if inventoryProvider and inventoryProvider.GetItemInfo then
        return inventoryProvider.GetItemInfo(item)
    end
    return {}
end

InventoryAPI.Items = function()
    if inventoryProvider and inventoryProvider.Items then
        return inventoryProvider.Items()
    end
    return {}
end

InventoryAPI.HasItem = function(item, requiredCount)
    if inventoryProvider and inventoryProvider.HasItem then
        return inventoryProvider.HasItem(item, requiredCount)
    end
    return false
end

InventoryAPI.GetItemCount = function(item)
    if inventoryProvider and inventoryProvider.GetItemCount then
        return inventoryProvider.GetItemCount(item)
    end
    return 0
end

InventoryAPI.GetPlayerInventory = function()
    if inventoryProvider and inventoryProvider.GetPlayerInventory then
        return inventoryProvider.GetPlayerInventory()
    end
    return {}
end

InventoryAPI.GetImagePath = function(item)
    if inventoryProvider and inventoryProvider.GetImagePath then
        return inventoryProvider.GetImagePath(item)
    end
    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

InventoryAPI.StripImageExtension = function(item)
    if inventoryProvider and inventoryProvider.StripImageExtension then
        return inventoryProvider.StripImageExtension(item)
    end
    if not item then return "" end
    item = string.gsub(item, "%.png$", "")
    item = string.gsub(item, "%.jpg$", "")
    item = string.gsub(item, "%.jpeg$", "")
    item = string.gsub(item, "%.webp$", "")
    return item
end

InventoryAPI.CanCarryItem = function(item, count)
    if inventoryProvider and inventoryProvider.CanCarryItem then
        return inventoryProvider.CanCarryItem(item, count)
    end
    return true
end

InventoryAPI.GetItemBySlot = function(slot)
    if inventoryProvider and inventoryProvider.GetItemBySlot then
        return inventoryProvider.GetItemBySlot(slot)
    end
    return {}
end

InventoryAPI.GetInventoryWeight = function()
    if inventoryProvider and inventoryProvider.GetInventoryWeight then
        return inventoryProvider.GetInventoryWeight()
    end
    return 0
end

InventoryAPI.GetInventoryMaxWeight = function()
    if inventoryProvider and inventoryProvider.GetInventoryMaxWeight then
        return inventoryProvider.GetInventoryMaxWeight()
    end
    return 100000
end

if not validateSystem() then
    DebugPrint("Inventory system validation failed, falling back to default", "warning")
    inventoryProvider = loadInventorySystem("default")
    inventorySystem = 'default'
end

return InventoryAPI
