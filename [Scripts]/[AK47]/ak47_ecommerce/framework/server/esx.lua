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
	return GetPlayer(source).job
end

GetPlayerFromIdentifier = function(identifier)
	return ESX.GetPlayerFromIdentifier(identifier)
end

AddItem = function(source, item, amount)
	local xPlayer = GetPlayer(source)
	xPlayer.addInventoryItem(item, amount)
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

GetPhoneNumber = function(source)
	local identifier = GetIdentifier(source)
	local result = MySQL.Sync.fetchAll('SELECT phone_number FROM phone_phones WHERE owner_id = ?', {identifier})
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

Notify = function(source, msg, type)
	TriggerClientEvent('ak47_ecommerce:notify', source, msg, type)
end