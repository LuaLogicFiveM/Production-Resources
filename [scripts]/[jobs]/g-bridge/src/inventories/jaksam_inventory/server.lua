---@diagnostic disable: duplicate-set-field
if GetResourceState("tgiann-inventory") ~= "started" then
    return
end

function INVENTORY.SERVER.GetInventoryName()
    return "tgiann-inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "tgiann-inventory/inventory_images/images/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return exports["tgiann-inventory"]:CanCarryItem(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1

    local itemCount = exports["tgiann-inventory"]:HasItem(source, item, count) or 0
    return itemCount >= count
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1
    metadata = metadata or {}

    if not exports["tgiann-inventory"]:CanCarryItem(source, item, count) then
        return false
    end

    local success = exports["tgiann-inventory"]:AddItem(source, item, count, slot, metadata, false)
    return success
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = exports["tgiann-inventory"]:RemoveItem(source, item, count, slot, metadata)
    return success
end

function INVENTORY.SERVER.GetItemMetadataInfo(itemName)
    if not itemName then
        return nil
    end

    local itemData = exports["tgiann-inventory"]:GetItemList(itemName)
    if not itemData[itemName] then
        return {}
    end

    local metadata = itemData.info or itemData.metadata or {}

    return {
        name = itemData.name or itemData.item or itemName,
        amount = itemData.count or itemData.amount,
        metadata = metadata,
        fullData = itemData
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports["tgiann-inventory"]:GetItemList(itemName)

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
    exports["tgiann-inventory"]:UpdateItemMetadata(source, item, slot, metadata)
end

function INVENTORY.SERVER.Items()
    return exports["tgiann-inventory"]:Items()
end

function INVENTORY.SERVER.GetPlayerInventory(source)
    local inventory = exports["tgiann-inventory"]:GetPlayerItems(source)
    if not inventory then
        return {}
    end

    local newTable = {}

    for _, v in pairs(inventory) do
        if tonumber(_) then
            table.insert(newTable, {
                name = v.name,
                count = v.amount or v.count,
                metadata = v.info or {},
                slot = v.slot,
                label = v.label or v.name
            })
        end
    end
    return newTable
end
