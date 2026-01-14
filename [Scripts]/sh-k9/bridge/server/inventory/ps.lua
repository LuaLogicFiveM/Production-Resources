if GetResourceState('ps-inventory') ~= 'started' then return end

Debug('ps-inventory system was loaded.', 'success')

-- ================== CONFIGURATION ==================
local itemList = exports['qb-core']:GetCoreObject().Shared.Items
local settings = require 'config.config'
local searchConfig = settings.search
local itemTypes = searchConfig.item_types
local searchableItems = searchConfig.items
local includeAllWeapons = searchConfig.all_weapons

-- ================== BASIC INVENTORY FUNCTIONS ==================
function AddItem(source, player, item)
    player.Functions.AddItem(item, 1)
    
    -- Show item box notification if item exists in item list
    if itemList[item] then 
        TriggerClientEvent('inventory:client:ItemBox', source, itemList[item], 'add') 
    end
end

function RemoveItem(source, player, item)
    player.Functions.RemoveItem(item, 1)
    
    -- Show item box notification if item exists in item list
    if itemList[item] then 
        TriggerClientEvent('inventory:client:ItemBox', source, itemList[item], 'remove') 
    end
end

function GetPlayerItems(source)
    local player = GetPlayer(source)
    return player and player.PlayerData.items or nil
end

function GetVehicleItems(plate, storageType)
    if storageType == 'trunk' then
        return exports['ps-inventory']:GetTrunkItems(plate)
    elseif storageType == 'glovebox' then
        return exports['ps-inventory']:GetGloveboxItems(plate)
    end
    
    return false
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
        local itemType = getItemType(item.name)
        if itemType then
            return true, itemType
        end
    end
    
    return false, nil
end

-- ================== CALLBACK FUNCTIONS ==================
lib.callback.register('sh-k9:cb:HasItem', function(source, item)
    return exports['ps-inventory']:HasItem(source, item, 1)
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