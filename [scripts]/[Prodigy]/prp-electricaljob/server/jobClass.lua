---@type table<JobOptions>
JobTypes = {}
JobId = 0

---@class Job
---@field id string jobId
---@field members table<JobMember>
---@field owner string Character id of the owner
---@field jobType string
---@field groupId string|nil
---@field destroyCb function
---@field addPlayerCb function
---@field removePlayerCb function
---@field syncData table Synced data
Job = {}
Job.__index = Job

---@type table<Job>
JobTable = {}

---@type table<number> Key: characterId, Value: jobId
JobMembers = {}

---@class JobOptions
---@field id string
---@field name string
---@field limit number
---@field maxMembers number
---@field salaryPerBox number
---@field depots table

---@class JobMember
---@field source number
---@field charId string

---@param jobType string
---@param joiner number Player id
---@param members table<table>|nil Players (without the owner)
---@param groupId string|nil
---@param destroyCb function
---@param addPlayerCb function
---@param removePlayerCb function
---@return Job
function CreateJob(jobType, joiner, members, groupId, destroyCb, addPlayerCb, removePlayerCb)
    JobId += 1
    local self = {
        id = tostring(JobId),
        syncData = {},
        members = {}
    }

    JobTable[self.id] = setmetatable(self, Job)
    ---@type Job
    local job = JobTable[self.id]
    job.jobType = jobType

    if members then
        for k, v in pairs(members) do
            job:AddMember(v.source)
        end
    end

    job:AddMember(joiner)

    job.owner = tostring(bridge.fw.getIdentifier(joiner))
    job.destroyCb = destroyCb
    job.addPlayerCb = addPlayerCb
    job.removePlayerCb = removePlayerCb

    job.groupId = groupId

    return JobTable[self.id]
end

---@param type string
---@param message string
---@param time number|nil
function Job:Notification(type, message, time)
    for k, v in pairs(self.members) do
        bridge.fw.notify(v.source, type, message, nil, time)
    end
end

---@param count number Progress count
---@return boolean complete Is task finished
function Job:UpdateTaskProgress(count)
    ---@type JobMember
    if not self.syncData.boxes then
        return false
    end
    local isComplete = false
    local pointsLeft = 0
    for k,v in pairs(self.syncData.boxes) do
        pointsLeft = pointsLeft + 1
    end
    if pointsLeft <= 0 then
        isComplete = true
    end
    return isComplete
end

---@param success boolean
---@param skipDistanceCheck boolean
function Job:Finish(success, skipDistanceCheck)
    ---@type JobMember
    local owner = self.members[self.owner]
    self.finished = true
    if success then
        self.success = true
    end
end

---@param eventName string
---@param ... any Args
function Job:SendEventToMembers(eventName, ...)
    local args = msgpack.pack_args(...)
    local argLength = args:len()
    for k, v in pairs(self.members) do
        TriggerClientEventInternal(eventName, v.source, args, argLength)
    end
end

function Job:Destroy()
    if self.destroyCb then
        self.destroyCb(self)
    end
    for k, v in pairs(self.members) do
        if v.source == source then
            JobMembers[v.charId] = nil
        end
    end
    JobTable[self.id] = nil
    self = nil
end

---@param source number
function Job:AddMember(source)
    local characterId = tostring(bridge.fw.getIdentifier(source))
    if not characterId then return end
    self.members[characterId] = {
        source = tonumber(source),
        charId = characterId
    }
    JobMembers[characterId] = self.id
    if self.addPlayerCb then
        self.addPlayerCb(self, source, characterId)
    end
end

---@param source number
function Job:RemoveMember(source)
    for k, v in pairs(self.members) do
        if v.source == source then
            if self.removePlayerCb then
                self.removePlayerCb(self, source, v.charId)
            end
            JobMembers[v.charId] = nil
            self.members[k] = nil
        end
    end
end

---@param source number
---@return Job|nil job
function Job:GetByMember(source)
    local characterId = tostring(bridge.fw.getIdentifier(source))
    if JobMembers[characterId] then
        return JobTable[JobMembers[characterId]]
    end
end

---@param charId number
---@return Job|nil job
function Job:GetByCharId(charId)
    local characterId = tostring(charId)
    if JobMembers[characterId] then
        return JobTable[JobMembers[characterId]]
    end
end

function Job:GetMemberCount()
    local count = 0
    for _, _ in pairs(self.members) do
        count += 1
    end
    return count
end

---@param groupId number
---@return Job|nil job 
function Job:GetByGroupId(groupId)
    for k, v in pairs(JobTable) do
        if v.groupId and v.groupId == groupId then
            return v
        end
    end
end

function Job:SyncData(source)
    if source then
       TriggerClientEvent(("prp-electrical:syncData"), source, self.syncData)
    else
        self:SendEventToMembers(("prp-electrical:syncData"), self.syncData)
    end
end

AddEventHandler("prp-bridge:server:groupMemberAdded", function(src, groupId)
    local job = Job:GetByGroupId(groupId)
    if not job then return end
    job:AddMember(src)
end)

AddEventHandler("prp-bridge:server:groupMemberRemoved", function(src, groupId)
    local job = Job:GetByGroupId(groupId)
    if not job then return end
    job:RemoveMember(src)
end)

AddEventHandler("prp-bridge:server:groupDisbanded", function(groupId)
    local job = Job:GetByGroupId(groupId)
    if not job then return end
    job:Destroy()
end)

---Registers a job type
---@param jobOptions JobOptions
---@param startCb function
---@param destroyCb function
function Job:RegisterType(jobOptions, startCb, destroyCb, addPlayerCb, removePlayerCb)
    JobTypes[jobOptions.id] = jobOptions

    if Config.StartByNPC then
        RegisterServerEvent("prp-electrical:startJob", function(depotId)
            local src = source
            local group = exports["prp-bridge"]:GetGroupFromMember(src)
            if not group then
                local result = exports["prp-bridge"]:CreateGroup(src)
                if result.success then
                    group = result.group
                end
            end
            local groupMembers = group.getMembers()
            local _groupMembers = {}
            for k,v in pairs(groupMembers) do
                table.insert(_groupMembers, { source = v.src, stateId = v.identifier })
            end
            local uuid = group.getUuid()
            local job = CreateJob(jobOptions.id, src, _groupMembers, uuid, destroyCb, addPlayerCb, removePlayerCb)
            startCb(job)
            job.syncData.depot = depotId
        end)

        RegisterServerEvent("prp-electrical:endJob", function()
            local job = Job:GetByMember(source)
            if not job then return end
            job:Destroy()
        end)
    end
end