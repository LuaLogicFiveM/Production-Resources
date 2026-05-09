SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")


queue = nil

lib.callback.register("prp-gun-smuggling:getItemData", function(_, itemName)
    return bridge.inv.getItemData(itemName)
end)

MySQL.ready(function()
    local sqls = {
        [[
            create table if not exists gun_smuggling_cnc
            (
                id           int auto_increment
                    primary key,
                mission_id   int(1)                                 null,
                started_by   varchar(255)                                    null,
                picked_up    tinyint(1) default 0                   null,
                started_at   timestamp  default current_timestamp() null,
                picked_up_at timestamp  default current_timestamp() null on update current_timestamp()
            ) collate = utf8mb4_general_ci;
        ]],
        [[
            create index if not exists gun_smuggling_cnc_mission_id_index
                on gun_smuggling_cnc (mission_id);
        ]],
        [[
            create index if not exists gun_smuggling_cnc_started_by_index
                on gun_smuggling_cnc (started_by);
        ]],
        [[
            create table if not exists gun_smuggling_airfield
            (
                id           int auto_increment
                    primary key,
                started_by   varchar(255)                                    not null,
                mission_id   int(1)                                 not null,
                picked_up    tinyint(1) default 0                   not null,
                started_at   timestamp  default current_timestamp() null,
                picked_up_at timestamp  default current_timestamp() null on update current_timestamp()
            );
        ]],
        [[
            create index if not exists gun_smuggling_airfield_mission_id_index
                on gun_smuggling_airfield (mission_id);
        ]]
    }

    for _, sql in ipairs(sqls) do
        MySQL.query.await(sql)
    end
end)



local SMUGGLING = {}
local ActiveMissions = {}
local selectedMissions = {}
local inUseLocations = {}

local function getFreeLocationIndex(removeLocation)
    if not Config or not Config.LOCATIONS or #Config.LOCATIONS == 0 then
        return nil
    end

    local freeLocations = {}

    for index = 1, #Config.LOCATIONS do
        if not inUseLocations[index] then
            table.insert(freeLocations, index)
        end
    end

    if #freeLocations == 0 then
        return nil
    end

    local locationId = freeLocations[math.random(1, #freeLocations)]
    if removeLocation then
        inUseLocations[locationId] = true
    end

    return locationId
end

local function getMissionByGroupId(groupId)
    return ActiveMissions[groupId]
end

local function countItems(inventory, itemName, metaData)
    local items = bridge.inv.getInventoryItems(inventory)
    local total = 0
    for _, item in pairs(items) do
        if item.name == itemName then
            if metaData then
                local match = true
                for key, value in pairs(metaData) do
                    if not item.metadata or item.metadata[key] ~= value then
                        match = false
                        break
                    end
                end

                if match then
                    total = total + item.count
                end
            else
                total = total + item.count
            end
        end
    end

    return total
end

local function check(_, partyId)
    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then
        queue.remove(party)

        lib.print.debug("No party found for ID:", partyId)
        return false
    end

    local locationIndex = getFreeLocationIndex()
    if not locationIndex then
        return false
    end

    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyId)
    if not group then
        queue.remove(party)

        return false
    end

    local leader = group.getLeader()
    if not leader then
        queue.remove(party)

        return false
    end

    local missionId = selectedMissions[leader.identifier]
    if not missionId or not Config.MISSIONS or not Config.MISSIONS[missionId] then
        return false
    end

    return true
end

local function execute(_, partyId, _, taskId)
    local party = exports['prp-bridge']:GetParty(partyId)
    if not party then
        queue.remove(party)

        return false
    end

    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyId)
    if not group then
        queue.remove(party)

        return false
    end

    local leader = group.getLeader()
    if not leader then
        queue.remove(party)

        return false
    end

    local freeLocation = getFreeLocationIndex()
    local groupId = group.getUuid()
    local missionId = selectedMissions[leader.identifier]

    local smuggling = SMUGGLING:new({
        stateId = leader.identifier,
        source = leader.src,
        groupId = groupId,
        missionId = missionId,
        locationId = freeLocation,
        taskId = taskId
    })

    local locationData = Config.LOCATIONS[freeLocation]
    local coords = locationData.ped

    for _, member in pairs(group.getMembers()) do
        bridge.phone.sendMessage(member.src, Config.Mission.phoneNumber, locale("SMUGGLING_TEXT"))
        Wait(100)
        bridge.phone.sendCoords(member.src, Config.Mission.phoneNumber, vector3(coords.x, coords.y, coords.z))
    end

    ActiveMissions[groupId] = smuggling
    selectedMissions[leader.identifier] = nil

    smuggling:thread()
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

    if Config.ResetCommand and Config.ResetCommand.enabled then
        bridge.fw.registerCommand(
            "reset_sling", locale("RESET_GUN_SMUGGLING_IF_BUGGED"), {}, "admin",
            function(src, args, rawCommand)
                local hadAny = false

                for _, mission in pairs(ActiveMissions) do
                    if mission then
                        hadAny = true
                        mission:destroy()
                    end
                end

                ActiveMissions = {}

                if hadAny then
                    bridge.fw.notify(src, "success", locale("GUN_SMUGGLING_MISSIONS_HAVE_BEEN_RESET"))
                else
                    bridge.fw.notify(src, "error", locale("GUN_SMUGGLING_NO_MISSION_IS_CURRENTLY_ACTIVE"))
                end
            end)
    end
end
SetTimeout(0, startup)

function SMUGGLING:new(data)
    local this = {
        source = data.source,
        stateId = data.stateId,
        taskId = data.taskId,

        airfield = math.random(1, #Config.AIRFIELDS),
        groupId = data.groupId,
        missionId = data.missionId or 1,
        locationId = data.locationId or 1,

        stage = 0,
        started = os.time(),

        handles = {}
    }

    setmetatable(this, self)
    self.__index = self

    return this
end

function SMUGGLING:notify(message)
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
    if not group then return end

    for _, member in pairs(group.getMembers()) do
        bridge.phone.sendMessage(member.src, Config.Mission.phoneNumber, message)
    end
end

function SMUGGLING:destroy()
    if self.handles then
        for _, handle in ipairs(self.handles) do
            if DoesEntityExist(handle) then
                DeleteEntity(handle)
            end
        end
    end

    if self.stage then
        if self.stage < 4 then
            self:notify(locale("SMUGGLING_MISSION_FAILED"))
        else
            self:notify(locale("SMUGGLING_MISSION_COMPLETED_TEXT"))
        end
    end

    ActiveMissions[self.groupId] = nil
    inUseLocations[self.locationId] = nil
end

function SMUGGLING:setStage(stage)
    self.stage = stage

    if stage == 6 then
        self.started = os.time() + Cocaine.WaitTime
    else
        self.started = os.time()
    end
end

function SMUGGLING:getStage()
    return self.stage
end

function SMUGGLING:getDTO()
    local missionId = self.missionId
    local loadedItems = nil

    if self.stage == 1 then
        while not self.plate do
            Wait(100)
        end

        local vehicleTrunk = "glove" .. self.plate

        local itemsRequired = 0
        local totalItems = #Config.MISSIONS[missionId].items

        for _, item in ipairs(Config.MISSIONS[missionId].items) do
            local succ, response = pcall(function()
                local itemCount = bridge.inv.count(vehicleTrunk, item.name)

                return itemCount or 0
            end)


            if succ and response >= item.count then
                itemsRequired = itemsRequired + 1
            end
        end

        loadedItems = itemsRequired == totalItems
    end

    return {
        mission = missionId or self.mission,
        verifiedContract = self.stage >= 1,
        airfield = self.airfield,
        loadedItems = loadedItems,
        counts = self:getHandedCounts()
    }
end

function SMUGGLING:getHandedCounts()
    return self.counts or {}
end

function SMUGGLING:incrementHandedCount(itemName, count)
    if not self.counts then
        self.counts = {}
    end

    if not self.counts[itemName] then
        self.counts[itemName] = 0
    end

    self.counts[itemName] = self.counts[itemName] + count
end

function SMUGGLING:spawnBoat()
    local boatHandle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = Config.BoatModel,
        coords = Config.LOCATIONS[self.locationId].boat,
        heading = Config.LOCATIONS[self.locationId].boat.w,
    })

    if not boatHandle or not DoesEntityExist(boatHandle) then
        return false, locale("FAILED_TO_SPAWN_BOAT")
    end

    self:notify(locale("FILL_BOAT_WITH_GOODS"))

    self.plate = plate
    self.boatSpawned = true
    table.insert(self.handles, boatHandle)

    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)

    for _, member in pairs(group.getMembers()) do
        bridge.vkeys.give(member.src, boatHandle, plate)
    end

    return true
end

function SMUGGLING:spawnGuards(playerId)
    local netIds = lib.callback.await("prp-gun-smuggling:spawnGuards", playerId, self.locationId)

    for _, netId in ipairs(netIds) do
        local entityHandle = NetworkGetEntityFromNetworkId(netId)

        if entityHandle and DoesEntityExist(entityHandle) then
            local entityType = GetEntityType(entityHandle)

            if entityType == 2 then
                Entity(entityHandle).state.DisableLockpick = true

                SetVehicleDoorsLocked(entityHandle, 2)
            end

            table.insert(self.handles, entityHandle)
        end
    end
end

function SMUGGLING:thread()
    local handle = self

    Citizen.CreateThreadNow(function()
        while ActiveMissions[handle.groupId] do
            local sleepThread = 1000

            if os.time() - handle.started >= Config.Timeout then
                handle:destroy()
                return
            end

            if handle:getStage() == 1 and not handle.boatSpawned then
                local boatLocation = Config.LOCATIONS[handle.locationId].boat

                local group = exports['prp-bridge']:GetGroupByUuid(handle.groupId)

                for _, member in pairs(group.getMembers()) do
                    local playerPed = GetPlayerPed(member.src)

                    if playerPed and DoesEntityExist(playerPed) then
                        local playerCoords = GetEntityCoords(playerPed)

                        if #(playerCoords - boatLocation.xyz) < 150.0 then
                            handle:spawnBoat()

                            break
                        end
                    end
                end
            elseif handle:getStage() == 2 then
                local pedLocation = Config.LOCATIONS[handle.locationId].ped

                local group = exports['prp-bridge']:GetGroupByUuid(handle.groupId)

                for _, member in pairs(group.getMembers()) do
                    local playerPed = GetPlayerPed(member.src)

                    if playerPed and DoesEntityExist(playerPed) then
                        local playerCoords = GetEntityCoords(playerPed)

                        if #(playerCoords - pedLocation.xyz) > 150.0 then
                            handle:setStage(3)
                            handle:spawnGuards(member.src)

                            break
                        end
                    end
                end
            elseif handle:getStage() == 3 then
                local dropOff = Config.DROP_OFFS[handle.dropOff]

                local dropOffLocation = dropOff.center

                local group = exports['prp-bridge']:GetGroupByUuid(handle.groupId)
                if not group then
                    handle:destroy()
                    return
                end

                for _, member in pairs(group.getMembers()) do
                    local playerPed = GetPlayerPed(member.src)

                    if playerPed and DoesEntityExist(playerPed) then
                        local playerCoords = GetEntityCoords(playerPed)

                        if #(playerCoords - dropOffLocation) < 75.0 then
                            handle:setStage(4)
                            handle:notify(locale("REACHED_DROP_OFF"))

                            break
                        end
                    end
                end
            end

            Wait(sleepThread)
        end
    end)
end

lib.callback.register("prp-crime:smuggling:getQueue", function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)
    if not stateId then
        return false
    end

    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        bridge.fw.notify(pSource, 'error', locale('MISSION_GROUP_REQUIRED'))
        return false
    end

    local partyUuid = group.getPartyUuid()
    local isInQueue = queue.isPartyIn(partyUuid)
    if isInQueue then
        local missionId = selectedMissions[stateId]
        local missionData = missionId and Config.MISSIONS[missionId]
        local missionLabel = missionData and missionData.label or "Unknown"

        return missionLabel
    end

    local missions = {}
    for id, smuggling in pairs(Config.MISSIONS) do
        local missionData = {
            id = id,
            label = smuggling.label
        }

        local requiredItem = smuggling.requiredContractItem
        if requiredItem and bridge.inv.count(pSource, requiredItem) > 0 then
            missions[#missions + 1] = missionData
        end
    end

    return missions
end)

lib.callback.register("prp-crime:smuggling:queueForMission", function(pSource, missionId)
    if not missionId or not Config.MISSIONS or not Config.MISSIONS[missionId] then
        return false, locale("NO_ACCESS")
    end

    if not Config.LOCATIONS or #Config.LOCATIONS == 0 then
        return false, locale("NO_ROUTES_AVAILABLE")
    end

    local stateId = bridge.fw.getIdentifier(pSource)
    if not stateId then
        return false, locale("NO_ACCESS")
    end

    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        return false, locale("YOU_MUST_BE_IN_GROUP_TO_SMUGGLE")
    end

    if selectedMissions[stateId] then
        return false, locale("YOU_ARE_ALREADY_IN_SMUGGLING_QUEUE")
    end

    for _, member in pairs(group.getMembers()) do
        if selectedMissions[member.identifier] then
            return false, locale("GROUP_MEMBER_IN_QUEUE")
        end
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    local response = group.enterUniqueue(Config.Mission.name)

    if response and response.success then
        selectedMissions[stateId] = missionId
        bridge.fw.notify(pSource, 'success', locale('QUEUE_ADDED'))
    else
        lib.print.debug('Failed to join queue:', response and response.error or 'unknown error')
        bridge.fw.notify(pSource, 'error', locale('MISSION_QUEUE_FAILED'))
    end

    return true
end)

lib.callback.register('prp-crime:smuggling:leaveQueue', function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)
    if not stateId then
        return false, locale("NO_ACCESS")
    end

    selectedMissions[stateId] = nil

    local group = exports['prp-bridge']:GetGroupFromMember(source)
    if not group then
        return false, locale("YOU_MUST_BE_IN_GROUP_TO_SMUGGLE")
    end

    if not queue.isPartyIn(group.getPartyUuid()) then
        return false, locale("YOU_ARE_NOT_IN_QUEUE")
    end

    local party = exports['prp-bridge']:GetParty(group.getPartyUuid())
    if not party then
        return false, locale("NO_ACCESS")
    end

    queue.remove(party)

    return true
end)

lib.callback.register("prp-crime:smuggling:isInMission", function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        return false
    end

    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        return false
    end

    local groupId = group.getUuid()

    local mission = groupId and getMissionByGroupId(groupId)
    if not mission then
        return false, locale("NOT_IN_SMUGGLING_MISSION")
    end

    Wait(100)

    return true, mission:getDTO()
end)

lib.callback.register("prp-crime:smuggling:talkToPed", function(pSource)
    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        return false, locale("BRING_ME_GUN_PARTS")
    end

    local groupId = group.getUuid()
    local currentSmuggling = groupId and getMissionByGroupId(groupId)
    if not currentSmuggling then
        return false, locale("BRING_ME_GUN_PARTS")
    end

    local missionId = currentSmuggling.missionId
    local missionData = Config.MISSIONS[missionId]
    local contractItem = missionData.requiredContractItem

    if bridge.inv.removeItem(pSource, contractItem, 1) then
        currentSmuggling:setStage(1)
        return true
    end

    return false, locale("DONT_HAVE_WHAT_I_NEED")
end)

lib.callback.register("prp-crime:smuggling:startMission", function(pSource)
    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        return false, locale("NOT_IN_SMUGGLING_MISSION")
    end

    local groupId = group.getUuid()
    local currentSmuggling = groupId and getMissionByGroupId(groupId)

    if not currentSmuggling then
        return false, locale("NOT_IN_SMUGGLING_MISSION")
    end

    if currentSmuggling:getStage() ~= 1 then
        return false, locale("ALREADY_STARTED_SMUGGLING")
    end

    local vehicleTrunk = "glove" .. currentSmuggling.plate

    local smugglingMission = currentSmuggling.missionId

    local itemsRequired = 0

    for _, item in ipairs(Config.MISSIONS[smugglingMission].items) do
        local itemCount = bridge.inv.count(vehicleTrunk, item.name)

        if itemCount >= item.count then
            itemsRequired = itemsRequired + 1
        end
    end

    if itemsRequired < #Config.MISSIONS[smugglingMission].items then
        return false, locale("MISSING_REQUIRED_ITEMS_IN_BOAT")
    end

    local inventory = bridge.inv.getInventoryItems(vehicleTrunk)

    for _, item in ipairs(inventory) do
        for _, missionItem in ipairs(Config.MISSIONS[smugglingMission].items) do
            if item.name == missionItem.name then
                bridge.inv.setItemMetaDataKey(vehicleTrunk, item.slot, "transported", true)
            end
        end
    end

    currentSmuggling:notify(locale("TRANSPORT_GOODS_TO_SUPPLIER"))

    local randomDropOff = math.random(1, #Config.DROP_OFFS)

    currentSmuggling.dropOff = randomDropOff
    currentSmuggling.mission = smugglingMission

    group.triggerEvent("prp-crime:smuggling:showBlip", randomDropOff)

    currentSmuggling:setStage(2)

    return true
end)

lib.callback.register("prp-crime:smuggling:handOverItem", function(pSource, itemName)
    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    local groupId = group.getUuid()
    local currentSmuggling = groupId and getMissionByGroupId(groupId)

    if not currentSmuggling then
        return false, locale("WHO_ARE_YOU")
    end

    local handedCounts = currentSmuggling:getHandedCounts()

    local itemCount = countItems(pSource, itemName, {
        transported = true
    })

    if itemCount <= 0 then
        return false, locale("NO_SMUGGLED_GOODS_TO_HAND_OVER")
    end

    local missionData = Config.MISSIONS[currentSmuggling.mission]
    local itemData

    for _, item in ipairs(missionData.items) do
        if item.name == itemName then
            itemData = item

            break
        end
    end

    if not itemData then
        return false, locale("NO_ITEMS_TO_HAND_OVER")
    end

    local countToHandOver = math.min(itemCount, itemData.count - (handedCounts[itemName] or 0))

    if countToHandOver <= 0 then
        return false, locale("GUN_SMUGGLING_CNC_ALREADY_HAVE_CORRECT_AMOUNT")
    end

    local removedItems = bridge.inv.removeItem(pSource, itemName, countToHandOver, {
        transported = true
    })

    if not removedItems then
        return false, locale("GUN_SMUGGLING_CNC_FAILED_TO_REMOVE_ITEMS")
    end

    currentSmuggling:incrementHandedCount(itemName, countToHandOver)

    local newCounts = currentSmuggling:getHandedCounts()

    local handedOver = 0

    for _, item in ipairs(missionData.items) do
        if item.name == itemName then
            if newCounts[itemName] >= item.count then
                handedOver = handedOver + 1
            end
        end
    end

    if handedOver == #missionData.items then
        bridge.log.send(Config.LogWebhook, "Gun Smuggling CNC Handoff", "Items handed over for CNC operation.", {
            mission_id = currentSmuggling.mission,
            character_id = currentSmuggling.stateId,
        })

        local inserted = MySQL.update.await([[
            INSERT INTO
                gun_smuggling_cnc
            (mission_id, started_by)
                VALUES
            (?, ?)
        ]], {
            currentSmuggling.mission,
            currentSmuggling.stateId
        })

        if not inserted then
            return false, locale("GUN_SMUGGLING_CNC_FAILED")
        end

        group.triggerEvent("prp-ocean-smuggling:startUplink",
            os.time() + Config.Timers.CNC, Config.Timers.CNC)

        currentSmuggling:notify(locale("GUN_SMUGGLING_CNC_COMPLETED"))
    else
        currentSmuggling:notify(locale("GUN_SMUGGLING_CNC_IN_PROGRESS"))
    end

    return true, locale("GUN_SMUGGLING_CNC_SUCCESS")
end)

lib.callback.register("prp-crime:smuggling:getOperations", function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        return false, locale("NO_ACCESS")
    end

    local operations = MySQL.query.await([[
        SELECT
            *, UNIX_TIMESTAMP(started_at) AS started_at
        FROM
            gun_smuggling_cnc
        WHERE
            (started_by = ?) AND picked_up = 0
    ]], {
        stateId
    })

    if not operations or #operations == 0 then
        return false, locale("GUN_SMUGGLING_NO_OPERATIONS_FOUND")
    end

    for _, operation in ipairs(operations) do
        operation.time_left = Config.Timers.CNC - (os.time() - operation.started_at)
        operation.time_left = math.max(0, operation.time_left)

        operation.percentage = 100 - math.floor((operation.time_left / Config.Timers.CNC) * 100)

        operation.mission_data = Config.MISSIONS[operation.mission_id]
    end

    return operations
end)

lib.callback.register("prp-crime:smuggling:collectCNC", function(pSource, operationId)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        return false, locale("NO_ACCESS")
    end

    local operation = MySQL.single.await([[
        SELECT
            mission_id
        FROM
            gun_smuggling_cnc
        WHERE
            id = ? AND picked_up = 0
    ]], {
        operationId
    })

    if not operation then
        return false, locale("GUN_SMUGGLING_CNC_OPERATION_NOT_FOUND")
    end

    local items = Config.MISSIONS[operation.mission_id].cnc

    local affectedRows = MySQL.update.await([[
        UPDATE
            gun_smuggling_cnc
        SET
            picked_up = 1
        WHERE
            id = ?
    ]], {
        operationId
    })

    if not affectedRows then
        return false, locale("GUN_SMUGGLING_CNC_FAILED_TO_DELETE_OPERATION")
    end

    for _, item in ipairs(items) do
        bridge.inv.giveItem(pSource, item.name, item.count, {
            tracker = true,
            trackerLabel = locale("TRACKER_ACTIVE"),

            missionId = operation.mission_id
        })
    end

    return true
end)

lib.callback.register("prp-crime:smuggling:talkToAirfield", function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        return false, locale("NO_ACCESS")
    end

    local hasOngoing = MySQL.query.await([[
        SELECT
            *, UNIX_TIMESTAMP(started_at) AS started_at
        FROM
            gun_smuggling_airfield
        WHERE
            (started_by = ?) AND picked_up = 0
    ]], {
        stateId
    })

    if hasOngoing and #hasOngoing > 0 then
        for _, operation in ipairs(hasOngoing) do
            operation.time_left = Config.Timers.Airfield - (os.time() - operation.started_at)
            operation.time_left = math.max(0, operation.time_left)

            operation.percentage = 100 - math.floor((operation.time_left / Config.Timers.Airfield) * 100)

            operation.mission_data = Config.MISSIONS[operation.mission_id]
        end

        return hasOngoing
    end

    local count = countItems(pSource, "gun_smuggling_crate", {
        tracker = true
    })

    if count <= 0 then
        return false, locale("GUN_SMUGGLING_AIRFIELD_WHAT_ARE_YOU_DOING_HERE")
    end

    return true
end)

local function findItem(inventory, itemName, metaData)
    local items = bridge.inv.getInventoryItems(inventory)
    for _, item in pairs(items) do
        if item.name == itemName then
            if metaData then
                local match = true
                for key, value in pairs(metaData) do
                    if not item.metadata or item.metadata[key] ~= value then
                        match = false
                        break
                    end
                end

                if match then
                    return item
                end
            else
                return item
            end
        end
    end

    return nil
end



lib.callback.register("prp-crime:smuggling:handOverGunCrate", function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        return false, locale("NO_ACCESS")
    end

    local smugglingCrate = findItem(inventoryId, Config.Items.crate, {
        tracker = true
    })

    if not smugglingCrate then
        return false, locale("GUN_SMUGGLING_AIRFIELD_YOU_DONT_HAVE_ANY_CRATES_TO_HAND_OVER")
    end

    if not smugglingCrate.metadata.missionId then
        return false, locale("GUN_SMUGGLING_AIRFIELD_YOU_DONT_HAVE_ANY_CRATES_TO_HAND_OVER")
    end

    local removedItem = bridge.inv.removeItem(pSource, Config.Items.crate, 1, nil, smugglingCrate.slot)

    if not removedItem then
        return false, locale("GUN_SMUGGLING_AIRFIELD_FAILED_TO_REMOVE_CRATE")
    end

    local inserted = MySQL.update.await([[
        INSERT INTO
            gun_smuggling_airfield
        (started_by, mission_id)
            VALUES
        (?, ?)
    ]], {
        stateId,
        smugglingCrate.metadata.missionId
    })

    if not inserted then
        return false, locale("GUN_SMUGGLING_AIRFIELD_FAILED_TO_INSERT_OPERATION")
    end

    return true
end)

lib.callback.register("prp-crime:smuggling:collectAirfield", function(pSource, operationId)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        return false, locale("NO_ACCESS")
    end

    local operation = MySQL.single.await([[
        SELECT
            mission_id
        FROM
            gun_smuggling_airfield
        WHERE
            id = ? AND picked_up = 0
    ]], {
        operationId
    })

    if not operation then
        return false, locale("GUN_SMUGGLING_AIRFIELD_OPERATION_NOT_FOUND")
    end

    local affectedRows = MySQL.update.await([[
        UPDATE
            gun_smuggling_airfield
        SET
            picked_up = 1
        WHERE
            id = ?
    ]], {
        operationId
    })

    if not affectedRows or affectedRows == 0 then
        return false, locale("GUN_SMUGGLING_AIRFIELD_FAILED_TO_UPDATE_OPERATION")
    end

    bridge.inv.giveItem(pSource, Config.Items.crate, 1, {
        tracker = false,
        trackerLabel = locale("TRACKER_DISABLED_LABEL"),

        missionId = operation.mission_id
    })

    return true
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, mission in pairs(ActiveMissions) do
            if mission then
                mission:destroy()
            end
        end

        ActiveMissions = {}
    end
end)

local function sendConfig()
    local src = source
    local config = {
        Mission = Config.Mission,
        LOCATIONS = Config.LOCATIONS,
        AIRFIELDS = Config.AIRFIELDS,
        DROP_OFFS = Config.DROP_OFFS,
        SafeHouses = Config.SafeHouses,
        MISSIONS = Config.MISSIONS,
        QueuePed = Config.QueuePed,
        Scene = Config.Scene,
        Items = Config.Items,
        Alert = Config.Alert
    }

    TriggerClientEvent("prp-crime:smuggling:config", src, config)
end
RegisterNetEvent("prp-gun-smuggling:server:requestConfig", sendConfig)
