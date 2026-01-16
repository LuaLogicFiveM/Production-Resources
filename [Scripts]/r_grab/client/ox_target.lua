if Config.TargetSystem.UseOXTarget then
    local ox_target = exports.ox_target

    --[[ox_target:addGlobalPlayer({
        {
            name = 'drag_player',
            icon = 'fa-solid fa-person-walking',
            label = Config.Languages[Config.Language]['dragplayer'],
            distance = 2.5,
            canInteract = function()
                return verifyPlayerJob()
            end,
            onSelect = function(data)
                TriggerServerEvent('r_grab:server:grabPlayer', getPlayerFromPed(data.entity))
            end
        }
    })]]

    ox_target:addGlobalVehicle({
        {
            name = 'put_player_in_vehicle',
            icon = 'fa-solid fa-car-rear',
            label = Config.Languages[Config.Language]['putplayerinvehicle'],
            distance = 2.5,
            canInteract = function(entity, distance, coords, name, bone)
                return grabbedData ~= nil and verifyPlayerJob()
            end,
            onSelect = function(data)
                putPlayerInVehicle(true)
            end
        }
    })

    ox_target:addGlobalVehicle({
        {
            name = 'remove_player_from_vehicle',
            icon = 'fa-solid fa-car-rear',
            label = Config.Languages[Config.Language]['removeplayerfromvehicle'],
            distance = 2.5,
            canInteract = function(entity, distance, coords, name, bone)
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
            onSelect = function(data)
                removePlayerFromVehicle(true)
            end
        }
    })
end