if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.VehicleAlarm.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][VehicleAlarm] ' .. msg .. '\n')
    end
end

local LastAlarmBurstAt = 0
local AlarmBurstDebounceMs = 1200
local VehicleAlarmLastAt = {}

local RecentVehicleDamage = {}
local RecentVehicleWindowBreak = {}

local function AlarmBurstReady()
    local now = GetGameTimer()
    if (now - LastAlarmBurstAt) < AlarmBurstDebounceMs then
        return false
    end
    LastAlarmBurstAt = now
    return true
end

local function VehicleDebounceReady(vehicle, ms)
    local now = GetGameTimer()
    local id = NetworkGetNetworkIdFromEntity(vehicle)
    if id == 0 then id = vehicle end

    local last = VehicleAlarmLastAt[id]
    if last and (now - last) < ms then
        return false
    end

    VehicleAlarmLastAt[id] = now
    return true
end

local function IsVehicleAlarmActuallyOn(vehicle)
    if vehicle == 0 or not DoesEntityExist(vehicle) then return false end
    return IsVehicleAlarmActivated(vehicle) == 1 or IsVehicleAlarmActivated(vehicle) == true
end

local function GetVehKey(vehicle)
    local id = NetworkGetNetworkIdFromEntity(vehicle)
    if id == 0 then id = vehicle end
    return id
end

local function MarkVehicleDamagedByPlayer(vehicle)
    RecentVehicleDamage[GetVehKey(vehicle)] = GetGameTimer()
end

local function WasVehicleDamagedByPlayerRecently(vehicle, windowMs)
    local t = RecentVehicleDamage[GetVehKey(vehicle)]
    if not t then return false end
    return (GetGameTimer() - t) <= (windowMs or 8000)
end

local function MarkVehicleWindowBroken(vehicle)
    RecentVehicleWindowBreak[GetVehKey(vehicle)] = GetGameTimer()
end

local function WasVehicleWindowBrokenRecently(vehicle, windowMs)
    local t = RecentVehicleWindowBreak[GetVehKey(vehicle)]
    if not t then return false end
    return (GetGameTimer() - t) <= (windowMs or 8000)
end

local function AnyWindowBroken(vehicle)
    if vehicle == 0 or not DoesEntityExist(vehicle) then return false end
    for cd = 0, 7 do
        if not IsVehicleWindowIntact(vehicle, cd) then
            return true
        end
    end
    return false
end

local function IsBreakInWeapon(weapon)
    return MeleeWeaponTypes[weapon] ~= nil
end

function TryVehicleAlarmAlert(vehicle)
    local cfg = Config.PoliceAlerts.VehicleAlarm
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)
    local vehicleCoords = GetEntityCoords(vehicle)

    if IsCooldownActive('vehiclealarm') or IsCooldownActive('vehiclealarm_pending') then
        Dbg('Cooldown is still active, returning.')
        return
    end
    if vehicle == 0 or not DoesEntityExist(vehicle) then
        Dbg('No vehicle entity, returning.')
        return
    end
    if not IsEntityAVehicle(vehicle) then
        Dbg('Entity is not a vehicle, returning.')
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
    if not AlarmBurstReady() then
        Dbg('Alarm burst debounced, returning.')
        return
    end
    if not VehicleDebounceReady(vehicle, 15000) then
        Dbg('Vehicle alarm debounced, returning.')
        return
    end
    if #(playerCoords - vehicleCoords) > 10.0 then
        Dbg('Player too far from vehicle, returning.')
        return
    end
    if not IsVehicleAlarmActuallyOn(vehicle) then
        Dbg('Alarm not active (or could not confirm), returning.')
        return
    end
    local damageWindow = 8000
    if not HasEntityBeenDamagedByEntity(vehicle, ped, true) and not WasVehicleDamagedByPlayerRecently(vehicle, damageWindow) and not WasVehicleWindowBrokenRecently(vehicle, damageWindow) and not AnyWindowBroken(vehicle) then
        Dbg('Vehicle not tampered with by player recently, returning.')
        return
    end
    if not RandomPoliceCallChance(Config.PoliceAlerts.VehicleAlarm.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('vehiclealarm_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('vehiclealarm_pending')
        return
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords = vehicleCoords,
        title = Locale('policealerts_vehiclealarm_title'),
        message = Locale('policealerts_vehiclealarm_message', playerData.vehicle_colour, playerData.vehicle_label, playerData.street),
        flash = 0,
        sound = 1,
        blip = {
            sprite = 225,
            scale = 1.1,
            colour = 5,
            flashes = false,
            text = Locale('policealerts_vehiclealarm_title'),
            time = 5,
            radius = 60,
        }
    })

    ClearCooldown('vehiclealarm_pending')
    StartCooldown('vehiclealarm', Config.PoliceAlerts.VehicleAlarm.cooldown)
end

AddEventHandler('CEventShockingCarAlarm', function(entities, vehicle)
    if vehicle and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        TryVehicleAlarmAlert(vehicle)
        return
    end

    if type(entities) == 'table' then
        for cd = 1, #entities do
            local ent = entities[cd]
            if ent and DoesEntityExist(ent) and IsEntityAVehicle(ent) then
                TryVehicleAlarmAlert(ent)
                return
            end
        end
    end
end)

AddEventHandler('entityDamaged', function(victim, culprit, weapon, baseDamage)
    if not victim or victim == 0 then return end
    if not DoesEntityExist(victim) or not IsEntityAVehicle(victim) then return end

    local ped = PlayerPedId()
    if not culprit or culprit == 0 or culprit ~= ped then return end

    if not IsBreakInWeapon(weapon) then
        return
    end

    MarkVehicleDamagedByPlayer(victim)

    if AnyWindowBroken(victim) then
        MarkVehicleWindowBroken(victim)
    end

    if IsVehicleAlarmActuallyOn(victim) then
        TryVehicleAlarmAlert(victim)
    end
end)

if Config.Debug then
    RegisterCommand('enablevehalarm', function()
        local ped = PlayerPedId()
        local vehicle = GetClosestVehicleToPlayer(10)

        if vehicle == 0 or not DoesEntityExist(vehicle) then
            print('No vehicle found nearby to test alarm on.')
            return
        end

        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, 5000)
    end, false)
end