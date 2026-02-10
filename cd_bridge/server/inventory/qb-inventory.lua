if Cfg.Inventory ~= 'qb-inventory' then return end

local ItemList = {}
local InventoryImages = {}

-- Check if a player has a specific item and amount
function HasItem(source, item_name, amount)
    local has_item = exports['qb-inventory']:HasItem(source, item_name, amount)
    if has_item  then
        return true
    end
    return false
end

-- Add item to a player's inventory
function AddItem(source, item_name, amount)
    exports['qb-inventory']:AddItem(source, item_name, amount)
end

-- Remove item from a player's inventory
function RemoveItem(source, item_name, amount)
    exports['qb-inventory']:RemoveItem(source, item_name, amount)
end

-- Get the count of a specific item in a player's inventory
function GetItemCount(source, item_name)
    local item_count = exports['qb-inventory']:GetItemCount(source, item_name)
    if item_count then
        return item_count
    end
    return 0
end

-- Check if a player can carry a specific item and amount
function CanCarryItem(source, item_name, amount)
    local canAdd, reason = exports['qb-inventory']:CanAddItem(source, item_name, amount)
    return canAdd
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
    local qb_items = QBCore.Shared.Items
    if qb_items then
        for name, row in pairs(qb_items) do
            ItemList[name or row.name] = {
                name = name or row.name,
                label = row.label
            }
        end
    end
    return ItemList
end

-- Get inventory images
function GetInventoryImages()
    if next(InventoryImages) ~= nil then
        return InventoryImages
    end

    local images = exports['cd_bridge']:ReadNUIDirectory(
        GetResourcePath('qb-inventory')..'/html/images',
        'qb-inventory/html/images/',
        {'png', 'jpg', 'jpeg', 'gif', 'webp'}
    )
    if images then
        InventoryImages = images
    end
    return InventoryImages
end