if Config.TargetSystem.UseQBTarget then
    local qbTarget = exports['qb-target']

    qbTarget:AddTargetModel('mp_m_freemode_01', {
        options = {
            {
                icon = "fa-solid fa-person-walking",
                label = Config.Languages[Config.Language]['dragplayer'],
                canInteract = function(entity)
                    return verifyPlayerJob()
                end,
                action = function(entity)
                    TriggerServerEvent('r_grab:server:grabPlayer', getPlayerFromPed(entity))
                end
            }
        },
        distance = 2.5
    })

    qbTarget:AddTargetModel('mp_f_freemode_01', {
        options = {
            {
                icon = "fa-solid fa-person-walking",
                label = Config.Languages[Config.Language]['dragplayer'],
                canInteract = function(entity)
                    return verifyPlayerJob()
                end,
                action = function(entity)
                    TriggerServerEvent('r_grab:server:grabPlayer', getPlayerFromPed(entity))
                end
            }
        },
        distance = 2.5
    })

    qbTarget:AddGlobalVehicle({
        options = {
            {
                icon = "fa-solid fa-car-rear",
                label = Config.Languages[Config.Language]['putplayerinvehicle'],
                canInteract = function(entity)
                    return grabbedData ~= nil and verifyPlayerJob()
                end,
                action = function(entity)
                    putPlayerInVehicle(true)
                end
            }
        },
        distance = 2.5
    })

    qbTarget:AddGlobalVehicle({
        options = {
            {
                icon = "fa-solid fa-car-rear",
                label = Config.Languages[Config.Language]['removeplayerfromvehicle'],
                canInteract = function(entity)
                    if DoesEntityExist(entity) and NetworkGetEntityIsNetworked(entity) then
                        local occupants = vehicleData[NetworkGetNetworkIdFromEntity(entity)]

                        if occupants then
                            for i = 1, #occupants do
                                local pedToCheck = GetPlayerPed(GetPlayerFromServerId(occupants[i]))
                                local isNearby = #(GetEntityCoords(pedToCheck) - coords) < 2.5
                                
                                if isNearby then
                                    return true and verifyPlayerJob()
                                end
                            end
                        end
                    end

                    return false
                end,
                action = function(entity)
                    removePlayerFromVehicle(true)
                end
            }
        },
        distance = 2.5
    })
end