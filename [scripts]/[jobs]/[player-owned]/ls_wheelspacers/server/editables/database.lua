function sqlFetch(query, data)
    if Config.sqlDriver == 'mysql' then
        return MySQL.Sync.fetchAll(query, data or {})
    end

    if Config.sqlDriver == 'oxmysql' then
        if Config.oldOxmysql then
            return exports[Config.sqlDriver]:fetchSync(query, data)
        end
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

--save:

function SaveCar(vehicleNetId, vehicle, wheel1, wheel2, wheel3, wheel4, wheel1Offset, wheel2Offset, wheel3Offset, wheel4Offset, bone1Coords, bone2Coords, bone3Coords, bone4Coords, spacerProp1, spacerProp2, spacerProp3, spacerProp4)
    local _source = source
    local identifier = _source

    local query1 = "SELECT * from ls_extra WHERE tag = @tag"
    local values1 = {
        ["tag"] = "ls_wheelspacers:" .. vehicle
    }
    table.insert(CAR_TABLE,{vehicle = vehicle, wheel1 = wheel1, wheel2 = wheel2, wheel3 = wheel3, wheel4 = wheel4, wheel1Offset = wheel1Offset, wheel2Offset = wheel2Offset, wheel3Offset = wheel3Offset, wheel4Offset = wheel4Offset, bone1Coords = bone1Coords, bone2Coords = bone2Coords, bone3Coords = bone3Coords, bone4Coords = bone4Coords, spacerProp1 = spacerProp1, spacerProp2 = spacerProp2, spacerProp3 = spacerProp3, spacerProp4 = spacerProp4})
    local currentData = sqlFetch(query1, values1)

    if #currentData > 0 then
        local query2 = 'Update ls_extra SET data = @data WHERE tag = @tag'
        local values2 = {
            ["data"] = json.encode({vehicle = vehicle, wheel1 = wheel1, wheel2 = wheel2, wheel3 = wheel3, wheel4 = wheel4, wheel1Offset = wheel1Offset, wheel2Offset = wheel2Offset, wheel3Offset = wheel3Offset, wheel4Offset = wheel4Offset, bone1Coords = bone1Coords, bone2Coords = bone2Coords, bone3Coords = bone3Coords, bone4Coords = bone4Coords, spacerProp1 = spacerProp1, spacerProp2 = spacerProp2, spacerProp3 = spacerProp3, spacerProp4 = spacerProp4}),
            ["tag"] = "ls_wheelspacers:" .. vehicle
        }

        sqlInsert(query2, values2)
    else
        local query2 = 'Insert INTO ls_extra (player, tag, data) VALUES (@player, @tag, @data)'

        local values2 = {
            ["data"] = json.encode({vehicle = vehicle, wheel1 = wheel1, wheel2 = wheel2, wheel3 = wheel3, wheel4 = wheel4, wheel1Offset = wheel1Offset, wheel2Offset = wheel2Offset, wheel3Offset = wheel3Offset, wheel4Offset = wheel4Offset, bone1Coords = bone1Coords, bone2Coords = bone2Coords, bone3Coords = bone3Coords, bone4Coords = bone4Coords, spacerProp1 = spacerProp1, spacerProp2 = spacerProp2, spacerProp3 = spacerProp3, spacerProp4 = spacerProp4}),
            ["player"] = identifier,
            ["tag"] = "ls_wheelspacers:" .. vehicle
        }

        sqlInsert(query2, values2)
    end
end

function RetrieveVehicleFromDatabase(vehicleLicense)
    local query = "SELECT * from ls_extra WHERE tag = @tag"
    local values = {
        ["tag"] = "ls_wheelspacers:" .. vehicleLicense
    }

    return sqlFetch(query, values)
end

function RetrieveDatabase()
    local query = 'SELECT * FROM ls_extra WHERE tag LIKE @tag'
    local values = {
        ["tag"] = 'ls_wheelspacers:%'
    }

    local data = {}

    data = sqlFetch(query, values)

    Citizen.Wait(1000)

    local newData = ConvertOldDataToNew(data)

    if #newData > 0 then
        return newData
    else
        return {}
    end
end

function ConvertOldDataToNew(baseData)
    local data = baseData
    local vehiclesToUpdate = {}

    for k, vehicleData in ipairs(baseData) do
        local vehicle = json.decode(vehicleData.data)
        local vehicleTag = vehicleData.tag
        local addedToUpdate = false

        for i = 1, 4, 1 do
            if vehicle['wheel' .. i] and vehicle['wheel' .. i].model then
                local index = GetSpacerIndexFromModel(vehicle['wheel' .. i].model)

                if index then
                    vehicle['wheel' .. i] = index

                    if not addedToUpdate then
                        table.insert(vehiclesToUpdate, vehicleTag)
                        addedToUpdate = true
                    end
                end
            end
        end

        data[k]['data'] = vehicle
    end

    return data
end

function GetSpacerIndexFromModel(modelName)
    for k, spacerData in pairs(Config.spacers) do
        if modelName == spacerData.model then
            return k
        end
    end

    return false
end

function GetPlayerIdentifier(player)
    local identifier
    for k, v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len(Config.identifier)) == Config.identifier then
            identifier = v:gsub(":", "")
        end
    end
    return identifier
end