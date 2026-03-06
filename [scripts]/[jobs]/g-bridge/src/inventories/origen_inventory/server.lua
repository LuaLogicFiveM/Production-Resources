---@diagnostic disable: duplicate-set-field
if GetResourceState("origen_inventory") ~= "started" then
    return
end

function INVENTORY.SERVER.GetInventoryName()
    return "origen_inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "origen_inventory/html/images/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return exports.origen_inventory:canCarryItem(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1

    local itemCount = exports.origen_inventory:getItemCount(source, item, count) or 0
    return itemCount >= count
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1
    metadata = metadata or {}

    if not exports.origen_inventory:canCarryItem(source, item, count) then
        return false
    end

    local success = exports.origen_inventory:addItem(source, item, count, metadata, slot, false)
    return success
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = exports.origen_inventory:removeItem(source, item, count, metadata, slot, false)
    return success
end

function INVENTORY.SERVER.GetItemMetadataInfo(itemName)
    if not itemName then
        return nil
    end

    local itemData = exports.origen_inventory:Items(itemName)
    if not itemData then
        return nil
    end

    local metadata = itemData.metadata or itemData.info or {}

    return {
        name = itemData.name or itemData.item or itemName,
        amount = itemData.count or itemData.amount or 1,
        metadata = metadata,
        fullData = itemData
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports.origen_inventory:Items(itemName)

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
    exports.origen_inventory:setMetadata(source, slot, metadata)
end

function INVENTORY.SERVER.Items()
    return exports.origen_inventory:Items()
end


function INVENTORY.SERVER.GetPlayerInventory(source)
    local playerInv = exports.origen_inventory:GetInventory(source)
    local inv = playerInv.inventory or {}
    local newTable = {}
    for _, v in pairs(inv) do
        if v.slot then
            table.insert(newTable, {
                name = v.name,
                count = v.amount or v.count,
                metadata = v.metadata or v.info or {},
                slot = v.slot,
                label = v.label or "unknown"
            })
        end
    end
    return newTable
end