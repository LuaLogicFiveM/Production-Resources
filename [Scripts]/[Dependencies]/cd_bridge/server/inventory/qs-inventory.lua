if Cfg.Inventory ~= 'qs-inventory' then return end

local ItemList = {}
local InventoryImages = {}

-- Check if a player has a specific item and amount
function HasItem(source, item_name, amount)
    local has_item = exports['qs-inventory']:GetItemTotalAmount(source, item_name)
    if has_item >= amount then
        return true
    else
        return false
    end
end

-- Add item to a player's inventory
function AddItem(source, item_name, amount)
    exports['qs-inventory']:AddItem(source, item_name, amount)
end

-- Remove item from a player's inventory
function RemoveItem(source, item_name, amount)
    exports['qs-inventory']:RemoveItem(source, item_name, amount)
end

-- Get the count of a specific item in a player's inventory
function GetItemCount(source, item_name)
    local item_count = exports['qs-inventory']:GetItemTotalAmount(source, item_name)
    if item_count then
        return item_count
    end
    return 0
end

-- Check if a player can carry a specific item and amount
function CanCarryItem(source, item_name, amount)
    return exports['qs-inventory']:CanCarryItem(source, item_name, amount)
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
    local qs_items = exports['qs-inventory']:GetItemList()
    if qs_items then
        for item_name, row in pairs(qs_items) do
            ItemList[item_name] = {
                name = item_name,
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
    local images = exports['cd_bridge']:ReadDirectory(
        GetResourcePath('qb-inventory')..'/html/images',
        {'png', 'jpg', 'jpeg', 'gif', 'webp'}
    )
    if images then
        InventoryImages = images
    end
    return InventoryImages
end