-- ================== INVENTORY SYSTEM DETECTION ==================
local supportedInventories = { 
    'ox_inventory', 'qs-inventory', 'qb-inventory', 
    'ps-inventory', 'tgiann-inventory', 'ak47_inventory'
}
for _, system in ipairs(supportedInventories) do
    if GetResourceState(system) == 'started' then 
        return 
    end
end

if GetResourceState('es_extended') ~= 'started' then return end

Debug("ESX Inventory system was loaded.", 'success')

-- ================== CONFIGURATION ==================
local settings = require 'config.config'
local searchConfig = settings.search
local itemTypes = searchConfig.item_types
local searchableItems = searchConfig.items
local includeAllWeapons = searchConfig.all_weapons

-- ================== BASIC INVENTORY FUNCTIONS ==================
function AddItem(source, player, item)
    player.addInventoryItem(item, 1)
end

function RemoveItem(source, player, item)
    player.removeInventoryItem(item, 1)
end

function GetPlayerItems(source)
    local player = GetPlayer(source)
    if not player then return nil, nil end
    return player.getInventory(), player.getLoadout()
end

function GetVehicleItems(plate, storageType)
    -- ESX doesn't have vehicle inventory by default
    -- Add your own implementation here if needed
    return nil
end

-- ================== HELPER FUNCTIONS ==================
local function getRandomItemType()
    return itemTypes[math.random(#itemTypes)]
end

local function isWeapon(itemName)
    return includeAllWeapons and string.find(string.lower(itemName), "weapon")
end

local function getItemType(itemName)
    -- Check if item is in searchable items list
    if searchableItems[itemName] then
        return itemTypes[searchableItems[itemName]]
    end
    
    -- Check if item is a weapon
    if isWeapon(itemName) then
        return itemTypes['weapons']
    end
    
    return nil
end

local function searchInventoryItems(items)
    if not items or not next(items) then
        return false, nil
    end
    
    for _, item in pairs(items) do
        if item.count and item.count > 0 then
            local itemType = getItemType(item.name)
            if itemType then
                return true, itemType
            end
        end
    end
    
    return false, nil
end

local function searchWeaponItems(weapons)
    if not weapons or not next(weapons) then
        return false, nil
    end
    
    for _, weapon in pairs(weapons) do
        -- Check if weapon is in searchable items (gets weapons item type)
        if searchableItems[weapon.name] then
            return true, itemTypes['weapons']
        end
        
        -- Check if all weapons should be detected
        if isWeapon(weapon.name) then
            return true, itemTypes['weapons']
        end
    end
    
    return false, nil
end

-- ================== CALLBACK FUNCTIONS ==================
lib.callback.register('sh-k9:cb:HasItem', function(source, item)
    local player = GetPlayer(source)
    if not player then return false end

    local playerItem = player.getInventoryItem(item)
    return playerItem and playerItem.count >= 1
end)

lib.callback.register('sh-k9:cb:SearchNPC', function(source, netId)
    local randomChance = math.random(100)
    local foundContraband = randomChance <= searchConfig.npc.chance
    
    if foundContraband then
        return true, getRandomItemType()
    end
    
    return false, nil
end)

lib.callback.register('sh-k9:cb:SearchPlayer', function(source, playerId)
    local inventoryItems, weaponItems = GetPlayerItems(playerId)
    
    -- Search inventory items first
    local foundInInventory, inventoryItemType = searchInventoryItems(inventoryItems)
    if foundInInventory then
        return true, inventoryItemType
    end
    
    -- Search weapon items if nothing found in inventory
    local foundInWeapons, weaponItemType = searchWeaponItems(weaponItems)
    return foundInWeapons, weaponItemType
end)

--[[ 
    SINCE ESX DOESN'T HAVE VEHICLE INVENTORY BY DEFAULT,
    WE USE RANDOMIZED LOGIC LIKE FOR STANDALONE USERS 
]]
lib.callback.register('sh-k9:cb:SearchVehicle', function(source, plate)
    local randomChance = math.random(100)
    local foundContraband = randomChance <= searchConfig.vehicle.chance
    
    if foundContraband then
        return true, getRandomItemType()
    end
    
    return false, nil
end)