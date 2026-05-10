local function isAdmin()
    return lib.callback.await('lorp_events:isAdmin', 2000)
end

local function openEventMenu()
    if not isAdmin() then
        lib.notify({ title = 'Event', description = "You don't have permission.", type = 'error' })
        return
    end

    local options = {
        {
            title = 'Pre-made Events',
            onSelect = function()
                local eventOptions = {}
                for i, event in ipairs(Config.CustomEvents) do
                    table.insert(eventOptions, {
                        title = event.name,
                        description = string.format('Start %s', event.name),
                        onSelect = function()
                            TriggerServerEvent('lorp_events:startPreConfigured', i)
                        end
                    })
                end
                
                lib.registerContext({
                    id = 'preconfigured_events',
                    title = 'Custom Events',
                    menu = 'event_root',
                    options = eventOptions
                })
                lib.showContext('preconfigured_events')
            end
        },
        {
            title = 'Create Custom Event',
            onSelect = function()
                local input = lib.inputDialog('Create Custom Event', {
                    { type = 'input', label = 'Event Title', required = true, placeholder = 'My Custom Event' }
                })
                if not input then return end
                
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local heading = GetEntityHeading(ped)
                
                TriggerServerEvent('lorp_events:startCustom', {
                    title = input[1],
                    coords = { x = coords.x, y = coords.y, z = coords.z, h = heading }
                })
            end
        }
    }

    lib.registerContext({
        id = 'event_root',
        title = 'Event Manager',
        options = options
    })
    lib.showContext('event_root')
end

RegisterCommand('event', function()
    openEventMenu()
end, false)

RegisterCommand('eventend', function()
    if isAdmin() then
        TriggerServerEvent('lorp_events:endEvent')
    else
        lib.notify({ title = 'Event', description = "You don't have permission.", type = 'error' })
    end
end, false)

RegisterCommand('eventjoin', function()
    TriggerServerEvent('lorp_events:requestJoin')
end, false)

local function showEventNotification(data)
    SendNUIMessage({
        action = "setVisible",
        data = true
    })
    SendNUIMessage({
        action = "showEventNotification",
        data = {
            eventName = data.title,
            eventMessage = "An event has started: " .. data.title,
            joinCommand = "/eventjoin",
            showJoinInstruction = true
        }
    })
    SendNUIMessage({
        action = "playAnnouncementSound"
    })
    SetNuiFocus(false, false)
end

local function showEventEndedNotification()
    SendNUIMessage({
        action = "setVisible",
        data = true
    })
    SendNUIMessage({
        action = "showEventEndedNotification"
    })
end

local function hideAllNotifications()
    SendNUIMessage({
        action = "hideAllNotifications"
    })
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
    SetNuiFocus(false, false)
end

RegisterNetEvent('lorp_events:announce', function(data)
    showEventNotification(data)
end)

RegisterNetEvent('lorp_events:eventEnded', function()
    showEventEndedNotification()
end)

RegisterNetEvent('lorp_events:clearUI', function()
    hideAllNotifications()
end)

RegisterNetEvent('lorp_events:notify', function(msg)
    lib.notify({ title = 'Event', description = msg, type = 'inform' })
end)

local spawnedRaceCars = {}
local lastEventId = nil

RegisterNetEvent('lorp_events:spawnAllRaceCars', function(eventData)
    if lastEventId == eventData.eventId then return end
    lastEventId = eventData.eventId

    for _, vehicle in pairs(spawnedRaceCars) do
        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
    spawnedRaceCars = {}

    for i, carData in ipairs(eventData.cars) do
        RequestModel(carData.model)
        while not HasModelLoaded(carData.model) do
            Wait(0)
        end

        local vehicle = CreateVehicle(carData.model, carData.x, carData.y, carData.z, carData.h, true, false)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleEngineOn(vehicle, false, true, false)
        SetVehicleUndriveable(vehicle, false)

        spawnedRaceCars[i] = vehicle
        SetModelAsNoLongerNeeded(carData.model)
    end
end)

RegisterNetEvent('lorp_events:cleanupRaceCars', function()
    for _, vehicle in pairs(spawnedRaceCars) do
        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
    spawnedRaceCars = {}
    lastEventId = nil
end)

RegisterNetEvent('lorp_events:teleportToEvent', function(eventData)
    local coords = eventData.coords or eventData.startingCoords
    local allowInVehicle = eventData.allowInVehicle or false

    if eventData.type == "Race" and eventData.carSpawn then
        coords = eventData.carSpawn
    end

    if not allowInVehicle and cache.vehicle then
        lib.notify({ title = 'Event', description = 'Exit your vehicle before joining.', type = 'error' })
        return
    end

    if Config.FadeTeleport then
        DoScreenFadeOut(300)
        Wait(400)
    end

    if eventData.type == "Race" and eventData.carSpawnIndex and spawnedRaceCars[eventData.carSpawnIndex] then
        local raceCar = spawnedRaceCars[eventData.carSpawnIndex]
        if DoesEntityExist(raceCar) then
            StartPlayerTeleport(cache.playerId, coords.x, coords.y, coords.z + Config.TeleportZOffset, coords.h, false, true, true)

            while IsPlayerTeleportActive() do
                Citizen.Wait(0)
            end

            lib.notify({ title = 'Event', description = 'You have joined the event.', type = 'success' })

            SetPedIntoVehicle(cache.ped, raceCar, -1)
            SetVehicleEngineOn(raceCar, true, true, false)
        else
            StartPlayerTeleport(cache.playerId, coords.x, coords.y, coords.z + Config.TeleportZOffset, coords.h, false, true, true)

            while IsPlayerTeleportActive() do
                Citizen.Wait(0)
            end

            lib.notify({ title = 'Event', description = 'You have joined the event.', type = 'success' })
        end
    else
        if cache.vehicle and allowInVehicle then
            StartPlayerTeleport(cache.playerId, coords.x, coords.y, coords.z + Config.TeleportZOffset, coords.h, false, true, true)

            while IsPlayerTeleportActive() do
                Citizen.Wait(0)
            end

            lib.notify({ title = 'Event', description = 'You have joined the event.', type = 'success' })

            SetEntityCoordsNoOffset(cache.vehicle, coords.x, coords.y, coords.z + Config.TeleportZOffset, false, false, false)
            SetEntityHeading(cache.vehicle, coords.h)
        else
            StartPlayerTeleport(cache.playerId, coords.x, coords.y, coords.z + Config.TeleportZOffset, coords.h, false, true, true)

            while IsPlayerTeleportActive() do
                Citizen.Wait(0)
            end

            lib.notify({ title = 'Event', description = 'You have joined the event.', type = 'success' })
        end
    end

    if Config.FadeTeleport then 
        DoScreenFadeIn(300) 
    end

    if eventData.type == "Race" and eventData.finishCoords then
        SetNewWaypoint(eventData.finishCoords.x, eventData.finishCoords.y)
        lib.notify({ title = 'Race Event', description = 'GPS set to finish line!', type = 'success' })
    end

    SendNUIMessage({
        action = "hideMainEventNotification"
    })
end)

RegisterNetEvent('lorp_events:returnToOriginal', function(coords)
    if Config.FadeTeleport then
        DoScreenFadeOut(300)
        Wait(400)
    end

    if cache.vehicle then
        TaskLeaveVehicle(cache.ped, cache.vehicle, 16)
        Wait(400)
    end

    StartPlayerTeleport(cache.playerId, coords.x, coords.y, coords.z + Config.TeleportZOffset, coords.h, false, true, true)

    while IsPlayerTeleportActive() do
        Citizen.Wait(0)
    end

    TriggerServerEvent('lorp_events:healPlayer')
    ClearPedBloodDamage(cache.ped)

    if Config.FadeTeleport then
        DoScreenFadeIn(300)
    end
end)

RegisterNetEvent('lorp_events:savePosition', function()
    local coords = GetEntityCoords(cache.ped)
    local heading = GetEntityHeading(cache.ped)
    TriggerServerEvent('lorp_events:savePlayerPosition', { 
        x = coords.x, 
        y = coords.y, 
        z = coords.z, 
        h = heading 
    })
end)
