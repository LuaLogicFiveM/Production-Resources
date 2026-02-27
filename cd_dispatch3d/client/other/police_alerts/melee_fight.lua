if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.MeleeFight.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][Melee] ' .. msg..'\n')
    end
end

local function TryMeleeAlert(victim, culprit, weapon)
    if IsCooldownActive('melee') or IsCooldownActive('melee_pending') then
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
    if not RandomPoliceCallChance(Config.PoliceAlerts.MeleeFight.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('melee_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('melee_pending')
        return
    end

    local meleeWeapon = MeleeWeaponTypes[weapon] or 'fists'

    local playerData = GetPlayerInfo()
    local message = ''
    if meleeWeapon == 'fists' then
        message = Locale('policealerts_melee_message_fists', playerData.street)
    elseif meleeWeapon == 'blunt' or meleeWeapon == 'bladed' then
        message = Locale('policealerts_melee_message_weapon', playerData.street, Locale(meleeWeapon))
    end

    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = playerData.coords,
        title     = Locale('policealerts_melee_title'),
        message   = message,
        flash     = 0,
        sound     = 1,
        blip      = {
            sprite  = 270,
            scale   = 1.1,
            colour  = 1,
            flashes = false,
            text    = Locale('policealerts_melee_title'),
            time    = 5,
            radius  = 60,
        }
    })
    ClearCooldown('melee_pending')
    StartCooldown('melee', Config.PoliceAlerts.MeleeFight.cooldown)
end

AddEventHandler('entityDamaged', function(victim, culprit, weapon, baseDamage)
    if not victim or victim == 0 then return end
    if not culprit or culprit == 0 then return end
    if culprit ~= PlayerPedId() then return end
    if not IsEntityAPed(victim) then return end
    if IsEntityAVehicle(victim) then return end
    if not MeleeWeaponTypes[weapon] then return end
    TryMeleeAlert(victim, culprit, weapon)
end)