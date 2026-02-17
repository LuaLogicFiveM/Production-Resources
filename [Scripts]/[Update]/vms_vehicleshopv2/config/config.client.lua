CL = {}

-- █▀▄ █▀▄ ▄▀▄ █   █ ▀█▀ ██▀ ▀▄▀ ▀█▀ ▀██ █▀▄
-- █▄▀ █▀▄ █▀█ ▀▄▀▄▀  █  █▄▄ █ █  █  ▄▄█ █▄▀
CL.DrawText3D = function(coords, text) -- This is the function used when using Config.UseText3D
    local camCoords = GetFinalRenderedCamCoord()
    local distance = #(vec(coords.x, coords.y, coords.z) - camCoords)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    SetTextScale(0.0 * scale, 0.35 * scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


-- ▀█▀ ▄▀▄ █▀▄ ▄▀  ██▀ ▀█▀
--  █  █▀█ █▀▄ ▀▄█ █▄▄  █ 
CL.Target = function(type, data, cb)
    if Config.TargetResource == 'ox_target' then
        if type == "entity" then
            return exports['ox_target']:addLocalEntity(data.entity, {
                {
                    name = 'vms_vehicleshopv2-'..data.uniqueName,
                    icon = data.icon,
                    label = data.label,
                    onSelect = function()
                        cb()
                    end,
                    distance = 1.6
                }
            })
        elseif type == "remove_entity" then
            exports['ox_target']:removeLocalEntity(data.entity, data.targetId)
        elseif type == "point" then
            return exports['ox_target']:addBoxZone({
                coords = vec(data.coords.x, data.coords.y, data.coords.z),
                size = data.size,
                debug = false,
                useZ = true,
                rotation = data.rotation or 0.0,
                options = {
                    {
                        distance = 1.8,
                        name = 'vms_vehicleshopv2',
                        icon = data.icon,
                        label = data.label,
                        onSelect = function()
                            cb()
                        end
                    }
                }
            })
        elseif type == "remove_point" then
            exports['ox_target']:removeZone(data.targetId)
        end
    elseif Config.TargetResource == "qb-target" then
        if type == "entity" then
            exports['qb-target']:AddTargetEntity(data.entity, {
                options = {
                    { 
                        num = 1,
                        icon = data.icon,
                        label = data.label,
                        action = function(entity)
                            cb()
                        end,
                    }
                },
                distance = 1.6,
            })
        
        elseif type == "remove_entity" then
            exports['qb-target']:RemoveTargetEntity(data.entity, data.targetId)
        elseif type == "point" then
            print('vms_vehicleshopv2-'..data.uniqueName)
            exports['qb-target']:AddBoxZone('vms_vehicleshopv2-'..data.uniqueName, vec(data.coords.x, data.coords.y, data.coords.z), data.size.x, data.size.y, {
                name = 'vms_vehicleshopv2-'..data.uniqueName,
                heading = data.rotation - 90.0 or 0.0,
                debugPoly = false,
                minZ = data.coords.z - (data.size.y),
                maxZ = data.coords.z + (data.size.y),
            }, {
                options = {
                    {
                        num = 1,
                        icon = data.icon,
                        label = data.label,
                        action = function()
                            cb()
                        end,
                    }
                },
                distance = 1.8,
            })
            return 'vms_vehicleshopv2-'..data.uniqueName
        elseif type == "remove_point" then
            exports['qb-target']:RemoveZone(data.targetId)
        end
    else
        print('You need to prepare Config.Target for the target system')
    end
end


-- █▀ █▀▄ ▄▀▄ █▄ ▄█ ██▀ █   █ ▄▀▄ █▀▄ █▄▀
-- █▀ █▀▄ █▀█ █ ▀ █ █▄▄ ▀▄▀▄▀ ▀▄▀ █▀▄ █ █
CL.GetClosestPlayers = function()
    if Config.Core == "ESX" then
        local playerInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
        return playerInArea
    elseif Config.Core == "QB-Core" then
        local playerInArea = QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 5.0)
        return playerInArea
    end
end

CL.GetIdentifier = function()
    if Config.Core == "ESX" then
        return PlayerData.identifier
    elseif Config.Core == "QB-Core" then
        return PlayerData.citizenid
    end
end

CL.IsEmployee = function(jobName)
    if Config.Core == "ESX" then
        return PlayerData.job.name == jobName
    elseif Config.Core == "QB-Core" then
        return PlayerData.job.name == jobName
    end
end

CL.IsManager = function(jobName)
    if Config.Core == "ESX" then
        return (PlayerData.job.name == jobName and PlayerData.job.grade_name == 'manager')
    elseif Config.Core == "QB-Core" then
        return (PlayerData.job.name == jobName and PlayerData.job.grade.level == 1)
    end
end

CL.IsBoss = function(jobName, storeId)
    if Config.Core == "ESX" then
        return (PlayerData.job.name == jobName and PlayerData.job.grade_name == 'boss')
    elseif Config.Core == "QB-Core" then
        return (PlayerData.job.name == jobName and PlayerData.job.grade.level == 2)
    end
end

CL.IsAllowedCityhall = function(jobName, storeId)
    local allowed = {}
    local options = Config.Stores[storeId].cityhall_grades
    if Config.Core == "ESX" then
        if PlayerData.job.name ~= jobName then
            return false
        end

        if options['resumes'] then
            if type(options['resumes']) == 'table' then
                for _, grade in ipairs(options['resumes']) do
                    if PlayerData.job.grade_name == grade then
                        allowed['resumes'] = true
                        break
                    end
                end
            else
                if PlayerData.job.grade_name == options['resumes'] then
                    allowed['resumes'] = true
                end
            end
        end

        if options['taxes'] then
            if type(options['taxes']) == 'table' then
                for _, grade in ipairs(options['taxes']) do
                    if PlayerData.job.grade_name == grade then
                        allowed['taxes'] = true
                        break
                    end
                end
            else
                if PlayerData.job.grade_name == options['taxes'] then
                    allowed['taxes'] = true
                end
            end
        end
        
    elseif Config.Core == "QB-Core" then
        if PlayerData.job.name ~= jobName then
            return false
        end

        if options['resumes'] then
            if type(options['resumes']) == 'table' then
                for _, grade in ipairs(options['resumes']) do
                    if PlayerData.job.grade.name == grade then
                        allowed['resumes'] = true
                        break
                    end
                end
            else
                if PlayerData.job.grade.name == options['resumes'] then
                    allowed['resumes'] = true
                end
            end
        end

        if options['taxes'] then
            if type(options['taxes']) == 'table' then
                for _, grade in ipairs(options['taxes']) do
                    if PlayerData.job.grade.name == grade then
                        allowed['taxes'] = true
                        break
                    end
                end
            else
                if PlayerData.job.grade.name == options['taxes'] then
                    allowed['taxes'] = true
                end
            end
        end
        
    end

    return allowed
end

CL.GetEmployees = function(cb, jobName)
    if Config.Core == "ESX" then
        ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)
            cb(employees)
        end, jobName)

    elseif Config.Core == "QB-Core" then
        QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(employees)
            cb(employees)
        end, jobName)
        
    end
end


CL.SetVehicle = function(vehicle, type)
    if type == "showroom" then
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleNumberPlateText(vehicle, "SHOWROOM")

        SetVehicleEngineOn(vehicle, true, true, true)

    elseif type == "testdrive" then
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleNumberPlateText(vehicle, "TESTDRIV")

    end
end

-- █ █ ██▀ █▄█ █ ▄▀▀ █   ██▀   █▄▀ ██▀ ▀▄▀ ▄▀▀
-- ▀▄▀ █▄▄ █ █ █ ▀▄▄ █▄▄ █▄▄   █ █ █▄▄  █  ▄██
CL.GiveVehicleKeys = function(vehicle, plate)
    if GetResourceState('qs-vehiclekeys') ~= 'missing' then
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        exports['qs-vehiclekeys']:GiveKeys(plate, model)
    end
    if GetResourceState('wasabi_carlock') ~= 'missing' then
        exports['wasabi_carlock']:GiveKey(plate)
    end
    if GetResourceState('qb-vehiclekeys') ~= 'missing' then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end

end

CL.RemoveVehicleKeys = function(vehicle, plate)
    if GetResourceState('qs-vehiclekeys') ~= 'missing' then
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        exports['qs-vehiclekeys']:RemoveKeys(plate, model)
    end
    if GetResourceState('wasabi_carlock') ~= 'missing' then
        exports['wasabi_carlock']:RemoveKey(plate)
    end
    if GetResourceState('qb-vehiclekeys') ~= 'missing' then
        TriggerEvent("qb-vehiclekeys:client:RemoveKeys", plate)
    end

end

-- █▀ █ █ ██▀ █  
-- █▀ ▀▄█ █▄▄ █▄▄
CL.SetVehicleFuel = function(vehicle, plate)
    if GetResourceState('LegacyFuel') ~= 'missing' then
        exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
    end
    if GetResourceState('ox_fuel') ~= 'missing' then
        Entity(vehicle).state.fuel = 100.0
    end
    if GetResourceState('ND_Fuel') ~= 'missing' then
        exports['ND_Fuel']:SetFuel(vehicle, 100.0)
    end
    if GetResourceState('FRFuel') ~= 'missing' then
        exports['FRFuel']:setFuel(vehicle, 100.0)
    end
    if GetResourceState('cdn-fuel') ~= 'missing' then
        exports['cdn-fuel']:SetFuel(vehicle, 100.0)
    end
    
end

RegisterCommand('checkvehicles', function()
    local storeData = Config.Stores['PDM']
    for vehicle, _ in pairs(storeData.vehicles) do
        print(vehicle, IsModelInCdimage(vehicle))
        if not IsModelInCdimage(vehicle) then
            print('Vehicle not found: ', vehicle)
        end
    end
end, false)