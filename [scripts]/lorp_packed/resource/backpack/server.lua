local registeredStashes = {}
local ox_inventory = exports.ox_inventory
local config = {
	onebag = true,
	slots = 10, -- Slots of backpack storage
	weight = 20000 -- Total weight for backpack
}

local function GenerateText(num) -- Thnx Linden
	local str
	repeat str = {}
		for i = 1, num do str[i] = string.char(math.random(65, 90)) end
		str = table.concat(str)
	until str ~= 'POL' and str ~= 'EMS'
	return str
end

local function GenerateSerial(text) -- Thnx Again
	if text and text:len() > 3 then
		return text
	end
	return ('%s%s%s'):format(math.random(100000,999999), text == nil and GenerateText(3) or text, math.random(100000,999999))
end

RegisterServerEvent('lorp_backpack:openBackpack')
AddEventHandler('lorp_backpack:openBackpack', function(identifier)
	if not registeredStashes[identifier] then
        ox_inventory:RegisterStash('bag_'..identifier, 'Backpack', config.slots, config.weight, false)
        registeredStashes[identifier] = true
    end
end)

lib.callback.register('lorp_backpack:getNewIdentifier', function(source, slot)
	local newId = GenerateSerial()
	ox_inventory:SetMetadata(source, slot, {identifier = newId})
	ox_inventory:RegisterStash('bag_'..newId, 'Backpack', config.slots, config.weight, false)
	registeredStashes[newId] = true
	return newId
end)

CreateThread(function()
	while GetResourceState('ox_inventory') ~= 'started' do Wait(500) end

	local swapHook = ox_inventory:registerHook('swapItems', function(payload)
		local start, destination, move_type = payload.fromInventory, payload.toInventory, payload.toType
		local count_bagpacks = ox_inventory:GetItem(payload.source, 'backpack', nil, true)

		if string.find(destination, 'bag_') then
			TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = 'Action Incomplete', description = 'You can\'t place a backpack in a backpack!'})
			return false
		end

		if config.onebag then
			if (count_bagpacks > 0 and move_type == 'player' and destination ~= start) then
				TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = 'Action Incomplete', description = 'You can only have 1x backpack!'})
				return false
			end
		end

		return true
	end, {
		print = false,
		itemFilter = {
			backpack = true,
		},
	})

	local createHook
	if config.onebag then
		createHook = exports.ox_inventory:registerHook('createItem', function(payload)
			local count_bagpacks = ox_inventory:GetItem(payload.inventoryId, 'backpack', nil, true)
			local playerItems = ox_inventory:GetInventoryItems(payload.inventoryId)

			if count_bagpacks > 0 then
				local slot = nil

				for i,k in pairs(playerItems) do
					if k.name == 'backpack' then
						slot = k.slot
						break
					end
				end

				CreateThread(function()
					local inventoryId = payload.inventoryId
					local dontRemove = slot
					Wait(1000)

					for i,k in pairs(ox_inventory:GetInventoryItems(inventoryId)) do
						if k.name == 'backpack' and dontRemove ~= nil and k.slot ~= dontRemove then
							local success = ox_inventory:RemoveItem(inventoryId, 'backpack', 1, nil, k.slot)
							if success then
								TriggerClientEvent('ox_lib:notify', inventoryId, {type = 'error', title = 'Action Incomplete', description = 'You can only have 1x backpack!'})
							end
							break
						end
					end
				end)
			end
		end, {
			print = false,
			itemFilter = {
				backpack = true
			}
		})
	end

	AddEventHandler('onResourceStop', function()
		ox_inventory:removeHooks(swapHook)
		if config.onebag then
			ox_inventory:removeHooks(createHook)
		end
	end)
end)
