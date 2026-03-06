---@diagnostic disable: duplicate-set-field
if GetResourceState("origen_inventory") ~= "started" then
    return
end

function INVENTORY.CLIENT.GetInventoryName()
    return "origen_inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "origen_inventory/html/images/"
end


function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports.origen_inventory:Items()[itemName]

    local data = {
        name = itemData.name or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = itemData.unique or true
    }
    return data

end
