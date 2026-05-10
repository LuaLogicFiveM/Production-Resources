local config = require 'config'
local zonePermissions = not config.zones.enabled or {}

function zoneCheck(source, action)
	local zoneData = zonePermissions[source]

	if zoneData then
		local zoneDataAction = zoneData[action]
		local playerJob = GetJob(source)

		return playerJob and zoneDataAction and (zoneDataAction == true or (zoneDataAction ~= false and playerJob.grade >= zoneDataAction) or zoneDataAction == true) or false
	end

	return zonePermissions == true or false
end

function zonePermissionData(source)
	return zonePermissions == true or zonePermissions[source] or false
end

RegisterNetEvent('lualogic_trust:server:zone', function(type, zoneId)
	if not type or not zoneId or not config.zones.locations[zoneId] then return end
	local source = source
	local playerJob = GetJob(source)
	local permData = playerJob and config.zones.locations[zoneId] and (config.zones.locations[zoneId].permissions[playerJob.name] or config.zones.locations[zoneId].permissions['default'])

	print(source, type, zoneId, permData)

	if type == 'enter' then
		print(permData, zonePermissions[source])
		if permData then
			zonePermissions[source] = permData
		end
	elseif type == 'exit' then
		print(permData, zonePermissions[source])
		if zonePermissions[source] then
			zonePermissions[source] = nil
		end
	end
end)

AddEventHandler('playerDropped', function()
	if zonePermissions[source] then
    	zonePermissions[source] = nil
	end
end)


function IsInZone(source, zones)
	if not config.zones.enabled then
		return true
	end

	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	local playerJob = GetJob(source)

	if playerJob then
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
	end

	return false
end