local MissionConfig = {
    metadata = {
        label = locale("DROP_OFF_RANSOM_MISSION_LABEL"),
        startable = false,
        autoStart = true
    },
    dropOffLocations = {
        vec4(44.4, -104.3, 55.7, 339.9)
    },
    timeForSms = { 30, 60 },
    useSharedLocations = "normal",
    vehRansomReward = {
        ["F"] = {
            { weight = 100, item = "moneyroll", count = { 1, 5 } },
        },
        ["E"] = {
            { weight = 100, item = "moneyroll", count = { 1, 5 } },
        },
        ["D"] = {
            { weight = 100, item = "moneyroll", count = { 10, 15 } },
        },
        ["C"] = {
            { weight = 100, item = "moneyroll", count = { 15, 25 } },
        },
        ["B"] = {
            { weight = 100, item = "moneyroll", count = { 15, 35 } },
        },
        ["A"] = {
            { weight = 100, item = "moneyroll", count = { 20, 40 } },
        },
        ["S"] = {
            { weight = 100, item = "moneyroll", count = { 40, 60 } },
        },
    },
    trapChance = {
        ["F"] = 0,
        ["E"] = 2,
        ["D"] = 3,
        ["C"] = 5,
        ["B"] = 10,
        ["A"] = 20,
        ["S"] = 35,
    }
}

local DropOffMission = {}
DropOffMission.__index = DropOffMission
DropOffMission = setmetatable(DropOffMission, Mission)

function DropOffMission:OnStart(stateId, contract, groupId)
    local locations = {}
    local stealLocations = MissionConfig.useSharedLocations and Config.SharedLocations[MissionConfig.useSharedLocations] or MissionConfig.dropOffLocations
    for k, v in pairs(stealLocations) do
        if not v.taken then
            table.insert(locations, k)
        end
    end
    if #locations == 0 then
        return self:Cancel()
    end
    local location = locations[math.random(1, #locations)]
    self.location = location
    self.locationCoords = stealLocations[location].coords
    self.npcLocations = stealLocations[location].npcLocations
    stealLocations[location].taken = self.taskId
    self.timeForSms = math.random(MissionConfig.timeForSms[1], MissionConfig.timeForSms[2])
    self:SendEventToMembers("prp-boosting:setMissionBlip", "dropOff", locale("DROP_OFF_LOCATION"), self.locationCoords.xyz, 500, 3, true)
    self:SendEventToMembers("prp-boosting:setPreviewVehicle", self.locationCoords)
    local src = bridge.fw.getSrcFromIdentifier(stateId)
    local smsLocation = lib.callback.await("prp-boosting:getStreetName", src, self.locationCoords.xyz)
    if smsLocation then
        self:SendSMSMessage(locale("DROP_OFF_RANSOM_START_TEXT_LOCATION", smsLocation.main), nil, "BoostWorks")
    else
        self:SendSMSMessage(locale("DROP_OFF_RANSOM_START_TEXT"), nil, "BoostWorks")
    end
end

function DropOffMission:OnDestroy(stateId, contract, groupId)
    if self.location then
        local stealLocations = MissionConfig.useSharedLocations and Config.SharedLocations[MissionConfig.useSharedLocations] or MissionConfig.stealLocations
        stealLocations[self.location].taken = nil
    end
    if self.ransomLocation then
        local stealLocations = MissionConfig.useSharedLocations and Config.SharedLocations[MissionConfig.useSharedLocations] or MissionConfig.stealLocations
        stealLocations[self.ransomLocation].taken = nil
    end
end

function DropOffMission:OnTick(stateId, contract, groupId, tickId)
    local veh = LoadedBoostingContracts[self.contractId].vehEntity
    if not veh or not DoesEntityExist(veh) then
        self:Fail()
        return
    end
    if self.locationCoords then
        local vehCoords = GetEntityCoords(veh)
        local dist = #(vehCoords.xy - self.locationCoords.xy)
        if dist < 5 and GetEntitySpeed(veh) < 1 and GetPedInVehicleSeat(veh, -1) == 0 then
            Citizen.Wait(2000)
            pcall(function()
                print("REMOVE VEHICLE ON drop off 21321", veh, Entity(veh).state.VIN)
            end)
            DeleteEntity(veh)
            self:AddProgress(1)
        end
    end
    if self.ransomCoords and self.shouldSpawnNpc and not self.ransomNpcSpawned then
        local vehCoords = GetEntityCoords(veh)
        local dist = #(vehCoords.xy - self.ransomCoords.xy)
        if dist < 150.0 then
            self.ransomNpcSpawned = true
            local stealLocations = MissionConfig.useSharedLocations and Config.SharedLocations[MissionConfig.useSharedLocations] or MissionConfig.dropOffLocations
            local npcLocations = stealLocations[self.ransomLocation].npcLocations
            self:NpcCheck(npcLocations, true)
        end
    end
    if not self.ransomSmsSent and os.time() - self.startTime > self.timeForSms then
        self.ransomSmsSent = true
        self.shouldSpawnNpc = math.random(1, 100) <= MissionConfig.trapChance[LoadedBoostingContracts[self.contractId].vehicleClass]
        local locations = {}
        local stealLocations = MissionConfig.useSharedLocations and Config.SharedLocations[MissionConfig.useSharedLocations] or MissionConfig.dropOffLocations
        for k, v in pairs(stealLocations) do
            if not v.taken then
                table.insert(locations, k)
            end
        end
        if #locations == 0 then
            return
        end
        self.ransomLocation = locations[math.random(1, #locations)]
        stealLocations[self.ransomLocation].taken = self.taskId
        self.ransomCoords = stealLocations[self.ransomLocation].coords
        self.ransomNumber = ("%s-%s-%s"):format(math.random(1000, 9999), math.random(1000, 9999), math.random(1000, 9999))
        self:SendSMSMessage(locale("DROP_OFF_RANSOM_TICK_TEXT"), self.ransomNumber, locale("Unknown"))
        self:SendSMSMessage(("location=%s,%s,%s"):format(self.ransomCoords.x, self.ransomCoords.y, self.ransomCoords.z), self.ransomNumber, locale("Unknown"))
        if not self.shouldSpawnNpc then
            self.caseObject = self:CreateLocalObject(`prop_ld_suitcase_01`, self.ransomCoords - vec4(0.0, 0.0, 0.5, 0.0), true, true)
            self:AddLocalObjectTarget(self.caseObject, "case_ransom", {
                label = locale("TAKE_THE_SUITCASE"),
                icon = "fas fa-briefcase",
                event = "prp-boosting:takeRansomCase",
            })
        end
    end
end

RegisterNetEvent("prp-boosting:takeRansomCase", function(missionId, objectId)
    local source = source
    local stateId = bridge.fw.getIdentifier(source)
    local mission = Missions[missionId]
    local playerMission = GetActiveMissionByStateId(stateId)
    if mission and playerMission and mission.taskId == playerMission.taskId then
        if mission.tookRansomCase then
            return
        end
        local playerPed = GetPlayerPed(source)
        local veh = LoadedBoostingContracts[mission.contractId].vehEntity
        if not veh or not DoesEntityExist(veh) then
            return
        end
        local vehCoords = GetEntityCoords(veh)
        local dist = #(vehCoords.xy - mission.ransomCoords.xy)
        if dist > 10 then
            return
        end
        mission.tookRansomCase = true
        local success = lib.callback.await("prp-boosting:playAnim", source, "pickup_object", "pickup_low", 48, true)
        mission:RemoveLocalObject(objectId)
        local reward = WeightedRandom(MissionConfig.vehRansomReward[LoadedBoostingContracts[mission.contractId].vehicleClass])
        if not reward then
            return
        end
        local count = math.random(reward.count[1], reward.count[2])
        local success = bridge.inv.giveItem(source, reward.item, count, reward.metadata)
        if success then
            mission:SendSMSMessage(locale("DROP_OFF_RANSOM_FINISH_TEXT"), nil, locale("Unknown"))
            FreezeEntityPosition(veh, true)
            mission:Fail(true, true)
            Citizen.SetTimeout(15000, function()
                if DoesEntityExist(veh) then
                    DeleteEntity(veh)
                end
            end)
        end
    end
end)

function DropOffMission:GetMetadata()
    return MissionConfig.metadata
end

function DropOffMission:GetPrerequisites()
    return MissionConfig.prerequisites
end


Citizen.CreateThread(function()
    RegisteredMissions["deliver_dropoff_ransom"] = DropOffMission
end)