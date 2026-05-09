SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

queue = nil
local locations = {}

function RegisterCommands()
    bridge.fw.registerCommand(
        "force_end_seahunt",
        "Force end a seahunt mission",
        { { name = "stateId", type = "number", help = "State ID of the player" } },
        "admin",
        function(source, args)
            if not args[1] then
                return
            end

            for k, v in pairs(MissionTable) do
                if v.members[tostring(args[1])] then
                    bridge.fw.notify(source, 'success', locale("SEAHUNT_MISSION_DESTROYED", args[1]), nil, 8000)
                    v:destroy()
                    return
                end
            end

            bridge.fw.notify(source, 'error', locale("SEAHUNT_MISSION_NOT_FOUND"), nil, 8000)
        end
    )
end

local function check(_, partyId)
    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then
        queue.remove(party)

        return false
    end

    local memberCount = #party.getMembersAsArray()
    if memberCount < Config.Mission.minimalGroupSize then
        return false
    end

    for _, member in pairs(party.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, Config.Mission.name) then
            return false
        end
    end

    return true
end

local function execute(_, partyId, _, taskId)
    local party = exports['prp-bridge']:GetParty(partyId)

    for _, identifier in pairs(party.getMembersAsArray()) do
        exports["prp-bridge"]:startCooldownByIdentifier(
            identifier,
            Config.Mission.name,
            Config.Mission.cooldown or 600,
            false
        )
    end

    StartMission(partyId, taskId, OnSeaHuntStart, OnSeaHuntDestroy)
end

local function startup()
    RegisterCommands()

    queue = exports['prp-bridge']:CreateQueue(
        Config.Mission.name,
        'crime',
        Config.Mission.policeRequired,
        Config.Mission.concurrentMissions,
        Config.Mission.timeout
    )

    queue.setCheckFunction(check)
    queue.setExecFunction(execute)
end
SetTimeout(0, startup)

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

    TriggerClientEvent("prp-seahunt:client:startingLocations", src, locations)
end
RegisterNetEvent("prp-seahunt:server:requestStartingData", sendLocations)

local function openStartingMenu()
    local src = source

    local menu = {
        id = 'seahunt_starting_npc_menu',
        title = locale('SEAHUNT_STARTING_NPC_MENU_LABEL'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('SEAHUNT_MISSION_GROUP_REQUIRED'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = queue.isPartyIn(partyUuid)

    if isInQueue then
        local position = isInQueue and queue.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('SEAHUNT_ALREADY_IN_QUEUE'),
            description = locale("SEAHUNT_ALREADY_IN_QUEUE_DESC", position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = Config.Mission.label,
            description = Config.Mission.desc,
            serverEvent = 'prp-seahunt:client:requestJoinQueue',
            disabled = isInQueue,
            args = {
                queueName = Config.Mission.name
            }
        }
    end

    TriggerClientEvent('prp-seahunt:client:openMenu', src, menu)
end
RegisterNetEvent("prp-seahunt:server:openStartingMenu", openStartingMenu)

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
        bridge.fw.notify(src, 'error', locale('SEAHUNT_MISSION_GROUP_REQUIRED'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, mission.name) then
            return bridge.fw.notify(src, 'error', locale('SEAHUNT_MISSION_COOLDOWN'))
        end
    end

    local requiredItem = mission.requiredItem
    if requiredItem then
        if not bridge.inv.hasItem(src, requiredItem.name) then
            return bridge.fw.notify(src, 'error', locale('SEAHUNT_MISSING_REQUIRED_ITEM'))
        end

        if not bridge.inv.removeItem(src, requiredItem.name, requiredItem.count) then
            return bridge.fw.notify(src, 'error', locale('SEAHUNT_MISSING_REQUIRED_ITEM'))
        end
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    lib.print.debug('Adding to queue:', mission.name, stateId)
    local response = group.enterUniqueue(mission.name)

    if response and response.success then
        bridge.fw.notify(src, 'success', locale('SEAHUNT_QUEUE_ADDED'))
    else
        lib.print.debug('Failed to join seahunt queue:', response and response.error or 'unknown error')
        bridge.fw.notify(src, 'error', locale('SEAHUNT_MISSION_QUEUE_FAILED'))
    end
end
RegisterNetEvent("prp-seahunt:client:requestJoinQueue", joinQueue)