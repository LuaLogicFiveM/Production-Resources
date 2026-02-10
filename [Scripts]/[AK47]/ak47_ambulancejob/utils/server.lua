--[[for i, v in pairs(Config.JobNames) do
	TriggerEvent('esx_society:registerSociety', i, i, 'society_'..i, 'society_'..i, 'society_'..i, {type = 'public'})
end]]

ESX.RegisterServerCallback('ak47_ambulancejob:emscount', function(source, cb)
    --local xPlayers = ESX.GetPlayers()
    local ems = ESX.GetExtendedPlayers('job', 'ems')
    --[[for i, v in pairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer and xPlayer.job and xPlayer.job.name and Config.JobNames[xPlayer.job.name] then
            ems += 1
        end
    end]]
    cb(#ems)
end)

RegisterNetEvent('ak47_ambulancejob:CombatLogPunishment', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.CombatLogPunishment.RemoveMoney then
		xPlayer.removeMoney(xPlayer.getMoney())
		Wait(100)
	end
	if Config.CombatLogPunishment.RemoveBlackMoney then
		xPlayer.removeAccountMoney('black_money', xPlayer.getAccount('black_money').money)
		Wait(100)
	end
	if Config.CombatLogPunishment.RemoveItems then
		local xPlayer = ESX.GetPlayerFromId(source)
		local inv = xPlayer.getInventory()
		if inv then
			for i, v in pairs(inv) do
				if v.name and v.count > 0 and not Config.CombatLogPunishment.IgnoreItemList[v.name:lower()] and not string.find(v.name:lower(), 'weapon_') then
					xPlayer.removeInventoryItem(v.name, v.count)
				end
			end
		end
		Wait(100)
	end
	if Config.CombatLogPunishment.RemoveWeapons then
		local xPlayer = ESX.GetPlayerFromId(source)
		local inv = xPlayer.getInventory()
		if inv then
			for i, v in pairs(inv) do
				if v.name and v.count > 0 and not Config.CombatLogPunishment.IgnoreLoadoutList[v.name] and string.find(v.name:lower(), 'weapon_') then
					xPlayer.removeInventoryItem(v.name, v.count)
				end
			end
		end
		local loadout = xPlayer.getLoadout()
		if loadout then
			for i, v in pairs(loadout) do
				if v.name and not Config.CombatLogPunishment.IgnoreLoadoutList[v.name] then
					xPlayer.removeWeapon(v.name)
				end
			end
		end
		Wait(100)
	end
end)

RegisterNetEvent('ak47_ambulancejob:ForceRespawnPunishment', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.ForceRespawnPunishment.RemoveMoney then
		xPlayer.removeMoney(xPlayer.getMoney())
		Wait(100)
	end
	if Config.ForceRespawnPunishment.RemoveBlackMoney then
		xPlayer.removeAccountMoney('black_money', xPlayer.getAccount('black_money').money)
		Wait(100)
	end
	if Config.ForceRespawnPunishment.RemoveItems then
		local xPlayer = ESX.GetPlayerFromId(source)
		local inv = xPlayer.getInventory()
		if inv then
			for i, v in pairs(inv) do
				if v.name and v.count > 0 and not Config.ForceRespawnPunishment.IgnoreItemList[v.name:lower()] and not string.find(v.name:lower(), 'weapon_') then
					xPlayer.removeInventoryItem(v.name, v.count)
				end
			end
		end
		Wait(100)
	end
	if Config.ForceRespawnPunishment.RemoveWeapons then
		local xPlayer = ESX.GetPlayerFromId(source)
		local inv = xPlayer.getInventory()
		if inv then
			for i, v in pairs(inv) do
				if v.name and v.count > 0 and not Config.ForceRespawnPunishment.IgnoreLoadoutList[v.name] and string.find(v.name:lower(), 'weapon_') then
					xPlayer.removeInventoryItem(v.name, v.count)
				end
			end
		end
		local loadout = xPlayer.getLoadout()
		if loadout then
			for i, v in pairs(loadout) do
				if v.name and not Config.ForceRespawnPunishment.IgnoreLoadoutList[v.name] then
					xPlayer.removeWeapon(v.name)
				end
			end
		end
		Wait(100)
	end
end)

RegisterNetEvent('ak47_ambulancejob:AutoRespawnPunishment', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.AutoRespawnPunishment.RemoveMoney then
		xPlayer.removeMoney(xPlayer.getMoney())
		Wait(100)
	end
	if Config.AutoRespawnPunishment.RemoveBlackMoney then
		xPlayer.removeAccountMoney('black_money', xPlayer.getAccount('black_money').money)
		Wait(100)
	end
	if Config.AutoRespawnPunishment.RemoveItems then
		local xPlayer = ESX.GetPlayerFromId(source)
		local inv = xPlayer.inventory
		if inv then
			for i, v in pairs(inv) do
				if v.name and v.count > 0 and not Config.AutoRespawnPunishment.IgnoreItemList[v.name:lower()] and not string.find(v.name:lower(), 'weapon_') then
					xPlayer.removeInventoryItem(v.name, v.count)
				end
			end
		end
		Wait(100)
	end
	if Config.AutoRespawnPunishment.RemoveWeapons then
		local xPlayer = ESX.GetPlayerFromId(source)
		local inv = xPlayer.inventory
		if inv then
			for i, v in pairs(inv) do
				if v.name and v.count > 0 and not Config.AutoRespawnPunishment.IgnoreLoadoutList[v.name] and string.find(v.name:lower(), 'weapon_') then
					xPlayer.removeInventoryItem(v.name, v.count)
				end
			end
		end
		local loadout = xPlayer.getLoadout()
		if loadout then
			for i, v in pairs(loadout) do
				if v.name and not Config.AutoRespawnPunishment.IgnoreLoadoutList[v.name] then
					xPlayer.removeWeapon(v.name)
				end
			end
		end
		Wait(100)
	end
end)

ESX.RegisterServerCallback('ak47_ambulancejob:hasmoney', function(source, cb, total)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getAccount('bank').money
	if GetResourceState('m-Insurance') == 'started' and exports['m-Insurance']:haveHealthInsurance(xPlayer.identifier) then
		local discount = 500 --change this
		local pay = total - discount
		if money >= pay then
			xPlayer.removeAccountMoney("bank", pay > 0 and pay or 0)
			--addSocietyMoney(pay)
			cb(true)
		else
			cb(false)
		end
	else
		if money >= total then
			xPlayer.removeAccountMoney('bank', total)
			--addSocietyMoney(total)
			cb(true)
		else
			cb(false)
		end
	end
end)

RegisterNetEvent('ak47_ambulancejob:gonegativebalance', function(total)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('bank', total)
	--addSocietyMoney(total)
end)

lib.callback.register('ak47_ambulancejob:hasdocmoney', function(source, total)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getAccount('bank').money
	return money >= total
end)

lib.callback.register('ak47_ambulancejob:getdoccount', function()
    local ems = ESX.GetExtendedPlayers('job', 'ems')
	return #ems
end)

RegisterNetEvent('ak47_ambulancejob:removedocmoney', function(total)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('bank', total)
	--addSocietyMoney(total)
end)

GetItemLabel = function(item)
	return ESX.GetItemLabel(item) or item
end

function addSocietyMoney(money)
   --[[TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
      account.addMoney(money)
   end)]]
end

local function playerDiscordId(source)
    local did = GetPlayerIdentifierByType(source, 'discord')
	return did and string.gsub(did, 'discord:', '') or 'N/A'
end

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	TriggerClientEvent('ak47_ambulancejob:revive', eventData.id)
	TriggerClientEvent('ak47_ambulancejob:skellyfix', eventData.id)
	exports.lorp_packed:SendLog('__**Tx Revive Logs**__', "### Source Information \n**"..GetPlayerName(source).. " ("..source..")**\n### Target Information \n**"..GetPlayerName(eventData.id).."("..eventData.id..")**", 'https://discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
end)

ESX.RegisterServerCallback('ak47_ambulancejob:getwebhook', function(source, cb)
	cb(ScreenshotWebhook)
end)

ESX.RegisterCommand('revive', 'tmod', function(xPlayer, args, showError)
	args.playerId.triggerEvent('ak47_ambulancejob:revive')
	args.playerId.triggerEvent('ak47_ambulancejob:skellyfix')
	exports.lorp_packed:SendLog('__**Revive Command Logs**__', "### Source Information \n**"..GetPlayerName(xPlayer.source).. " ("..xPlayer.source..") ("..playerDiscordId(xPlayer.source)..")**\n### Target Information \n**"..GetPlayerName(args.playerId.source).."("..args.playerId.source..") ("..playerDiscordId(args.playerId.source)..")**", 'https://discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
end, true, {help = _U('revivecmd'), validate = true, arguments = {
	{name = 'playerId', help = _U('playerid'), type = 'player'}
}})

ESX.RegisterCommand('skellyfix', 'tmod', function(xPlayer, args, showError)
	args.playerId.triggerEvent('ak47_ambulancejob:skellyfix')
end, true, {help = _U('skellyfix'), validate = true, arguments = {
	{name = 'playerId', help = _U('playerid'), type = 'player'}
}})

ESX.RegisterCommand('heal', 'owner', function(xPlayer, args, showError)
	args.playerId.triggerEvent('ak47_ambulancejob:heal')
	args.playerId.triggerEvent('ak47_ambulancejob:skellyfix')
end, true, {help = _U('healcmd'), validate = true, arguments = {
	{name = 'playerId', help = _U('playerid'), type = 'player'}
}})

ESX.RegisterCommand('healall', 'owner', function(xPlayer, args, showError)
	TriggerClientEvent('ak47_ambulancejob:heal', -1)
	TriggerClientEvent('ak47_ambulancejob:skellyfix', -1)
end, true, {help = _U('healall'), validate = true, arguments = {}})

ESX.RegisterCommand('reviveall', 'owner', function(xPlayer, args, showError)
	TriggerClientEvent('ak47_ambulancejob:revive', -1)
	TriggerClientEvent('ak47_ambulancejob:skellyfix', -1)
end, true, {help = _U('reviveall'), validate = true, arguments = {}})

ESX.RegisterCommand('skellyfixall', 'owner', function(xPlayer, args, showError)
	TriggerClientEvent('ak47_ambulancejob:skellyfix', -1)
end, true, {help = _U('skellyfixall'), validate = true, arguments = {}})