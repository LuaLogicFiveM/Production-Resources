---@diagnostic disable: duplicate-set-field
if GetResourceState("core_inventory") ~= "started" then
    return
end

if _G.CALLBACK then
    _G.CALLBACK.Register('g-bridge:inventory:core_inventory:items', function()
        return exports.core_inventory:getItemsList() or {}
    end)
end

function INVENTORY.SERVER.GetInventoryName()
    return "core_inventory"
end

function INVENTORY.SERVER.GetInventoryImagePath()
    return "core_inventory/html/img/"
end

function INVENTORY.SERVER.CanCarryItem(source, item, count)
    count = count or 1
    return exports.core_inventory:canCarry(source, item, count)
end

function INVENTORY.SERVER.HasItem(source, item, count)
    count = count or 1
    return exports.core_inventory:hasItem(source, item, count)
end

function INVENTORY.SERVER.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end
    count = count or 1
    metadata = metadata or {}
    if not exports.core_inventory:canCarry(source, item, count, metadata) then
        return false
    end
    local ok = exports.core_inventory:addItem(source, item, count, metadata, nil)
    return ok == true or type(ok) == "table"
end

function INVENTORY.SERVER.RemoveItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end
    count = count or 1
    return exports.core_inventory:removeItem(source, item, count)
end

function INVENTORY.SERVER.GetItemMetadataInfo(itemName)
    if not itemName then
        return nil
    end
    local itemList = exports.core_inventory:getItemsList() or {}
    local itemData = itemList[itemName]
    if not itemData then
        return {}
    end
    return {
        name = itemData.name or itemName,
        amount = itemData.count or itemData.amount or 0,
        metadata = itemData.info or itemData.metadata or {},
        fullData = itemData
    }
end

function INVENTORY.SERVER.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemList = exports.core_inventory:getItemsList() or {}
    local raw = itemList[itemName] or {}
    if next(raw) == nil then
        return {}
    end
    return {
        name = raw.name or itemName,
        label = raw.label or raw.name or "",
        weight = raw.weight or 0,
        description = raw.description or "",
        stack = not raw.unique
    }
end

function INVENTORY.SERVER.SetMetadata(source, item, slot, metadata)
    exports.core_inventory:setMetadata(source, slot, metadata or {})
end

function INVENTORY.SERVER.Items()
    return exports.core_inventory:getItemsList() or {}
end

function INVENTORY.SERVER.GetPlayerInventory(source)
    local inv = exports.core_inventory:getInventory(source)
    if not inv or type(inv) ~= "table" then
        return {}
    end
    local out = {}
    for _, v in pairs(inv) do
        if v and v.name then
            table.insert(out, {
                name = v.name,
                count = v.amount or v.count or 0,
                metadata = v.info or v.metadata or {},
                slot = v.slot or (v.slots and v.slots[1]),
                label = v.label or v.name
            })
        end
    end
    return out
end
