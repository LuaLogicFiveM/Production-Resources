---@diagnostic disable: duplicate-set-field, need-check-nil, undefined-field
if GetResourceState("qb-inventory") ~= "started" then
    return
end

local qbInventory = exports['qb-inventory']

local Framework = exports['qb-core']:GetCoreObject()

function INVENTORY.SERVER.GetInventoryName()
    return "qb-inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "qb-inventory/html/images/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return qbInventory:CanAddItem(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1
    return qbInventory:HasItem(source, item, count)
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local canAdd, reason = exports['qb-inventory']:CanAddItem(source, item, count)
    if not canAdd then
        return false, reason
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return false
    end

    local md = type(metadata) == "table" and metadata
    local success = Player.Functions.AddItem(item, count, slot or false, md)

    return success or false
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    count = count or 1

    local success = qbInventory:RemoveItem(source, item, count, slot, 'g-bridge')
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
    if not Framework or not Framework.Shared or not Framework.Shared.Items then
        return nil
    end
    local itemData = Framework.Shared.Items[itemName]
    if not itemData then
        return nil
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
    local slotData = qbInventory:GetItemBySlot(source, slot)
    if slotData then
        qbInventory:SetMetadata(source, slot, metadata)
    end
end

function INVENTORY.SERVER.Items()
    if not Framework or not Framework.Shared or not Framework.Shared.Items then
        return {}
    end
    return Framework.Shared.Items
end

function INVENTORY.SERVER.GetPlayerInventory(source)
    local player = FRAMEWORKS.SERVER.GetPlayer(source)
    if not player then
        return nil
    end

    local playerInventory = player.PlayerData.items or {}
    local newTable = {}

    for _, v in pairs(playerInventory) do
        if v and v.name and v.amount > 0 then
            table.insert(newTable, {
                name = v.name,
                count = v.amount,
                metadata = v.info or {},
                slot = v.slot,
                label = v.label or Framework.Shared.Items[v.name].label or "unknown"
            })
        end
    end

    return newTable
end
