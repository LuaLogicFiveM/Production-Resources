Killfeed = {}
local lastDeath = 0

AddEventHandler('gameEventTriggered', function(name, args)
    if name ~= 'CEventNetworkEntityDamage' then return end
    local victim = args[1]
    local attacker = args[2]
    local isFatal = args[6]
    local weaponHash = args[7]
    if not victim or not DoesEntityExist(victim) or not IsEntityAPed(victim) or not IsPedAPlayer(victim) or (isFatal ~= 1 and isFatal ~= true) or victim ~= PlayerPedId() then return end
    local now = GetGameTimer()
    if now - lastDeath < Config.Killfeed.DeathCooldown then return end
    lastDeath = now

    local killerId = 0
    local distance = 0.0
    local victimCoords = GetEntityCoords(PlayerPedId())
    if attacker and attacker ~= 0 and DoesEntityExist(attacker) then
        local attackerCoords = GetEntityCoords(attacker)
        distance = #(victimCoords - attackerCoords)
        if IsEntityAPed(attacker) and IsPedAPlayer(attacker) then
            local killerPlayer = NetworkGetPlayerIndexFromPed(attacker)
            if killerPlayer >= 0 then
                killerId = GetPlayerServerId(killerPlayer)
            end
        elseif IsEntityAVehicle(attacker) then
            local driver = GetPedInVehicleSeat(attacker, -1)
            if driver and driver ~= 0 and IsEntityAPed(driver) and IsPedAPlayer(driver) then
                local driverPlayer = NetworkGetPlayerIndexFromPed(driver)
                if driverPlayer >= 0 then
                    killerId = GetPlayerServerId(driverPlayer)
                    weaponHash = GetHashKey('WEAPON_RUN_OVER_BY_CAR')
                end
            else
                for seat = 0, GetVehicleMaxNumberOfPassengers(attacker) - 1 do
                    local passenger = GetPedInVehicleSeat(attacker, seat)
                    if passenger and passenger ~= 0 and IsEntityAPed(passenger) and IsPedAPlayer(passenger) then
                        local passengerPlayer = NetworkGetPlayerIndexFromPed(passenger)
                        if passengerPlayer >= 0 then
                            killerId = GetPlayerServerId(passengerPlayer)
                            weaponHash = GetHashKey('WEAPON_RUN_OVER_BY_CAR')
                            break
                        end
                    end
                end
            end
        end
    end
    if killerId == GetPlayerServerId(PlayerId()) then killerId = 0 end
    local isSuicide = killerId == 0
    distance = math.floor(distance * 10 + 0.5) / 10
    TriggerServerEvent('eg_killfeed:server:playerDied', killerId, weaponHash, distance, isSuicide)
end)

RegisterCommand('killfeededitor', function()
    if UI.isEditorOpen then
        UI.CloseEditor()
    else
        UI.OpenEditor()
    end
end, false)

CreateThread(function()
    Wait(3000)
    TriggerServerEvent('eg_killfeed:server:playerLoaded')
end)

return Killfeed
