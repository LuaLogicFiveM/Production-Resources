---@diagnostic disable: duplicate-set-field
if GetResourceState("qs-inventory") ~= "started" then
	return
end


function INVENTORY.CLIENT.GetInventoryName()
    return "qs-inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "qs-inventory/html/images/"
end

function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end

    local itemList = exports['qs-inventory']:GetItemList()
    if not itemList or not itemList[itemName] then
        return nil
    end

    local itemData = itemList[itemName]

    return {
        name = itemData.name or itemName,
        label = itemData.label or itemData.name or itemName,
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = not itemData.unique
    }
end
