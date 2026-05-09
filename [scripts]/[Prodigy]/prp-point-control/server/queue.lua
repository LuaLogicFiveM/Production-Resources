CurrentlyActive = false
Queue = nil

function HasFreeLocations()
    for k, v in pairs(Config.Locations) do
        if not v.missionId then
            return true
        end
    end
    return false
end

local function check(_, partyId)
    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then return false end

    if not HasFreeLocations() then
        return false
    end

    for _, member in pairs(party.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, Config.Mission.name) then
            return false
        end
    end

    return true
end

local function exec(_, partyId, members, taskId)
    local mission = StartPointControl(partyId, members, taskId)

    mission:start()
end

local function prepareQueue()
    Queue = exports['prp-bridge']:CreateQueue(
        Config.Mission.name,
        "crime",
        Config.Mission.policeRequired,
        Config.Mission.concurrentMissions,
        Config.Mission.timeout
    )

    Queue.setCheckFunction(check)
    Queue.setExecFunction(exec)
end
SetTimeout(0, prepareQueue)

function JoinMembersToQueue(members)
    local party = exports['prp-bridge']:CreateUniqueueParty('crime')

    for src, _ in pairs(members) do
        local identifier = bridge.fw.getIdentifier(src)
        if not identifier then return false end
        
        party.addMember(identifier)
    end

    local response = Queue.add(party)
    if not response then 
        return false
    end

    return true
end
