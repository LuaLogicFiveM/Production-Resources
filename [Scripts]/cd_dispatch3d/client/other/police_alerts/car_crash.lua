if not Config.PoliceAlerts.ENABLE or not Config.PoliceAlerts.CarCrash.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][CarCrash] ' .. msg .. '\n')
    end
end

local function CarCrashCallPolice(ped, witnessVehicle)
    if IsCooldownActive('carcrash') or IsCooldownActive('carcrash_pending') then
        Dbg('Cooldown is still active, returning.')
        return
    end
    if IsPlayerJobWhitelisted() then
        Dbg('Player job whitelisted, returning.')
        return
    end
    if IsPlayerInNoSnitchingZone then
        Dbg('Player is in a no-snitching zone, returning.')
        return
    end
    if not RandomPoliceCallChance(Config.PoliceAlerts.CarCrash.random_chance or 100) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    StartCooldown('carcrash_pending', Config.PoliceAlerts.WitnessPeds.time_to_kill_caller)
    local policeCalled, canceledReason = HasWitnessCalledPolice()
    if not policeCalled then
        if canceledReason == 'no_peds_nearby' then
            Dbg('No witness ped nearby, returning.')
        elseif canceledReason == 'all_witnesses_harmed' then
            Dbg('All witness peds harmed, returning.')
        end
        ClearCooldown('carcrash_pending')
        return
    end

    local dispatchData = GetPlayerInfo()
    local randomCall = math.random(1, 3)
    local message

    if randomCall == 1 then
        message = Locale('policealerts_carcrash_message_1', dispatchData.vehicle_colour, dispatchData.vehicle_label, dispatchData.vehicle_plate, dispatchData.street)
    elseif randomCall == 2 then
        message = Locale('policealerts_carcrash_message_2', dispatchData.vehicle_colour, dispatchData.vehicle_label, dispatchData.street)
    else
        message = Locale('policealerts_carcrash_message_3', dispatchData.vehicle_colour, dispatchData.street)
    end

    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords    = dispatchData.coords,
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

    ClearCooldown('carcrash_pending')
    StartCooldown('carcrash', Config.PoliceAlerts.CarCrash.cooldown)
end

CreateThread(function()
    local MIN_CRASH_SPEED = Config.PoliceAlerts.CarCrash.minimum_crash_speed or 35
    local COOLDOWN_MS = (Config.PoliceAlerts.CarCrash.cooldown or 30) * 1000

    local COLLIDE_RADIUS = 5.0
    local LOOK_DIST = 3.0

    local lastCrashTime = 0
    local wasCollided = false

    local ped, myVehicle, speed, hasCrashed
    local now, position, velocity, dir, len
    local startPosition, endPosition
    local handle, ret, hit, hitCoords, surfaceNorm, entityHit
    local smallestDistance, victimVehicle, vehicles, veh, distanceCheck

    while true do
        ::continue::
        Wait(200)

        ped = PlayerPedId()

        if not IsPedInAnyVehicle(ped, false) then
            wasCollided = false
            goto continue
        end

        myVehicle = GetVehiclePedIsIn(ped, false)
        if myVehicle == 0 or not DoesEntityExist(myVehicle) then
            wasCollided = false
            goto continue
        end

        speed = GetEntitySpeed(myVehicle) * 2.236936
        hasCrashed = HasEntityCollidedWithAnything(myVehicle)

        if hasCrashed and not wasCollided and speed >= MIN_CRASH_SPEED then
            now = GetGameTimer()
            if (now - lastCrashTime) >= COOLDOWN_MS then
                wasCollided = true
                lastCrashTime = now

                position = GetEntityCoords(myVehicle)
                velocity = GetEntityVelocity(myVehicle)

                dir = velocity
                len = math.sqrt((dir.x * dir.x) + (dir.y * dir.y) + (dir.z * dir.z))
                if len > 0.001 then
                    dir = dir / len
                end

                startPosition = position + vector3(0.0, 0.0, 1.0)
                endPosition = position + (dir * LOOK_DIST) + vector3(0.0, 0.0, 1.0)

                handle = StartShapeTestCapsule(
                    startPosition.x, startPosition.y, startPosition.z,
                    endPosition.x, endPosition.y, endPosition.z,
                    COLLIDE_RADIUS, 2, myVehicle, 7
                )

                ret, hit, hitCoords, surfaceNorm, entityHit = GetShapeTestResult(handle)

                if ret == 2 and hit and entityHit ~= 0 and DoesEntityExist(entityHit) and IsEntityAVehicle(entityHit) then
                    CarCrashCallPolice(ped, entityHit)
                    goto continue
                end

                smallestDistance = COLLIDE_RADIUS * 2.0
                victimVehicle = nil

                vehicles = GetGamePool('CVehicle')
                for cd = 1, #vehicles do
                    veh = vehicles[cd]
                    if veh ~= myVehicle and DoesEntityExist(veh) then
                        distanceCheck = #(GetEntityCoords(veh) - position)
                        if distanceCheck < smallestDistance and HasEntityCollidedWithAnything(veh) then
                            smallestDistance = distanceCheck
                            victimVehicle = veh
                        end
                    end
                end

                if victimVehicle then
                    CarCrashCallPolice(ped, victimVehicle)
                end
            end
        elseif not hasCrashed then
            wasCollided = false
        end
    end
end)