ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
	if Config.Inventory == 'auto' then
		if GetResourceState('ak47_inventory') ~= 'missing' then
			Config.Inventory = 'ak47_inventory'
		elseif GetResourceState('ox_inventory') ~= 'missing' then
			Config.Inventory = 'ox_inventory'
		elseif GetResourceState('qs-inventory') ~= 'missing' then
			Config.Inventory = 'qs-inventory'
		elseif GetResourceState('codem-inventory') ~= 'missing' then
			Config.Inventory = 'codem-inventory'
		elseif GetResourceState('origen_inventory') ~= 'missing' then
			Config.Inventory = 'origen_inventory'
		elseif GetResourceState('tgiann-inventory') ~= 'missing' then
			Config.Inventory = 'tgiann-inventory'
		else
			print('^1Incompatible inventory! Please set your inventory in config.^0')
			return
		end
		print(string.format("^2%s initialized for this script.^0", Config.Inventory))
	end
end)

pError = function(err)
    print(string.format("^1SCRIPT ERROR: %s^0", err))
end

GetPlayers = function()
	return ESX.GetPlayers()
end

GetPlayer = function(source)
	return ESX.GetPlayerFromId(source)
end

GetSource = function(xPlayer)
	return xPlayer.source
end

GetIdentifier = function(source)
	local xPlayer = GetPlayer(source)
	return xPlayer.identifier
end

GetInventory = function(source)
	local xPlayer = GetPlayer(source)
	return xPlayer.inventory
end

GetDob = function(source)
	local identifier = GetIdentifier(source)
	local dob = MySQL.Sync.fetchAll('SELECT dateofbirth FROM users WHERE identifier = ?', {identifier})
	return dob and dob[1].dateofbirth or ""
end

GetFirstName = function(source)
	local identifier = GetIdentifier(source)
	local namedb = MySQL.Sync.fetchAll('SELECT firstname FROM users WHERE identifier = ?', {identifier})
    return namedb and namedb[1].firstname or ""
end

GetLastName = function(source)
	local identifier = GetIdentifier(source)
	local namedb = MySQL.Sync.fetchAll('SELECT lastname FROM users WHERE identifier = ?', {identifier})
    return namedb and namedb[1].lastname or ""
end

GetSexName = function(source)
	local identifier = GetIdentifier(source)
	local sex = MySQL.Sync.fetchAll('SELECT sex FROM users WHERE identifier = ?', {identifier})
    return sex and (sex[1] and sex[1].sex == 'm' and _U('male') or _U('female')) or ""
end

GetName = function(source)
	local identifier = GetIdentifier(source)
	local namedb = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
    local name = namedb[1].firstname or ''
    name = namedb[1].lastname and name..' '..namedb[1].lastname or ''
    return name
end

GetMoney = function(source, account)
	local account = account == 'cash' and 'money' or account
	if account == 'coin' then
		return GetCoin(GetIdentifier(source))
	else
		local xPlayer = GetPlayer(source)
		return xPlayer.getAccount(account).money
	end
end

AddMoney = function(source, account, amount)
	local account = account == 'cash' and 'money' or account
	local xPlayer = GetPlayer(source)
	xPlayer.addAccountMoney(account, amount)
end

RemoveMoney = function(source, account, amount)
	local account = account == 'cash' and 'money' or account
	if account == 'coin' then
		RemoveCoin(GetIdentifier(source), amount)
	else
		local xPlayer = GetPlayer(source)
		xPlayer.removeAccountMoney(account, amount)
	end
end

GetAccountLabel = function(source, account)
	local account = account == 'cash' and 'money' or account
	if account == 'coin' then
		return 'Coin'
	else
		local xPlayer = GetPlayer(source)
		return xPlayer.getAccount(account).label
	end
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

GetCoin = function(identifier)
	local result = MySQL.Sync.fetchAll('SELECT * FROM '..Config.SpecialCoin.tablename..' WHERE `'..Config.SpecialCoin.identifiercolumname..'` = ?', {identifier})
	return result[1] and result[1][Config.SpecialCoin.coincolumname] or 0
end

RemoveCoin = function(identifier, amount)
	MySQL.Async.execute('UPDATE '..Config.SpecialCoin.tablename..' SET '..Config.SpecialCoin.coincolumname..' = '..Config.SpecialCoin.coincolumname..' - ? WHERE `'..Config.SpecialCoin.identifiercolumname..'` = ?', {amount, identifier})
end

GetJobName = function(source)
	local xPlayer = GetPlayer(source)
    return xPlayer and xPlayer.job and xPlayer.job.name
end

GetJobGrade = function(source)
	local xPlayer = GetPlayer(source)
    return xPlayer and xPlayer.job and xPlayer.job.grade
end

GetGangName = function(source)
    if GetResourceState('ak47_gangs') ~= 'missing' then
        local gang = exports['ak47_gangs']:GetPlayerGang(source)
        return gang and gang.tag
    end
    return nil
end

GetGangRank = function(source)
    if GetResourceState('ak47_gangs') ~= 'missing' then
        local gang = exports['ak47_gangs']:GetPlayerGang(source)
        return gang and gang.rankid
    end
    return nil
end

HasLicense = function(source, item, class)
	local items = GetInventory(source)
	local identifier = GetIdentifier(source)

	if GetResourceState('ak47_inventory') == 'started' then
		items = exports['ak47_inventory']:GetInventoryItems(source)
	elseif Config.Inventory == 'qs-inventory' then
		items = exports['qs-inventory']:GetInventory(source)
	elseif Config.Inventory == 'codem-inventory' then
		items = exports['codem-inventory']:GetInventory(GetIdentifier(source), source)
	elseif Config.Inventory == 'tgiann-inventory' then
		items = exports['tgiann-inventory']:GetPlayerItems(source)
	end

	for i, v in pairs(items) do
		if v and v.name and v.name == item then
			local meta = v.metadata or v.info
			if meta and meta.identifier == identifier then
				if class then
					if meta.licenseclass == class then
						return true
					end
					goto nextsearch
				end
				return true
			end
			::nextsearch::
		end
	end
	return false
end
exports('HasLicense', HasLicense)

GetLicenseLabel = function(item)
    return Config.Cards[item] and Config.Cards[item].label
end
exports('GetLicenseLabel', GetLicenseLabel)

lib.callback.register('ak47_idcardv2:haslicense', function(source, item, class)
	return HasLicense(source, item, class)
end)

AddItem = function(source, item, amount, slot, info)
	if Config.Inventory == 'ak47_inventory' then
		exports['ak47_inventory']:AddItem(source, item, 1, slot, info)
	elseif Config.Inventory == 'ox_inventory' then
		exports['ox_inventory']:AddItem(source, item, 1, info)
	elseif Config.Inventory == 'qs-inventory' then
		exports['qs-inventory']:AddItem(source, item, 1, slot, info)
	elseif Config.Inventory == 'codem-inventory' then
		exports['codem-inventory']:AddItem(source, item, 1, slot, info)
	elseif Config.Inventory == 'origen_inventory' then
		exports['origen_inventory']:AddItem(source, item, 1, slot, info)
	elseif Config.Inventory == 'tgiann-inventory' then
		exports['tgiann-inventory']:AddItem(source, item, 1, slot, info)
	end
end

GetPlayerMeta = function(source, key)
	local xPlayer = GetPlayer(source)
	return xPlayer.getMeta(key)
end

SetPlayerMeta = function(source, key, value)
	local xPlayer = GetPlayer(source)
	xPlayer.setMeta(key, value)
end

CreateUsable = ESX.RegisterUsableItem

ESX.RegisterCommand('giveid', {'user', 'tmod', 'mod', 'admin', 'manager', 'owner'}, function(xPlayer, args)
	print(xPlayer.source, xPlayer.job.name)
	if IsAdmin(xPlayer.source) or Config.GiveIdCommandAccessByJob[xPlayer.job.name] then
		if args.playerId then
			print('IsAdmin', IsAdmin(xPlayer.source))
			print('GetJobName', GetJobName(xPlayer.source))
			print('GetJobGrade', GetJobGrade(xPlayer.source))
			if IsAdmin(xPlayer.source) then
				TriggerClientEvent('ak47_idcardv2:opengivemenu', xPlayer.source, args.playerId.source, true)
			elseif GetJobName(xPlayer.source) and Config.GiveIdCommandAccessByJob[GetJobName(xPlayer.source)] and GetJobGrade(xPlayer.source) >= Config.GiveIdCommandAccessByJob[GetJobName(xPlayer.source)].minimumrank then
				TriggerClientEvent('ak47_idcardv2:opengivemenu', xPlayer.source, args.playerId.source)
			else
				TriggerClientEvent('ak47_idcardv2:notify', xPlayer.source, _U('notaccess'), 'error')
			end
		else
			TriggerClientEvent('ak47_idcardv2:notify', xPlayer.source, _U('notonline'), 'error')
		end
	else
		TriggerClientEvent('ak47_idcardv2:notify', xPlayer.source, _U('notaccess'), 'error')
	end
end, true, {help = _U('giveid'), validate = true, arguments = {
		{ name = 'playerId', help = _U('playerid'), type = 'player' }
	}
})