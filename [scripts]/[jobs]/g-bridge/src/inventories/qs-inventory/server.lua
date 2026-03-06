---@diagnostic disable: duplicate-set-field, need-check-nil, undefined-field
if GetResourceState("qb-inventory") ~= "started" then
    return
end

function INVENTORY.SERVER.GetInventoryName()
    return "qs-inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "qs-inventory/html/images/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return exports['qs-inventory']:CanCarryItem(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    if not src or not item then
        return false
    end
    count = count or 1

    local total = exports['qs-inventory']:GetItemTotalAmount(source, item)

    return total and total >= count
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1
    metadata = metadata or {}

    if not exports['qs-inventory']:CanCarryItem(source, item, count) then
        return false
    end

    local success = exports['qs-inventory']:AddItem(source, item, count, metadata)
    return success
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = exports['qs-inventory']:RemoveItem(source, item, count, slot, metadata)
    return success or false
end

function INVENTORY.SERVER.GetItemMetadataInfo(item)
    if not item then
        return nil
    end

    local metadata = item.info or item.metadata or {}

    return {
        name = item.name or item.item,
        amount = item.amount or item.count or 1,
        metadata = metadata,
        fullData = item
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemsData = exports['qs-inventory']:GetItemList()

    local itemData = itemsData[itemName]
    if not itemData then
        return {}
    end

    local data = {
        name = itemData.name or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = not itemData.unique
    }
    return data
end

function INVENTORY.SERVER.SetMetadata(source, item, slot, metadata)
    exports['qs-inventory']:SetItemMetadata(source, slot, metadata)
end

function INVENTORY.SERVER.Items()
    return exports['qs-inventory']:GetItemList()
end

function INVENTORY.SERVER.GetPlayerInventory(source)
    local inventory = exports['qs-inventory']:GetInventory(source)
    if not inventory then
        return {}
    end

    local newTable = {}

    for slot, v in pairs(inventory) do
        if v and v.name then
            table.insert(newTable, {
                name = v.name,
                count = v.amount or v.count,
                metadata = v.info or v.metadata or {},
                slot = slot,
                label = v.label or v.name or "unknown"
            })
        end
    end

    return newTable
end
