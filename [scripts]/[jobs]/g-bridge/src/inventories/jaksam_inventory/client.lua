---@diagnostic disable: duplicate-set-field
if GetResourceState("tgiann-inventory") ~= "started" then
    return
end

function INVENTORY.CLIENT.GetInventoryName()
    return "tgiann-inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "tgiann-inventory/inventory_images/images/"
end


function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemData = exports["tgiann-inventory"]:GetItemList(itemName)
    if not itemData[itemName] then return {} end

    local data = {
        name = itemData.name or "",
        label = itemData.label or itemData.name or "",
        weight = itemData.weight or 0,
        description = itemData.description or "",
        stack = itemData.unique or true
    }
    return data
end
