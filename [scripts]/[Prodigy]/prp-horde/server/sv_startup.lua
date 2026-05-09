local setupKeys = {
    storageLocations = true,
}

local setupFinished = false

local locations = {}

queues = {
    normal = nil,
    hard = nil
}

hordeQueueDisabled = GetConvarBool('sv_horde_queue_disabled', false)
AddConvarChangeListener('sv_horde_queue_disabled', function(convarName)
    hordeQueueDisabled = GetConvarBool('sv_horde_queue_disabled', false)
end)

local queueAllowedStateIds = {}

local function getStartingData()
    return {
        storageLocations = getStorageLocations(),
    }
end

function setupDone(key)
    if setupFinished then
        return
    end

    setupKeys[key] = nil

    if next(setupKeys) then
        return
    end

    setupFinished = true

    TriggerClientEvent('prp-horde:client:receiveStartingData', -1, getStartingData())
end

RegisterNetEvent('prp-horde:server:requestStartingData', function()
    local playerId = tonumber(source)
    if not playerId then return end

    if not setupFinished then
        return
    end

    TriggerClientEvent('prp-horde:client:receiveStartingData', playerId, getStartingData())
end)

local function registerByppasCommand()
    if not config.bypassQueueCommand then return end

    bridge.fw.registerCommand(config.bypassQueueCommand, locale('BYPASS_COMMAND_HELPTEXT'), {
        {
            name = 'target',
            type = 'playerId',
            help = locale('BYPASS_COMMAND_PARAM_HELPTEXT'),
        },
    }, nil, function(source, args, raw)
        local playerId = tonumber(args.target)

        if not playerId then
            bridge.fw.notify(source, 'error', locale('BYPASS_COMMAND_INVALID_PLAYER'))
            return
        end

        if queueAllowedStateIds[playerId] then
            queueAllowedStateIds[playerId] = nil
            bridge.fw.notify(source, 'success', locale('BYPASS_COMMAND_REMOVED', playerId))
            return
        end

        queueAllowedStateIds[playerId] = true

        bridge.fw.notify(source, 'success', locale('BYPASS_COMMAND_ADDED', playerId))
    end)
end

local function sendLocations(source)
    TriggerClientEvent('prp-horde:client:startingLocations', source, locations)
end
RegisterNetEvent('prp-horde:server:requestStartingData', function()
    local playerId = tonumber(source)
    if not playerId then return end

    sendLocations(playerId)
end)

groundLootAttachedObjects = {}

local groundLootItemFilter = {}
for _, item in pairs(svConfig.groundLootItems) do
    groundLootItemFilter[item.id] = true
end

local function registerGroundLootObjects()
    for _, item in pairs(svConfig.groundLootItems) do
        exports["prp-bridge"]:RegisterObject({
            objectName = item.id,
            modelHash = item.animation.prop.hash,
            offset = item.animation.prop.position,
            rotation = item.animation.prop.rotation,
            boneId = item.animation.prop.bone,
            disableCollision = true,
            completelyDisableCollision = true,
        })
    end

    bridge.inv.registerSwapItemsHook(function(payload)
        local src = payload.source

        SetTimeout(0, function()
            local hasGroundLootItem = false
            local foundItemId = nil

            for _, item in pairs(svConfig.groundLootItems) do
                if bridge.inv.hasItem(src, item.id, 1) then
                    hasGroundLootItem = true
                    foundItemId = item.id
                    break
                end
            end

            if hasGroundLootItem and not groundLootAttachedObjects[src] then
                groundLootAttachedObjects[src] = exports["prp-bridge"]:CreateAttachObject(src, foundItemId)

                local itemData = nil
                for _, item in pairs(svConfig.groundLootItems) do
                    if item.id == foundItemId then
                        itemData = item
                        break
                    end
                end

                if itemData then
                    TriggerClientEvent("prp-horde:client:carryAnim", src, true, itemData.animation.dictionary, itemData.animation.animation)
                end
            elseif not hasGroundLootItem and groundLootAttachedObjects[src] then
                exports["prp-bridge"]:RemoveAttachObject(src, groundLootAttachedObjects[src])
                groundLootAttachedObjects[src] = nil
                TriggerClientEvent("prp-horde:client:carryAnim", src, false)
            end
        end)

        return true
    end, {
        itemFilter = groundLootItemFilter,
    })
end

AddEventHandler('playerDropped', function()
    groundLootAttachedObjects[source] = nil
end)

AddEventHandler('prp-horde:server:startup', function()
    registerGroundLootObjects()

    registerByppasCommand()

    if svConfig.startingNpc?.randomLocation then
        lib.print.debug('Choosing random starting NPC location')
        local randomCoords = svConfig.startingNpc.locations[math.random(1, #svConfig.startingNpc.locations)]

        locations[1] = {
            model = svConfig.startingNpc.models[math.random(1, #svConfig.startingNpc.models)],
            coords = randomCoords,
            scenario = svConfig.startingNpc.scenario,
            anim = svConfig.startingNpc.anim,
        }
    else
        lib.print.debug('Using all starting NPC locations')
        for _, coords in pairs(svConfig.startingNpc.locations) do
            locations[#locations + 1] = {
                model = svConfig.startingNpc.models[math.random(1, #svConfig.startingNpc.models)],
                coords = coords,
                scenario = svConfig.startingNpc.scenario,
                anim = svConfig.startingNpc.anim,
            }
        end
    end

    queues.normal = exports['prp-bridge']:CreateQueue(
        svConfig.mission.name,
        "crime",
        svConfig.mission.policeRequired,
        svConfig.mission.concurrentMissions,
        svConfig.mission.cooldown
    )

    queues.normal.setExecFunction(function(queueName, partyId, partyMembers, taskId)
        lib.print.debug('Starting new horde for party:', partyId, 'with members:', partyMembers)
        startNewHorde(partyId, taskId)
    end)

    queues.normal.setCheckFunction(function(queueName, partyId)
        local party = exports['prp-bridge']:GetParty(partyId)
        if not party then
            queues.normal.remove(party)

            return false
        end

        local memberCount = #party.getMembersAsArray()
        if memberCount < svConfig.mission.minimalGroupSize then
            return false
        end

        if memberCount > svConfig.mission.maximumGroupSize then
            return false
        end

        return true
    end)

    -- HARD MODE
    queues.hard = exports['prp-bridge']:CreateQueue(
        svConfig.hardMission.name,
        "crime",
        svConfig.hardMission.policeRequired,
        svConfig.hardMission.concurrentMissions,
        svConfig.hardMission.cooldown
    )

    queues.hard.setExecFunction(function(queueName, partyId, partyMembers, taskId)
        lib.print.debug('Starting new horde for party:', partyId, 'with members:', partyMembers)
        startNewHorde(partyId, taskId, true)
    end)

    queues.hard.setCheckFunction(function(queueName, partyId)
        local party = exports['prp-bridge']:GetParty(partyId)
        if not party then
            queues.hard.remove(party)

            return false
        end

        local memberCount = #party.getMembersAsArray()
        if memberCount < svConfig.hardMission.minimalGroupSize then
            return false
        end

        if memberCount > svConfig.hardMission.maximumGroupSize then
            return false
        end

        return true
    end)
end)

local function openMenu()
    local src = source

    if hordeQueueDisabled and not queueAllowedStateIds[stateId] then
        bridge.fw.notify(src, 'error', locale('HORDE_MISSION_DISABLED'))
        return
    end

    local menu = {
        id = 'horde_starting_npc_menu',
        title = locale('HORDE_STARTING_NPC_MENU_LABEL'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('HORDE_MISSION_GROUP_REQUIRED'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInNormalQueue = false

    if partyUuid and queues.normal.isPartyIn(partyUuid) then
        isInNormalQueue = true
    end

    local isInHardQueue = false
    if svConfig.hardMission and partyUuid and queues.hard.isPartyIn(partyUuid) then
        isInHardQueue = true
    end

    if isInNormalQueue or isInHardQueue then
        local position = isInNormalQueue and queues.normal.getPartyPosition(partyUuid) or queues.hard.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('HORDE_ALREADY_IN_QUEUE'),
            description = locale("HORDE_ALREADY_IN_QUEUE_DESC", position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = svConfig.mission.label,
            description = svConfig.mission.description,
            serverEvent = 'prp-horde:client:requestJoinQueue',
            disabled = isInNormalQueue,
            args = {
                queueName = svConfig.mission.name
            }
        }

        menu.options[#menu.options + 1] = {
            title = svConfig.hardMission.label,
            description = svConfig.hardMission.description,
            serverEvent = 'prp-horde:client:requestJoinQueue',
            disabled = isInHardQueue,
            args = {
                queueName = svConfig.hardMission.name
            }
        }
    end

    TriggerClientEvent('prp-menu:client:openMenu', src, menu)
end
RegisterNetEvent('prp-horde:server:openStartingHordeMenu', openMenu)

local function joinQueue(data)
    local src = source

    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then
        bridge.fw.notify(src, 'error', locale('FRAMEWORK_INVALID_PLAYER'))
        return
    end

    local mission = svConfig.mission

    if svConfig.hardMission and data.queueName == svConfig.hardMission.name then
        mission = svConfig.hardMission
    end

    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(identifier)
    if not group then
        bridge.fw.notify(src, 'error', locale('HORDE_MISSION_GROUP_REQUIRED'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, mission.name) then
            return bridge.fw.notify(src, 'error', locale('HORDE_MISSION_COOLDOWN'))
        end
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    lib.print.debug('Adding to queue:', mission.name, stateId)
    local response = group.enterUniqueue(mission.name)

    if response and response.success then
        bridge.fw.notify(src, 'success', locale('HORDE_QUEUE_ADDED'))
    else
        lib.print.debug('Failed to join horde queue:', response and response.error or 'unknown error')
        bridge.fw.notify(src, 'error', locale('HORDE_MISSION_QUEUE_FAILED'))
    end
end
RegisterNetEvent('prp-horde:client:requestJoinQueue', joinQueue)
