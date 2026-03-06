---@diagnostic disable: duplicate-set-field
if GetResourceState("codem-inventory") ~= "started" then
    return
end

function INVENTORY.CLIENT.GetInventoryName()
    return "codem-inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "codem-inventory/html/itemimages/"
end

function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end

    local itemList = exports["codem-inventory"]:GetItemList()
    if not itemList or not itemList[itemName] then
        return nil
    end

    local item = itemList[itemName]

    return {
        name = item.name or itemName,
        label = item.label or item.name or itemName,
        weight = item.weight or 0,
        description = item.description or "",
        stack = not item.unique
    }
end
