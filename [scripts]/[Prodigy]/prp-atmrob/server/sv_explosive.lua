RegisterNetEvent("prp-atmrob:server:tryRigExplosiveCheckGroup", function(atmNetId)
    local source = source

    if Config.Explosive.minGroupSize > 1 then
        -- // Check if we're even in a group
        local inGroup, groupData = IsInGroup(source, Config.Explosive.minGroupSize)
        if not inGroup then
            bridge.fw.notify(source, "error", locale("GROUP_NOT_BIG"))
            return
        end
    end

    if (getOnDutyCount() or 0) < Config.Explosive.requiredCops then
        bridge.fw.notify(source, "error", locale("NOT_ENOUGH_POLICE"))
        return
    end

    if IsCooldownActive(source) or GlobalState["GLOBAL_ATM_COOLDOWN"] then
        bridge.fw.notify(source, "error", locale("PLAYER_COOLDOWN"))
        return
    end

    PlaceExplosive(source, atmNetId)
end)

function PlaceExplosive(source, atmNetId)
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    local modelData = SHConfig.ATMModels[GetEntityModel(atmEntity)]
    if not modelData then return end

    -- // Some anticheat checks
    local atmCoords = GetEntityCoords(atmEntity)
    local dist = #(GetEntityCoords(GetPlayerPed(source)) - atmCoords)
    if dist > 1.7 or (atmRobData and (atmRobData.hasDevice ~= nil or atmRobData.beingHacked or atmRobData.robbed or atmRobData.exploded)) then
        bridge.fw.notify(source, "error", locale("CANT_DO_THAT"))
        return
    end

    if IsNearLockdownZone(atmCoords) then
        bridge.fw.notify(source, "error", locale("AREA_TOO_HOT"))
        return
    end

    -- // Check if player has explosive item
    if not bridge.inv.hasItem(source, SHConfig.ExplosiveItem) then
        bridge.fw.notify(source, "error", locale("NO_HACK_DEVICE_INV"))
        return
    end

    atmEntity, atmNetId = RecreateATM(atmNetId, false)
    CreateLockdownZone(atmNetId, GetEntityCoords(atmEntity))
    GlobalState["GLOBAL_ATM_COOLDOWN"] = true

    -- // Update the stored atmState to the new entity
    atmState = Entity(atmEntity).state
    atmState:set("atmRobData", {
        atmNetId = atmNetId,
        hasDevice = "explosive",
    }, true)

    -- // Start minigame (this is temp till new minigame is made)
    local success = SHConfig.Debug
    if not SHConfig.Debug then
        success = lib.callback.await("prp-bridge:minigame", source, "cableConnect", {
            time = 15000,
            text = locale("CONNECT_EXPLO_CABLES")
        })
    end

    if not success then
        atmState:set("atmRobData", nil, true)
        RemoveLockdownZone(atmNetId)
        GlobalState["GLOBAL_ATM_COOLDOWN"] = false

        -- // Consume the explosive on failure
        bridge.inv.removeItem(source, SHConfig.ExplosiveItem, 1)

        if Config.Explosive.explodeExplosiveOnBroken then
            TriggerClientEvent("prp-atmrob:client:atmExplosion", source, GetEntityCoords(atmEntity))
        end
        return
    end

    local alertData = Config.Explosive.alertData
    DispatchAlert(source, alertData.chance, GetEntityCoords(atmEntity), alertData.code, alertData.title, alertData.blip)

    SetTimeout(Config.GlobalCooldown * 60000, function()
        GlobalState["GLOBAL_ATM_COOLDOWN"] = false
    end)

    -- // Minigame successfully completed, remove explosive item
    bridge.inv.removeItem(source, SHConfig.ExplosiveItem, 1)

    TriggerClientEvent("prp-atmrob:client:placeExplosive", source, atmNetId)
end

RegisterNetEvent("prp-atmrob:server:explosiveFailed", function(atmNetId)
    local source = source

    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end

    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData

    local atmCoords = GetEntityCoords(atmEntity)
    local dist = #(GetEntityCoords(GetPlayerPed(source)) - atmCoords)
    if dist > 1.7 or (atmRobData and (atmRobData.hasDevice ~= "explosive")) then
        return
    end

    atmState:set("atmRobData", nil, true)

    bridge.inv.giveItem(source, SHConfig.ExplosiveItem, 1)
end)

RegisterNetEvent("prp-atmrob:server:explosivePlaced", function(atmNetId, offset)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    local model = GetEntityModel(atmEntity)
    local modelData = SHConfig.ATMModels[model]
    if not modelData then return end

    if not atmRobData or atmRobData.hasDevice ~= "explosive" then return end

    -- // Create the explosive object
    local explosive = CreateObject(`h4_prop_h4_ld_bomb_02a`, offset.x, offset.y, offset.z, true, true, false)
    while not DoesEntityExist(explosive) do
        Wait(0)
    end

    FreezeEntityPosition(explosive, true)
    local heading = GetEntityHeading(atmEntity)
    local rot = GetEntityRotation(explosive)
    SetEntityRotation(explosive, rot.x + modelData.explosiveRotation.x, rot.y + modelData.explosiveRotation.y, heading, 2, false)

    StartGroupCooldown(src)

    -- // Wait a random amount of time then kaboom
    bridge.fw.notify(src, "inform", locale("STAND_BACK"))
    local randTime = math.random(Config.Explosive.explodeDelayTime.min * 60000, Config.Explosive.explodeDelayTime.max * 60000)
    TriggerClientEvent("prp-atmrob:client:bombBeep", -1, atmNetId, randTime)
    SetTimeout(randTime, function()
        atmEntity, atmNetId = RecreateATM(atmNetId, false, SHConfig.ExplodedModel)
        atmState = Entity(atmEntity).state
        atmState:set("atmRobData", {
            atmNetId = atmNetId,
            hasDevice = "explosive",
            exploded = true,
            canBeSearched = true,
        }, true)

        TriggerClientEvent("prp-atmrob:client:atmExplosion", src, offset)
        DeleteEntity(explosive)

        -- // Start a timer to automatically reset the ATM
        SetTimeout(Config.Explosive.resetTime * 60000, function()
            RemoveLockdownZone(atmNetId)
            if not DoesEntityExist(atmEntity) then return end
            atmState = Entity(atmEntity).state
            DeleteEntity(atmEntity) -- Delete this ATM, let the engine respawn it
            RemoveSpawnedATM(atmNetId)
            atmState:set("atmRobData", nil, true)
        end)
    end)
end)

RegisterNetEvent("prp-atmrob:server:trySearchExplodedATM", function(atmNetId)
    local src = source

    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end

    if #(GetEntityCoords(atmEntity) - GetEntityCoords(GetPlayerPed(src))) > 1.7 then return end

    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    if not atmRobData or not atmRobData.exploded or not atmRobData.canBeSearched or atmRobData.robbed then return end

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

    UpdateAtmRobData(atmEntity, function(data)
        data.robbed = true
        data.canBeSearched = false
    end)

    StartGroupCooldown(src)

    -- // Give rewards and XP
    local loot = GiveSearchLoot(src, Config.Explosive.loot.lootTableRolls, Config.Explosive.loot.lootTable, Config.Explosive.loot.guaranteedRarities)

    SendLog(src, "ATM Robbery", "Exploded ATM Robbed", {
        atmrob_explodeLoot = json.encode(loot or {"unknown loot"})
    })
end)
