SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

local activeGames = {}
local locations = {}

---@param partyId string
---@param taskId string
function StartDrugDrops(partyId, taskId)
    local group = exports["prp-bridge"]:GetGroupByPartyUuid(partyId)

    if not group then
        lib.print.error(("Player %d with identifier %s is not in a group"):format(playerId, identifier))
        return false
    end

    local groupId = group.getUuid()
    local leader = group.getLeader()

    local success, response = pcall(function()
        local instance = Game:new(leader.src, groupId, partyId, taskId)

        return instance
    end)

    if not success then
        lib.print.error(("Failed to start run for group %s: %s"):format(tostring(groupId), tostring(response)))
        bridge.fw.notify(leader.src, "error", locale("SOMETHING_WENT_WRONG"))
        return false
    end

    activeGames[response:getId()] = response
    lib.print.info(("Started drug drops run for group %s"):format(tostring(groupId)))
end

local function getGameByGroupId(groupId)
    for _, game in pairs(activeGames) do
        if game.groupId == groupId then
            return game
        end
    end

    return nil
end

local function getGameById(gameId)
    return activeGames[gameId]
end

exports["prp-bridge"]:RegisterObject({
    objectName = "drug_drops_box",
    modelHash = Config.DropItem.animation.prop.hash,
    offset = Config.DropItem.animation.prop.position,
    rotation = Config.DropItem.animation.prop.rotation,
    boneId = Config.DropItem.animation.prop.bone,
    disableCollision = true,
    completelyDisableCollision = true,
})

local attachedBoxes = {}

local function detachBox(playerId)
    if not attachedBoxes[playerId] then return end

    exports["prp-bridge"]:RemoveAttachObject(playerId, attachedBoxes[playerId])
    attachedBoxes[playerId] = nil
    TriggerClientEvent("prp-drug-drops:client:carryAnim", playerId, false)
end

local function attachBox(playerId)
    if attachedBoxes[playerId] then return end

    attachedBoxes[playerId] = exports["prp-bridge"]:CreateAttachObject(playerId, "drug_drops_box")
    TriggerClientEvent("prp-drug-drops:client:carryAnim", playerId, true, Config.DropItem.animation.dictionary,
        Config.DropItem.animation.animation)
end

bridge.inv.registerSwapItemsHook(function(payload)
    local src = payload.source

    SetTimeout(1000, function()
        local hasBox = bridge.inv.hasItem(src, "drug_drops_box", 1)

        if hasBox and not attachedBoxes[src] then
            attachBox(src)
        elseif not hasBox and attachedBoxes[src] then
            detachBox(src)
        end
    end)

    return true
end, {
    itemFilter = { drug_drops_box = true },
})

AddEventHandler("playerDropped", function()
    attachedBoxes[source] = nil
end)

local function startDialog(zoneId)
    local src = source

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(src)
    if not groupId then
        lib.print.debug(("Player %d is not in a group"):format(src))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    local game = getGameByGroupId(groupId)
    if not game then
        lib.print.debug(("No active game found for group %s"):format(groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    lib.print.debug("Starting dialog for player " .. src)
    lib.print.debug("Zone ID:", zoneId)

    local dialog = {
        id = 'drug_drops_starting_npc',
        title = locale("STARTING_NPC_TITLE"),
        dialog = locale("STARTING_NPC_DIALOG"),
        options = {
            {
                title = locale("START_DRUG_DROP_RUN"),
                description = locale("START_DRUG_DROP_RUN_DESC"),
                serverEvent = "prp-drug-drops:server:startRun",
            },
            {
                title = locale("CANCEL"),
                description = locale("CANCEL_DESC"),
                serverEvent = "prp-drug-drops:server:cancelRun",
            }
        }
    }

    TriggerClientEvent("prp-dialogs:client:startDialog", src, zoneId, dialog)
end
RegisterNetEvent("prp-drug-drops:server:startDialog", startDialog)

local function openStartingCrate()
    local src = source

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(src)
    if not groupId then
        lib.print.debug(("Player %d is not in a group"):format(src))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    local game = getGameByGroupId(groupId)
    if not game then
        lib.print.debug(("No active game found for group %s"):format(groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    game:openStartingStash(src)
end
RegisterNetEvent("prp-drug-drops:server:openStartingCrate", openStartingCrate)

local function startRun()
    local src = source

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(src)
    if not groupId then
        lib.print.debug(("Player %d is not in a group"):format(src))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    local game = getGameByGroupId(groupId)
    if not game then
        lib.print.debug(("No active game found for group %s"):format(groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    game:startRun(src)
end
RegisterNetEvent("prp-drug-drops:server:startRun", startRun)

local function openDropCrate(gameId, pointIndex)
    local src = source

    local game = getGameById(gameId)
    if not game then
        lib.print.debug(("No active game found for group %s"):format(groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(src)
    if not groupId then
        lib.print.debug(("Player %d is not in a group"):format(src))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    if groupId ~= game.groupId then
        lib.print.debug(("Player %d's group %s does not match game group %s"):format(src, groupId, game.groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    game:openDropCrate(src, pointIndex)
end
RegisterNetEvent("prp-drug-drops:server:openDropCrate", openDropCrate)

local function openRewardsCrate(gameId)
    local src = source

    local game = getGameById(gameId)
    if not game then
        lib.print.debug(("No active game found for group %s"):format(groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    game:openRewardsCrate(src)
end
RegisterNetEvent("prp-drug-drops:server:openRewardsCrate", openRewardsCrate)

AddEventHandler("prp-drug-drops:server:gameCanceled", function(_, gameId)
    activeGames[gameId] = nil
end)

local function cancelRun()
    local src = source

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(src)
    if not groupId then
        lib.print.debug(("Player %d is not in a group"):format(src))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    local game = getGameByGroupId(groupId)
    if not game then
        lib.print.debug(("No active game found for group %s"):format(groupId))
        bridge.fw.notify(src, "error", locale("NO_DEAL_FOR_THIS_PLAYER"))
        return
    end

    game:cancel()
end
RegisterNetEvent("prp-drug-drops:server:cancelRun", cancelRun)

AddEventHandler('prp-bridge:server:groupDisbanded', function(partyId)
    for _, game in pairs(activeGames) do
        if game.partyId == partyId then
            game:cancel()
            break
        end
    end
end)

local function updateMetadata(source, itemUuid, inventoryId)
    local inventory = bridge.inv.getInventory(inventoryId)
    if not inventory then
        lib.print.error(("Failed to get inventory %s for metadata update"):format(inventoryId))
        return
    end

    local playerInventory = bridge.inv.getInventoryItems(source)

    local itemFound = false
    for _, item in pairs(playerInventory) do
        if item.metaData.uuid == itemUuid then
            itemFound = item
            break
        end
    end

    if not itemFound then
        lib.print.error(("Item with UUID %s not found in source %s's inventory during metadata update"):format(itemUuid,
            source))
        return
    end

    local itemCounts = {}
    for _, slot in pairs(inventory.items) do
        if slot and slot.name then
            itemCounts[slot.name] = (itemCounts[slot.name] or 0) + (slot.count or 0)
        end
    end

    local updated = bridge.inv.setItemMetaData(
        source,
        itemFound.slot,
        {
            uuid = itemUuid,
            items = itemCounts,
        }
    )

    if not updated then
        lib.print.error(("Failed to update metadata for item %s"):format(itemUuid))
        return
    end

    lib.print.debug(("Updated metadata for item %s with counts: %s"):format(itemUuid, json.encode(itemCounts)))
end

local registeredStashes = {}
local function openDrugBox(slot)
    local src = source

    local item = bridge.inv.getSlot(src, slot)
    if not item then
        lib.print.error(("Failed to get item in slot %d for player %d"):format(slot, src))
        return
    end

    if not registeredStashes[item.metadata.uuid] then
        registeredStashes[item.metadata.uuid] = {}

        local items = {}
        for name, count in pairs(item.metadata.items or {}) do
            lib.print.debug(("Adding %d of %s to drug box stash"):format(count, name))

            items[#items + 1] = {
                name, count
            }
        end

        registeredStashes[item.metadata.uuid].stash = bridge.inv.createTemporaryStash({
            label = locale("DROP_BOX_STASH_LABEL"),
            slots = 50,
            maxWeight = 500,
        })

        Wait(0)
        for _, itemData in pairs(items) do
            bridge.inv.giveItem(registeredStashes[item.metadata.uuid].stash, itemData[1], itemData[2])
        end

        registeredStashes[item.metadata.uuid].hook = bridge.inv.registerSwapItemsHook(function()
            SetTimeout(0, function()
                updateMetadata(src, item.metadata.uuid, registeredStashes[item.metadata.uuid].stash)
            end)

            return true
        end, {
            inventoryFilter = {
                (registeredStashes[item.metadata.uuid].stash:gsub("%-", "%%-"))
            }
        })
    end

    bridge.inv.forceOpenStash(src, registeredStashes[item.metadata.uuid].stash)
end
RegisterNetEvent("prp-drug-drops:server:openDrugBox", openDrugBox)

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

    TriggerClientEvent("prp-drug-drops:client:startingLocations", src, locations)
end
RegisterNetEvent("prp-drug-drops:server:requestStartingData", sendLocations)
