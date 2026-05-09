local activeStorages = {}

local storageLocations = {}

AddEventHandler('prp-horde:server:startup', function()
    for k, v in pairs(svConfig.interiors) do
        if v.storageCoords then
            storageLocations[v.key] = {
                model = v.storageModel,
                coords = v.storageCoords,
                rotation = v.storageRotation,
            }
        end
    end

    setupDone('storageLocations')
end)

function removeStorage(storageKey)
    if not storageKey then
        return
    end

    local storage = activeStorages[storageKey]

    if not storage then
        return
    end

    bridge.inv.removeHooks(storage.inventoryHookId)
    bridge.inv.clearInventory(storage.inventoryId)

    activeStorages[storageKey] = nil
end

function addStorage(interiorKey, groupId, items)
    local storageKey = ('%s-%s'):format(interiorKey, groupId)

    if activeStorages[storageKey] then
        removeStorage(storageKey)
    end


    local inventoryId = bridge.inv.createTemporaryStash({
        label = locale('HORDE_STORAGE'),
        slots = 100,
        maxWeight = 500,
        items = items,
    })

    local inventoryHookId = bridge.inv.registerSwapItemsHook(function(payload)
        if payload.action ~= "move" then return false end

        return payload.fromInventory == inventoryId
    end, {
        inventoryFilter = { inventoryId }
    })

    local group = exports['prp-bridge']:GetGroupByUuid(groupId)
    local identifiers = {}
    
    if group then
        for _, member in pairs(group.getMembers()) do
            table.insert(identifiers, member.identifier)
        end
    end

    activeStorages[storageKey] = {
        stateIds = identifiers,
        openedStateIds = {},
        inventoryId = inventoryId,
        inventoryHookId = inventoryHookId,
        expiresAt = os.time() + (60 * 10),
    }
end

RegisterNetEvent('prp-horde:server:openStorage', function(id)
    local playerId = tonumber(source)
    if not playerId then return end

    if not storageLocations[id] then
        return
    end

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)
    if not groupId then
        bridge.fw.notify(playerId, 'error', locale('GROUP_NEEDED'))
        return
    end

    local game = getGameByGroupId(groupId)

    if game then
        if not game.finished then
            bridge.fw.notify(playerId, 'error', locale('STORAGE_AVAILABLE_AFTER_GAME'))
            return
        end

        local message = locale('STORAGE_AVAILABLE_ANY_SECOND')

        local secondsLeft = game.timeoutAt - os.time()

        if secondsLeft > 1 then
            message = locale('STORAGE_AVAILABLE_IN', secondsLeft)
        end

        bridge.fw.notify(playerId, 'error', message)

        return
    end

    local storageKey = ('%s-%s'):format(id, groupId)

    local storage = activeStorages[storageKey]

    if not storage then
        bridge.fw.notify(playerId, 'error', locale('STORAGE_MISSING'))
        return
    end

    if os.time() > storage.expiresAt then
        bridge.fw.notify(playerId, 'error', locale('STORAGE_EXPIRED'))
        return
    end

    local stateId = bridge.fw.getIdentifier(playerId)

    if not storage.openedStateIds[stateId] then
        storage.openedStateIds[stateId] = true
    end

    bridge.inv.openStash(playerId, storage.inventoryId)
end)

local function notifyNotOpened(secondsLeft, stateIds, openedStateIds)
    local minutes = math.floor(secondsLeft / 60)

    if minutes > 9 or minutes < 1 then
        return
    end

    local minuteString = minutes == 1 and locale('MINUTE') or locale('MINUTES')

    local message = locale('STORAGE_EXPIRING', minutes, minuteString)

    for k, stateId in pairs(stateIds) do
        if not openedStateIds[stateId] then
            local playerId = bridge.fw.getSrcFromIdentifier(stateId)

            if playerId and DoesPlayerExist(playerId) then
                bridge.fw.notify(playerId, 'error', message)
            end
        end
    end
end

local function storageTick()
    local timeNow = os.time()

    for k, v in pairs(activeStorages) do
        if timeNow > v.expiresAt then
            removeStorage(k)
        else
            notifyNotOpened((v.expiresAt - timeNow), v.stateIds, v.openedStateIds)
        end
    end
end

CreateThread(function()
    while true do
        Wait(1000 * 60)

        local success, exception = pcall(function()
            storageTick()
        end)

        if not success then
            lib.print.debug('STORAGE TICK LOOP FAILED!', exception)
        end
    end
end)

function getStorageLocations()
    return storageLocations
end
