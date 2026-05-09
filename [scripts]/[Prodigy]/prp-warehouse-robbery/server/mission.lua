---@class ServerWarehouse : OxClass
local ServerWarehouse = lib.class("ServerWarehouse")

---@type table<number, ServerWarehouse>
local warehouses = {}

local lastWarehouseCoords = {}

local currentBucket = 10000

---@type table<string, number>
local occupiedInteriors = {}

function ServerWarehouse:constructor(pSource, id, taskId, interior)
    self.guards = {}

    self.pSource = pSource
    self.stateId = bridge.fw.getIdentifier(pSource)

    self.group = exports['prp-bridge']:GetGroupIdFromMemberByIdentifier(self.stateId)

    local achievableEntitySets = {
        ENTITY_SETS[1],
        ENTITY_SETS[2],
        ENTITY_SETS[3]
    }

    self.entitySet = Mission.forceEntitySet or achievableEntitySets[math.random(1, #achievableEntitySets)]

    self.id = id
    self.room = 5
    self.taskId = taskId
    self.interior = interior
    self.states = {}

    occupiedInteriors[interior.key] = self.id

    self.safeRoom = math.random(1, #WarehouseCfg.safes)
    self.safeCode = math.random(1, #Codes)

    local boxIds = RollUnique(#WarehouseCfg.boxes[self.entitySet], #WarehouseCfg.boxes[self.entitySet], 5)

    self.boxIds = {
        1,
        2,
        3,
        4
    }

    for _, boxId in pairs(boxIds) do
        table.insert(self.boxIds, boxId)
    end

    local caseIds = RollUnique(#WarehouseCfg.cases[self.entitySet], #WarehouseCfg.cases[self.entitySet], 5)

    self.caseIds = {
        1,
        2,
        3,
        4
    }

    for _, caseId in pairs(caseIds) do
        table.insert(self.caseIds, caseId)
    end

    self.fuseIds = RollUnique(#WarehouseCfg.fuses[self.entitySet], 4)

    self.bucketId = ServerWarehouse:getNewBucket()

    TriggerClientEvent("prp-warehouse-robbery:setupWarehouse", -1, self.id)

    local group = exports['prp-bridge']:GetGroupByUuid(self.group)
    
    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            TriggerClientEvent("prp-warehouse-robbery:tempBlip", member.src, Entrances[self.id])
        end
    end

    self:sendSMSLocation(Entrances[self.id].xyz)

    self:notifyPhone(
        locale("SEARCH_FOR_THE_WAREHOUSE")
    )
end

function ServerWarehouse:notifyPhone(message)
    local group = exports['prp-bridge']:GetGroupByUuid(self.group)

    if not group then
        return
    end

    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            bridge.phone.sendNotification(
                member.src,
                locale("MISSION_LABEL"),
                message
            )
        end
    end
end

function ServerWarehouse:getNewBucket()
    currentBucket = currentBucket + 1

    return currentBucket
end

function ServerWarehouse:setBucketForEntity(entity, bucket)
    SetEntityRoutingBucket(entity, bucket or self.bucketId)
end

function ServerWarehouse:setBucketForPlayer(playerId, bucket)
    SetPlayerRoutingBucket(playerId, bucket or self.bucketId)
end

function ServerWarehouse:getDTO()
    return {
        id = self.id,
        states = self.states,
        boxIds = self.boxIds,
        caseIds = self.caseIds,
        fuseIds = self.fuseIds,
        room = self.room,

        safeRoom = self.safeRoom,
        safeCode = self.safeCode,

        entitySet = self.entitySet,
        interior = self.interior,
    }
end

function ServerWarehouse:setupGuards(pSource)
    for _, guardData in ipairs(WarehouseCfg.guards[self.room]) do
        local guardModel = WarehouseCfg.guardModels[self.entitySet]
        [math.random(1, #WarehouseCfg.guardModels[self.entitySet])]

        local spawnedGuard = lib.callback.await("prp-warehouse-robbery:setupGuard", pSource, guardData, self.room,
            guardModel)

        local guardHandle = NetworkGetEntityFromNetworkId(spawnedGuard)

        if guardHandle and DoesEntityExist(guardHandle) then
            self:setBucketForEntity(guardHandle)

            table.insert(self.guards, guardHandle)
        end
    end
end

function ServerWarehouse:getState(state)
    return self.states[state]
end

function ServerWarehouse:setState(state, value)
    self.states[state] = value

    TriggerClientEvent("prp-warehouse-robbery:updateWarehouseState", -1, self.id, state, value)
end

function ServerWarehouse:setRoom(roomId)
    self.room = roomId

    self:setupGuards(self.pSource)

    SetTimeout(30000, function()
        self:setupGuards(self.pSource)
    end)
end

function ServerWarehouse:cleanup()
    if self.guards then
        for _, guardHandle in ipairs(self.guards) do
            if guardHandle and DoesEntityExist(guardHandle) then
                DeleteEntity(guardHandle)
            end
        end
    end
end

function ServerWarehouse:enter(pSource)
    self.players = self.players or {}
    self.players[pSource] = true

    local ped = GetPlayerPed(pSource)
    local coords = GetEntityCoords(ped)

    if not self.hasDispatched then
        self.hasDispatched = true

        if math.random(1, 100) >= 30 then
            bridge.dispatch.sendAlert(
                nil,
                Mission.Alert.jobs,
                location,
                {
                    code = Mission.Alert.code,
                    icon = Mission.Alert.icon,
                    title = Mission.Alert.title,
                    description = Mission.Alert.description,
                },
                {
                    sprite = Mission.Alert.blip.icon,
                    scale = Mission.Alert.blip.size,
                    colour = Mission.Alert.blip.color,
                    text = Mission.Alert.title,
                    length = Mission.Alert.blip.duration,
                    flash = Mission.Alert.blip.flashing,
                }
            )
        end
    end

    self.hasEntered = true

    self:setBucketForPlayer(pSource)

    Player(pSource).state.OverrideCoords = coords

    if not self.spawnedGuards then
        self.spawnedGuards = true

        self:setupGuards(pSource)
    end

    return true
end

function ServerWarehouse:exit(pSource)
    if self.players then
        self.players[pSource] = nil
    end

    lastWarehouseCoords[pSource] = Entrances[self.id]

    Player(pSource).state.OverrideCoords = nil

    self:setBucketForPlayer(pSource, 0)

    local playersInWarehouse = 0

    for _, _ in pairs(self.players or {}) do
        playersInWarehouse = playersInWarehouse + 1
    end

    if playersInWarehouse == 0 then
        CreateThread(function()
            Wait(60000 * 5)

            playersInWarehouse = 0

            for _, _ in pairs(self.players or {}) do
                playersInWarehouse = playersInWarehouse + 1
            end

            if playersInWarehouse == 0 and warehouses[self.id] then
                StopMission(self.id)
            end
        end)
    end
end

function ServerWarehouse:sendSMSLocation(coords, targetSource)
    if targetSource then
        bridge.phone.sendCoords(
            targetSource,
            Mission.Phone.number,
            coords
        )
        return
    end

    local group = exports['prp-bridge']:GetGroupByUuid(self.group)

    if not group then
        return
    end

    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            bridge.phone.sendCoords(
                member.src,
                Mission.Phone.number,
                coords
            )
        end
    end
end

local function getFreeInterior()
    for _, interior in ipairs(svConfig.interiors) do
        if not occupiedInteriors[interior.key] then
            return interior
        end
    end

    return nil
end

local function getFreeMission()
    local totalMissions = #Entrances

    local occupied = {}

    for missionId, _ in pairs(MissionOngoing) do
        occupied[missionId] = true
    end

    local freeMissions = {}

    for i = 1, totalMissions do
        if not occupied[i] then
            table.insert(freeMissions, i)
        end
    end

    if #freeMissions == 0 then
        return nil
    end

    return freeMissions[math.random(1, #freeMissions)]
end

function StartMission(starter, taskId)
    local currentTaskId = taskId
    local stateId = bridge.fw.getIdentifier(starter)

    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(stateId)

    if not group then
        missionQeueue.setTaskIsExecuting(currentTaskId, false)
        return
    end

    local groupId = group.getUuid()

    if not groupId then
        return
    end

    local randomMission = getFreeMission()

    if not randomMission then
        missionQeueue.setTaskIsExecuting(currentTaskId, false)
        return
    end

    local interior = getFreeInterior()

    if not interior then
        missionQeueue.setTaskIsExecuting(currentTaskId, false)
        return
    end

    MissionOngoing[randomMission] = ServerWarehouse:new(starter, randomMission, currentTaskId, interior)
    warehouses[randomMission] = MissionOngoing[randomMission]

    local memberIds = {}
    for _, member in pairs(group.getMembers()) do
        exports['prp-bridge']:startCooldownByIdentifier(member.identifier, Mission.queueName, Mission.cooldown * 60)
        memberIds[#memberIds + 1] = member.identifier
    end

    bridge.log.send(Config.LogWebhook, "Warehouse Robbery Started", "A warehouse robbery mission has started.", {
        warehouse_id = randomMission,
        started_by = bridge.fw.getIdentifier(starter),
        player_name = GetPlayerName(starter),
        members = memberIds,
    })

    MissionCount = MissionCount + 1

    MissionOngoing[randomMission].timer = lib.timer((1000 * 60 * Mission.timeToFinish), function()
        if not MissionOngoing[randomMission] then
            return
        end

        StopMission(randomMission)
    end, true)
end

function StopMission(missionId)
    local mission = MissionOngoing[missionId]

    if not mission then
        return
    end

    bridge.log.send(Config.LogWebhook, "Warehouse Robbery Ended", "A warehouse robbery mission has ended.", {
        warehouse_id = missionId,
    })

    if mission.interior then
        occupiedInteriors[mission.interior.key] = nil
    end

    missionQeueue.setTaskIsExecuting(mission.taskId, false)

    MissionCount = MissionCount - 1

    mission:cleanup()

    if mission.timer then
        mission.timer:forceEnd(false)
    end

    MissionOngoing[missionId] = nil
    warehouses[missionId] = nil

    TriggerClientEvent("prp-warehouse-robbery:teardownWarehouse", -1, missionId)
end

lib.callback.register("prp-warehouse-robbery:checkState", function(pSource, warehouseId, state, expectedValue)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    return warehouse:getState(state) == expectedValue
end)

lib.callback.register("prp-warehouse-robbery:getWarehouseData", function(pSource, id)
    if not warehouses[id] then
        return {}
    end

    return warehouses[id]:getDTO()
end)

RegisterNetEvent("prp-warehouse-robbery:doAnimation", function(warehouseId, id, animationName)
    local pSource = source

    local pedHandle = GetPlayerPed(pSource)

    if not pedHandle or not DoesEntityExist(pedHandle) then
        return
    end

    local networkId = NetworkGetNetworkIdFromEntity(pedHandle)

    TriggerClientEvent("prp-warehouse-robbery:doAnimation", -1, warehouseId, id, animationName, networkId)
end)

RegisterNetEvent("prp-warehouse-robbery:setState", function(warehouseId, state, value)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return
    end

    warehouse:setState(state, value)
end)

lib.callback.register("prp-warehouse-robbery:takeFuse", function(pSource, warehouseId, id)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    if warehouse:getState(id) == "TAKEN" then
        return false
    end

    bridge.inv.giveItem(pSource, Mission.Other.Items.fuse, 1)

    warehouse:setState(id, "TAKEN")

    return true
end)

lib.callback.register("prp-warehouse-robbery:loot", function(pSource, warehouseId, id)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return nil, "Invalid warehouse."
    end

    if warehouse:getState(id) == "LOOTED" then
        return nil, locale("ALREADY_LOOTED")
    end

    warehouse:setState(id, "LOOTED")

    local hasBase = HasNumber(id)

    if not hasBase then
        return nil, "Invalid loot ID."
    end

    GiveRewards(pSource, WarehouseCfg.loot[hasBase].rolls, WarehouseCfg.loot[hasBase].table)

    bridge.log.send(Config.LogWebhook, "Warehouse Loot Taken", "A player looted a warehouse container.", {
        warehouse_id = warehouseId,
        loot_id = id,
        character_id = bridge.fw.getIdentifier(pSource),
        player_name = GetPlayerName(pSource),
    })

    return true
end)

lib.callback.register("prp-warehouse-robbery:unlockGate", function(pSource, warehouseId, id)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    if warehouse:getState(id) == "OPEN" then
        return false
    end

    if not bridge.inv.removeItem(pSource, Mission.Other.Items.fuse, Mission.Other.Items.requiredFuses) then
        return false
    end

    warehouse:setState(id, "OPEN")

    local hasBase, doorId = HasNumber(id)

    if not hasBase or not doorId then
        return false
    end

    warehouse:setState("door_" .. doorId, "OPEN")
    warehouse:setRoom(doorId)

    return true
end)

lib.callback.register("prp-warehouse-robbery:enterWarehouse", function(pSource, warehouseId)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    return warehouse:enter(pSource)
end)

lib.callback.register("prp-warehouse-robbery:leaveWarehouse", function(pSource, warehouseId)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    warehouse:exit(pSource)

    return true
end)

lib.callback.register("prp-warehouse-robbery:getActiveWarehouses", function()
    local active = {}

    for id, _ in pairs(warehouses) do
        active[id] = true
    end

    return active
end)

lib.callback.register("prp-warehouse-robbery:attemptUnlockSafe", function(pSource, warehouseId)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false, locale("INVALID_WAREHOUSE")
    end

    local safeValues = warehouse:getState("safeValues") or {}

    lib.print.debug(json.encode(safeValues, { indent = true }))

    local correctNumbers = 0

    for i = 1, 3 do
        if safeValues[i] and tonumber(safeValues[i]) == Codes[warehouse.safeCode].code[i] then
            correctNumbers = correctNumbers + 1
        end
    end

    lib.print.debug("Attempted code:", correctNumbers, "Real code:", Codes[warehouse.safeCode].code)

    if correctNumbers < 3 then
        bridge.log.send(Config.LogWebhook, "Safe Unlock Failed", "A player entered an incorrect safe code.", {
            warehouse_id = warehouseId,
            character_id = bridge.fw.getIdentifier(pSource),
            player_name = GetPlayerName(pSource),
            correct_numbers = correctNumbers,
        })
        return false, locale("SAFE_INCORRECT_CODE")
    end

    bridge.log.send(Config.LogWebhook, "Safe Unlocked", "A player successfully unlocked a warehouse safe.", {
        warehouse_id = warehouseId,
        character_id = bridge.fw.getIdentifier(pSource),
        player_name = GetPlayerName(pSource),
    })

    warehouse:setState("safe", "UNLOCKED")

    return true
end)

lib.callback.register("prp-warehouse-robbery:lootSafe", function(pSource, warehouseId)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    if warehouse:getState("safe") ~= "OPEN" then
        return false
    end

    local safeInventoryId = warehouse:getState("safeInventoryId")

    if safeInventoryId then
        bridge.inv.forceOpenStash(pSource, safeInventoryId)
    else
        local itemsInStash = lib.table.deepclone(Mission.BaseItemsInSafeStash)
        local items = GetRewards(WarehouseCfg.loot.safe.rolls, WarehouseCfg.loot.safe.table)

        for itemName, itemCount in pairs(items) do
            table.insert(itemsInStash, { itemName, itemCount })
        end

        local inventoryId = bridge.inv.createTemporaryStash({
            label = locale('SAFE_LABEL'),
            slots = 10,
            maxWeight = 100,
            items = itemsInStash
        })

        warehouse:setState("safeInventoryId", inventoryId)
        bridge.inv.forceOpenStash(pSource, inventoryId)
    end

    return true
end)

lib.callback.register("prp-warehouse-robbery:plantBomb", function(pSource, warehouseId)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return false
    end

    if warehouse:getState("safe") == "UNLOCKED" then
        return false
    end

    if bridge.inv.removeItem(pSource, Mission.Other.Items.bomb, 1) then
        warehouse:setState("safe", "UNLOCKED")

        return true
    end

    return false
end)

RegisterNetEvent("prp-warehouse-robbery:setSafeValue", function(warehouseId, position, value)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return
    end

    local safeValues = warehouse:getState("safeValues") or {}

    safeValues[position + 1] = value

    warehouse:setState("safeValues", safeValues)
end)

RegisterNetEvent("prp-warehouse-robbery:setSafePosition", function(warehouseId, position)
    local warehouse = warehouses[warehouseId]

    if not warehouse then
        return
    end

    warehouse:setState("safePosition", position)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for _, warehouse in pairs(warehouses) do
        StopMission(warehouse.id)
    end
end)

if EnableDebug then
    RegisterCommand("test_warehouse", function(pSource)
        warehouses[1] = ServerWarehouse:new(pSource, 1, 1)
    end)
end

lib.callback.register("prp-warehouse-robbery:getSavedCoords", function(pSource)
    return lastWarehouseCoords[pSource]
end)
