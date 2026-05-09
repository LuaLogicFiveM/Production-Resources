local config = require 'config'
local logs = require 'logs'
local vehicles, vehicles_owned = {}, {}

local function InitCache()
	vehicles = {}
	vehicles_owned = {}
	local start = os.time()

	local response = MySQL.prepare.await('SELECT `identifier`, `data` FROM `lualogic_trust`')

	if response then
		if #response ~= 0 then
			for _, profile in ipairs(response) do
				local decoded_data = json.decode(profile.data)

				for vehicle, owner in pairs(decoded_data) do
					local hash = joaat(vehicle)

					if owner and not vehicles_owned[hash] then
						vehicles_owned[hash] = true
					end

					decoded_data[vehicle] = owner
					decoded_data[_] = nil
				end

				vehicles[profile.identifier] = decoded_data
			end
		else
			local decoded_data = json.decode(response.data)

			for vehicle, owner in pairs(decoded_data) do
				local hash = joaat(vehicle)

				if owner and not vehicles_owned[hash] then
					vehicles_owned[hash] = true
				end

				decoded_data[vehicle] = owner
			end

			vehicles[response.identifier] = decoded_data
		end
	end

	local endTime = os.time()
	local totalTime = endTime - start
	lib.print.info('[InitCache] - Cache Initiated, Benchmark Ended '..totalTime.. ' seconds')
end

local function SaveCache()
	local start = os.time()

	for identifier, data in pairs(vehicles) do
		MySQL.update('UPDATE lualogic_trust SET data = ? WHERE identifier = ?', { json.encode(data), identifier })
	end

	local ending = os.time()
	local total = ending - start
	lib.print.info('[SaveCache] - Cache Saved, Benchmark Ended '..total.. ' seconds')
end

RegisterCommand('savecache', SaveCache, true)

local function IsVehicleOwnedHash(model)
	return vehicles_owned[model] or false
end

local function HasVehicle(source, model)
	local vehicle = model
	local identifier = GetIdentifier(source)
	local player_vehicles = vehicles[identifier] or {}

	if GetTableSize(player_vehicles) == 0 then return false end

    for spawncode, _ in pairs(player_vehicles) do
		if joaat(spawncode) == vehicle then
			return true
		end
    end

	return false
end

local function CheckVehicleHash(source, vehicle)
	local player = tonumber(source)
	local vehicleEntity = vehicle

	if not DoesEntityExist(vehicleEntity) then
		return
	end

	local vehicleModel = GetEntityModel(vehicleEntity)

	if not IsVehicleOwnedHash(vehicleModel) then
		return
	end

	SetTimeout(1500, function()
		if not DoesEntityExist(vehicleEntity) then
			return
		end

		if HasVehicle(player, vehicleModel) then
			return
		end

		Wait(1500)

		---@diagnostic disable-next-line: param-type-mismatch
		local playerPed = GetPlayerPed(player)

		if not DoesEntityExist(vehicleEntity) or not DoesEntityExist(playerPed) then
			return
		end

		TaskLeaveVehicle(playerPed, vehicleEntity, 0)
		Notify(player, 'You do not have access to drive this personal vehicle.', 'error')
	end)
end

local function IsVehicleOwned(source, vehicle)
	local src = tonumber(source)
	local veh = string.upper(vehicle)
	local identifier = GetIdentifier(src)
	local profile = vehicles[identifier] or {}

	return profile[veh] or false
end

local function IsVehicleTrusted(source, vehicle)
	local src = tonumber(source)
	local veh = string.upper(vehicle)
	local identifier = GetIdentifier(src)
	local profile = vehicles[identifier] or {}

	return profile[veh] == false or false
end

local function IsVehicleValid(source, vehicle)
	local validVehicle = lib.callback.await('lualogic_trust:client:loaded', source, vehicle)
	return validVehicle
end

local function getTrustedVehicles(source)
	local src = source
	local identifier = GetIdentifier(src)
	local identifierProfile = vehicles[identifier] or {}
	local result = {}

	for vehicle, owner in pairs(identifierProfile) do
		if not owner then
			result[#result+1] = vehicle
		end
	end

	return GetTableSize(result) ~= 0 and result or false
end

lib.callback.register('lualogic_trust:server:requestTrusted', function(source)
	return getTrustedVehicles(source)
end)

local limitConfig = config.modules.owner.set.limits

local function HasVehicleSlots(source, data)
	if not limitConfig.enabled then return true end

	local src = tonumber(source)
	local limit = config.modules.owner.set.limits.count
	local playerRoles = GetDiscordRoles(src)

	if playerRoles then
		for limitCount, discordRole in ipairs(limitConfig.whitelist) do
			if playerRoles[discordRole] then
				limit = limitCount
			end
		end
	end

	return limit > #data, limit
end

lib.callback.register('lualogic_trust:server:requestOwned', function(source)
	local src = source
	local identifier = GetIdentifier(src)
	local identifierProfile = vehicles[identifier] or {}
	local result = {}

	for vehicle, owner in pairs(identifierProfile) do
		if owner then
			result[#result+1] = vehicle
		end
	end

	local hasSlots, limit = HasVehicleSlots(src, identifierProfile)

	return #result ~= 0 and result or false, config.modules.owner.set.limits.enabled and limit or ''
end)

function RemoveOwner(source, target, vehicle, admin)
	local src = tonumber(source)

	if not GlobalState.owner_remove then
		Notify(src, 'The remove owner global state is disabled', 'error')
		return
	end

	local tgt = tonumber(target)
	local identifier = GetIdentifier(tgt)
	local veh = string.upper(vehicle)

	if not identifier then
		lib.print.error('identifier not found for player: ', tgt)
		return
	end

	if tgt ~= src and not admin then
		Notify(src, 'You are unable to remove trust from another player', 'error')
		return
	end

	if not admin and not IsVehicleOwned(tgt, veh) then
		Notify(src, 'The player does not have ownership of the vehicle', 'error')
		return
	end

	local player_vehicles = vehicles[identifier] or {}
	local hash = joaat(veh)

	player_vehicles[veh] = nil
	vehicles_owned[hash] = nil
	vehicles[identifier] = player_vehicles

	local targetName = GetPlayerName(tgt)

	if admin and tgt ~= src then
		Notify(src, ('You have removed ownership of %s from %s'):format(veh, targetName), 'success')
	end

	Notify(tgt, ('You have removed ownership of %s'):format(veh), 'success')
	DiscordLog('Owner Removed', '**[Source Name]:** '..GetPlayerName(src)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..GetPlayerName(tgt)..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Target Vehicle]:** '..veh, logs.owner_remove)
end

function RemoveTrust(source, target, vehicle)
	local src = tonumber(source)

	if not GlobalState.trust_remove then
		Notify(src, 'The remove trust global state is disabled', 'error')
		return
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if not IsPlayerActive(tgt) then
		Notify(src, 'The id you provided is not online', 'error')
		return
	end

	if src ~= tgt and not IsVehicleOwned(src, veh) then
		Notify(src, 'You do not have ownership of this vehicle', 'error')
		return
	end

	if not IsVehicleTrusted(tgt, veh) then
		Notify(src, 'The target does not have trust to this vehicle', 'error')
		return
	end

	local identifier = GetIdentifier(tgt)

	if not identifier then
		lib.print.error('identifier not found for player: ', tgt)
		return
	end

	local player_vehicles = vehicles[identifier] or {}

	if player_vehicles[veh] == false then
		player_vehicles[veh] = nil
	end

	vehicles[identifier] = player_vehicles

	Notify(src, 'You have removed trust from '..veh, 'success')
	Notify(tgt, 'Trust of the vehicle '..veh..' has been removed from you', 'success')
	DiscordLog('Trust Removed', '**[Source Name]:** '..GetPlayerName(src)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..GetPlayerName(tgt)..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.trust_remove)
end

function GiveTrust(source, target, vehicle)
	local src = tonumber(source)

	if not GlobalState.trust_give then
		Notify(src, 'The give trust global state is disabled', 'error')
		return
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if src == tgt then
		Notify(src, 'You are unable to give yourself trust', 'error')
		return
	end

	if not IsPlayerActive(tgt) then
		Notify(src, 'The id you provided is not online', 'error')
		return
	end

	local identifier = GetIdentifier(tgt)

	if not identifier then
		lib.print.error('[GiveTrust] - [GetIdentifier] - Internal error 1: ', identifier)
		Notify(src, '[GiveTrust] - Internal error 1, please contact support if you encounter this error.', 'error')
		return
	end

	if not IsVehicleValid(src, veh) then
		Notify(src, 'The spawn code you provided is invalid', 'error')
		return
	end

	if not IsVehicleOwned(src, veh) then
		Notify(src, 'You do not have ownership of this vehicle', 'error')
		return
	end

	local target_vehicles = vehicles[identifier] or {}
	local PlayerName = GetPlayerName(src)
	local TargetName = GetPlayerName(tgt)

	if GetTableSize(target_vehicles) == 0 then
		target_vehicles = {}
		target_vehicles[veh] = false
		vehicles[identifier] = target_vehicles
		MySQL.insert('INSERT INTO `lualogic_trust` (identifier, data) VALUES (?, ?)', { identifier, json.encode(target_vehicles) }, false)
		Notify(src, 'You have given '..TargetName..' trust to '..veh, 'success')
		Notify(tgt, 'You have received trust for '..veh..' from from '..PlayerName, 'success')
		DiscordLog('Trust Added', '**[Source Name]:** '..PlayerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..GetPlayerName(tgt)..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.trust_give)
		return
	end

	if IsVehicleTrusted(tgt, veh) then
		Notify(src, 'This player already has trust to this vehicle', 'error')
		return
	end

	target_vehicles[veh] = false
	vehicles[identifier] = target_vehicles

	Notify(src, 'You have given id '..tgt..' trust to '..veh, 'success')
	Notify(tgt, 'You have received trust for '..veh..' from id '..src, 'success')
	DiscordLog('Trust Added', '**[Source Name]:** '..PlayerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..GetPlayerName(tgt)..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.trust_give)
end

function SetOwner(source, target, vehicle)
	local src = tonumber(source)

	if not GlobalState.owner_set then
		Notify(src, 'The set owner global state is disabled', 'error')
		return
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if not IsPlayerActive(tgt) then
		Notify(src, 'The player id you provided is not online', 'error')
		return
	end

	if not IsVehicleValid(tgt, veh) then
		Notify(src, 'The vehicle provided is not in the server', 'error')
		return
	end

	local vehicleHash = joaat(veh)

	if vehicles_owned[vehicleHash] then
		Notify(src, 'This vehicle is already owned', 'error')
		return
	end

	local identifier = GetIdentifier(tgt)

	if not identifier then
		lib.print.error('identifier not found for player: ', tgt)
		return
	end

	local player_vehicles = vehicles[identifier] or {}
	local playerName = src ~= 0 and GetPlayerName(src) or 'Console'
	local targetName = GetPlayerName(tgt)

	if GetTableSize(player_vehicles) == 0 then
		player_vehicles = {}
		vehicles_owned[vehicleHash] = true
		player_vehicles[veh] = true
		vehicles[identifier] = player_vehicles
		MySQL.insert('INSERT INTO `lualogic_trust` (identifier, data) VALUES (?, ?)', { identifier, json.encode(player_vehicles) }, false)
		Notify(src, 'You have set the owner of vehicle '..veh..' to player '..targetName, 'success')
		Notify(tgt, 'You have received owner of vehicle '..veh..' by player '..playerName, 'success')
		DiscordLog('Ownership Set', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src) or 'Console'..'>\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.owner_set)
		return
	end

	if IsVehicleOwned(tgt, veh) then
		Notify(src, 'This player already has ownership to this vehicle', 'error')
		return
	end

	if IsVehicleTrusted(tgt, veh) then
		Notify(src, 'This player has trust to this vehicle', 'error')
		return
	end

	if config.modules.owner.set.limits.enabled and not HasVehicleSlots(tgt, player_vehicles) then
		Notify(src, 'This player doesn\'t have any owned vehicle slots', 'error')
		return
	end

	vehicles_owned[vehicleHash] = true
	player_vehicles[veh] = true
	vehicles[identifier] = player_vehicles
	Notify(src, 'You have set the owner of vehicle '..veh..' to player '..targetName, 'success')
	Notify(tgt, 'You have received owner of vehicle '..veh..' by player '..playerName, 'success')
	DiscordLog('Ownership Set', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.owner_set)
end

function SetTrust(source, target, vehicle)
	local src = tonumber(source)

	if not GlobalState.trust_set then
		Notify(src, 'The set trust global state is disabled', 'error')
		return
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if not IsPlayerActive(tgt) then
		Notify(src, 'The player id you provided is not online', 'error')
		return
	end

	if not IsVehicleValid(tgt, veh) then
		Notify(src, 'The vehicle provided is not in the server', 'error')
		return
	end

	local identifier = GetIdentifier(tgt)

	if not identifier then
		lib.print.error('[GiveTrust] - [GetIdentifier] - Internal error 1: ', identifier)
		Notify(src, '[GiveTrust] - Internal error 1, please contact support if you encounter this error.', 'error')
		return
	end

	local player_vehicles = vehicles[identifier] or {}
	local playerName = src ~= 0 and GetPlayerName(src) or 'Console'
	local targetName = GetPlayerName(tgt)

	if GetTableSize(player_vehicles) == 0 then
		player_vehicles[veh] = false
		vehicles[identifier] = player_vehicles
		MySQL.insert('INSERT INTO `lualogic_trust` (identifier, data) VALUES (?, ?)', { identifier, json.encode(player_vehicles) }, false)
		Notify(src, 'You have set the trust of vehicle '..veh..' to player '..targetName, 'success')
		Notify(tgt, 'You have received trust of vehicle '..veh..' by player '..playerName, 'success')
		DiscordLog('Trust Set', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src) or 'Console'..'>\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.trust_set)
		return
	end

	if IsVehicleOwned(tgt, veh) then
		Notify(src, 'This player has ownership to this vehicle', 'error')
		return
	end

	if IsVehicleTrusted(tgt, veh) then
		Notify(src, 'This player already has trust to this vehicle', 'error')
		return
	end

	player_vehicles[veh] = false
	vehicles[identifier] = player_vehicles
	Notify(src, 'You have set the trust of vehicle '..veh..' to player '..targetName, 'success')
	Notify(tgt, 'You have received trust of vehicle '..veh..' by player '..playerName, 'success')
	DiscordLog('Trust Set', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.trust_set)
end

if config.modules.owner.clear.enabled then
	function ClearOwner(source, vehicle)
		local src = tonumber(source)
		local veh = string.upper(vehicle)

		if src ~= 0 and not GlobalState.owner_clear then
			Notify(src, 'The clear owner global state is disabled', 'error')
			return
		end

		local model = joaat(veh)

		if vehicles_owned[model] then
			vehicles_owned[model] = nil
		else
			Notify(src, 'This vehicle is not owned', 'error')
			return
		end

		local result = {}
		for identifier, profile in pairs(vehicles) do
			if profile[veh] == true then
				profile[veh] = nil
			end
			result[identifier] = profile
			vehicles[identifier] = profile
		end

		if src ~= 0 then
			local data = json.encode(result)
			local playerName = GetPlayerName(src)
			local playerIdentifiers = '<@'..GetDiscordIdentifier(src)..'>'
			Notify(src, 'You have cleared the ownership of '..veh, 'success')
			DiscordLog('Ownership Cleared', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** '..playerIdentifiers..'\n **[Target Vehicle]:** '..veh..'\n **[Data Removed]:** '..data, logs.owner_clear)
		else
			print('[TRUST SYSTEM] - [OWNER CLEAR] - You have cleared the ownership of '..veh)
		end
	end
end

if config.modules.trust.clear.enabled then
	function ClearTrust(source, vehicle)
		local src = tonumber(source)

		if not GlobalState.trust_clear then
			return Notify(src, 'The clear trust global state is disabled', 'error')
		end

		local veh = string.upper(vehicle)
		local result = {}

		for identifier, profile in pairs(vehicles) do
			if profile[veh] == false then
				profile[veh] = nil
			end
			result[identifier] = profile
			vehicles[identifier] = profile
		end

		if GetTableSize(result) == 0 then
			Notify(src, 'There is no trust on this vehicle', 'error')
			return
		end

		local data = json.encode(result, {indent=true})
		local playerName = (src ~= 0  and GetPlayerName(src) or 'Console')
		local playerIdentifiers = (src ~= 0  and '<@'..GetDiscordIdentifier(src)..'>' or 'Console')

		Notify(src, 'You have cleared the trust to '..veh, 'success')
		DiscordLog('Trust Cleared', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** '..playerIdentifiers..'\n **[Target Vehicle]:** '..veh..'\n **[Data Removed]:** '..data, logs.trust_clear)
	end
end

if config.transfer.enabled then
	local function IsTransferred(identifier)
		local row = MySQL.prepare.await('SELECT `transferred` FROM `lualogic_trust` WHERE `identifier` = ? LIMIT 1', { identifier })
		return row or false
	end

	lib.callback.register('lualogic_trust:server:checkTransfer', function(source)
		local src = tonumber(source)

		if not IsPlayerActive(src) then
			Notify(src, 'This player is not in the server', 'error')
			return false
		end

		local identifier = GetIdentifier(src)
		return IsTransferred(identifier) == 'true'
	end)

	local function GetSteamHex(source)
		local src = tonumber(source)
		local identifier = GetPlayerIdentifierByType(src, 'steam')

		if not identifier then
			Notify(src, 'Your Steam is not open, please open the application to continue.', 'error')
			return false
		end

		return identifier
	end

	local function TransferData(source)
		local src = tonumber(source)
		local identifier = GetIdentifier(src)

		if not identifier then
			return
		end

		if IsTransferred(identifier) == 'true' then
			Notify(src, 'Your data was already transferred', 'error')
			return
		end

		local al = LoadResourceFile(GetCurrentResourceName(), 'convert/whitelist.json')
		local cfg = json.decode(al)
		local result = {}
		local found = false
		local steamhex = GetSteamHex(src)

		for index, _ in pairs(cfg) do
			if not found and steamhex == index then
				found = true
				for _, veh in ipairs(cfg[index]) do
					local spawncode = string.upper(veh.spawncode)
					result[spawncode] = veh.owner
					if veh.owner then
						local hash = joaat(spawncode)
						vehicles_owned[hash] = true
					end
				end
			end
		end

		vehicles[identifier] = result
		Notify(src, 'You have transferred all of your data', 'success')
		DiscordLog('Data Transfered', '**[Source Name]:** '..GetPlayerName(src)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Data]:** '..json.encode(result), logs.transfer_data)
	end

	if config.transfer.command then
		RegisterCommand(config.transfer.command, function(source)
			local src = source
			local perm = config.transfer.permission

			if perm and not IsPlayerAceAllowed(src, perm) then
				Notify(src, 'You are unable to access this', 'error')
				return
			end

			TransferData(src)
		end, true)
	end
end

if config.modules.owner.trade.enabled then
	function TradeVehicle(source, target, sourcevehicle, targetvehicle, type)
		local src = tonumber(source)
		local tgt = tonumber(target)
		local playerVehicle = string.upper(sourcevehicle)
		local targetVehicle = string.upper(targetvehicle)

		if not IsPlayerActive(tgt) then
			Notify(src, 'The id you provided is invalid', 'error')
			return
		end

		if not IsPlayerActive(src) then
			Notify(tgt, 'The id you provided is invalid', 'error')
			return
		end

		if not IsVehicleValid(src, playerVehicle) then
			Notify(src, 'The vehicle you provided is not valid', 'error')
			return
		end

		if not IsVehicleValid(tgt, targetVehicle) then
			Notify(tgt, 'The vehicle you provided is not valid', 'error')
			return
		end

		local playerIdentifier = GetIdentifier(src)
		local targetIdentifier = GetIdentifier(tgt)

		if not playerIdentifier then
			lib.print.error('identifier not found for player: ', src)
			return
		end

		if not targetIdentifier then
			lib.print.error('identifier not found for player: ', tgt)
			return
		end

		local playerName = GetPlayerName(src)
		local playerData = vehicles[playerIdentifier] or {}

		local targetName = GetPlayerName(tgt)
		local targetData = vehicles[targetIdentifier] or {}

		if type == 'owner' then
			if not GlobalState.owner_trade then
				Notify(src, 'The trade owner global state is disabled', 'error')
				return
			end

			if not IsVehicleOwned(src, playerVehicle) then
				Notify(src, 'You do not have ownership of the vehicle '..playerVehicle, 'error')
				return
			end

			if not IsVehicleOwned(tgt, targetVehicle) then
				Notify(tgt, 'You do not have ownership of the vehicle '..targetVehicle, 'error')
				return
			end

			if playerData[targetVehicle] == false then
				playerData[targetVehicle] = nil
			end

			if playerData[playerVehicle] == true then
				playerData[playerVehicle] = nil
			end

			playerData[targetVehicle] = true
			vehicles[playerIdentifier] = playerData

			if targetData[playerVehicle] == false then
				targetData[playerVehicle] = nil
			end

			if targetData[targetVehicle] == true then
				targetData[targetVehicle] = nil
			end

			targetData[playerVehicle] = true
			vehicles[targetIdentifier] = targetData

			Notify(src, 'You traded ownership of '..playerVehicle..' for '..targetVehicle..' to '..targetName, 'success')
			Notify(tgt, 'You traded ownership of '..targetVehicle..' for '..playerVehicle..' to '..playerName, 'success')
			DiscordLog('Ownership Traded', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Source Vehicle]:** '..playerVehicle..'\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Target Vehicle]:** '..targetVehicle, logs.owner_trade)
		elseif type == 'trust' then
			if not GlobalState.trust_trade then
				Notify(src, 'The trade trust global state is disabled', 'error')
				return
			end

			if IsVehicleOwned(src, playerVehicle) then
				Notify(src, 'You have ownership of the vehicle '..playerVehicle, 'error')
				return
			end

			if IsVehicleOwned(src, targetVehicle) then
				Notify(src, 'You have ownership of the vehicle '..targetVehicle, 'error')
				return
			end

			if IsVehicleOwned(tgt, targetVehicle) then
				Notify(tgt, 'You have ownership of the vehicle '..targetVehicle, 'error')
				return
			end

			if IsVehicleOwned(tgt, playerVehicle) then
				Notify(tgt, 'You have ownership of the vehicle '..playerVehicle, 'error')
				return
			end

			if not IsVehicleTrusted(src, playerVehicle) then
				Notify(src, 'You do not have trust to this vehicle '..playerVehicle, 'error')
				return
			end

			if not IsVehicleTrusted(tgt, targetVehicle) then
				Notify(tgt, 'You do not have trust to this vehicle '..targetVehicle, 'error')
				return
			end

			if playerData[playerVehicle] == false then
				playerData[playerVehicle] = nil
			end

			playerData[targetVehicle] = false
			vehicles[playerIdentifier] = playerData

			if targetData[targetVehicle] == false then
				targetData[targetVehicle] = nil
			end

			targetData[playerVehicle] = false
			vehicles[targetIdentifier] = targetData

			Notify(src, 'You traded trust of '..playerVehicle..' for '..targetVehicle..' to '..targetName, 'success')
			Notify(tgt, 'You traded trust of '..targetVehicle..' for '..playerVehicle..' to '..playerName, 'success')
			DiscordLog('Trust Traded', '**[Source Name]:** '..playerName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Source Vehicle]:** '..playerVehicle..'\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Target Vehicle]:** '..targetVehicle, logs.trust_trade)
		end
	end

	RegisterNetEvent('lualogic_trust:server:requestDialog', function(target, vehicle, type)
		local tgt = tonumber(target)
		local sourceVehicle = vehicle
		local requestTargetDialog = lib.callback.await('lualogic_trust:client:requestTargetDialogSecond', tgt, sourceVehicle, type)

		if requestTargetDialog == nil then
			Notify(tgt, 'You cancelled the trade', 'error')
			return
		end

		local src = requestTargetDialog[1]

		if not IsVehicleValid(tgt, sourceVehicle) then
			Notify(tgt, 'The vehicle you provided is invalid', 'error')
			return
		end

		local targetVehicle = requestTargetDialog[2]

		if not IsVehicleValid(src, targetVehicle) then
			Notify(src, 'The vehicle you provided is invalid', 'error')
			return
		end

		if requestTargetDialog[3] then
			TradeVehicle(src, tgt, sourceVehicle, targetVehicle, type)
		else
			Notify(tgt, 'You did not agree to the trade', 'error')
			Notify(src, 'The player did not agree to the trade', 'error')
		end
	end)
end

if config.modules.owner.transfer.enabled then
    function TransferOwnership(source, target, vehicle)
        local src = tonumber(source)

        if not GlobalState.owner_transfer then
			Notify(src, 'The transfer owner global state is disabled', 'error')
            return
        end

        local tgt = tonumber(target)
        local veh = string.upper(vehicle)

        if not IsPlayerActive(tgt) then
			Notify(src, 'The player id you provided is not online', 'error')
            return
        end

        if not IsVehicleValid(tgt, veh) then
			Notify(src, 'The vehicle provided is not in the server', 'error')
            return
        end

        local targetIdentifier = GetIdentifier(tgt)

		if not targetIdentifier then
			lib.print.error('identifier not found for player: ', tgt)
			return
		end

        local target_vehicles = vehicles[targetIdentifier] or {}

		local sourceIdentifier = GetIdentifier(src)

		if not sourceIdentifier then
			lib.print.error('identifier not found for player: ', src)
			return
		end

		local player_vehicles = vehicles[sourceIdentifier] or {}

		if config.modules.owner.set.limits.enabled and not HasVehicleSlots(tgt, target_vehicles) then
			Notify(src, 'This player doesn\'t have any owned vehicle slots', 'error')
            return
        end

        local sourceName = src ~= 0 and GetPlayerName(src) or 'Console'
        local targetName = GetPlayerName(tgt)

		if player_vehicles[veh] == true then
			if GetTableSize(target_vehicles) == 0 then
				target_vehicles = {}
				player_vehicles[veh] = nil
				target_vehicles[veh] = true
				vehicles[targetIdentifier] = target_vehicles
				vehicles[sourceIdentifier] = player_vehicles
				MySQL.insert('INSERT INTO `lualogic_trust` (identifier, data) VALUES (?, ?)', { targetIdentifier, json.encode(target_vehicles) }, false)
				Notify(src, 'You have transferred the owner of vehicle '..veh..' to player '..targetName, 'success')
				Notify(tgt, 'You have received owner of vehicle '..veh..' by player '..sourceName, 'success')
				DiscordLog('Ownership Transfered', '**[Source Name]:** '..sourceName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src) or 'Console'..'>\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.owner_set)
				return
			end

			if IsVehicleOwned(tgt, veh) then
				Notify(src, 'This player already has ownership to this vehicle', 'error')
				return
			end

			if IsVehicleTrusted(tgt, veh) then
				Notify(src, 'This player has trust to this vehicle', 'error')
				return
			end

			player_vehicles[veh] = nil
			target_vehicles[veh] = true
			vehicles[targetIdentifier] = target_vehicles
			vehicles[sourceIdentifier] = player_vehicles
			Notify(src, 'You have transferred the owner of vehicle '..veh..' to player '..targetName, 'success')
			Notify(tgt, 'You have received owner of vehicle '..veh..' from player '..sourceName, 'success')
			DiscordLog('Ownership Transfered', '**[Source Name]:** '..sourceName..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..targetName..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Vehicle]:** '..veh, logs.owner_transfer)
		end
    end
end

local function SearchVehicleModel(source, vehicle)
	if source ~= 0 and not GlobalState.search_vehicle then
		Notify(source, 'The name search global state is disabled', 'error')
		return
	end

	local result = {}

	for id, search in pairs(vehicles) do
		local identifier = id
		for searchedVehicle, owned in pairs(search) do
			if searchedVehicle == vehicle then
				local data = MySQL.rawExecute.await('SELECT `name` FROM `lualogic_trust` WHERE `identifier` = ?', { identifier })[1]
				result[identifier] = {owner = owned, name = data.name or 'Name Not Logged'}
			end
		end
	end

	if source ~= 0 then
		DiscordLog('Search Vehicle', '**[Source Name]:** '..GetPlayerName(source)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(source)..'>\n **[Result]:** '..json.encode(result, {indent=true, sort_keys=true}), logs.search)
	end

	return result
end

local searchConfig = config.modules.system.search

if searchConfig.vehicle.enabled then
	if searchConfig.vehicle.command then
		RegisterCommand(searchConfig.vehicle.command, function(source, args)
			local src = tonumber(source)
			local perm = searchConfig.vehicle.permission

			if perm and not IsPlayerAceAllowed(src, perm) then
				Notify(src, 'You are unable to access this', 'error')
				return
			end

			if not args[1] then
				Notify(src, 'You must provide a vehicle name', 'error')
				return
			end

			local vehicle = string.upper(args[1])
			local search = SearchVehicleModel(src, vehicle)

			TriggerClientEvent('lualogic_trust:client:returnSearch', src, 'vehicle', search)
		end, false)

		RegisterCommand(searchConfig.vehicle.command .. '_console', function(source, args)
			local src = tonumber(source)

			if src == 0 then
				if not args[1] then
					Notify(src, 'You must provide a vehicle name', 'error')
					return
				end

				local vehicle = string.upper(args[1])
				local search = SearchVehicleModel(src, vehicle)

				print('[SEARCH RESULT] - '..json.encode(search, {indent=true, sort_keys=true}))
			end
		end, true)
	end
end

local function SearchPlayerIdentifier(source, identifier)
	if source ~= 0 and not GlobalState.search_identifier then
		return Notify(source, 'The identifier search global state is disabled', 'error')
	end

	local playerIdentifier = identifier

	if string.len(playerIdentifier) < 4 then
		if not IsPlayerActive(playerIdentifier) then
			lib.print.error('[SearchPlayerIdentifier] - source was not connected: '..playerIdentifier)
			return false
		end

		local xPlayerIdentifier = GetIdentifier(playerIdentifier)

		if not xPlayerIdentifier then
			lib.print.error('[SearchPlayerIdentifier] - xPlayer unable to be found for source: '..playerIdentifier)
			return false
		end

		playerIdentifier = xPlayerIdentifier
	end

	local result = {}

	for id, profile in pairs(vehicles) do
		if id == playerIdentifier then
			result.data = profile
		end
	end

	local searchName = MySQL.rawExecute.await('SELECT `name` FROM `lualogic_trust` WHERE `identifier` = ?', { playerIdentifier })[1].name
	result.name = searchName

	if source ~= 0 then
		DiscordLog('Search Identifier', '**[Source Name]:** '..GetPlayerName(source)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(source)..'>\n **[Result]:** '..json.encode(result, {indent=true, sort_keys=true}), logs.search)
	end

	return result
end

if searchConfig.identifier.enabled then
	if searchConfig.identifier.command then
		RegisterCommand(searchConfig.identifier.command, function(source, args)
			local src = tonumber(source)
			local perm = searchConfig.identifier.permission
	
			if perm and not IsPlayerAceAllowed(src, perm) then
				Notify(src, 'You are unable to access this', 'error')
				return
			end

			if not args[1] then
				Notify(src, 'You must provide a player identifier', 'error')
				return
			end

			local identifier = args[1]
			local search = SearchPlayerIdentifier(src, identifier)

			TriggerClientEvent('lualogic_trust:client:returnSearch', src, 'identifier', search)
		end, true)

		RegisterCommand(searchConfig.identifier.command..'_console', function(source, args)
			local src = tonumber(source)

			if src == 0 then
				if not args[1] then
					Notify(src, 'You must provide a player identifier', 'error')
					return
				end

				local identifier = args[1]
				local search = SearchPlayerIdentifier(src, identifier)

				print('[SEARCH RESULT] - '..json.encode(search, {indent=true, sort_keys=true}))
			end
		end, true)
	end
end

local function SearchPlayerName(source, name)
	if source ~= 0 and not GlobalState.search_name then
		return Notify(source, 'The player name search global state is disabled', 'error')
	end

	local profile = MySQL.rawExecute.await('SELECT * FROM `lualogic_trust` WHERE `name` = ?', { name })[1]

	if not profile then
		return false
	end

	local decodedResult = json.decode(profile.data)

	if source ~= 0 then
		DiscordLog('Search Name', '**[Source Name]:** '..GetPlayerName(source)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(source)..'>\n **[Result]:** '..json.encode(decodedResult, {indent=true, sort_keys=true}), logs.search)
	end

	return decodedResult
end

if searchConfig.name.enabled then
	if searchConfig.name.command then
		RegisterCommand(searchConfig.name.command, function(source, args)
			local src = tonumber(source)
			local perm = searchConfig.name.permission

			if perm and not IsPlayerAceAllowed(src, perm) then
				Notify(src, 'You are unable to access this', 'error')
				return
			end

			if not args[1] then
				Notify(src, 'You must provide a player name', 'error')
				return
			end

			local name = args[1]
			local result = SearchPlayerName(src, name)

			TriggerClientEvent('lualogic_trust:client:returnSearch', src, 'name', result)
		end, true)

		RegisterCommand(searchConfig.name.command .. '_console', function(source, args)
			local src = tonumber(source)
			if src == 0 then
				if not args[1] then
					Notify(src, 'You must provide a player name', 'error')
					return
				end

				local name = args[1]
				local result = SearchPlayerName(src, name)

				print('[SEARCH RESULT] - '..json.encode(result, {indent=true, sort_keys=true}))
			end
		end, true)
	end
end

function PlayerClear(identifier)
	local player = identifier
	local playerProfile = vehicles[player]
	if playerProfile then
		for spawncode, owner in pairs(playerProfile) do
			if owner then
				vehicles_owned[joaat(spawncode)] = nil
			end
		end

		lib.print.info('[INFO] - Player profile cleared from identifier (' .. player .. ') by Console, data removed: ' .. json.encode(playerProfile))
		MySQL.update('DELETE FROM lualogic_trust WHERE identifier = ?', { player }, false)
		vehicles[player] = nil
	else
		lib.print.info('[INFO] - Player profile not found from identifier '..player)
	end
end

RegisterServerEvent('lualogic_trust:server:enteredVehicle', function(vehicle)
	local src = source
	local vehicleModel = vehicle

	if not vehicleModel or type(vehicleModel) ~= "number" then
		return
	end

	local vehicleNetId = NetworkGetEntityFromNetworkId(vehicleModel)

	CheckVehicleHash(src, vehicleNetId)
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	SaveCache()
	lib.print.info('[onResourceStop] - Cache Saved')
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end

	GlobalState.cache_cooldown = false
	GlobalState.admin_menu = config.modules.system.admin.enabled
	GlobalState.transfer_vehicles = config.transfer.enabled

	GlobalState.owner_set = config.modules.owner.set.enabled
	GlobalState.owner_remove = config.modules.owner.remove.enabled
	GlobalState.owner_clear = config.modules.owner.clear.enabled
	GlobalState.owner_trade = config.modules.owner.trade.enabled
	GlobalState.owner_transfer = config.modules.owner.transfer.enabled

	GlobalState.trust_set = config.modules.trust.set.enabled
	GlobalState.trust_give = config.modules.trust.give.enabled
	GlobalState.trust_remove = config.modules.trust.remove.enabled
	GlobalState.trust_clear = config.modules.trust.clear.enabled
	GlobalState.trust_trade = config.modules.trust.trade.enabled

	GlobalState.search_name = searchConfig.name.enabled
	GlobalState.search_vehicle = searchConfig.vehicle.enabled
	GlobalState.search_identifier = searchConfig.identifier.enabled

	InitCache()
end)

if config.cache.txadmin then
	AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
		if eventData.secondsRemaining == 30 then
			SaveCache()
			lib.print.info('[txAdmin:events:scheduledRestart] - Cache Saved')
		end
	end)
end

if config.cache.interval then
	lib.cron.new(config.cache.interval, SaveCache)
end

exports('IsVehicleOwnedHash', IsVehicleOwnedHash)

lib.callback.register('lualogic_trust:server:IsVehicleOwnedHash', function(source, model)
	return IsVehicleOwnedHash(model)
end)

-- lualogic_trust owned vehicles -> garage owned vehicles

local function GeneratePlate()
    local format = 'XXX ###'
    local plate = ''

    for i = 1, #format do
        local char = format:sub(i, i)

        if char == 'X' then
            plate = plate .. string.char(math.random(65, 90))
        elseif char == '#' then
            plate = plate .. tostring(math.random(0, 9))
        else
            plate = plate .. char
        end
    end

    return plate
end

local function PlateExists(plate)
    local result = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE plate = ?', { plate })
    return result ~= nil
end

local function GenerateUniquePlate()
    local plate
    local attempts = 0
    local maxAttempts = 100

    repeat
        plate = GeneratePlate()
        attempts = attempts + 1
    until not PlateExists(plate) or attempts >= maxAttempts

    if attempts >= maxAttempts then
        return nil
    end

    return plate
end

local transferred = {}

local function IsTransferredOwned(identifier)
	local row = MySQL.prepare.await('SELECT `transferred_owned` FROM `lualogic_trust` WHERE `identifier` = ? LIMIT 1', { identifier })
	return row or false
end

local function GetBoughtVehicles(identifier)
	local response = MySQL.prepare.await('SELECT `bought_trusted` FROM `lualogic_trust` WHERE `identifier` = ? LIMIT 1', { identifier })

	if not response then
		lib.print.info('Requesting purchased trusted vehicles returned nil', response)
		return
	end

	return json.decode(response)
end

lib.callback.register('lualogic_trust:server:requestBoughtVehicles', function(source)
	local identifier = GetIdentifier(source)

	return GetBoughtVehicles(identifier), getTrustedVehicles(source)
end)

RegisterNetEvent('lualogic_trust:server:purchaseTrustedVehicle', function(vehicle)
	local source = source
	local sourceIdentifier = GetIdentifier(source)

	if not sourceIdentifier then
		lib.print.error('Unable to fetch identifier for source: ', source)
		return
	end

	local sourceVehicles = vehicles[sourceIdentifier]

	if not sourceVehicles then
		Notify(source, 'You do not have any vehicles', 'error')
		return
	end

	if sourceVehicles[vehicle] == nil or sourceVehicles[vehicle] == true then
		Notify(source, 'You do not have the provided vehicle or you own the provided vehicle', 'error')
		return
	end

	local purchasedVehicles = GetBoughtVehicles(sourceIdentifier) or {}

	if purchasedVehicles[vehicle] then
		Notify(source, 'This vehicle was already purchased', 'error')
		return
	end

	if not exports.ox_inventory:RemoveItem(source, 'money', 10000) then
		Notify(source, 'You were not able to afford the vehicle', 'error')
		return
	end

	purchasedVehicles[vehicle] = true
	local properties = {plate = GenerateUniquePlate(), model = GetHashKey(vehicle)}
	MySQL.insert('INSERT INTO `owned_vehicles` (owner, plate, vehicle, type) VALUES (?, ?, ?, ?)', { GetIdentifierFramework(source), properties.plate, json.encode(properties), 'car' }, false)
	MySQL.update('UPDATE lualogic_trust SET bought_trusted = ? WHERE identifier = ?', { json.encode(purchasedVehicles), sourceIdentifier })
	Notify(source, ('You have transferred %s to your garage for $10,000'):format(vehicle), 'success')
	TriggerClientEvent('lualogic_trust:client:trustedTransferMenu', source)
end)

--[[RegisterCommand('transfer_vehicles_owned', function(source, args)
	--if source >= 1 then return end

	local targetSource = source

	if targetSource then
		if transferred[targetSource] then
			return Notify(source, 'This players vehicles are already transferred', 'error')
		end

		local identifier = GetIdentifier(targetSource)

		if IsTransferredOwned(identifier) == 'true' then
			return Notify(source, 'This players vehicles are already transferred', 'error')
		end

		local player_vehicles = identifier and vehicles[identifier] or false

		if player_vehicles then
			local queries = {}

			for vehicle, owned in pairs(player_vehicles) do
				if owned == true then
					local properties = {plate = GenerateUniquePlate(), model = GetHashKey(vehicle)}
					queries[#queries+1] = { query = 'INSERT INTO `owned_vehicles` (owner, plate, vehicle, type) VALUES (?, ?, ?, ?)', values = { GetIdentifierFramework(targetSource), properties.plate, json.encode(properties), 'car' } }
				end
			end

			MySQL.transaction(queries, function(success)
				if success then
					transferred[targetSource] = true
					MySQL.update('UPDATE lualogic_trust SET transferred_owned = ? WHERE identifier = ?', { 'true', identifier })
					Notify(source, ('You have transferred all the vehicles to the garages for %s (%i)'):format(GetPlayerName(targetSource), targetSource), 'success')
				else
					Notify(source, 'The player already has one of his owned vehicles in the garages', 'error')
				end
			end)
		else
			return Notify(source, 'Unable to fetch targets vehicles', 'error')
		end
	else
		return Notify(source, 'Invalid command usage (/transfer_vehicles_owned [id])', 'error')
	end
end, false)]]

-- MARK: Cache Updating

local function UpdateCacheRuntime(identifier, data)
	if not identifier or not data then
		lib.print.error('There was an issue reading the inputted data: ', identifier, data)
		return
	end

	if data == 'NULL' then
		vehicles[identifier] = {}
		lib.print.info('Successfully updated the cache in runtime with no data for identifier: ', identifier)
		return
	end

	local dataDecoded = json.decode(data)

	if dataDecoded then
		vehicles[identifier] = dataDecoded
	else
		lib.print.error('There was an issue decoding the inputted data: ', json.encode(data))
		return
	end

	lib.print.info('Successfully updated the cache in runtime with new data for identifier: ', identifier, json.encode(vehicles[identifier], {indent=true}))
end

RegisterCommand('updatecacheruntime', function(source, args)
	local player = source == 0 and tonumber(source) or false
	local target = args[1] and args[1] or false
	local data = args[2] and args[2] or false

	if not player or not target or not data then
		lib.print.error('There was an issue reading the inputted arguments to the command: ', player, target, data)
		return
	end

	local targetIdentifier = string.sub(target, 1, 7) == 'license' and target or GetIdentifier(target)

	lib.print.info(target, type(target), targetIdentifier, string.sub(target, 1, 4))

	if not targetIdentifier then
		lib.print.error('Unable to fetch target identifier: ', targetIdentifier)
		return
	end

	UpdateCacheRuntime(targetIdentifier, data)
end, true)

RegisterCommand('convertidentifierstolicense', function(source)
	if source ~= 0 then return end

	local response = MySQL.prepare.await('SELECT `identifier`, `data` FROM `lualogic_trust`')

	if response then
		for _, profile in ipairs(response) do
			local noCharString = profile.identifier:match("^char%d+:(.+)$")
			local licenseFormatted = ('license:%s'):format(noCharString)

			MySQL.update('UPDATE lualogic_trust SET identifier = ? WHERE identifier = ?', { licenseFormatted, profile.identifier }, function(affectedRows)
				if affectedRows == 1 then
					lib.print.info('Successfully updated identifier: ', profile.identifier)
				end
			end)
		end
	end
end, true)