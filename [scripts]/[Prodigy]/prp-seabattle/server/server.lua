SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

local activeMissions = {}
local locations = {}
local currentId = 1

Crates = {}
CurrentCrateId = 1
ActiveLocations = {}

queue = nil

local function check(_, partyId)
    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then
        lib.print.debug('Queue check failed: party not found')
        queue.remove(party)

        return false
    end

    local memberCount = #party.getMembersAsArray()
    if memberCount < Config.Mission.minimalGroupSize then
        lib.print.debug('Group does not have enough members to start the mission')
        return false
    end

    for _, member in pairs(party.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, Config.Mission.name) then
            lib.print.debug('A member of the group is on cooldown for the mission')
            return false
        end
    end

    local isAnyLocationFree = IsAnyLocationFree()
    if not isAnyLocationFree then
        lib.print.debug('No crate locations are currently available')
        return false
    end

    return true
end

local function execute(_, partyId, _, taskId)
    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyId)

    if not group then
        queue.setTaskIsExecuting(taskId, false)
        return
    end

    local leader = group.getLeader()
    if not leader then
        queue.setTaskIsExecuting(taskId, false)
        return
    end

    local mission = StartSeaBattle(leader.src, taskId)
    mission:setInfoStage()
end

local function startup()
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

    TriggerClientEvent("prp-seabattle:client:startingLocations", src, locations)
end
RegisterNetEvent("prp-seabattle:server:requestStartingData", sendLocations)

local function openStartingMenu()
    local src = source

    local menu = {
        id = 'seabattle_starting_npc_menu',
        title = locale('SEABATTLE_STARTING_NPC_MENU_LABEL'),
        options = {}
    }

    local group = exports['prp-bridge']:GetGroupFromMember(src)
    if not group then
        bridge.fw.notify(src, 'error', locale('SEABATTLE_MISSION_GROUP_REQUIRED'))
        return
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = queue.isPartyIn(partyUuid)

    if isInQueue then
        local position = isInQueue and queue.getPartyPosition(partyUuid)
        menu.options[#menu.options + 1] = {
            title = locale('SEABATTLE_ALREADY_IN_QUEUE'),
            description = locale("SEABATTLE_ALREADY_IN_QUEUE_DESC", position),
        }
    else
        menu.options[#menu.options + 1] = {
            title = Config.Mission.label,
            description = Config.Mission.desc,
            serverEvent = 'prp-seabattle:client:requestJoinQueue',
            disabled = isInQueue,
            args = {
                queueName = Config.Mission.name
            }
        }
    end

    TriggerClientEvent('prp-seabattle:client:openMenu', src, menu)
end
RegisterNetEvent("prp-seabattle:server:openStartingMenu", openStartingMenu)

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
        bridge.fw.notify(src, 'error', locale('SEABATTLE_MISSION_GROUP_REQUIRED'))
        return
    end

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, mission.name) then
            return bridge.fw.notify(src, 'error', locale('SEABATTLE_MISSION_COOLDOWN'))
        end
    end

    local requiredItem = mission.requiredItem
    if requiredItem then
        if not bridge.inv.hasItem(src, requiredItem.name) then
            return bridge.fw.notify(src, 'error', locale('SEABATTLE_MISSING_REQUIRED_ITEM'))
        end

        if not bridge.inv.removeItem(src, requiredItem.name, requiredItem.count) then
            return bridge.fw.notify(src, 'error', locale('SEABATTLE_MISSING_REQUIRED_ITEM'))
        end
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    lib.print.debug('Adding to queue:', mission.name, stateId)
    local response = group.enterUniqueue(mission.name)

    if response and response.success then
        bridge.fw.notify(src, 'success', locale('SEABATTLE_QUEUE_ADDED'))
    else
        lib.print.debug('Failed to join seabattle queue:', response and response.error or 'unknown error')
        bridge.fw.notify(src, 'error', locale('SEABATTLE_MISSION_QUEUE_FAILED'))
    end
end
RegisterNetEvent("prp-seabattle:client:requestJoinQueue", joinQueue)

lib.callback.register("prp-seabattle:server:getCrates", function(playerId)
    return Crates
end)

function GetMissionTypeForPlayer()
    return "buoy"
end

function GetActiveMissionByGroupId(groupId)
    for missionId, mission in pairs(activeMissions) do
        if mission.groupId == groupId then
            return mission
        end
    end
    return nil
end

function GetCrateLocation(playerId, missionType)
    local availableCrateLocations = {}
    for i = 1, #Config.Crates do
        if Config.Crates[i].type == missionType and not ActiveLocations[i] then
            availableCrateLocations[#availableCrateLocations + 1] = i
        end
    end

    if #availableCrateLocations == 0 then
        return nil
    end

    return availableCrateLocations[math.random(1, #availableCrateLocations)]
end

function IsAnyLocationFree()
    local isFree = false
    for i = 1, #Config.Crates do
        if not ActiveLocations[i] then
            return true
        end
    end
    return isFree
end

function GetLootReward(lootRolls, lootTable, guaranteedRarities)
    if not lootRolls then
        lootRolls = 1
    end

    for _, loot in pairs(lootTable) do
        for _, item in pairs(loot) do
            if item.name:match("weapon_") then
                item.metadata = item.metadata or {}
                item.metadata.scratchedSerial = true
            end
        end
    end

    local loot = exports["prp-bridge"]:GenerateLoot(lootTable, lootRolls, guaranteedRarities)

    return loot
end

function SpawnVehicle(model, coords)
    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = model,
        coords = coords.xyz,
        heading = coords.w,
    })
    if not vehicle then
        return
    end
    local vehState = Entity(vehicle).state
    vehState.PlayerDriven = true
    vehState.NoCriminalActivities = true
    return { veh = vehicle, plate = plate }
end

function RemoveVehicle(entity)
    Entity(entity).state.Deleted = true
    DeleteEntity(entity)
end

function GetActiveMissionByPlayerId(playerId)
    local stateId = bridge.fw.getIdentifier(playerId)
    local group = exports['prp-bridge']:GetGroupFromMember(playerId)
    local groupId = group and group.getUuid() or nil

    for uniqueId, mission in pairs(activeMissions) do
        if mission.stateId == stateId or (groupId and mission.groupId == groupId) then
            return mission
        end
    end
end

function StartSeaBattle(playerId, taskId)
    local missionId = currentId

    local missionType = GetMissionTypeForPlayer()

    activeMissions[missionId] = SeaBattle:new(playerId, {
        faction = nil,
        id = missionId,
        reservedLocation = GetCrateLocation(playerId, missionType),
        missionType = missionType,
        taskId = taskId,
    })
    currentId = currentId + 1

    return activeMissions[missionId]
end

function DestroyMission(missionId)
    activeMissions[missionId] = nil
end

RegisterServerEvent("prp-seabattle:server:infoTalked", function()
    local playerId = source

    local mission = GetActiveMissionByPlayerId(playerId)

    if not mission then
        return
    end

    if mission.currentStage ~= 'getInfo' then
        return
    end

    mission:infoTalked(playerId)
end)

RegisterServerEvent("prp-seabattle:server:boatTalked", function(npcId)
    local playerId = source

    local mission = GetActiveMissionByPlayerId(playerId)

    if mission.gearTaken then
        return
    end

    if not mission then
        return
    end

    mission:boatTalked(playerId, npcId)

    mission:syncMission()
end)

RegisterServerEvent("prp-seabattle:server:removeCrateRope", function(crateId)
    local playerId = source
    if not crateId or not Crates[crateId] then
        return
    end
    Crates[crateId].hasRope = false
    TriggerClientEvent("prp-seabattle:client:crateRopeRemoved", -1, crateId)

    bridge.fw.notify(playerId, 'success', locale("SEABATTLE_ROPE_REMOVED_NOTIFY"))
end)

RegisterServerEvent("prp-seabattle:server:attachCrateRope", function(crateId, vehNetId)
    local playerId = source
    if not crateId or not Crates[crateId] then
        return
    end

    bridge.inv.removeItem(playerId, "sb_boat_rope", 1)

    local veh = NetworkGetEntityFromNetworkId(vehNetId)

    local crateModel = Config.CrateModels.closed

    local crate = CreateObject(crateModel, Config.Crates[Crates[crateId].location].cratePos.x,
        Config.Crates[Crates[crateId].location].cratePos.y, Config.Crates[Crates[crateId].location].cratePos.z, true,
        true, false)
    while not DoesEntityExist(crate) do
        Citizen.Wait(0)
    end
    TriggerClientEvent("prp-seabattle:client:crateAttached", -1, crateId)

    Crates[crateId].serverEntity = crate
    Crates[crateId].attachedTo = veh
    Crates[crateId].dontSpawn = true

    Entity(veh).state.attachedCrate = NetworkGetNetworkIdFromEntity(crate)
    Entity(veh).state.attachedCrateId = crateId

    bridge.fw.notify(playerId, 'inform', locale("SEABATTLE_DELIVERY_CRATE_NOTIFY"))

    DestroyZone(crateId)

    local playerMission = GetActiveMissionByPlayerId(playerId)
    if playerMission and playerMission.id == Crates[crateId].missionId then
        playerMission:event("prp-seabattle:markDeliveryLocations", crateId)
    else
        TriggerClientEvent("prp-seabattle:markDeliveryLocations", playerId, crateId)
        activeMissions[Crates[crateId].missionId]:crateStolen()
    end
end)

RegisterServerEvent("prp-seabattle:server:deliveryCrate", function(pointId, crateId)
    local playerId = source

    if not Crates[crateId] then
        return
    end

    local veh = Crates[crateId].attachedTo

    if not veh then
        return
    end

    Entity(veh).state.attachedCrate = nil
    Entity(veh).state.attachedCrateId = nil

    Crates[crateId].attachedTo = nil

    Crates[crateId].usedDeliveryPoint = pointId

    DeleteEntity(Crates[crateId].serverEntity)
    Crates[crateId].serverEntity = nil
    Crates[crateId].openingTime = os.time()

    TriggerClientEvent("prp-seabattle:client:startCrateOpening", -1, crateId, pointId, Crates[crateId].faction,
        Crates[crateId].openingTime)
    StartOpeningCrate(crateId)

    bridge.fw.notify(playerId, 'inform', locale("SEABATTLE_WAIT_FOR_GPS_NOTIFY"))
end)

function StartOpeningCrate(crateId)
    Citizen.CreateThread(function()
        Citizen.Wait(Config.Mission.gpsRemoving * 1000)
        if not Crates[crateId] then
            return
        end
        Crates[crateId].opened = true
        TriggerClientEvent("prp-seabattle:client:finishCrateOpening", -1, crateId)
    end)
end

RegisterServerEvent("prp-seabattle:server:getCrateRewards", function(crateId)
    local playerId = source
    if not Crates[crateId] then
        return
    end

    if not Crates[crateId].opened then
        return
    end

    Crates[crateId].looted = true

    local stolen = playerFaction ~= Crates[crateId].faction
    if stolen then
        Crates[crateId].stolen = true
    else
        bridge.fw.notify(playerId, 'inform', locale("SEABATTLE_RETURN_NOTIFY"))
    end

    local loot = GetLootReward(Config.CrateLoot.lootTableRolls, Config.CrateLoot.lootTable,
        Config.CrateLoot.guaranteedRarities)
    local lootNames = {}
    for k, v in pairs(loot or {}) do
        bridge.inv.giveItem(playerId, v.name, v.count, v.metaData)
        lootNames[#lootNames + 1] = ("%sx %s"):format(v.count, v.name)
    end

    bridge.log.send(Config.LogWebhook, "Sea Battle Crate Looted", "A player looted a sea battle crate.", {
        crate_id = crateId,
        character_id = bridge.fw.getIdentifier(playerId),
        player_name = GetPlayerName(playerId),
        stolen = stolen,
        items = table.concat(lootNames, ", "),
    })

    TriggerClientEvent("prp-seabattle:client:crateLooted", -1, crateId)
end)

RegisterServerEvent("prp-seabattle:server:returnBoat", function()
    local playerId = source

    local mission = GetActiveMissionByPlayerId(playerId)

    if not mission then
        return
    end

    if not mission.gearTaken then
        return
    end

    mission:returnBoat(playerId)

    if not Crates[mission.crateId] or Crates[mission.crateId].looted then
        local wasStolen = Crates[mission.crateId].stolen
        if not wasStolen then
            local loot = GetLootReward(Config.MissionLoot.lootTableRolls, Config.MissionLoot.lootTable,
                Config.MissionLoot.guaranteedRarities)
            for k, v in pairs(loot or {}) do
                bridge.inv.giveItem(playerId, v.name, v.count, v.metaData)
            end
            bridge.fw.notify(playerId, 'inform', locale("SEABATTLE_MISSION_COMPLETED_NOTIFY"))
        else
            bridge.fw.notify(playerId, 'error', locale("SEABATTLE_MISSION_FAILED_NOTIFY"))
        end

        bridge.log.send(Config.LogWebhook, "Sea Battle Finished", "A sea battle mission has finished.", {
            character_id = bridge.fw.getIdentifier(playerId),
            player_name = GetPlayerName(playerId),
            crate_stolen = wasStolen,
        })

        mission:finish()
        return
    end
    mission:syncMission()
end)

function SpawnBoat(model, coords)
    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = model,
        coords = coords.xyz,
        heading = coords.w,
    })

    if not vehicle then
        return
    end

    return vehicle, plate
end

local spawnedGuards = {}
local playersInZones = {}
local zonesForPlayers = {}

local function randomOffset(value)
    if math.random(1, 2) == 1 then
        return value
    else
        return value * -1
    end
end

local function getCoordsForNewBoat(preparedBoats, cratePos, offset)
    local randomPos = nil
    local foundCoords = true
    ::findCoords::
    randomPos = vector4(cratePos.x + randomOffset(30.0), cratePos.y + randomOffset(30.0), cratePos.z + 1.0,
        math.random(0, 360))
    for i = 1, #preparedBoats do
        local boat = preparedBoats[i]
        if boat and boat.pos then
            if #(boat.pos.xyz - randomPos.xyz) < 25.0 then
                foundCoords = false
            end
        end
    end
    Citizen.Wait(0)
    if not foundCoords then
        goto findCoords
    end
    return randomPos
end

local function prepareZone(crateId, playerId)
    if not spawnedGuards[crateId] then
        spawnedGuards[crateId] = {}
        spawnedGuards[crateId].boats = {}
        spawnedGuards[crateId].savedBoats = {}
        spawnedGuards[crateId].guards = {}
        spawnedGuards[crateId].savedGuards = {}
    end

    local cratePos = Config.Crates[Crates[crateId].location].cratePos

    for i = 1, Config.BoatsCount do
        local boatPos

        if not spawnedGuards[crateId].boats[i] or not spawnedGuards[crateId].boats[i].boat then
            if not spawnedGuards[crateId].boats[i] then
                spawnedGuards[crateId].boats[i] = {}
            end
            if not spawnedGuards[crateId].guards[i] then
                spawnedGuards[crateId].guards[i] = {}
            end
            if not spawnedGuards[crateId].boats[i].pos then
                boatPos = getCoordsForNewBoat(spawnedGuards[crateId].boats, cratePos, 30.0)
                spawnedGuards[crateId].boats[i].pos = boatPos
            end
            local boat, plate = SpawnBoat(Config.GuardsBoat, spawnedGuards[crateId].boats[i].pos)
            if boat then
                local boatNetId = NetworkGetNetworkIdFromEntity(boat)
                spawnedGuards[crateId].boats[i].boat = boat
                spawnedGuards[crateId].boats[i].plate = plate
                spawnedGuards[crateId].boats[i].netId = boatNetId

                Citizen.Wait(150)

                local currentSeat = -1
                for j = 1, Config.GuardsCount do
                    if not spawnedGuards[crateId].guards[i][j] then
                        spawnedGuards[crateId].guards[i][j] = {}
                    end
                    if not spawnedGuards[crateId].guards[i][j].dead then
                        local pedModel = Config.GuardModels[math.random(1, #Config.GuardModels)]
                        if spawnedGuards[crateId].guards[i][j].model then
                            pedModel = spawnedGuards[crateId].guards[i][j].model
                        end
                        local pedPos = spawnedGuards[crateId].boats[i].pos

                        local ped = CreatePed(0, pedModel, pedPos.x, pedPos.y, pedPos.z, 0.0, true, true)
                        local timeout = 0
                        while not DoesEntityExist(ped) and timeout <= 50 do
                            timeout = timeout + 1
                            Citizen.Wait(10)
                        end
                        local pedNetId = NetworkGetNetworkIdFromEntity(ped)
                        spawnedGuards[crateId].guards[i][j].ped = ped
                        spawnedGuards[crateId].guards[i][j].netId = pedNetId
                        spawnedGuards[crateId].guards[i][j].model = pedModel
                        spawnedGuards[crateId].guards[i][j].dead = false
                        Citizen.Wait(25)
                        SetPedIntoVehicle(ped, spawnedGuards[crateId].boats[i].boat, currentSeat)

                        Citizen.Wait(10)

                        if GetVehiclePedIsIn(ped, false) ~= spawnedGuards[crateId].boats[i].boat then
                            SetPedIntoVehicle(ped, spawnedGuards[crateId].boats[i].boat, currentSeat)
                        end

                        Citizen.Wait(10)
                    end
                    currentSeat = currentSeat + 1
                end
            end
        end
    end

    for i = 1, #spawnedGuards[crateId].boats do
        local boatOwner = NetworkGetEntityOwner(spawnedGuards[crateId].boats[i].boat)
        local pedsNetIds = {}
        for j = 1, #spawnedGuards[crateId].guards[i] do
            if not spawnedGuards[crateId].guards[i][j].dead then
                pedsNetIds[#pedsNetIds + 1] = spawnedGuards[crateId].guards[i][j].netId
            end
        end

        TriggerClientEvent("prp-seabattle:client:setupGuards", boatOwner, spawnedGuards[crateId].boats[i].netId,
            pedsNetIds)
    end
end

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(spawnedGuards) do
            local cratePos = Config.Crates[Crates[k].location].cratePos
            for i = 1, #v.boats do
                local boat = v.boats[i]
                if boat.boat and DoesEntityExist(boat.boat) and #(cratePos - GetEntityCoords(boat.boat)) >= 250.0 then
                    DeleteEntity(boat.boat)
                    v.boats[i].boat = nil
                    v.boats[i].plate = nil
                    v.boats[i].netId = nil
                    for j = 1, #v.guards[i] do
                        DeleteEntity(v.guards[i][j].ped)
                        v.guards[i][j].ped = nil
                        v.guards[i][j].netId = nil
                    end
                end
            end
        end
        Citizen.Wait(10000)
    end
end)

local function cleanupZone(crateId)
    if not spawnedGuards[crateId] then
        return
    end

    if spawnedGuards[crateId].boats and #spawnedGuards[crateId].boats > 0 then
        for i = 1, #spawnedGuards[crateId].boats do
            if spawnedGuards[crateId].boats[i].boat then
                DeleteEntity(spawnedGuards[crateId].boats[i].boat)
            end
            spawnedGuards[crateId].boats[i].boat = nil
            spawnedGuards[crateId].boats[i].plate = nil
            spawnedGuards[crateId].boats[i].netId = nil

            for j = 1, #spawnedGuards[crateId].guards[i] do
                if spawnedGuards[crateId].guards[i][j].ped then
                    if GetEntityHealth(spawnedGuards[crateId].guards[i][j].ped) <= 0 then
                        spawnedGuards[crateId].guards[i][j].dead = true
                    end
                    DeleteEntity(spawnedGuards[crateId].guards[i][j].ped)
                end
                spawnedGuards[crateId].guards[i][j].ped = nil
                spawnedGuards[crateId].guards[i][j].netId = nil
            end
        end
    end
end

function DestroyZone(crateId)
    cleanupZone(crateId)
    spawnedGuards[crateId] = nil
end

function DestroyZone2(crateId)
    if not spawnedGuards[crateId] then
        return
    end
    if #spawnedGuards[crateId].guards > 0 then
        for i = 1, #spawnedGuards[crateId].guards do
            if spawnedGuards[crateId].guards[i] and spawnedGuards[crateId].guards[i].ped then
                DeleteEntity(spawnedGuards[crateId].guards[i].ped)
            end
        end
    end
    if spawnedGuards[crateId].boat then
        DeleteEntity(spawnedGuards[crateId].boat)
    end
    spawnedGuards[crateId] = nil
end

RegisterServerEvent("prp-seabattle:server:zone", function(crateId, state)
    if not Crates[crateId] then
        lib.print.debug("Invalid crateId " .. tostring(crateId) .. " for zone event")
        return
    end
    if Crates[crateId].dontSpawn then
        lib.print.debug("Not spawning zone for crate " .. crateId .. " because dontSpawn is true")
        return
    end
    local playerId = source
    if state then
        if not playersInZones[crateId] or not next(playersInZones[crateId]) then
            if not playersInZones[crateId] then
                playersInZones[crateId] = {}
            end
            playersInZones[crateId][playerId] = true
            zonesForPlayers[playerId] = crateId
            prepareZone(crateId, playerId)
        end
        if not playersInZones[crateId] then
            playersInZones[crateId] = {}
        end
        playersInZones[crateId][playerId] = true
        zonesForPlayers[playerId] = crateId
    else
        playersInZones[crateId][playerId] = nil
        zonesForPlayers[playerId] = nil
        if not next(playersInZones[crateId]) then
            cleanupZone(crateId)
            playersInZones[crateId] = nil
        end
    end
end)

AddEventHandler("playerDropped", function(reason)
    local playerId = source
    if zonesForPlayers[playerId] then
        playersInZones[zonesForPlayers[playerId]][playerId] = nil
        if not next(playersInZones[zonesForPlayers[playerId]]) then
            playersInZones[zonesForPlayers[playerId]] = nil
        end
        zonesForPlayers[playerId] = nil
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    for k, v in pairs(Crates) do
        DestroyZone(k)
    end

    for uniqueId, mission in pairs(activeMissions) do
        mission:cleanup()
    end
end)
