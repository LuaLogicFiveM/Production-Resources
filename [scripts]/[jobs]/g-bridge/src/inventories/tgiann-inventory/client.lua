---@diagnostic disable: duplicate-set-field
if GetResourceState("jaksam_inventory") ~= "started" then
    return
end

function INVENTORY.CLIENT.GetInventoryName()
    return "jaksam_inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "jaksam_inventory/_images/"
end

function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local item, _slotId = exports["jaksam_inventory"]:getItemByName(itemName)
    if not item or not item.name then
        return {}
    end
    return {
        name = item.name or itemName,
        label = item.label or item.name or "",
        weight = item.weight or 0,
        description = item.description or "",
        stack = not item.unique
    }
end
