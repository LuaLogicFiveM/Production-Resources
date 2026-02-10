local config = require 'config'

--[[
local trustSetConfig = config.modules.trust.set

if trustSetConfig.enabled then
	RegisterCommand(trustSetConfig.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..trustSetConfig.command..' [id] [vehicle])', 'error')
		end

		local permission = trustSetConfig.permission
		local permissionType = trustSetConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if src ~= 0 and zoneCheck(source, 'trust_set') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		SetTrust(src, tgt, vehicle)
	end, false)
end

local trustGiveConfig = config.modules.trust.give

if trustGiveConfig.enabled then
	RegisterCommand(trustGiveConfig.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..trustGiveConfig.command..' [id] [vehicle])', 'error')
		end

		local permission = trustGiveConfig.permission
		local permissionType = trustGiveConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not zoneCheck(src, 'trust_give') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		end

		local tgt = tonumber(args[1])
		local vehicle = args[2]

		GiveTrust(src, tgt, vehicle)
	end, false)
end

local trustRemoveConfig = config.modules.trust.remove

if trustRemoveConfig.enabled then
	RegisterCommand(trustRemoveConfig.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..trustRemoveConfig.command..' [vehicle])', 'error')
		end

		local permission = trustRemoveConfig.permission
		local permissionType = trustRemoveConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not zoneCheck(src, 'trust_remove') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		end

		local veh = args[1]

		RemoveTrust(src, src, veh, false)
	end, false)
end

if trustRemoveConfig.admin.enabled then
	RegisterCommand(trustRemoveConfig.admin.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..trustRemoveConfig.admin.command..' [target] [vehicle])', 'error')
		end

		local permission = trustRemoveConfig.admin.permission
		local permissionType = trustRemoveConfig.admin.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		RemoveTrust(src, tgt, vehicle, true)
	end, false)
end

local trustClearConfig = config.modules.trust.clear

if trustClearConfig.enabled then
	RegisterCommand(trustClearConfig.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..trustClearConfig.command..' [vehicle])', 'error')
		end

		local permission = trustClearConfig.permission
		local permissionType = trustClearConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		--if not zoneCheck(src, 'trust_clear') then
		--	return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		--end

		local vehicle = args[1]

		ClearTrust(src, vehicle)
	end, false)
end

local ownerRemoveConfig = config.modules.owner.remove

if ownerRemoveConfig.enabled then
	RegisterCommand(ownerRemoveConfig.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..ownerRemoveConfig.command..' [vehicle])', 'error')
		end

		local permission = ownerRemoveConfig.permission
		local permissionType = ownerRemoveConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not zoneCheck(src, 'owner_remove') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		end

		local vehicle = args[1]

		RemoveOwner(src, src, vehicle, false)
	end, false)
end

if ownerRemoveConfig.admin.enabled then
	RegisterCommand(ownerRemoveConfig.admin.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You did not use the command correctly. (/'..ownerRemoveConfig.admin.command..' [target] [vehicle])', 'error')
		end

		local permission = ownerRemoveConfig.admin.permission
		local permissionType = ownerRemoveConfig.admin.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		RemoveOwner(src, tgt, vehicle, true)
	end, false)
end

local ownerTransferConfig = config.modules.owner.transfer

if ownerTransferConfig.enabled then
	RegisterCommand(ownerTransferConfig.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..ownerTransferConfig.command..' [id] [vehicle])', 'error')
		end

		local permission = ownerTransferConfig.permission
		local permissionType = ownerTransferConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if not zoneCheck(src, 'owner_transfer') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		TransferOwnership(src, tgt, vehicle)
	end, false)
end

local ownerSetConfig = config.modules.owner.set

if ownerSetConfig.enabled then
	RegisterCommand(ownerSetConfig.command, function(source, args)
		local src = source

		if not args[1] or not args[2] then
			return Notify(src, 'You did not use the command correctly. (/'..ownerSetConfig.command..' [id] [vehicle])', 'error')
		end

		local permission = ownerSetConfig.permission
		local permissionType = ownerSetConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if src ~= 0 and not zoneCheck(src, 'owner_set') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
		end

		local tgt = args[1]
		local vehicle = args[2]

		SetOwner(src, tgt, vehicle)
	end, false)
end

local ownerClearConfig = config.modules.owner.clear

if ownerClearConfig.enabled then
	RegisterCommand(ownerClearConfig.command, function(source, args)
		local src = source

		if not args[1] then
			return Notify(src, 'You must provide a vehicle model', 'error')
		end

		local permission = ownerClearConfig.permission
		local permissionType = ownerClearConfig.permissionType

		if src ~= 0 and permission and permissionType and not HasPermission(src, permissionType, permission) then
			return Notify(src, 'You are unable to access this', 'error')
		end

		if src ~= 0 and not zoneCheck(src, 'owner_clear') then
			return Notify(src, 'You are not permitted to use this command in this area.', 'error')
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

local adminConfig = config.modules.system.admin

if adminConfig.enabled then
	RegisterCommand(adminConfig.command_disable, function(source)
		if source ~= 0 then
			return Notify(source, 'You are not allowed to use this', 'error')
		end

		GlobalState.admin_menu = not GlobalState.admin_menu
		print('[SUCCESS] - You have changed the admin menu status to '..GlobalState.admin_menu)
	end, true)

	lib.callback.register('lualogic_trust:server:requestPermission', function(source, type, role)
		return HasPermission(source, type, role)
	end)
end]]

function HasDiscordRole(source, role)
	local roles = exports.lorp_discord_api:GetUserRoles(source)
	return roles[role] or false
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