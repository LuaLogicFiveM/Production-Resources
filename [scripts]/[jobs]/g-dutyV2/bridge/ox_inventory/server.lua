if GetResourceState("ox_inventory") ~= "started" then
	return
end

Wait(100)
G.Inventory = {}
---@diagnostic disable-next-line: duplicate-set-field
function G.Inventory.CanCarryItem(source, item, amount)
	return exports.ox_inventory:CanCarryItem(source, item, amount)
end
---@diagnostic disable-next-line: duplicate-set-field
function G.Inventory.InventoryItem(src, itemName)
	local count = exports.ox_inventory:Search(src, "count", itemName) or 0
	return count or 0
end
