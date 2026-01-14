local function checkVehicle(vehicle)
    local class = GetVehicleClass(vehicle)
    if class == 8 or class == 13 or class == 14 or class == 15 or class == 16 or class == 21 then
        lib.notify({title = 'Tint Meter', description = 'You are unabled to test a vehicle of this class', type = 'error'})
        return false
    end

    local playercoords = GetEntityCoords(cache.ped)
    if #(playercoords - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'door_dside_f'))) < 1.5 then
        if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 and IsVehicleWindowIntact(vehicle, 0) then
            return true
        end
        lib.notify({title = 'Tint Meter', description = 'The vehicle door is not open or the window is broken', type = 'error'})
    elseif #(playercoords - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'door_pside_f'))) < 1.5 then
        if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 and IsVehicleWindowIntact(vehicle, 1) then
            return true
        end
        lib.notify({title = 'Tint Meter', description = 'The vehicle door is not open or the window is broken', type = 'error'})
    else
        lib.notify({title = 'Tint Meter', description = 'You are not close enough to the window', type = 'error'})
    end

    return false
end

local function getTintLabels(level)
    if level == -1 then
        return 'None', 'Legal'
    elseif level == 0 then
        return 'None', 'Legal'
    elseif level == 1 then
        return 'Pure Black', 'Illegal'
    elseif level == 2 then
        return 'Dark Smoke', 'Illegal'
    elseif level == 3 then
        return 'Light Smoke', 'Legal'
    elseif level == 4 then
        return 'Stock', 'Legal'
    elseif level == 5 then
        return 'Limo', 'Illegal'
    elseif level == 6 then
        return 'Green', 'Legal'
    end
end

local function OpenTintMeter()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), 3.0, false)

    if not vehicle then
        return lib.notify({title = 'Tint Meter', description = 'There is not a vehicle nearby', type = 'error'})
    end

    if not checkVehicle(vehicle) then return end

    local tint = GetVehicleWindowTint(vehicle)
    local title, status = getTintLabels(tint)

    if lib.progressCircle({
        label = 'Checking Tint...',
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            combat = true,
            move = true,
            mouse = true,
        },
        anim = {
            dict = 'amb@world_human_tourist_map@female@base',
            clip = 'base'
        },
    }) then
        local menu = {
            id = 'tint_meter_menu',
            title = 'Tint Meter',
            options = {
                {
                    title = title,
                    description = 'Status: '..status,
                    readOnly = true,
                }
            }
        }

        lib.registerContext(menu)
        lib.showContext('tint_meter_menu')
    end
end exports('TintMeter', OpenTintMeter)