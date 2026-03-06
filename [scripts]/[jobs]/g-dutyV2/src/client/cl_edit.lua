-----------------------------------x--Groot Development--x-----------------------------------------------
-- Editable
-- TextUI
local TextUi = Config.TextUI
function TextUiShow(message)
	if not message then
		return
	end
	if TextUi == "okok" then
		exports.okokTextUI:Open(message, "darkblue", "right")
	elseif TextUi == "ox_lib" then
		exports["ox_lib"]:showTextUI(message)
	elseif TextUi == "esx" then
		ESX.ShowHelpNotification(message)
	elseif TextUi == "qbcore" then
		exports["qb-core"]:DrawText(message, "right")
	end
end
function TextUiNewHide()
	if TextUi == "okok" then
		exports.okokTextUI:Close()
	elseif TextUi == "qbcore" then
		exports["qb-core"]:HideText()
	elseif TextUi == "ox_lib" then
		exports["ox_lib"]:hideTextUI()
	end
end
-- Notifications
local Notification = Config.Notify
Notify = function(message, type, duration)
	if not type then
		type = "success"
	end
	if not duration then
		duration = 5000
	end

	if Notification == "esx" then
		ESX.ShowNotification(message)
	elseif Notification == "okok" then
		exports.okokNotify:Alert(type, message, duration, type, false)
	elseif Notification == "qbcore" then
		if type == "info" then
			type = "primary"
		end
		QBCore.Functions.Notify(message, type, duration)
	elseif Notification == "ox_lib" then
		exports["ox_lib"]:notify({
			title = "Notification",
			description = message,
			type = type,
			duration = duration,
			position = "top-right",
		})
	elseif Notification == "17mov" then
		exports["17mov_Hud"]:ShowNotification(message, type, "Notification", duration)
	elseif Notification == "standalone" then
		AddTextEntry("g_bridge", message)
		BeginTextCommandThefeedPost("g_bridge")
		EndTextCommandThefeedPostTicker(false, true)
	elseif Notification == "g-notifications" then
		exports["g-notifications"]:Notify({
			title = "Notification",
			description = message,
			type = type,
			duration = duration,
			position = "top-right",
		})
	else
		print("Notification type not found")
	end
end

RegisterNetEvent("justgroot:g-dutyV2:notify", function(message, type, duration)
	Notify(message, type, duration)
end)

-- Do not touch if you don't know what you're doing.
-- open duty station open logic
CreateThread(function()
	for index, target in pairs(Config.DutySystem) do
		local usercoords = target.Station.duty.coords
		local bosscords = target.Station.boss.coords
		-- User
		for _, v in pairs(usercoords) do
			if Config.SystemSettings.OpenMenuVia == "target" then
				Target.AddTargetBoxZone(
					"G_" .. tostring(index) .. "_user_" .. tostring(_),
					vector3(v.x, v.y, v.z - 0.5),
					1.0, -- Size
					v.w, -- Heading
					{
						{
							name = "dutyV2user_" .. tostring(index),
							icon = Config.Icons.userTargetIcon,
							label = LAN("open_duty_station"),
							onSelect = function()
								TriggerEvent("justgroot:g-dutyV2:open:menu", index)
							end,
						},
					},
					Config.SystemSettings.Debug
				)
			elseif Config.SystemSettings.OpenMenuVia == "textui" then
				for _, value in pairs(usercoords) do
					SetupInteractionZone(
						{ value.x, value.y, value.z },
						LAN("open_duty_station"),
						"justgroot:g-dutyV2:open:menu",
						index
					)
				end
			end
		end
		--- boss
		for _, v in pairs(bosscords) do
			if Config.SystemSettings.OpenMenuVia == "target" then
				Target.AddTargetBoxZone(
					"G_" .. tostring(index) .. "_boss_" .. tostring(_),
					vector3(v.x, v.y, v.z - 0.5),
					1.0, -- Size
					v.w, -- Heading
					{
						{
							name = "dutyV2boss_" .. tostring(index),
							icon = Config.Icons.bossTargetIcon,
							label = LAN("open_boss_menu"),
							onSelect = function()
								TriggerEvent("justgroot:g-dutyV2:boss:open:menu", index)
							end,
						},
					},
					Config.SystemSettings.Debug
				)
			elseif Config.SystemSettings.OpenMenuVia == "textui" then
				for _, value in pairs(bosscords) do
					SetupInteractionZone(
						{ value.x, value.y, value.z },
						LAN("open_boss_menu"),
						"justgroot:g-dutyV2:boss:open:menu",
						index
					)
				end
			end
		end
	end
	-- leaderboard & rewards
	for index, target in pairs(Config.LeaderBoard) do
		if target == nil then
			return
		end
		if Config.EnableLeaderBoard == false and Config.EnableRewards == false then
			print(LAN("leaderboard_and_rewards_disabled"))
			return
		end

		for _, v in pairs(target.Coords) do
			local zoneId = "G_" .. tostring(index) .. "_leaderboard_rewards_" .. tostring(v.x) .. "_" .. tostring(v.y)

			if Config.SystemSettings.OpenMenuVia == "target" then
				Target.AddTargetBoxZone(
					zoneId,
					vector3(v.x, v.y, v.z - 0.5),
					1.0, -- Size
					v.w, -- Heading
					{
						{
							name = "dutyV2leaderboardandrewards_" .. tostring(index),
							icon = Config.Icons.LeaderBoardAndRewardsIcon,
							label = LAN("open_leader_rewards_menu"),
							onSelect = function()
								
								TriggerEvent("justgroot:g-dutyV2:leaderboard:rewards:open:menu", index)
							end,
						},
					},
					Config.SystemSettings.Debug
				)
			elseif Config.SystemSettings.OpenMenuVia == "textui" then
				SetupInteractionZone(
					{ v.x, v.y, v.z },
					LAN("open_leader_rewards_menu"),
					"justgroot:g-dutyV2:leaderboard:rewards:open:menu",
					index
				)
			end
		end
	end
end)

-- Creating peds & Map blips
CreateThread(function()
	-- peds
	for _, set in pairs(Config.DutySystem) do
		local dutyuser = set.Station.duty
		if not dutyuser or not dutyuser.EnablePed then
			goto continue
		end

		local pedModel = dutyuser.model
		local pedModelHash = type(pedModel) == "number" and pedModel or joaat(pedModel)

		if not RRequestModel(pedModelHash, 20000) then
			DebugLog(("Failed to load model '%s' (hash: %d)"):format(pedModel, pedModelHash))
			goto continue
		end

		for _, coord in pairs(dutyuser.coords) do
			local ped = CreatePed(4, pedModelHash, coord.x, coord.y, coord.z - 1, coord.w or 0.0, false, true)
			if not ped or not DoesEntityExist(ped) then
				goto next_coord
			end

			SetEntityHeading(ped, coord.w or 0.0)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			SetPedCanBeTargetted(ped, false)
			SetPedFleeAttributes(ped, 0, false)

			if dutyuser.scenario then
				TaskStartScenarioInPlace(ped, dutyuser.scenario, 0, true)
			end

			Wait(100)

			::next_coord::
		end

		-- Clean up model
		SetModelAsNoLongerNeeded(pedModelHash)

		::continue::
	end
	for _, set in pairs(Config.LeaderBoard) do
		local dutyuser = set.Peds
		local coords = set.Coords
		if not dutyuser or not dutyuser.EnablePed then
			goto continue
		end

		local pedModel = dutyuser.model
		local pedModelHash = type(pedModel) == "number" and pedModel or joaat(pedModel)

		if not RRequestModel(pedModelHash, 20000) then
			DebugLog(("Failed to load model '%s' (hash: %d)"):format(pedModel, pedModelHash))
			goto continue
		end

		for _, coord in pairs(coords) do
			local ped = CreatePed(4, pedModelHash, coord.x, coord.y, coord.z - 1, coord.w or 0.0, false, true)
			if not ped or not DoesEntityExist(ped) then
				goto next_coord
			end
			SetEntityHeading(ped, coord.w or 0.0)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			SetPedCanBeTargetted(ped, false)
			SetPedFleeAttributes(ped, 0, false)
			if dutyuser.scenario then
				TaskStartScenarioInPlace(ped, dutyuser.scenario, 0, true)
			end

			Wait(100)

			::next_coord::
		end

		-- Clean up model
		SetModelAsNoLongerNeeded(pedModelHash)

		::continue::
	end
	-- blips
	for _, v in pairs(Config.DutySystem) do
		if not v.Blip.Enable then
			goto continue
		end
		local blip = v.Blip
		local coords = v.Station.duty.coords

		local blipName = v.Blip.BlipName
		DebugLog("Creating blip for: " .. blipName)

		for _, coord in ipairs(coords) do
			CCreateBlip(coord.x, coord.y, coord.z, blip.BlipSprite, blip.BlipColor, blipName, blip.BlipScale)
		end
		::continue::
	end
	-- leaderboard & rewards
	for _, v in pairs(Config.LeaderBoard) do
		if Config.EnableLeaderBoard == false and Config.EnableRewards == false then
			return
		end
		if not v.Blip.Enable then
			goto continue
		end
		local blip = v.Blip
		local coords = v.Coords

		local blipName = v.Blip.BlipName
		DebugLog("Creating blip for: " .. blipName)
		for _, coord in ipairs(coords) do
			CCreateBlip(coord.x, coord.y, coord.z, blip.BlipSprite, blip.BlipColor, blipName, blip.BlipScale)
		end
		::continue::
	end
end)

function CanOpenDutyBossMenu()
	return true
end

function CanOpenDutyUserContextMenu()
	return true
end
function CanOpenLeaderBoardAndRewards()
	return true
end

-- Function to hide or unhide the UI element (e.g., HUD) based on the DutyBoss menu state
-- This function checks the 'isOpen' parameter: if true, it hides the UI element, and if false, it unhides it.
local lastBossMenuState = nil

function isBossDutyMenuOpened(isOpen)
	if isOpen == lastBossMenuState then
		return
	end
	lastBossMenuState = isOpen
	if isOpen then
		DebugLog("Duty Boss Menu Opened")
	else
		DebugLog("Duty Boss Menu Closed")
	end
end
