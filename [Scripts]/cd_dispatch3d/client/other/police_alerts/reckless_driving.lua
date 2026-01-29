if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.RecklessDriving.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][RecklessDriving] ' .. msg .. '\n')
    end
end

local ShockingDrivingEvents = {
    ['CEventShockingCarChase'] = true,
    ['CEventShockingMadDriverExtreme'] = true,
    ['CEventShockingInDangerousVehicle'] = true,
    ['CEventShockingDrivingOnPavement'] = true
}

local function IsValidDriver(ped)
    if not IsPedInAnyVehicle(ped, false) then return false end

    local vehicle = GetVehiclePedIsUsing(ped)
    if vehicle == 0 then return false end
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then return false end
    if IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then return false end

    return true, vehicle
end

local function GetSpeedMph(vehicle)
    return Round(GetEntitySpeed(vehicle) * 2.236936)
end

local function TryRecklessDrivingAlert(eventName, vehicle)
    local cfg = Config.PoliceAlerts.RecklessDriving

    if IsCooldownActive('recklessdriving') or IsCooldownActive('recklessdriving_pending') then
        Dbg('Cooldown is active, returning.')
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
        Dbg('Random chance failed, returning.')
        return
    end

    local mph = GetSpeedMph(vehicle)
    local minSpeed = cfg.min_speed
    if mph < minSpeed then
        Dbg(('Speed %s < %s, returning.'):format(mph, minSpeed))
        return
    end

    StartCooldown('recklessdriving_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed or despawned, returning.')
        end
        ClearCooldown('recklessdriving_pending')
        return
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords = playerData.coords,
        title = Locale('policealerts_reckless_driving_title'),
        message = Locale('policealerts_reckless_driving_message', playerData.vehicle_colour, playerData.vehicle_label, playerData.heading, playerData.street),
        flash = 0,
        sound = 1,
        blip  = {
            sprite = 326,
            scale = 1.1,
            colour = 1,
            flashes = false,
            text = Locale('policealerts_reckless_driving_title'),
            time = 5,
            radius = 120,
        }
    })

    ClearCooldown('recklessdriving_pending')
    StartCooldown('recklessdriving', cfg.cooldown)
end

local function HandleShockingDrivingEvent(eventName, args)
    local data = ShockingDrivingEvents[eventName]
    if not data then return end

    local cfg = Config.PoliceAlerts.RecklessDriving

    local ped = PlayerPedId()
    local ok, vehicle = IsValidDriver(ped)
    if not ok then return end

    local radius = cfg.event_radius or 60.0
    local playerCoords = GetEntityCoords(ped)

    local eventCoords = nil
    if type(args) == 'table' then
        if args[1] and type(args[1]) == 'vector3' then
            eventCoords = args[1]
        elseif args[1] and args[2] and args[3] and type(args[1]) == 'number' and type(args[2]) == 'number' and type(args[3]) == 'number' then
            eventCoords = vector3(args[1], args[2], args[3])
        end
    end

    if eventCoords then
        if #(playerCoords - eventCoords) > radius then
            return
        end
    end

    TryRecklessDrivingAlert(eventName, vehicle)
end


for eventName, _ in pairs(ShockingDrivingEvents) do
    AddEventHandler(eventName, function(...)
        HandleShockingDrivingEvent(eventName, { ... })
    end)
end