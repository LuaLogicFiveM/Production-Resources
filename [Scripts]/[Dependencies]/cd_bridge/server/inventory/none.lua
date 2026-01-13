if Cfg.Inventory ~= 'none' then return end

-- Check if a player has a specific item and amount
function HasItem(source, item_name, amount)
    return true
end

-- Add item to a player's inventory
function RemoveItem(source, item_name, amount)

end

-- Remove item from a player's inventory
function GetItemCount(source, item_name)
    return 10000
end

-- Check if a player can carry a specific item and amount
function CanCarryItem(source, item_name, amount)
    return true
end

-- Add weapon to a player's inventory
function AddWeapon(source, weapon_name, ammo)

end

-- Check if a player can carry a specific item and amount
function GetItemList()
    return {}
end

-- Get inventory images
function GetInventoryImages()
    return {}
end