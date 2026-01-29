if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.VehicleAssault.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][VehicleAssault] ' .. msg .. '\n')
    end
end

local function IsVehicleDriver(ped, vehicle)
    if vehicle == 0 then return false end
    if not IsPedInAnyVehicle(ped, false) then return false end
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then return false end
    if IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then return false end
    return true
end

local function TryVehicleAssaultAlert(victim, vehicle)
    local cfg = Config.PoliceAlerts.VehicleAssault

    if IsCooldownActive('vehicleassault') or IsCooldownActive('vehicleassault_pending') then
        Dbg('Cooldown is still active, returning.')
        return
    end
    if IsPlayerInNoSnitchingZone() then
        Dbg('Player is in a no-snitching zone, returning.')
        return
    end
    if IsPlayerJobWhitelisted() then
        Dbg('Player job whitelisted, returning.')
        return
    end
    if not RandomPoliceCallChance(cfg.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    if vehicle and vehicle ~= 0 then
        local mph = Round(GetEntitySpeed(vehicle) * 2.236936)
        if mph < cfg.min_speed_mph then
            Dbg(('Speed %s mph below min (%s), returning.'):format(mph, cfg.min_speed_mph))
            return
        end
    end

    StartCooldown('vehicleassault_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice(victim)
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('vehicleassault_pending')
        return
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = playerData.coords,
        title     = Locale('policealerts_vehicleassault_title'),
        message   = Locale('policealerts_vehicleassault_message_player', playerData.vehicle_colour, playerData.vehicle_label, playerData.street),
        flash     = 0,
        sound     = 1,
        blip      = {
            sprite  = 227,
            scale   = 1.1,
            colour  = 1,
            flashes = false,
            text    = Locale('policealerts_vehicleassault_title'),
            time    = 5,
            radius  = 80,
        }
    })

    ClearCooldown('vehicleassault_pending')
    StartCooldown('vehicleassault', cfg.cooldown or 30)
end

AddEventHandler('entityDamaged', function(victim, culprit, weapon, baseDamage)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(playerPed)
    if vehicle == 0 then return end

    if not victim or victim == 0 then return end
    if not culprit or culprit == 0 then return end
    if culprit ~= PlayerPedId() then return end
    if not IsEntityAPed(victim) then return end
    if not IsVehicleDriver(playerPed, vehicle) then return end
    if not IsEntityAVehicle(vehicle) then return end
    if not IsPedHuman(victim) then return end
    if victim == playerPed then return end
    if IsPedInAnyVehicle(victim, false) then return end

    TryVehicleAssaultAlert(victim, vehicle)
end)