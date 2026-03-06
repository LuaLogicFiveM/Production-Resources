---@diagnostic disable: duplicate-set-field
if GetResourceState("qb-inventory") ~= "started" then
	return
end
Wait(100)
G.Inventory = {}
G.Inventory.inventoryPath = "qb-inventory/html/images/"
---@diagnostic disable-next-line: duplicate-set-field
function G.Inventory.CanCarryItem(source, item, amount)
	return exports["qb-inventory"]:CanAddItem(source, item, amount)
end
