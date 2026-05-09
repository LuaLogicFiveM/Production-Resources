SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

ActiveMissions = {}
local currentId = 1
local ready = false
Snitches = {}

local function setupCommand()
        if not Config.Testing.enabled then
        return
    end

    bridge.fw.registerCommand(
        Config.Testing.command,
        locale("START_AERIAL_COMMAND_HELP"),
        nil,
        Config.Testing.restricted,
        function(source, args, rawCommand)
            if not GetFreeLocation() then
                bridge.fw.notify(source, 'error', locale("NO_LOCATIONS_FREE"))
                return
            end

            local group = exports['prp-bridge']:GetGroupFromMember(source)
            if not group then
                bridge.fw.notify(source, 'error', locale("NO_GROUP"))
                return
            end

            local mission = StartAerial(source, "admin"..currentId+10)
            mission:start()
        end
    )
end

local function startup()
    if ready then
        return
    end
    ready = true

    setupCommand()
end
SetTimeout(0, startup)

function StartAerial(playerId, taskId)
    local missionId = currentId

    ActiveMissions[missionId] = Aerial:new(playerId, nil, {
        faction = nil,
        id = missionId,
        taskId = taskId,
        locationIndex = GetFreeLocation()
    })
    currentId = currentId + 1

    return ActiveMissions[missionId]
end

function GetFreeLocation()
    local freeLocations = {}
    for k, v in pairs(Config.Locations) do
        if not v.missionId then
            table.insert(freeLocations, k)
        end
    end
    return freeLocations[math.random(1, #freeLocations)]
end

function GetActiveMissionByGroupId(groupId)
    for missionId, mission in pairs(ActiveMissions) do
        if mission.groupId == groupId then
            return mission
        end
    end
    return nil
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

function GetActiveMissionByPlayerId(playerId)
    local stateId = bridge.fw.getIdentifier(playerId)
    local groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)

    for uniqueId, mission in pairs(ActiveMissions) do
        if mission.stateId == stateId or (groupId and mission.groupId == groupId) or mission.enemyStateId == stateId or (groupId and mission.enemyGroupId == groupId) then
            return mission
        end
    end
end

function HasItemWithDurability(inventoryId, itemName)
    if not inventoryId or not itemName then
        return false
    end
    local hasItem = false

    local items = bridge.inv.searchInventory(inventoryId, itemName)
    if not items then
        return false
    end

    for _, item in pairs(items) do
        hasItem = item
        if item.metadata and (not item.metadata.durability or item.metadata.durability > 0) then
            hasItem = item
            break
        end
    end
    return hasItem
end

AddEventHandler('onResourceStop', function(resourceName)
    for k, v in pairs(ActiveMissions) do
        v:destroy()
    end
end)

RegisterNetEvent("prp-aerialrun:getPlane", function(locationIndex)
    local mission = GetActiveMissionByPlayerId(source)
    if not mission then return end
    mission:getPlane(source, locationIndex)
end)

RegisterNetEvent("prp-aerialrun:dropCrate", function()
    local mission = GetActiveMissionByPlayerId(source)
    if not mission then return end
    mission:dropCrate(source)
end)

RegisterNetEvent("prp-aerialrun:leftPlane", function()
    local mission = GetActiveMissionByPlayerId(source)
    if not mission then return end
    mission:leftPlane(source)
end)

RegisterNetEvent("prp-aerialrun:openCrate", function(locationIndex, crateIndex)
    local missionId = Config.Locations[locationIndex] and Config.Locations[locationIndex].missionId
    if not missionId then return end
    local source = source
    local mission = ActiveMissions[missionId]
    if not mission then return end
    mission:openCrate(source, locationIndex, crateIndex)
end)

function BuySnitch(source, itemName, itemCount)
    local group = exports['prp-bridge']:GetGroupFromMember(source)
    if not group then
        bridge.fw.notify(source, 'error', locale("NO_GROUP"))
        return
    end

    if itemName == "money" then
        local money = bridge.fw.getMoney(source, 'cash')

        if money < itemCount then
            bridge.fw.notify(source, 'error', locale("NOT_ENOUGH_MONEY"))
            return
        end

        bridge.fw.removeMoney(source, 'cash', itemCount, "aerial_snitch")
    else
        local hasItem = bridge.inv.hasItem(source, itemName, itemCount)
        if not hasItem then
            bridge.fw.notify(source, 'error', locale("REQUIRED_ITEM_MISSING"))
            return
        end

        local success = bridge.inv.removeItem(source, itemName, itemCount)
        if not success then
            bridge.fw.notify(source, 'error', locale("REQUIRED_ITEM_MISSING"))
            return
        end
    end
    Snitches[tostring(source)] = {
        active = false
    }
end

RegisterNetEvent("prp-aerialrun:exchangeItems", function(index)
    local source = source
    local exchange = Config.ConvertPed.exchanges[index]
    if not exchange then return end
    if exchange.rewardItem and exchange.rewardItem == "SNITCH" then
        return BuySnitch(source, exchange.requiredItem, exchange.requiredCount)
    end
    local items = exchange.itemPoints
    local requiredPoints = exchange.requiredPoints
    local itemSearch = {}
    for k, v in pairs(items) do
        itemSearch[#itemSearch+1] = k
    end

    local itemCount = bridge.inv.count(source, itemSearch)
    local hasRequiredItem = nil
    if type(exchange.requiredItem) == "table" then
        for _, reqItem in pairs(exchange.requiredItem) do
            local hasItem = bridge.inv.hasItem(source, reqItem)
            if hasItem then
                hasRequiredItem = reqItem
                break
            end
        end
    else
        hasRequiredItem = bridge.inv.hasItem(source, exchange.requiredItem) and exchange.requiredItem
    end
    if not hasRequiredItem then
        bridge.fw.notify(source, 'error', locale("REQUIRED_ITEM_MISSING"))
        return
    end
    local itemsToRemove = {}
    for itemName, count in pairs(itemCount) do
        if items[itemName] and count > 0 then
            itemsToRemove[itemName] = math.min(math.floor(requiredPoints / items[itemName])+1, count)
            requiredPoints = requiredPoints - (itemsToRemove[itemName] * items[itemName])
            if requiredPoints <= 0 then
                break
            end
        end
    end
    if requiredPoints > 0 then
        bridge.fw.notify(source, 'error', locale("NOT_ENOUGH_ITEMS"))
        return
    end
    for itemName, count in pairs(itemsToRemove) do
        if not bridge.inv.removeItem(source, itemName, count) then
            bridge.fw.notify(source, 'error', locale("NOT_ENOUGH_ITEMS"))
            return
        end
    end
    if not bridge.inv.removeItem(source, hasRequiredItem, 1) then
        bridge.fw.notify(source, 'error', locale("REQUIRED_ITEM_MISSING"))
        return
    end

    bridge.inv.giveItem(source, exchange.rewardItem, 1)
end)

RegisterNetEvent("prp-aerialrun:decryptPendrive", function()
    local source = source
    local hasItem = bridge.inv.count(source, Config.Decrypt.requiredItem)
    if hasItem < 1 then
        bridge.fw.notify(source, 'error', locale("PENDRIVE_REQUIRED"))
        return
    end
    local success = bridge.inv.removeItem(source, Config.Decrypt.requiredItem, 1)
    if not success then
        bridge.fw.notify(source, 'error', locale("PENDRIVE_REQUIRED"))
        return
    end

    success = lib.callback.await("prp-aerialrun:decryptPendrive", source)
    if not success then
        bridge.fw.notify(source, 'error', locale("PENDRIVE_DECRYPT_FAILED"))
        return
    end
    bridge.inv.giveItem(source, Config.Decrypt.rewardItem, 1)
    bridge.fw.notify(source, 'success', locale("PENDRIVE_DECRYPTED"))
end)

function GetFreeSnitch(playerIds)
    local freeSnitches = {}
    for src, snitch in pairs(Snitches) do
        if not snitch.active and not table.contains(playerIds, tonumber(src)) then
            local snitchGroup = exports['prp-bridge']:GetGroupFromMember(tonumber(src))
            if snitchGroup then
                table.insert(freeSnitches, src)
            end
        end
    end
    if #freeSnitches == 0 then
        return nil
    end
    return freeSnitches[math.random(#freeSnitches)]
end

local function sendConfig()
    local src = source

    TriggerClientEvent("prp-aerialrun:setupConfig", src, {
        Locations = Config.Locations,
        ConvertPed = Config.ConvertPed,
        Decrypt = Config.Decrypt,
        PlaneModel = Config.PlaneModel,
    })
end 
RegisterNetEvent("prp-aerialrun:requestData", sendConfig)