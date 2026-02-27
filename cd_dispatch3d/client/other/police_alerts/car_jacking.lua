if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.CarJacking.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][CarJacking] ' .. msg..'\n')
    end
end

local function TryCarjackAlert()
    if IsCooldownActive('carjack') or IsCooldownActive('carjack_pending') then
        Dbg('Cooldown is still active, returning.')
        return
    end
    if not IsPedJacking(PlayerPedId()) then
        Dbg('Player is not jacking a vehicle, returning.')
        return
    end
    if IsPlayerJobWhitelisted() then
        Dbg('Player job whitelisted, returning.')
        return
    end
    if IsPlayerInNoSnitchingZone() then
        Dbg('Player is in a no-snitching zone, returning.')
        return
    end
    if not RandomPoliceCallChance(Config.PoliceAlerts.CarJacking.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('carjack_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('carjack_pending')
        return
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = playerData.coords,
        title     = Locale('policealerts_carjack_title'),
        message   = Locale('policealerts_carjack_message', playerData.vehicle_colour, playerData.vehicle_label, playerData.street),
        flash     = 0,
        sound     = 1,
        blip      = {
            prite  = 225,
            scale   = 1.2,
            colour  = 1,
            flashes = false,
            text    = Locale('policealerts_carjack_title'),
            time    = 6,
            radius  = 100
        }
    })
    ClearCooldown('carjack_pending')
    StartCooldown('carjack', Config.PoliceAlerts.CarJacking.cooldown)
end

AddEventHandler('CEventDraggedOutCar', function(_, playerPed)
    if playerPed ~= PlayerPedId() then return end
    TryCarjackAlert()
end)