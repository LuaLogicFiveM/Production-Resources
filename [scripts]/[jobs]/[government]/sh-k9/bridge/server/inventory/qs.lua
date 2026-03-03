if GetResourceState('qs-inventory') ~= 'started' then return end

Debug('Quasar Inventory system was loaded.', 'success')

-- ================== CONFIGURATION ==================
local itemList = exports['qs-inventory']:GetItemList()
local settings = require 'config.config'
local searchConfig = settings.search
local itemTypes = searchConfig.item_types
local searchableItems = searchConfig.items
local includeAllWeapons = searchConfig.all_weapons

-- ================== BASIC INVENTORY FUNCTIONS ==================
function AddItem(source, player, item)
    exports['qs-inventory']:AddItem(source, item, 1)
end

function RemoveItem(source, player, item)
    exports['qs-inventory']:RemoveItem(source, item, 1)
end

function GetPlayerItems(source)
    return exports['qs-inventory']:GetInventory(source)
end

function GetVehicleItems(plate, storageType)
    -- Database table mapping
    local queryMap = {
        trunk = 'SELECT items FROM inventory_trunk WHERE plate = ?',
        glovebox = 'SELECT items FROM inventory_glovebox WHERE plate = ?'
    }
    
    local query = queryMap[storageType]
    if not query then return nil end
    
    local databaseResult = MySQL.scalar.await(query, {plate})
    local decodedItems = json.decode(databaseResult)
    
    if not decodedItems then return nil end
    
    local items = {}
    for _, item in pairs(decodedItems) do
        local itemInfo = itemList[item.name:lower()]
        if itemInfo then 
            items[item.slot] = { name = itemInfo["name"] } 
        end
    end
    
    return items
end

-- ================== SEARCH HELPER FUNCTIONS ==================
local function isWeapon(itemName)
    return includeAllWeapons and string.find(itemName, "weapon")
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
        local itemType = getItemType(item.name)
        if itemType then
            return true, itemType
        end
    end
    
    return false, nil
end

-- ================== CALLBACK FUNCTIONS ==================
lib.callback.register('sh-k9:cb:HasItem', function(source, item)
    return exports['qs-inventory']:HasItem(source, item, 1)
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