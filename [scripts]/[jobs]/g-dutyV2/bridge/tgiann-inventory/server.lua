---@diagnostic disable: duplicate-set-field
if GetResourceState("tgiann-inventory") ~= "started" then
    return
end


Wait(100)
G.Inventory = {}


function G.Inventory.CanCarryItem(source, item, amount)
	return exports["tgiann-inventory"]:CanCarryItem(source, item, amount)
end


function G.Inventory.InventoryItem(src, itemName)
	local count = exports["tgiann-inventory"]:GetItemCount(src, itemName)
	return count or 0
end
