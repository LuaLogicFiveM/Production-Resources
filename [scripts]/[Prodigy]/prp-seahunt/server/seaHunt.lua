---@enum STAGE
local STAGE = {
    GET_TOOLS = 1,
    SEARCH_TREASURE = 2,
    SELL_ITEMS = 3,
}

---@param mission Mission
function OnSeaHuntStart(mission)
    mission.phoneNumber = ("%d-%d-%d"):format(math.random(100, 999), math.random(100, 999), math.random(1000, 9999))
    mission:sendSMS(mission.phoneNumber, locale("SEAHUNT_MISSION_START_SMS"), "SZF")
    mission:sendSMSLocation(mission.phoneNumber, Config.DivingPed.coords.xyz, "SZF")
    mission.treasureLocation = GetFreeDivingLocation()
    Config.DivingLocations[mission.treasureLocation].missionId = mission.id
    mission.stage = STAGE.GET_TOOLS
    mission.endTime = os.time() + (Config.Mission.timeout * 60)
    mission.color = vec3(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
    mission.gotObjects = {}
    mission.gotRebreater = {}
    TriggerClientEvent("prp-seahunt:setLocationActive", -1, mission.treasureLocation, mission.id, mission.color)
    local coords = Config.DivingLocations[mission.treasureLocation].flareCoords.xyz
    local radius = Config.BlipRadius
    mission.targetCoords = vector3(coords.x + math.random(-radius / 4, radius / 4),
        coords.y + math.random(-radius / 4, radius / 4), coords.z)
    mission:sendEvent("prp-seahunt:radiusBlip", mission.targetCoords, radius)
end

function OnSeaHuntDestroy(mission)
    mission:sendEvent("prp-seahunt:destroy")
    if mission.treasureLocation then
        Config.DivingLocations[mission.treasureLocation].missionId = nil
        TriggerClientEvent("prp-seahunt:setLocationActive", -1, mission.treasureLocation, nil, nil)
    end
end

AddEventHandler("prp-bridge:server:playerLoad", function(source)
    local locations = {}
    for k, v in pairs(Config.DivingLocations) do
        if v.missionId then
            local mission = GetMissionById(v.missionId)
            table.insert(locations, { id = k, color = mission.color, missionId = mission.id })
        end
    end
    TriggerClientEvent("prp-seahunt:setLocationsActive", source, locations)
    local group = exports['prp-bridge']:GetGroupFromMember(source)
    if not group then return end
    
    local groupId = group.getUuid()
    if not groupId then return end
    local missionId = MissionGroupTable[tostring(groupId)]
    if not missionId then return end
    local mission = GetMissionById(missionId)
    if mission then
        mission.members[tostring(stateId)] = source
        if mission.targetCoords then
            TriggerClientEvent("prp-seahunt:radiusBlip", source, mission.targetCoords, radius)
        end
    end
end)

RegisterNetEvent("prp-seahunt:searchObject", function(locationId, objectId)
    local source = source
    local missionId = Config.DivingLocations[locationId].missionId
    if not missionId then return lib.print.debug("No mission ID found for location " .. tostring(locationId)) end
    local mission = GetMissionById(missionId)
    if not mission then return lib.print.debug("No mission found for mission ID " .. tostring(missionId)) end
    if mission.gotObjects[objectId] then
        bridge.fw.notify(source, 'error', locale("SEAHUNT_OBJECT_ALREADY_SEARCHED"))
        return
    end
    local object = Config.DivingLocations[locationId].objects[objectId]
    if not object or not object.dropTable then return lib.print.debug("No object or drop table found for object ID " .. tostring(objectId)) end
    local stateId = bridge.fw.getIdentifier(source)
    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(stateId)
    if not group then return lib.print.debug("No group found for state ID " .. tostring(stateId)) end
    local groupId = group.getUuid()
    if not groupId or tonumber(mission.groupId) ~= tonumber(groupId) then
        bridge.fw.notify(source, 'error', locale("SEAHUNT_OBJECT_NOT_ALLOWED"))
        return
    end
    local dropTable = Config.DropTables[object.dropTable]
    mission.gotObjects[objectId] = true
    if object.search then
        local success = lib.callback.await("prp-seahunt:searchProgress", source, object.searchTime)
        if not success then
            lib.print.debug("Search canceled for object ID " .. tostring(objectId))
            mission.gotObjects[objectId] = nil
            return
        end
    end
    if not groupId or tonumber(mission.groupId) ~= tonumber(groupId) then
        mission.stolenObjects = mission.stolenObjects or {}
        mission.stolenObjects[objectId] = true
    end
    for i = 1, dropTable.itemCount do
        for _, item in pairs(dropTable.items) do
            bridge.inv.giveItem(source, item.name, item.count, item.metaData)
        end
    end
    local allObjects = true
    local allObjectsStolen = true
    for k, v in pairs(Config.DivingLocations[locationId].objects) do
        if v.dropTable and not mission.gotObjects[k] then
            allObjects = false
        end
        if mission.gotObjects[k] and (not mission.stolenObjects or not mission.stolenObjects[k]) then
            allObjectsStolen = false
        end
    end
    if allObjects then
        if allObjectsStolen then
            mission:sendSMS(mission.phoneNumber, locale("SOMEONE_ELSE_STOLE_EVERYTHING"), "SZF")
            mission:destroy()
        else
            mission:sendSMS(mission.phoneNumber, locale("SEAHUNT_MISSION_FOUND_ALL"), "SZF")
            Citizen.SetTimeout(15000, function()
                mission:destroy()
            end)
        end
    end
end)

function GetFreeDivingLocation(missionId)
    local freeLocations = {}
    for k, v in pairs(Config.DivingLocations) do
        if not v.missionId then
            table.insert(freeLocations, k)
        end
    end
    if #freeLocations == 0 then return end
    local location = freeLocations[math.random(1, #freeLocations)]
    return location
end

RegisterNetEvent("prp-seahunt:getRebreather", function()
    local source = source
    local stateId = bridge.fw.getIdentifier(source)
    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(stateId)
    if not group then return end
    local groupId = group.getUuid()
    if not groupId then return end
    local missionId = MissionGroupTable[tostring(groupId)]
    if not missionId then return end
    local mission = GetMissionById(missionId)
    if not mission then return end
    if mission.gotRebreater[source] then
        bridge.fw.notify(source, 'error', locale("SEAHUNT_REBREATHER_ALREADY_HAVE"))
        return
    end
    mission.gotRebreater[source] = true
    local success = bridge.inv.giveItem(source, "diving_rebreather", 1)
    if not success then
        mission.gotRebreater[source] = nil
    end
end)

bridge.fw.registerItemUse("diving_rebreather", function(source, itemData)
    local remainingTime = itemData.metaData and itemData.metaData.rebreatherTime

    bridge.inv.removeItem(source, itemData.name, 1, itemData.metaData, itemData.slot)

    local equipped = lib.callback.await("prp-seahunt:client:useRebreather", source, remainingTime)

    if not equipped then
        bridge.inv.giveItem(source, "diving_rebreather", 1, itemData.metaData)
        return bridge.fw.notify(source, 'error', locale("REBREATHER_ALREADY_EQUIPPED"))
    end
end)

lib.callback.register("prp-seahunt:server:returnRebreather", function(source, remainingTime)
    bridge.inv.giveItem(source, "diving_rebreather", 1, { rebreatherTime = remainingTime })
    return true
end)

RegisterNetEvent("prp-seahunt:getSeashark", function()
    local source = source
    local stateId = bridge.fw.getIdentifier(source)
    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(stateId)
    if not group then return end
    local groupId = group.getUuid()
    if not groupId then return end
    local missionId = MissionGroupTable[tostring(groupId)]
    if not missionId then return end
    local mission = GetMissionById(missionId)
    if not mission then return end
    local price = Config.Seashark.price
    local walletAmount = bridge.fw.getMoney(source, "cash")
    if walletAmount < price then
        bridge.fw.notify(source, 'error', locale("SEAHUNT_NOT_ENOUGH_MONEY"))
        return
    end
    local removedFromWallet = bridge.fw.removeMoney(source, "cash", Config.Seashark.price, "seahunt_seashark")
    if not removedFromWallet then
        bridge.fw.notify(source, 'error', locale("SEAHUNT_FAILED_TO_REMOVE_MONEY"))
        return
    end

    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = Config.Seashark.model,
        coords = Config.Seashark.coords.xyz,
        heading = Config.Seashark.coords.w
    })

    if vehicle then
        bridge.vkeys.give(source, vehicle, plate)
        bridge.vfuel.set(source, vehicle, 100)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(MissionTable) do
            if v.endTime and os.time() > v.endTime then
                v:sendSMS(v.phoneNumber, locale("SEAHUNT_MISSION_TIMEOUT"), "SZF")
                v:destroy()
            end
        end
        Citizen.Wait(10 * 1000)
    end
end)
