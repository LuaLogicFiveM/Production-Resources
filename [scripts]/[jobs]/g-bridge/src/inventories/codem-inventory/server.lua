---@diagnostic disable: duplicate-set-field
if GetResourceState("codem-inventory") ~= "started" then
    return
end

function INVENTORY.SERVER.GetInventoryName()
    return "codem-inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "codem-inventory/html/itemimages/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    -- seems like codem-inventory doesn't have a way to check if a player can carry an item
    return true
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1

    local has = exports['codem-inventory']:HasItem(source, item, count)
    return has
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1
    metadata = metadata or {}

    local success = exports["codem-inventory"]:AddItem(source, item, count, slot, metadata)
    return success
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = exports["codem-inventory"]:RemoveItem(source, item, count, slot)
    return success
end

function INVENTORY.SERVER.GetItemMetadataInfo(itemName)
    if not itemName then
        return nil
    end

    local items = exports['codem-inventory']:GetItemList()
    if not items or not items[itemName] then
        return nil
    end

    local item = items[itemName]

    return {
        name = item.name or itemName,
        amount = item.count or item.amount,
        metadata = item.info or item.metadata or {},
        fullData = item
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports["codem-inventory"]:GetItemList(itemName)

    local data = {
        name = itemData.name or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = itemData.unique or true
    }
    return data
end

function INVENTORY.SERVER.SetMetadata(source, item, slot, metadata)
    exports["codem-inventory"]:SetItemMetadata(source, slot, metadata)
end

function INVENTORY.SERVER.Items()
    return exports["codem-inventory"]:GetItemList()
end

function INVENTORY.SERVER.GetPlayerInventory(source)
    local identifier = FRAMEWORKS.SERVER.GetIdentifier(source)
    local inventory = exports["codem-inventory"]:GetInventory(identifier, source)
    if not inventory then
        return {}
    end

    local newTable = {}

    for _, v in pairs(inventory) do
        table.insert(newTable, {
            name = v.name,
            label = v.label or v.name,
            count = v.amount or v.count,
            metadata = v.info or v.metadata or {},
            slot = v.slot
        })
    end
    return newTable
end
