
if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.GunPointCarJacking.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][GunPointCarJacking] ' .. msg .. '\n')
    end
end

local function IsGunpointingAtDriver(playerPed)
    if IsPedDeadOrDying(playerPed, true) then return false end
    if IsPedInAnyVehicle(playerPed, false) then return false end
    if not IsPlayerFreeAiming(PlayerId()) then return false end

    local weapon = GetSelectedPedWeapon(playerPed)
    if weapon == GetHashKey('WEAPON_UNARMED') then return false end

    local aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
    if not aiming or not entity or entity == 0 then return false end

    if IsEntityAPed(entity) then
        if IsPedAPlayer(entity) then return false end
        if not IsPedInAnyVehicle(entity, false) then return false end

        local veh = GetVehiclePedIsIn(entity, false)
        if veh == 0 then return false end

        local driver = GetPedInVehicleSeat(veh, -1)
        if driver == 0 or driver ~= entity then
            return false
        end

        return true, driver, veh
    end

    if IsEntityAVehicle(entity) then
        local driver = GetPedInVehicleSeat(entity, -1)
        if driver == 0 then return false end
        if IsPedAPlayer(driver) then return false end
        return true, driver, entity
    end

    return false
end

local function MakeDriverStopExitAndFlee(driverPed, vehicle, fromPed)
    if not DoesEntityExist(driverPed) or IsEntityDead(driverPed) then return end
    if not DoesEntityExist(vehicle) then return end

    SetBlockingOfNonTemporaryEvents(driverPed, true)
    SetPedCombatAttributes(driverPed, 46, true)
    SetPedFleeAttributes(driverPed, 0, false)

    TaskVehicleTempAction(driverPed, vehicle, 27, 2000)
    local start = GetGameTimer()
    while GetGameTimer() - start < 1500 do
        if not DoesEntityExist(vehicle) then return end
        if GetEntitySpeed(vehicle) < 1.0 then break end
        Wait(0)
    end

    if GetEntitySpeed(vehicle) > 1.5 then
        BringVehicleToHalt(vehicle, 1.0, 2000, false)
        Wait(150)
    end

    TaskLeaveVehicle(driverPed, vehicle, 256)
    local exitStart = GetGameTimer()
    while GetGameTimer() - exitStart < 3000 do
        if not DoesEntityExist(driverPed) or IsEntityDead(driverPed) then return end
        if not IsPedInAnyVehicle(driverPed, false) then break end
        Wait(0)
    end

    TaskSmartFleePed(driverPed, fromPed, 250.0, -1, false, false)

    CreateThread(function()
        Wait(4000)
        if DoesEntityExist(driverPed) then
            SetBlockingOfNonTemporaryEvents(driverPed, false)
        end
    end)
end

local function TryGunpointFleeAndAlert(driverPed, vehicle)
    local cfg = Config.PoliceAlerts.GunPointCarJacking

    StartCooldown('weapondrawn', cfg.cooldown)

    if IsCooldownActive('gunpoint_carjacking') or IsCooldownActive('gunpoint_carjacking_pending') then
        Dbg('Cooldown is still active, returning.')
        return
    end
    if IsPlayerJobWhitelisted() then
        Dbg('Player job whitelisted, returning.')
        return
    end
    if IsPlayerInNoSnitchingZone and IsPlayerInNoSnitchingZone() then
        Dbg('Player is in a no-snitching zone, returning.')
        return
    end
    if not RandomPoliceCallChance(cfg.random_chance or 100) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('gunpoint_carjacking_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('gunpoint_carjacking_pending')
        return
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = playerData.coords,
        title     = Locale('policealerts_gunpointcarjack_title'),
        message   = Locale('policealerts_gunpointcarjack_message', playerData.sex, playerData.street),
        flash     = 0,
        sound     = 1,
        blip      = {
            sprite  = 225,
            scale   = 1.1,
            colour  = 1,
            flashes = false,
            text    = Locale('policealerts_gunpointcarjack_title'),
            time    = 6,
            radius  = 100
        }
    })

    ClearCooldown('gunpoint_carjacking_pending')
    StartCooldown('gunpoint_carjacking', cfg.cooldown)
end

CreateThread(function()
    local cfg = Config.PoliceAlerts.GunPointCarJacking

    while true do
        ::continue::

        local ped = PlayerPedId()
        local maxDist = cfg.max_distance

        local tick = 350

        local ok, driverPed, vehicle = IsGunpointingAtDriver(ped)
        if not ok then
            Wait(tick)
            goto continue
        end

        tick = 50

        local dist = #(GetEntityCoords(ped) - GetEntityCoords(vehicle))
        if dist > maxDist then
            Wait(tick)
            goto continue
        end

        CreateThread(function ()
            TryGunpointFleeAndAlert(driverPed, vehicle)
        end)

        MakeDriverStopExitAndFlee(driverPed, vehicle, ped)

        Wait(2500)
    end
end)
