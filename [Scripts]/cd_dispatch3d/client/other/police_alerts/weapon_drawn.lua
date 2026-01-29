if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.WeaponDrawn.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][WeaponDrawn] ' .. msg .. '\n')
    end
end

local function IsWeaponOut(ped)
    local hasWeapon, weaponHash = GetCurrentPedWeapon(ped, true)
    if not hasWeapon then return false end
    if weaponHash == `WEAPON_UNARMED` then return false end
    return true, weaponHash
end

local function TryWeaponDrawnAlert()
    local ped = PlayerPedId()
    local isWeaponOut, weaponHash = IsWeaponOut(ped)

    if not isWeaponOut then return end
    if IsPedInAnyVehicle(ped, true) then return end
    if IsCooldownActive('weapondrawn') or IsCooldownActive('weapondrawn_pending') then return end
    if IsWeaponWhitelisted(Config.PoliceAlerts.WeaponDrawn.WhitelistedWeapons, weaponHash) then return false end
    if IsPlayerInNoSnitchingZone() then return end
    if IsPlayerJobWhitelisted() then return end
    if not RandomPoliceCallChance(Config.PoliceAlerts.VehicleAlarm.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('weapondrawn_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('weapondrawn_pending')
        return
    end

    local weaponLabel = Locale('weapon')
    local firearmType = FirearmWeaponTypes[weaponHash]
    local meleeType = MeleeWeaponTypes[weaponHash]

    if firearmType then
        weaponLabel = Locale(firearmType)
    elseif meleeType then
        weaponLabel = Locale(meleeType)..' '..Locale('weapon')
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = playerData.coords,
        title     = Locale('policealerts_weapon_drawn_title'),
        message   = Locale('policealerts_weapon_drawn_message', playerData.sex, weaponLabel, playerData.street),
        flash     = 0,
        sound     = 1,
        blip      = {
            sprite  = 156,
            scale   = 1.1,
            colour  = 1,
            flashes = false,
            text    = Locale('policealerts_weapon_drawn_title'),
            time    = 5,
            radius  = 60,
        }
    })

    ClearCooldown('weapondrawn_pending')
    StartCooldown('weapondrawn', Config.PoliceAlerts.WeaponDrawn.cooldown)
end

CreateThread(function()
    while true do
        Wait(5000)

        if not IsEntityDead(PlayerPedId()) then
            TryWeaponDrawnAlert()
        end
    end
end)