---@class Aerial : OxClass
---@field id string
---@field playerId number
---@field stateId string
---@field groupId string
---@field isActive boolean
Aerial = lib.class('Aerial')

function Aerial:constructor(playerId, partyId, data)
    self.playerId = playerId
    self.stateId = bridge.fw.getIdentifier(playerId)
    self.groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)

    -- self.enemyId = selectedPlayerId
    -- self.enemyStateId = selectedPlayerId and bridge.fw.getIdentifier(selectedPlayerId)
    -- self.enemyGroupId = selectedPlayerId and exports['prp-groups']:getGroupIdByPlayerId(selectedPlayerId)

    if not data then
        data = {}
    end

    self.label = data.label

    self.id = data.id

    self.faction = data.faction
    self.taskId = data.taskId
    self.stage = 0
    self.locationIndex = data.locationIndex
    local maxCrates = #Config.Locations[self.locationIndex].caseCoords
    self.crateCount = math.min(Config.Mission.crateCount or 2, maxCrates)
    Config.Locations[self.locationIndex].missionId = self.id

    self:cooldown()
end

function Aerial:groupEvent(groupId, eventName, ...)
    if not groupId then return end

    local group = exports['prp-bridge']:GetGroupByUuid(groupId)
    if not group then return end

    for _, member in pairs(group.getMembers()) do
        TriggerClientEvent(eventName, member.src, ...)
    end
end

function Aerial:event(eventName, ...)
    if self.groupId then
        self:groupEvent(self.groupId, eventName, ...)
    else
        TriggerClientEvent(eventName, self.playerId, ...)
    end

    if self.enemyGroupId then
        self:groupEvent(self.enemyGroupId, eventName, ...)
    elseif self.enemyId then
        TriggerClientEvent(eventName, self.enemyId, ...)
    end
end

function Aerial:teamEvent(eventName, ...)
    if self.groupId then
        self:groupEvent(self.groupId, eventName, ...)
    else
        TriggerClientEvent(eventName, self.playerId, ...)
    end
end

function Aerial:enemyEvent(eventName, ...)
    if self.enemyGroupId then
        self:groupEvent(self.enemyGroupId, eventName, ...)
    elseif self.enemyId then
        TriggerClientEvent(eventName, self.enemyId, ...)
    end
end

function Aerial:serverEvent(eventName, ...)
    TriggerEvent(eventName, ...)
end

function Aerial:syncMission()
    local data = {
        id = self.id,
        locationIndex = self.locationIndex,
        stage = self.stage,
        faction = self.faction,
        isActive = self.isActive,
    }
    self:teamEvent("prp-aerialrun:missionSync", data)
    data.isEnemy = true
    self:enemyEvent("prp-aerialrun:missionSync", data)
end

function Aerial:collectReward(playerId)
    local loot = GetLootReward(
        Config.CrateLoot.lootTableRolls,
        Config.CrateLoot.lootTable,
        Config.CrateLoot.guaranteedRarities
    )

    for _, v in pairs(loot or {}) do
        bridge.inv.giveItem(playerId, v.name, v.count, v.metaData)
    end
end

function Aerial:cooldown()
    if self.groupId then
        local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
        if not group then return end

        for _, member in pairs(group.getMembers()) do
            exports['prp-bridge']:startCooldownByIdentifier(member.identifier, Config.Mission.name,
                Config.Mission.cooldown)
        end
    else
        local identifier = bridge.fw.getIdentifier(self.playerId)
        if not identifier then return end

        exports['prp-bridge']:startCooldownByIdentifier(identifier, Config.Mission.name, Config.Mission.cooldown)
    end

    if self.enemyGroupId then
        local group = exports['prp-bridge']:GetGroupByUuid(self.enemyGroupId)
        if not group then return end

        for _, member in pairs(group.getMembers()) do
            exports['prp-bridge']:startCooldownByIdentifier(member.identifier, Config.Mission.name,
                Config.Mission.cooldown)
        end
    elseif self.enemyStateId then
        local identifier = bridge.fw.getIdentifier(self.enemyStateId)
        if not identifier then return end

        exports['prp-bridge']:startCooldownByIdentifier(identifier, Config.Mission.name, Config.Mission.cooldown)
    end
end

function Aerial:getPlayerIds()
    if self.groupId then
        local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
        if not group then return { self.playerId } end

        local playerIds = {}
        for _, member in pairs(group.getMembers()) do
            table.insert(playerIds, member.src)
        end

        return playerIds
    end

    return { self.playerId }
end

function Aerial:getEnemyPlayerIds()
    if self.enemyGroupId then
        local group = exports['prp-bridge']:GetGroupByUuid(self.enemyGroupId)
        if not group then return { self.enemyId } end

        local playerIds = {}
        for _, member in pairs(group.getMembers()) do
            table.insert(playerIds, member.src)
        end

        return playerIds
    end

    if self.snitch then
        local snitchSrc = tonumber(self.snitch)
        local groupId = exports['prp-bridge']:GetGroupIdFromMember(snitchSrc)
        if not groupId then return { snitchSrc } end

        local group = exports['prp-bridge']:GetGroupByUuid(groupId)
        if not group then return { snitchSrc } end

        local playerIds = {}
        for _, member in pairs(group.getMembers()) do
            table.insert(playerIds, member.src)
        end

        return playerIds
    end

    return { self.enemyId }
end

function Aerial:getPlayerIdsByGroupId(groupId)
    local group = exports['prp-bridge']:GetGroupByUuid(groupId)
    if not group then return {} end

    local playerIds = {}
    for _, member in pairs(group.getMembers()) do
        table.insert(playerIds, member.src)
    end

    return playerIds
end

function Aerial:finish(enemyWon)
    bridge.log.send(Config.LogWebhook, "Aerial Run Finished", "An aerial run mission has finished.", {
        mission_id = self.id,
        enemy_won = enemyWon,
    })

    self:teamEvent(
        "prp-bridge:notify",
        enemyWon and "error" or "success",
        locale(enemyWon and "MISSION_FAILED_DESC" or "MISSION_COMPLETED_DESC"),
        locale(enemyWon and "MISSION_FAILED" or "MISSION_COMPLETED")
    )
    self:enemyEvent(
        "prp-bridge:notify",
        enemyWon and "success" or "error",
        locale(enemyWon and "MISSION_COMPLETED_DESC" or "MISSION_FAILED_DESC"),
        locale(enemyWon and "MISSION_COMPLETED" or "MISSION_FAILED")
    )

    self:destroy()
end

function Aerial:cleanup()
    self:event("prp-aerialrun:missionSync", nil)

    if self.plane and DoesEntityExist(self.plane) then
        DeleteEntity(self.plane)
        self.plane = nil
    end
    TriggerClientEvent("prp-aerialrun:clearCrates", -1, self.locationIndex)
    Config.Locations[self.locationIndex].missionId = nil
end

function Aerial:destroy()
    queue.setTaskIsExecuting(self.taskId, false)

    self:cleanup()
    if self.snitch then
        if Snitches[tostring(self.snitch)].notified then
            Snitches[tostring(self.snitch)] = nil
        else
            Snitches[tostring(self.snitch)].active = nil
            Snitches[tostring(self.snitch)].notified = nil
        end
    end
    ActiveMissions[self.id] = nil
end

function Aerial:start()
    bridge.log.send(Config.LogWebhook, "Aerial Run Started", "A new aerial run mission has started.", {
        mission_id = self.id,
        location_index = self.locationIndex,
        player_ids = self:getPlayerIds(),
    })

    self.snitch = GetFreeSnitch(self:getPlayerIds())

    if self.snitch then
        Snitches[tostring(self.snitch)].active = self.id
        local snitchSrc = tonumber(self.snitch)
        self.enemyId = snitchSrc
        self.enemyStateId = bridge.fw.getIdentifier(snitchSrc)
        self.enemyGroupId = exports['prp-bridge']:GetGroupIdFromMember(snitchSrc)
    end

    self:enemyEvent(
        "prp-bridge:notify",
        "inform",
        locale("WAIT_FOR_LOCATION_DESC"),
        locale("WAIT_FOR_LOCATION")
    )
    self:teamEvent(
        "prp-bridge:notify",
        "inform",
        locale("GO_TO_AIRPORT_DESC"),
        locale("GO_TO_AIRPORT")
    )

    self.isActive = true
    self:syncMission()
end

function Aerial:getPlane(source, locationIndex)
    if self.stage ~= 0 or locationIndex ~= self.locationIndex then
        return
    end
    local playerIds = self:getPlayerIds()
    if not table.contains(playerIds, source) then
        return
    end

    local planeCoords = Config.Locations[self.locationIndex].planeCoords
    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = Config.PlaneModel,
        coords = planeCoords,
        heading = planeCoords.w,
    })

    if not vehicle then
        bridge.fw.notify(source, "error", locale("FAILED_VEH_SPAWN"))
        return
    end

    for _, playerId in pairs(playerIds) do
        bridge.vkeys.give(playerId, vehicle, plate)
    end

    self.plane = vehicle
    self.stage = 1

    bridge.inv.giveItem(source, Config.ParachuteItem, 1)
    bridge.fw.notify(source, "inform", locale("DROP_THE_CRATES_DESC"), locale("DROP_THE_CRATES"))

    for k, v in pairs(playerIds) do
        if v ~= source then
            bridge.fw.notify(v, "inform", locale("WAIT_FOR_CRATES_DESC"), locale("WAIT_FOR_CRATES"))
        end
    end

    self:syncMission()
end

function Aerial:dropCrate(source)
    if self.stage ~= 1 or self.crateCount <= 0 then
        return
    end
    local playerIds = self:getPlayerIds()
    if not table.contains(playerIds, source) then
        return
    end
    self.cratePositions = self.cratePositions or {}
    local freeCratePositions = {}
    for k, v in pairs(Config.Locations[self.locationIndex].caseCoords) do
        if not self.cratePositions[k] then
            table.insert(freeCratePositions, k)
        end
    end
    if #freeCratePositions == 0 then
        return
    end
    local cratePos = 1
    local planeCoords = GetEntityCoords(self.plane)
    local heading = GetEntityHeading(self.plane)
    local forwardVec = vec3(math.cos(math.rad(heading)), math.sin(math.rad(heading)), 0)
    local bestDot = -1.0
    for k, v in pairs(freeCratePositions) do
        local coords = Config.Locations[self.locationIndex].caseCoords[v]
        local dir = (coords - planeCoords)
        dir = dir / #dir
        local dotVec = forwardVec.x * dir.x + forwardVec.y * dir.y + forwardVec.z * dir.z
        if dotVec > bestDot then
            bestDot = dotVec
            cratePos = v
        end
    end
    self.cratePositions[cratePos] = true
    self.crates = self.crates or {}
    self.droppedCrates = self.droppedCrates or {}
    if #self.droppedCrates == 0 then
        local location = Config.Locations[self.locationIndex].caseCoords[cratePos]
        local radius = Config.Locations[self.locationIndex].areaRadius * 0.1

        local normalRadius = math.sqrt(math.random()) * radius;
        local angle = math.random() * 2 * math.pi

        location = vector3(
            location.x + math.cos(angle) * normalRadius,
            location.y + math.sin(angle) * normalRadius,
            location.z
        )

        local blip = lib.table.deepclone(Config.Dispatch.blip)

        blip.radius = radius

        bridge.dispatch.sendAlert(
            nil,
            Config.Dispatch.jobs,
            location,
            {
                code = Config.Dispatch.code,
                icon = Config.Dispatch.icon,
                title = Config.Dispatch.title,
                description = Config.Dispatch.description,
            },
            {
                sprite = Config.Dispatch.blip.icon,
                scale = Config.Dispatch.blip.size,
                colour = Config.Dispatch.blip.color,
                text = Config.Dispatch.title,
                length = Config.Dispatch.blip.duration,
                flash = Config.Dispatch.blip.flashing,
            }
        )
    end

    local crateIndex = #self.droppedCrates + 1
    local crateCoords = Config.Locations[self.locationIndex].caseCoords[cratePos]
    local duration = #(planeCoords - crateCoords) / 5.0
    self.droppedCrates[crateIndex] = {
        coords = crateCoords,
        dropTime = os.time(),
        looted = false,
        openTime = os.time() + Config.Mission.crateOpenTime + math.floor(duration),
    }

    self.crateCount = self.crateCount - 1
    if self.crateCount <= 0 then
        bridge.fw.notify(source, "inform", locale("LAND_THE_PLANE_DESC"), locale("LAND_THE_PLANE"))

        for k, v in pairs(playerIds) do
            if v ~= source then
                bridge.fw.notify(v, "inform", locale("ALL_CRATES_DROPPED_DESC"), locale("ALL_CRATES_DROPPED"))
            end
        end

        self.stage = 2
        self:enemyEvent(
            "prp-bridge:notify",
            "inform",
            locale("ENEMY_CRATES_DROPPED_DESC"),
            locale("ENEMY_CRATES_DROPPED")
        )

        if self.snitch then
            local snitchNumber = ("%s-%s"):format(math.random(1000, 9999), math.random(100, 999))
            Snitches[tostring(self.snitch)].notified = true
            bridge.phone.sendMessage(
                tonumber(self.snitch),
                snitchNumber,
                "SNITCH"
            )

            bridge.phone.sendCoords(
                tonumber(self.snitch),
                snitchNumber,
                crateCoords
            )
        end
        self:syncMission()
    else
        bridge.fw.notify(source, "inform", locale("CRATES_LEFT", self.crateCount))
    end

    lib.print.debug("Dropping crate at index %d for mission %s", crateIndex, self.id)
    TriggerClientEvent(
        "prp-aerialrun:dropCrate",
        -1,
        NetworkGetNetworkIdFromEntity(self.plane),
        self.locationIndex,
        cratePos
    )

    Wait(math.floor(duration * 1000))
    self.droppedCrates[crateIndex].dropped = true
    TriggerClientEvent("prp-aerialrun:addCrate", -1, self.locationIndex, self.droppedCrates[crateIndex], crateIndex)
end

function Aerial:leftPlane(source)
    if self.stage ~= 2 then
        return
    end
    local playerIds = self:getPlayerIds()
    if not table.contains(playerIds, source) then
        return
    end
    for i = -1, 20 do
        local targetPed = GetPedInVehicleSeat(self.plane, i)
        if targetPed ~= 0 then
            TaskLeaveVehicle(targetPed, self.plane, 4160)
        end
    end
    Citizen.SetTimeout(15 * 1000, function()
        if self.stage ~= 2 then
            return
        end
        if self.plane and DoesEntityExist(self.plane) then
            DeleteEntity(self.plane)
            self.plane = nil
        end
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end)
    self:syncMission()
end

function Aerial:openCrate(source, locationIndex, crateIndex)
    if self.stage ~= 2 or locationIndex ~= self.locationIndex then
        return
    end
    local playerIds = self:getPlayerIds()
    local enemyIds = self:getEnemyPlayerIds()
    local isEnemy = table.contains(enemyIds, source)
    local isPolice = false

    for _, job in pairs(Config.Dispatch.jobs) do
        if bridge.fw.hasJob(source, job, nil, true) then
            isPolice = true
            break
        end
    end

    if not table.contains(playerIds, source) and not isEnemy and not isPolice then
        bridge.fw.notify(source, "error", locale("NO_ACCESS_CRATES"))
        return
    end

    self.droppedCrates = self.droppedCrates or {}
    local crate = self.droppedCrates[crateIndex]
    if not crate or crate.looted or not crate.openTime or os.time() < crate.openTime or not crate.dropped then
        return
    end
    crate.looted = true

    local success = lib.callback.await("prp-bridge:progress", source, {
        duration = 10000,
        label = locale("OPENING_CRATE"),
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            flags = 49,
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })

    if not success then
        crate.looted = false
        return
    end
    if isEnemy or isPolice then
        crate.enemyLooted = true
    end

    local loot = GetLootReward(
        Config.CrateLoot.lootTableRolls,
        Config.CrateLoot.lootTable,
        Config.CrateLoot.guaranteedRarities
    )

    local lootNames = {}
    for k, v in pairs(loot or {}) do
        bridge.inv.giveItem(
            source,
            v.name,
            v.count,
            v.metaData
        )
        lootNames[#lootNames + 1] = ("%sx %s"):format(v.count, v.name)
    end

    bridge.log.send(Config.LogWebhook, "Crate Looted", "A player looted an aerial run crate.", {
        mission_id = self.id,
        character_id = bridge.fw.getIdentifier(source),
        player_name = GetPlayerName(source),
        is_enemy = isEnemy,
        is_police = isPolice,
        items = table.concat(lootNames, ", "),
    })

    TriggerClientEvent("prp-aerialrun:removeCrate", -1, locationIndex, crateIndex)

    local allLooted, teamLooted, enemyLooted = true, 0, 0
    for k, v in pairs(self.droppedCrates) do
        if not v.looted then
            allLooted = false
        else
            if v.enemyLooted then
                enemyLooted = enemyLooted + 1
            else
                teamLooted = teamLooted + 1
            end
        end
    end
    if allLooted then
        self:finish(enemyLooted > teamLooted)
    end
end

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(ActiveMissions) do
            local status, err = pcall(function()
                if v.isActive and (v.stage == 1) and v.plane and DoesEntityExist(v.plane) then
                    if GetVehicleEngineHealth(v.plane) < 200.0 and GetPedInVehicleSeat(v.plane, -1) ~= 0 then
                        v:finish(true)
                        v:teamEvent("prp-bridge:notify", "error", locale("PLANE_DAMAGED_DESC"), locale("PLANE_DAMAGED"))
                    end
                end
            end)
            if not status then
                print(err)
            end
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("prp-characters:server:characterSelected", function(source, stateId)
    local locations = {}
    for k, v in pairs(ActiveMissions) do
        locations[v.locationIndex] = v.droppedCrates
    end
    if next(locations) then
        TriggerClientEvent("prp-aerialrun:syncCrates", source, locations)
    end
end)
