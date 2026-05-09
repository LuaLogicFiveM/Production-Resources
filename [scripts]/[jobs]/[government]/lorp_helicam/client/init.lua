---=========================
--- Config				====
---=========================
local Config = {}
local theme = "blue"          -- white | green | blue | orange
local fov_max = 80.0
local fov_min = 5.0           -- max zoom level (smaller fov is more zoom)
local zoomspeed = 3.0         -- camera zoom speed
local speed_lr = 4.0          -- speed by which the camera pans left-right
local speed_ud = 4.0          -- speed by which the camera pans up-down
local toggle_helicam = 51     -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT (E)
local toggle_vision = 25      -- control id to toggle vision mode. Default: INPUT_AIM (Right mouse btn)
local toggle_rappel = 154     -- control id to rappel out of the heli. Default: INPUT_DUCK (X)
local toggle_spotlight = 183  -- control id to toggle the various spotlight states Default: INPUT_PhoneCameraGrid (G)
local toggle_lock_on = 22     -- control id to lock onto a vehicle with the camera or unlock from vehicle (with or without camera). Default is INPUT_SPRINT (spacebar)
local toggle_display = 44     -- control id to toggle vehicle info display. Default: INPUT_COVER (Q)
local lightup_key = 246       -- control id to increase spotlight brightness. Default: INPUT_MP_TEXT_CHAT_TEAM (Y)
local lightdown_key = 173     -- control id to decrease spotlight brightness. Default: INPUT_CELLPHONE_DOWN  (ARROW-DOWN)
local radiusup_key = 137      -- control id to increase manual spotlight radius. Default: INPUT_VEH_PUSHBIKE_SPRINT (CAPSLOCK)
local radiusdown_key = 21     -- control id to decrease spotlight radius. Default: INPUT_SPRINT (LEFT-SHIFT)
local maxtargetdistance = 700 -- max distance at which target lock is maintained
local brightness = 1.0        -- default spotlight brightness
local spotradius = 4.0        -- default manual spotlight radius
local speed_measure =
"MP/H"                        -- default unit to measure vehicle speed but can be changed to "MPH". Use either exact string, "Km/h" or "MPH", or else functions break.

local isMarkersThreadActive = false
local markers = {}
local markerBlips = {}

Config.Jobs = {
	bcso = true,
	gsp = true,
	gov = true,
}

Config.Marker = {
	MaxAmount = 5,         -- Above 9 the number markers should be disabled.
	MaxDrawDistance = 500.0, -- The furthest distance a marker will be drawn at.
	Circle = {
		Type = 23,
		Scale = 8.0,
		Colour = { R = 230, G = 50, B = 50, A = 200 } -- { R = 110, G = 160, B = 230, A = 200 }
	},
	Number = {
		Display = true, -- Set this to false if you want the max amount of markers the be above 9
		Scale = 6.0,
		Colour = { R = 230, G = 50, B = 50, A = 200 }
	},
	Blip = {
		Display = true, -- Whether to display marker blips
		Number = true, -- Whether to display the number on the blip or not (99 is cap.)
		Sprite = 57,
		Scale = 0.75,
		Colour = 1, -- Red
	}
}

local helimodels = {
	"AS365",
	"909_Seahawk",
	"swatec135",
	"b412",
	"swatec135",
	"swatec135",
	"c3swathawk",
	"riothuey",
	"airone",
}

-- Script starts here
local target_vehicle = nil
local manual_spotlight = false
local tracking
local spotlight = false
local vehicle_display = 0 -- 0 is turns off, 1 is turn on
local helicam = false
local helicamEnt = nil
local fov = (fov_max + fov_min) * 0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision

local UI_Data = {
	heliZ = 0,
	camZ = 0,
	vehicle_display = 0,
	vehicle_info = { plate = nil, speed = 0, model = nil },
	vision_state = vision_state,
	tracking = tracking,
	speed_measure = speed_measure,
	zoom_value = 0,
	camFov = 0,
	fov_min = fov_min,
	fov_max = fov_max,
	locked = false,
	theme = theme,
}

Config.Framework = nil
local Framework = nil
Citizen.CreateThread(function()
	local function HasResource(name)
		return GetResourceState(name):find("start") ~= nil
	end
	if HasResource("qb-core") then
		Config.Framework = "qb"
		Framework = exports["qb-core"]:GetCoreObject()
	elseif HasResource("es_extended") then
		Config.Framework = "esx"
		Framework = exports["es_extended"]:getSharedObject()
	end
end)

Citizen.CreateThread(function() -- Register ped decorators used to pass some variables from heli pilot to other players (variable settings: 1=false, 2=true)
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			DecorRegister("SpotvectorX", 3) -- For direction of manual spotlight
			DecorRegister("SpotvectorY", 3)
			DecorRegister("SpotvectorZ", 3)
			DecorRegister("Target", 3) -- Backup method of target ID
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 2500
		local lPed = PlayerPedId()
		local heli = GetVehiclePedIsIn(lPed)

		if IsPlayerInPolmav(heli) then
			sleep = 1

			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0, toggle_helicam) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = true
				end

				if IsControlJustPressed(0, toggle_rappel) then -- Initiate rappel
					Citizen.Trace("try to rappel")
					if GetPedInVehicleSeat(heli, 1) == lPed or GetPedInVehicleSeat(heli, 2) == lPed then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						TaskRappelFromHeli(PlayerPedId(), 1)
					else
						SetNotificationTextEntry("STRING")
						AddTextComponentString("~r~Can't rappel from this seat")
						DrawNotification(false, false)
						PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
					end
				end
			end

			if IsControlJustPressed(0, toggle_spotlight) and GetPedInVehicleSeat(heli, -1) == lPed and not helicam then -- Toggle forward and tracking spotlight states
				if target_vehicle then
					if tracking_spotlight then
						if not pause_Tspotlight then
							pause_Tspotlight = true
							TriggerServerEvent("lorp_helipause.tracking.spotlight", pause_Tspotlight)
						else
							pause_Tspotlight = false
							TriggerServerEvent("lorp_helipause.tracking.spotlight", pause_Tspotlight)
						end
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					else
						if Fspotlight_state then
							Fspotlight_state = false
							TriggerServerEvent("lorp_heliforward.spotlight", Fspotlight_state)
						end
						local target_netID = VehToNet(target_vehicle)
						local target_plate = GetVehicleNumberPlateText(target_vehicle)
						local targetposx, targetposy, targetposz = table.unpack(GetEntityCoords(target_vehicle))
						pause_Tspotlight = false
						tracking_spotlight = true
						TriggerServerEvent("lorp_helitracking.spotlight", target_netID, target_plate, targetposx,
							targetposy,
							targetposz)
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					end
				else
					if tracking_spotlight then
						pause_Tspotlight = false
						tracking_spotlight = false
						TriggerServerEvent("lorp_helitracking.spotlight.toggle")
					end
					Fspotlight_state = not Fspotlight_state
					TriggerServerEvent("lorp_heliforward.spotlight", Fspotlight_state)
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
				end
			end

			if target_vehicle and GetPedInVehicleSeat(heli, -1) == lPed then
				local coords1 = GetEntityCoords(heli)
				local coords2 = GetEntityCoords(target_vehicle)
				local target_distance = GetDistanceBetweenCoords(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y,
					coords2.z, false)
				if IsControlJustPressed(0, toggle_lock_on) or target_distance > maxtargetdistance then
					UI_Data.locked = false
					--Citizen.Trace("Heli: target vehicle released or lost")
					DecorRemove(target_vehicle, "Target")
					if tracking_spotlight then
						TriggerServerEvent("lorp_helitracking.spotlight.toggle")
					end
					tracking_spotlight = false
					pause_Tspotlight = false
					target_vehicle = nil
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
				end
			end

			if helicam then
				UI_ToggleVisible(true)
				SetTimecycleModifier("heliGunCam")
				SetTimecycleModifierStrength(0.3)
				local lPed = PlayerPedId()
				local heli = GetVehiclePedIsIn(lPed)
				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
				helicamEnt = cam
				AttachCamToEntity(cam, heli, 0.0, 0.0, -1.5, true)
				SetCamRot(cam, 0.0, 0.0, GetEntityHeading(heli))
				SetCamFov(cam, fov)
				RenderScriptCams(true, false, 0, 1, 0)
				local locked_on_vehicle = nil
				Citizen.Wait(0)
				while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and IsHeliHighEnough(heli) do
					if IsControlJustPressed(0, toggle_helicam) then -- Toggle Helicam
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						if manual_spotlight and target_vehicle then -- If exiting helicam while manual spotlight is locked on a target, transition to non-helicam auto tracking spotlight
							TriggerServerEvent("lorp_helimanual.spotlight.toggle")
							local target_netID = VehToNet(target_vehicle)
							local target_plate = GetVehicleNumberPlateText(target_vehicle)
							local targetposx, targetposy, targetposz = table.unpack(GetEntityCoords(target_vehicle))
							pause_Tspotlight = false
							tracking_spotlight = true
							TriggerServerEvent("lorp_helitracking.spotlight", target_netID, target_plate, targetposx,
								targetposy,
								targetposz)
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						end
						manual_spotlight = false
						helicam = false
					end

					if IsControlJustPressed(0, toggle_vision) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						ChangeVision()
					end

					if IsControlJustPressed(0, toggle_spotlight) then -- Spotlight_toggles within helicam
						if tracking_spotlight then     -- If tracking spotlight active, pause it & toggle manual spotlight
							pause_Tspotlight = true
							TriggerServerEvent("lorp_helipause.tracking.spotlight", pause_Tspotlight)
							manual_spotlight = not manual_spotlight
							if manual_spotlight then
								local rotation = GetCamRot(cam, 2)
								local forward_vector = RotAnglesToVec(rotation)
								local SpotvectorX, SpotvectorY, SpotvectorZ = table.unpack(forward_vector)
								DecorSetInt(lPed, "SpotvectorX", SpotvectorX)
								DecorSetInt(lPed, "SpotvectorY", SpotvectorY)
								DecorSetInt(lPed, "SpotvectorZ", SpotvectorZ)
								PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
								TriggerServerEvent("lorp_helimanual.spotlight")
							else
								TriggerServerEvent("lorp_helimanual.spotlight.toggle")
							end
						elseif Fspotlight_state then -- If forward spotlight active, disable it & toggle manual spotlight
							Fspotlight_state = false
							TriggerServerEvent("lorp_heliforward.spotlight", Fspotlight_state)
							manual_spotlight = not manual_spotlight
							if manual_spotlight then
								PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
								TriggerServerEvent("lorp_helimanual.spotlight")
							else
								TriggerServerEvent("lorp_helimanual.spotlight.toggle")
							end
						else -- If no other spotlight mode active, toggle manual spotlight
							manual_spotlight = not manual_spotlight
							if manual_spotlight then
								PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
								TriggerServerEvent("lorp_helimanual.spotlight")
							else
								TriggerServerEvent("lorp_helimanual.spotlight.toggle")
							end
						end
					end

					if IsControlJustPressed(0, lightup_key) then
						TriggerServerEvent("lorp_helilight.up")
					end

					if IsControlJustPressed(0, lightdown_key) then
						TriggerServerEvent("lorp_helilight.down")
					end

					if IsControlJustPressed(0, radiusup_key) then
						TriggerServerEvent("lorp_heliradius.up")
					end

					if IsControlJustPressed(0, radiusdown_key) then
						TriggerServerEvent("lorp_heliradius.down")
					end

					if IsControlJustPressed(0, toggle_display) then
						ChangeDisplay()
					end

					if locked_on_vehicle then
						if DoesEntityExist(locked_on_vehicle) then
							PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
							RenderVehicleInfo(locked_on_vehicle)
							local coords1 = GetEntityCoords(heli)
							local coords2 = GetEntityCoords(locked_on_vehicle)
							local target_distance = GetDistanceBetweenCoords(coords1.x, coords1.y, coords1.z, coords2.x,
								coords2.y, coords2.z, false)
							if IsControlJustPressed(0, toggle_lock_on) or target_distance > maxtargetdistance then
								UI_Data.locked = true
								--Citizen.Trace("Heli: locked_on_vehicle unlocked or lost")
								PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
								DecorRemove(target_vehicle, "Target")
								if tracking_spotlight then
									TriggerServerEvent("lorp_helitracking.spotlight.toggle")
									tracking_spotlight = false
								end
								target_vehicle = nil
								locked_on_vehicle = nil
								local rot = GetCamRot(cam, 2) -- All this because I can't seem to get the camera unlocked from the entity
								local fov = GetCamFov(cam)
								local old
								cam = cam
								DestroyCam(old_cam, false)
								cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
								AttachCamToEntity(cam, heli, 0.0, 0.0, -1.5, true)
								helicamEnt = cam
								SetCamRot(cam, rot, 2)
								SetCamFov(cam, fov)
								RenderScriptCams(true, false, 0, 1, 0)
							end
						else
							UI_Data.locked = false
							locked_on_vehicle = nil -- Cam will auto unlock when entity doesn't exist anyway
							target_vehicle = nil
						end
					else
						local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
						UI_Data.zoom_value = zoomvalue
						CheckInputRotation(cam, zoomvalue)
						local vehicle_detected = GetVehicleInView(cam)
						if vehicle_detected and DoesEntityExist(vehicle_detected) then
							RenderVehicleInfo(vehicle_detected)
							if IsControlJustPressed(0, toggle_lock_on) then
								PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
								locked_on_vehicle = vehicle_detected

								if target_vehicle then -- If previous target exists, remove old target decorator before updating target vehicle
									DecorRemove(target_vehicle, "Target")
								end

								target_vehicle = vehicle_detected
								NetworkRequestControlOfEntity(target_vehicle)
								local target_netID = VehToNet(target_vehicle)
								SetNetworkIdCanMigrate(target_netID, true)
								NetworkRegisterEntityAsNetworked(VehToNet(target_vehicle))
								SetNetworkIdExistsOnAllMachines(target_vehicle, true)
								SetEntityAsMissionEntity(target_vehicle, true, true)
								target_plate = GetVehicleNumberPlateText(target_vehicle)
								DecorSetInt(locked_on_vehicle, "Target", 2)

								if tracking_spotlight then -- If tracking previous target, terminate and start tracking new target
									TriggerServerEvent("lorp_helitracking.spotlight.toggle")
									target_vehicle = locked_on_vehicle

									if not pause_Tspotlight then -- If spotlight was paused when tracking old target,
										local target_netID = VehToNet(target_vehicle)
										local target_plate = GetVehicleNumberPlateText(target_vehicle)
										local targetposx, targetposy, targetposz = table.unpack(GetEntityCoords(
											target_vehicle))
										pause_Tspotlight = false
										tracking_spotlight = true
										TriggerServerEvent("lorp_helitracking.spotlight", target_netID, target_plate,
											targetposx,
											targetposy, targetposz)
										PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
									else
										tracking_spotlight = false
										pause_Tspotlight = false
									end
								end
							end
						end
					end

					HandleZoom(cam)
					HideHUDThisFrame()
					UpdateUIHeadingPitchAndBearing(cam, heli)
					local heliCoords = GetEntityCoords(heli)
					UI_Data.heliZ = heliCoords.z
					local heading = string.format("%.0f", (360.0 - ((GetCamRot(cam, 2).z + 360.0) % 360.0)))
					heading = tonumber(heading)
					if heading == 360 then heading = 0 end
					UI_Data.camZ = heading
					local latitude = GetCartesianCoords(heliCoords.x)
					local longitude = GetCartesianCoords(heliCoords.y)
					UI_Data.latitude = latitude
					UI_Data.longitude = longitude
					if speed_measure == "MPH" then
						UI_Data.heliSpeed = GetEntitySpeed(heli) * 2.236936
					else
						UI_Data.heliSpeed = GetEntitySpeed(heli) * 3.6
					end

					if manual_spotlight then -- Continuously update manual spotlight direction, sync client-client with decorators
						local rotation = GetCamRot(cam, 2)
						local forward_vector = RotAnglesToVec(rotation)
						local SpotvectorX, SpotvectorY, SpotvectorZ = table.unpack(forward_vector)
						local camcoords = GetCamCoord(cam)

						DecorSetInt(lPed, "SpotvectorX", SpotvectorX)
						DecorSetInt(lPed, "SpotvectorY", SpotvectorY)
						DecorSetInt(lPed, "SpotvectorZ", SpotvectorZ)
						DrawSpotLight(camcoords, forward_vector, 255, 255, 255, 800.0, 10.0, brightness, spotradius, 1.0,
							1.0)
					end
					Citizen.Wait(0)
				end
				if manual_spotlight then
					manual_spotlight = false
					TriggerServerEvent("lorp_helimanual.spotlight.toggle")
				end
				helicam = false
				ClearTimecycleModifier()
				fov = (fov_max + fov_min) * 0.5 -- reset to starting zoom level
				RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
				DestroyCam(cam, false)
				helicamEnt = nil
				SetNightvision(false)
				SetSeethrough(false)
				UI_ToggleVisible(false)
			end

			if target_vehicle and not helicam and vehicle_display ~= 0 then
				RenderVehicleInfo(target_vehicle)
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		UI_Update()
		Wait(500)
	end
end)

RegisterKeyMapping('helicam_toggle_marker', "Helicam - Add/Remove Markers", "MOUSE_BUTTON", "MOUSE_MIDDLE")
RegisterCommand('helicam_toggle_marker', function()
	if helicam and IsPlayerPolice() then
		ToggleMarker()
	end
end, false)

RegisterNetEvent('lorp_heliforward.spotlight')
AddEventHandler('lorp_heliforward.spotlight', function(serverID, state)
	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	SetVehicleSearchlight(heli, state, false)
end)

RegisterNetEvent('lorp_heliTspotlight')
AddEventHandler('lorp_heliTspotlight', function(serverID, target_netID, target_plate, targetposx, targetposy, targetposz)
	-- Client target identification and verification, with fail-safes until FiveM code around global networked entities is sorted out
	if GetVehicleNumberPlateText(NetToVeh(target_netID)) == target_plate then
		Tspotlight_target = NetToVeh(target_netID)
	elseif GetVehicleNumberPlateText(DoesVehicleExistWithDecorator("Target")) == target_plate then
		Tspotlight_target = DoesVehicleExistWithDecorator("Target")
		--Citizen.Trace("Client target ID by primary netID method failed! Secondary decorator-based method worked.")
	elseif GetVehicleNumberPlateText(GetClosestVehicle(targetposx, targetposy, targetposz, 25.0, 0, 70)) == target_plate then
		Tspotlight_target = GetClosestVehicle(targetposx, targetposy, targetposz, 25.0, 0, 70)
		--Citizen.Trace("Heli: client target ID methods based on netID and decorator both failed! Tertiary method using target coordinates worked.")
	else
		vehicle_match = FindVehicleByPlate(target_plate)
		if vehicle_match then
			Tspotlight_target = vehicle_match
			--Citizen.Trace("Heli: client target ID methods based on netID, decorator and coords all failed! Final method of searching vehicles by plate worked.")
		else
			Tspotlight_target = nil
			--Citizen.Trace("Heli: all methods of client target ID failed!!")
		end
	end

	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	local heliPed = GetPlayerPed(GetPlayerFromServerId(serverID))
	Tspotlight_toggle = true
	Tspotlight_pause = false
	tracking_spotlight = true
	while not IsEntityDead(heliPed) and (GetVehiclePedIsIn(heliPed) == heli) and Tspotlight_target and Tspotlight_toggle do
		Citizen.Wait(0)
		local helicoords = GetEntityCoords(heli)
		local targetcoords = GetEntityCoords(Tspotlight_target)
		local spotVector = targetcoords - helicoords
		local target_distance = Vdist(targetcoords, helicoords)
		if Tspotlight_target and Tspotlight_toggle and not Tspotlight_pause then -- Redundant condition seems needed here or a function breaks
			DrawSpotLight(helicoords['x'], helicoords['y'], helicoords['z'], spotVector['x'], spotVector['y'],
				spotVector['z'], 255, 255, 255, (target_distance + 20), 10.0, brightness, 4.0, 1.0, 0.0)
		end
		if Tspotlight_target and Tspotlight_toggle and target_distance > maxtargetdistance then -- Ditto for this target loss section
			--Citizen.Trace("Heli: tracking spotlight target lost")
			DecorRemove(Tspotlight_target, "Target")
			target_vehicle = nil
			tracking_spotlight = false
			TriggerServerEvent("lorp_helitracking.spotlight.toggle")
			Tspotlight_target = nil
			break
		end
	end
	Tspotlight_toggle = false
	Tspotlight_pause = false
	Tspotlight_target = nil
	tracking_spotlight = false
end)

RegisterNetEvent('lorp_heliTspotlight.toggle')
AddEventHandler('lorp_heliTspotlight.toggle', function(serverID)
	Tspotlight_toggle = false
	tracking_spotlight = false
end)

RegisterNetEvent('lorp_helipause.Tspotlight')
AddEventHandler('lorp_helipause.Tspotlight', function(serverID, pause_Tspotlight)
	if pause_Tspotlight then
		Tspotlight_pause = true
	else
		Tspotlight_pause = false
	end
end)

RegisterNetEvent('lorp_heliMspotlight')
AddEventHandler('lorp_heliMspotlight', function(serverID)
	if GetPlayerServerId(PlayerId()) ~= serverID then -- Skip event for the source, since heli pilot already sees a more responsive manual spotlight
		local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
		local heliPed = GetPlayerPed(GetPlayerFromServerId(serverID))
		Mspotlight_toggle = true
		while not IsEntityDead(heliPed) and (GetVehiclePedIsIn(heliPed) == heli) and Mspotlight_toggle do
			Citizen.Wait(0)
			local helicoords = GetEntityCoords(heli)
			spotoffset = helicoords + vector3(0.0, 0.0, -1.5)
			SpotvectorX = DecorGetInt(heliPed, "SpotvectorX")
			SpotvectorY = DecorGetInt(heliPed, "SpotvectorY")
			SpotvectorZ = DecorGetInt(heliPed, "SpotvectorZ")
			if SpotvectorX then
				DrawSpotLight(spotoffset['x'], spotoffset['y'], spotoffset['z'], SpotvectorX, SpotvectorY, SpotvectorZ,
					255, 255, 255, 800.0, 10.0, brightness, spotradius, 1.0, 1.0)
			end
		end
		Mspotlight_toggle = false
		DecorSetInt(heliPed, "SpotvectorX", nil)
		DecorSetInt(heliPed, "SpotvectorY", nil)
		DecorSetInt(heliPed, "SpotvectorZ", nil)
	end
end)

RegisterNetEvent('lorp_heliMspotlight.toggle')
AddEventHandler('lorp_heliMspotlight.toggle', function(serverID)
	Mspotlight_toggle = false
end)

RegisterNetEvent('lorp_helilight.up')
AddEventHandler('lorp_helilight.up', function(serverID)
	if brightness < 10 then
		brightness = brightness + 1.0
	end
end)

RegisterNetEvent('lorp_helilight.down')
AddEventHandler('lorp_helilight.down', function(serverID)
	if brightness > 1.0 then
		brightness = brightness - 1.0
	end
end)

RegisterNetEvent('lorp_heliradius.up')
AddEventHandler('lorp_heliradius.up', function(serverID)
	if spotradius < 10.0 then
		spotradius = spotradius + 1.0
	end
end)

RegisterNetEvent('lorp_heliradius.down')
AddEventHandler('lorp_heliradius.down', function(serverID)
	if spotradius > 4.0 then
		spotradius = spotradius - 1.0
	end
end)

RegisterNetEvent("0r-helicam:Client:SyncMarkerBlips", function(_markers)
	if not IsPlayerPolice() then return end
	markers = _markers
	UpdateMarkerBlips()
end)

function IsPlayerPolice()
	local xPlayer = nil
	local isPolice = false
	if Config.Framework == "esx" then
		xPlayer = Framework.GetPlayerData()
	elseif Config.Framework == "qb" then
		xPlayer = Framework.Functions.GetPlayerData()
	end
	local playerJob = xPlayer.job.name
	isPolice = Config.Jobs[playerJob]
	return isPolice
end

function IsPlayerInPolmav(vehicle)
    for i = 1, #helimodels do
        if IsVehicleModel(vehicle, GetHashKey(helimodels[i])) then
            return true 
        end
    end
    return false 
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 2.0
end

function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
	UI_Data.vision_state = vision_state
end

function ChangeDisplay()
	if vehicle_display == 0 then
		vehicle_display = 1
	else
		vehicle_display = 0
	end
	UI_Data.vehicle_display = vehicle_display
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY * -1.0 * (speed_lr) * (zoomvalue + 0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local fov_changed = false
	if IsControlJustPressed(0, 241) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
		fov_changed = true
	end
	if IsControlJustPressed(0, 242) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		fov_changed = true
	end
	if fov_changed then
		local current_fov = GetCamFov(cam)
		if math.abs(fov - current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov) * 0.05) -- Smoothing of camera zoom
		UI_Data.camFov = current_fov + (fov - current_fov) * 0.05
	end
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords + (forward_vector * 200.0), 10,
		GetVehiclePedIsIn(PlayerPedId()), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit > 0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RenderVehicleInfo(vehicle)
	if DoesEntityExist(vehicle) then
		local model = GetEntityModel(vehicle)
		local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
		local licenseplate = GetVehicleNumberPlateText(vehicle)
		if speed_measure == "MPH" then
			vehspeed = GetEntitySpeed(vehicle) * 2.236936
		else
			vehspeed = GetEntitySpeed(vehicle) * 3.6
		end
		UI_Data.vehicle_info.model = vehname
		UI_Data.vehicle_info.plate = licenseplate
		UI_Data.vehicle_info.speed = math.ceil(vehspeed)
	end
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

-- Following two functions from IllidanS4's entity enuerator script:  https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function FindVehicleByPlate(plate) -- Search existing vehicles enumerated above for target plate and return the matching vehicle
	for vehicle in EnumerateVehicles() do
		if GetVehicleNumberPlateText(vehicle) == plate then
			return vehicle
		end
	end
end

function SendReactMessage(action, data)
	SendNUIMessage({
		action = action,
		data = data
	})
end

function UI_ToggleVisible(state)
	SendReactMessage("ui:setVisible", state or false)
end

function UI_Update()
	SendReactMessage("ui:update", UI_Data)
end

function GetCartesianCoords(coord)
	local degrees = math.floor(coord)
	local min = (coord - degrees) * 60
	local minutes = math.floor(min)

	local sec = (min - minutes) * 60
	local secfloor = math.floor(sec)
	local seconds = string.format("%02d", secfloor) .. string.format("%.2f", sec - secfloor):sub(2)

	local cartesian = string.format("%02d", degrees) .. "° " .. string.format("%02d", minutes) .. "' " .. seconds .. '"'
	return cartesian
end

function RotationToHeading(rotation)
	local heading = rotation
	if heading < 0 then
		heading = heading * -1
		heading = heading + math.abs(heading - 180.0) * 2
	end

	heading = (heading - 360) * -1

	return heading
end

function UpdateUIHeadingPitchAndBearing(cam, heli)
	local rotation = GetCamRot(cam, 2)
	local bearing = string.format("%.0f", RotationToHeading(rotation.z))
	local pitch = (rotation.x * -1) + 90.0
	local heading = (rotation.z * -1) + GetEntityHeading(heli)
	if heading > 360 then
		heading = heading - 360
	end
	UI_Data.cameraPitch = string.format("%.0f", (pitch - 90) * -1)
	UI_Data.cameraBearing = string.format("%.0f", bearing)
	UI_Data.heliHeading = string.format("%.0f", heading)
end

function MarkersThread()
	if isMarkersThreadActive then return end
	CreateThread(function()
		isMarkersThreadActive = true

		while true do
			if markers == nil or #markers == 0 then
				break
			end
			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			local heliCoords = GetEntityCoords(heli)

			for index, coords in pairs(markers) do
				if #(heliCoords - coords) < Config.Marker.MaxDrawDistance then
					DrawMarker(Config.Marker.Circle.Type, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
						Config.Marker.Circle.Scale, Config.Marker.Circle.Scale, Config.Marker.Circle.Scale,
						Config.Marker.Circle.Colour.R, Config.Marker.Circle.Colour.G, Config.Marker.Circle.Colour.B,
						Config.Marker.Circle.Colour.A, false, true, 2, false, nil, nil, false)
					if Config.Marker.Number.Display then
						DrawMarker(index + 10, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
							Config.Marker.Number.Scale, Config.Marker.Number.Scale, Config.Marker.Number.Scale,
							Config.Marker.Number.Colour.R, Config.Marker.Number.Colour.G, Config.Marker.Number.Colour.B,
							Config.Marker.Number.Colour.A, false, true, 2, false, nil, nil, false)
					end
				end
			end
			Wait(0)
		end

		isMarkersThreadActive = false
	end)
end

function Raycast(startCoords, destination, entity, flag)
	local rayHandle = StartShapeTestLosProbe(startCoords.x, startCoords.y, startCoords.z, destination.x, destination.y,
		destination.z, flag or 4294967295, entity, 4) -- 4294967295 = TraceFlags_IntersectEverything

	while true do
		local result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
		if result ~= 1 then
			return hit, endCoords, surfaceNormal, entityHit
		end

		Wait(0)
	end
end

function GetOffsetFromCoordsInWorldCoords(position, rotation, offset)
	local rotX, rotY, rotZ = math.rad(rotation.x), math.rad(rotation.y), math.rad(rotation.z)
	local matrix = {}

	matrix[1] = {}
	matrix[1][1] = math.cos(rotZ) * math.cos(rotY) - math.sin(rotZ) * math.sin(rotX) * math.sin(rotY)
	matrix[1][2] = math.cos(rotY) * math.sin(rotZ) + math.cos(rotZ) * math.sin(rotX) * math.sin(rotY)
	matrix[1][3] = -math.cos(rotX) * math.sin(rotY)
	matrix[1][4] = 1

	matrix[2] = {}
	matrix[2][1] = -math.cos(rotX) * math.sin(rotZ)
	matrix[2][2] = math.cos(rotZ) * math.cos(rotX)
	matrix[2][3] = math.sin(rotX)
	matrix[2][4] = 1

	matrix[3] = {}
	matrix[3][1] = math.cos(rotZ) * math.sin(rotY) + math.cos(rotY) * math.sin(rotZ) * math.sin(rotX)
	matrix[3][2] = math.sin(rotZ) * math.sin(rotY) - math.cos(rotZ) * math.cos(rotY) * math.sin(rotX)
	matrix[3][3] = math.cos(rotX) * math.cos(rotY)
	matrix[3][4] = 1

	matrix[4] = {}
	matrix[4][1], matrix[4][2], matrix[4][3] = position.x, position.y, position.z
	matrix[4][4] = 1

	local x = offset.x * matrix[1][1] + offset.y * matrix[2][1] + offset.z * matrix[3][1] + matrix[4][1]
	local y = offset.x * matrix[1][2] + offset.y * matrix[2][2] + offset.z * matrix[3][2] + matrix[4][2]
	local z = offset.x * matrix[1][3] + offset.y * matrix[2][3] + offset.z * matrix[3][3] + matrix[4][3]

	return vector3(x, y, z)
end

function RaycastFromHeliCam(flag)
	local lPed = PlayerPedId()
	local heli = GetVehiclePedIsIn(lPed)
	local camCoords = GetCamCoord(helicamEnt)
	local camRotation = GetCamRot(helicamEnt, 2)
	local destination = GetOffsetFromCoordsInWorldCoords(camCoords, camRotation, vector3(0.0, 424.0, 0.0))
	local hit, endCoords, _surfaceNormal, entityHit = Raycast(camCoords, destination, heli, flag)

	return (hit == 1 and true) or false, endCoords, entityHit
end

function CreateMarkerBlip(coords, number)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

	SetBlipSprite(blip, Config.Marker.Blip.Sprite)
	SetBlipScale(blip, Config.Marker.Blip.Scale)
	SetBlipColour(blip, Config.Marker.Blip.Colour)

	if Config.Marker.Blip.Number then
		ShowNumberOnBlip(blip, number)
	end

	-- Set blip name
	-- BeginTextCommandSetBlipName("STRING")
	-- AddTextComponentString("Helicam Marker")
	-- EndTextCommandSetBlipName(blip)

	return blip
end

function UpdateMarkerBlips()
	if markers == nil then
		return
	end

	if #markers < #markerBlips then
		for index, data in pairs(markerBlips) do
			if index > #markers then
				RemoveBlip(data.handler)
				markerBlips[index] = nil
			end
		end
	end

	for index, coords in pairs(markers) do
		if not markerBlips[index] then
			markerBlips[index] = {}
			markerBlips[index].handler = CreateMarkerBlip(coords, index)
			markerBlips[index].coords = coords
		elseif markerBlips[index].coords ~= coords then
			SetBlipCoords(markerBlips[index].handler, coords.x, coords.y, coords.z)
			ShowNumberOnBlip(markerBlips[index].handler, index)
			markerBlips[index].coords = coords
		end
	end
end

function ToggleMarker()
	local markerIndex = nil
	local hit, hitCoords = RaycastFromHeliCam()
	if not hit then
		return
	end

	local adjustedCoords = vector3(hitCoords.x, hitCoords.y, hitCoords.z + 0.25)
	for index, coords in pairs(markers) do
		local dist = #(coords - adjustedCoords)
		if dist < Config.Marker.Circle.Scale + 0.5 then
			markerIndex = index
			break
		end
	end

	if markerIndex then
		table.remove(markers, markerIndex)
	else
		if #markers >= Config.Marker.MaxAmount then
			table.remove(markers, 1)
		end
		markers[#markers + 1] = adjustedCoords
	end
	TriggerServerEvent("0r-helicam:Server:SyncMarkerBlips", markers)
	MarkersThread()
end
