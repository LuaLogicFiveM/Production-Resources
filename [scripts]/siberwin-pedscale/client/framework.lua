local resourceName = GetCurrentResourceName()

local function autoLoadScale()
    if not Config.AutoApplyOnSpawn then
        return
    end

    local Database = exports[resourceName]:getDatabase()
    local isScaling = exports[resourceName]:getScalingState()

    if not Database then
        return
    end

    if not isScaling then
        Database.loadPlayerScale(function(savedScale, savedWeight)
            if savedScale and savedScale ~= 1.0 then
                exports[resourceName]:sendLocalizedNotification(
                    'success',
                    'notification_framework_loading',
                    'notification_framework_title',
                    4000,
                    { scale = tostring(savedScale) }
                )
                Wait(1000)
                exports[resourceName]:startScale(savedScale, savedWeight or 1.0)
            end
        end)
    end
end

AddEventHandler('playerSpawned', function()
    CreateThread(function()
        Wait(2000)
        autoLoadScale()
    end)
end)

RegisterNetEvent('esx:playerLoaded', function(playerData)
    Wait(1500)
    autoLoadScale()
end)

RegisterNetEvent('esx:onPlayerSpawn', function()
    Wait(1000)
    autoLoadScale()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1500)
    autoLoadScale()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local isScaling = exports[resourceName]:getScalingState()
    if isScaling then
        exports[resourceName]:stopScale()
    end
end)

RegisterNetEvent('vRP:playerSpawn', function()
    Wait(1500)
    autoLoadScale()
end)

AddEventHandler('baseevents:onPlayerKilled', function()
end)

AddEventHandler('baseevents:onPlayerWasted', function()
end)

AddEventHandler('baseevents:enteringVehicle', function()
    local isScaling = exports[resourceName]:getScalingState()
    local currentScale = exports[resourceName]:getCurrentScale()

    if isScaling and currentScale and currentScale ~= 1.0 then
        Wait(100)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) then
            local currentWeight = exports[resourceName]:getCurrentWeight()
            exports[resourceName]:applyScaleToEntity(ped, currentScale, currentWeight)
        end
    end
end)

AddEventHandler('baseevents:leftVehicle', function()
    local isScaling = exports[resourceName]:getScalingState()
    local currentScale = exports[resourceName]:getCurrentScale()

    if isScaling and currentScale and currentScale ~= 1.0 then
        Wait(100)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) then
            local currentWeight = exports[resourceName]:getCurrentWeight()
            exports[resourceName]:applyScaleToEntity(ped, currentScale, currentWeight)
        end
    end
end)

RegisterNetEvent('hospital:client:Revive')
AddEventHandler('hospital:client:Revive', function()
    Wait(2000)
    autoLoadScale()
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
    Wait(2000)
    autoLoadScale()
end)

CreateThread(function()
    Wait(10000)

    if not Config.AutoApplyOnSpawn then
        return
    end

    local Database = exports[resourceName]:getDatabase()
    local isScaling = exports[resourceName]:getScalingState()

    if Database and not isScaling then
        autoLoadScale()
    end

    while true do
        Wait(30000)

        if not Config.AutoApplyOnSpawn then
            break
        end

        Database = exports[resourceName]:getDatabase()
        isScaling = exports[resourceName]:getScalingState()
        local currentScale = exports[resourceName]:getCurrentScale()

        if Database and not isScaling and currentScale and currentScale ~= 1.0 then
            Database.loadPlayerScale(function(savedScale, savedWeight)
                if savedScale and savedScale ~= 1.0 then
                    exports[resourceName]:sendLocalizedNotification(
                        'warning',
                        'notification_periodic_reapply',
                        'notification_periodic_title',
                        3000,
                        { scale = tostring(savedScale) }
                    )
                    exports[resourceName]:startScale(savedScale, savedWeight or 1.0)
                end
            end)
        end
    end
end)

CreateThread(function()
    local lastModel = GetEntityModel(PlayerPedId())

    while true do
        Wait(1000)

        if not Config.AutoApplyOnSpawn then
            Wait(5000)
            goto continue
        end

        local currentModel = GetEntityModel(PlayerPedId())
        if currentModel ~= lastModel then
            lastModel = currentModel
            exports[resourceName]:sendLocalizedNotification(
                'info',
                'notification_model_changed',
                'notification_scale_system_title',
                3000
            )

            local isScaling = exports[resourceName]:getScalingState()
            local currentScale = exports[resourceName]:getCurrentScale()

            if isScaling and currentScale and currentScale ~= 1.0 then
                Wait(1000)
                local ped = PlayerPedId()
                if DoesEntityExist(ped) then
                    local currentWeight = exports[resourceName]:getCurrentWeight()
                    exports[resourceName]:applyScaleToEntity(ped, currentScale, currentWeight)
                end
            end
        end

        ::continue::
    end
end)
