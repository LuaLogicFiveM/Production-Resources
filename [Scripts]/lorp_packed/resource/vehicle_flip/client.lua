local function FlipVehicle(VehicleData)
    local success = lib.skillCheck({'easy', 'medium'}, {'1', '2', '3', '4'})
    if success then
        if lib.progressCircle({
            label = 'Flipping Vehicle...',
            duration = 10000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
                mouse = false,
            },
            anim = {
                dict = 'missfinale_c2ig_11',
                clip = 'pushcar_offcliff_m'
            },
        }) then 
            local carCoords = GetEntityRotation(VehicleData, 2)
            SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
            SetVehicleOnGroundProperly(VehicleData)
            lib.notify({
                title = 'Vehicle System',
                description = 'You flipped the vehicle',
                position = 'top',
                icon = 'car',
                iconColor = 'green'
            })
        else
            lib.notify({
                title = 'Vehicle System',
                description = 'You could not flip the vehicle',
                position = 'top',
                icon = 'car',
            })
        end
    end
end exports('FlipVehicle', FlipVehicle)

CreateThread(function()
    exports.ox_target:addGlobalVehicle({
        label = 'Flip Vehicle',
        icon = 'fa-solid fa-car-burst',
        distance = 3.0,
        canInteract = function(entity)
            return not IsVehicleOnAllWheels(entity)
        end,
        onSelect = function(data)
            FlipVehicle(data.entity)
        end,
    })
end)