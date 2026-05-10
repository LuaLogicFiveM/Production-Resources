local Config = lib.require('resource.spike_strips.shared')
local stingers = {}
local stingersCount = 0
local placing = {}
local model = `p_ld_stinger_s`
local discordWebhook = "https://discord.com/api/webhooks/"
local cachedUsers = {}
local ox_inventory = exports.ox_inventory

local function getForumUserFromId(id)
	if cachedUsers[id] then return cachedUsers[id] end

	local getPromise = promise.new()

	PerformHttpRequest("https://policy-live.fivem.net/api/getUserInfo/" .. id, function(statusCode, response, headers)
		if statusCode ~= 200 then
			getPromise:resolve()
		end

		local responseData = json.decode(response)

		getPromise:resolve({
			username = responseData.username,
			avatar = "https://forum.cfx.re/" .. responseData.avatar_template:gsub("{size}", "512")
		})
	end, "GET", "", {["Content-Type"] = "application/json"})

	local user = Citizen.Await(getPromise)

	if user then
		cachedUsers[id] = user
	end

	return user
end

local function Log(source, event, message)
	if not Config.LogSystem then
		return
	end

	if Config.LogSystem == "ox_lib" then
		lib.Logger(source, event, message)
	end

	if Config.LogSystem ~= "discord" then return end

	local cleanedUpIdentifiers = {}
	local accounts = {}
	local identifiers = GetPlayerIdentifiers(source)
	local avatar = "https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352156-stock-illustration-default-placeholder-profile-icon.jpg"
	local description = "**Message:**\n" .. message
	local accountsCount = 0

	for i = 1, #identifiers do
		local identifierTypeIndex = identifiers[i]:find(":")

		if not identifierTypeIndex then
			goto continue
		end

		local identifierType = identifiers[i]:sub(1, identifierTypeIndex - 1)
		local identifier = identifiers[i]:sub(identifierTypeIndex + 1)

		if identifierType == "steam" then
			accountsCount += 1
			accounts[accountsCount] = "- Steam: https://steamcommunity.com/profiles/" .. tonumber(identifier, 16)
		elseif identifierType == "fivem" then
			local user = getForumUserFromId(identifier)

			if user then
				avatar = user.avatar
				accountsCount += 1
				accounts[accountsCount] = "- Forum account: [" .. user.username .. "](https://forum.cfx.re/u/" .. user.username .. ")"
			end
		elseif identifierType == "discord" then
			accountsCount += 1
			accounts[accountsCount] = "- Discord: <@" .. identifier .. ">"
		end

		if identifierType ~= "ip" then
			cleanedUpIdentifiers[identifierType] = identifier
		end

		::continue::
	end

	local currentTime = os.time(os.date("!*t")) -- Get the current time in UTC
    local timestamp = os.date("%Y-%m-%dT%H:%M:%S.000Z", currentTime)

	if accountsCount > 0 then
		description = description .. "\n\n**Accounts:**\n"
		for i = 1, accountsCount do
			description = description .. accounts[i] .. "\n"
		end
	end

	description = description .. "**Identifiers:**"

	for identifierType in pairs(cleanedUpIdentifiers) do
		description = description .. "\n- **" .. identifierType .. ":** " .. cleanedUpIdentifiers[identifierType]
	end

	local embed = {
		title = event,
		description = description,
		color = 15633643,
		timestamp = timestamp,
		author = {
			name = GetPlayerName(source) .. " | " .. source,
			icon_url = avatar
		},
		footer = {
			text = "lorp_spikestrips",
			icon_url = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/3abb800c9903d7ba189328c8f520e76c96bf35ba.png"
		}
	}

	PerformHttpRequest(discordWebhook, function() end, "POST", json.encode({
		username = "Spike Strips",
		avatar_url = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/3abb800c9903d7ba189328c8f520e76c96bf35ba.png",
		embeds = {
			embed
		}
	}), {
		["Content-Type"] = "application/json"
	})
end

local function HasItem(source, item)
	local count = ox_inventory:GetItemCount(source, item) or 0

	return count > 0
end

local function RemoveItem(source, item)
	if not HasItem(source, item) then return false end

	ox_inventory:RemoveItem(source, item, 1)

	return true
end

local function AddItem(source, item)
	if not ox_inventory:CanCarryItem(source, item, 1) then return false end

	ox_inventory:AddItem(source, item, 1)

	return true
end

local function IsPolice(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if not xPlayer then return false end

	return Config.Job.Allowed[xPlayer.job.name] == true
end

local function RegisterAdminCommand(command, description, cb)
	RegisterCommand(command, function(source)
		cb(source)
	end, true)
end

local function allowedToPlace(source)
	if placing[source] then return false end

	if Config.MaxStingers and stingersCount >= Config.MaxStingers then
		TriggerClientEvent("lorp_spikestrips:notify", source, "There are already too many spike strips placed", "error")
		return false
	end

	if Config.Job.RequirePlace then
		if not IsPolice(source) then
			TriggerClientEvent("lorp_spikestrips:notify", source, "You need to be a police officer to place spike strips", "error")
			return false
		end
	end

	if Config.Item.Require then
		if not HasItem(source, Config.Item.Name) then
			TriggerClientEvent("lorp_spikestrips:notify", source, "You need a spike strip to place one", "error")
			return false
		end
	end

	if Config.Item.Require and Config.Item.Remove then
		RemoveItem(source, Config.Item.Name)
	end

	return true
end

if Config.SpawnMethod == "server" then
	lib.callback.register("lorp_spikestrips:createSpikestrip", function(source, coords)
		if not allowedToPlace(source) then
			return false
		end

		local entity = CreateObjectNoOffset(model, coords.x, coords.y, coords.z - 4.0, true, false, false)
		local netId = NetworkGetNetworkIdFromEntity(entity)

		SetEntityIgnoreRequestControlFilter(entity, true)

		placing[source] = entity

		return netId
	end)
else
	lib.callback.register("lorp_spikestrips:startPlacing", function(source)
		if not allowedToPlace(source) then return false end

		placing[source] = true

		return true
	end)
end

lib.callback.register("lorp_spikestrips:getSpikestrips", function()
	return stingers
end)

local function removeStinger(id)
	local stinger = stingers[id]

	if not stinger then return end

	if stinger.netId then
		local entity = NetworkGetEntityFromNetworkId(stinger.netId)

		if entity then
			DeleteEntity(entity)
		end
	end

	stingers[id] = nil
	stingersCount -= 1

	TriggerClientEvent("lorp_spikestrips:spikestripRemoved", -1, id)

	return true
end

RegisterNetEvent("lorp_spikestrips:placedSpikestrip", function(coords, rotation, minOffset, maxOffset, netId)
	local src = source

	if Config.SpawnMethod ~= "local" and not netId then return end

	if not placing[src] then return end

	if Config.SpawnMethod == "server" then
		SetEntityIgnoreRequestControlFilter(placing[src], false)
	end

	local id = lib.string.random(".......")

	while stingers[id] do
		id = lib.string.random(".......")
		Wait(0)
	end

	stingersCount += 1
	placing[src] = nil
	stingers[id] = {
		netId = netId,
		coords = coords,
		rotation = rotation,
		minOffset = minOffset,
		maxOffset = maxOffset,
		placer = src
	}

	TriggerClientEvent("lorp_spikestrips:spikestripAdded", -1, src, id, coords, rotation, minOffset, maxOffset, netId)

	if Config.AutoDelete then
		SetTimeout(Config.AutoDelete * 60000, function()
			removeStinger(id)
		end)
	end

	Log(src, "placedSpikestrip", "Placed a spike strip with the id "..id)
end)

RegisterNetEvent("lorp_spikestrips:removeSpikestrip", function(id, distance)
	local src = source

	if not id or not stingers[id] then return end

	if not distance and #(GetEntityCoords(GetPlayerPed(src)) - stingers[id].coords) > 5.0 then return end

	if Config.Job.RequireRemove then
		if not IsPolice(src) then return end
	end

	if not distance and Config.Item.Require and Config.Item.Remove then
		AddItem(src, Config.Item.Name)
	end

	if distance then
		Log(src, "removeSpikestrip", "Removed the spike strip "..id.." because the player went too far away")
	else
		Log(src, "removeSpikestrip", "Picked up the spike strip "..id)
	end

	removeStinger(id)
end)

CreateThread(function()
	if not Config.Item.Usable then return end

	CreateUsableItem(Config.Item.Name, function(source)
		TriggerClientEvent("lorp_spikestrips:placeSpikestrip", source)
	end)
end)

if Config.ClearCommand then
	RegisterAdminCommand(Config.ClearCommand, "Clear all spike strips", function(source)
		Wait(0) -- print on server console, not f8

		for id, _ in pairs(stingers) do
			removeStinger(id)
		end

		Log(source, "clearspikestrips", "Cleared all spike strips")
	end)
end

CreateThread(function()
	if Config.SpawnMethod ~= "server" then return end

	while true do
		Wait(1000)

		for id, stinger in pairs(stingers) do
			local netId = stinger?.netId
			local coords = stinger?.coords
			local rotation = stinger?.rotation

			if not netId or not coords or not rotation then
				goto continue
			end

			local entity = NetworkGetEntityFromNetworkId(stinger.netId)

			if entity and entity ~= 0 then
				goto continue
			end

			local nwEntity = CreateObjectNoOffset(model, coords.x, coords.y, coords.z, true, false, false)
			local newNetId = NetworkGetNetworkIdFromEntity(nwEntity)

			FreezeEntityPosition(nwEntity, true)
			SetEntityRotation(nwEntity, rotation.x, rotation.y, rotation.z, 2, true)

			stinger.netId = newNetId

			TriggerClientEvent("lorp_spikestrips:updateNetId", -1, id, newNetId)

			::continue::
		end
	end
end)

AddEventHandler("playerDropped", function()
	local src = source

	if placing[src] then
		if Config.SpawnMethod == "server" then
			DeleteEntity(placing[src])
		end

		placing[src] = nil
	end

	if Config.RemoveDisconnect then
		for id, stinger in pairs(stingers) do
			if stinger.placer == src then
				removeStinger(id)
			end
		end
	end
end)

AddEventHandler("onResourceStop", function(resource)
	if resource ~= GetCurrentResourceName() then return end

	for _, stinger in pairs(stingers) do
		if stinger.netId then
			DeleteEntity(NetworkGetEntityFromNetworkId(stinger.netId))
		end
	end
end)