local spawnedATMs = {}
local lockdownZones = {}

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    for k, v in pairs(spawnedATMs) do
        if DoesEntityExist(v) then
            DeleteEntity(v)
        end
    end

    GlobalState["GLOBAL_ATM_COOLDOWN"] = false
end)

function RemoveSpawnedATM(atmNetId)
    spawnedATMs[atmNetId] = nil
end

---@param atmNetId number netId of the old atm entity
---@param keepOld boolean if we should not delete the old atm
---@param newModel? number model to swap to
---@param overrideCoords? vector3 original ATM coords from client
function RecreateATM(atmNetId, keepOld, newModel, overrideCoords)
    local oldATMEntity = AwaitEntityFromNetId(atmNetId)
    if not oldATMEntity then return end

    local isWeight = newModel == `blazer`

    local wasWeight = GetEntityModel(oldATMEntity) == `blazer`

    local atmCoords = overrideCoords or GetEntityCoords(oldATMEntity)
    local model = newModel and newModel or GetEntityModel(oldATMEntity)
    local rotation = GetEntityRotation(oldATMEntity)

    if wasWeight and not isWeight then
        rotation = vec3(rotation.x + 90.0, rotation.y, rotation.z)
    end

    if not keepOld then
        DeleteEntity(oldATMEntity)
        spawnedATMs[atmNetId] = nil

        local deleted = lib.waitFor(function()
            if not DoesEntityExist(oldATMEntity) then
                return true
            end
        end, 'Failed to delete old ATM entity', 5000)

        if not deleted then
            lib.print.error("Failed to delete old ATM entity?")
            return nil
        end
    end

    local atmEntity = nil
    if isWeight then
        atmEntity = CreateVehicleServerSetter(model, "automobile", atmCoords.x, atmCoords.y, atmCoords.z, rotation.z)
    else
        atmEntity = CreateObjectNoOffset(model, atmCoords.x, atmCoords.y, atmCoords.z, true, true, false)
    end

    local spawned = lib.waitFor(function()
        if DoesEntityExist(atmEntity) and NetworkGetEntityOwner(atmEntity) ~= -1 then
            return true
        end
    end, 'Failed to create new ATM entity', 5000)

    if not spawned then
        lib.print.error("Failed to create new ATM entity?")
        return nil
    end

    local netId = NetworkGetNetworkIdFromEntity(atmEntity)

    if isWeight then
        FreezeEntityPosition(atmEntity, true)
        SetEntityCoords(atmEntity, atmCoords.x, atmCoords.y, atmCoords.z, false, false, false, false)
    end

    local weightRot = isWeight and vec3(-90.0, 0.0, 0.0) or vec3(0.0, 0.0, 0.0)
    local newRotation = vec3(rotation.x + weightRot.x, rotation.y + weightRot.y, rotation.z + weightRot.z)
    rotation = newRotation

    SetEntityRotation(atmEntity, newRotation.x, newRotation.y, newRotation.z, 2, true)

    local atmState = Entity(atmEntity).state
    atmState:set("deleteNearWorldATM", { model = model, coords = atmCoords }, true)
    atmState:set("atmRotation", rotation, true)
    atmState:set("ATM_WEIGHT", isWeight and {
        atmNetId = netId,
        coords = atmCoords,
        rot = rotation,
        pulled = false,
    } or nil, true)

    spawnedATMs[netId] = atmEntity

    return atmEntity, netId
end

-- // This creates a zone for all players to lock nearby ATMs from being robbed.
-- // This stops players from robbing 1 ATM, then robbing another one right beside it immediately.
---@param coords vector3
function CreateLockdownZone(atmNetId, coords)
    lockdownZones[atmNetId] = coords
end

function RemoveLockdownZone(atmNetId)
    lockdownZones[atmNetId] = nil
end

function IsNearLockdownZone(coords)
    for k, v in pairs(lockdownZones) do
        if #(coords - v) < 50.0 then
            return true
        end
    end
    return false
end

---@type number
local onDuty = 0

function cacheDutyCount()
    local count = 0

    for _, player in pairs(GetPlayers()) do
        local src = tonumber(player)
        if not src then goto continue end

        for _, job in pairs(SHConfig.PoliceJobs) do
            if bridge.fw.hasJob(src, job, nil, true) then
                count = count + 1
                break
            end
        end

        ::continue::
    end

    onDuty = count
end
SetInterval(cacheDutyCount, 5 * 1000)

---@return number
function getOnDutyCount()
    return onDuty or 0
end

function isPoliceOfficer(source)
    for _, job in pairs(SHConfig.PoliceJobs) do
        if bridge.fw.hasJob(source, job, nil, true) then
            return true
        end
    end

    return false
end

---@param source number
---@param minGroupSize number
---@return boolean inGroup
---@return table? groupData
function IsInGroup(source, minGroupSize)
    local group = exports['prp-bridge']:GetGroupFromMember(source)
    if not group then
        return false
    end

    local members = group.getMembersCount()
    if members < minGroupSize then
        return false
    end

    return true, group.getMembers()
end

function RandomFloatInRange(min, max)
    return math.random() * (max - min) + min
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

function GiveSearchLoot(source, lootTableRolls, lootTable, guaranteedRarities)
    local loot = GetLootReward(lootTableRolls, lootTable, guaranteedRarities)
    for k, v in pairs(loot or {}) do
        bridge.inv.giveItem(source, v.name, v.count, v.metaData)
    end

    return loot
end

function DispatchAlert(source, chance, coords, code, title, blip)
    if math.random(1, 100) > chance then return end

    bridge.dispatch.sendAlert(
        source,
        SHConfig.PoliceJobs,
        coords,
        {
            code = code,
            title = title,
            length = blip.duration / 60, -- convert to minutes
        },
        {
            sprite = blip.icon,
            colour = blip.color,
            scale = blip.size,
            text = blip.text
        },
        blip.flashing
    )
end

---@param atmEntity number
---@param updateFn fun(data: table)
---@return table? atmRobData the updated data, or nil if entity is gone
function UpdateAtmRobData(atmEntity, updateFn)
    if not DoesEntityExist(atmEntity) then return nil end
    local atmState = Entity(atmEntity).state
    local data = atmState.atmRobData or {}
    updateFn(data)
    atmState:set("atmRobData", data, true)
    return data
end

function AwaitEntityFromNetId(netId)
    local entity = lib.waitFor(function()
        local ent = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(ent) then
            return ent
        end
    end, 'Failed to get entity from netId: ' .. tostring(netId), 5000)

    if not entity then
        lib.print.error("Failed to get entity from netId: " .. tostring(netId))
    end

    return entity
end

function StartGroupCooldown(source)
    -- // If the OwnerRobCooldown is 0, just skip all of this
    if Config.OwnerRobCooldown == 0 then return end

    local playersToCooldown = {}

    local affilCooldown = math.floor(Config.OwnerRobCooldown * (Config.AffiliateRobCooldown / 100))

    -- // If we're in a group, give people cooldowns based off their group role
    local inGroup, members = IsInGroup(source, Config.Hack.minGroupSize)
    if inGroup and members then
        for _, v in pairs(members) do
            playersToCooldown[v.src] = v.isLeader and Config.OwnerRobCooldown or affilCooldown
        end
    else
        -- // If we're not in a group, just give this player a cooldown
        playersToCooldown[source] = Config.OwnerRobCooldown
    end

    -- // Also grab all nearby players to give them a cooldown as well
    local nearPlys = lib.getNearbyPlayers(source, 15.0)
    for k, v in pairs(nearPlys) do
        if v.id ~= source and not playersToCooldown[v.id] then
            playersToCooldown[v.id] = affilCooldown
        end
    end

    for k, v in pairs(playersToCooldown) do
        local stateId = bridge.fw.getIdentifier(k)
        exports['prp-bridge']:startCooldownByIdentifier(stateId, "atm_robbery", v, false)
    end
end

function IsCooldownActive(source)
    local stateId = bridge.fw.getIdentifier(source)
    return SHConfig.Debug and false or exports["prp-bridge"]:isCooldownActiveForIdentifier(stateId, "atm_robbery")
end

function SendLog(source, category, desc, data)
    pcall(function()
        bridge.log.send(
            Config.LogWebhookurl,
            category,
            desc,
            data
        )
    end)
end
