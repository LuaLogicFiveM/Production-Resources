function IsAllowed_features(source, perm)
    local job = GetJobName(source)
    local perms = Config.Perms[perm][job]
    if not perms then return false end
    return HasJob(source, perms)
end

function SortNotificationCoords(coords, blip)
	local coords = {x = coords.x, y = coords.y, z = coords.z}
    if blip and type(blip.radius) == 'number' and blip.radius > 0 then
        if math.random(1, 2) == 1 then
            coords.x = coords.x + math.random(1, blip.radius)
        else
            coords.x = coords.x - math.random(1, blip.radius)
        end

        if math.random(1, 2) == 1 then
            coords.y = coords.y + math.random(1, blip.radius)
        else
            coords.y = coords.y - math.random(1, blip.radius)
        end
    end

    return {x = coords.x, y = coords.y, z = coords.z}
end

RegisterServerEvent('cd_dispatch:UnloadPlayer', function()
    PlayerDropped(source)
end)

RegisterServerEvent('esx:cd_multicharacter:SwitchCharacter', function(src)
	local source = (source ~= nil and source ~= '') and source or src
	PlayerDropped(source)
end)

RegisterServerEvent('cd_vipshop:CharacterNameChanged', function(new_name, src)
	local source = (source ~= nil and source ~= '') and source or src

	if AllPlayers and AllPlayers[source] then
        AllPlayers[source].char_name = new_name
        PlayerBlipsActions(source, 'update')
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    PlayerDropped(src)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        if Config.HeatMap.ENABLE then
            SaveHeatMapCache()
        end
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    if Config.HeatMap.ENABLE then
        SaveHeatMapCache()
    end
end)