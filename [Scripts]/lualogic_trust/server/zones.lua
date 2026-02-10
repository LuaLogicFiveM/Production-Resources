--[[
local config = require 'config'
local zonePermissions = not config.zones.enabled or {}

function zoneCheck(source, action)
	local zoneData = zonePermissions[source]

	if zoneData then
		print('zoneData')
		local zoneDataAction = zoneData[action]
		local playerJob = GetJob(source)

		print(playerJob and zoneDataAction and playerJob.grade >= zoneDataAction)
		return playerJob and zoneDataAction and playerJob.grade >= zoneDataAction
	end

	return zonePermissions == true or false
end

function zonePermissionData(source)
	return zonePermissions[source] or zonePermissions == true
end

RegisterNetEvent('lualogic_trust:server:zone', function(type, zoneId)
	if not type or not config.zones.permissions.enabled then return end
	local source = source
	local playerJob = GetJob(source)
	local permData = playerJob and config.zones.permissions[zoneId] and config.zones.permissions[zoneId][playerJob.name]

	if type == 'enter' then
		if permData then
			zonePermissions[source] = permData
		end
	elseif type == 'exit' then
		if zonePermissions[source] then
			zonePermissions[source] = nil
		end
	end
end)

AddEventHandler('playerDropped', function()
    zonePermissions[source] = nil
end)
]]

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