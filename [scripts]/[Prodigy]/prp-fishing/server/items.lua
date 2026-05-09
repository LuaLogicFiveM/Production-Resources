local function isFish(fishName)
    local prefixes = {}
    for _, kind in pairs(FishingKinds) do
        table.insert(prefixes, ("%s_"):format(kind))
    end

    for _, prefix in ipairs(prefixes) do
        if fishName:sub(1, #prefix) == prefix then
            return fishName:sub(#prefix + 1), prefix
        end
    end

    return fishName
end

local allItemNamesKeys = {}
for lootName in pairs(FishingLoot) do
    for _, kind in ipairs(FishingKinds) do
        local fullName = ("%s_%s"):format(kind, lootName)

        allItemNamesKeys[fullName] = true
    end
end

if FishingBootItem then
    bridge.fw.registerItemUse(FishingBootItem, function(source, itemData)
        bridge.inv.removeItem(source, itemData.name, 1)

        local item = WeightedRandom(BootLoot)

        if item then
            bridge.inv.giveItem(source, item.name, math.random(item.min or 1, item.max))
        end
    end)
end

for lootName in pairs(FishingLoot) do
    for _, kind in ipairs(FishingKinds) do
        local fullName = ("%s_%s"):format(kind, lootName)

        bridge.fw.registerItemUse(fullName, function(source, itemData)
            local itemWeight = (itemData.metaData.weight or 0) / 1000

            TriggerClientEvent("prp-fishing:client:showOff", source, itemData.name, itemWeight, lootName)
        end)
    end
end

for trophyName, trophyData in pairs(FishingTrophies) do
    bridge.fw.registerItemUse(trophyName, function(source, itemData)
        TriggerClientEvent("prp-fishing:client:showOffTrophy", source, itemData.name, trophyData.model)
    end)
end

local hasCaughtFish = {}
local fishingStartTime = {}

local function handleReward(source, rodData)
    local fishingZone = lib.callback.await("prp-fishing:client:getFishingZone", source)
    lib.print.debug("Handling fishing reward for player", source, "in zone", fishingZone)

    local fishingZoneId = GetFishingZoneIndex(fishingZone)
    lib.print.debug("Fishing zone ID for player", source, "is", fishingZoneId
    )
    local fishingZoneData = FishingZones[fishingZoneId]
    if not fishingZoneData then
        lib.print.debug("No fishing zone data found for zone", fishingZone, "using default loot table")
        return false
    end

    local removedBait = bridge.inv.removeItem(source, fishingZoneData.bait or FishingBaits.worm, 1)
    if not removedBait then
        lib.print.debug("No bait found for player", source, "in fishing zone", fishingZone)
        bridge.fw.notify(source, 'error', locale("NO_BAIT"))

        return false
    end

    if not hasCaughtFish[source] then
        lib.print.debug("Player", source, "has not caught a fish yet.")
        return false
    end

    hasCaughtFish[source] = nil

    local loot = fishingZoneData.loot

    local set = {}

    for _, lootItem in ipairs(loot) do
        table.insert(set, {
            lootItem.chance, {
            name = lootItem.table,
            min = 1,
            max = 1
        }
        })
    end

    local selectedLoot = WeightedRandom(set)
    local randomItem = selectedLoot and
        { name = selectedLoot.name, count = math.random(selectedLoot.min or 1, selectedLoot.max) }

    if randomItem then
        local randomLoot = FishingLootTables[fishingZoneData.zone or FishingDefaultLoot][randomItem.name]
            [math.random(#FishingLootTables[fishingZoneData.zone or FishingDefaultLoot][randomItem.name])]

        if not randomLoot then
            lib.print.debug("No loot found for item", randomItem.name, "in zone", fishingZoneData.zone)
            return false
        end

        local itemName, prefix = isFish(randomLoot)
        local itemData = FishingLoot[itemName]

        lib.print.debug("Selected loot for player", source, "is", randomLoot, "which is item", itemName, "with prefix",
            prefix)
        local realItemData = bridge.inv.getItemData(randomLoot)

        if not realItemData then
            lib.print.debug("Item data not found for", randomLoot)
            bridge.fw.notify(source, 'error', locale("ERROR_FISHING", randomLoot))

            return false
        end

        local randomWeight = realItemData.weight or 0.0

        if itemData and type(itemData.weight) == "table" then
            randomWeight = math.random(itemData.weight[1], itemData.weight[2]) / 1000
        elseif itemData and type(itemData.weight) == "number" then
            ---@diagnostic disable-next-line: cast-local-type
            randomWeight = itemData.weight
        end

        if prefix == "small_" then
            randomWeight = randomWeight * 0.6
        elseif prefix == "large_" then
            randomWeight = randomWeight * 1.25
        end

        if itemData and not itemData.isTrash then
            lib.print.debug("Item is not trash, asking player if they want to keep it")
            lib.print.debug("Item data for", randomLoot, "is", json.encode(itemData))

            local keepFish = lib.callback.await(
                "prp-fishing:client:keepFish",
                source,
                randomLoot,
                randomWeight,
                rodData.name,
                itemName
            )

            lib.print.debug("Did the player keep the fish?", keepFish)

            if not keepFish then
                return false
            end
        end

        local metaData = {
            weight = math.ceil(randomWeight * 1000),
            lootRarity = randomItem.name,
            caughtIn = fishingZoneData.zone or FishingDefaultLoot
        }

        -- TODO: might add if there's cases UI
        -- if randomLoot == "case" then
        --     metaData.caseId = "FISHING_CASE"
        --     metaData.label = locale("TREASURE_CHEST")
        -- end

        bridge.inv.giveItem(source, randomLoot, randomItem.count, metaData)

        TriggerEvent("prp-fishing:fishCaught", source, itemName, randomLoot, randomItem.count, metaData)

        return true
    end
end

local function removeDurabilityFromRod(source, slot, rodName)
    local rodConfig = FishingRods[rodName]
    if not rodConfig or not rodConfig.consume then return end

    local currentItem = bridge.inv.getSlot(source, slot)
    if not currentItem then return end

    local currentDurability = currentItem.metadata and currentItem.metadata.durability or 100
    local newDurability = currentDurability - (rodConfig.consume * 100)

    if newDurability <= 0 then
        bridge.inv.removeItem(source, currentItem.name, 1, nil, slot)
        bridge.fw.notify(source, 'inform', locale("ROD_BROKEN"))
    else
        bridge.inv.setItemMetaDataKey(source, slot, "durability", newDurability)
    end
end

local function tryFishing(source, itemData)
    lib.print.debug(("Player %d is using item '%s' with data: %s"):format(source, itemData.name, json.encode(itemData)))
    local item = bridge.inv.getSlot(source, itemData.slot)
    if not item then
        lib.print.debug(("Item '%s' not found in slot %d for player %d"):format(itemData.name, itemData.slot, source))
        bridge.fw.notify(source, 'error', locale("NEED_FISHING_ROD"))
        return false
    end

    local currentDurability = item.metadata and item.metadata.durability
    if not currentDurability then
        bridge.inv.setItemMetaDataKey(source, item.slot, "durability", 100)
    elseif currentDurability <= 0 then
        bridge.inv.removeItem(source, item.name, 1, nil, item.slot)
        bridge.fw.notify(source, 'inform', locale("ROD_BROKEN"))
        return false
    end

    local fishingZone = lib.callback.await("prp-fishing:client:getFishingZone", source)
    lib.print.debug("Player", source, "is attempting to fish in zone", fishingZone)

    local fishingZoneId = fishingZone and GetFishingZoneIndex(fishingZone)
    local fishingZoneData = fishingZoneId and FishingZones[fishingZoneId]

    if not fishingZoneData then
        if not AllowFishingOutsideZones then
            bridge.fw.notify(source, 'error', locale("NOT_IN_FISHING_ZONE"))
            return false
        end

        fishingZoneData = {
            bait = "fishing_bait_worm",
            loot = DefaultFishingLoot
        }
    end

    local baitCount = bridge.inv.count(source, fishingZoneData.bait)

    if baitCount == 0 then
        lib.print.debug("No bait found for player", source, "in fishing zone", fishingZone)
        local baitData = bridge.inv.getItemData(fishingZoneData.bait)
        local baitLabel = baitData and baitData.label or fishingZoneData.bait
        bridge.fw.notify(source, 'error', locale("NO_BAIT_WITH_NAME", baitLabel))
        return false
    end

    lib.print.debug("Player", source, "is using fishing rod", itemData.name, "in zone", fishingZone, "with bait count:",
        baitCount)

    fishingStartTime[source] = GetGameTimer()
    local shouldRemoveDurability, errorMsg = lib.callback.await("prp-fishing:client:tryToFish", source, item.name)

    lib.print.debug("Fishing rod used by", source, "shouldRemoveDurability:", shouldRemoveDurability, "errorMsg:", errorMsg)

    local elapsed = GetGameTimer() - (fishingStartTime[source] or 0)
    fishingStartTime[source] = nil

    if elapsed < MinimumFishingTime then
        lib.print.warn(("Player %d completed fishing in %dms (minimum %dms) - possible exploit"):format(source, elapsed, MinimumFishingTime))
        return false
    end

    -- Re-verify the rod still exists and has durability after the fishing session
    local currentItem = bridge.inv.getSlot(source, itemData.slot)
    if not currentItem then return false end

    local currentDurability = currentItem.metadata and currentItem.metadata.durability
    if currentDurability and currentDurability <= 0 then
        bridge.inv.removeItem(source, currentItem.name, 1, nil, itemData.slot)
        bridge.fw.notify(source, 'inform', locale("ROD_BROKEN"))
        return false
    end

    if shouldRemoveDurability then
        removeDurabilityFromRod(source, itemData.slot, item.name)
    end

    if shouldRemoveDurability and errorMsg then
        hasCaughtFish[source] = true

        lib.print.debug("Player", source, "has caught a fish. Awaiting reward handling.")

        handleReward(source, itemData)
    elseif not shouldRemoveDurability and errorMsg then
        bridge.fw.notify(source, 'error', errorMsg)
    end
end

for item in pairs(FishingRods) do
    bridge.fw.registerItemUse(item, function(source, itemData)
        SetTimeout(0, function()
            tryFishing(source, itemData)
        end)
    end)
end

RegisterNetEvent("prp-fishing:server:cutFish", function(slot)
    local source = source
    local ped = GetPlayerPed(source)

    local item = bridge.inv.getSlot(source, slot)
    if not item then
        return bridge.fw.notify(source, 'error', locale("ITEM_NOT_FOUND"))
    end

    if not isFish(item.name) then
        return bridge.fw.notify(source, 'error', locale("NOT_A_FISH"))
    end

    if not allItemNamesKeys[item.name] then
        return bridge.fw.notify(source, 'error', locale("CANNOT_CUT_ITEM"))
    end

    if GetSelectedPedWeapon(ped) ~= `WEAPON_KNIFE` then
        return bridge.fw.notify(source, 'error', locale("KNIFE_EQUIPPED"))
    end

    local cut = lib.callback.await("prp-bridge:progress", source, {
        duration = 5000,
        label = locale("CUTTING_FISH"),
        canCancel = true,
        useWhileDead = true,
    })

    if not cut then
        return bridge.fw.notify(source, 'error', locale("CUTTING_CANCELLED"))
    end

    lib.print.debug('Removing fish item from player', source, 'slot', slot, 'item:', item)
    local removedItem, error = bridge.inv.removeItem(source, item.name, 1, item.metadata, slot)
    if not removedItem then
        lib.print.debug('Failed to remove fish item from player', source, 'error:', error, 'item:', item.name)
        return bridge.fw.notify(source, 'error', locale("ITEM_NOT_FOUND"))
    end

    local meatToAdd = math.random(1, 2)

    bridge.inv.giveItem(source, FishingItems.meat, meatToAdd)
    bridge.fw.notify(source, 'success', locale("YOU_CUT_FISH"))
end)
