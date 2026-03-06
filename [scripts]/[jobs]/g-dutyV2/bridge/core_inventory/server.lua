if GetResourceState("core_inventory") ~= "started" then
	return
end

Wait(100)
G.Inventory = {}
---@diagnostic disable-next-line: duplicate-set-field
function G.Inventory.CanCarryItem(source, item, amount)
	return exports.core_inventory:canCarry(source, item, amount)
end

-- Not tested. If you're a developer and find any bugs, please feel free to fix them and post the updated version in the #g-snippets channel on the Groot Development Discord server
---@diagnostic disable-next-line: duplicate-set-field
function G.Inventory.InventoryItem(src, itemName)
	local count = exports.core_inventory:getItemCount(src, itemName)
	return count or 0
end
