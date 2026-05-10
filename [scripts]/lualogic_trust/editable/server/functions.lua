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
		return print('You need to put your notification in lualogic_trust/editable/core/functions.lua') -- custom notification here
	end
end

local discordType = config.core.discord

function GetDiscordRoles(source)
	local playerRoles = exports.lorp_discord_api:GetUserRoles(source)
	return playerRoles and playerRoles or false
end

function HasPermission(source, type, permission)
	if type == 'discord' then
		if not discordType then return end

		if discordType == 'badger' then
			local playerRoles = exports.Badger_Discord_API:GetDiscordRoles(source)
			return playerRoles and permission and playerRoles[permission] or false
		elseif discordType == 'custom' then
			local playerRoles = GetDiscordRoles(source)
			return playerRoles and permission and playerRoles[permission] or false
		elseif discordType == 'none' then
			return true
		end
	elseif type == 'group' then
		if config.core.framework == 'qb' then
			return IsPlayerAceAllowed(source, permission) == 1 or false
		end

		local playerGroup = GetGroup(source)

		return playerGroup and playerGroup == permission or false
	end
end

function IsPlayerActive(source)
	return GetPlayerPing(source) ~= 0
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