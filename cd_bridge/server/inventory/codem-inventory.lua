if Cfg.Inventory ~= 'codem-inventory' then return end

local ItemList = {}
local InventoryImages = {}

-- Check if a player has a specific item and amount
function HasItem(source, item_name, amount)
    local has_item = exports['codem-inventory']:HasItem(source, item_name, amount)
    if has_item  then
        return true
    end
    return false
end

-- Add item to a player's inventory
function AddItem(source, item_name, amount)
    exports['codem-inventory']:AddItem(source, item_name, amount)
end

-- Remove item from a player's inventory
function RemoveItem(source, item_name, amount)
    exports['codem-inventory']:RemoveItem(source, item_name, amount)
end

-- Get the count of a specific item in a player's inventory
function GetItemCount(source, item_name)
    local item_count = exports['codem-inventory']:GetItemCount(source, item_name)
    if item_count then
        return item_count
    end
    return 0
end

-- Check if a player can carry a specific item and amount
function CanCarryItem(source, item_name, amount)
    return exports['codem-inventory']:AddItem(source, item_name, amount)
end

-- Add weapon to a player's inventory
function AddWeapon(source, weapon_name, ammo)
    AddItem(source, weapon_name, 1)
end

-- Check if a player can carry a specific item and amount
function GetItemList()
    if next(ItemList) ~= nil then
        return ItemList
    end
    return exports['codem-inventory']:GetItemList()
end

-- Get inventory images
function GetInventoryImages()
    if next(InventoryImages) ~= nil then
        return InventoryImages
    end
    local images = exports['cd_bridge']:ReadDirectory(
        GetResourcePath('codem-inventory')..'/html/itemimages',
        {'png', 'jpg', 'jpeg', 'gif', 'webp'}
    )
    InventoryImages = images
    return InventoryImages
end