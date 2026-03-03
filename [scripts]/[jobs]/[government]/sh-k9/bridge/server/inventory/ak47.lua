if GetResourceState('ak47_inventory') ~= 'started' then return end

Debug("ak47_inventory system was loaded.", 'success')

-- ================== CONFIGURATION ==================
local settings = require 'config.config'
local searchConfig = settings.search
local itemTypes = searchConfig.item_types
local searchableItems = searchConfig.items
local includeAllWeapons = searchConfig.all_weapons

-- ================== BASIC INVENTORY FUNCTIONS ==================
function AddItem(source, player, item)
    exports['ak47_inventory']:AddItem(source, item, 1)
end

function RemoveItem(source, player, item)
    exports['ak47_inventory']:RemoveItem(source, item, 1)
end

function GetPlayerItems(source)
    return exports['ak47_inventory']:GetInventoryItems(source)
end

function GetVehicleItems(plate, storageType)
    local inventoryPrefix = storageType == 'trunk' and 'trunk' or 'glovebox'
    local inventoryId = inventoryPrefix .. plate
    local inventoryItems = exports['ak47_inventory']:GetInventoryItems(inventoryId)
    
    local items = {}
    for _, item in pairs(inventoryItems or {}) do
        if item and item.name then
            items[#items + 1] = { name = item.name }
        end
    end
    
    return items
end

-- ================== SEARCH HELPER FUNCTIONS ==================
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

local function searchItemsForContraband(items)
    if not items or not next(items) then
        return false, nil
    end
    
    for _, item in pairs(items) do
        if item and item.name then
            local itemType = getItemType(item.name)
            if itemType then
                return true, itemType
            end
        end
    end
    
    return false, nil
end

-- ================== CALLBACK FUNCTIONS ==================
lib.callback.register('sh-k9:cb:HasItem', function(source, item)
    local count = exports['ak47_inventory']:Search(source, 'count', item)
    return count >= 1
end)

lib.callback.register('sh-k9:cb:SearchNPC', function(source, netId)
    local randomChance = math.random(100)
    local foundContraband = randomChance <= searchConfig.npc.chance
    
    if foundContraband then
        local randomItemType = itemTypes[math.random(#itemTypes)]
        return true, randomItemType
    end
    
    return false, nil
end)

lib.callback.register('sh-k9:cb:SearchPlayer', function(source, playerId)
    local playerItems = GetPlayerItems(playerId)
    return searchItemsForContraband(playerItems)
end)

lib.callback.register('sh-k9:cb:SearchVehicle', function(source, plate)
    -- Search trunk first
    local trunkItems = GetVehicleItems(plate, 'trunk')
    local foundInTrunk, itemType = searchItemsForContraband(trunkItems)
    
    if foundInTrunk then
        return true, itemType
    end
    
    -- Search glovebox if nothing found in trunk
    local gloveboxItems = GetVehicleItems(plate, 'glovebox')
    local foundInGlovebox, gloveboxItemType = searchItemsForContraband(gloveboxItems)
    
    return foundInGlovebox, gloveboxItemType
end)