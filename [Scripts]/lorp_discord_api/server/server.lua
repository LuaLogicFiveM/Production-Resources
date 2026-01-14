local AdaptiveCard = [[
{
  "type": "AdaptiveCard",
  "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
  "version": "1.2",
  "backgroundImage": {
    "url": "]] .. Config.BackgroundLink .. [[",
    "fillMode": "Cover",
    "horizontalAlignment": "Top",
    "verticalAlignment": "Center"
  },
  "body": [
    {
      "type": "Container",
      "bleed": true,
      "spacing": "None",
      "items": [
        {
          "type": "TextBlock",
          "text": "🌟 Welcome to ]] .. (Config.ServerName or GetGuildName()) .. [[ 🌟",
          "weight": "Bolder",
          "size": "ExtraLarge",
          "wrap": true,
          "horizontalAlignment": "Center",
          "color": "Light"
        },
        {
          "type": "TextBlock",
          "text": "You were not detected in our Discord, please join to be able to play!",
          "weight": "Bolder",
          "size": "Medium",
          "color": "Attention",
          "wrap": true,
          "horizontalAlignment": "Center"
        },
        {
          "type": "TextBlock",
          "text": "Join our Discord and have fun!",
          "size": "Medium",
          "wrap": true,
          "horizontalAlignment": "Center",
          "color": "Light"
        },
        {
          "type": "ColumnSet",
          "spacing": "Medium",
          "horizontalAlignment": "Center",
          "columns": [
            {
              "type": "Column",
              "width": "auto",
              "horizontalAlignment": "Center",
              "items": [
                {
                  "type": "ActionSet",
                  "actions": [
                    {
                      "type": "Action.OpenUrl",
                      "title": "💠 DISCORD 💠",
                      "url": "]] .. Config.DiscordInvite .. [[",
                      "style": "positive"
                    }
                  ]
                }
              ]
            },
            {
              "type": "Column",
              "width": "auto",
              "horizontalAlignment": "Center",
              "items": [
                {
                  "type": "ActionSet",
                  "actions": [
                    {
                      "type": "Action.OpenUrl",
                      "title": "🌐 WEBSITE 🌐",
                      "url": "]] .. Config.WebsiteLink .. [[",
                      "style": "positive"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "TextBlock",
          "text": "Powered by Leaned Out Roleplay",
          "horizontalAlignment": "Center",
          "wrap": true,
          "spacing": "Large",
          "isSubtle": true,
          "color": "Default"
        }
      ]
    }
  ]
}
]]

local errorCodes = {
    [200] = 'OK - The request was completed successfully..!',
	[204] = 'OK - No Content',
	[400] = "Error - The request was improperly formatted, or the server couldn't understand it..!",
	[401] = 'Error - The Authorization header was missing or invalid..! Your Discord Token is probably wrong or does not have correct permissions attributed to it.',
	[403] = 'Error - The Authorization token you passed did not have permission to the resource..! Your Discord Token is probably wrong or does not have correct permissions attributed to it.',
	[404] = "Error - The resource at the location specified doesn't exist.",
	[429] = 'Error - Too many requests, you hit the Discord rate limit. https://discord.com/developers/docs/topics/rate-limits',
	[502] = 'Error - Discord API may be down?...'
}

local formattedToken = 'Bot ' .. Config.BotToken
local guildId = Config.GuildID
local roleList = Config.Permissions

local loadedPlayers = {}

local Caches = {
	ServerRoles = {},
	PlayerRoles = {},
	PlayerPermissions = {},
	PermissionRoles = {},
	Avatars = {}
}

RegisterNetEvent('lorp_discord_api:playerLoaded')
AddEventHandler('lorp_discord_api:playerLoaded', function()
	local license = GetPlayerIdentifierByType(source, 'discord')
	if license and (loadedPlayers[license] == nil) then
		loadedPlayers[license] = true
	end
end)

CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/".. Config.GuildID, {})
	if guild.code == 200 then
	  	local data = json.decode(guild.data)
	  	sendDebug("Successful connection to Guild : "..data.name.." ("..data.id..")", "success")
	else
		sendDebug("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data and json.decode(guild.data) or guild.code), "error") 
	end
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    deferrals.defer()
    local src = source
    local license = GetIdentifier(src, 'license')
    local discordId = GetIdentifier(src, 'discord')
    discordId = discordId and discordId:gsub("discord:", "")

    local cardShown = false

    if discordId then
        if not RegisterPermissions(src, 'playerConnecting') then
            if not cardShown then
                cardShown = true
                deferrals.presentCard(AdaptiveCard, function(data, _)
                    if data.submitId == 'played' then
                        deferrals.done("You have been verified in the Discord.!")
                    else
                        deferrals.done("You have not been found in our Discord! Please join to play, discord.gg/lorp.")
                    end
                end)
                return
            end
        else
            if Config.EnableWhitelist then
                local userRoles = GetUserRoles(src)
                if not userRoles or not userRoles[Config.WhitelistRoleID] then
                    if not cardShown then
                        cardShown = true
                        --sendDebug("Spieler " .. GetPlayerName(src) .. " besitzt keine Whitelist-Rolle!", "warning")
                        deferrals.presentCard(AdaptiveCard, function(data, _)
                            if data.submitId == 'played' then
                                deferrals.done()
                            else
                                deferrals.done("You are not whitelisted to play this server. Please join the Discord and apply today to join! discord.gg/lorp")
                            end
                        end)
                        return
                    end
                end
            end

            TriggerEvent('vMenu:RequestPermissions', src)
        end
    else
        --sendDebug("Discord wurde nicht gefunden für Spieler " .. GetPlayerName(src), "warning")
        if not cardShown then
            cardShown = true
            deferrals.presentCard(AdaptiveCard, function(data, _)
                if data.submitId == 'played' then
                    deferrals.done()
                else
                    deferrals.done("Your Discord has not been found, please open the Windows Application and reconnect!")
                end
            end)
            return
        end
    end

    deferrals.done()
end)

--[[AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    deferrals.defer()
    local src = source
    local discordId = GetPlayerIdentifierByType(src, 'discord')
    print(src, discordId)
    if not discordId then return deferrals.done("You have not been found in our Discord! Please join to play, discord.gg/lorp.") end
    discordId = discordId and discordId:gsub("discord:", "")

    print(discordId)

    local cardShown = false

    if discordId then
        if not RegisterPermissions(src, 'playerConnecting') then
            if not cardShown then
                cardShown = true
                deferrals.presentCard(AdaptiveCard, function(data, _)
                    if data.submitId == 'played' then
                        deferrals.done("You have been verified in the Discord.!")
                    else
                        deferrals.done("You have not been found in our Discord! Please join to play, discord.gg/lorp.")
                    end
                end)
                return
            end
        else
            local userRoles = GetUserRoles(src)
            if not userRoles or not userRoles[Config.WhitelistRoleID] then
                if not cardShown then
                    cardShown = true
                    deferrals.presentCard(AdaptiveCard, function(data, _)
                        if data.submitId == 'played' then
                            deferrals.done()
                        else
                            deferrals.done("You are not whitelisted to play this server. Please join the Discord and apply today to join! discord.gg/lorp")
                        end
                    end)
                    return
                end
            end

            TriggerEvent('vMenu:RequestPermissions', src)
        end
    else
        if not cardShown then
            cardShown = true
            deferrals.presentCard(AdaptiveCard, function(data, _)
                if data.submitId == 'played' then
                    deferrals.done()
                else
                    deferrals.done("Your Discord has not been found, please open the Windows Application and reconnect!")
                end
            end)
            return
        end
    end

    deferrals.done()
end)]]

AddEventHandler('playerDropped', function (reason) 
	local src = source
    local discord = GetPlayerIdentifierByType(src, 'discord')
    if not discord then return end
	local discordId = discord:gsub("discord:", "")
	if Caches.PlayerPermissions[discordId] ~= nil then
		local list = Caches.PlayerPermissions[discordId]
		for i = 1, #list do
			local permGroup = list[i]
			ExecuteCommand('remove_principal identifier.discord:' .. discordId .. " " .. permGroup)
			if Config.UseLogs then
				print("[Discord API] - (playerDropped) Removed "  .. GetPlayerName(src) .. " from role group " .. permGroup)
			end
		end
		Caches.PlayerPermissions[discordId] = nil
	end
end)


function RegisterPermissions(src, eventLocation)
    local discord = GetPlayerIdentifierByType(src, 'discord')
    if not discord then return false end
	local discordId = discord:gsub("discord:", "")
	if discordId then
		sendDebug("Player " .. discordId .. " had their Discord identifier found...", "info")
		ClearCaches(2, discordId)
		Caches.PlayerPermissions[discordId] = nil
		local permAdd = "add_principal identifier.discord:" .. discordId .. " "
		local roleIDs = GetUserRoles(src)
		if roleIDs then
			local roleMap = ConvertUserRolesToMap(roleIDs)
			sendDebug("Player " .. discordId .. " had a valid roleIDs... Length: " .. tostring(#roleIDs), "info")
			for i = 1, #roleList do
				local roleEntry = roleList[i]
				local discordRoleId = nil

				if (Caches.PermissionRoles[roleEntry.roleid] ~= nil) then
					discordRoleId = Caches.PermissionRoles[roleEntry.roleid]
				else
					discordRoleId = FetchRoleID(roleEntry.roleid)
					if (discordRoleId ~= nil) then
						Caches.PermissionRoles[roleEntry.roleid] = discordRoleId
					end
				end

				sendDebug("Checking to add permission: " .. roleEntry.groupname .. " => Player " .. discordId .. " has role " .. tostring(discordRoleId) .. " and it was compared against " .. tostring(roleEntry.roleid), "info" )

				if roleMap[tostring(discordRoleId)] ~= nil then
					if (Config.UseLogs) then
						print("[Discord API] - (" .. eventLocation .. ") Added " .. discordId .. " to role group " .. roleEntry.groupname)
					end
					ExecuteCommand(permAdd .. roleEntry.groupname)
					Caches.PlayerPermissions[discordId] = Caches.PlayerPermissions[discordId] or {}
					table.insert(Caches.PlayerPermissions[discordId], roleEntry.groupname)
				end
			end
			return true
		else
			return false
		end
	end
	return false
end

function GetDiscordAvatar(user) 
    local discord = GetPlayerIdentifierByType(user, 'discord')
    if not discord then return nil end
    local discordId = string.gsub(discord, "discord:", "")
    local imgURL = nil

	if discordId then 
		if Caches.Avatars[discordId] == nil then 
			local endpoint = ("users/%s"):format(discordId)
			local member = DiscordRequest("GET", endpoint, {})
			if member.code == 200 then
				local data = json.decode(member.data)
				if data ~= nil and data.avatar ~= nil then 
					if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
						imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif"
					else 
						imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
					end
				end
			else 
				sendDebug("ERROR: Code 200 was not reached. DETAILS: " .. errorCodes[member.code], "error")
			end
			Caches.Avatars[discordId] = imgURL
		else
			imgURL = Caches.Avatars[discordId]
		end
	else
		sendDebug("ERROR: Discord ID was not found...", "error")
	end
    return imgURL
end

function RemoveRole(user, roleId, reason)
    local discordId = GetPlayerIdentifierByType(user, 'discord')
    if not discordId then return false end
    discordId = discordId:gsub("discord:", "")
    ClearCaches(2, discordId)

    local currentRoles = GetUserRoles(user)
    if not currentRoles or type(currentRoles) ~= "table" then return false end

    local updatedRoles = {}
    for id, _ in pairs(currentRoles) do
        if tostring(id) ~= tostring(roleId) then
            table.insert(updatedRoles, id)
        end
    end

    local endpoint = ("guilds/%s/members/%s"):format(guildId, discordId)
    local payload = json.encode({ roles = updatedRoles })
    local result = DiscordRequest("PATCH", endpoint, payload, reason or "Rolle entfernt")

    if result.code == 200 or result.code == 204 then
        if Config.CacheRoles.UserRoles and Caches.PlayerRoles[discordId] then
            Caches.PlayerRoles[discordId][roleId] = nil
            GetUserRoles(user)
        end
        return true
    else
        return false
    end
end

function AddRole(user, roleId, reason)
    local discordId = GetPlayerIdentifierByType(user, 'discord')
    if not discordId then return false end

    discordId = discordId:gsub("discord:", "")
    ClearCaches(2, discordId)

    local currentRoles = GetUserRoles(user)
    if not currentRoles or type(currentRoles) ~= "table" then return false end

    local updatedRoles = {}
    local alreadyHasRole = false

    for id, _ in pairs(currentRoles) do
        table.insert(updatedRoles, id)
        if tostring(id) == tostring(roleId) then
            alreadyHasRole = true
        end
    end

    if not alreadyHasRole then
        table.insert(updatedRoles, roleId)
    end

    local endpoint = ("guilds/%s/members/%s"):format(guildId, discordId)
    local payload = json.encode({ roles = updatedRoles })
    local result = DiscordRequest("PATCH", endpoint, payload, reason or "Rolle hinzugefügt")

    if result.code == 200 or result.code == 204 then
        if Config.CacheRoles.UserRoles then
            Caches.PlayerRoles[discordId] = Caches.PlayerRoles[discordId] or {}
            Caches.PlayerRoles[discordId][roleId] = true
            GetUserRoles(user)
        end
        return true
    else
        return false
    end
end

function GetUserRoles(user)
    if not user then return nil end

    local discord = GetPlayerIdentifierByType(user, 'discord')
    if not discord then return nil end

	local discordId = string.gsub(discord, "discord:", "")
    if not discordId then return nil end

    if Config.CacheRoles.UserRoles and Caches.PlayerRoles[discordId] then
        ClearCaches(2, discordId)
    end

    local member = DiscordRequest("GET", "guilds/" .. guildId .. "/members/" .. discordId, {})
    if member.code ~= 200 then return nil end

    local data = json.decode(member.data)
    local roles = data.roles or {}
    local tempRoleList = {}
    for _, roleId in ipairs(roles) do
        local roleName = Caches.ServerRoles[roleId]
        if not roleName then
            GetGuildRoleList()
            roleName = Caches.ServerRoles[roleId] or "Unknown"
        end

        tempRoleList[roleId] = roleName
    end

    if Config.CacheRoles.UserRoles then
        Caches.PlayerRoles[discordId] = tempRoleList
    end

    return tempRoleList
end

function GetGuildRoleList()
    if (Caches.ServerRoles == nil or next(Caches.ServerRoles) == nil) then 
        local guild = DiscordRequest("GET", "guilds/"..guildId .."/roles", {})
        if guild.code == 200 then
            local data = json.decode(guild.data)
            local roles = data
            local tempRoleList = {}
            for i = 1, #roles do
                tempRoleList[roles[i].id] = roles[i].name
            end
			Caches.ServerRoles = tempRoleList
        else
            sendDebug("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code), "error") 
            Caches.ServerRoles = nil
        end
    end
    return Caches.ServerRoles
end

function GetGuildName()
    local guild = DiscordRequest("GET", "guilds/"..guildId, {})
    if guild.code == 200 then
        local data = json.decode(guild.data)
        return data.name
    else
        sendDebug("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code), "error") 
    end
    return nil
end

function GetGuildMemberCount()
    local guild = DiscordRequest("GET", "guilds/" .. guildId .. "?with_counts=true", {})
    if guild.code == 200 then
        local data = json.decode(guild.data)
        return data.approximate_member_count
    else
        sendDebug("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code), "error") 
    end
    return nil
end

function GetGuildOnlineMemberCount()
    local guild = DiscordRequest("GET", "guilds/"..guildId.."?with_counts=true", {})
    if guild.code == 200 then
        local data = json.decode(guild.data)
        return data.approximate_presence_count
    else
        sendDebug("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code), "error") 
    end
    return nil
end

function GetDiscordName(user)
    local nameData = nil
    local discord = GetPlayerIdentifierByType(user, 'discord')
    if not discord then return nil end
	local discordId = string.gsub(GetPlayerIdentifierByType(user, 'discord'), "discord:", "")

    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then
			if data.discriminator == 0 or data.discriminator == "0" then 
				return data.username 
			end
				nameData = data.username .. "#" .. data.discriminator
			end
		else
			sendDebug("ERROR: Code 200 was not reached. DETAILS: " .. member.code, "error")
		end
    end
    return nameData
end

function ClearCaches(type, discordID)
	if type == 1 then
		Caches.ServerRoles = {}
	elseif type == 2 then
		if not discordID then
			Caches.PlayerRoles = {}
		else
			if Caches.PlayerRoles[discordID] ~= nil or Caches.PlayerRoles[discordID] ~= {} then
				Caches.PlayerRoles[discordID] = {}
			else
				sendDebug("Player has no Entry yet.. DiscordID: " .. discordID, "info")
			end
		end
	elseif type == 3 then 
		Caches.Avatars = {}
	else
		Caches = {
			ServerRoles = {},
			PlayerRoles = {},
			Avatars = {}
		}
	end
end

function GetIdentifier(source, id_type)
    if type(id_type) ~= "string" then return end
    for _, identifier in pairs(GetPlayerIdentifiers(source)) do
        if string.find(identifier, id_type) then
            return identifier
        end
    end
    return nil
end

function DiscordRequest(method, endpoint, jsondata, reason)
    local data = nil
    PerformHttpRequest("https://discord.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and jsondata or "", {["Content-Type"] = "application/json", ["Authorization"] = formattedToken, ['X-Audit-Log-Reason'] = reason})

    while data == nil do
        Wait(0)
    end

    return data
end

function FetchRoleID(labelOrId)
    if type(labelOrId) == "number" then
        return labelOrId
    elseif type(labelOrId) == "string" and tonumber(labelOrId) then
        return tonumber(labelOrId)
    elseif type(labelOrId) ~= "string" then
        return nil
    end

    for _, entry in ipairs(Config.Permissions) do
        if entry.label:lower() == labelOrId:lower() then
            return entry.roleid
        end
    end

    return nil
end

function ConvertUserRolesToMap(roleList)
    local roleMap = {}
    if not roleList then return roleMap end

    for roleId, _ in pairs(roleList) do
        roleMap[roleId] = true
    end

    return roleMap
end

function sendDebug(message, type)
    if not Config.Debug then return end
    local types = {["error"] = "^1", ["info"] = "^5", ["success"] = "^2", ["warning"] = "^3"}
	print("" .. types[type] .. "[Discord API] ^7" .. message)
end


function Notify(src, message)
	lib.notify(src, {title = 'Discord API', description = message, type = 'info', position = 'top'})
end

if Config.AllowRefreshCommand then
    local cooldown = false
	RegisterCommand('refreshdiscord', function(src, args, rawCommand)
        if not cooldown then
            cooldown = true
            Notify(src, "Your permissions have been refreshed")
            RegisterPermissions(src, 'refreshPerms')
            TriggerEvent('vMenu:RequestPermissions', src)
            SetTimeout(60000*5, function()
                cooldown = false
            end)
        else
            Notify(src, "You cannot refresh your permissions since you are on a cooldown")
        end
	end, false)
end