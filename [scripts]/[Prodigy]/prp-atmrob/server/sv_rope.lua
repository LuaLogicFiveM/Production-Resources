local unlockTimer = {}

RegisterNetEvent("prp-atmrob:server:tryAttachRopeToATM", function(atmNetId, originalCoords)
    local src = source

    -- // Check if the player is in a large enough group
    if Config.Rope.minGroupSize > 1 then
        local inGroup, groupData = IsInGroup(src, Config.Rope.minGroupSize)
        if not inGroup then
            bridge.fw.notify(src, "error", locale("GROUP_NOT_BIG"))
            return
        end
    end

    if (getOnDutyCount() or 0) < Config.Rope.requiredCops then
        bridge.fw.notify(src, "error", locale("NOT_ENOUGH_POLICE"))
        return
    end

    if IsCooldownActive(src) or GlobalState["GLOBAL_ATM_COOLDOWN"] then
        bridge.fw.notify(src, "error", locale("PLAYER_COOLDOWN"))
        return
    end

    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData or {}

    -- // Some anticheat checks
    local atmCoords = GetEntityCoords(atmEntity)
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - atmCoords)
    if dist > 2.0 or atmRobData.hasDevice or atmRobData.beingHacked or atmRobData.robbed or atmRobData.exploded or atmRobData.locked or atmRobData.attachedPlayer then
        bridge.fw.notify(src, "error", locale("CANT_DO_THAT"))
        return
    end

    if IsNearLockdownZone(atmCoords) then
        bridge.fw.notify(src, "error", locale("AREA_TOO_HOT"))
        return
    end

    -- // Check if player has the rope item
    local ropeItems = bridge.inv.searchInventory(src, SHConfig.RopeItem)

    if not next(ropeItems or {}) then
        bridge.fw.notify(src, "error", locale("NO_ROPE_INV"))
        return
    end

    atmRobData.hasDevice = "rope"
    atmState:set("atmRobData", atmRobData, true)
    GlobalState["GLOBAL_ATM_COOLDOWN"] = true

    local finished = lib.callback.await("prp-bridge:progress", src, {
        name = "atmrob-attach-rope-prog",
        duration = 800,
        label = locale("TYING_ROPE"),
        useWhileDead = false,
        canCancel = true,
        ignoreModifier = false,
        disarm = true,
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            animFlag = 49
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false,
        },
    })

    if not finished then
        UpdateAtmRobData(atmEntity, function(data)
            data.hasDevice = nil
            data.attachedPlayer = nil
        end)
        Player(src).state:set("holdingATMRope", {
            source = src,
            atmNetId = nil
        }, true)
        GlobalState["GLOBAL_ATM_COOLDOWN"] = false
        return
    end

    local newATMEntity
    newATMEntity, atmNetId = RecreateATM(atmNetId, false, `blazer`, originalCoords)
    TriggerClientEvent("prp-atmrob:client:syncWeight", -1, atmNetId, originalCoords, GetEntityRotation(newATMEntity), false)

    SetVehicleDoorsLocked(newATMEntity, 2)
    Entity(newATMEntity).state:set("DisableLockpick", true, true)
    Entity(newATMEntity).state:set("Locked", true, true)

    CreateLockdownZone(atmNetId, GetEntityCoords(newATMEntity))

    SetTimeout(Config.GlobalCooldown * 60000, function()
        GlobalState["GLOBAL_ATM_COOLDOWN"] = false
    end)

    atmState = Entity(newATMEntity).state
    atmRobData.atmNetId = atmNetId
    atmRobData.hasDevice = "rope"
    atmRobData.initiator = src
    atmRobData.attachedPlayer = src
    atmState:set("atmRobData", atmRobData, true)
    Player(src).state:set("holdingATMRope", {
        source = src,
        atmNetId = atmNetId
    }, true)

    bridge.inv.removeItem(src, SHConfig.RopeItem, 1)
end)

RegisterNetEvent("prp-atmrob:server:tryDetachRopeFromATM", function(atmNetId)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData

    -- // Check if we're holding a rope and if we are the player holding this rope
    if not atmRobData or not atmRobData.attachedPlayer then
        bridge.fw.notify(src, "error", locale("NO_ROPE_TIED"))
        return
    end

    if atmRobData.attachedPlayer ~= src then
        bridge.fw.notify(src, "error", locale("NOT_HOLDING_ROPE"))
        return
    end

    RemoveLockdownZone(atmNetId)

    atmRobData.hasDevice = nil
    atmRobData.attachedPlayer = nil
    atmRobData.attachedVehicle = nil
    atmState:set("atmRobData", atmRobData, true)
    Player(src).state:set("holdingATMRope", {
        source = src,
        atmNetId = nil
    }, true)

    -- // Delete this ATM entity (the visualATM takes over as the main ATM)
    DeleteEntity(atmEntity)
    RemoveSpawnedATM(atmNetId)

    bridge.inv.giveItem(src, SHConfig.RopeItem, 1)
end)

RegisterNetEvent("prp-atmrob:server:tryAttachRopeVehicle", function(vehNetId)
    local src = source

    -- -- // Check if we're actually holding a rope
    local playerState = Player(src).state
    local atmNetId = playerState.holdingATMRope?.atmNetId
    if not atmNetId then
        bridge.fw.notify(src, "error", locale("NEED_HOLD_ROPE"))
        return
    end

    local vehEntity = AwaitEntityFromNetId(vehNetId)
    if not vehEntity then return end
    local vehState = Entity(vehEntity).state
    local atmRobVehicleData = vehState.atmRobVehicleData or {}

    -- // Check if this vehicle already has a rope attached
    if atmRobVehicleData.attachedATM then
        bridge.fw.notify(src, "error", locale("ROPE_ALREADY_TIED"))
        return
    end

    atmRobVehicleData.attachedATM = atmNetId
    vehState:set("atmRobVehicleData", atmRobVehicleData, true)

    local finished = lib.callback.await("prp-bridge:progress", src, {
        name = "atmrob-attach-rope-veh-prog",
        duration = SHConfig.Debug and 1000 or 3000,
        label = locale("TYING_ROPE"),
        useWhileDead = false,
        canCancel = true,
        ignoreModifier = false,
        disarm = true,
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            animFlag = 0
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false,
        },
    })

    if not finished then
        atmRobVehicleData.attachedATM = nil
        vehState:set("atmRobVehicleData", atmRobVehicleData, true)
        return
    end

    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    if not atmRobData then return end

    atmRobData.attachedPlayer = nil
    atmRobData.attachedVehicle = vehNetId
    atmState:set("atmRobData", atmRobData, true)
    Player(src).state:set("holdingATMRope", {
        source = src,
        atmNetId = nil
    }, true)

    local alertData = Config.Rope.alertData
    DispatchAlert(src, alertData.chance, GetEntityCoords(atmEntity), alertData.code, alertData.title, alertData.blip)
end)

RegisterNetEvent("prp-atmrob:server:tryDetachATMVehicle", function(vehNetId)
    local src = source
    local vehEntity = AwaitEntityFromNetId(vehNetId)
    if not vehEntity then return end
    local vehState = Entity(vehEntity).state
    local atmRobVehicleData = vehState.atmRobVehicleData
    if not atmRobVehicleData then return end

    -- // Make sure this vehicle is actually attached to an ATM
    if not vehState.atmRobVehicleData then
        bridge.fw.notify(src, "error", locale("NO_ROPE_TIED"))
        return
    end

    local finished = lib.callback.await("prp-bridge:progress", src, {
        name = "atmrob-attach-rope-veh-prog",
        duration = SHConfig.Debug and 1000 or 3000,
        label = locale("UNTYING_ROPE"),
        useWhileDead = false,
        canCancel = true,
        ignoreModifier = false,
        disarm = true,
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            animFlag = 0
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false,
        },
    })

    if not finished then return end

    vehState = Entity(vehEntity).state
    local atmNetId = vehState.atmRobVehicleData.attachedATM
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    if not atmRobData then return end

    -- // If this ATM wasn't pulled fully off the wall, remove the lockdownZone
    if not atmRobData.pulled then
        RemoveLockdownZone(atmNetId)
    end

    atmRobData.hasDevice = nil
    atmRobData.attachedPlayer = nil
    atmRobData.attachedVehicle = nil
    atmState:set("atmRobData", atmRobData, true)

    atmRobVehicleData.attachedATM = nil
    vehState:set("atmRobVehicleData", atmRobVehicleData, true)

    if not atmRobData.pulled then
        bridge.inv.giveItem(src, SHConfig.RopeItem, 1)
    end
end)

RegisterNetEvent("prp-atmrob:server:updateATMPull", function(atmNetId, amount)
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    Entity(atmEntity).state:set("pullAmount", amount, true)
end)

-- // Wait until the ATM is fully detached from everything before deleting it
-- // We do this so the ATM doesn't just delete out of nowhere while being pulled
local function tryCleanupATM(atmEntity, atmNetId)
    if not DoesEntityExist(atmEntity) then return end

    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    if not atmRobData then return end

    -- // If the ATM is detatched from everything, delete it
    if atmRobData.attachedPlayer == nil and atmRobData.attachedVehicle == nil then
        TriggerClientEvent("prp-atmrob:client:atmDeleted", -1, atmNetId)
        DeleteEntity(atmEntity)
        RemoveSpawnedATM(atmNetId)
        return
    end

    -- // Else, wait another 10 seconds and try again
    SetTimeout(10000, function()
        tryCleanupATM(atmEntity, atmNetId)
    end)
end

RegisterNetEvent("prp-atmrob:server:atmYoinked", function(vehNetId, atmNetId, inFront)
    local src = source
    local vehEntity = AwaitEntityFromNetId(vehNetId)
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not vehEntity or not atmEntity then return end

    local pCoords = GetEntityCoords(GetPlayerPed(src))
    local atmCoords = GetEntityCoords(atmEntity)
    local vehCoords = GetEntityCoords(vehEntity)
    if #(pCoords - atmCoords) > 30.0 or #(pCoords - vehCoords) > 30.0 then return end

    -- Push ATM toward the vehicle so it clears the wall/interior
    local dir = vector3(vehCoords.x - atmCoords.x, vehCoords.y - atmCoords.y, 0.0)
    local dist = #dir
    if dist > 0.0 then
        dir = dir / dist
    end
    local pushed = vector3(atmCoords.x + dir.x * 3.0, atmCoords.y + dir.y * 3.0, atmCoords.z)
    SetEntityCoords(atmEntity, pushed.x, pushed.y, pushed.z, false, false, false, false, false)

    local vehState = Entity(vehEntity).state
    local atmState = Entity(atmEntity).state

    local atmRobVehicleData = vehState.atmRobVehicleData
    if not atmRobVehicleData then return end
    local atmRobData = atmState.atmRobData
    if not atmRobData then return end

    -- // Make sure this is legit
    if atmRobVehicleData.attachedATM ~= atmNetId or atmRobData.pulled then return end

    atmRobData.pulled = true
    atmState:set("atmRobData", atmRobData, true)

    TriggerClientEvent("prp-atmrob:client:atmYoinked", -1, atmNetId)

    local unlockTime = RandomFloatInRange(Config.Rope.unlockTime.min, Config.Rope.unlockTime.max)
    unlockTimer[atmNetId] = lib.timer(unlockTime * 1000, function()
        if not DoesEntityExist(atmEntity) then return end
        unlockTimer[atmNetId] = nil

        UpdateAtmRobData(atmEntity, function(data)
            data.canBeSearched = true
        end)

        if Config.Rope.playSoundOnUnlock then
            TriggerClientEvent("prp-atmrob:client:unlockSound", -1, atmNetId)
        end
    end, true)

    -- // Auto reset timer
    SetTimeout(Config.Rope.resetTime * 60000, function()
        RemoveLockdownZone(atmNetId)
        tryCleanupATM(atmEntity, atmNetId)
    end)

    -- // Blip Update Thread
    if Config.Rope.tracker.enabled then
        CreateThread(function()
            while true do
                Wait(Config.Rope.tracker.updateTime)

                if not DoesEntityExist(atmEntity) then
                    TriggerClientEvent("prp-atmrob:client:atmBlipRemove", -1, atmNetId)
                    return
                end

                atmState = Entity(atmEntity).state
                atmRobData = atmState.atmRobData

                if not atmRobData.pulled or atmRobData.robbed then
                    TriggerClientEvent("prp-atmrob:client:atmBlipRemove", -1, atmNetId)
                    return
                end

                local coords = GetEntityCoords(atmEntity)
                TriggerClientEvent("prp-atmrob:client:atmBlipUpdate", -1, atmNetId, coords, Config.Rope.tracker.blip)
            end
        end)
    end
end)

RegisterNetEvent("prp-atmrob:server:tryManuallySecureATM", function(atmNetId)
    local src = source

    if not isPoliceOfficer(src) then return end

    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end

    local atmState = Entity(atmEntity).state
    if not atmState.atmRobData then return end

    if not atmState.atmRobData.pulled then
        bridge.fw.notify(src, "error", locale("ATM_NOT_PULLED"))
        return
    end

    -- // Check if this ATM is attached to something
    if atmState.atmRobData.attachedPlayer or atmState.atmRobData.attachedVehicle then
        bridge.fw.notify(src, "error", locale("SHOULD_UNTIE"))
        return
    end

    local finished = lib.callback.await("prp-bridge:progress", src, {
        name = "atmrob-secure-prog",
        duration = SHConfig.Debug and 1000 or 10250,
        label = locale("SECURING"),
        useWhileDead = false,
        canCancel = true,
        ignoreModifier = false,
        disarm = true,
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            animFlag = 0
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false,
        },
    })

    if not finished then return end

    SetEntityCoords(atmEntity, 0.0, 0.0, 0.0, false, false, false, false)
    FreezeEntityPosition(atmEntity, true)

    atmState:set("ATM_WEIGHT", nil, true)
    TriggerClientEvent("prp-atmrob:client:atmDeleted", -1, atmNetId)
end)

RegisterNetEvent("prp-atmrob:server:trySearchPulledATM", function(atmNetId)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end

    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    if not atmRobData then return end

    if not atmRobData.canBeSearched then
        local timer = unlockTimer[atmNetId] and unlockTimer[atmNetId]:getTimeLeft("s") or 0
        bridge.fw.notify(src, "error", locale("CANT_SEARCH_YET", math.floor(timer)))
        return
    end

    if not atmRobData.pulled or atmRobData.robbed then return end

    atmRobData.robbed = true
    atmState:set("atmRobData", atmRobData, true)

    local finished = lib.callback.await("prp-bridge:progress", src, {
        name = "atmrob-search-prog",
        duration = SHConfig.Debug and 1000 or 6500,
        label = locale("SEARCHING"),
        useWhileDead = false,
        canCancel = true,
        ignoreModifier = false,
        disarm = true,
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            animFlag = 0
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false,
        },
    })

    if not finished then
        UpdateAtmRobData(atmEntity, function(data)
            data.robbed = false
        end)
        return
    end

    local updatedData = UpdateAtmRobData(atmEntity, function(data)
        data.robbed = true
        data.canBeSearched = false
    end)

    StartGroupCooldown(src)
    if updatedData and updatedData.initiator and updatedData.initiator ~= src then
        StartGroupCooldown(updatedData.initiator)
    end

    local loot = GiveSearchLoot(src, Config.Rope.loot.lootTableRolls, Config.Rope.loot.lootTable, Config.Rope.loot.guaranteedRarities)

    SendLog(src, "ATM Robbery", "Pulled ATM Robbed", {
        atmrob_ropeLoot = json.encode(loot or {"unknown loot"})
    })

    SetTimeout(Config.Rope.cleanupAfterLoot * 60000, function()
        if not DoesEntityExist(atmEntity) then return end

        SetEntityCoords(atmEntity, 0.0, 0.0, 0.0, false, false, false, false)
        FreezeEntityPosition(atmEntity, true)

        local atmState = Entity(atmEntity).state
        atmState:set("ATM_WEIGHT", nil, true)

        RemoveLockdownZone(atmNetId)
        TriggerClientEvent("prp-atmrob:client:atmDeleted", -1, atmNetId)
    end)
end)
