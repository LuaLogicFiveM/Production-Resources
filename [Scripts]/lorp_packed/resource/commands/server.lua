-- Ped & Object Wipes
local function getNearbyEntities(entities, coords, maxDistance, isPed)
    local nearbyEntities = {}
    coords = type(coords) == "number" and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)
    for _, entity in pairs(entities) do
        if not isPed or (isPed and not IsPedAPlayer(entity)) then
			local entityCoords = GetEntityCoords(entity)
			if not maxDistance or #(coords - entityCoords) <= maxDistance then
				nearbyEntities[#nearbyEntities + 1] = NetworkGetNetworkIdFromEntity(entity)
			end
        end
    end

    return nearbyEntities
end

RegisterCommand('dvpeds', function(source, args, rawCommand)
	local src = source
	local Peds = getNearbyEntities(GetAllPeds(), GetEntityCoords(GetPlayerPed(src)), tonumber(args[1]) or 5.0)
	for i = 1, #Peds do
		local Ped = NetworkGetEntityFromNetworkId(Peds[i])
		if DoesEntityExist(Ped) then
			DeleteEntity(Ped)
		end
	end
end, true)

RegisterCommand('dvobjects', function(source, args, rawCommand)
	local src = source
	local Objects = getNearbyEntities(GetAllObjects(), GetEntityCoords(GetPlayerPed(src)), tonumber(args[1]) or 5.0)
	for i = 1, #Objects do
		local Object = NetworkGetEntityFromNetworkId(Objects[i])
		if DoesEntityExist(Object) then
			DeleteEntity(Object)
		end
	end
end, true)