-- ================== INVENTORY SYSTEM DETECTION ==================
local supportedInventories = {
    'ox_inventory', 'qs-inventory', 'qb-inventory', 
    'ps-inventory', 'tgiann-inventory', 'ak47_inventory',
    'es_extended'
}

for _, system in ipairs(supportedInventories) do
    if GetResourceState(system) == 'started' then
        return
    end
end

Debug("Inventory system wasn't detected.", 'inform')

-- ================== CONFIGURATION ==================
local settings = require 'config.config'
local searchConfig = settings.search
local itemTypes = searchConfig.item_types

-- ================== BASIC INVENTORY FUNCTIONS ==================
function AddItem(source, player, item)
    -- Add your code for adding item here
end

function RemoveItem(source, player, item)
    -- Add your code for removing item here
end

-- ================== HELPER FUNCTIONS ==================
local function getRandomItemType()
    local typeKeys = {}
    for key in pairs(itemTypes) do
        typeKeys[#typeKeys + 1] = key
    end
    
    local randomIndex = math.random(1, #typeKeys)
    local randomKey = typeKeys[randomIndex]
    return itemTypes[randomKey]
end

local function performRandomSearch(searchType)
    local searchChance = searchConfig[searchType].chance
    local randomRoll = math.random(100)
    local foundContraband = randomRoll <= searchChance
    
    local itemType = foundContraband and getRandomItemType() or nil
    return foundContraband, itemType
end

-- ================== CALLBACK FUNCTIONS ==================
lib.callback.register('sh-k9:cb:HasItem', function(source, item)
    -- Implement your item check logic here
    return true
end)

lib.callback.register('sh-k9:cb:SearchNPC', function(source, netId)
    return performRandomSearch('npc')
end)

lib.callback.register('sh-k9:cb:SearchPlayer', function(source, playerId)
    return performRandomSearch('player')
end)

lib.callback.register('sh-k9:cb:SearchVehicle', function(source, plate)
    return performRandomSearch('vehicle')
end)