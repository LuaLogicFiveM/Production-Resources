if GetResourceState('qb-inventory') ~= 'started' then return end

Debug('qb-inventory system was loaded.', 'success')

-- ================== CONFIGURATION ==================
local QBCore = exports['qb-core']:GetCoreObject()
local itemList = QBCore.Shared.Items
local settings = require 'config.config'
local searchConfig = settings.search
local itemTypes = searchConfig.item_types
local searchableItems = searchConfig.items
local includeAllWeapons = searchConfig.all_weapons

-- ================== BASIC INVENTORY FUNCTIONS ==================
function AddItem(source, player, item)
    player.Functions.AddItem(item, 1)

    if itemList[item] then 
        TriggerClientEvent('inventory:client:ItemBox', source, itemList[item], 'add') 
    end
end

function RemoveItem(source, player, item)
    player.Functions.RemoveItem(item, 1)

    if itemList[item] then 
        TriggerClientEvent('inventory:client:ItemBox', source, itemList[item], 'remove') 
    end
end

function GetPlayerItems(source)
    local player = GetPlayer(source)
    return player and player.PlayerData.items or nil
end

function GetVehicleItems(plate, storageType)
    local inventoryId = storageType .. '-' .. plate
    
    local query = 'SELECT items FROM inventories WHERE identifier = ?'
    local dbResult = MySQL.scalar.await(query, {inventoryId})
    
    if not dbResult then return nil end
    
    local rawItems = json.decode(dbResult)
    if not rawItems then return nil end
    
    local formattedItems = {}
    for _, item in pairs(rawItems) do
        local itemInfo = itemList[item.name:lower()]
        if itemInfo then 
            formattedItems[item.slot] = { name = itemInfo.name } 
        end
    end
    
    return formattedItems
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
    return exports['qb-inventory']:HasItem(source, item, 1)
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