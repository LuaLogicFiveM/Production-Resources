if not Config.PoliceAlerts.ENABLE then return end

-- Returns true if the player is on duty and their job is in the whitelist.
local function IsPlayerJobWhitelisted()
    return HasJob(Config.PoliceAlerts.whitelisted_jobs)
end

-- Returns true if the player is within any whitelisted zone for gunshots.
local function IsPlayerInGunshotWhitelistZone()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for _, zone in pairs(Config.PoliceAlerts.GunShots.WhitelistedZones) do
        if #(coords - zone.coords) <= zone.distance then
            return true
        end
    end
    if IsPlayingPaintball() then
        return true
    end

    return false
end

local pedIsCurrentlyCallingPolice = {}
local function HasWitnessCalledPolice() --change it to be only 1 caller, or do it so more call based on how many peds are in the area. choose the chosen peds randomly.
    if not Config.PoliceAlerts.require_witness_peds.ENABLE then
        return false
    end

    local required_distance = Config.PoliceAlerts.require_witness_peds.distance
    local kill_timer = Config.PoliceAlerts.require_witness_peds.time_to_kill

    local player_ped = PlayerPedId()
    local player_coords = GetEntityCoords(player_ped)

    local policeCalled = false
    local chosenPed = {}

    local peds = GetGamePool('CPed')
    local tempPeds = {}
    for cd = 1, #peds do
        local ped = peds[cd]
        local ped_coords = GetEntityCoords(ped)
        local dist = #(player_coords-ped_coords)
        if not IsPedAPlayer(ped) and not IsPedInAnyVehicle(ped, false) and dist < required_distance and not pedIsCurrentlyCallingPolice[ped] then
            tempPeds[#tempPeds+1] = {ped = ped, health = GetEntityHealth(ped)}
        end
    end

    if #tempPeds > 0 then
        chosenPed = tempPeds[math.random(1, #tempPeds)]
        pedIsCurrentlyCallingPolice[#pedIsCurrentlyCallingPolice+1] = chosenPed
    else
        return false
    end

    TaskTurnPedToFaceEntity(chosenPed.ped, player_ped, kill_timer*1000)
    RequestAnimDict('cellphone@')
    while not HasAnimDictLoaded('cellphone@') do
        Wait(0)
    end
    TaskPlayAnim(chosenPed.ped, 'cellphone@', 'cellphone_call_listen_base', 8.0, -8.0, -1, 49, 0, false, false, false)

    local endtime = GetGameTimer() + (kill_timer * 1000)
    while true do
        Wait(100)
        local now = GetGameTimer()
        local remaining = endtime - now
        if remaining <= 0 then
            policeCalled = true
            break
        end
        if GetEntityHealth(chosenPed.ped) < chosenPed.health or IsEntityDead(chosenPed.ped) then
            break
        end
    end
    StopAnimTask(chosenPed.ped, 'cellphone@', 'cellphone_call_listen_base', 8.0)
    TaskReactAndFleePed(chosenPed.ped, player_ped)
    pedIsCurrentlyCallingPolice[chosenPed.ped] = nil

    return policeCalled
end

--#####################################################################
-- Gunshot Alert Thread
--#####################################################################

if Config.PoliceAlerts.GunShots.ENABLE then
    CreateThread(function()
        while true do
            local wait_time = 500  -- default wait time
            local ped = PlayerPedId()
            local has_weapon, weapon_hash = GetCurrentPedWeapon(ped)

            -- If the player has a weapon, reduce wait time for more responsive checks.
            if has_weapon then
                wait_time = 5
            end

            -- Determine whether we should process an alert.
            local process_alert = false

            -- Only process the alert if all checks are passed.
            if IsPedShooting(ped) and not IsPedCurrentWeaponSilenced(ped) and not Config.PoliceAlerts.GunShots.WhitelistedWeapons[weapon_hash] and not IsPlayerJobWhitelisted() and not IsPlayerInGunshotWhitelistZone() and not HasWitnessCalledPolice() then
                process_alert = true
            end

            if process_alert then
                local weapon_name = WeaponHashToLabel[weapon_hash] or Locale('firearm')
                local in_vehicle = IsPedInAnyVehicle(ped, true)
                local data = GetPlayerInfo()
                local message

                if in_vehicle then
                    message = Locale('policealerts_gunshots_message_1', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, data.heading, data.street) --randomize the data thats sent when a player is in a vehicle.
                else
                    message = Locale('policealerts_gunshots_message_2', data.sex, weapon_name, data.street)
                end

                TriggerServerEvent('cd_dispatch:AddNotification', {
                    job_table = Config.PoliceAlerts.police_jobs,
                    coords    = data.coords,
                    title     = Locale('policealerts_gunshots_title'),
                    message   = message,
                    flash     = 0,
                    sound     = 1,
                    blip      = {
                        sprite  = in_vehicle and 229 or 313,
                        scale   = 1.2,
                        colour  = 3,
                        flashes = false,
                        text    = Locale('policealerts_gunshots_title'),
                        time    = 5,
                        radius  = 100,
                    }
                })

                if Config.PoliceAlerts.add_bolos and in_vehicle then
                    TriggerServerEvent('cd_dispatch:pdalerts:Gunshots', data)
                end

                -- Wait the configured cooldown before checking again.
                Wait(Config.PoliceAlerts.cooldown * 1000)
            else
                Wait(wait_time)
            end
        end
    end)
end


--#####################################################################
-- Speed Trap Alert Thread
--#####################################################################


if Config.PoliceAlerts.SpeedTrap.ENABLE then
    CreateThread(function()
        local function FirstChecks(ped, vehicle)
            if vehicle ~= 0 and ped == GetPedInVehicleSeat(vehicle, -1) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
                return true
            end
            return false
        end

        local function SecondChecks()
            if not IsPlayerJobWhitelisted() and not HasWitnessCalledPolice() then
                return true
            end
            return false
        end

        while true do
            local wait_time = 50
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)

            if FirstChecks(ped, vehicle) then
                local ped_coords = GetEntityCoords(ped)
                local speed = Round(GetEntitySpeed(vehicle) * 2.236936)

                for cd = 1, #Config.PoliceAlerts.SpeedTrap.Locations do
                    local config_data = Config.PoliceAlerts.SpeedTrap.Locations[cd]
                    if (#(config_data.coords-ped_coords) < config_data.distance) and (speed > config_data.speed_limit) then

                        if SecondChecks() then
                            Wait(math.random(3000, 6000))

                            local data = GetPlayerInfo()
                            TriggerServerEvent('cd_dispatch:AddNotification', {
                                job_table = Config.PoliceAlerts.police_jobs,
                                coords = data.coords,
                                title = Locale('policealerts_speedtrap_title'),
                                message = Locale('policealerts_speedtrap_message', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street),
                                flash = 0,
                                sound = 1,
                                blip = {
                                    sprite = 515,
                                    scale = 1.0,
                                    colour = 3,
                                    flashes = false,
                                    text = Locale('policealerts_speedtrap_title'),
                                    time = 5,
                                    radius = 0,
                                }
                            })
                            TriggerServerEvent('cd_dispatch:pdalerts:Speedtrap', data, config_data, speed, GetAllPlateFormats(vehicle))
                            Wait(Config.PoliceAlerts.cooldown * 1000)
                            break
                        end
                    else
                        wait_time = 500
                    end
                end
            else
                wait_time = 2000
            end
            Wait(wait_time)
        end
    end)
end

-- Speed Trap Blip Thread
if Config.PoliceAlerts.SpeedTrap.Blip.ENABLE then
    CreateThread(function()
        for _, location  in pairs(Config.PoliceAlerts.SpeedTrap.Locations) do
            local blip = AddBlipForCoord(location .coords.x, location .coords.y, location .coords.z)
            SetBlipSprite(blip, Config.PoliceAlerts.SpeedTrap.Blip.sprite)
            SetBlipDisplay(blip, Config.PoliceAlerts.SpeedTrap.Blip.display)
            SetBlipScale(blip, Config.PoliceAlerts.SpeedTrap.Blip.scale)
            SetBlipColour(blip, Config.PoliceAlerts.SpeedTrap.Blip.colour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Config.PoliceAlerts.SpeedTrap.Blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end)
end


--#####################################################################
-- Car Crash Alert Thread
--#####################################################################

if Config.PoliceAlerts.CarCrash.ENABLE then

    local function callPolice_CarCrash(data)
        local message
        local randomCall = math.random(1,3)

        if randomCall == 1 then
            message = Locale('policealerts_carcrash_message_1', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, data.street)
        elseif randomCall == 2 then
            message = Locale('policealerts_carcrash_message_2', data.vehicle_colour, data.vehicle_label, data.street)
        elseif randomCall == 3 then
            message = Locale('policealerts_carcrash_message_3', data.vehicle_colour, data.street)
        end

        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config.PoliceAlerts.police_jobs,
            coords    = data.coords,
            title     = Locale('policealerts_carcrash_title'),
            message   = message,
            flash     = 0,
            sound     = 1,
            blip      = {
                sprite  = 380,
                scale   = 1.2,
                colour  = 3,
                flashes = false,
                text    = Locale('policealerts_carcrash_title'),
                time    = 5,
                radius  = 50,
            }
        })
    end

    local function CarCrashCallPolice(ped, witnessVehicle)
        local dispatchData = GetPlayerInfo()
        if not Config.PoliceAlerts.require_witness_peds.ENABLE then
            callPolice_CarCrash(dispatchData)
            return
        end

        local witnessPed = GetPedInVehicleSeat(witnessVehicle, -1)
        local witnessPedHealth = GetEntityHealth(witnessPed)
        local policeCalled = false
        local kill_timer = Config.PoliceAlerts.require_witness_peds.time_to_kill

        TaskLeaveVehicle(witnessPed, witnessVehicle, 0)

        TaskTurnPedToFaceEntity(witnessPed, ped, -1)
        RequestAnimDict('cellphone@')
        while not HasAnimDictLoaded('cellphone@') do
            Wait(0)
        end
        TaskPlayAnim(witnessPed, 'cellphone@', 'cellphone_call_listen_base', 8.0, -8.0, -1, 49, 0, false, false, false)
        while GetPedInVehicleSeat(witnessVehicle, -1) ~= 0 do Wait(100) if IsEntityDead(witnessPed) then break end end

        local endtime = GetGameTimer() + (kill_timer * 1000)
        while true do
            Wait(100)
            local now = GetGameTimer()
            local remaining = endtime - now
            if remaining <= 0 then
                policeCalled = true
                break
            end
            if GetEntityHealth(witnessPed) < witnessPedHealth or IsEntityDead(witnessPed) then
                break
            end
        end
        StopAnimTask(witnessPed, 'cellphone@', 'cellphone_call_listen_base', 8.0)
        TaskReactAndFleePed(witnessPed, ped)

        if policeCalled then
            callPolice_CarCrash(dispatchData)
        end
    end

    CreateThread(function()
        local MIN_CRASH_SPEED = Config.PoliceAlerts.CarCrash.minimum_crash_speed
        local COOLDOWN = Config.PoliceAlerts.cooldown
        local COLLIDE_RADIUS = 5 --radius of the capsule.
        local LOOK_DIST = 3 --how far ahead in the distance should we cast.

        local lastCrashTime = 0
        local wasCollided = false
        while true do
            Wait(200)

            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped, false) then
                wasCollided = false
            else
                local myVehicle = GetVehiclePedIsIn(ped, false)
                local speed = GetEntitySpeed(myVehicle)*2.236936

                local hasCrashed = HasEntityCollidedWithAnything(myVehicle)
                if hasCrashed and not wasCollided and speed >= MIN_CRASH_SPEED then
                    local now = GetGameTimer()
                    if now - lastCrashTime >= COOLDOWN then
                        wasCollided = true
                        lastCrashTime = now

                        local position = GetEntityCoords(myVehicle)
                        local velocity = GetEntityVelocity(myVehicle)
                        local direction = velocity / (speed > 0 and speed or 1)
                        local startPosition = position + vector3(0, 0, 1.0)
                        local endPosistion = position + direction * LOOK_DIST+0.0 + vector3(0, 0, 1.0)

                        local handle = StartShapeTestCapsule(startPosition.x, startPosition.y, startPosition.z, endPosistion.x, endPosistion.y, endPosistion.z, COLLIDE_RADIUS+0.0, 2, myVehicle, 7)
                        local ret, hit, hitCoords, surfaceNorm, entityHit = GetShapeTestResult(handle)
                        if ret == 2 and hit and entityHit ~= 0 and DoesEntityExist(entityHit) and IsEntityAVehicle(entityHit) then
                            CarCrashCallPolice(ped, entityHit)
                        else
                            local smallestDistance = COLLIDE_RADIUS+0.0 * 2
                            local victimVehicle = nil

                            for _, vehicle in ipairs(GetGamePool('CVehicle')) do
                                local distanceCheck = #(GetEntityCoords(vehicle) - position)
                                if vehicle ~= myVehicle
                                and distanceCheck < smallestDistance
                                and HasEntityCollidedWithAnything(vehicle)
                                then
                                    smallestDistance = distanceCheck
                                    victimVehicle = vehicle
                                end
                            end
                            if victimVehicle then
                                CarCrashCallPolice(ped, victimVehicle)
                            end
                        end
                    end
                elseif not hasCrashed then
                    wasCollided = false
                end
            end
        end
    end)

end