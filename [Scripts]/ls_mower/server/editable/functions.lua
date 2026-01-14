local playerExp = {}

function SetExperience(playerId, experience)
    local identifier = GetIdentifier(playerId)
    local query = "UPDATE ls_extra SET data = @experience WHERE player = @player AND tag = @tag"
    local values = {
        ["experience"] = experience,
        ["player"] = identifier,
        ["tag"] = "ls_mower:exp"
    }
    sqlInsert(query, values)

    -- Update the player's level based on their new experience value
    
    playerExp[identifier] = experience
end

RegisterServerEvent('ls_mower:server:setVehPlate')
AddEventHandler('ls_mower:server:setVehPlate', function (vehicles)
    
    for _, veh in pairs(vehicles) do
        CustomPlates(NetworkGetEntityFromNetworkId(veh))
    end
end)

function CustomPlates(vehicle)
    if vehicle ~= nil then
        local plateText = "CUT" .. math.random(0, 999)
        SetVehicleNumberPlateText(vehicle, plateText)
    end
end

function AddExperience(playerId, experienceToAdd)
    local identifier = GetIdentifier(playerId)
    local query = "SELECT * from ls_extra where player = @player and tag = @tag"
    local values = {
        ["player"] = identifier,
        ["tag"] = "ls_mower:exp"
    }
    local data = sqlFetch(query, values)

    if #data > 0 then
        local currentXP = tonumber(data[1].data)
        local newXP = currentXP + experienceToAdd
        SetExperience(playerId, newXP)
    end
end



function sqlFetch(query, data)
    if Config.sqlDriver  == 'mysql' then
        return MySQL.Sync.fetchAll(query, data or {})
    end

    if Config.sqlDriver  == 'oxmysql' then

        return exports[Config.sqlDriver]:query_async(query, data)
    else
        return exports[Config.sqlDriver]:executeSync(query, data)
    end
end

function sqlInsert(query, data)
    if Config.sqlDriver == 'mysql' then
        MySQL.Sync.insert(query, data)
        return
    end

    if Config.sqlDriver == 'oxmysql' then
        exports[Config.sqlDriver]:insertSync(query, data)
    else
        exports[Config.sqlDriver]:executeSync(query, data)
    end
end

function clampMax(value, max)
    if max and value > max then
        return max
    end
    return value
end

function GetIdentifier(player)
    local identifier = GetPlayerIdentifiers(player)[1]:gsub(":", "")
    if Config.alternativeIdentifier.enabled then
        for k,v in pairs(GetPlayerIdentifiers(player))do
            if string.sub(v, 1, string.len(Config.alternativeIdentifier.identifier)) == Config.alternativeIdentifier.identifier then
                identifier = v:gsub(":", "")
            end
        end
    end
    return identifier 
end

function DeleteVehiclesProperly(mower, truck, trailer)
    --print(mower,truck,trailer) -- all 3 vehicles networked identifiers
end

