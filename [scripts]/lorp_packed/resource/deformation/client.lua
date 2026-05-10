local Config = lib.require('resource.deformation.shared')

-- iterations for damage application
local MAX_DEFORM_ITERATIONS <const> = 50

-- the minimum damage value at a deformation point before being registered as actual damage
local DEFORMATION_DAMAGE_THRESHOLD <const> = 0.05

-- max difference for angle to be considered to steep (0.0-1.0)
local ANGLE_THRESHOLD <const> = 0.5

local INITIAL_DAMAGE <const> = 50.0
local DAMAGE_INCREMENTS <const> = 5.0

-- cache for deformation offsets
local deformationOffsets = {}

-- clamps a vector on an an arbitrary axis
local function ClampVectorAlongAxis(v, axis)
	local axisNorm = norm(axis)

	return dot(v, axisNorm) * axisNorm
end

local function LogDebug(text, ...)
	if (Config.debug) then
		print(("^0[DEBUG] %s^0"):format(text):format(...))
	end
end

-- checks if a point is too far from the vehicle or the angle too steep
local function IsPointTooFarFromVehicle(point, vehicle)
	local vehPos = GetEntityCoords(vehicle)
	local pointInWorld = GetOffsetFromEntityInWorldCoords(vehicle, point.x, point.y, point.z)
	local _, hit, position, normal, hitEntity = GetShapeTestResult(
		StartExpensiveSynchronousShapeTestLosProbe(pointInWorld.x, pointInWorld.y, pointInWorld.z, vehPos.x, vehPos.y, vehPos.z, 2, 0, 0)
	)

	if (not hit or hitEntity ~= vehicle) then
		return true
	end

	-- return angle difference > threshold
	return 1.0 - dot(norm(pointInWorld - position), norm(normal)) > ANGLE_THRESHOLD
end

-- returns offsets for deformation check
local function GetVehicleOffsetsForDeformation(vehicle)
	local model = GetEntityModel(vehicle)

	if (deformationOffsets[model]) then
		return deformationOffsets[model]
	end

	local pos = GetEntityCoords(PlayerPedId()) + vector3(0, 0, -50)
	local newVehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 0.0, false, false)
	FreezeEntityPosition(newVehicle, true)
	SetEntityAlpha(newVehicle, 0, false)

	local min, max = GetModelDimensions(model)

	local defPoints = {}

	local count = 0
	for x = -1, 1, 0.25 do
		for y = 1, -1, -0.25 do
			for z = -1, 1, 0.5 do
				if ((y < -0.55 or y > 0.55) and z > -0.6) then
					count += 1

					defPoints[count] = vector3(
						(max.x - min.x) * x * 0.5 + (max.x + min.x) * 0.5,
						(max.y - min.y) * y * 0.5 + (max.y + min.y) * 0.5,
						(max.z - min.z) * z * 0.5 + (max.z + min.z) * 0.5
					)
				end
			end
		end
	end

	for i = #defPoints, 1, -1 do
		if (IsPointTooFarFromVehicle(defPoints[i], newVehicle)) then
			table.remove(defPoints, i)
		end
	end

	DeleteEntity(newVehicle)

	deformationOffsets[model] = defPoints

	return defPoints
end

-- gets deformation from a vehicle
local function GetVehicleDeformation(vehicle)
	assert(vehicle ~= nil and DoesEntityExist(vehicle), "Parameter \"vehicle\" must be a valid vehicle entity!")

	local offsets = GetVehicleOffsetsForDeformation(vehicle)

	-- get deformation from vehicle
	local deformationPoints = {}
	for i = 1, #offsets do
		local projectedDamageVector = ClampVectorAlongAxis(GetVehicleDeformationAtPos(vehicle, offsets[i].x, offsets[i].y, offsets[i].z), -offsets[i])
		if (#(projectedDamageVector) > DEFORMATION_DAMAGE_THRESHOLD) then
			deformationPoints[#deformationPoints + 1] = { offsets[i], projectedDamageVector }
		end
	end

	LogDebug("Got %s deformation point(s) from \"%s\".", #deformationPoints, GetVehicleNumberPlateText(vehicle))

	return deformationPoints
end

-- check if vehicle is blacklisted
local function IsVehicleBlacklisted(vehicle)
	if (#Config.typeBlacklist > 0) then
		local vehicleType = GetVehicleType(vehicle)
		for i = 1, #Config.typeBlacklist do
			if (Config.typeBlacklist[i] == vehicleType) then
				return true
			end
		end
	end

	if (#Config.modelBlacklist > 0) then
		local vehicleModel = GetEntityModel(vehicle)
		for i = 1, #Config.modelBlacklist do
			if (Config.modelBlacklist[i] == vehicleModel) then
				return true
			end
		end
	end

	if (#Config.plateBlacklist > 0) then
		local vehiclePlate = GetVehicleNumberPlateText(vehicle)
		for i = 1, #Config.plateBlacklist do
			if (vehiclePlate:find(Config.plateBlacklist[i]:upper())) then
				return true
			end
		end
	end

	return false
end

-- sets deformation on a vehicle
local function SetVehicleDeformation(vehicle, deformationPoints, callback)
	assert(vehicle ~= nil and DoesEntityExist(vehicle), "Parameter \"vehicle\" must be a valid vehicle entity!")
	assert(deformationPoints ~= nil and type(deformationPoints) == "table", "Parameter \"deformationPoints\" must be a table!")

	-- ignore if deformation is already worse
	-- TODO: BROKEN AS OF NOW
	--if (not IsDeformationWorse(deformationPoints, GetVehicleDeformation(vehicle))) then return end

	if (deformationPoints[1] and type(deformationPoints[1][2]) == "number") then
		LogDebug("Got pre v2.2.0 data, ignoring function call...")
		return
	end

	CreateThread(function()
		local deform = true
		local iterations = 0
		while (deform and iterations < MAX_DEFORM_ITERATIONS) do
			if (not DoesEntityExist(vehicle)) then
				LogDebug("Vehicle got deleted mid-deformation.")
				return
			end

			deform = false

			for i, def in ipairs(deformationPoints) do
				local currDef = GetVehicleDeformationAtPos(vehicle, def[1].x, def[1].y, def[1].z)
				local clampedDef = ClampVectorAlongAxis(currDef, -vector3(def[1].x, def[1].y, def[1].z))
				if (#clampedDef < #vector(def[2].x, def[2].y, def[2].z)) then
					-- damage/radius increase method - seems to work best for most vehicles
					if (def[3] == nil) then
						def[3] = INITIAL_DAMAGE
					else
						def[3] = def[3] + DAMAGE_INCREMENTS
					end
					SetVehicleDamage(
						vehicle, 
						def[1].x, def[1].y, def[1].z, 
						def[3], -- damage
						def[3], -- radius
						true
					)

					deform = true

					Wait(0)
				end
			end

			iterations = iterations + 1

			Wait(0)
		end

		if (not IsVehicleBlacklisted(vehicle)) then
			local state = Entity(vehicle).state
			if (state.deformation == nil) then
				state:set("deformation", deformationPoints, true)
			end
		end

		LogDebug("Applying deformation finished for \"%s\" in %s iterations.", GetVehicleNumberPlateText(vehicle), iterations)

		if (callback) then
			callback()
		end
	end)
end

local function ApplyDeformation(vehicle, deformation)
	if (not DoesEntityExist(vehicle)) then
		local endTime = GetGameTimer() + 5000
		while (not DoesEntityExist(vehicle) and GetGameTimer() < endTime) do
			Wait(0)
		end

		if (not DoesEntityExist(vehicle)) then
			return
		end
	end
	if (not IsEntityAVehicle(vehicle)) then return end

	if (deformation and #deformation > 0) then
		SetVehicleDeformation(vehicle, deformation)
	else
		SetVehicleDeformationFixed(vehicle)
	end
end

local damageUpdate = {}
local function HandleDeformationUpdate(vehicle)
	if (damageUpdate[vehicle]) then
		damageUpdate[vehicle] = GetGameTimer() + 1000
		return
	end

	damageUpdate[vehicle] = GetGameTimer() + 1000

	while (damageUpdate[vehicle] > GetGameTimer()) do
		Wait(0)
	end

	damageUpdate[vehicle] = nil

	if (not DoesEntityExist(vehicle) or NetworkGetEntityOwner(vehicle) ~= PlayerId()) then return end

	local deformation = GetVehicleDeformation(vehicle)
	if (deformation and #deformation > 0) then
		Entity(vehicle).state:set("deformation", deformation, true)
	end
end

-- state bag handler to apply any deformation
AddStateBagChangeHandler("deformation", nil, function(bagName, key, value, _unused, replicated)
	if (bagName:find("entity") == nil) then return end

	ApplyDeformation(GetEntityFromStateBagName(bagName), value)
end)

-- update state bag on taking damage
AddEventHandler("gameEventTriggered", function (name, args)
	if (name ~= "CEventNetworkEntityDamage") then return end

	local entity = args[1]
	if (not IsEntityAVehicle(entity) or IsVehicleBlacklisted(entity)) then return end

	HandleDeformationUpdate(entity)
end)


-- fix deformation on vehicle
local function FixVehicleDeformation(vehicle)
	assert(DoesEntityExist(vehicle) and NetworkGetEntityIsNetworked(vehicle), "Parameter \"vehicle\" must be a valid and networked vehicle entity!")

	TriggerServerEvent("lorp_packed:server:fix", NetworkGetNetworkIdFromEntity(vehicle))
end

exports("FixVehicleDeformation", FixVehicleDeformation)
exports("GetVehicleDeformation", GetVehicleDeformation)
exports("SetVehicleDeformation", SetVehicleDeformation)
exports("GetDeformationOffsets", GetVehicleOffsetsForDeformation)
