-- All the code in the file is included as an example. You should edit these exports according to your own script.

if not configCore.custom.customInventory then return end
local myInventory = exports["my-inventory-script"]

---@return CustomInventoryItem[]
---@diagnostic disable-next-line:duplicate-set-field
tgiCore.Items = function()
    return myInventory:Items()
end

---@return CustomInventoryPlayerItem[]
---@diagnostic disable-next-line:duplicate-set-field
tgiCore.getPlayerItems = function()
    return myInventory:GetPlayerItems()
end

---@param item string
---@return string
---@diagnostic disable-next-line:duplicate-set-field
tgiCore.itemName = function(item)
    local itemData = myInventory:Items(item)
    if itemData then
        return itemData.label
    else
        return string.format("Item Not Found! %s", item)
    end
end

---@param item string
---@return CustomInventoryItem|nil
---@diagnostic disable-next-line:duplicate-set-field
function tgiCore.item(item)
    local itemData = myInventory:Items(item)
    return itemData
end
