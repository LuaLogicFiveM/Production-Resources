---@class TruckTransport
---@field airfield number
---@field truck number truckHandle
---@field plate string plate for truckHandle
---@field groupId number groupId
---@field startedBy number startedBy
---@field transporting boolean transporting
---@field activeTracker number activeTracker

---@type table<number, TruckTransport>
local Transports = {}

local function findItem(inventory, itemName, metaData)
    local items = bridge.inv.getInventoryItems(inventory)
    for _, item in pairs(items) do
        if item.name == itemName then
            local match = true
            
            if metaData then
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

---@class TruckTransport : OxClass
local Transport = lib.class("TruckTransport")

function Transport:constructor(data)
    for key, value in pairs(data) do
        self[key] = value
    end
end

function Transport:start()
    local truckData = Config.AIRFIELDS[self.airfield].truck

    local truckHandle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = truckData.model,
        coords = truckData.location.xyzw,
        heading = truckData.location.w
    })


    if not truckHandle or not DoesEntityExist(truckHandle) then
        return false, locale("TRUCK_TRANSPORT_FAILED_TO_SPAWN_VEHICLE")
    end

    if not plate then
        return false, locale("TRUCK_TRANSPORT_FAILED_TO_GET_VIN")
    end

    local smugglingCrateItem = findItem(pSource, Config.Items.crate, {
        tracker = true
    })

    if not smugglingCrateItem then
        DeleteEntity(truckHandle)

        return false, locale("TRUCK_TRANSPORT_NO_GUN_CRATE")
    end

    local removed = bridge.inv.removeItem(self.startedBy, Config.Items.crate, smugglingCrateItem.count,
        smugglingCrateItem.metadata)
    if not removed then
        DeleteEntity(truckHandle)

        return false, locale("TRUCK_TRANSPORT_FAILED_TO_REMOVE_GUN_CRATE")
    end

    local added = bridge.inv.giveItem("trunk" .. plate, Config.Items.crate, smugglingCrateItem.count,
        smugglingCrateItem.metadata)
    if not added then
        DeleteEntity(truckHandle)

        return false, locale("TRUCK_TRANSPORT_FAILED_TO_MOVE_GUN_CRATE")
    end

    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
    if not group then
        DeleteEntity(truckHandle)
        return false, locale("TRUCK_TRANSPORT_GROUP_NOT_FOUND")
    end

    for _, member in pairs(group.getMembers()) do
        bridge.vkeys.give(member.src, truckHandle)
    end

    local safeHouse = math.random(1, #Config.SafeHouses)

    Entity(truckHandle).state.gunSmugglingTransport = self.airfield
    Entity(truckHandle).state.gunSmugglingTransportGroupId = self.groupId
    Entity(truckHandle).state.gunSmugglingTransportSafeHouse = safeHouse

    Entity(truckHandle).state.DisableBennys = true

    self.truck = truckHandle
    self.plate = plate
    self.safehouse = safeHouse

    self:notify(locale("TRUCK_TRANSPORT_PUT_CRATE_IN_TRUCK"))
    self:event("prp-crime:smuggling:truckTransportStarted", self.airfield)

    return true
end

function Transport:thread()
    CreateThread(function()
        while self.activeTracker do
            Wait(10000)

            local truckCoords = GetEntityCoords(self.truck)

            TriggerClientEvent("prp-crime:smuggling:truckLocationUpdate", -1, self.groupId, truckCoords)

            if os.time() - self.activeTracker > Config.TruckTransport.trackerTimeout then
                self.activeTracker = false

                TriggerClientEvent("prp-crime:smuggling:removeTruckLocationBlip", -1, self.groupId)

                self:notify(locale("TRUCK_TRANSPORT_TRACKER_DISABLED"))
            end
        end
    end)
end

function Transport:notify(message)
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
    if not group then return end

    for _, member in pairs(group.getMembers()) do
        bridge.phone.sendMessage(member.src, Config.Mission.phoneNumber, message)
    end
end

function Transport:event(event, data)
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
    if not group then return end

    group.triggerEvent(event, data)
end

function Transport:destroy()
    if self.truck and DoesEntityExist(self.truck) then
        DeleteEntity(self.truck)
    end

    self:event("prp-crime:smuggling:truckTransportCompleted")

    for index, transport in ipairs(Transports) do
        if transport == self then
            table.remove(Transports, index)

            break
        end
    end
end

local function getTransportMissionByGroupId(groupId)
    for _, transport in pairs(Transports) do
        if transport.groupId == groupId then
            return transport
        end
    end

    return nil
end

lib.callback.register("prp-crime:smuggling:startTruckTransport", function(pSource, airfield)
    local stateId = bridge.fw.getIdentifier(pSource)
    if not stateId then
        return false, locale("TRUCK_TRANSPORT_NOT_IN_GROUP")
    end

    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        return false, locale("TRUCK_TRANSPORT_NOT_IN_GROUP")
    end

    if Transports[airfield] then
        return false, locale("TRUCK_TRANSPORT_MISSION_IN_PROGRESS")
    end

    local transport = Transport:new({
        airfield = airfield,
        groupId = group.getUuid(),
        startedBy = pSource,
        transporting = false
    })

    local success, errorMessage = transport:start()
    if not success then
        return false, errorMessage
    end

    Transports[airfield] = transport

    return true
end)

local handingOver = false

lib.callback.register("prp-crime:smuggling:handOverGunCrateReward", function(pSource, safehouseIndex)
    if handingOver then
        return false, locale("TRUCK_TRANSPORT_ALREADY_HANDING_OVER")
    end

    handingOver = true

    local group = exports['prp-bridge']:GetGroupFromMember(pSource)
    if not group then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_NOT_IN_GROUP")
    end

    local transportMission = getTransportMissionByGroupId(group.getUuid())
    if not transportMission then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_NOT_IN_TRANSPORT_MISSION")
    end

    if transportMission.safehouse ~= safehouseIndex then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_NOT_AT_CORRECT_SAFEHOUSE")
    end

    local missionItem = findItem(pSource, Config.Items.crate)
    if not missionItem then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_NO_GUN_CRATE")
    end

    local missionId = missionItem.metadata.missionId
    if not missionId or not Config.MISSIONS[missionId] then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_INVALID_MISSION")
    end

    if not transportMission.truck or not DoesEntityExist(transportMission.truck) then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_VEHICLE_MISSING")
    else
        local playerPed = GetPlayerPed(pSource)
        local playerCoords = GetEntityCoords(playerPed)
        local truckCoords = GetEntityCoords(transportMission.truck)
        local distance = #(playerCoords - truckCoords)

        if distance > 20.0 then
            handingOver = false
            return false, locale("TRUCK_TRANSPORT_TOO_FAR_FROM_VEHICLE")
        end
    end

    local removed = bridge.inv.removeItem(pSource, Config.Items.crate, 1, nil, missionItem.slot)

    if not removed then
        handingOver = false
        return false, locale("TRUCK_TRANSPORT_NO_GUN_CRATE")
    end

    transportMission:notify(locale("TRUCK_TRANSPORT_MISSION_COMPLETED"))

    bridge.log.send(Config.LogWebhook, "Truck Transport Completed", "A truck transport mission has been completed.", {
        mission_id = missionId,
        character_id = bridge.fw.getIdentifier(pSource),
        player_name = GetPlayerName(pSource),
    })

    transportMission:destroy()

    for _, item in ipairs(Config.TruckTransport.guaranteedRewards[missionId]) do
        local count = type(item.count) == "table" and math.random(item.count[1], item.count[2]) or item.count

        bridge.inv.giveItem(pSource, item.itemId, count, item.metaData)
    end

    local rewardPool = Config.TruckTransport.rewards[missionId]
    if rewardPool then
        local loot = exports['prp-bridge']:GenerateLoot(rewardPool, Config.TruckTransport.rewardCount)
        for _, reward in pairs(loot or {}) do
            bridge.inv.giveItem(pSource, reward.name, reward.count, reward.metadata)
        end
    end

    Transports[transportMission.airfield] = nil
    handingOver = false

    return true
end)

RegisterNetEvent("prp-crime:smuggling:truckTransportStarted", function(airfield)
    local transport = Transports[airfield]
    if not transport then
        return
    end

    if transport.transporting then
        return
    end

    transport.transporting = true

    local vehiclePlate = GetVehicleNumberPlateText(transport.truck)

    local text = locale("TRUCK_TRANSPORT_ALERT_TEXT", 'Unknown', vehiclePlate,
        Config.AIRFIELDS[transport.airfield].label)

    bridge.dispatch.sendAlert(
        source,
        Config.Alert.jobs or { 'police' },
        GetEntityCoords(transport.truck),
        {
            code = Config.Alert.code,
            title = Config.Alert.title,
            description = text,
        },
        {
            sprite = Config.Alert.blip.sprite,
            scale = Config.Alert.blip.size,
            colour = Config.Alert.blip.color,
            text = Config.Alert.title,
            length = Config.Alert.blip.duration or 30000,
            flash = Config.Alert.blip.flashing,
        }
    )

    transport.activeTracker = os.time()

    transport:thread()
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for _, transport in ipairs(Transports) do
        transport:destroy()
    end
end)
