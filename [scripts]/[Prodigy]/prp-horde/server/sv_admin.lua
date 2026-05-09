local adminsEditing = {}

---- STASHES/DROPS
local function insertStash(interiorKey, x, y, z)
    return MySQL.insert.await('INSERT INTO horde_stashes (interiorKey, x, y, z) VALUES (?, ?, ?, ?)', {interiorKey, x, y, z})
end

local function deleteStash(id)
    return MySQL.insert.await('DELETE FROM horde_stashes WHERE id = ?', {id})
end

local function addStash(interiorKey, coords)
    local newId = insertStash(interiorKey, coords.x, coords.y, coords.z)

    for playerId, key in pairs(adminsEditing) do
        if key == interiorKey then
            TriggerClientEvent('prp-horde:client:adminAddStash', playerId, newId, coords)
        end
    end
end

local function removeStash(id)
    deleteStash(id)

    for playerId, key in pairs(adminsEditing) do
        TriggerClientEvent('prp-horde:client:adminDeleteStash', playerId, id)
    end
end

---- NPC SPAWNS
local function insertSpawn(interiorKey, x, y, z, w)
    return MySQL.insert.await('INSERT INTO horde_spawns (interiorKey, x, y, z, w) VALUES (?, ?, ?, ?, ?)', {interiorKey, x, y, z, w})
end

local function deleteSpawn(id)
    return MySQL.insert.await('DELETE FROM horde_spawns WHERE id = ?', {id})
end

local function addSpawn(interiorKey, coords, heading)
    local newId = insertSpawn(interiorKey, coords.x, coords.y, coords.z, heading)

    for playerId, key in pairs(adminsEditing) do
        if key == interiorKey then
            TriggerClientEvent('prp-horde:client:adminAddSpawn', playerId, newId, coords, heading)
        end
    end
end

local function removeSpawn(id)
    deleteSpawn(id)

    for playerId, key in pairs(adminsEditing) do
        TriggerClientEvent('prp-horde:client:adminDeleteSpawn', playerId, id)
    end
end

---- OBJECTS
local function insertObject(interiorKey, model, x, y, z, rx, ry, rz)
    return MySQL.insert.await('INSERT INTO horde_objects (interiorKey, model, x, y, z, rx, ry, rz) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {interiorKey, model, x, y, z, rx, ry, rz})
end

local function deleteObject(id)
    return MySQL.insert.await('DELETE FROM horde_objects WHERE id = ?', {id})
end

local function addObject(interiorKey, model, coords, rotation)
    local newId = insertObject(interiorKey, model, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z)

    for playerId, key in pairs(adminsEditing) do
        if key == interiorKey then
            TriggerClientEvent('prp-horde:client:adminAddObject', playerId, newId, model, coords, rotation)
        end
    end
end

local function removeObject(id)
    deleteObject(id)

    for playerId, key in pairs(adminsEditing) do
        TriggerClientEvent('prp-horde:client:adminDeleteObject', playerId, id)
    end
end

function editModeToggle(playerId)
    if adminsEditing[playerId] then
        adminsEditing[playerId] = nil
        TriggerClientEvent('prp-horde:client:adminAddStashModeOff', playerId)
        return
    end

    local locations = {}

    for k, v in pairs(svConfig.interiors) do
        table.insert(locations, {
            title = ('%s (%s)'):format(v.name, v.key),
            description = v.hardMode and 'Click to edit (hard mode)' or 'Click to edit',
            serverEvent = 'prp-horde:server:adminEditMode',
            args = v.key,
        })
    end

    TriggerClientEvent('prp-horde:client:adminMenu', playerId, locations)
end

RegisterNetEvent('prp-horde:server:adminEditMode', function(interiorKey)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    if adminsEditing[playerId] then
        TriggerClientEvent('prp-horde:client:adminAddStashModeOff', playerId)
        Wait(1000)
    end

    adminsEditing[playerId] = interiorKey

    local stashes = MySQL.query.await('SELECT * FROM horde_stashes WHERE interiorKey = ?', {interiorKey})

    local spawns = MySQL.query.await('SELECT * FROM horde_spawns WHERE interiorKey = ?', {interiorKey})

    local objects = MySQL.query.await('SELECT * FROM horde_objects WHERE interiorKey = ?', {interiorKey})

    local hardMode = false
    for k, v in pairs(svConfig.interiors) do
        if v.key == interiorKey and v.hardMode then
            TriggerClientEvent('prp-horde:client:teleport', playerId, v.insideCoords)
            hardMode = true
        elseif v.key == interiorKey then
            TriggerClientEvent('prp-horde:client:teleport', playerId, v.insideCoords)
        end
    end

    TriggerClientEvent('prp-horde:client:adminAddStashModeOn', playerId, stashes, spawns, objects, hardMode)
end)

RegisterNetEvent('prp-horde:server:adminAddStash', function(coords)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    local interiorKey = adminsEditing[playerId]

    if not interiorKey then
        return
    end

    addStash(interiorKey, coords)
end)

RegisterNetEvent('prp-horde:server:adminRemoveStash', function(id)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    removeStash(id)
end)

RegisterNetEvent('prp-horde:server:adminAddSpawn', function(coords, heading)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    local interiorKey = adminsEditing[playerId]

    if not interiorKey then
        return
    end

    addSpawn(interiorKey, coords, heading)
end)

RegisterNetEvent('prp-horde:server:adminRemoveSpawn', function(id)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    removeSpawn(id)
end)

RegisterNetEvent('prp-horde:server:adminAddObject', function(model, coords, rotation)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    local interiorKey = adminsEditing[playerId]

    if not interiorKey then
        return
    end

    addObject(interiorKey, model, coords, rotation)
end)

RegisterNetEvent('prp-horde:server:adminRemoveObject', function(id)
    local playerId = tonumber(source)
    if not playerId then return end

    if not isAdmin(playerId) then
        return
    end

    removeObject(id)
end)
