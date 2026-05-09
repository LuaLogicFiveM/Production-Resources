queue = nil

local ready = false
local locations = {}

local function startup()
    if ready then
        return
    end
    ready = true

    Citizen.Wait(250)

    queue = exports['prp-bridge']:CreateQueue(
        Config.Mission.name,
        'crime',
        Config.Mission.policeRequired,
        Config.Mission.concurrentMissions,
        Config.Mission.timeout
    )

    queue.setCheckFunction(check)
    queue.setExecFunction(exec)
end
SetTimeout(0, startup)

local function hasFreeLocations()
    for k, v in pairs(Config.Locations) do
        if not v.missionId then
            return true
        end
    end
    return false
end

function check(_, partyId)
    if not hasFreeLocations() then return false end

    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then
        return false
    end

    local memberCount = #party.getMembersAsArray()
    if memberCount < Config.Mission.minimalGroupSize then
        return false
    end

    if memberCount > Config.Mission.maximalGroupSize then
        return false
    end

    for _, identifier in pairs(party.getMembersAsArray()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(identifier, Config.Mission.name) then
            return false
        end
    end

    return true
end

function exec(_, partyId, _, taskId)
    local party = exports['prp-bridge']:GetParty(partyId)
    for _, identifier in pairs(party.getMembersAsArray()) do
        exports["prp-bridge"]:startCooldownByIdentifier(
            identifier,
            Config.Mission.name,
            Config.Mission.cooldown or 600,
            false
        )
    end

    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyId)
    if not group then
        queue.setTaskIsExecuting(taskId, false)
        return false
    end

    local leader = group.getLeader()

    local mission = StartAerial(leader.src, taskId)
    mission:start()
end

local function joinQueue()
    local src = source

    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then
        bridge.fw.notify(src, 'error', locale('FRAMEWORK_INVALID_PLAYER'))
        return
    end

    local mission = Config.Mission

    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(identifier)
    if not group then
        bridge.fw.notify(src, 'error', locale('AERIAL_MISSION_GROUP_REQUIRED'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, mission.name) then
            return bridge.fw.notify(src, 'error', locale('AERIAL_MISSION_COOLDOWN'))
        end
    end

    if not bridge.inv.hasItem(src, mission.startItem, 1) then
        bridge.fw.notify(src, 'error', locale('AERIAL_START_ITEM_REQUIRED'))
        return
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    lib.print.debug('Adding to queue:', mission.name, stateId)
    local response = group.enterUniqueue(mission.name)

    if response and response.success then
        bridge.inv.removeItem(src, mission.startItem, 1)
        bridge.fw.notify(src, 'success', locale('AERIAL_MISSION_QUEUE_ADDED'))
    else
        lib.print.debug('Failed to join aerial mission queue:', response and response.error or 'unknown error')
        bridge.fw.notify(src, 'error', locale('AERIAL_MISSION_QUEUE_FAILED'))
    end
end
RegisterNetEvent("prp-aerialrun:client:requestJoinQueue", joinQueue)

local function startingPoints()
    if Config.StartingNpc?.randomLocation then
        lib.print.debug('Choosing random starting NPC location')
        local randomCoords = Config.StartingNpc.locations[math.random(1, #Config.StartingNpc.locations)]

        locations[1] = {
            model = Config.StartingNpc.models[math.random(1, #Config.StartingNpc.models)],
            coords = randomCoords,
            scenario = Config.StartingNpc.scenario,
            anim = Config.StartingNpc.anim,
        }
    else
        lib.print.debug('Using all starting NPC locations')
        for _, coords in pairs(Config.StartingNpc.locations) do
            locations[#locations + 1] = {
                model = Config.StartingNpc.models[math.random(1, #Config.StartingNpc.models)],
                coords = coords,
                scenario = Config.StartingNpc.scenario,
                anim = Config.StartingNpc.anim,
            }
        end
    end
end
SetTimeout(0, startingPoints)

local function sendLocations()
    local src = source

    TriggerClientEvent("prp-aerialrun:client:startingLocations", src, locations)
end
RegisterNetEvent("prp-aerialrun:server:requestStartingData", sendLocations)

local function openStartMenu()
    local src = source

    local menu = {
        id = 'aerial_starting_npc_menu',
        title = locale('AERIAL_STARTING_NPC_MENU_LABEL'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('AERIAL_MISSION_GROUP_REQUIRED'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = queue.isPartyIn(partyUuid)

    if isInQueue then
        local position = isInQueue and queue.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('AERIAL_ALREADY_IN_QUEUE'),
            description = locale("AERIAL_ALREADY_IN_QUEUE_DESC", position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = Config.Mission.label,
            description = Config.Mission.desc,
            serverEvent = 'prp-aerialrun:client:requestJoinQueue',
            disabled = isInQueue,
            args = {
                queueName = Config.Mission.name
            }
        }
    end

    TriggerClientEvent('prp-aerialrun:client:openMenu', src, menu)
end
RegisterNetEvent("prp-aerialrun:server:openStartingAerialMenu", openStartMenu)
