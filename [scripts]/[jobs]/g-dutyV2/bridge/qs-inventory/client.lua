---@diagnostic disable: duplicate-set-field
if GetResourceState("qs-inventory") ~= "started" then
	return
end
Wait(100)
G.Inventory = {}
G.Inventory.inventoryPath = "qs-inventory/html/images/"
G.Inventory.Name = "qs-inventory"
