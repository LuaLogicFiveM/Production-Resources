local unlockTimer = {}

RegisterNetEvent("prp-atmrob:server:tryPlugDeviceCheckGroup", function(atmNetId)
    local source = source

    if Config.Hack.minGroupSize > 1 then
        -- // Check if we're even in a group
        local inGroup, groupData = IsInGroup(source, Config.Hack.minGroupSize)
        if not inGroup then
            bridge.fw.notify(source, "error", locale("GROUP_NOT_BIG"))
            return
        end
    end

    if (getOnDutyCount() or 0) < Config.Hack.requiredCops then
        bridge.fw.notify(source, "error", locale("NOT_ENOUGH_POLICE"))
        return
    end

    if IsCooldownActive(source) then
        bridge.fw.notify(source, "error", locale("PLAYER_COOLDOWN"))
        return
    end

    PlaceHackDevice(source, atmNetId)
end)

function PlaceHackDevice(source, atmNetId)
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end

    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData or {}

    -- // Some anticheat checks
    local atmCoords = GetEntityCoords(atmEntity)
    local dist = #(GetEntityCoords(GetPlayerPed(source)) - atmCoords)
    if dist > 1.7 or (atmRobData and (atmRobData.hasDevice ~= nil or atmRobData.beingHacked or atmRobData.robbed or atmRobData.exploded)) then
        bridge.fw.notify(source, "error", locale("CANT_DO_THAT"))
        return
    end

    if GlobalState["GLOBAL_ATM_COOLDOWN"] then
        bridge.fw.notify(source, "error", locale("PLAYER_COOLDOWN"))
        return
    end

    if IsNearLockdownZone(atmCoords) then
        bridge.fw.notify(source, "error", locale("AREA_TOO_HOT"))
        return
    end

    -- // Check if the player even has a non-broken hack device
    local invHackDevices = bridge.inv.searchInventory(source, SHConfig.HackDeviceItem)

    -- // Filter for items with durability > 0
    local hackDeviceItem = nil
    for _, item in pairs(invHackDevices or {}) do
        if item.metadata and item.metadata.durability and item.metadata.durability > 0 then
            hackDeviceItem = item
            break
        end
    end
    if not hackDeviceItem then
        bridge.fw.notify(source, "error", locale("NO_HACK_DEVICE_INV"))
        return
    end

    atmEntity, atmNetId = RecreateATM(atmNetId, false)

    CreateLockdownZone(atmNetId, GetEntityCoords(atmEntity))
    GlobalState["GLOBAL_ATM_COOLDOWN"] = true
    SetTimeout(Config.GlobalCooldown * 60000, function()
        GlobalState["GLOBAL_ATM_COOLDOWN"] = false
    end)


    -- // Update the stored atmState to the new entity
    atmState = Entity(atmEntity).state
    atmRobData.atmNetId = atmNetId
    atmRobData.hasDevice = "hack"
    atmRobData.initiator = source
    atmRobData.hackDeviceDurability = hackDeviceItem.metadata.durability
    atmState:set("atmRobData", atmRobData, true)

    lib.print.debug("Removing device from inventory, durability:", hackDeviceItem.metadata.durability)
    bridge.inv.removeItem(source, SHConfig.HackDeviceItem, 1, nil, hackDeviceItem.slot)

    TriggerClientEvent("prp-atmrob:client:plugDevice", source, atmNetId)

    -- // Start a timer to automatically reset the ATM
    SetTimeout(Config.Hack.resetTime * 60000, function()
        RemoveLockdownZone(atmNetId)
        if not DoesEntityExist(atmEntity) then return end

        local updatedState = Entity(atmEntity).state
        if updatedState.atmRobData and updatedState.atmRobData.hackDeviceNetId then
            local hackDevice = AwaitEntityFromNetId(updatedState.atmRobData.hackDeviceNetId)
            if hackDevice then
                DeleteEntity(hackDevice)
            end
        end
        DeleteEntity(atmEntity) -- Delete this ATM, let the engine respawn it
        RemoveSpawnedATM(atmNetId)
        updatedState:set("atmRobData", nil, true)
    end)
end

RegisterNetEvent("prp-atmrob:server:plugDeviceFailed", function(atmNetId)
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    Entity(atmEntity).state:set("atmRobData", nil, true)
    RemoveLockdownZone(atmNetId)
end)

RegisterNetEvent("prp-atmrob:server:pluggedDevice", function(atmNetId, deviceOffset)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData

    if not atmRobData or atmRobData.hasDevice ~= "hack" then return end

    -- // Create the hack device on the ATM
    local hackDevice = CreateObject(`hei_prop_heist_card_hack`, deviceOffset.x, deviceOffset.y, deviceOffset.z, true,
        true, false)
    while not DoesEntityExist(hackDevice) do
        Wait(0)
    end

    FreezeEntityPosition(hackDevice, true)
    SetEntityHeading(hackDevice, GetEntityHeading(atmEntity) - 90.0)

    atmRobData.hackDeviceNetId = NetworkGetNetworkIdFromEntity(hackDevice)
    atmState:set("atmRobData", atmRobData, true)

    local alertData = Config.Hack.alertData
    DispatchAlert(src, alertData.chance, GetEntityCoords(atmEntity), alertData.code, alertData.title, alertData.blip)
end)

local function sendFriedDevice(coords, atmNetId)
    local nearPlayers = lib.getNearbyPlayers(coords, 100.0, true)
    for k, v in pairs(nearPlayers) do
        TriggerClientEvent("prp-atmrob:client:deviceFried", v.id, atmNetId)
    end
end

RegisterNetEvent("prp-atmrob:server:hackATM", function(atmNetId)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end

    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    local atmCoords = GetEntityCoords(atmEntity)

    -- // Some anticheat checks
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - atmCoords)
    if dist > 1.7 or (atmRobData and (atmRobData.hasDevice ~= "hack" or atmRobData.beingHacked or atmRobData.robbed or atmRobData.exploded or atmRobData.locked)) then
        bridge.fw.notify(src, "error", locale("CANT_DO_THAT"))
        return
    end

    if atmRobData.onCooldown ~= nil then
        local timeTill = os.difftime(atmRobData.onCooldown, os.time())
        bridge.fw.notify(src, "error", locale("ATM_HACK_COOLDOWN", math.floor(timeTill)))
        return
    end

    atmRobData.beingHacked = true
    atmState:set("atmRobData", atmRobData, true)

    -- // Start minigame (this is temp till new minigame is made)
    local success = SHConfig.Debug and true or false
    if not SHConfig.Debug then
        success = lib.callback.await("prp-bridge:minigame", src, "memorySymbols", {
            memoryTime = 10000,
            answerTime = 10000,
            answerSize = 4,
            type = { "numbers" }, -- // symbols, numbers, letters
        }, {
            animation = {
                dict = 'missheist_agency2ahelmet',
                name = 'take_off_helmet_stand',
                flag = 1,
            },
        })
    end

    -- // Re-read hackDeviceNetId from fresh state after minigame yield
    local freshData = Entity(atmEntity).state.atmRobData
    local hackDeviceNetId = freshData and freshData.hackDeviceNetId
    local hackDeviceEntity = hackDeviceNetId and AwaitEntityFromNetId(hackDeviceNetId) or nil

    if not success then
        lib.print.debug("Hack failed")
        TriggerClientEvent("prp-atmrob:client:hackFailed", src)

        local updatedData = UpdateAtmRobData(atmEntity, function(data)
            data.beingHacked = false
            data.failHackCount = (data.failHackCount or 0) + 1
            data.locked = data.failHackCount >= Config.Hack.failsAllowed
            data.hackDeviceDurability = (data.hackDeviceDurability or 0) - Config.Hack.durabilityLossOnFail
            if Config.Hack.failCooldown > 0 then data.onCooldown = os.time() + Config.Hack.failCooldown end
        end)
        if not updatedData then return end

        SetTimeout(Config.Hack.failCooldown * 1000, function()
            UpdateAtmRobData(atmEntity, function(data)
                data.onCooldown = nil
            end)
        end)

        local newFailCount = updatedData.failHackCount

        -- // If we've failed too many times, ATM is locked (no more hacking)
        if newFailCount >= Config.Hack.failsAllowed then
            bridge.fw.notify(src, "error", locale("ATM_LOCKED"))
            sendFriedDevice(atmCoords, atmNetId)
            StartGroupCooldown(src)

            UpdateAtmRobData(atmEntity, function(data)
                data.hasDevice = nil
                data.hackDeviceNetId = nil
                data.hackDeviceDurability = 0
            end)
            if hackDeviceEntity then
                DeleteEntity(hackDeviceEntity)
            end
            bridge.fw.notify(src, "error", locale("HACK_DEVICE_BROKE", locale("ITEM_HACKING_DEVICE_LABEL")))

            return
        end

        bridge.fw.notify(src, "error", locale("ATM_FAIL_COUNT", Config.Hack.failsAllowed - newFailCount))

        -- // If the durability of the hack device is 0, break it.
        if updatedData.hackDeviceDurability <= 0 then
            if hackDeviceEntity then
                DeleteEntity(hackDeviceEntity)
            end

            UpdateAtmRobData(atmEntity, function(data)
                data.hasDevice = nil
                data.hackDeviceNetId = nil
                data.hackDeviceDurability = nil
            end)
            bridge.fw.notify(src, "error", locale("HACK_DEVICE_BROKE", locale("ITEM_HACKING_DEVICE_LABEL")))
            sendFriedDevice(atmCoords, atmNetId)
        end

        return
    end

    lib.print.debug("Hack succeeded")

    if Config.Hack.breakItemOnSuccess then
        if hackDeviceEntity then
            DeleteEntity(hackDeviceEntity)
        end

        UpdateAtmRobData(atmEntity, function(data)
            data.hackDeviceNetId = nil
            data.hackDeviceDurability = nil
        end)
        bridge.fw.notify(src, "error", locale("HACK_DEVICE_BROKE", locale("ITEM_HACKING_DEVICE_LABEL")))
        sendFriedDevice(atmCoords, atmNetId)
    end

    bridge.fw.notify(src, "success", locale("ATM_CRACKED"))
    UpdateAtmRobData(atmEntity, function(data)
        data.beenHacked = true
        data.beingHacked = false
    end)

    local rndSearchTime = RandomFloatInRange(Config.Hack.searchDelay.min, Config.Hack.searchDelay.max)
    unlockTimer[atmNetId] = lib.timer(rndSearchTime * 60000, function()
        unlockTimer[atmNetId] = nil

        UpdateAtmRobData(atmEntity, function(data)
            data.canBeSearched = true
            data.failHackCount = 0
        end)

        TriggerClientEvent("prp-atmrob:client:unlockSound", src, atmNetId)
    end, true)
end)

RegisterNetEvent("prp-atmrob:server:unplugHackDevice", function(atmNetId)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData
    if not atmRobData then return end

    -- // Some anticheat checks
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(atmEntity))
    if dist > 1.7 or atmRobData.hasDevice ~= "hack" or atmRobData.beingHacked or not atmRobData.hackDeviceNetId then
        bridge.fw.notify(src, "error", locale("CANT_DO_THAT"))
        return
    end

    local finished = lib.callback.await("prp-bridge:progress", src, {
        name = "atmrob-unplug-prog",
        duration = 1000,
        label = locale("UNPLUGGING_DEVICE"),
        useWhileDead = false,
        canCancel = true,
        ignoreModifier = false,
        disarm = true,
        animation = {
            animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@female@",
            animClip = "exit",
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

    -- // Re-read fresh state after progress bar yield
    local freshData = Entity(atmEntity).state.atmRobData
    if not freshData then return end

    local hackDevice = freshData.hackDeviceNetId and AwaitEntityFromNetId(freshData.hackDeviceNetId) or nil
    if hackDevice then
        DeleteEntity(hackDevice)
    end

    -- // Give the player their hack device back, with the updated durability OR break it if new durability is 0
    if (freshData.hackDeviceDurability or 0) > 0 then
        bridge.inv.giveItem(src, SHConfig.HackDeviceItem, 1, { durability = freshData.hackDeviceDurability })
    else
        bridge.fw.notify(src, "error", locale("HACK_DEVICE_BROKE", locale("ITEM_HACKING_DEVICE_LABEL")))
    end

    if not freshData.canBeSearched and not freshData.locked then
        RemoveLockdownZone(atmNetId)
    end

    UpdateAtmRobData(atmEntity, function(data)
        data.hasDevice = nil
        data.hackDeviceNetId = nil
        data.hackDeviceDurability = nil
    end)
end)

RegisterNetEvent("prp-atmrob:server:searchATM", function(atmNetId)
    local src = source
    local atmEntity = AwaitEntityFromNetId(atmNetId)
    if not atmEntity then return end
    local atmState = Entity(atmEntity).state
    local atmRobData = atmState.atmRobData

    if not atmRobData or atmRobData.robbed then return end

    if not atmRobData.canBeSearched then
        local time = unlockTimer[atmNetId] and unlockTimer[atmNetId]:getTimeLeft("s") or 0
        bridge.fw.notify(src, "error", locale("CANT_SEARCH_YET", math.ceil(time)))
        return
    end

    atmRobData.robbed = true
    atmState:set("atmRobData", atmRobData, true)

    local success = lib.callback.await("prp-bridge:progress", src, {
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

    if not success then
        UpdateAtmRobData(atmEntity, function(data)
            data.robbed = false
        end)
        return
    end

    local updatedData = UpdateAtmRobData(atmEntity, function(data)
        data.canBeSearched = false
    end)

    StartGroupCooldown(src)
    if updatedData and updatedData.initiator and updatedData.initiator ~= src then
        StartGroupCooldown(updatedData.initiator)
    end

    local loot = GiveSearchLoot(src, Config.Hack.loot.lootTableRolls, Config.Hack.loot.lootTable,
        Config.Hack.loot.guaranteedRarities)

    SendLog(src, "ATM Robbery", "Hacked ATM Robbed", {
        atmrob_hackLoot = json.encode(loot or { "unknown loot" })
    })
end)
