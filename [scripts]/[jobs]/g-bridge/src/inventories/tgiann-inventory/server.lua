---@diagnostic disable: duplicate-set-field
if GetResourceState("jaksam_inventory") ~= "started" then
    return
end

function INVENTORY.SERVER.GetInventoryName()
    return "jaksam_inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "jaksam_inventory/_images/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return exports["jaksam_inventory"]:canCarryItem(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1

    local itemCount = exports["jaksam_inventory"]:hasItem(source, item, count) or 0
    return itemCount >= count
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1
    metadata = metadata or {}

    if not exports["jaksam_inventory"]:canCarryItem(source, item, count) then
        return false
    end

    local success = exports["jaksam_inventory"]:addItem(source, item, count, metadata, slot)
    return success
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = exports["jaksam_inventory"]:removeItem(source, item, count, metadata, slot)
    return success
end

function INVENTORY.SERVER.GetItemMetadataInfo(source, itemName)
    local src = type(source) == "number" and source or nil

    if not itemName then
        return nil
    end

    if not src then
        return {}
    end

    local item, _slotId = exports["jaksam_inventory"]:getItemByName(src, itemName)
    if not item or not item.name then
        return {}
    end
    return {
        name = item.name or itemName,
        amount = item.amount or 0,
        metadata = item.metadata or {},
        fullData = item
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports['jaksam_inventory']:getStaticItem(itemName)

    local data = {
        name = itemData.name or itemName or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = itemData.stackable or true
    }
    return data
end

function INVENTORY.SERVER.SetMetadata(source, item, slot, metadata)
    exports["jaksam_inventory"]:setItemMetadataInSlot(source, slot, metadata)
end

function INVENTORY.SERVER.Items()
    return exports["jaksam_inventory"]:getStaticItemsList()
end

function INVENTORY.SERVER.GetPlayerInventory(source)
    local inventory = exports["jaksam_inventory"]:getInventory(source)
    if not inventory or not inventory.items then
        return {}
    end

    local newTable = {}

    for slot, v in pairs(inventory.items) do
        if v and v.name then
            newTable[#newTable + 1] = {
                name = v.name,
                count = v.amount or 0,
                metadata = v.metadata or {},
                slot = slot,
                label = v.label or v.name
            }
        end
    end

    return newTable
end
