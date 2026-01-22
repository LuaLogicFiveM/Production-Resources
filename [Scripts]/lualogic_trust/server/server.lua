local config = require 'config'
local logs = require 'logs'
local vehicles, vehicles_owned = {}, {}

local function InitCache()
	vehicles_owned = {}
	local start = os.time()

	local response = MySQL.prepare.await('SELECT `identifier`, `data` FROM `lualogic_trust`')

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

			--[[for _, data in ipairs(decoded_data) do -- data fix (save backup, stop server, uncomment, start script, comment out, restart script)
				local hash = joaat(data.vehicle)

				if data.owner and not vehicles_owned[hash] then
					vehicles_owned[hash] = true
				end

				decoded_data[data.vehicle] = data.owner
				decoded_data[_] = nil
			end]]

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

	local endTime = os.time()
	local totalTime = endTime - start
	DebugPrint('[InitCache] - Cache Initiated, Benchmark Ended '..totalTime.. ' seconds', 'info')
end

local function SaveCache()
	local start = os.time()

	for identifier, data in pairs(vehicles) do
		MySQL.update('UPDATE lualogic_trust SET data = ? WHERE identifier = ?', { json.encode(data), identifier })
	end

	local ending = os.time()
	local total = ending - start
	DebugPrint('[SaveCache] - Cache Saved, Benchmark Ended '..total.. ' seconds', 'info')
end

RegisterCommand('savecache', SaveCache, true)

local function IsVehicleOwnedHash(model)
	return vehicles_owned[model] or false
end

local function HasVehicle(source, vehicle)
	local identifier = GetIdentifier(source)
	local player_vehicles = vehicles[identifier] or {}

	if GetTableSize(player_vehicles) == 0 then return false end

	local model = GetEntityModel(vehicle)

    for spawncode, _ in pairs(player_vehicles) do
		if joaat(spawncode) == model then
			return true
		end
    end

	return false
end

local function CheckVehicleHash(source, vehicle)
	local src = tonumber(source)
	if not DoesEntityExist(vehicle) then return end
	if not IsVehicleOwnedHash(GetEntityModel(vehicle)) then return end
	SetTimeout(1500, function()
		if not DoesEntityExist(vehicle) then return end
		if HasVehicle(src, vehicle) then return end
		Notify(src, 'You do not have access to drive this personal vehicle.', 'error')
		TaskLeaveVehicle(GetPlayerPed(src), vehicle, 0)
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
	return lib.callback.await('lualogic_trust:client:loaded', source, vehicle)
end

lib.callback.register('lualogic_trust:server:requestTrusted', function(source)
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
end)

local slotConfig = config.modules.owner.set.limits
local function HasVehicleSlots(source, data)
	if not slotConfig.enabled then return true end

	local src = tonumber(source)
	local limit = slotConfig.count
	local roles = exports.lorp_discord_api:GetUserRoles(src)

	for limitCount, acePerm in pairs(slotConfig.exempt) do
		if roles[acePerm] then
			limit = limitCount
		end
	end

	local slots = 0
	for _, owner in pairs(data) do
		if (owner == true) and not (owner == false) then
			slots = slots+1
		end
	end

	return limit > slots, limit
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

	return GetTableSize(result) ~= 0 and result or false, limit
end)

function RemoveOwner(source, target, vehicle, admin)
	local src = tonumber(source)

	if not GlobalState.owner_remove then
		return Notify(src, 'The remove owner global state is disabled', 'error')
	end

	local tgt = tonumber(target)
	local identifier = GetIdentifier(tgt)
	local veh = string.upper(vehicle)

	if tgt ~= src and not admin then
		return Notify(src, 'You are unable to remove trust from another player', 'error')
	end

	if not admin and not IsVehicleOwned(tgt, veh) then
		return Notify(src, 'The player does not have ownership of the vehicle', 'error')
	end

	local player_vehicles = vehicles[identifier] or {}
	local hash = joaat(veh)

	player_vehicles[veh] = nil
	vehicles_owned[hash] = nil
	vehicles[identifier] = player_vehicles

	local targetName = GetPlayerName(tgt)

	if admin and tgt ~= src then
		Notify(src, 'You have removed ownership of '..veh..' from '..targetName, 'success')
	end

	Notify(tgt, 'You have removed ownership of '..veh, 'success')
	DiscordLog('Owner Removed', '**[Source Name]:** '..GetPlayerName(src)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(src)..'>\n **[Target Name]:** '..GetPlayerName(tgt)..'\n **[Target Discord]:** <@'..GetDiscordIdentifier(tgt)..'>\n **[Target Vehicle]:** '..veh, logs.owner_remove)
end

function RemoveTrust(source, target, vehicle, admin)
	local src = tonumber(source)

	if not GlobalState.trust_remove then
		return Notify(src, 'The remove trust global state is disabled', 'error')
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)
	local identifier = GetIdentifier(tgt)

	if not IsPlayerActive(tgt) then
		return Notify(src, 'The id you provided is not online', 'error')
	end

	if src ~= tgt and not IsVehicleOwned(src, veh) then
		return Notify(src, 'You do not have ownership of this vehicle', 'error')
	end

	if not IsVehicleTrusted(tgt, veh) then
		return Notify(src, 'The target does not have trust to this vehicle', 'error')
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
		return Notify(src, 'The give trust global state is disabled', 'error')
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if src == tgt then
		return Notify(src, 'You are unable to give yourself trust', 'error')
	end

	if not IsPlayerActive(tgt) then
		return Notify(src, 'The id you provided is not online', 'error')
	end

	if not IsVehicleValid(src, veh) then
		return Notify(src, 'The spawn code you provided is invalid', 'error')
	end

	if not IsVehicleOwned(src, veh) then
		return Notify(src, 'You do not have ownership of this vehicle', 'error')
	end

	local identifier = GetIdentifier(tgt)
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
		return Notify(src, 'This player already has trust to this vehicle', 'error')
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
		return Notify(src, 'The set owner global state is disabled', 'error')
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if not IsPlayerActive(tgt) then
		return Notify(src, 'The player id you provided is not online', 'error')
	end

	if not IsVehicleValid(tgt, veh) then
		return Notify(src, 'The vehicle provided is not in the server', 'error')
	end

	local vehicleHash = joaat(veh)

	if vehicles_owned[vehicleHash] then
		return Notify(src, 'This vehicle is already owned', 'error')
	end

	local identifier = GetIdentifier(tgt)
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
		return Notify(src, 'This player already has ownership to this vehicle', 'error')
	end

	if IsVehicleTrusted(tgt, veh) then
		return Notify(src, 'This player has trust to this vehicle', 'error')
	end

	if not HasVehicleSlots(tgt, player_vehicles) then
		return Notify(src, 'This player doesn\'t have any owned vehicle slots', 'error')
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
		return Notify(src, 'The set trust global state is disabled', 'error')
	end

	local tgt = tonumber(target)
	local veh = string.upper(vehicle)

	if not IsPlayerActive(tgt) then
		return Notify(src, 'The player id you provided is not online', 'error')
	end

	if not IsVehicleValid(tgt, veh) then
		return Notify(src, 'The vehicle provided is not in the server', 'error')
	end

	local identifier = GetIdentifier(tgt)
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
		return Notify(src, 'This player has ownership to this vehicle', 'error')
	end

	if IsVehicleTrusted(tgt, veh) then
		return Notify(src, 'This player already has trust to this vehicle', 'error')
	end

	--table.insert(player_vehicles, {vehicle = veh, owner = false})
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
			return Notify(src, 'The clear owner global state is disabled', 'error')
		end

		local model = joaat(veh)

		if vehicles_owned[model] then
			vehicles_owned[model] = nil
		else
			return Notify(src, 'This vehicle is not owned', 'error')
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
			return Notify(src, 'There is no trust on this vehicle', 'error')
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

		if IsTransferred(identifier) == 'true' then
			return Notify(src, 'You already transferred your data', 'error')
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

	RegisterCommand(config.transfer.command, function(source)
		local src = source
		local perm = config.transfer.permission

		if perm and not IsPlayerAceAllowed(src, perm) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		TransferData(src)
	end, true)
end

if config.modules.owner.trade.enabled then
	function TradeVehicle(source, target, sourcevehicle, targetvehicle, type)
		local src = tonumber(source)
		local tgt = tonumber(target)
		local playerVehicle = string.upper(sourcevehicle)
		local targetVehicle = string.upper(targetvehicle)

		if not IsPlayerActive(tgt) then
			return Notify(src, 'The id you provided is invalid', 'error')
		end

		if not IsPlayerActive(src) then
			return Notify(tgt, 'The id you provided is invalid', 'error')
		end

		if not IsVehicleValid(src, playerVehicle) then
			return Notify(src, 'The vehicle you provided is not valid', 'error')
		end

		if not IsVehicleValid(tgt, targetVehicle) then
			return Notify(tgt, 'The vehicle you provided is not valid', 'error')
		end

		local playerIdentifier = GetIdentifier(src)
		local targetIdentifier = GetIdentifier(tgt)

		local playerName = GetPlayerName(src)
		local playerData = vehicles[playerIdentifier] or {}

		local targetName = GetPlayerName(tgt)
		local targetData = vehicles[targetIdentifier] or {}

		if type == 'owner' then
			if not GlobalState.owner_trade then
				return Notify(src, 'The trade owner global state is disabled', 'error')
			end

			if not IsVehicleOwned(src, playerVehicle) then
				return Notify(src, 'You do not have ownership of the vehicle '..playerVehicle, 'error')
			end

			if not IsVehicleOwned(tgt, targetVehicle) then
				return Notify(tgt, 'You do not have ownership of the vehicle '..targetVehicle, 'error')
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
				return Notify(src, 'The trade trust global state is disabled', 'error')
			end

			if IsVehicleOwned(src, playerVehicle) then
				return Notify(src, 'You have ownership of the vehicle '..playerVehicle, 'error')
			end

			if IsVehicleOwned(src, targetVehicle) then
				return Notify(src, 'You have ownership of the vehicle '..targetVehicle, 'error')
			end

			if IsVehicleOwned(tgt, targetVehicle) then
				return Notify(tgt, 'You have ownership of the vehicle '..targetVehicle, 'error')
			end

			if IsVehicleOwned(tgt, playerVehicle) then
				return Notify(tgt, 'You have ownership of the vehicle '..playerVehicle, 'error')
			end

			if not IsVehicleTrusted(src, playerVehicle) then
				return Notify(src, 'You do not have trust to this vehicle '..playerVehicle, 'error')
			end

			if not IsVehicleTrusted(tgt, targetVehicle) then
				return Notify(tgt, 'You do not have trust to this vehicle '..targetVehicle, 'error')
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
			return Notify(tgt, 'You cancelled the trade', 'error')
		end

		local src = requestTargetDialog[1]

		if not IsVehicleValid(tgt, sourceVehicle) then
			return Notify(tgt, 'The vehicle you provided is invalid', 'error')
		end

		local targetVehicle = requestTargetDialog[2]

		if not IsVehicleValid(src, targetVehicle) then
			return Notify(src, 'The vehicle you provided is invalid', 'error')
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
            return Notify(src, 'The transfer owner global state is disabled', 'error')
        end

        local tgt = tonumber(target)
        local veh = string.upper(vehicle)

        if not IsPlayerActive(tgt) then
            return Notify(src, 'The player id you provided is not online', 'error')
        end

        if not IsVehicleValid(tgt, veh) then
            return Notify(src, 'The vehicle provided is not in the server', 'error')
        end

        local targetIdentifier = GetIdentifier(tgt)
        local target_vehicles = vehicles[targetIdentifier] or {}

		local sourceIdentifier = GetIdentifier(src)
		local player_vehicles = vehicles[sourceIdentifier] or {}

		if not HasVehicleSlots(tgt, target_vehicles) then
            return Notify(src, 'This player doesn\'t have any owned vehicle slots', 'error')
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
				return Notify(src, 'This player already has ownership to this vehicle', 'error')
			end

			if IsVehicleTrusted(tgt, veh) then
				return Notify(src, 'This player has trust to this vehicle', 'error')
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
		return Notify(source, 'The name search global state is disabled', 'error')
	end

	local result = {}

	for id, search in pairs(vehicles) do
		local identifier = id
		for i = 1, #search do
			local profile = search[i]
			if profile.vehicle == vehicle then
				local data = MySQL.rawExecute.await('SELECT `name` FROM `lualogic_trust` WHERE `identifier` = ?', { identifier })[1]
				result[identifier][data.name] = profile.owner
			end
		end
	end

	if source ~= 0 then
		DiscordLog('Search Vehicle', '**[Source Name]:** '..GetPlayerName(source)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(source)..'>\n **[Result]:** '..json.encode(result, {indent=true, sort_keys=true}), logs.search)
	end

	return result
end

if config.modules.system.search.vehicle.enabled then
	RegisterCommand(config.modules.system.search.vehicle.command, function(source, args)
		local src = tonumber(source)
		local perm = config.modules.system.search.vehicle.permission

		if perm and not IsPlayerAceAllowed(src, perm) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not args[1] then
			return Notify(src, 'You must provide a vehicle name', 'error')
		end

		local vehicle = string.upper(args[1])
		local search = SearchVehicleModel(src, vehicle)

		TriggerClientEvent('lualogic_trust:client:returnSearch', src, 'vehicle', search)
	end, false)
end

RegisterCommand(config.modules.system.search.vehicle.command .. '_console', function(source, args)
	local src = tonumber(source)

	if src == 0 then
		if not args[1] then
			return Notify(src, 'You must provide a vehicle name', 'error')
		end

		local vehicle = string.upper(args[1])
		local search = SearchVehicleModel(src, vehicle)

		print('[SEARCH RESULT] - '..json.encode(search, {indent=true, sort_keys=true}))
	end
end, true)

local function SearchPlayerIdentifier(source, identifier)
	if source ~= 0 and not GlobalState.search_identifier then
		return Notify(source, 'The identifier search global state is disabled', 'error')
	end

	local playerIdentifier = identifier

	if string.len(playerIdentifier) < 4 then
		if not IsPlayerActive(playerIdentifier) then
			return false, DebugPrint('[SearchPlayerIdentifier] - source was not connected: '..playerIdentifier, 'error')
		end
		local xPlayerIdentifier = GetIdentifier(playerIdentifier)
		if not xPlayerIdentifier then
			return false, DebugPrint('[SearchPlayerIdentifier] - xPlayer unable to be found for source: '..playerIdentifier, 'error')
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

if config.modules.system.search.identifier.enabled then
	RegisterCommand(config.modules.system.search.identifier.command, function(source, args)
		local src = tonumber(source)
		local perm = config.modules.system.search.identifier.permission

		if perm and not IsPlayerAceAllowed(src, perm) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not args[1] then
			return Notify(src, 'You must provide a player identifier', 'error')
		end

		local identifier = args[1]
		local search = SearchPlayerIdentifier(src, identifier)

		TriggerClientEvent('lualogic_trust:client:returnSearch', src, 'identifier', search)
	end, true)
end

RegisterCommand(config.modules.system.search.identifier.command..'_console', function(source, args)
	local src = tonumber(source)
	if src == 0 then
		if not args[1] then
			return Notify(src, 'You must provide a player identifier', 'error')
		end

		local identifier = args[1]
		local search = SearchPlayerIdentifier(src, identifier)
		print('[SEARCH RESULT] - '..json.encode(search, {indent=true, sort_keys=true}))
	end
end, true)

local function SearchPlayerName(source, name)
	if source ~= 0 and not GlobalState.search_name then
		return Notify(source, 'The player name search global state is disabled', 'error')
	end

	local profile = MySQL.rawExecute.await('SELECT * FROM `lualogic_trust` WHERE `name` = ?', { name })[1]

	if not profile then return false end

	local decodedResult = json.decode(profile.data)

	if source ~= 0 then
		DiscordLog('Search Name', '**[Source Name]:** '..GetPlayerName(source)..'\n **[Source Discord]:** <@'..GetDiscordIdentifier(source)..'>\n **[Result]:** '..json.encode(decodedResult, {indent=true, sort_keys=true}), logs.search)
	end

	return decodedResult
end

if config.modules.system.search.name.enabled then
	RegisterCommand(config.modules.system.search.name.command, function(source, args)
		local src = tonumber(source)
		local perm = config.modules.system.search.name.permission

		if perm and not IsPlayerAceAllowed(src, perm) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not args[1] then
			return Notify(src, 'You must provide a player name', 'error')
		end

		local name = args[1]
		local result = SearchPlayerName(src, name)

		TriggerClientEvent('lualogic_trust:client:returnSearch', src, 'name', result)
	end, true)
end

RegisterCommand(config.modules.system.search.name.command .. '_console', function(source, args)
	local src = tonumber(source)
	if src == 0 then
		if not args[1] then
			return Notify(src, 'You must provide a player name', 'error')
		end

		local name = args[1]
		local result = SearchPlayerName(src, name)

		print('[SEARCH RESULT] - '..json.encode(result, {indent=true, sort_keys=true}))
	end
end, true)

function PlayerClear(identifier)
	local player = identifier
	local playerProfile = vehicles[player]
	if playerProfile then
		for spawncode, owner in pairs(playerProfile) do
			if owner then
				vehicles_owned[joaat(spawncode)] = nil
			end
		end

		MySQL.update('DELETE FROM lualogic_trust WHERE identifier = ?', { player }, false)
		print('[INFO] - Player profile cleared from identifier (' .. player .. ') by Console, data removed: ' .. json.encode(playerProfile))
		vehicles[player] = nil
	else
		print('[INFO] - Player profile not found from identifier '..player)
	end
end

lib.cron.new(config.cache.interval, SaveCache)

RegisterServerEvent('lualogic_trust:server:enteredVehicle', function(vehicle)
	local src = source
	if not vehicle or type(vehicle) ~= "number" then return end
	local netid = NetworkGetEntityFromNetworkId(vehicle)
	CheckVehicleHash(src, netid)
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	SaveCache()
	DebugPrint('[onResourceStop] - Cache Saved', 'info')
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end

	GlobalState.cache_cooldown = false
	GlobalState.admin_menu =config.modules.system.admin.enabled
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

	GlobalState.search_name = config.modules.system.search.name.enabled
	GlobalState.search_vehicle = config.modules.system.search.vehicle.enabled
	GlobalState.search_identifier = config.modules.system.search.identifier.enabled

	InitCache()
end)

if config.cache.txadmin then
	AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
		if eventData.secondsRemaining == 30 then
			print('30 seconds from restart')
			SaveCache()
			DebugPrint('[txAdmin:events:scheduledRestart] - Cache Saved', 'info')
		end
	end)
end

exports('IsVehicleOwnedHash', IsVehicleOwnedHash)

lib.callback.register('lualogic_trust:server:IsVehicleOwnedHash', function(source, model)
	return IsVehicleOwnedHash(model)
end)

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

RegisterCommand('transfer_vehicles_owned', function(source, args)
	if source >= 1 then return end

	local targetSource = args[1] and args[1] or false

	if targetSource then
		if transferred[targetSource] then
			return Notify(source, 'This players vehicles are already transferred', 'error')
		end

		local identifier = GetIdentifier(targetSource) or targetSource
		local player_vehicles = identifier and vehicles[identifier] or false

		if player_vehicles then
			local queries = {}

			for vehicle, owned in pairs(player_vehicles) do
				if owned == true then
					local properties = {plate = GenerateUniquePlate(), model = GetHashKey(vehicle)}
					queries[#queries+1] = { query = 'INSERT INTO `owned_vehicles` (owner, plate, vehicle, type) VALUES (?, ?, ?, ?)', values = { identifier, properties.plate, json.encode(properties), 'car' } }
				end
			end

			MySQL.transaction(queries, function(success)
				if success then
					transferred[targetSource] = true
					Notify(source, ('You have transferred all the vehicles to the garages for %s (%i)'):format(GetPlayerName(targetSource), targetSource), 'success')
					Notify(targetSource, ('Your owned vehicles have been transferred the garages by %s (%i)'):format(source ~= 0 and GetPlayerName(source) or 'Server Console', source), 'success')
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
end, false)