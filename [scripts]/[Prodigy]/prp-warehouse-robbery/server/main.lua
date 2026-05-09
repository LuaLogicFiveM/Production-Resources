missionQeueue = nil

MissionCount = 0
MissionOngoing = {}

local npcLocations = {
    warehouse = {},
    smuggling = {},
}

local function check(_, partyUuid)
    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyUuid)

    if not group then
        lib.print.debug("No group found for partyUuid:", partyUuid)
        return false
    end

    local leader = group.getLeader()

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, Mission.queueName) then
            bridge.fw.notify(leader.src, 'error', locale("GROUP_MEMBER_ON_CD"))

            return false
        end
    end

    return true
end

local function exec(_, partyUuid, _, taskId)
    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyUuid)
    if not group then
        missionQeueue.setTaskIsExecuting(taskId, false)
        return false
    end

    local leader = group.getLeader()

    StartMission(
        leader.src,
        taskId
    )
end

local function setup()
    missionQeueue = exports['prp-bridge']:CreateQueue(
        Mission.queueName,
        "crime",
        Mission.policeRequired,
        Mission.concurrentJobs,
        Mission.cooldown * 60 * 1000
    )

    missionQeueue.setCheckFunction(check)
    missionQeueue.setExecFunction(exec)
end

local function processNpcLocations(npcConfig)
    local processed = {}

    if npcConfig?.randomLocation then
        local randomCoords = npcConfig.locations[math.random(1, #npcConfig.locations)]

        processed[1] = {
            model = npcConfig.models[math.random(1, #npcConfig.models)],
            coords = randomCoords,
            scenario = npcConfig.scenario,
            anim = npcConfig.anim,
        }
    else
        for _, coords in pairs(npcConfig.locations) do
            processed[#processed + 1] = {
                model = npcConfig.models[math.random(1, #npcConfig.models)],
                coords = coords,
                scenario = npcConfig.scenario,
                anim = npcConfig.anim,
            }
        end
    end

    return processed
end

if Mission.StartingNpc then
    npcLocations.warehouse = processNpcLocations(Mission.StartingNpc)
end

if SmugglingMission.StartingNpc then
    npcLocations.smuggling = processNpcLocations(SmugglingMission.StartingNpc)
end

SetTimeout(0, setup)

function ProgressBar(playerId, duration, label, canCancel, controlDisables, anim, prop)
    if not controlDisables then
        controlDisables = { disableMovement = true }
    end

    if anim then
        anim = {
            animDict = anim.dict,
            anim = anim.clip,
            flags = anim.flag,
        }
    end

    return lib.callback.await("prp-bridge:progress", playerId, {
        duration = duration,
        label = label,
        animation = anim,
        controlDisables = controlDisables,
        prop = prop,
        canCancel = canCancel,
    })
end

local function sendConfig()
    local src = source

    local configs = {
        WarehouseCfg = WarehouseCfg,
        MissionCfg = Mission.Other,
        SmugglingCfg = SmugglingMission.Other,
        Entrances = Entrances,
        ENTITY_SETS = ENTITY_SETS,
        Codes = Codes,
        Interiors = svConfig.interiors,
        SmugglingWeaponHashes = SmugglingMission.WEAPON_HASHES,
        SmugglingBoatModel = SmugglingMission.BoatModel
    }

    TriggerClientEvent("prp-warehouse-robbery:client:configs", src, configs)
end
RegisterNetEvent("prp-warehouse-robbery:clientReady", sendConfig)

local function sendLocations()
    local src = source

    TriggerClientEvent("prp-warehouse-robbery:client:startingLocations", src, npcLocations.warehouse, npcLocations.smuggling)
end
RegisterNetEvent("prp-warehouse-robbery:requestStartingData", sendLocations)

local function openMenu(src, payload)
    TriggerClientEvent("prp-warehouse-robbery:client:openMenu", src, payload)
end

local function openWarehouseMenu()
    local src = source

    local menu = {
        id = 'warehouse_starting_npc_menu',
        title = locale('WAREHOUSE_QUEUE_MENU_TITLE'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('QUEUE_NO_GROUP'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = partyUuid and missionQeueue.isPartyIn(partyUuid)

    if isInQueue then
        local position = missionQeueue.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('QUEUE_ALREADY_IN'),
            description = locale('QUEUE_ALREADY_IN_DESC', position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = locale('QUEUE_JOIN'),
            description = locale('QUEUE_JOIN_DESC'),
            serverEvent = 'prp-warehouse-robbery:server:joinWarehouseQueue',
        }
    end

    openMenu(src, menu)
end
RegisterNetEvent("prp-warehouse-robbery:server:openWarehouseMenu", openWarehouseMenu)

local function joinWarehouseQueue()
    local src = source

    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then return end

    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(identifier)
    if not group then
        bridge.fw.notify(src, 'error', locale('QUEUE_NO_GROUP'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, Mission.queueName) then
            return bridge.fw.notify(src, 'error', locale('QUEUE_COOLDOWN'))
        end
    end

    if not bridge.inv.hasItem(src, Mission.startItem, 1) then
        bridge.fw.notify(src, 'error', locale('QUEUE_START_ITEM_REQUIRED'))
        return
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    local response = group.enterUniqueue(Mission.queueName)

    if response and response.success then
        bridge.inv.removeItem(src, Mission.startItem, 1)
        bridge.fw.notify(src, 'success', locale('QUEUE_JOINED'))
    else
        bridge.fw.notify(src, 'error', locale('QUEUE_FAILED'))
    end
end
RegisterNetEvent("prp-warehouse-robbery:server:joinWarehouseQueue", joinWarehouseQueue)

local function openSmugglingMenu()
    local src = source

    local menu = {
        id = 'smuggling_starting_npc_menu',
        title = locale('SMUGGLING_QUEUE_MENU_TITLE'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('QUEUE_NO_GROUP'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = partyUuid and smugglingQueue.isPartyIn(partyUuid)

    if isInQueue then
        local position = smugglingQueue.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('QUEUE_ALREADY_IN'),
            description = locale('QUEUE_ALREADY_IN_DESC', position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = locale('QUEUE_JOIN'),
            description = locale('QUEUE_JOIN_DESC'),
            serverEvent = 'prp-warehouse-robbery:server:joinSmugglingQueue',
        }
    end

    openMenu(src, menu)
end
RegisterNetEvent("prp-warehouse-robbery:server:openSmugglingMenu", openSmugglingMenu)

local function joinSmugglingQueue()
    local src = source

    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then return end

    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(identifier)
    if not group then
        bridge.fw.notify(src, 'error', locale('QUEUE_NO_GROUP'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, SmugglingMission.queueName) then
            return bridge.fw.notify(src, 'error', locale('QUEUE_COOLDOWN'))
        end
    end

    if not bridge.inv.hasItem(src, SmugglingMission.startItem, 1) then
        bridge.fw.notify(src, 'error', locale('QUEUE_START_ITEM_REQUIRED'))
        return
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    local response = group.enterUniqueue(SmugglingMission.queueName)

    if response and response.success then
        bridge.inv.removeItem(src, SmugglingMission.startItem, 1)
        bridge.fw.notify(src, 'success', locale('QUEUE_JOINED'))
    else
        bridge.fw.notify(src, 'error', locale('QUEUE_FAILED'))
    end
end
RegisterNetEvent("prp-warehouse-robbery:server:joinSmugglingQueue", joinSmugglingQueue)