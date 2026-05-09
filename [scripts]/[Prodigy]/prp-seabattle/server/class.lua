---@class SeaBattle : OxClass
---@field id string
---@field playerId number
---@field stateId string
---@field group table|nil
---@field groupId string
---@field isActive boolean
SeaBattle = lib.class('SeaBattle')

function SeaBattle:constructor(playerId, data)
    self.playerId = playerId
    self.stateId = bridge.fw.getIdentifier(playerId)
    self.group = exports['prp-bridge']:GetGroupFromMember(playerId)
    self.groupId = self.group and self.group.getUuid() or nil

    if not data then
        data = {}
    end

    self.label = data.label

    self.id = data.id

    self.faction = data.faction
    self.currentStage = nil
    self.missionType = data.missionType
    self.gearTaken = false
    self.ropeTaken = false
    self.crateLocation = data.reservedLocation
    ActiveLocations[self.crateLocation] = true
    self.taskId = data.taskId

    self:cooldown()
    self:setActivity(Config.Mission.label)
end

function SeaBattle:event(eventName, ...)
    if self.group then
        self.group.triggerEvent(eventName, ...)
    else
        TriggerClientEvent(eventName, self.playerId, ...)
    end
end

function SeaBattle:serverEvent(eventName, ...)
    TriggerEvent(eventName, ...)
end

function SeaBattle:syncMission()
    self:event('prp-seabattle:client:updateMissionData', {
        currentStage = self.currentStage,
        missionId = self.id,
        missionType = self.missionType,
        infoNPCid = self.infoNPCid,
        crateLocation = self.crateLocation,
        crateId = self.crateId,
        gearTaken = self.gearTaken,
        faction = faction,
    })
end

function SeaBattle:setActivity(title)
    if not self.group then
        return
    end

    self.group.setActivity(self.id, title)
end

function SeaBattle:collectReward(playerId)

end

function SeaBattle:cooldown()
    if self.group then
        local stateIds = self.group.getMembersIdentifiers()

        for k, v in pairs(stateIds or {}) do
            exports['prp-bridge']:startCooldownByIdentifier(v, 'seabattle', Config.Mission.cooldown, false)
        end
    else
        exports['prp-bridge']:startCooldownByIdentifier(self.stateId, 'seabattle', Config.Mission.cooldown, false)
    end
end

function SeaBattle:getPlayerIds()
    if self.group then
        local members = self.group.getMembers()
        local playerIds = {}
        for _, member in pairs(members) do
            playerIds[#playerIds + 1] = member.src
        end
        return playerIds
    end

    return {self.playerId}
end

function SeaBattle:finish()
    self:event('prp-seabattle:client:missionFinished', self.id)
    self:cleanup()
end

function SeaBattle:cleanup()
    if self.crateLocation then
        ActiveLocations[self.crateLocation] = nil
    end

    queue.setTaskIsExecuting(self.taskId, false)

    if self.spawnedBoat and DoesEntityExist(self.spawnedBoat) then
        DeleteEntity(self.spawnedBoat)
        self.spawnedBoat = nil
    end

    if self.crateId then
        if Crates[self.crateId] and Crates[self.crateId].serverEntity then
            DeleteEntity(Crates[self.crateId].serverEntity)
        end
        Crates[self.crateId] = nil
        TriggerClientEvent("prp-seabattle:client:removeCrate", -1, self.crateId)
        self.crateId = nil
    end

    self:event("prp-seabattle:client:toggleBoatBlips", false)

    DestroyMission(self.id)
end

function SeaBattle:setInfoStage()
    self.currentStage = 'getInfo'
    self.infoNPCid = math.random(1, #Config.DeliveryNPCs)

    local players = self:getPlayerIds()

    for i=1, #players do
        bridge.phone.sendMessage(players[i],
            Config.ContactNumber,
            locale("SEABATTLE_INFO_SMS")
        )
    end
    self:syncMission()
    self:event("prp-seabattle:client:toggleInfoBlip", self.infoNPCid, true)
end

function SeaBattle:infoTalked(playerId)
    self.currentStage = 'getGear'
    self.crateId = CurrentCrateId
    CurrentCrateId = CurrentCrateId + 1

    bridge.fw.notify(playerId, 'inform', locale("SEABATTLE_CRATE_MARKED_NOTIFY"))

    self:syncMission()

    local shouldSpawnNPCs = math.random(1, 100) <= Config.ChanceForGuards and true or false

    Crates[self.crateId] = {
        location = self.crateLocation,
        hasRope = true,
        serverEntity = nil,
        missionId = self.id,
        faction = self.faction,
        spawnGuards = shouldSpawnNPCs,
    }

    TriggerClientEvent("prp-seabattle:client:spawnNewCrate", -1, self.crateId, Crates[self.crateId])

    self:event("prp-seabattle:client:markCrate", self.crateId, self.crateLocation)
end

function SeaBattle:boatTalked(playerId, npcId)
    if not self.ropeTaken then
        bridge.inv.giveItem(playerId, "sb_boat_rope", 1)
        self.ropeTaken = true
    end

    self.gearTaken = true
    local vehData = SpawnVehicle(Config.BoatModel, Config.DeliveryNPCs[npcId].npc.boatPos)
    if not vehData then
        bridge.fw.notify(playerId, 'error', locale("SEABATTLE_SOMETHING_WENT_WRONG_NOTIFY"))
        return
    end
    self.spawnedBoat = vehData.veh
    self.spawnedBoatPlate = vehData.plate
    bridge.vkeys.give(playerId, vehData.veh, vehData.plate)
    bridge.vfuel.set(playerId, vehData.veh, 100)

    self.currentStage = 'getCrate'
end

function SeaBattle:returnBoat(playerId)
    self.gearTaken = false
    bridge.vkeys.remove(playerId, self.spawnedBoat, self.spawnedBoatPlate)
    if self.spawnedBoat and DoesEntityExist(self.spawnedBoat) then
        DeleteEntity(self.spawnedBoat)
        self.spawnedBoat = nil
    end
end

function SeaBattle:crateStolen()
    local players = self:getPlayerIds()

    for i=1, #players do
        bridge.phone.sendMessage(players[i],
            Config.ContactNumber,
            locale("SEABATTLE_STOLEN_SMS")
        )
    end
end

AddEventHandler("prp-groups:internal:leftGroup", function(playerId, groupId)
    local mission = GetActiveMissionByGroupId(groupId)
    if not mission then
        return
    end

    local playerIds = mission:getPlayerIds()
    if #playerIds == 1 and playerIds[1] == playerId then
        mission:cleanup()
    end
end)
