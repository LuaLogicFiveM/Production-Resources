---@script core/server/classes/Bridge.lua

---@class IncidentData
---@field type string
---@field description string
---@field location string
---@field data table

---@class ServerBridge
---@field refreshFrameworkData fun()
---@field check fun(source: integer, data: table): boolean
---@field autoBookOnUser fun(source: integer, department_str: string)
---@field newIncident fun(incident: IncidentData)

---@type ServerBridge
Bridge = Bridge or {}

local ESX = nil
local QBCore = nil

local function detectFramework()
	if GetResourceState("es_extended") == "started" then
		ESX = exports["es_extended"]:getSharedObject()
	end

	if GetResourceState("qb-core") == "started" then
		QBCore = exports["qb-core"]:GetCoreObject()
	end
end

detectFramework()

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

local function warnPrint(message)
	if Server and type(Server.warnServer) == "function" then
		Server.warnServer(message)
	else
		print(("[Bridge:WARN] %s"):format(message))
	end
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
local function refreshFrameworkData()
	detectFramework()
end

Bridge.refreshFrameworkData = refreshFrameworkData

---@param source integer
---@param data table
---@return boolean
local function check_permissions(source, data)
	if not data then
		warnPrint("check_permissions: missing data table.")
		return false
	end

	local framework = data.framework
	if not framework then
		warnPrint("check_permissions: missing framework key in data.")
		return false
	end

	local permission_checks = {
		["qb-core"] = function()
			if QBCore and QBCore.Functions.GetPlayer(source) then
				return QBCore.Functions.HasPermission(source, data.permission)
			end
		end,
		["ace-perms"] = function()
			return IsPlayerAceAllowed(tostring(source), data.permission)
		end,
		["qbx_core"] = function()
			local player = exports["qbx_core"]:GetPlayer(source)
			if player == nil then
				return false
			end

			for _, job_str in pairs(data.permission) do
				if player.PlayerData.job.name == job_str then
					return true
				end
			end

			return false
		end,
	}

	local fun = permission_checks[framework]
	if not fun then
		warnPrint(("check_permissions: framework '%s' not supported."):format(framework))
		return false
	end

	local ok, result = pcall(fun)
	if not ok then
		warnPrint(("check_permissions: error during permission check: %s"):format(result))
		return false
	end

	return result
end

Bridge.check = check_permissions

---@param source integer
---@param department_str string
local function auto_book_on_user(source, department_str)
	if not Init or not Init.departments then
		warnPrint("autoBookOnUser: Init.departments not defined.")
		return
	end

	local dept = Init.departments[department_str]
	if not dept then
		warnPrint(("Department [%s] not found!"):format(department_str))
		return
	end

	local framework = dept.framework or {}
	Init.dutyTable = Init.dutyTable or {}
	Init.dutyTable[department_str] = Init.dutyTable[department_str] or { members = {} }

	local duty = Init.dutyTable[department_str].members

	if QBCore and framework.QBCore and framework.QBCore.enabled and framework.QBCore.autoBook then
		local player = QBCore.Functions.GetPlayer(source)
		if player and player.PlayerData and player.PlayerData.job then
			local job = player.PlayerData.job.name
			for _, allowed in pairs(framework.QBCore.jobs or {}) do
				if job == allowed and not duty[source] then
					duty[source] = {}
				end
			end
		end
	end

	if ESX and framework.ESX and framework.ESX.enabled and framework.ESX.autoBook then
		local player = ESX.GetPlayerFromId(source)
		if player and player.job then
			local job = player.job.name
			for _, allowed in pairs(framework.ESX.jobs or {}) do
				if job == allowed and not duty[source] then
					duty[source] = {}
				end
			end
		end
	end
end

Bridge.autoBookOnUser = auto_book_on_user

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param incident IncidentData
local function new_incident(incident)
	if not incident then
		return
	end

	---@return boolean
	local function isValidIncident()
		if (not incident) or type(incident) ~= "table" or type(incident.data) ~= "table" then
			return false
		end

		local required_data_fields = { "pos", "dept" }
		for _, field in ipairs(required_data_fields) do
			if incident.data[field] == nil then
				return false
			end
		end

		local required_fields = { "type", "description", "location" }
		for _, field in ipairs(required_fields) do
			if incident[field] == nil then
				return false
			end
		end

		return true
	end

	if not isValidIncident() then
		Server.warnServer("Invalid incident data provided.")
		return
	end

	local incidents = cfg.autoIncidents
	local integrations = incidents.integrations

	if not incidents.dutyAlerts.allow then
		return
	end

	local hasSentAlert = false

	if integrations["albosFMS"] then
		hasSentAlert = true
		exports["fms"]:createCad({
			type = incident.type,
			description = incident.description,
			location = incident.location,
			x = incident.data.pos.x,
			y = incident.data.pos.y,
		}, function(err)
			if not err then
				return
			end
			Server.warnServer(("Error creating CAD with albosFMS: %s"):format(err))
		end)
	end

	if integrations["sonoranCAD"] then
		hasSentAlert = true
		exports["sonorancad"]:performApiRequest({
			{
				["serverId"] = GetConvarInt("sonoran_serverId", 1),
				["isEmergency"] = true,
				["caller"] = "System",
				["location"] = incident.location,
				["description"] = incident.description,
				["metaData"] = {
					["useCallLocation"] = false,
					["postal"] = 0,
				},
			},
		}, "CALL_911")
	end

	if integrations["infernoPager"] then
		hasSentAlert = true
		TriggerEvent(
			"Fire-EMS-Pager:PageTones",
			{ "fire" },
			true,
			{ incident.type, incident.description, incident.location }
		)
	end

	if integrations["emergencyDispatch"] then
		hasSentAlert = true
		TriggerEvent(
			"emergencydispatch:emergencycall:new",
			"fire",
			incident.description,
			vector3(incident.data.pos.x, incident.data.pos.y, incident.data.pos.z),
			true
		)
	end

	if integrations["cd_dispatch"] then
		hasSentAlert = true
		TriggerClientEvent("cd_dispatch:AddNotification", -1, {
			job_table = { "fire" },
			coords = vector3(incident.data.pos.x, incident.data.pos.y, incident.data.pos.z),
			title = incident.type,
			message = incident.description,
			flash = 0,
			unique_id = tostring(math.random(1000000, 9999999)),
			blip = {
				sprite = 431,
				scale = 1.2,
				colour = 3,
				flashes = true,
				text = incident.type,
				time = (60 * 1000),
				sound = 1,
			},
		})
	end

	if integrations["codem-dispatch"] then
		hasSentAlert = true
		TriggerClientEvent(("%s:utils:integration"):format(Server.resourceName), -1, "codeM", {
			coords = vector3(incident.data.pos.x, incident.data.pos.y, incident.data.pos.z),
			header = incident.description,
			description = incident.description,
			type = incident.type,
		})
	end

	if integrations["night_shifts"] then
		hasSentAlert = true
		TriggerClientEvent(("%s:utils:integration"):format(Server.resourceName), -1, "nightShifts", {
			true, -- Is it an emergency?
			false, -- Is police required?
			false, -- Is ambulance required?
			true, -- Is fire required?
			false, -- Is tow required?
			incident.description, -- Call description
			"System", -- Caller name
			vector3(incident.data.pos.x, incident.data.pos.y, incident.data.pos.z), -- Coordinates
			"E-Mail", -- Contact details
		})
	end

	if integrations["commandControl"] then
		hasSentAlert = true
		exports["CommandControl-Main"]:createCAD(0, {
			description = incident.description,
			location = incident.location,
		}, function(err, cadId)
			if err == 200 then
				return
			end
			Server.warnServer(("Error creating CAD with commandControl: %s"):format(err))
		end)
	end

	if integrations["ps-dispatch"] then
		hasSentAlert = true
		TriggerEvent("dispatch:server:notify", {
			dispatchcodename = "bankrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
			dispatchCode = "10-90",
			firstStreet = incident.location,
			gender = nil,
			camId = nil,
			model = nil,
			plate = nil,
			priority = 2,
			firstColor = nil,
			automaticGunfire = false,
			origin = {
				x = incident.data.pos.x,
				y = incident.data.pos.y,
				z = incident.data.pos.z,
			},
			dispatchMessage = incident.description,
			job = { "fire" },
		})
	end

	if integrations["infernoStationAlert"] then
		hasSentAlert = true
		exports["inferno-station-alert"]:newAlertNearestStationWithPlayers(
			vector3(incident.data.pos.x, incident.data.pos.y, incident.data.pos.z),
			{
				["message"] = "-station-, " .. incident.location .. ", " .. incident.description,
				["unitColors"] = { "red" },
			}
		)
	end

	if integrations["lb-tablet"] then
		hasSentAlert = true
		exports["lb-tablet"]:AddDispatch({
			priority = "high",
			code = "code",
			title = "New Fire Incident!",
			description = incident.description,
			time = 9999,
			job = "fire",
			location = {
				label = incident.location,
				coords = vector2(incident.data.pos.x, incident.data.pos.y),
			},
		})
	end

	local members = Init.dutyTable[incident.data.dept] and Init.dutyTable[incident.data.dept].members or {}

	if incidents.dutyAlerts.maintainNotification then
		hasSentAlert = false
	end
	for user, data in pairs(members) do
		if not data then
			return
		end

		TriggerClientEvent("z_fire:return:newIncident", user, incident, hasSentAlert)
	end
end

Bridge.newIncident = new_incident
