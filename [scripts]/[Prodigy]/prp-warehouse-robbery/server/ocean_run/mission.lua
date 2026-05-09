smugglingQueue = nil

---@class SmugglingRun : OxClass
local SmugglingRun = lib.class("SmugglingRun")

---@type SmugglingRun | nil
local smugglingRun

function SmugglingRun:constructor(pSource, taskId)
    self.pSource = pSource
    self.stateId = bridge.fw.getIdentifier(pSource)

    self.group = exports['prp-bridge']:GetGroupIdFromMember(pSource)

    self.taskId = taskId

    self.locationId = math.random(1, #SmugglingMission.Locations)

    self.handles = {}

    self.isRunning = true

    self.HDDIds = RollUnique(7, 4)

    self:sendSMS(SmugglingMission.Phone.number, locale("OCEAN_RUN_START_SMS"))
    self:sendSMSLocation(SmugglingMission.Phone.number, SmugglingMission.Locations[self.locationId].boat)

    self:thread()

    lib.timer((1000 * 60 * SmugglingMission.timeToFinish), function()
        if not self.isRunning then
            return
        end

        self:cleanup()
    end, true)
end

function SmugglingRun:giveKeys(vehicleHandle, plate)
    local group = exports['prp-bridge']:GetGroupByUuid(self.group)
    if not group then
        return
    end

    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            bridge.vkeys.give(member.src, vehicleHandle, plate)
        end
    end
end

function SmugglingRun:spawnBoat()
    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = SmugglingMission.BoatModel,
        coords = SmugglingMission.Locations[self.locationId].boat,
    })

    if not vehicle or not DoesEntityExist(vehicle) then
        return false, "Failed to spawn the boat."
    end

    self:giveKeys(vehicle, plate)

    self:sendSMS(SmugglingMission.Phone.number, locale("OCEAN_RUN_BOAT_ARRIVED_SMS"))
    self:sendSMSLocation(SmugglingMission.Phone.number, SmugglingMission.Locations[self.locationId].truck)

    self.plate = plate
    self.boatSpawned = true

    self.boat = {
        handle = vehicle,
        plate = plate,
    }

    self.stage = 2

    table.insert(self.handles, vehicle)

    return true
end

function SmugglingRun:spawnTruck()
    local truckHandle, truckPlate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = SmugglingMission.TruckModel,
        coords = SmugglingMission.Locations[self.locationId].truck,
    })

    if not truckHandle or not DoesEntityExist(truckHandle) then
        return false, "Failed to spawn the truck."
    end

    self:giveKeys(truckHandle, truckPlate)

    for _, bikePos in pairs(SmugglingMission.Locations[self.locationId].dirtBikes) do
        local bikeHandle, bikePlate = exports['prp-bridge']:SpawnTemporaryVehicle({
            model = SmugglingMission.DirtBikeModel,
            coords = bikePos,
        })

        if bikeHandle and DoesEntityExist(bikeHandle) then
            table.insert(self.handles, bikeHandle)
        end

        self:giveKeys(bikeHandle, bikePlate)
    end

    self:sendSMSLocation(SmugglingMission.Phone.number, SmugglingMission.DropOff)
    self:sendSMS(SmugglingMission.Phone.number, locale("OCEAN_RUN_TRUCK_ARRIVED_SMS"))

    Entity(self.boat.handle).state.smugglingBoat = true

    self.truckSpawned = true

    self.truck = {
        handle = truckHandle,
        plate = truckPlate,
    }

    self.stage = 3

    table.insert(self.handles, truckHandle)

    self:spawnGuards(SmugglingMission.Locations[self.locationId].islandGuards)

    return true
end

function SmugglingRun:startUplink(nasUUID)
    self.lastGuardSpawn = os.time()

    self:sendSMS(SmugglingMission.Phone.number, locale("OCEAN_RUN_UPLINK_PLANTED_SMS"))

    self.endTimestamp = os.time() + (SmugglingMission.UplinkTime * 60)

    local group = exports['prp-bridge']:GetGroupByUuid(self.group)
    group.triggerEvent("prp-ocean-smuggling:startUplink", self.endTimestamp)

    self.stage = 4

    lib.timer((1000 * 60 * SmugglingMission.UplinkTime), function()
        if not self.isRunning then
            return
        end

        if self.nasId then
            local deleteGroup = exports['prp-bridge']:GetGroupByUuid(self.group)
            if deleteGroup then
                deleteGroup.triggerEvent("prp-ocean-smuggling:deleteNAS", self.nasId)
            end
        end

        self:sendSMS(SmugglingMission.Phone.number, locale("OCEAN_RUN_UPLINK_COMPLETE_SMS"))

        group.triggerEvent("prp-ocean-smuggling:upLinkFinished")

        self.stage = 5

        lib.timer(1000 * 60 * 15, function()
            if not self.isRunning then
                return
            end

            self:cleanup()
        end)
    end, true)
end

function SmugglingRun:notifyPhone(message)
    local group = exports['prp-bridge']:GetGroupByUuid(self.group)

    if not group then
        return
    end

    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            bridge.phone.sendNotification(
                member.src,
                locale("SMUGGLING_MISSION_LABEL"),
                message
            )
        end
    end
end

function SmugglingRun:getClosestToLocation(loc)
    local closestSrc = nil
    local closestDistance = math.huge

    local group = exports['prp-bridge']:GetGroupByUuid(self.group)

    if not group then
        return closestSrc, closestDistance
    end

    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            local ped = GetPlayerPed(member.src)

            local distanceToDropOff = #(loc.xyz - GetEntityCoords(ped))

            if distanceToDropOff < closestDistance then
                closestDistance = distanceToDropOff
                closestSrc = member.src
            end
        end
    end

    return closestSrc, closestDistance
end

function SmugglingRun:spawnGuards(guards)
    local pSource = self:getClosestToLocation(SmugglingMission.DropOff)

    local netIds = lib.callback.await("prp-ocean-smuggling:spawnGuards", pSource,
        guards or SmugglingMission.Locations[self.locationId].guards)

    for _, netId in pairs(netIds) do
        local handle = NetworkGetEntityFromNetworkId(netId)

        if handle and DoesEntityExist(handle) then
            table.insert(self.handles, handle)

            local entityType = GetEntityType(handle)

            if entityType == 2 then
                Entity(handle).state.DisableLockpick = true

                SetVehicleDoorsLocked(handle, 2)
            end
        end
    end
end

function SmugglingRun:spawnBoatGuards(pSource)
    local netIds = lib.callback.await("prp-ocean-smuggling:spawnGuards", pSource, SmugglingMission.Locations[self.locationId].boatGuards,
        true)

    for _, netId in pairs(netIds) do
        local handle = NetworkGetEntityFromNetworkId(netId)

        if handle and DoesEntityExist(handle) then
            table.insert(self.handles, handle)

            local entityType = GetEntityType(handle)

            if entityType == 2 then
                Entity(handle).state.DisableLockpick = true

                SetVehicleDoorsLocked(handle, 2)
            end
        end
    end
end

function SmugglingRun:generateLoot()
    local itemsInStash = {}
    local items = GetRewards(SmugglingMission.loot.rolls, SmugglingMission.loot.table)

    for itemName, itemCount in pairs(items) do
        table.insert(itemsInStash, { name = itemName, count = itemCount })
    end

    local inventoryId = bridge.inv.createTemporaryStash({
        label = locale("SMUGGLING_LOOT_BOX"),
        slots = 16,
        maxWeight = 100,
        items = itemsInStash
    })

    self.hasLooted = inventoryId

    return inventoryId
end

function SmugglingRun:thread()
    Citizen.CreateThread(function()
        while self.isRunning do
            Citizen.Wait(1000)

            local pSource, distanceToBoat = self:getClosestToLocation(SmugglingMission.Locations[self.locationId].boat)
            local _, distanceToTruck = self:getClosestToLocation(SmugglingMission.Locations[self.locationId].truck)

            if not self.boatSpawned and distanceToBoat < 100.0 then
                local success, err = self:spawnBoat()

                if not success then
                    print(err)
                end
            elseif not self.truckSpawned and self.stage == 2 then
                if distanceToTruck < 125.0 then
                    local success, err = self:spawnTruck()

                    if not success then
                        print(err)
                    end
                elseif distanceToBoat > 75.0 and not self.spawnedGuards then
                    self:spawnBoatGuards(pSource)

                    self.spawnedGuards = true
                end
            elseif self.stage == 3 and self.truckSpawned then
                local src, distanceToDropOff = self:getClosestToLocation(SmugglingMission.DropOff)

                if distanceToDropOff < 25.0 then
                    if not self.notified then
                        self:sendSMS(SmugglingMission.Phone.number, locale("OCEAN_RUN_NEAR_DROP_OFF_SMS"))

                        self.notified = true
                    end
                end
            elseif self.stage == 4 then
                local lastGuardSpawn = self.lastGuardSpawn or 0

                if os.time() - lastGuardSpawn > 60 then
                    self:spawnGuards()

                    self.lastGuardSpawn = os.time()
                end
            end
        end
    end)
end

--- Sends a SMS to all members of the mission
---@param number string "RANDOM" or a phone number
---@param message string
---@param targetSource number|nil
function SmugglingRun:sendSMS(number, message, targetSource)
    if targetSource then
        bridge.phone.sendMessage(targetSource, SmugglingMission.Phone.number, message)
        return
    end

    local group = exports['prp-bridge']:GetGroupByUuid(self.group)
    if not group then
        error("Group not found for UUID: " .. tostring(self.group))
    end

    for _, member in pairs(group.getMembers()) do
        if member.src and DoesPlayerExist(member.src) then
            bridge.phone.sendMessage(member.src, SmugglingMission.Phone.number, message)
        end
    end
end

--- Sends a location message to the specified number
--- @param number string "RANDOM" or a phone number
--- @param coords vector3
--- @param contactName string|nil
--- @param targetSource number|nil
function SmugglingRun:sendSMSLocation(number, coords, contactName, targetSource)
    if targetSource then
        bridge.phone.sendCoords(
            targetSource,
            SmugglingMission.Phone.number,
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
                SmugglingMission.Phone.number,
                coords
            )
        end
    end
end

function SmugglingRun:cleanup()
    self.isRunning = false

    if self.nasId then
        local group = exports['prp-bridge']:GetGroupByUuid(self.group)
        if group then
            group.triggerEvent("prp-ocean-smuggling:deleteNAS", self.nasId)
        end
    end

    for _, handle in pairs(self.handles) do
        if handle and DoesEntityExist(handle) then
            DeleteEntity(handle)
        end
    end

    smugglingQueue.setTaskIsExecuting(self.taskId, false)

    smugglingRun = nil
end

RegisterNetEvent("prp-ocean-smuggling:doAnimation", function(id, animationName)
    local pSource = source

    local pedHandle = GetPlayerPed(pSource)

    if not pedHandle or not DoesEntityExist(pedHandle) then
        return
    end

    TriggerClientEvent("prp-ocean-smuggling:doAnimation", -1, id, animationName, pSource)
end)

RegisterNetEvent("prp-ocean-smuggling:removeHDD", function()
    local pSource = source

    bridge.inv.removeItem(pSource, SmugglingMission.Other.Items.hdd, 1)
end)

lib.callback.register("prp-ocean-smuggling:enteredDrives", function(pSource, nasUUID)
    if not smugglingRun then
        return false
    end

    if not smugglingRun.isRunning then
        return false
    end

    if smugglingRun.stage ~= 3 then
        return false
    end

    smugglingRun:startUplink(nasUUID)

    return false
end)

lib.callback.register("prp-ocean-smuggling:canStealHDD", function(pSource, rackId)
    if not smugglingRun then
        return false
    end

    if not smugglingRun.isRunning then
        return false
    end

    if smugglingRun.stage ~= 3 then
        return false
    end

    for _, id in ipairs(smugglingRun.HDDIds) do
        if id == rackId then
            return true
        end
    end

    return false
end)

lib.callback.register("prp-ocean-smuggling:receivedServer", function(pSource, rackId)
    if not smugglingRun then
        return false
    end

    if not smugglingRun.isRunning then
        return false
    end

    if smugglingRun.stage ~= 3 then
        return false
    end

    for i, id in ipairs(smugglingRun.HDDIds) do
        if id == rackId then
            table.remove(smugglingRun.HDDIds, i)

            bridge.inv.giveItem(pSource, SmugglingMission.Other.Items.hdd, 1)

            if #smugglingRun.HDDIds <= 0 then
                smugglingRun:notifyPhone(locale("OCEAN_RUN_ALL_SERVERS_STOLEN"))
            end

            return true
        end
    end

    return false
end)

lib.callback.register("prp-ocean-smuggling:takeNAS", function(pSource, vehicleNetId)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if not vehicle or not DoesEntityExist(vehicle) then
        return false
    end

    local completed = ProgressBar(pSource, 5000, locale("OCEAN_RUN_PLACE_NAS_PROGRESS"), true, true)

    if not completed then
        return false
    end

    if not Entity(vehicle).state.smugglingBoat then
        return false
    end

    Entity(vehicle).state.smugglingBoat = false

    bridge.inv.giveItem(pSource, SmugglingMission.Other.Items.nas, 1)

    return true
end)

lib.callback.register("prp-ocean-smuggling:canLootCrate", function(pSource)
    if not smugglingRun then
        return false
    end

    if not smugglingRun.isRunning then
        return false
    end

    if smugglingRun.stage ~= 5 then
        return false
    end

    local hasLoot = smugglingRun.hasLooted

    if hasLoot then
        bridge.inv.forceOpenStash(pSource, hasLoot)
    else
        local lootId = smugglingRun:generateLoot()

        bridge.inv.forceOpenStash(pSource, lootId)
    end

    return true
end)

local function check(_, partyUuid)
    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyUuid)

    if not group then
        return false
    end

    local leader = group.getLeader()

    for _, member in pairs(group.getMembers()) do
        if exports['prp-bridge']:isCooldownActiveForIdentifier(member.identifier, SmugglingMission.queueName) then
            bridge.fw.notify(leader.src, 'error', locale("GROUP_MEMBER_ON_CD"))

            return false
        end
    end

    return true
end

local function exec(_, partyUuid, _, taskId)
    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyUuid)
    if not group then
        smugglingQueue.setTaskIsExecuting(taskId, false)
        return false
    end

    local leader = group.getLeader()

    smugglingRun = SmugglingRun:new(
        leader.src,
        taskId
    )
end

local function setup()
    smugglingQueue = exports['prp-bridge']:CreateQueue(
        SmugglingMission.queueName,
        'crime',
        SmugglingMission.policeRequired,
        SmugglingMission.concurrentJobs,
        SmugglingMission.cooldown * 60 * 1000
    )

    smugglingQueue.setCheckFunction(check)
    smugglingQueue.setExecFunction(exec)
end
SetTimeout(0, setup)

if SmugglingMission.TestCommand and SmugglingMission.TestCommand?.enabled then
    bridge.fw.registerCommand(
        SmugglingMission.TestCommand.name,
        locale("SMUGGLING_MISSION_TEST_COMMAND_DESC"),
        {},
        SmugglingMission.TestCommand.restricted,
        function(playerId)
            smugglingRun = SmugglingRun:new(
                playerId,
                1
            )
        end
    )
end

SetTimeout(0, function()
    bridge.fw.registerItemUse(SmugglingMission.Other.Items.nas, function(src, _)
        if not smugglingRun or not smugglingRun.isRunning then return end
        if smugglingRun.stage ~= 3 then return end
        if smugglingRun.nasId then return end

        local result = lib.callback.await("prp-ocean-smuggling:placeNAS", src)

        if not result then return end

        local placedCoords = vector3(result.x, result.y, result.z)

        local validPlacement = false
        for _, zone in ipairs(SmugglingMission.Other.NAS_ZONES) do
            local dist = #(placedCoords - zone.coords)
            if dist < 5.0 then
                validPlacement = true
                break
            end
        end

        if not validPlacement then
            bridge.fw.notify(src, 'error', locale("NOT_IN_NAS_ZONE"))
            return
        end

        bridge.inv.removeItem(src, SmugglingMission.Other.Items.nas, 1)

        local nasId = tostring(math.random(100000, 999999))
        smugglingRun.nasId = nasId

        local group = exports['prp-bridge']:GetGroupByUuid(smugglingRun.group)
        if group then
            group.triggerEvent("prp-ocean-smuggling:spawnNAS", nasId, placedCoords, result.heading)
        end
    end)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    if smugglingRun then
        smugglingRun:cleanup()
    end
end)
