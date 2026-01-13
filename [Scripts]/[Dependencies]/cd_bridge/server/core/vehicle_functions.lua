function GetAllPossiblePlates(plate)
    local results = {}
    local seen = {}

    local function add(p)
        if p and p ~= '' and not seen[p] then
            seen[p] = true
            table.insert(results, p)
        end
    end

    add(plate)

    local trimmed = plate:match('^%s*(.-)%s*$')
    add(trimmed)

    if #trimmed < 8 then
        add(GenerateSpacesInPlate(trimmed))
    end

    return results
end

-- If plate is a string, fetch all possible plates using GetAllPossiblePlates().
-- Use {plate} to check only that specific plate.
function IsVehicleOwned(plate)
    local plates = type(plate) == 'string' and GetAllPossiblePlates(plate) or plate
    if not plates or #plates == 0 then
        return false
    end

    local placeholders = {}
    for cd = 1, #plates do
        placeholders[cd] = '?'
    end

    local query = ('SELECT plate FROM %s WHERE plate IN (%s) LIMIT 1'):format(FW.vehicle_table, table.concat(placeholders, ','))

    local result = DB.fetch(query, plates)
    return result and result[1] ~= nil
end

-- If plate is a string, fetch all possible plates using GetAllPossiblePlates().
-- Use {plate} to check only that specific plate.
function DoesPlayerOwnVehicle(source, plate)
    local plates = type(plate) == 'string' and GetAllPossiblePlates(plate) or plate
    if not plates or #plates == 0 then
        return false
    end

    local placeholders = {}
    for cd = 1, #plates do
        placeholders[cd] = '?'
    end

    local query = ('SELECT plate FROM %s WHERE plate IN (%s) AND %s = ? LIMIT 1'):format(FW.vehicle_table, table.concat(placeholders, ','), FW.vehicle_owner)

    local params = plates
    params[#params + 1] = GetIdentifier(source)

    local result = DB.fetch(query, params)
    return result and result[1] ~= nil
end