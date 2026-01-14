local config = require 'config'
local notificationType = config.core.notification

function Notify(src, msg, type)
	if src == 0 then
		return print(msg)
	end
	if notificationType == 'ox' then
		return lib.notify(src, {title = 'Vehicle System', description = msg, type = type, duration = 5000, position = 'top'})
	elseif notificationType == 'esx' then
		return TriggerClientEvent('esx:showNotification', src, msg, type, 5000)
	elseif notificationType == 'qb' then
		return TriggerClientEvent('QBCore:Notify', src, msg)
	elseif notificationType == 'qbx' then
		return print('add qbx core notify')
	elseif notificationType == 'nd' then
		return print('add nd core notify')
	elseif notificationType == 'custom' then
		return print('You need to put your notification in lualogic_trust/editable/core/server.lua') -- custom notification here
	end
end

function IsPlayerActive(source)
	return GetPlayerPing(source) ~= 0
end

function HasDiscordRole(source, role)
	local roles = exports.lorp_discord_api:GetUserRoles(source)
	return roles[role] or false
end

function DiscordLog(title, message, webhook, color)
	local embed = {{
		["color"] = color,
		["title"] = title,
		["description"] = message,
		["footer"] = {
			["text"] = GetCurrentResourceName().. ' - ' .. os.date ("%A, %m %B %Y"),
		},
    }}

  	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function GetDiscordIdentifier(source)
	local src = source
	if src == 0 then return 'N/A' end
	local discord = GetPlayerIdentifierByType(src, 'discord')
	return discord:sub(9)
end

function IsInZone(source, zones)
	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	local playerJob = GetJob(source)

	for i = 1, #zones do
		local zone = zones[i]

		if #(playerCoords - zone.coords) < zone.radius.radius then
			if not zone.jobs then
				return true
			end

			local zoneJobs = zone.jobs[playerJob.name]

			if zoneJobs and zoneJobs <= playerJob.grade then
				return true
			end
		end
	end

	return false
end

if config.modules.trust.set.enabled then
	RegisterCommand(config.modules.trust.set.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.trust.set.command..' [id] [vehicle])', 'error')
		end

		local role = config.modules.trust.set.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if config.modules.trust.set.locations.enabled and src ~= 0 and not IsInZone(src, config.modules.trust.set.locations.zones) then
			return Notify(src, 'You are not in a set trust zone.', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		SetTrust(src, tgt, vehicle)
	end, false)
end

if config.modules.trust.give.enabled then
	RegisterCommand(config.modules.trust.give.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.trust.give.command..' [id] [vehicle])', 'error')
		end

		local role = config.modules.trust.give.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if config.modules.trust.give.locations.enabled and not IsInZone(src, config.modules.trust.give.locations.zones) then
			return Notify(src, 'You are not in a give trust zone.', 'error')
		end

		local tgt = tonumber(args[1])
		local vehicle = args[2]

		GiveTrust(src, tgt, vehicle)
	end, false)
end

if config.modules.trust.remove.admin.enabled then
	RegisterCommand(config.modules.trust.remove.admin.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.trust.remove.admin.command..' [target] [vehicle])', 'error')
		end

		local role = config.modules.trust.remove.admin.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		RemoveTrust(src, tgt, vehicle, true)
	end, false)
end

if config.modules.trust.remove.enabled then
	RegisterCommand(config.modules.trust.remove.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.trust.remove.command..' [vehicle])', 'error')
		end

		local role = config.modules.trust.remove.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if config.modules.trust.remove.locations.enabled and not IsInZone(src, config.modules.trust.remove.locations.zones) then
			return Notify(src, 'You are not in a remove trust zone.', 'error')
		end

		local veh = args[1]

		RemoveTrust(src, src, veh, false)
	end, false)
end

if config.modules.trust.clear.enabled then
	RegisterCommand(config.modules.trust.clear.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.trust.clear.command..' [vehicle])', 'error')
		end

		local role = config.modules.trust.clear.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		--[[if config.modules.trust.clear.locations.enabled and not IsInZone(src, 'trust_clear') then
			return Notify(src, 'You are not in a clear trust zone.', 'error')
		end]]

		local vehicle = args[1]

		ClearTrust(src, vehicle)
	end, false)
end

if config.modules.owner.remove.enabled then
	RegisterCommand(config.modules.owner.remove.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.owner.remove.command..' [vehicle])', 'error')
		end

		local role = config.modules.owner.remove.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if config.modules.owner.remove.locations.enabled and not IsInZone(src, config.modules.owner.remove.locations.zones) then
			return Notify(src, 'You are not in a ownership remove zone.', 'error')
		end

		local vehicle = args[1]

		RemoveOwner(src, src, vehicle, false)
	end, false)
end

if config.modules.owner.transfer.enabled then
	RegisterCommand(config.modules.owner.transfer.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.owner.transfer.command..' [id] [vehicle])', 'error')
		end

		local role = config.modules.owner.transfer.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if config.modules.owner.transfer.locations.enabled and not IsInZone(src, config.modules.owner.transfer.locations.zones) then
			return Notify(src, 'You are not in a ownership transfer zone.', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		TransferOwnership(src, tgt, vehicle)
	end, false)
end

if config.modules.owner.remove.admin.enabled then
	RegisterCommand(config.modules.owner.remove.admin.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.owner.remove.admin.command..' [target] [vehicle])', 'error')
		end

		local role = config.modules.owner.remove.admin.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		RemoveOwner(src, tgt, vehicle, true)
	end, false)
end

if config.modules.owner.set.enabled then
	RegisterCommand(config.modules.owner.set.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..config.modules.owner.set.command..' [id] [vehicle])', 'error')
		end

		local role = config.modules.owner.set.permission

		if role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if config.modules.owner.set.locations.enabled and src ~= 0 and not IsInZone(src, config.modules.owner.set.locations.zones) then
			return Notify(src, 'You are not in a ownership set zone.', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		SetOwner(src, tgt, vehicle)
	end, false)
end

if config.modules.owner.clear.enabled then
	RegisterCommand(config.modules.owner.clear.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You must provide a vehicle model', 'error')
		end

		local role = config.modules.owner.clear.permission

		if src ~= 0 and role and not HasDiscordRole(src, role) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if src ~= 0 and config.modules.owner.clear.locations.enabled and not IsInZone(src, config.modules.owner.clear.locations.zones) then
			return Notify(src, 'You are not in a clear owner zone.', 'error')
		end

		local vehicle = args[1]

		ClearOwner(src, vehicle)
	end, false)
end

RegisterCommand('player_clear', function(source, args)
	local src = source

	if src ~= 0 then return end

	if not args[1] then
		return Notify(src, 'You did not use the command correctly. (/player_clear [identifier])', 'error')
	end

	local identifier = args[1]

	PlayerClear(identifier)
end, true)

if config.modules.system.admin.enabled then
	RegisterCommand(config.modules.system.admin.command_disable, function(source)
		if source ~= 0 then
			return Notify(source, 'You are not allowed to use this', 'error')
		end

		GlobalState.admin_menu = not GlobalState.admin_menu
		print('[SUCCESS] - You have changed the admin menu status to '..GlobalState.admin_menu)
	end, true)

	lib.callback.register('lualogic_trust:server:requestPermission', function(source, role)
		return HasDiscordRole(source, role)
	end)
end

if config.core.auto_sql then
	MySQL.ready(function()
		Wait(1000)
		local success, error = pcall(MySQL.scalar.await, 'SELECT 1 FROM `lualogic_trust`')
		if not success then
			MySQL.query([[
				CREATE TABLE IF NOT EXISTS `lualogic_trust` (
				`identifier` varchar(46) NOT NULL,
				`name` text DEFAULT NULL,
				`data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
				`transferred` text NOT NULL DEFAULT 'false',
				PRIMARY KEY (`identifier`)
				) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
			]])
		end
	end)
end

RegisterServerEvent('lualogic_trust:server:requestAction', function(data)
	local action = data.action
	local status = data.status
	if action == 'owner_set' then
		GlobalState.owner_set = status
	elseif action == 'owner_trade' then
		GlobalState.owner_trade = status
	elseif action == 'owner_transfer' then
		GlobalState.owner_transfer = status
	elseif action == 'owner_remove' then
		GlobalState.owner_remove = status
	elseif action == 'owner_clear' then
		GlobalState.owner_clear = status
	elseif action == 'trust_set' then
		GlobalState.trust_set = status
	elseif action == 'trust_give' then
		GlobalState.trust_give = status
	elseif action == 'trust_remove' then
		GlobalState.trust_remove = status
	elseif action == 'trust_clear' then
		GlobalState.trust_clear = status
	elseif action == 'trust_trade' then
		GlobalState.trust_trade = status
	elseif action == 'search_name' then
		GlobalState.search_name = status
	elseif action == 'search_vehicle' then
		GlobalState.search_vehicle = status
	elseif action == 'search_identifier' then
		GlobalState.search_identifier = status
	elseif action == 'admin_menu' then
		GlobalState.admin_menu = status
	elseif action == 'transfer_vehicles' then
		GlobalState.transfer_vehicles = status
	end
end)