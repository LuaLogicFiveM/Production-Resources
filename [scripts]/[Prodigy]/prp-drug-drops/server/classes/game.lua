local takenLocations = {}

Game = lib.class("Game")

function Game:constructor(playerId, groupId, partyId, taskId)
    self.private = {
        id = lib.string.random("..........", 10)
    }
    self.playerId = playerId
    self.groupId = groupId
    self.partyId = partyId
    self.taskId = taskId
    self.zoneId = nil
    self.zoneName = nil
    self.route = nil
    self.startData = nil
    self.rewardPickupData = nil

    self.completedPoints = {}

    self:generareRun()

    if not self.zoneId then
        error("Failed to generate run: no zone selected")
        return
    end

    self:setupStartingStash()
    self:setupStartingLocation()
    self:enableLocksForGroup()

    self.cancellationTimer = lib.timer(Config.ThresholdForCancelingRun * 1000, function()
        self:cancel()
    end, true)
end

function Game:enableLocksForGroup()
end

function Game:disableLocksForGroup()
end

function Game:getId()
    return self.private.id
end

function Game:generareRun()
    local zoneIds = {}
    for zoneId, _ in pairs(Config.Runs) do
        table.insert(zoneIds, zoneId)
    end

    if #zoneIds == 0 then
        lib.print.error("No zones found in config")
        return nil
    end

    local zoneId = zoneIds[math.random(1, #zoneIds)]
    local zone = Config.Runs[zoneId]

    if not zone.routes then return nil end
    if #zone.routes <= 0 then return nil end

    local randomRouteIndex = math.random(1, #zone.routes)
    local route = zone.routes[randomRouteIndex]

    if takenLocations[zoneId] then
        lib.print.error(("Zone %s already taken"):format(zoneId))
        return nil
    end

    self.zoneId = zoneId
    self.zoneName = zone.name
    self.route = lib.table.deepclone(route)
    self.routeIndex = randomRouteIndex
    self.startData = lib.table.deepclone(zone.starting)

    self.rewardPickupData = lib.table.deepclone(zone.rewardPickups[math.random(1, #zone.rewardPickups)])

    self:loadCompletionTimes()

    takenLocations[zoneId] = true
end

function Game:loadCompletionTimes()
    local topTimes = MySQL.query.await([[
        SELECT DISTINCT completion_time
        FROM drug_drop_times
        WHERE zone_id = ? AND route_index = ?
        ORDER BY completion_time ASC
        LIMIT 3
    ]], { self.zoneId, self.routeIndex })

    if topTimes and #topTimes >= 3 then
        self.route.completionTime = {
            fast = topTimes[1].completion_time,
            normal = topTimes[2].completion_time,
            slow = topTimes[3].completion_time
        }
        lib.print.debug(("Loaded completion times from leaderboard for zone %s route %d"):format(self.zoneId,
            self.routeIndex))
    end
end

function Game:saveCompletionResult()
    local completionTime = self.finishedAt - self.startedAt

    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)

    MySQL.insert.await([[
        INSERT INTO drug_drop_times
        (zone_id, route_index, completion_time, state_ids)
        VALUES (?, ?, ?, ?)
    ]], {
        self.zoneId,
        self.routeIndex,
        completionTime,
        json.encode(group.getMembersIdentifiers())
    })

    lib.print.debug(("Saved completion result for zone %s route %d: %d seconds"):format(self.zoneId, self.routeIndex,
        completionTime))
end

function Game:sendMessage(playerId, message)
    bridge.phone.sendMessage(
        playerId,
        Config.Messages.contactNumber,
        message
    )
end

function Game:setupStartingLocation()
    self:groupCallback(function(playerId)
        self:sendMessage(
            playerId,
            locale("MESSAGE_STARTING_LOCATION")
        )
    end)

    self:groupEvent(
        "prp-drug-drops:blips:createBlip",
        "startingPoint",
        84,
        5,
        self.startData.npc.coords,
        locale("STARTING_LOCATION_BLIP_LABEL")

    )

    self:groupEvent(
        "prp-drug-drops:blips:markGps",
        self.startData.npc.coords
    )

    lib.triggerClientEvent("prp-drug-drops:client:setupStartingLocation", -1, self.zoneId, self.zoneName, self.startData)
end

function Game:setupStartingStash()
    self.startingStorageId = bridge.inv.createTemporaryStash({
        label = locale('STARTING_CRATE'),
        slots = 20,
        maxWeight = 500,
    })

    self.moveItemHookId = bridge.inv.registerSwapItemsHook(function(payload)
        if payload.toInventory ~= self.startingStorageId then
            return true
        end

        local allowedItems = Config.Requirements.itemPoints
        if not allowedItems[payload.fromSlot.name] then
            lib.print.debug("Item not allowed in starting stash:", payload.fromSlot.name)
            return false
        end

        return true
    end, {
        inventoryFilter = {
            (self.startingStorageId:gsub("%-", "%%-"))
        }
    })
end

function Game:openStartingStash(playerId)
    local ped = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(ped)

    local distance = #(playerCoords - vector3(self.startData.crate.coords.x, self.startData.crate.coords.y, self.startData.crate.coords.z))

    if distance > 5.0 then
        bridge.fw.notify(playerId, "error", locale("TOO_FAR_FROM_NPC"))
        return
    end

    bridge.inv.openStash(playerId, self.startingStorageId)
end

function Game:calculateTotalPoints()
    local stashItems = bridge.inv.getInventoryItems(self.startingStorageId)
    if not stashItems then
        return 0, {}
    end

    local requiredPoints = Config.Requirements.requiredPoints
    local totalPoints = 0
    local itemCounts = {}

    for _, item in pairs(stashItems) do
        local itemName = item.name
        local points = Config.Requirements.itemPoints[itemName]

        if points then
            local pointsNeeded = requiredPoints - totalPoints
            
            if pointsNeeded <= 0 then
                break
            end
            
            local itemsNeeded = math.ceil(pointsNeeded / points)
            local itemsToTake = math.min(itemsNeeded, item.count)
            
            local itemTotal = points * itemsToTake
            totalPoints = totalPoints + itemTotal
            itemCounts[itemName] = (itemCounts[itemName] or 0) + itemsToTake
        end
    end

    return totalPoints, itemCounts
end

function Game:removeItemsFromStash(itemCounts)
    for itemName, amount in pairs(itemCounts) do
        local removed, error = bridge.inv.removeItem(self.startingStorageId, itemName, amount)
        if not removed then
            lib.print.error(("Failed to remove %d x %s from stash"):format(amount, itemName), error)
            return false
        end
    end

    return true
end

function Game:findFreeSpotForVehicle(src)
    local coords = lib.callback.await("prp-drug-drops:client:findFreeSpotForVehicle", src, self.startData.vehicle.coords)

    if not coords then
        lib.print.error(("Failed to find free spot for vehicle for player %d"):format(src))
        return nil
    end

    return coords
end

function Game:spawnVehicle(src, coords)
    local model = self.startData.vehicle.models[math.random(1, #self.startData.vehicle.models)]

    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = model,
        coords = coords,
        heading = coords.w,
    })

    if not vehicle then
        lib.print.error(("Failed to spawn vehicle model %s for game %s"):format(tostring(model), self:getId()))
        return nil
    end

    self:groupCallback(function(playerId)
        bridge.vkeys.give(playerId, vehicle, plate)
    end)

    return vehicle, plate
end

function Game:putDropItemsToVehicle(vehiclePlate)
    local trunkInventory = ("trunk%s"):format(vehiclePlate)

    if not self.dropItems or #self.dropItems == 0 then
        lib.print.error("No drop items generated")
        return false
    end

    local inventoryValid = lib.waitFor(function()
        local inv = bridge.inv.getInventoryItems(trunkInventory)

        if inv then
            return true
        end
    end, "Vehicle trunk inventory did not become available", 5000)

    if not inventoryValid then
        lib.print.error(("Vehicle trunk inventory %s not available"):format(trunkInventory))
        return false
    end

    for _, dropItem in ipairs(self.dropItems) do
        local success, error = bridge.inv.giveItem(trunkInventory, dropItem.name, 1, dropItem.metadata)
        if not success then
            lib.print.error(("Failed to add drop item to vehicle trunk"), error)
            return false
        end
    end

    return true
end

function Game:refund(src, itemCounts)
    for itemName, amount in pairs(itemCounts) do
        local added = bridge.inv.giveItem(src, itemName, amount)
        if not added then
            lib.print.error(("Failed to refund %d x %s to stash"):format(amount, itemName))
        end
    end
end

function Game:getCurrentPoint()
    for _, point in pairs(self.route.locations) do
        if not point.completed then
            return point, _
        end
    end

    return nil
end

function Game:setupDropPoint()
    local currentPoint, currentPointIndex = self:getCurrentPoint()
    if not currentPoint then
        return false
    end

    if self.currentPointStashHook then
        bridge.inv.removeHooks(self.currentPointStashHook)
    end

    self.currentPointStashId = bridge.inv.createTemporaryStash({
        label = locale('DROP_CRATE'),
        slots = 1,
        maxWeight = 100,
    })

    self.currentPointStashHook = bridge.inv.registerSwapItemsHook(function(payload)
        if tostring(payload.fromInventory) ~= self.currentPointStashId and tostring(payload.toInventory) ~= self.currentPointStashId then
            return true
        end

        if payload.fromSlot.name ~= Config.DropItem.id then
            lib.print.debug("Invalid item dropped: wrong item name", payload.fromSlot.name)
            return false
        end

        if payload.count ~= 1 then
            lib.print.debug("Invalid item dropped: wrong item count", payload.count)
            return false
        end

        local itemMetadata = payload.fromSlot.metadata or {}
        local isValidDropItem = false

        if itemMetadata.items then
            for _, dropItem in ipairs(self.dropItems) do
                local dropMetadata = dropItem.metadata or {}
                if dropMetadata.items then
                    local matches = true

                    for itemName, count in pairs(dropMetadata.items) do
                        if itemMetadata.items[itemName] ~= count then
                            matches = false
                            break
                        end
                    end

                    if matches then
                        for itemName, count in pairs(itemMetadata.items) do
                            if dropMetadata.items[itemName] ~= count then
                                matches = false
                                break
                            end
                        end
                    end

                    if matches then
                        isValidDropItem = true
                        break
                    end
                end
            end
        end

        if not isValidDropItem then
            bridge.fw.notify(payload.source, "error", locale("INVALID_DROP_ITEM"))
            lib.print.debug("Invalid item dropped: invalid drop item metadata", payload.fromSlot.metadata)  
            return false
        end

        local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
        local pointCoords = currentPoint.coords
        local distance = #(playerCoords - vector3(pointCoords.x, pointCoords.y, pointCoords.z))

        if distance > 10.0 then
            lib.print.debug("Invalid item dropped: too far from drop point", distance)
            return false
        end

        local vehiclePosition = GetEntityCoords(self.vehicle)

        if #(vehiclePosition - vector3(pointCoords.x, pointCoords.y, pointCoords.z)) > 20.0 then
            lib.print.debug("Invalid item dropped: vehicle too far from drop point", #(vehiclePosition - vector3(pointCoords.x, pointCoords.y, pointCoords.z)))
            return false
        end 

        self:itemDropped(payload.source)

        return true
    end, {
        inventoryFilter = {
            (self.currentPointStashId:gsub("%-", "%%-"))
        },
        print = true
    })

    self:groupEvent("prp-drug-drops:blips:createBlip", self:getId(), 94, 5, currentPoint.coords,
        locale("DROP_POINT_BLIP_LABEL"))

    self:groupEvent(
        "prp-drug-drops:blips:markGps",
        currentPoint.coords
    )

    lib.triggerClientEvent("prp-drug-drops:client:setupDrop", -1, self:getId(), currentPointIndex, currentPoint)

    self:groupCallback(function(playerId)
        self:sendMessage(
            playerId,
            locale("MESSAGE_DROP_POINT_READY")
        )

        TriggerClientEvent("prp-hud:notify", playerId, "Success", locale("DROP_COMPLETED"))
    end)

    local chance = Config.ChanceForNextDropAlert or 0.3
    if math.random() < chance then
        lib.print.debug(("Sending drop alert for game %s at point index %d"):format(self:getId(), currentPointIndex))
        
        local alert = Config.Alert
        bridge.dispatch.sendAlert(
            nil, 
            Config.Alert.jobs,
            currentPoint.coords,
            {
                code = alert.code,
                icon = alert.icon,
                title = locale('DISPATCH_ALERT_TITLE'),
                description = locale('DISPATCH_ALERT_DETAILS'),
            },
            {
                sprite = alert.blip.sprite,
                scale = alert.blip.size,
                colour = alert.blip.color,
                text = locale('DISPATCH_ALERT_TITLE'),
                length = alert.blip.duration,
                flash = alert.blip.flash,
            }
        )
    end

    return true
end

function Game:openDropCrate(playerId, pointIndex)
    local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
    local pointData = self.route.locations[pointIndex]
    if not pointData then
        lib.print.error(("No point data found for point index %d"):format(pointIndex))
        return
    end

    if self.completedPoints[pointIndex] then
        lib.print.debug(("Point index %d already completed"):format(pointIndex))
        bridge.fw.notify(playerId, "error", locale("DROP_ALREADY_FINISHED"))
        return
    end

    local distance = #(playerCoords - pointData.coords)

    if distance > 5.0 then
        bridge.fw.notify(playerId, "error", locale("TOO_FAR_FROM_DROP"))
        return
    end

    bridge.inv.openStash(playerId, self.currentPointStashId)
end

function Game:itemDropped(src)
    local currentPoint, currentPointIndex = self:getCurrentPoint()
    if not currentPoint or not currentPointIndex then
        return
    end

    currentPoint.completed = true

    self.completedPoints[currentPointIndex] = true

    TriggerClientEvent("prp-inventory:client:closeInventory", src)
    bridge.inv.removeHooks(self.currentPointStashHook)
    bridge.inv.clearInventory(self.currentPointStashId)

    self.currentPointStashId = nil
    self.currentPointStashHook = nil

    SetTimeout(Config.TimeToRemoveCompletedDropPoint * 1000, function()
        lib.triggerClientEvent("prp-drug-drops:client:removeDrop", -1, self:getId(), currentPointIndex)
    end)

    local nextPoint, _ = self:getCurrentPoint()
    if nextPoint then
        return self:setupDropPoint()
    end

    self:dropsStageCompleted()
    lib.print.debug("Run completed!")
    return nil
end

function Game:getCompletionTier()
    if not self.startedAt or not self.finishedAt then
        return "unknown"
    end

    local completionTime = self.finishedAt - self.startedAt
    local thresholds = self.route.completionTime

    if not thresholds then
        return "unknown"
    end

    if completionTime <= thresholds.fast then
        return "fast"
    elseif completionTime <= thresholds.normal then
        return "normal"
    else
        return "slow"
    end
end

function Game:dropsStageCompleted()
    for _, point in pairs(self.route.locations) do
        if not point.completed then
            return false
        end
    end

    if self.completed then
        return false
    end

    self.finishedAt = os.time()

    local completionTier = self:getCompletionTier()

    self:saveCompletionResult()

    self:groupEvent(
        "prp-drug-drops:blips:removeBlip",
        self:getId()
    )

    if completionTier == "unknown" then
        lib.print.error(("Could not determine completion tier for game %s"):format(self:getId()))
    else
        self:groupCallback(function(playerId)
            self:sendMessage(
                playerId,
                locale(("MESSAGE_RUN_COMPLETED_%s"):format(completionTier:upper()))
            )
        end)

        lib.triggerClientEvent("prp-drug-drops:client:setupRewardPickup", -1, self:getId(), self.rewardPickupData)
        
        self.rewardsStashId = bridge.inv.createTemporaryStash({
            label = locale('REWARD_CRATE'),
            slots = 20,
            maxWeight = 1000,
        })

        self.rewardsStashMoveHookId = bridge.inv.registerSwapItemsHook(function(payload)
            if payload.toInventory == self.rewardsStashId then
                lib.print.debug("Invalid item moved to rewards stash:", payload.fromSlot.name)
                return false
            end

            return true
        end, {
            inventoryFilter = {
                (self.rewardsStashId:gsub("%-", "%%-"))
            },
            print = true
        })
    end

    self.cancellationTimer:forceEnd(false)
    self.cancellationTimer = nil

    local rewards = self:generateRewards(completionTier)
    lib.print.debug(("Generated rewards for game %s"):format(self:getId()), rewards)

    local rewardNames = {}
    for _, reward in pairs(rewards) do
        bridge.inv.giveItem(self.rewardsStashId, reward.name, reward.count, reward.metadata)
        rewardNames[#rewardNames + 1] = ("%sx %s"):format(reward.count, reward.name)
    end

    bridge.log.send(Config.LogWebhook, "Drug Drops Completed", "A drug drops run has been completed.", {
        game_id = self:getId(),
        completion_tier = completionTier,
        duration = self.finishedAt - self.startedAt,
        rewards = table.concat(rewardNames, ", "),
    })

    SetTimeout(Config.TimeBeforeRewardCrateGetsRemoved * 1000, function()
        self:finishGame()
    end)

    self:groupEvent("prp-drug-drops:client:sendAppAction", "countupTimer", "stop")
    self:groupEvent("prp-drug-drops:client:sendAppAction", "countupTimer", "setLabel", locale("YOU_TOOK_TO_FINISH"))

    self:groupEvent("prp-drug-drops:blips:createBlip", ("%s_reward"):format(self:getId()), 431, 5,
        self.rewardPickupData.coords, locale("REWARD_PICKUP_BLIP_LABEL"))

    self:groupEvent(
        "prp-drug-drops:blips:markGps",
        self.rewardPickupData.coords
    )

    SetTimeout(10 * 1000, function()
        self:groupEvent("prp-drug-drops:client:sendAppAction", "countupTimer", "hide")
    end)

    self.completed = true

    return true
end

function Game:finishGame()
    lib.triggerClientEvent("prp-drug-drops:client:removeRewardPickup", -1, self:getId())

    if self.rewardsStashId then
        bridge.inv.removeHooks(self.rewardsStashMoveHookId)
        bridge.inv.clearInventory(self.rewardsStashId)

        self.rewardsStashId = nil
        self.rewardsStashMoveHookId = nil
    end

    if self.startingStorageId then
        bridge.inv.removeHooks(self.moveItemHookId)
        bridge.inv.clearInventory(self.startingStorageId)

        self.startingStorageId = nil
        self.moveItemHookId = nil

        lib.triggerClientEvent("prp-drug-drops:client:removeStartingLocation", -1, self.zoneId)
    end

    if self.currentPointStashId then
        bridge.inv.removeHooks(self.currentPointStashHook)
        bridge.inv.clearInventory(self.currentPointStashId)

        self.currentPointStashId = nil
        self.currentPointStashHook = nil

        self:groupEvent("prp-drug-drops:client:sendAppAction", "countupTimer", "hide")

        local _, currentPointIndex = self:getCurrentPoint()
        lib.triggerClientEvent("prp-drug-drops:client:removeDrop", -1, self:getId(), currentPointIndex)
    end

    if self.cancellationTimer then
        self.cancellationTimer:forceEnd(false)
        self.cancellationTimer = nil
    end

    self:disableLocksForGroup()

    if self.taskId then
        queue.setTaskIsExecuting(self.taskId, false, self.partyId)
    end

    takenLocations[self.zoneId] = nil
end

function Game:cancel()
    self:finishGame()

    if self.vehicle then
        if DoesEntityExist(self.vehicle) then
            DeleteEntity(self.vehicle)
        end

        self.vehicle = nil
        self.vehiclePlate = nil
    end

    TriggerEvent("prp-drug-drops:server:gameCanceled", self.groupId, self.id)
end

function Game:openRewardsCrate()
    local playerCoords = GetEntityCoords(GetPlayerPed(self.playerId))
    local pickupCoords = self.rewardPickupData.coords
    local distance = #(playerCoords - vector3(pickupCoords.x, pickupCoords.y, pickupCoords.z))

    if distance > 5.0 then
        bridge.fw.notify(self.playerId, "error", locale("TOO_FAR_FROM_REWARD_PICKUP"))
        return
    end

    bridge.inv.openStash(self.playerId, self.rewardsStashId)
end

function Game:generateRewards(tier)
    local config = Config.Rewards.byCompletion[tier] or Config.Rewards.byCompletion["slow"]

    local rewards = exports['prp-bridge']:GenerateLoot(
        Config.Rewards.lootPool,
        config.items,
        config.guarantees
    )

    return rewards or {}
end

function Game:groupEvent(event, ...)
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)

    if not group then
        lib.print.error(("Group %s not found for event %s"):format(self.groupId, event))
        return
    end

    for _, member in pairs(group.getMembers()) do
        TriggerClientEvent(event, member.src, ...)
    end
end

function Game:groupCallback(cb)
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)

    if not group then
        lib.print.error(("Group %s not found for callback"):format(self.groupId))
        return nil
    end

    for _, member in pairs(group.getMembers()) do
        cb(member.src)
    end
end

function Game:generateDropItems(itemCounts)
    local dropItemCount = #self.route.locations
    local dropItems = {}
    local itemsPerBox = {}
    for itemName, totalCount in pairs(itemCounts) do
        local baseAmount = math.floor(totalCount / dropItemCount)
        local remainder = totalCount % dropItemCount

        itemsPerBox[itemName] = {
            base = baseAmount,
            remainder = remainder
        }
    end

    for i = 1, dropItemCount do
        local metadata = {
            items = {},
            uuid = lib.string.random("..........", 10)
        }

        for itemName, distribution in pairs(itemsPerBox) do
            local amount = distribution.base

            if i <= distribution.remainder then
                amount = amount + 1
            end

            if amount > 0 then
                metadata.items[itemName] = amount
            end
        end

        table.insert(dropItems, {
            name = Config.DropItem.id,
            metadata = metadata
        })
    end

    self.dropItems = dropItems

    lib.print.debug(("Generated %d drop items with distributed contents"):format(#dropItems), dropItems)
end

function Game:startRun(src)
    if self.started then
        lib.print.debug(("Game %s already started"):format(self:getId()))
        bridge.fw.notify(src, "error", locale("RUN_ALREADY_STARTED"))
        return false
    end

    local totalPoints, itemCounts = self:calculateTotalPoints()
    local requiredPoints = Config.Requirements.requiredPoints

    if totalPoints < requiredPoints then
        bridge.fw.notify(src, "error", locale("NOT_ENOUGH_ITEMS"))
        return false
    end

    local vehicleCoords = self:findFreeSpotForVehicle(src)
    if not vehicleCoords then
        bridge.fw.notify(src, "error", locale("ALL_VEHICLE_SPOTS_OCCUPIED"))
        return false
    end

    local success = self:removeItemsFromStash(itemCounts)
    if not success then
        bridge.fw.notify(src, "error", locale("FAILED_TO_REMOVE_ITEMS"))
        return false
    end

    local vehicle, vehiclePlate = self:spawnVehicle(src, vehicleCoords)
    if not vehicle then
        self:refund(src, itemCounts)

        bridge.fw.notify(src, "error", locale("FAILED_TO_SPAWN_VEHICLE"))
        return false
    end

    self:generateDropItems(itemCounts)

    self.vehicle = vehicle
    self.vehiclePlate = vehiclePlate

    local itemsAdded = self:putDropItemsToVehicle(vehiclePlate)
    if not itemsAdded then
        self:refund(src, itemCounts)

        bridge.fw.notify(src, "error", locale("FAILED_TO_ADD_ITEMS_TO_VEHICLE"))
        return false
    end

    self:groupEvent("prp-drug-drops:blips:removeBlip", "startingPoint")

    self.startedAt = os.time()
    self.started = true

    bridge.log.send(Config.LogWebhook, "Drug Drops Started", "A drug drops run has started.", {
        game_id = self:getId(),
        character_id = bridge.fw.getIdentifier(src),
        player_name = GetPlayerName(src),
        route = self.route and self.route.name or "unknown",
        total_points = totalPoints,
    })

    self:setupDropPoint()

    self:groupEvent("prp-drug-drops:client:sendAppAction", "countupTimer", "start")

    local bestTime = self.route.completionTime?.fast or 0
    local minutes, seconds = math.floor(bestTime / 60), bestTime % 60

    self:groupCallback(function(playerId)
        self:sendMessage(
            playerId,
            locale("MESSAGE_RUN_STARTED", minutes, seconds)
        )
    end)

    bridge.fw.notify(src, "success", locale("RUN_STARTED", totalPoints))
    return true
end
