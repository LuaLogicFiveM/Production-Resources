queue = nil
local ready = false

local function check(_, partyId)
    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then
        queue.remove(party)
        
        return false
    end

    local memberCount = #party.getMembersAsArray()
    if memberCount < Config.Mission.group?.min then
        return false
    end

    if memberCount > Config.Mission.group?.max then
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

    StartDrugDrops(partyId, taskId)
end

local function setupQueue()
    if ready then return end
    ready = true

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
SetTimeout(0, setupQueue)

local function openStartMenu()
    local src = source

    local menu = {
        id = 'drug_drops_starting_npc_menu',
        title = locale('DRUG_DROPS_STARTING_NPC_MENU_LABEL'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('DRUG_DROPS_MISSION_GROUP_REQUIRED'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = queue.isPartyIn(partyUuid)

    if isInQueue then
        local position = isInQueue and queue.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('DRUG_DROPS_ALREADY_IN_QUEUE'),
            description = locale("DRUG_DROPS_ALREADY_IN_QUEUE_DESC", position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = Config.Mission.label,
            description = Config.Mission.desc,
            serverEvent = 'prp-drug-drops:client:requestJoinQueue',
            disabled = isInQueue,
            args = {
                queueName = Config.Mission.name
            }
        }
    end

    TriggerClientEvent('prp-drug-drops:client:openMenu', src, menu)
end
RegisterNetEvent("prp-drug-drops:server:openStartingDrugDropsMenu", openStartMenu)

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
        bridge.fw.notify(src, 'error', locale('DRUG_DROPS_MISSION_GROUP_REQUIRED'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, mission.name) then
            return bridge.fw.notify(src, 'error', locale('DRUG_DROPS_MISSION_COOLDOWN'))
        end
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    lib.print.debug('Adding to queue:', mission.name, stateId)
    local response = group.enterUniqueue(mission.name)

    if response and response.success then
        bridge.fw.notify(src, 'success', locale('DRUG_DROPS_QUEUE_ADDED'))
    else
        lib.print.debug('Failed to join drug drops queue:', response and response.error or 'unknown error')
        bridge.fw.notify(src, 'error', locale('DRUG_DROPS_MISSION_QUEUE_FAILED'))
    end
end
RegisterNetEvent("prp-drug-drops:client:requestJoinQueue", joinQueue)
