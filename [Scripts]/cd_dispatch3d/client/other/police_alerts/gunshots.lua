if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.GunShots.ENABLE then return end

local LastTryGunshotTick = -1
local GunshotBurst = {
    startedAt = 0,
    shots = 0,
    lastShotAt = 0,
}

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][Gunshots] ' .. msg..'\n')
    end
end

local function ResetBurst()
    GunshotBurst.startedAt = 0
    GunshotBurst.shots = 0
    GunshotBurst.lastShotAt = 0
end

local function CountShotInBurst()
    local now = GetGameTimer()
    local burstCfg = Config.PoliceAlerts.GunShots.BurstShots

    if GunshotBurst.lastShotAt == 0 or (now - GunshotBurst.lastShotAt) > (burstCfg.burst_gap_ms) then
        GunshotBurst.startedAt = now
        GunshotBurst.shots = 0
    end

    GunshotBurst.shots = GunshotBurst.shots + 1
    GunshotBurst.lastShotAt = now
    return GunshotBurst.shots
end

local function GetHeardGunshotMessage(firearmType, street)
    if firearmType == 'shotgun' or firearmType == 'sniper' then
        return Locale('policealerts_gunshots_message_heard_loud', street)
    end

    local now = GetGameTimer()
    local fireMode = 'single'
    if GunshotBurst.lastShotAt == 0 then fireMode = 'semi_auto' end

    local delta = now - GunshotBurst.lastShotAt
    local threshold = 180

    if delta > 0 and delta <= threshold then
        fireMode = 'full_auto'
    end

    if fireMode == 'full_auto' then
        return Locale('policealerts_gunshots_message_heard_fullauto', street)
    elseif fireMode == 'single' then
        return Locale('policealerts_gunshots_message_heard_single', street)
    end
end

local function GetGunshotBlipData(in_vehicle, firearmType)
    local sprite = in_vehicle and 229 or 313
    local radius = 100
    local sound = 1
    local flash = 0
    local colour = 3

    if firearmType == 'rifle' then
        radius = 160
    elseif firearmType == 'shotgun' then
        radius = 140
    elseif firearmType == 'smg' then
        radius = 130
    elseif firearmType == 'pistol' then
        radius = 110
    end

    if in_vehicle then
        radius = radius + 40
    end
    return sprite, radius, sound, flash, colour
end

local function TryGunshotAlert()
    local ped = PlayerPedId()
    local callKind = 'seen'
    local has_weapon, weapon_hash = GetCurrentPedWeapon(ped)
    local cfg = Config.PoliceAlerts.GunShots

    StartCooldown('weapondrawn', cfg.cooldown)

    if not has_weapon then
        Dbg('No weapon found, returning.')
        return
    end

    local shots = CountShotInBurst()
    local minShots = cfg.BurstShots.min_shots_in_burst
    local settleMs = cfg.BurstShots.burst_settle_ms

    if Config.Debug then
        Dbg(('Burst: shots=%s minShots=%s'):format(tostring(shots), tostring(minShots)))
    end

    if shots < minShots then
        return
    end

    if IsCooldownActive('gunshot') or IsCooldownActive('gunshot_pending') then
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
    if IsPlayerInGunshotWhitelistZone() then
        Dbg('Player in gunshot whitelist zone, returning.')
        return
    end
    if IsWeaponWhitelisted(cfg.WhitelistedWeapons, weapon_hash) then
        Dbg('Weapon is whitelisted, returning.')
        return
    end
    if IsPedCurrentWeaponSilenced(ped) then
        Dbg('Weapon is silenced, returning.')
        return
    end
    if not RandomPoliceCallChance(cfg.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('gunshot_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if policeCalled then
        callKind = 'seen'
    else
        if HasWitnessHeardGunshots() then
            callKind = 'heard'
        else
            if canceledReason == 'no_peds_nearby' then
                Dbg('No witness ped nearby, returning.')
            elseif canceledReason == 'all_witnesses_harmed' then
                Dbg('All witness peds harmed, returning.')
            end
            ClearCooldown('gunshot_pending')
            return
        end
    end

    if settleMs > 0 then
        Wait(settleMs)
    end

    local in_vehicle = IsPedInAnyVehicle(ped, true)

    local firearmType = FirearmWeaponTypes[weapon_hash] or 'firearm'
    local firearmLabel = Locale(firearmType)

    local playerData = GetPlayerInfo()
    local message = ''

    if callKind == 'seen' then
        if in_vehicle then
            message = Locale('policealerts_gunshots_message_vehicle', playerData.vehicle_colour, playerData.vehicle_label, playerData.street)
        else
            message = Locale('policealerts_gunshots_message_onfoot', playerData.sex, firearmLabel, playerData.street)
        end
    elseif callKind == 'heard' then
        message = GetHeardGunshotMessage(firearmType, playerData.street)
    end

    local sprite, radius, sound, flash, colour = GetGunshotBlipData(in_vehicle, firearmType)

    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = playerData.coords,
        title     = Locale('policealerts_gunshots_title'),
        message   = message,
        flash     = flash,
        sound     = sound,
        blip      = {
            sprite  = sprite,
            scale   = 1.2,
            colour  = colour,
            flashes = false,
            text    = Locale('policealerts_gunshots_title'),
            time    = 5,
            radius  = radius,
        }
    })

    if Config.PoliceAlerts.add_bolos and in_vehicle then
        TriggerServerEvent('cd_dispatch:pdalerts:Gunshots', playerData)
    end

    ClearCooldown('gunshot_pending')
    StartCooldown('gunshot', cfg.cooldown)
    ResetBurst()
end

AddEventHandler('CEventGunShot', function()
    if IsPedShooting(PlayerPedId()) then
        local tick = GetGameTimer()
        if LastTryGunshotTick == tick then
            return
        end
        LastTryGunshotTick = tick

        TryGunshotAlert()
    else
        Dbg('Player not currently shooting, returning.')
    end
end)