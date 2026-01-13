ESX = exports['es_extended']:getSharedObject()

GetSource = function(xPlayer)
	return xPlayer.source
end

GetPlayer = function(source)
	return ESX.GetPlayerFromId(source)
end

GetSourceFromIdentifier = function(identifier)
	return GetPlayerFromIdentifier(identifier).source
end

GetPlayers = function()
	return ESX.GetPlayers()
end

GetJob = function(source)
	local xPlayer = GetPlayer(source)
	return xPlayer and xPlayer.job
end

GetPlayerFromIdentifier = function(identifier)
	return ESX.GetPlayerFromIdentifier(identifier)
end

AddItem = function(source, item, amount, meta)
	local xPlayer = GetPlayer(source)
	if not meta then
		xPlayer.addInventoryItem(item, amount)
	else
		if Config.Inventory == 'ak47_inventory' then
			exports['ak47_inventory']:AddItem(source, item, amount, nil, meta)
		elseif Config.Inventory == 'ox_inventory' then
			exports['ox_inventory']:AddItem(source, item, amount, meta)
		elseif Config.Inventory == 'qs-inventory' then
			exports['qs-inventory']:AddItem(source, item, amount, nil, meta)
		elseif Config.Inventory == 'codem-inventory' then
			exports['codem-inventory']:AddItem(source, item, amount, nil, meta)
		elseif Config.Inventory == 'tgiann-inventory' then
			exports['tgiann-inventory']:AddItem(source, item, amount, nil, meta)
		elseif Config.Inventory == 'origen_inventory' then
			exports['origen_inventory']:AddItem(source, item, amount, nil, meta)
		end
	end
end

RemoveItem = function(source, item, amount)
	local xPlayer = GetPlayer(source)
	xPlayer.removeInventoryItem(item, amount)
end

GetMoney = function(source, account)
	local account = account == 'cash' and 'money' or account
	local xPlayer = GetPlayer(source)
	return xPlayer.getAccount(account).money
end

AddMoney = function(source, account, amount)
	local account = account == 'cash' and 'money' or account
	local xPlayer = GetPlayer(source)
	xPlayer.addAccountMoney(account, amount)
end

RemoveMoney = function(source, account, amount)
	local account = account == 'cash' and 'money' or account
	local xPlayer = GetPlayer(source)
	xPlayer.removeAccountMoney(account, amount)
end

GetIdentifier = function(source)
	local xPlayer = GetPlayer(source)
	return xPlayer.identifier
end

GetInventory = function(source)
	local xPlayer = GetPlayer(source)
	return xPlayer.getInventory()
end

GetInventoryItem = function(source, item)
	local xPlayer = GetPlayer(source)
	local inv = xPlayer.getInventoryItem(item)
	return inv and (inv.amount or inv.count) or 0
end

HasEnoughItem = function(source, item, amount)
	local xPlayer = GetPlayer(source)
	local inv = xPlayer.getInventoryItem(item)
	return inv and ((inv.amount and inv.amount >= amount) or (inv.count and inv.count >= amount)) or false
end

GetItems = function()
	if GetResourceState('qs-inventory') == 'started' then
		return exports['qs-inventory']:GetItemList()
	elseif GetResourceState('ox_inventory') == 'started' then
		return exports['ox_inventory']:Items()
	else
		return exports['es_extended']:getSharedObject().Items
	end
end

GetItemLabel = function(item)
	local items = GetItems()
    if items and items[item] then
	   return items[item].label
    else
        print('^1Item: ^3['..item..']^1 missing^0')
        return item
    end
end

AddSocietyMoney = function(job, money)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job, function(account)
       account.addMoney(money)
    end)
end

GetIdentifierByType = function(playerId, idtype)
    local src = source
    for _, identifier in pairs(GetPlayerIdentifiers(playerId)) do
        if string.find(identifier, idtype) then
            return identifier
        end
    end
    return nil
end

GetName = function(source)
	local identifier = GetIdentifier(source)
	local namedb = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
    local name = namedb[1].firstname or ''
    name = namedb[1].lastname and name..' '..namedb[1].lastname or ''
    return name
end

GetNameFromIdentifier = function(identifier)
	local namedb = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
    local name = namedb[1].firstname or ''
    name = namedb[1].lastname and name..' '..namedb[1].lastname or ''
    return name
end

GetPhoneNumber = function(source)
	local identifier = GetIdentifier(source)
	local result = MySQL.Sync.fetchAll('SELECT phone_number FROM users WHERE identifier = ?', {identifier})
    return result and result[1] and result[1].phone_number
end

CanCarryItem = function(source, item, amount)
	local xPlayer = GetPlayer(source)
	if xPlayer.canCarryItem then
		return xPlayer.canCarryItem(item, amount)
	else
		return true
	end
end

IsAdmin = function(source)
	local xPlayer = GetPlayer(source)
	if (Config.AdminWithAce and IsPlayerAceAllowed(source, 'command')) then
		return true
	elseif Config.AdminWithGroup[xPlayer.getGroup()] then
		return true
	elseif  Config.AdminWithLicense[GetIdentifierByType(source, 'license')] then
		return true
	elseif Config.AdminWithIdentifier[GetIdentifier(source)] then 
		return true
	end
	return false
end

GetPlayerMetaValue = function(source, type)
	local xPlayer = GetPlayer(source)
	return xPlayer.getMeta(type)
end

SetPlayerMetaValue = function(source, type, val)
	local xPlayer = GetPlayer(source)
	return xPlayer.setMeta(type, val)
end

GetItemAmount = function(source, item)
	local xPlayer = GetPlayer(source)
	local inv = xPlayer.getInventoryItem(item)
	return inv and (inv.amount or inv.count) or 0
end

GetPlayerInventory = function(source)
    local items = {}

    for i, v in pairs(Config.Items) do
    	local amount = GetItemAmount(source, i)
    	if amount > 0 then
    		table.insert(items, { id = i, quantity = amount, label = v.label })
    	end
    end

    return items
end

Notify = function(source, msg, type)
	TriggerClientEvent('ak47_radio:notify', source, msg, type)
end

--[[ESX.RegisterUsableItem(Config.UsableItem, function(source, item)
    TriggerClientEvent('ak47_radio:client:open', source)
end)]]