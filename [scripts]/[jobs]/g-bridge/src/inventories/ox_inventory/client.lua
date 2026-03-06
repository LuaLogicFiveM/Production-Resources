---@diagnostic disable: duplicate-set-field
if GetResourceState("ox_inventory") ~= "started" then
    return
end

function INVENTORY.CLIENT.GetInventoryName()
    return "ox_inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "ox_inventory/web/images/"
end


function INVENTORY.CLIENT.GetItemInfo(itemName)
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
