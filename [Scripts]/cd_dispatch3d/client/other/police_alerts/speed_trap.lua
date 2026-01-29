if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.SpeedTrap.ENABLE then return end

local SpeedTrapLastHit = {}

local function IsDriverInValidVehicle(ped)
    if not IsPedInAnyVehicle(ped, false) then return false end

    local vehicle = GetVehiclePedIsUsing(ped)
    if vehicle == 0 then return false end
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then return false end
    if IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then return false end

    return true, vehicle
end

local function TrapCooldownReady(trapIndex, seconds)
    local now = GetGameTimer()
    seconds = seconds * 1000

    if SpeedTrapLastHit[trapIndex] and (now - SpeedTrapLastHit[trapIndex]) < seconds then
        return false
    end
    SpeedTrapLastHit[trapIndex] = now
    return true
end

local function GetVehicleSpeed(vehicle)
    local unit = Config.PoliceAlerts.SpeedTrap.speed_unit:lower()
    local ms = GetEntitySpeed(vehicle)

    if unit == 'kmh' then
        return Round(ms * 3.6), 'kmh'
    end

    return Round(ms * 2.236936), 'mph'
end

CreateThread(function()
    local traps = Config.PoliceAlerts.SpeedTrap.Locations

    while true do
        ::continue::

        local ped = PlayerPedId()

        local ok, vehicle = IsDriverInValidVehicle(ped)
        if not ok then
            Wait(2000)
            goto continue
        end

        if IsPlayerJobWhitelisted() then
            Wait(1000)
            goto continue
        end

        local coords = GetEntityCoords(ped)

        local speedMph = Round(GetEntitySpeed(vehicle) * 2.236936)

        local foundTrapIndex, foundTrap
        local nearAnyTrap = false

        for cd = 1, #traps do
            local trap = traps[cd]
            local dist = #(coords - trap.coords)

            if dist < (trap.radius + 25.0) then
                nearAnyTrap = true
            end

            if dist < trap.radius and speedMph > trap.speed_limit then
                foundTrapIndex, foundTrap = cd, trap
                break
            end
        end

        if not nearAnyTrap then
            Wait(300)
            goto continue
        end

        if not foundTrap then
            Wait(50)
            goto continue
        end

        if not TrapCooldownReady(foundTrapIndex, 10) then
            Wait(150)
            goto continue
        end

        local speed, unit = GetVehicleSpeed(vehicle)

        Wait(math.random(3000, 6000))

        if not DoesEntityExist(vehicle) then
            Wait(250)
            goto continue
        end

        local playerData = GetPlayerInfo()

        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config.PoliceAlerts.police_jobs,
            coords = playerData.coords,
            title = Locale('policealerts_speedtrap_title'),
            message = Locale('policealerts_speedtrap_message', playerData.vehicle_colour, playerData.vehicle_label, playerData.vehicle_plate, speed, playerData.heading, playerData.street),
            flash     = 0,
            sound     = 1,
            blip      = {
                sprite  = 515,
                scale   = 1.0,
                colour  = 3,
                flashes = false,
                text    = Locale('policealerts_speedtrap_title'),
                time    = 5,
                radius  = 0,
            }
        })

        TriggerServerEvent('cd_dispatch:pdalerts:Speedtrap', playerData, foundTrap, speed, GetVehiclePlate(vehicle))

        Wait((Config.PoliceAlerts.SpeedTrap.cooldown) * 1000)

        Wait(0)
    end
end)

if Config.PoliceAlerts.SpeedTrap.enable_blip then
    CreateThread(function()
        for _, location in ipairs(Config.PoliceAlerts.SpeedTrap.Locations) do
            local blip = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)
            SetBlipSprite(blip, 184)
            SetBlipDisplay(blip, 5)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 0)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Locale('speedtrap_blip_name'))
            EndTextCommandSetBlipName(blip)
        end
    end)
end



if Config.Debug then
    CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local heading = RoundDecimals(GetEntityHeading(PlayerPedId()), 1)
            for _, trap in ipairs(Config.PoliceAlerts.SpeedTrap.Locations) do
                local dist = #(playerCoords - trap.coords)
                if dist < 50.0 then
                    DrawMarker(28, trap.coords.x, trap.coords.y, trap.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, trap.radius+0.0, trap.radius+0.0, trap.radius+0.0, 255, 0, 170, 170, false, false, 2, false, nil, nil, false)
                end
            end
            Wait(0)
        end
    end)
end