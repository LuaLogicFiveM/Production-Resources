local currentEvent = nil
local playerPositions = {}
local recentJoins = {}
local usedCarSpawns = {}

local function isAdmin(src)
    local roles = exports.lorp_discord_api:GetUserRoles(src)

    for roleId, _ in pairs(Config.Permissions) do
        if roles[roleId] then
            return true
        end
    end

    return false
end

local function announceEvent()
    if not currentEvent then return end
    TriggerClientEvent('lorp_events:announce', -1, {
        title = currentEvent.title,
        message = currentEvent.message
    })
end

lib.callback.register('lorp_events:isAdmin', function(source)
    return isAdmin(source)
end)

RegisterNetEvent('lorp_events:startPreConfigured', function(eventIndex)
    local src = source
    if not isAdmin(src) then
        TriggerClientEvent('lorp_events:notify', src, "You don't have permission.")
        return
    end
    
    local event = Config.CustomEvents[eventIndex]
    if not event then
        TriggerClientEvent('lorp_events:notify', src, "Invalid event selection.")
        return
    end
    
    currentEvent = {
        title = event.title,
        message = event.message,
        type = event.type or "Default",
        coords = event.coords,
        startingCoords = event.startingCoords,
        finishCoords = event.finishCoords,
        allowInVehicle = event.allowInVehicle or false,
        carSpawnLocations = event.carSpawnLocations,
        startedBy = src,
        participants = {},
        expiresAt = Config.EventExpiresMinutes > 0 and (os.time() + (Config.EventExpiresMinutes * 60)) or nil
    }
    
    if currentEvent.type == "Race" and currentEvent.carSpawnLocations then
        TriggerClientEvent('lorp_events:cleanupRaceCars', -1)
        Wait(500)
        
        local carData = {}
        for i, carSpawn in ipairs(currentEvent.carSpawnLocations) do
            table.insert(carData, {
                x = carSpawn.coords.x,
                y = carSpawn.coords.y, 
                z = carSpawn.coords.z,
                h = carSpawn.coords.w,
                model = carSpawn.model
            })
        end
        
        TriggerClientEvent('lorp_events:spawnAllRaceCars', -1, {
            cars = carData,
            eventId = os.time()
        })
        usedCarSpawns = {}
    end
    
    announceEvent()
end)

RegisterNetEvent('lorp_events:startCustom', function(data)
    local src = source
    if not isAdmin(src) then
        TriggerClientEvent('lorp_events:notify', src, "You don't have permission.")
        return
    end
    
    if not data.title or not data.coords then
        TriggerClientEvent('lorp_events:notify', src, "Missing event data.")
        return
    end
    
    currentEvent = {
        title = data.title,
        message = "An event has started: " .. data.title,
        type = "Default",
        coords = data.coords,
        allowInVehicle = false,
        startedBy = src,
        participants = {},
        expiresAt = Config.EventExpiresMinutes > 0 and (os.time() + (Config.EventExpiresMinutes * 60)) or nil
    }
    
    announceEvent()
end)

RegisterNetEvent('lorp_events:endEvent', function()
    local src = source
    if not isAdmin(src) then
        TriggerClientEvent('lorp_events:notify', src, "You don't have permission.")
        return
    end
    
    if not currentEvent then
        TriggerClientEvent('lorp_events:notify', src, "No active event to end.")
        return
    end
    
    for playerId, _ in pairs(currentEvent.participants) do
        if GetPlayerName(playerId) then
            local originalPos = playerPositions[playerId]
            if originalPos then
                TriggerClientEvent('lorp_events:returnToOriginal', playerId, originalPos)
            end
        end
    end
    
    TriggerClientEvent('lorp_events:cleanupRaceCars', -1)
    
    currentEvent = nil
    playerPositions = {}
    usedCarSpawns = {}
    
    TriggerClientEvent('lorp_events:eventEnded', -1)
end)

RegisterNetEvent('lorp_events:requestJoin', function()
    local src = source
    if not GetPlayerName(src) then return end
    
    if not currentEvent then
        TriggerClientEvent('lorp_events:notify', src, "No active event right now.")
        return
    end

    if currentEvent.expiresAt and os.time() > currentEvent.expiresAt then
        currentEvent = nil
        TriggerClientEvent('lorp_events:notify', src, "The event has expired.")
        TriggerClientEvent('lorp_events:clearUI', -1)
        return
    end

    local now = os.time()
    if (recentJoins[src] or 0) > now then
        local left = recentJoins[src] - now
        TriggerClientEvent('lorp_events:notify', src, string.format("Please wait %ds before joining again.", left))
        return
    end
    recentJoins[src] = now + Config.JoinCooldown
    
    TriggerClientEvent('lorp_events:savePosition', src)
    currentEvent.participants[src] = true
    
    local teleportData = {
        coords = currentEvent.coords and {
            x = currentEvent.coords.x,
            y = currentEvent.coords.y,
            z = currentEvent.coords.z,
            h = currentEvent.coords.w
        } or nil,
        startingCoords = currentEvent.startingCoords and {
            x = currentEvent.startingCoords.x,
            y = currentEvent.startingCoords.y,
            z = currentEvent.startingCoords.z,
            h = currentEvent.startingCoords.w
        } or nil,
        finishCoords = currentEvent.finishCoords and {
            x = currentEvent.finishCoords.x,
            y = currentEvent.finishCoords.y,
            z = currentEvent.finishCoords.z,
            h = currentEvent.finishCoords.w
        } or nil,
        type = currentEvent.type,
        allowInVehicle = currentEvent.allowInVehicle
    }
    
    if currentEvent.type == "Race" and currentEvent.carSpawnLocations then
        local availableSpawns = {}
        for i, spawn in ipairs(currentEvent.carSpawnLocations) do
            if not usedCarSpawns[i] then
                table.insert(availableSpawns, {
                    index = i, 
                    spawn = {
                        x = spawn.coords.x,
                        y = spawn.coords.y,
                        z = spawn.coords.z,
                        h = spawn.coords.w,
                        model = spawn.model
                    }
                })
            end
        end
        
        if #availableSpawns > 0 then
            local selectedSpawn = availableSpawns[math.random(#availableSpawns)]
            usedCarSpawns[selectedSpawn.index] = src
            teleportData.carSpawn = selectedSpawn.spawn
            teleportData.carSpawnIndex = selectedSpawn.index
        end
    end
    
    TriggerClientEvent('lorp_events:teleportToEvent', src, teleportData)
end)

RegisterNetEvent('lorp_events:savePlayerPosition', function(pos)
    local src = source
    if not GetPlayerName(src) then return end
    
    playerPositions[src] = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        h = pos.h
    }
end)

RegisterNetEvent('lorp_events:healPlayer', function()
    local src = source
    if not GetPlayerName(src) then return end

    TriggerServerEvent('ak47_ambulancejob:revive', src)
end)

AddEventHandler('playerDropped', function()
    local src = source
    recentJoins[src] = nil
    playerPositions[src] = nil
    if currentEvent and currentEvent.participants then
        currentEvent.participants[src] = nil
    end
end)

