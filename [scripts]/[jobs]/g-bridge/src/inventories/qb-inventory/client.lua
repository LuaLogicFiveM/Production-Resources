---@diagnostic disable: duplicate-set-field
if GetResourceState("qb-inventory") ~= "started" then
	return
end

local Framework = exports['qb-core']:GetCoreObject()


function INVENTORY.CLIENT.GetInventoryName()
    return "qb-inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "qb-inventory/html/images/"
end

function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    if not Framework or not Framework.Shared or not Framework.Shared.Items then return nil end
    local itemData = Framework.Shared.Items[itemName]
    if not itemData then return nil end

    local data = {
        name = itemData.name or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = not itemData.unique
    }
    return data
end
