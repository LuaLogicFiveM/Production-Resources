local cooldown = false
local Locations = {
    vec3(-1134.1917, -1621.0695, 4.5111),--693
    vec3(-287.8678, -2688.8169, 6.1596),--913
    vec3(1321.3428, 2632.8999, 39.2984),--262
    vec3(1418.9896, 1043.0084, 113.3351),--538
    vec3(735.8017, -1072.3123, 21.2329),--769
    vec3(-1159.6997, -2094.9856, 13.2617),--887
    vec3(2730.2830, 4921.5288, 33.8412),--099
    vec3(2420.3066, 1553.3392, 36.3692),--346
    vec3(1442.0057, 1710.7118, 110.9060),--542
    vec3(-1156.2391, -1184.4346, 5.6234),--698
    vec3(1325.4037, 2621.6938, 39.4674),--262
    vec3(718.6129, 112.4341, 80.8684),--592
}

local function StartChop()
    if cache.vehicle and not cooldown then
        local playerCoords = GetEntityCoords(cache.ped)
        local dispatchId = exports["lb-tablet"]:AddDispatch({
            priority = 'medium',
            code = '10-100',
            title = 'Illegal Chop Shop Alert',
            description = 'There is a report of a vehicle chop shop at the marked locations',
            location = { label = GetStreetNameFromHashKey(GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)), coords = { x = playerCoords.x, y = playerCoords.y, z = playerCoords.z } },
            time = 30,
            job = 'police', -- not a job just category
            sound = 'notification.mp3'
        })
        if lib.progressCircle({
            label = 'Opening Hood...',
            duration = 1500,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
                mouse = false,
            },
        }) then
            SetVehicleDoorOpen(cache.vehicle, 4, false, false)
            if lib.progressCircle({
                label = 'Chopping Hood...',
                duration = 5000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true,
                    mouse = false,
                },
            }) then
                SetVehicleDoorBroken(cache.vehicle, 4, true)
                if lib.progressCircle({
                    label = 'Opening Trunk...',
                    duration = 1500,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                        move = true,
                        combat = true,
                        mouse = false,
                    },
                }) then
                    SetVehicleDoorOpen(cache.vehicle, 5, false, false)
                    if lib.progressCircle({
                        label = 'Chopping Trunk...',
                        duration = 5000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                            combat = true,
                            mouse = false,
                        },
                    }) then
                        SetVehicleDoorBroken(cache.vehicle, 5, true)
                        if lib.progressCircle({
                            label = 'Opening Front Driver Door...',
                            duration = 1500,
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                                combat = true,
                                mouse = false,
                            },
                        }) then
                            SetVehicleDoorOpen(cache.vehicle, 0, false, false)
                            if lib.progressCircle({
                                label = 'Chopping Front Driver Door...',
                                duration = 5000,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    car = true,
                                    move = true,
                                    combat = true,
                                    mouse = false,
                                },
                            }) then
                                SetVehicleDoorBroken(cache.vehicle, 0, true)
                                if lib.progressCircle({
                                    label = 'Opening Front Passenger Door...',
                                    duration = 1500,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        car = true,
                                        move = true,
                                        combat = true,
                                        mouse = false,
                                    },
                                }) then
                                    SetVehicleDoorOpen(cache.vehicle, 1, false, false)
                                    if lib.progressCircle({
                                        label = 'Chopping Front Passenger Door...',
                                        duration = 5000,
                                        position = 'bottom',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        SetVehicleDoorOpen(cache.vehicle, 1, false, false)
                                        if lib.progressCircle({
                                            label = 'Opening Rear Left Door...',
                                            duration = 1500,
                                            position = 'bottom',
                                            useWhileDead = false,
                                            canCancel = true,
                                            disable = {
                                                car = true,
                                                move = true,
                                                combat = true,
                                                mouse = false,
                                            },
                                        }) then
                                            SetVehicleDoorOpen(cache.vehicle, 2, false, false)
                                            if lib.progressCircle({
                                                label = 'Chopping Rear Left Door...',
                                                duration = 5000,
                                                position = 'bottom',
                                                useWhileDead = false,
                                                canCancel = true,
                                                disable = {
                                                    car = true,
                                                    move = true,
                                                    combat = true,
                                                    mouse = false,
                                                },
                                            }) then
                                                SetVehicleDoorBroken(cache.vehicle, 2, true)
                                                if lib.progressCircle({
                                                    label = 'Opening Rear Right Door...',
                                                    duration = 1500,
                                                    position = 'bottom',
                                                    useWhileDead = false,
                                                    canCancel = true,
                                                    disable = {
                                                        car = true,
                                                        move = true,
                                                        combat = true,
                                                        mouse = false,
                                                    },
                                                }) then
                                                    SetVehicleDoorOpen(cache.vehicle, 3, false, false)
                                                    if lib.progressCircle({
                                                        label = 'Chopping Rear Right Door...',
                                                        duration = 5000,
                                                        position = 'bottom',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        disable = {
                                                            car = true,
                                                            move = true,
                                                            combat = true,
                                                            mouse = false,
                                                        },
                                                    }) then
                                                        if cache.vehicle then
                                                            SetVehicleDoorBroken(cache.vehicle, 3, true)
                                                            DeleteEntity(cache.vehicle)
                                                            ESX.ShowNotification('You finished chopping the vehicle!')
                                                            TriggerServerEvent('lorp_chopshop:server:requestChoppedVehicle')
                                                            cooldown = true
                                                            SetTimeout(60000*5, function()
                                                                cooldown = false
                                                            end)
                                                        end
                                                    else
                                                        ESX.ShowNotification('You canceled the Chopping Process.')
                                                    end
                                                else
                                                    ESX.ShowNotification('You canceled the Chopping Process.')
                                                end
                                            else
                                                ESX.ShowNotification('You canceled the Chopping Process.')
                                            end
                                        else
                                            ESX.ShowNotification('You canceled the Chopping Process.')
                                        end
                                    else
                                        ESX.ShowNotification('You canceled the Chopping Process.')
                                    end
                                else
                                    ESX.ShowNotification('You canceled the Chopping Process.')
                                end
                            else
                                ESX.ShowNotification('You canceled the Chopping Process.')
                            end
                        else
                            ESX.ShowNotification('You canceled the Chopping Process.')
                        end
                    else
                        ESX.ShowNotification('You canceled the Chopping Process.')
                    end
                else
                    ESX.ShowNotification('You canceled the Chopping Process.')
                end
            else
                ESX.ShowNotification('You canceled the Chopping Process.')
            end
        else
            ESX.ShowNotification('You canceled the Chopping Process.')
        end
    else
        ESX.ShowNotification('You are on cooldown.')
    end
end

CreateThread(function()
    for _, v in pairs(Locations) do
        local ChopShopPoint = lib.points.new({
            coords = vec3(v.x, v.y, v.z),
            distance = 3,
        })

        function ChopShopPoint:onEnter()
            if cache.vehicle then
                lib.showTextUI('[E] - Chop Vehicle')
            end
        end

        function ChopShopPoint:onExit()
            lib.hideTextUI()
        end

        function ChopShopPoint:nearby()
            DrawMarker(1, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 1.0, 255, 0, 0, 255, false, true, 2, false, nil, nil, false)
            if IsControlJustReleased(0, 38) and cache.vehicle then
                StartChop()
            end
        end
    end
end)