if Config.Core == "ESX" then
    RegisterNetEvent(Config.PlayerSetJob)
    AddEventHandler(Config.PlayerSetJob, function(PLAYER_JOB)
        PlayerData.job = PLAYER_JOB
    end)
elseif Config.Core == "QB-Core" then
    RegisterNetEvent(Config.PlayerSetJob)
    AddEventHandler(Config.PlayerSetJob, function(PLAYER_JOB)
        PlayerData.job = PLAYER_JOB
    end)
end

function DrawText3D(x, y, z, text) -- This is the function used when using Config.Use3DText
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextDropShadow()
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

CL = {}


CL.AllowOpenTuningMenu = function(ped, vehicle)
    --[[
        In this function, you can enter your dependencies to run the tuning menu
        
        If the player is not to be able to run the menu,
        you must make return false, otherwise return true

        EXAMPLE:
        
        if not vehicle then
            return Config.Notification("You cannot run the menu...", 4000, 'error')
        end

    ]]
        
    return true
end


-- ██████╗ ██████╗  ██████╗  ██████╗ ██████╗ ███████╗███████╗███████╗    ██████╗  █████╗ ██████╗ 
-- ██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗
-- ██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝█████╗  ███████╗███████╗    ██████╔╝███████║██████╔╝
-- ██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══╝  ╚════██║╚════██║    ██╔══██╗██╔══██║██╔══██╗
-- ██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║███████╗███████║███████║    ██████╔╝██║  ██║██║  ██║
-- ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
CL.ProgressBar = function(label, time)
    exports['progressbar']:Progress({
        name = 'installation',
        label = label,
        duration = time,
        canCancel = false,
        controlDisables = {
            disableMouse = false,
            disableMovement = true,
            disableCarMovement = true,
            disableCombat = true,
        }
    })
end


-- ███████╗██╗  ██╗██╗██╗     ██╗         ██████╗  █████╗ ██████╗ 
-- ██╔════╝██║ ██╔╝██║██║     ██║         ██╔══██╗██╔══██╗██╔══██╗
-- ███████╗█████╔╝ ██║██║     ██║         ██████╔╝███████║██████╔╝
-- ╚════██║██╔═██╗ ██║██║     ██║         ██╔══██╗██╔══██║██╔══██╗
-- ███████║██║  ██╗██║███████╗███████╗    ██████╔╝██║  ██║██║  ██║
-- ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
CL.Skillbar = function(cb)
    local finished = exports["tgiann-skillbar"]:taskBar(3000)
    cb(finished)
end


-- ████████╗ █████╗ ██████╗  ██████╗ ███████╗████████╗
-- ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝
--    ██║   ███████║██████╔╝██║  ███╗█████╗     ██║   
--    ██║   ██╔══██║██╔══██╗██║   ██║██╔══╝     ██║   
--    ██║   ██║  ██║██║  ██║╚██████╔╝███████╗   ██║   
--    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
CL.Target = function(type, data, cb)
    if type == 'part' then
        if Config.TargetResource == 'ox_target' then
            return exports['ox_target']:addBoxZone({
                coords = vec(data.coords.x, data.coords.y, data.coords.z-0.5),
                size = data.size and data.size.xyz or vec(1.2, 1.2, 1.8),
                debug = false,
                useZ = true,
                rotation = data.vehicleHeading or 0.0,
                options = {
                    {
                        name = 'tuning-part',
                        icon = data.icon,
                        label = data.label,
                        onSelect = function()
                            cb()
                        end,
                        distance = 1.2,
                    }
                }
            })
        elseif Config.TargetResource == 'qb-target' then
            local uniqueName = 'vms_tuning-'..math.random(1000000, 9999999999)
            exports['qb-target']:AddBoxZone(uniqueName, vec(data.coords.x, data.coords.y, data.coords.z), data.size and data.size.x or 1.2, data.size and data.size.y or 1.2, {
                name = uniqueName,
                heading = data.vehicleHeading and data.vehicleHeading - 90.0 or 0.0,
                debugPoly = false,
                minZ = data.coords.z - (data.size and data.size.y or 1.2),
                maxZ = data.coords.z + (data.size and data.size.y or 1.2),
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
                distance = 1.2,
            })
            return uniqueName
        else
            warn('You need to prepare CL.Target for the target system')
        end
    elseif type == 'remove-zone' then
        if Config.TargetResource == 'ox_target' then
            exports['ox_target']:removeZone(data)
        elseif Config.TargetResource == 'qb-target' then
            exports['qb-target']:RemoveZone(data)
        else
            warn('You need to prepare CL.Target for the target system')
        end
    else
        if Config.TargetResource == 'ox_target' then
            exports['ox_target']:addBoxZone({
                coords = vec(data.coords.x, data.coords.y, data.coords.z-0.5),
                size = vec(1.8, 1.8, 1.8),
                debug = false,
                useZ = true,
                rotation = 0.0,
                distance = 1.2,
                options = {
                    {
                        name = 'tuning-bossmenu',
                        icon = data.icon,
                        label = data.label,
                        groups = data.job,
                        onSelect = function()
                            cb()
                        end,
                        canInteract = data.canInteract
                    }
                }
            })
        elseif Config.TargetResource == 'qb-target' then
            local uniqueName = 'tuning-bossmenu-'..math.random(1000000, 9999999999)
            exports['qb-target']:AddBoxZone(uniqueName, vec(data.coords.x, data.coords.y, data.coords.z), 1.8, 1.8, {
                name = uniqueName,
                heading = 0.0,
                debugPoly = false,
                minZ = data.coords.z - 1.8,
                maxZ = data.coords.z + 1.8,
            }, {
                options = {
                    {
                        num = 1,
                        icon = data.icon,
                        label = data.label,
                        job = data.job,
                        action = function()
                            cb()
                        end,
                        canInteract = data.canInteract
                    }
                },
                distance = 1.2,
            })
        else
            warn('You need to prepare CL.Target for the target system')
        end
    end
end


-- ███████╗ ██████╗ ██╗   ██╗███╗   ██╗██████╗     ███████╗███████╗███████╗███████╗ ██████╗████████╗███████╗
-- ██╔════╝██╔═══██╗██║   ██║████╗  ██║██╔══██╗    ██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔════╝
-- ███████╗██║   ██║██║   ██║██╔██╗ ██║██║  ██║    █████╗  █████╗  █████╗  █████╗  ██║        ██║   ███████╗
-- ╚════██║██║   ██║██║   ██║██║╚██╗██║██║  ██║    ██╔══╝  ██╔══╝  ██╔══╝  ██╔══╝  ██║        ██║   ╚════██║
-- ███████║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝    ███████╗██║     ██║     ███████╗╚██████╗   ██║   ███████║
-- ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝     ╚══════╝╚═╝     ╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝
CL.PlayInstallationSoundEffect = function(part, fileName)
    if not Config.UseInstallationSoundEffects then;return;end;
    if not Config.PartsInstallationSoundEffects[part] then;return;end;
    if not Config.PartsInstallationSoundEffects[part].use then;return;end;

    local xsound = GetResourceState('xsound') == 'started'
    local mx_surround = GetResourceState('mx-surround') == 'started'
    local interactSound = GetResourceState('InteractSound') == 'started' or GetResourceState('interactSound') == 'started' or GetResourceState('interact-sound') == 'started'

    if xsound or mx_surround or interactSound then
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, Config.PartsInstallationSoundEffects[part].fileName, Config.PartsInstallationSoundEffects[part].volume)

    end
end


--  ██████╗ ██╗   ██╗███████╗███████╗████████╗██╗ ██████╗ ███╗   ██╗    ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ██╔═══██╗██║   ██║██╔════╝██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██║   ██║██║   ██║█████╗  ███████╗   ██║   ██║██║   ██║██╔██╗ ██║    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║▄▄ ██║██║   ██║██╔══╝  ╚════██║   ██║   ██║██║   ██║██║╚██╗██║    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ╚██████╔╝╚██████╔╝███████╗███████║   ██║   ██║╚██████╔╝██║ ╚████║    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
--  ╚══▀▀═╝  ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
CL.CustomQuestionMenu = function(requesterId, cache)
    local question = exports['vms_notify']:Question(
        "PARTS INSTALLATION REQUEST", 
        ("Do you want to accept a request to install parts for a vehicle from player %s"):format(requesterId),
        '#4287f5', 
        'fa-solid fa-screwdriver-wrench'
    )
    Citizen.Await(question)
    if question == 'y' then -- vms_notify question export return 'y' when player accept and 'n' when player reject
        TriggerServerEvent("vms_tuning:acceptTuneRequest", requesterId, cache)
    else
        TriggerServerEvent("vms_tuning:rejectTuneRequest", requesterId)
    end
end


-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
CL.GetClosestPlayer = function()
    if Config.Core == "ESX" then
        return ESX.Game.GetClosestPlayer(GetEntityCoords(PlayerPedId()), 6.0) -- ESX
    elseif Config.Core == "QB-Core" then
        return QBCore.Functions.GetClosestPlayer(GetEntityCoords(PlayerPedId())) -- QB-Core
    end
end

CL.GetClosestPlayers = function()
    if Config.Core == "ESX" then
        local playerInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
        return playerInArea
    elseif Config.Core == "QB-Core" then
        local playerInArea = QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 5.0)
        return playerInArea
    end
end

CL.getPlayerJob = function(type)
    if Config.Core == "ESX" then
        if type == "table" and PlayerData.job then
            return PlayerData.job
        end
        if type == "name" and PlayerData.job.name then
            return PlayerData.job.name
        end
        if type == "grade_name" and PlayerData.job.grade_name then
            return PlayerData.job.grade_name
        end
    elseif Config.Core == "QB-Core" then
        if type == "table" and PlayerData.job then
            return PlayerData.job
        end
        if type == "name" and PlayerData.job.name then
            return PlayerData.job.name
        end
        if type == "grade_name" and PlayerData.job.grade.name then
            return PlayerData.job.grade.name
        end
    end
    return nil
end

CL.IsEmployee = function(jobName)
    if Config.Core == "ESX" then
        return PlayerData.job.name == jobName
    elseif Config.Core == "QB-Core" then
        return PlayerData.job.name == jobName
    end
end

CL.IsManager = function(jobName, tuningId)
    local managerGrades = Config.TuningPoints[tuningId].manager_grades
    
    if Config.Core == "ESX" then
        if PlayerData.job.name ~= jobName then
            return false
        end
        
        if type(managerGrades) == 'table' then
            for _, grade in ipairs(managerGrades) do
                if PlayerData.job.grade_name == grade then
                    return true
                end
            end
        else
            return PlayerData.job.grade_name == managerGrades
        end
    elseif Config.Core == "QB-Core" then
        if PlayerData.job.name ~= jobName then
            return false
        end

        if type(managerGrades) == 'table' then
            for _, grade in ipairs(managerGrades) do
                if PlayerData.job.grade.name == grade then
                    return true
                end
            end
        else
            return PlayerData.job.grade.name == managerGrades
        end
        
    end
end

CL.IsBoss = function(jobName, tuningId)
    local bossGrades = Config.TuningPoints[tuningId].boss_grades
    if Config.Core == "ESX" then
        if PlayerData.job.name ~= jobName then
            return false
        end

        if type(bossGrades) == 'table' then
            for _, grade in ipairs(bossGrades) do
                if PlayerData.job.grade_name == grade then
                    return true
                end
            end
        else
            return PlayerData.job.grade_name == bossGrades
        end
        
    elseif Config.Core == "QB-Core" then
        if PlayerData.job.name ~= jobName then
            return false
        end

        if type(bossGrades) == 'table' then
            for _, grade in ipairs(bossGrades) do
                if PlayerData.job.grade.name == grade then
                    return true
                end
            end
        else
            return PlayerData.job.grade.name == bossGrades
        end

    end
end

CL.IsAllowedCityhall = function(jobName, tuningId)
    local allowed = {}
    local options = Config.TuningPoints[tuningId].cityhall_grades
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

CL.IsPlayerOnDuty = function()
    if Config.Core == "ESX" then
        return true
    elseif Config.Core == "QB-Core" then
        return PlayerData.job.onduty
    end
end

CL.GetEmployees = function(cb, jobName)
    if Config.Core == "ESX" then
        ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)
            cb(employees)
        end, jobName)

        -- local employees = lib.callback.await('esx_society:getEmployees', false, jobName) -- OX_LIB ESX_SOCIETY
        -- cb(employees)

    elseif Config.Core == "QB-Core" then
        QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(employees)
            cb(employees)
        end, jobName)
        
    end
end

CL.getVehiclePrice = function(vehicle, vehicleClass)
    for model, price in pairs(Config.Vehicles) do
        if GetEntityModel(vehicle) == GetHashKey(model) then
            return price
        end
    end
    if Config.VehiclesPricesByClass[vehicleClass] then
        return Config.VehiclesPricesByClass[vehicleClass]
    end
    return nil
end

CL.UpdatedVehicle = function(vehicle, lastProperties, newProperties)
    -- This function is executed only if the vehicle is present in the database and it has been tuned
    if GetResourceState('AdvancedParking') ~= 'missing' then
        exports["AdvancedParking"]:UpdateVehicle(vehicle)
    end
    
end


-- ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗    ██╗  ██╗███████╗██╗   ██╗███████╗
-- ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
-- ██║   ██║█████╗  ███████║██║██║     ██║     █████╗      █████╔╝ █████╗   ╚████╔╝ ███████╗
-- ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--  ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ██║  ██╗███████╗   ██║   ███████║
--   ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝
CL.GiveVehicleKeys = function(vehicle, plate)
    if GetResourceState('qs-vehiclekeys') ~= 'missing' then
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
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


-- █▄ ▄█ █ ▄▀▀ ▄▀▀ █ ▄▀▄ █▄ █ ▄▀▀
-- █ ▀ █ █ ▄██ ▄██ █ ▀▄▀ █ ▀█ ▄██
CL.OnMissionVehicle = function(vehicle)
    -- OnMissionVehicle: the function is called on the NPC vehicle you will be repairing.
    if GetResourceState('t1ger_keys') ~= 'missing' then
        exports['t1ger_keys']:SetVehicleLocked(vehicle, 0)
    end
    
end