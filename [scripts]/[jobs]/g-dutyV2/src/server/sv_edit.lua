if SV_CONFIG.TXAdmin then
	AddEventHandler("txAdmin:events:scheduledRestart", function(eventData)
		if eventData.secondsRemaining == 60 then
			CreateThread(function()
				print("[^g-dutyV2^0]: ^3" .. LAN("restart_notice_60"))
				Wait(15000)
				print("[^g-dutyV2^0]: ^2" .. LAN("restart_notice_45"))
				Wait(20000)
				print("[^g-dutyV2^0]: ^1" .. LAN("restart_notice_25"))
				TriggerEvent("justgroot:g-dutyv2:saveAll")
				Wait(10000)
				print("[^g-dutyV2^0]: ^0" .. LAN("restart_notice_8"))
			end)
		end
	end)
else
	CreateThread(function()
		while SV_CONFIG.EnableAutoSave do
			Wait(SV_CONFIG.AutoSaveHours * 60 * 60 * 1000)
			DebugLog(LAN("duty_auto_saving"))
			TriggerEvent("justgroot:g-dutyv2:saveAll")
		end
	end)
end

-- logs
function LogToDiscord(title, description, color, webhook, footer, fields, author)
	if not webhook or webhook == "CHANGEME" then
		print(LAN("no_webhookk"))
		return
	end

	local embed = {
		{
			title = title,
			description = description,
			color = color or 16777215,
			footer = {
				text = footer or os.date("%Y-%m-%d %H:%M:%S"),
			},
			fields = fields or {},
			author = author or nil,
			timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
		},
	}

	PerformHttpRequest(
		webhook,
		function(err, text, headers)
			if err ~= 204 and err ~= 200 then
				print("Error sending webhook: " .. err)
			end
		end,
		"POST",
		json.encode({
			username = "Groot Logs",
			embeds = embed,
		}),
		{
			["Content-Type"] = "application/json",
		}
	)
end

function DutyDiscorDLog(embed, webhook, job)
	if not job then
		job = "Unknown"
	end
	if not webhook or webhook == "CHANGEME" then
		print(LAN("no_webhookk"))
		return
	end
	if not embed then
		embed = {}
	end
	PerformHttpRequest(
		webhook,
		function(err, text, headers)
			if err ~= 204 and err ~= 200 then
				print("Error sending webhook: " .. err)
			end
		end,
		"POST",
		json.encode({
			username = "DUTY SYSTEM",
			embeds = embed,
		}),
		{
			["Content-Type"] = "application/json",
		}
	)
end

function G.GetPlayerDiscordId(src)
	local identifiers = GetPlayerIdentifiers(src)
	for _, id in ipairs(identifiers) do
		if string.sub(id, 1, 8) == "discord:" then
			return string.sub(id, 9)
		end
	end
	return nil
end

AddEventHandler("onResourceStart", function(resourceName)
	if GetCurrentResourceName() ~= resourceName then
		return
	end

	local players = GetPlayers()
	for _, playerId in pairs(players) do
		playerId = tonumber(playerId)
		local xPlayer = G.GetPlayer(playerId)
		if xPlayer then
			SessionRestore(playerId)
		end
	end
end)

---
--- Reward system
---
function AddXp(source, data)
	local xPlayer = G.GetPlayer(source)
	local playerinfo = G.PlayerJobinfo(source)
	local item = data.item -- The name of the reward you want to give XP to
	local amount = tonumber(data.amount) -- The amount of XP you want to give
	if not xPlayer then
		return
	end
	----
	-- Remove the line below and implement your own XP system. Make sure to return true after successfully adding XP to the player.
	----
	local isAdded = true
	if isAdded then
		DebugLog("Added XP to " .. playerinfo.name .. " for " .. item .. " for " .. amount .. " XP")
		return true
	else
		return false
	end
end

function AddCustomReward(source, data)
	-- code here
	return true
end
