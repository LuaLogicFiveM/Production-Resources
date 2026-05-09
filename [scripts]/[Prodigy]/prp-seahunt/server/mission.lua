MissionId = 0
Mission = {}
Mission.__index = Mission
MissionTable = {}
MissionGroupTable = {}

---@class Mission
---@field id string
---@field taskId string
---@field stateId number
---@field groupId number
---@field members table<string, number>
---@field startTime number
---@field onDestroy function
---@field sendNotification function
---@field sendSMS function
---@field sendSMSLocation function
---@field destroy function
---@field sendEvent function


--- Starts a new mission
--- @param stateId number
--- @param onStart function
--- @return Mission Mission
function StartMission(partyId, taskId, onStart, onDestroy)
    MissionId += 1
    local self = {
        id = tostring(MissionId),
        partyId = partyId,
        taskId = taskId,
        startTime = os.time()
    }
    MissionTable[tostring(self.id)] = setmetatable(self, Mission)
    local mission = MissionTable[tostring(self.id)]
    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyId)
    local groupId = group.getUuid()
    mission.groupId = groupId
    local stateIds = group.getMembersIdentifiers()
    mission.members = {}
    mission.onDestroy = onDestroy
    MissionGroupTable[tostring(groupId)] = self.id
    for _, sId in pairs(stateIds) do
        mission.members[tostring(sId)] = bridge.fw.getSrcFromIdentifier(sId)
    end

    Citizen.CreateThread(function()
        if not onStart then return end
        onStart(MissionTable[self.id])
    end)

    return MissionTable[self.id]
end

function Mission:destroy()
    self.onDestroy(self)
    MissionGroupTable[tostring(self.groupId)] = nil
    MissionTable[tostring(self.id)] = nil

    queue:setTaskIsExecuting(self.taskId, false)
end

function Mission:onStart()

end

--- Sends a notification to all members of the mission
--- @param notifType string "success" | "inform" | "warning" | "error"
--- @param text string
--- @param time number|nil
function Mission:sendNotification(notifType, text, time)
    for _, src in pairs(self.members) do
        if DoesPlayerExist(src) then
            bridge.fw.notify(src, notifType, text, nil, time or 8000)
        end
    end
end

--- Sends a SMS to all members of the mission
---@param number string "RANDOM" or a phone number
---@param message string
---@param contactName string|nil
---@param targetSource number|nil
function Mission:sendSMS(number, message, contactName, targetSource)
    local from = number ~= "RANDOM" and number or nil
    if targetSource then
        bridge.phone.sendMessage(targetSource, from, message)
        return
    end
    for stateId, src in pairs(self.members) do
        if DoesPlayerExist(src) then
            bridge.phone.sendMessage(src, from, message)
        end
    end
end

--- Sends a location message to the specified number
--- @param number string "RANDOM" or a phone number
--- @param coords vector3
--- @param contactName string|nil
--- @param targetSource number|nil
function Mission:sendSMSLocation(number, coords, contactName, targetSource)
    local from = number ~= "RANDOM" and number or nil
    if targetSource then
        bridge.phone.sendCoords(targetSource, from, coords)
        return
    end
    for _, src in pairs(self.members) do
        if DoesPlayerExist(src) then
            bridge.phone.sendCoords(src, from, coords)
        end
    end
end

--- Sends an event to all members of the mission
--- @param eventName string
--- @vararg any
--- @return nil
--- @usage Mission:sendEvent("prp-seahunt:setLocation", vector3(0.0, 0.0, 0.0))
function Mission:sendEvent(eventName, ...)
    local msg = msgpack.pack_args(...)
    local msgLen = msg:len()
    for _, src in pairs(self.members) do
        if DoesPlayerExist(src) then
            TriggerClientEventInternal(eventName, src, msg, msgLen)
        end
    end
end

function GetMissionById(id)
    return MissionTable[tostring(id)]
end

function GetMissionByGroupId(groupId)
    return GetMissionById(MissionGroupTable[tostring(groupId)])
end

-- TODO
AddEventHandler("prp-bridge:server:playerLoad", function(source)
    Citizen.Wait(2000)
    local group = exports['prp-bridge']:GetGroupFromMember(source)
    if not group then return end
    
    local groupId = group.getUuid()
    if not groupId then return end
    local missionId = MissionGroupTable[tostring(groupId)]
    if not missionId then return end
    local mission = GetMissionById(missionId)
    if not mission then return end

    local identifier = bridge.fw.getIdentifier(source)
    if not identifier then return end
    if not mission.members[tostring(identifier)] then return end
    mission.members[tostring(identifier)] = source
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k, v in pairs(MissionTable) do
            v:destroy()
        end
    end
end)
