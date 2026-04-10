local currentScale = 1.0
local currentWeight = 1.0
local SCRIPT_VERSION = "1.0.1"

local playerScales = {}
local currentLocale = {}
local isWeaponDrawn = false
local savedScale = 1.0
local savedWeight = 1.0
local lastWeaponState = nil
local weaponScaleThread = nil
local cache = cache or {
    ped = PlayerPedId()
}

CreateThread(function()
    while true do
        cache.ped = PlayerPedId()
        Wait(1000)
    end
end)

local lang = Config.Language or "en"

if lang == "tr" then
    currentLocale = Locale.tr
elseif lang == "es" then
    currentLocale = Locale.es
elseif lang == "de" then
    currentLocale = Locale.de
elseif lang == "fr" then
    currentLocale = Locale.fr
elseif lang == "it" then
    currentLocale = Locale.it
elseif lang == "pl" then
    currentLocale = Locale.pl
elseif lang == "ru" then
    currentLocale = Locale.ru
elseif lang == "ar" then
    currentLocale = Locale.ar
elseif lang == "bg" then
    currentLocale = Locale.bg
elseif lang == "cs" then
    currentLocale = Locale.cs
elseif lang == "el" then
    currentLocale = Locale.el
elseif lang == "fi" then
    currentLocale = Locale.fi
elseif lang == "he" then
    currentLocale = Locale.he
elseif lang == "hi" then
    currentLocale = Locale.hi
elseif lang == "hr" then
    currentLocale = Locale.hr
elseif lang == "hu" then
    currentLocale = Locale.hu
elseif lang == "id" then
    currentLocale = Locale.id
elseif lang == "ja" then
    currentLocale = Locale.ja
elseif lang == "ko" then
    currentLocale = Locale.ko
elseif lang == "nl" then
    currentLocale = Locale.nl
elseif lang == "no" then
    currentLocale = Locale.no
elseif lang == "pt-br" then
    currentLocale = Locale["pt-br"]
elseif lang == "ro" then
    currentLocale = Locale.ro
elseif lang == "sv" then
    currentLocale = Locale.sv
elseif lang == "th" then
    currentLocale = Locale.th
elseif lang == "uk" then
    currentLocale = Locale.uk
else
    currentLocale = Locale.en
end

local function sendNotification(type, message, title, duration)
    if Config.Notification.sounds then
        if type == 'success' then
            PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", false)
        elseif type == 'error' then
            PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        elseif type == 'warning' then
            PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", false)
        else
            PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", false)
        end
    end

    SendNUIMessage({
        type = 'siberwin-pedscale-notification',
        action = 'showNotification',
        data = {
            type = type or 'info',
            message = message or '',
            title = title or '',
            duration = duration or Config.Notification.duration
        }
    })
end

local function sendLocalizedNotification(type, messageKey, titleKey, duration, replacements)
    local message = currentLocale[messageKey] or messageKey
    local title = currentLocale[titleKey] or titleKey

    if replacements then
        for key, value in pairs(replacements) do
            message = message:gsub('{' .. key .. '}', tostring(value))
            title = title:gsub('{' .. key .. '}', tostring(value))
        end
    end

    sendNotification(type, message, title, duration)
end

local pendingPermissionCallback = nil
local currentPermissionType = "none"

local function checkPermissionAndExecute(callback)
    pendingPermissionCallback = callback
    TriggerServerEvent('siberwin-pedscale:server:checkPermission')
end

RegisterNetEvent('siberwin-pedscale:client:permissionResult')
AddEventHandler('siberwin-pedscale:client:permissionResult', function(hasPermission, permissionType)
    currentPermissionType = permissionType or "none"
    if pendingPermissionCallback then
        if hasPermission then
            pendingPermissionCallback()
        else
            sendLocalizedNotification(
                'error',
                'notification_permission_denied_message',
                'notification_permission_denied_title',
                4000
            )
        end
        pendingPermissionCallback = nil
    end
end)

local tick = nil

local function norm(vector)
    local length = math.sqrt(vector.x^2 + vector.y^2 + vector.z^2)
    return length > 0 and vector3(vector.x/length, vector.y/length, vector.z/length) or vector3(0, 0, 0)
end

local function removePlayerScale(playerId)
    playerScales[playerId] = nil
end

local intervals = {}
local intervalId = 0

local function SetInterval(func, delay)
    intervalId = intervalId + 1
    local id = intervalId
    intervals[id] = {
        func = func,
        delay = delay or 0,
        lastRun = GetGameTimer()
    }
    return id
end

local function ClearInterval(id)
    if intervals[id] then
        intervals[id] = nil
        return true
    end
    return false
end

CreateThread(function()
    while true do
        local currentTime = GetGameTimer()
        for id, interval in pairs(intervals) do
            if currentTime - interval.lastRun >= interval.delay then
                interval.func()
                interval.lastRun = currentTime
            end
        end
        Wait(0)
    end
end)

local function changeEntitySize(ped, heightScale, widthScale)
    if not DoesEntityExist(ped) then return end

    local forward, right, upVector, position = GetEntityMatrix(ped)

    local adjustedWidthScale = Config.WeightEnabled and heightScale * widthScale or heightScale

    local forwardNorm = norm(forward) * adjustedWidthScale
    local rightNorm   = norm(right) * adjustedWidthScale
    local upNorm      = norm(upVector) * heightScale

    local entitySpeed             = GetEntitySpeed(ped)
    local entityHeightAboveGround = GetEntityHeightAboveGround(ped)

    local adjustedZ               = (entitySpeed <= 0 and entityHeightAboveGround < 2) and (entityHeightAboveGround - heightScale) or (GetEntityUprightValue(ped) - heightScale)

    TaskLookAtEntity(ped, ped, 1, 2048, 3)

    SetEntityMatrix(ped,
        forwardNorm.x, forwardNorm.y, forwardNorm.z,
        rightNorm.x, rightNorm.y, rightNorm.z,
        upNorm.x, upNorm.y, upNorm.z,
        position.x, position.y, (position.z - adjustedZ)
    )
end

local saveCurrentScale, restoreSavedScale, applyWeaponScale, startScale, stopScale

local function getPlayerWeaponHash()
    local ped = cache.ped or PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(ped)
    return weaponHash
end

local function isPlayerDrawingWeapon()
    local ped = cache.ped or PlayerPedId()
    if IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) or
       IsEntityPlayingAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 3) or
       GetPedConfigFlag(ped, 78, true) then
        return true
    end
    return false
end

local function hasWeaponEquipped()
    local weaponHash = getPlayerWeaponHash()
    return weaponHash ~= GetHashKey("WEAPON_UNARMED")
end

local function checkWeaponState()
    local ped = cache.ped or PlayerPedId()

    local isArmed = IsPedArmed(ped, 7)
    local hasWeapon = hasWeaponEquipped()
    local isDrawing = isPlayerDrawingWeapon()

    local currentWeaponState = isArmed or hasWeapon or isDrawing

    if currentWeaponState ~= lastWeaponState then
        if currentWeaponState and not isWeaponDrawn then
            saveCurrentScale()
            applyWeaponScale()
            isWeaponDrawn = true
        elseif not currentWeaponState and isWeaponDrawn then
            restoreSavedScale()
            isWeaponDrawn = false
        end
        lastWeaponState = currentWeaponState
    end
end

saveCurrentScale = function()
    savedScale = currentScale
    savedWeight = currentWeight
end

applyWeaponScale = function()
    isScaling = false
    if scaleThread then
        scaleThread = nil
    end
    if weaponScaleThread then
        weaponScaleThread = nil
    end

    weaponScaleThread = CreateThread(function()
        currentScale = 1.0
        currentWeight = 1.0

        local ped = cache.ped or PlayerPedId()
        if DoesEntityExist(ped) then
            changeEntitySize(ped, 1.0, 1.0)
        end

        Wait(3000)

        if isWeaponDrawn and (savedScale ~= 1.0 or savedWeight ~= 1.0) then
            currentScale = savedScale
            currentWeight = savedWeight

            local ped = cache.ped or PlayerPedId()
            if DoesEntityExist(ped) then
                changeEntitySize(ped, savedScale, savedWeight)
            end
        end

        weaponScaleThread = nil
    end)
end

local Database = {}

function Database.savePlayerScale(scale, weight)
    TriggerServerEvent('siberwin-pedscale:server:saveScale', scale, weight or 1.0)
end

function Database.loadPlayerScale(callback)
    local eventName = 'siberwin-pedscale:client:scaleLoaded'

    RegisterNetEvent(eventName)
    AddEventHandler(eventName, function(scale, weight)
        callback(scale, weight or 1.0)
    end)

    TriggerServerEvent('siberwin-pedscale:server:loadScale')
end

local function applyScaleToEntity(ped, scale, weight)
    if not DoesEntityExist(ped) then return end
    if not scale then return end

    changeEntitySize(ped, scale, weight or 1.0)
end

local isScaling = false
local scaleThread = nil

CreateThread(function()
    while true do
        if isScaling and (currentScale ~= 1.0 or currentWeight ~= 1.0) then
            local ped = PlayerPedId()
            if DoesEntityExist(ped) then
                changeEntitySize(ped, currentScale, currentWeight)
            end
        end
        Wait(Config.ScaleUpdateInterval or 0)
    end
end)

local function startScale(scale, weight)
    isScaling = true
    currentScale = scale
    currentWeight = weight or 1.0
    Database.savePlayerScale(scale, currentWeight)

    if scaleThread then
        scaleThread = nil
    end

    if scale ~= 1.0 or currentWeight ~= 1.0 then
        scaleThread = CreateThread(function()
            while isScaling and (currentScale ~= 1.0 or currentWeight ~= 1.0) do
                local ped = PlayerPedId()
                if DoesEntityExist(ped) then
                    applyScaleToEntity(ped, currentScale, currentWeight)
                end
                Wait(Config.ScaleUpdateInterval or 0)
            end
            scaleThread = nil
        end)
    end
end

local function stopScale()
    isScaling = false
    currentScale = 1.0
    currentWeight = 1.0
    if scaleThread then
        scaleThread = nil
    end
end

restoreSavedScale = function()
    if savedScale ~= 1.0 or savedWeight ~= 1.0 then
        startScale(savedScale, savedWeight)
    else
        stopScale()
    end
end

RegisterCommand(Config.Commands.scalePed, function()
    checkPermissionAndExecute(function()
        local titleSuffix = ""
        if currentPermissionType == "discord" then
            titleSuffix = " (Discord)"
        elseif currentPermissionType == "framework" then
            titleSuffix = " (Framework)"
        elseif currentPermissionType == "both" then
            titleSuffix = " (Discord + Framework)"
        end

        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'siberwin-pedscale',
            action = 'setVisible',
            data = {
                visible = true,
                currentScale = currentScale,
                currentWeight = currentWeight,
                minScale = Config.MinScale,
                maxScale = Config.MaxScale,
                scaleStep = Config.ScaleStep,
                weightEnabled = Config.WeightEnabled,
                minWeight = Config.MinWeight,
                maxWeight = Config.MaxWeight,
                weightStep = Config.WeightStep,
                locale = currentLocale,
                title = Config.Title .. titleSuffix,
                version = SCRIPT_VERSION,
                permissionType = currentPermissionType
            }
        })
    end)
end)

RegisterCommand(Config.Commands.resetScale, function()
    checkPermissionAndExecute(function()
        stopScale()
        Database.savePlayerScale(1.0, 1.0)
        sendLocalizedNotification(
            'success',
            'notification_scale_reset_message',
            'notification_scale_reset_title',
            3000
        )
    end)
end)

RegisterCommand(Config.Commands.setScale, function(source, args, rawCommand)
    checkPermissionAndExecute(function()
        if not args[1] then
            sendLocalizedNotification(
                'error',
                'notification_setscale_usage',
                'notification_error_title',
                4000
            )
            return
        end

        local scale = tonumber(args[1])
        if not scale then
            sendLocalizedNotification(
                'error',
                'notification_setscale_invalid_number',
                'notification_error_title',
                4000
            )
            return
        end

        if scale < Config.MinScale or scale > Config.MaxScale then
            sendLocalizedNotification(
                'error',
                'notification_setscale_out_of_range',
                'notification_error_title',
                4000,
                {
                    min = tostring(Config.MinScale),
                    max = tostring(Config.MaxScale),
                    scale = tostring(scale)
                }
            )
            return
        end

        scale = math.floor(scale / Config.ScaleStep + 0.5) * Config.ScaleStep
        scale = tonumber(string.format("%.1f", scale))

        if scale == 1.0 then
            stopScale()
            Database.savePlayerScale(1.0, currentWeight)
            sendLocalizedNotification(
                'success',
                'notification_scale_reset_message',
                'notification_scale_reset_title',
                3000
            )
        else
            startScale(scale, currentWeight)
            sendLocalizedNotification(
                'success',
                'notification_setscale_applied',
                'notification_setscale_applied_title',
                3000,
                { scale = tostring(scale) }
            )
        end
    end)
end)

RegisterCommand(Config.Commands.setWeight, function(source, args, rawCommand)
    if not Config.WeightEnabled then
        sendLocalizedNotification(
            'error',
            'Weight feature is disabled',
            'notification_error_title',
            4000
        )
        return
    end

    checkPermissionAndExecute(function()
        if not args[1] then
            sendLocalizedNotification(
                'error',
                'notification_setweight_usage',
                'notification_error_title',
                4000
            )
            return
        end

        local weight = tonumber(args[1])
        if not weight then
            sendLocalizedNotification(
                'error',
                'notification_setweight_invalid_number',
                'notification_error_title',
                4000
            )
            return
        end

        if weight < Config.MinWeight or weight > Config.MaxWeight then
            sendLocalizedNotification(
                'error',
                'notification_setweight_out_of_range',
                'notification_error_title',
                4000,
                {
                    min = tostring(Config.MinWeight),
                    max = tostring(Config.MaxWeight),
                    weight = tostring(weight)
                }
            )
            return
        end

        weight = math.floor(weight / Config.WeightStep + 0.5) * Config.WeightStep
        weight = tonumber(string.format("%.2f", weight))

        currentWeight = weight
        Database.savePlayerScale(currentScale, weight)
        sendLocalizedNotification(
            'success',
            'notification_setweight_applied',
            'notification_setweight_applied_title',
            3000,
            { weight = tostring(weight) }
        )
    end)
end)

RegisterCommand(Config.Commands.giveScaleMenu, function(source, args, rawCommand)
    if not args[1] then
        sendLocalizedNotification(
            'error',
            'notification_givescale_usage',
            'notification_error_title',
            4000
        )
        return
    end

    local targetId = tonumber(args[1])
    if not targetId then
        sendLocalizedNotification(
            'error',
            'notification_givescale_usage',
            'notification_error_title',
            4000
        )
        return
    end

    TriggerServerEvent('siberwin-pedscale:server:giveScaleMenu', targetId)
end)

RegisterCommand(Config.Commands.checkScale, function()
    TriggerServerEvent('siberwin-pedscale:server:getScaleRecords')
end)

CreateThread(function()
    Wait(3000)
    TriggerServerEvent('siberwin-pedscale:server:requestInitialSync')
end)

RegisterNetEvent('siberwin-pedscale:client:openMenuByAdmin')
AddEventHandler('siberwin-pedscale:client:openMenuByAdmin', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'siberwin-pedscale',
        action = 'setVisible',
        data = {
            visible = true,
            currentScale = currentScale,
            currentWeight = currentWeight,
            minScale = Config.MinScale,
            maxScale = Config.MaxScale,
            scaleStep = Config.ScaleStep,
            weightEnabled = Config.WeightEnabled,
            minWeight = Config.MinWeight,
            maxWeight = Config.MaxWeight,
            weightStep = Config.WeightStep,
            locale = currentLocale,
            title = Config.Title .. " (Admin)",
            adminMode = true,
            version = SCRIPT_VERSION,
            permissionType = "admin"
        }
    })
end)

RegisterNetEvent('siberwin-pedscale:client:showNotification')
AddEventHandler('siberwin-pedscale:client:showNotification', function(data)
    sendLocalizedNotification(
        data.type,
        data.messageKey,
        data.titleKey,
        data.duration or 4000,
        data.replacements
    )
end)

RegisterNetEvent('siberwin-pedscale:client:scaleRecordsLoaded')
AddEventHandler('siberwin-pedscale:client:scaleRecordsLoaded', function(records)
    if records and #records > 0 then
        SendNUIMessage({
            type = 'siberwin-pedscale',
            action = 'updateRecords',
            data = {
                records = records
            }
        })
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'siberwin-checkscale',
        action = 'setVisible',
        data = {
            visible = true,
            records = records,
            locale = currentLocale
        }
    })
end)

exports('getDatabase', function()
    return Database
end)

exports('getScalingState', function()
    return isScaling
end)

exports('getCurrentScale', function()
    return currentScale
end)

exports('getCurrentWeight', function()
    return currentWeight
end)

exports('startScale', function(scale, weight)
    return startScale(scale, weight)
end)

exports('stopScale', function()
    return stopScale()
end)

exports('applyScaleToEntity', function(ped, scale, weight)
    return applyScaleToEntity(ped, scale, weight)
end)

exports('sendNotification', function(type, message, title, duration)
    return sendNotification(type, message, title, duration)
end)

exports('getPlayerScales', function()
    return playerScales
end)

exports('getStateBagData', function()
    return {stateName = 'pedScale', isStateBagEnabled = true}
end)

exports('changeEntitySize', function(ped, heightScale, widthScale)
    return changeEntitySize(ped, heightScale, widthScale)
end)

exports('sendLocalizedNotification', function(type, messageKey, titleKey, duration, replacements)
    return sendLocalizedNotification(type, messageKey, titleKey, duration, replacements)
end)

exports('getCurrentScale', function()
    return currentScale
end)

exports('getCurrentWeight', function()
    return currentWeight
end)

exports('changeEntitySize', function(ped, heightScale, widthScale)
    return changeEntitySize(ped, heightScale, widthScale)
end)

CreateThread(function()
    while true do
        checkWeaponState()
        Wait(25)
    end
end)

CreateThread(function()
    while true do
        if not tick then
            if next(playerScales) then
                tick = SetInterval(function()
                    local playerCoords = GetEntityCoords(cache.ped or PlayerPedId())
                    for playerId, data in pairs(playerScales) do
                        if NetworkIsPlayerActive(GetPlayerFromServerId(playerId)) and (data.height ~= 1.0 or data.weight ~= 1.0) then
                            local ped = GetPlayerPed(GetPlayerFromServerId(playerId))
                            if DoesEntityExist(ped) then
                                local distance = #(playerCoords - GetEntityCoords(ped))
                                if distance < (Config.MaxScaleDistance or 100) then
                                    changeEntitySize(ped, data.height, data.weight)
                                end
                            end
                        else
                            removePlayerScale(playerId)
                        end
                    end
                end, Config.ScaleUpdateInterval or 0)
            end
        elseif not next(playerScales) then
            tick = ClearInterval(tick)
        end
        Wait(25)
    end
end)

RegisterNetEvent('siberwin-pedscale:client:syncScale')
AddEventHandler('siberwin-pedscale:client:syncScale', function(playerId, height, weight)
    playerScales[playerId] = {
        height = height,
        weight = weight,
        timestamp = GetGameTimer()
    }

    CreateThread(function()
        local targetPlayer = GetPlayerFromServerId(playerId)
        if targetPlayer and targetPlayer ~= 0 then
            local ped = GetPlayerPed(targetPlayer)
            if DoesEntityExist(ped) then
                changeEntitySize(ped, height, weight)
            end
        end
    end)
end)

AddStateBagChangeHandler('pedScale', nil, function(bagName, key, value)
    local serverId = tonumber(bagName:match("player:(%d+)"))

    if not serverId or serverId == GetPlayerServerId(PlayerId()) then
        return
    end

    if value and (value.height or value.weight) then
        local height = value.height or 1.0
        local weight = value.weight or 1.0

        if height ~= 1.0 or weight ~= 1.0 then
            playerScales[serverId] = {
                height = height,
                weight = weight,
                timestamp = value.timestamp or GetGameTimer()
            }

            CreateThread(function()
                Wait(10)
                local targetPlayer = GetPlayerFromServerId(serverId)
                if targetPlayer and targetPlayer ~= 0 then
                    local ped = GetPlayerPed(targetPlayer)
                    if DoesEntityExist(ped) then
                        changeEntitySize(ped, height, weight)
                    end
                end
            end)
        else
            removePlayerScale(serverId)
        end
    else
        removePlayerScale(serverId)
    end
end)

RegisterNUICallback('playSliderSound', function(data, cb)
    if Config.Notification.sounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    end
    cb('ok')
end)

RegisterNUICallback('playApplySound', function(data, cb)
    if Config.Notification.sounds then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    end
    cb('ok')
end)

RegisterNUICallback('playResetSound', function(data, cb)
    if Config.Notification.sounds then
        PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    end
    cb('ok')
end)

RegisterNUICallback('playCloseSound', function(data, cb)
    if Config.Notification.sounds then
        PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    end
    cb('ok')
end)

RegisterNUICallback('applyScale', function(data, cb)
    local scale = tonumber(data.scale)
    local weight = tonumber(data.weight) or currentWeight

    if scale then
        scale = tonumber(math.floor(scale * 10) / 10)

        if Config.WeightEnabled and weight then
            weight = tonumber(math.floor(weight * 100) / 100)
        end

        if scale == 1.0 and weight == 1.0 then
            stopScale()
            Database.savePlayerScale(1.0, 1.0)
        else
            startScale(scale, weight)
        end
    end

    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb('ok')
end)

RegisterNUICallback('previewScale', function(data, cb)
    local scale = tonumber(data.scale)
    local weight = tonumber(data.weight) or currentWeight

    if scale then
        currentScale = scale
        if Config.WeightEnabled and weight then
            currentWeight = weight
        end
        local ped = PlayerPedId()
        if DoesEntityExist(ped) then
            applyScaleToEntity(ped, scale, currentWeight)
        end
    end
    cb('ok')
end)

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb('ok')
end)

RegisterNUICallback('deleteScaleRecord', function(data, cb)
    local identifier = data.identifier
    if identifier then
        TriggerServerEvent('siberwin-pedscale:server:deleteScaleRecord', identifier)
    end
    cb('ok')
end)

RegisterNUICallback('closeCheckScale', function(data, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb('ok')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    stopScale()
    

    for id, _ in pairs(intervals) do
        ClearInterval(id)
    end
    
   
    playerScales = {}
end)
