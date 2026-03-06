---@diagnostic disable: duplicate-set-field
if GetResourceState("ox_inventory") ~= "started" then
    return
end

function INVENTORY.SERVER.GetInventoryName()
    return "ox_inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "ox_inventory/web/images/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return ox_inventory:CanCarryItem(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1

    local itemCount = exports.ox_inventory:Search(source, 'count', item) or 0
    return itemCount >= count
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1
    metadata = metadata or {}

    if not exports.ox_inventory:CanCarryItem(source, item, count, metadata) then
        return false
    end

    local success = exports.ox_inventory:AddItem(source, item, count, metadata)
    return success
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
    return success
end

function INVENTORY.SERVER.GetItemMetadataInfo(item)
    if not item then
        return nil
    end

    local metadata = item.metadata or item.info or {}

    return {
        name = item.name or item.item,
        amount = item.count or item.amount or 1,
        metadata = metadata,
        fullData = item
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports.ox_inventory:Items(itemName)

    local data = {
        name = itemData.name or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = itemData.stack or true
    }
    return data

end

function INVENTORY.SERVER.SetMetadata(source, item, slot, metadata)
    exports.ox_inventory:SetMetadata(source, slot, metadata)
end

function INVENTORY.SERVER.Items()
    return exports.ox_inventory:Items()
end


function INVENTORY.SERVER.GetPlayerInventory(source)
    local playerInv = exports.ox_inventory:GetInventoryItems(source, false)
    local inv = playerInv or {}
    local newTable = {}
    for _, v in pairs(inv) do
        table.insert(newTable, {
            name = v.name,
            count = v.amount or v.count,
            metadata = v.metadata or v.info or {},
            slot = v.slot,
            label = v.label or "unknown"
        })
    end
    return newTable
end