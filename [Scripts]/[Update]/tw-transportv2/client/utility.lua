local RequestId = 0
local serverRequests = {}
targetLoaded = false
showBar = false
TriggerServerCallback = function(eventName, ...)
    local prom = promise.new()

    local requestId = RequestId
    serverRequests[requestId] = function(...)
        prom:resolve(...)
    end
    TriggerServerEvent(_event('triggerServerCallback'), eventName, requestId, GetInvokingResource() or "unknown", ...)
    RequestId = RequestId + 1


    return Citizen.Await(prom)
end

RegisterNetEvent(_event('serverCallback'), function(requestId, invoker, ...)
    if not serverRequests[requestId] then
        return print(("[^1ERROR^7] Server Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.")
            :format(requestId, invoker))
    end

    serverRequests[requestId](...)
    serverRequests[requestId] = nil
end)

jobData = {
    jobname = nil,
    job_grade_name = nil,
    job_grade = nil,
    job_label = nil
}

local Player = {}
local Loaded = false

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    Wait(1000)
    TriggerServerEvent(_event('server:loadData'))
    Player = {
        Group = {
            [xPlayer.job.name] = xPlayer.job.grade,
        },
    }

    Loaded = true
    TriggerEvent('interact:groupsChanged', Player.Group)
end)


RegisterNetEvent('esx:onPlayerLogout', function()
    Player = table.wipe(Player)

    TriggerEvent('interact:groupsChanged', {})
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    Wait(1000)
    TriggerServerEvent(_event('server:loadData'))
end)

AddEventHandler("vRP:Active", function()
    Wait(1000)
    TriggerServerEvent(_event('server:loadData'))
end)

-- Standalone framework player loaded event
if Config.Framework == 'standalone' then
    CreateThread(function()
        Wait(1000)
        TriggerServerEvent(_event('server:loadData'))
    end)
end

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Player = table.wipe(Player)

    TriggerEvent('interact:groupsChanged', {})
end)


RegisterNetEvent('esx:setPlayerData', function(key, value)
    if not Loaded or GetInvokingResource() ~= 'es_extended' then return end

    if key ~= 'job' then return end

    Player.Group = { [value.name] = value.grade }

    TriggerEvent('interact:groupsChanged', Player.Group)
end)


CreateThread(function()
    -- Standalone framework bypass
    if Config.Framework == 'standalone' then
        Core = true
    else
        Core, Config.Framework = GetCore()
    end

    spawnPed()
    createBlips()
    SetPlayerJob()
end)

AddEventHandler('onResourceStop', function(resource)
    if (GetCurrentServerEndpoint() == nil) then
        return
    end
    if (resource == GetCurrentResourceName()) then
        TriggerServerEvent(_event('server:loadData'))
        ClearPedTasks(PlayerPedId())
    end
end)


function SetPlayerJob()
    while Core == nil do
        Wait(0)
    end
    Wait(500)
    while not nuiLoaded do
        Wait(50)
    end
    WaitPlayer()

    -- Standalone framework (no job system)
    if Config.Framework == 'standalone' then
        jobData.jobname = "transport"
        jobData.job_grade_name = "Transporter"
        jobData.job_grade = 0
    elseif Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local PlayerData = Core.GetPlayerData()
        jobData.jobname = PlayerData.job.name
        jobData.job_grade_name = PlayerData.job.label
        jobData.job_grade = tonumber(PlayerData.job.grade)
        Player = {
            Group = {},
        }

        TriggerEvent('interact:groupsChanged', Player.Group)
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local PlayerData = Core.Functions.GetPlayerData()
        jobData.jobname = PlayerData["job"].name
        jobData.job_grade_name = PlayerData["job"].label
        jobData.job_grade = PlayerData["job"].grade.level
        Player = {
            Group = {
                [PlayerData.job.name] = PlayerData.job.grade.level,
                [PlayerData.gang.name] = PlayerData.gang.grade.level
            },
            job = PlayerData.job.name,
            gang = PlayerData.gang.name,
        }
        TriggerEvent('interact:groupsChanged', Player.Group)
    elseif Config.Framework == 'vrp' then
        jobData.jobname = "transport"
        jobData.job_grade_name = "Transporter"
        jobData.job_grade = 0
    end
end

function WaitPlayer()
    -- Standalone framework (no player data waiting needed)
    if Config.Framework == 'standalone' then
        return
    elseif Config.Framework == "esx" or Config.Framework == 'oldesx' then
        while Core == nil do Wait(0) end
        while Core.GetPlayerData() == nil do Wait(0) end
        while Core.GetPlayerData().job == nil do Wait(0) end
    elseif Config.Framework == "qb" or Config.Framework == "oldqb" then
        while Core == nil do Wait(0) end
        while Core.Functions.GetPlayerData() == nil do Wait(0) end
        while Core.Functions.GetPlayerData().metadata == nil do Wait(0) end
    elseif Config.Framework == "vrp" then
        while Core == nil do Wait(0) end
        Wait(1000)
    end
end

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    Wait(1000)
    SetPlayerJob()
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(data)
    Wait(1000)
    SetPlayerJob()
end)

local blips = {}

function createBlips()
    if Config.Job['blip']['show'] then
        blips = AddBlipForCoord(tonumber(Config.Job['coords'].intreactionCoords.x),
            tonumber(Config.Job['coords'].intreactionCoords.y),
            tonumber(Config.Job['coords'].intreactionCoords.z))
        SetBlipSprite(blips, Config.Job['blip'].blipType)
        SetBlipCategory(blips, 2) -- 2: Places category
        SetBlipDisplay(blips, 4)
        SetBlipScale(blips, Config.Job['blip'].blipScale)
        SetBlipColour(blips, Config.Job['blip'].blipColor)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Job['blip'].blipName)
        EndTextCommandSetBlipName(blips)
    end
end

function canOpen()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        return false
    end
    if Config.Job['job'] then
        if Config.Job['job'] ~= 'all' and Config.Job['job'] ~= jobData.jobname then
            Config.sendNotification(Config.NotificationText['wrongjob'])
            return false
        end
    end
    return true
end

function spawnPed()
    if Config.Job.coords.ped then
        WaitForModel(Config.Job.coords.pedHash)
        local createNpc = CreatePed("PED_TYPE_PROSTITUTE", Config.Job.coords.pedHash, Config.Job.coords.pedCoords.x,
            Config.Job.coords.pedCoords.y, Config.Job.coords.pedCoords.z - 0.98, Config.Job.coords.pedHeading, false,
            false)
        FreezeEntityPosition(createNpc, true)
        SetEntityInvincible(createNpc, true)
        SetBlockingOfNonTemporaryEvents(createNpc, true)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

function SetBlipAttributes(blip, id)
    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 26)
    ShowNumberOnBlip(blip, id)
    SetBlipShowCone(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(base.resource .. " : " .. id)
    EndTextCommandSetBlipName(blip)
end

RegisterNetEvent(_event('openMenu'), function()
    if canOpen() then
        openJobMenu()
    end
end)

function WaitForModel(model)
    if not IsModelValid(model) then
        return
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
    end

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
end

activeOpenTriggerZone = nil

Citizen.CreateThread(function()
    Config.OpenTrigger = function(bool)
        if not bool then
            if Config.InteractionHandler == "qb-target" then
                exports['qb-target']:RemoveZone(base.resource .. "_1" .. 1)
            elseif Config.InteractionHandler == "ox-target" then
                if activeOpenTriggerZone then
                    exports.ox_target:removeZone(activeOpenTriggerZone)
                    activeOpenTriggerZone = nil
                end
            elseif Config.InteractionHandler == "drawtext" then
                Config.drawTextActive = false
            end
        else
            if Config.InteractionHandler == "ox-target" and activeOpenTriggerZone then
                exports.ox_target:removeZone(activeOpenTriggerZone)
                activeOpenTriggerZone = nil
            elseif Config.InteractionHandler == "qb-target" and activeOpenTriggerZone then
                exports['qb-target']:RemoveZone(activeOpenTriggerZone)
                activeOpenTriggerZone = nil
            end

            if Config.InteractionHandler == "qb-target" then
                activeOpenTriggerZone = exports['qb-target']:AddBoxZone(base.resource .. "_1" .. 1,
                    vector3(Config.Job.coords.intreactionCoords.x,
                        Config.Job.coords.intreactionCoords.y,
                        Config.Job.coords.intreactionCoords.z), 1.5,
                    1.5,
                    {
                        name = base.resource .. "_1" .. 1,
                        debugPoly = false,
                        heading = -20,
                        minZ = Config.Job.coords.intreactionCoords.z - 2,
                        maxZ = Config.Job.coords.intreactionCoords.z + 2,
                    }, {
                        options = {
                            {
                                type = "client",
                                event = _event('openMenu'),
                                icon = 'fas fa-credit-card',
                                label = Locales[Config.Locale]['openJobMenu'],
                            },
                        },
                        distance = 2
                    })
            elseif Config.InteractionHandler == "ox-target" then
                activeOpenTriggerZone = exports.ox_target:addBoxZone({
                    coords = vector3(Config.Job.coords.intreactionCoords.x, Config.Job.coords.intreactionCoords.y,
                        Config.Job.coords.intreactionCoords.z),
                    size = vec3(1.5, 1.5, 2.0),
                    rotation = -20,
                    debug = false,
                    options = {
                        {
                            name = base.resource .. "_1",
                            icon = 'fas fa-credit-card',
                            label = Locales[Config.Locale]['openJobMenu'],
                            event = _event('openMenu'),
                            distance = 2.0
                        }
                    }
                })
            elseif Config.InteractionHandler == "scriptbase" then
                local interactionId = _event('client:openMenu')
                exports[base.resource]:AddInteraction({
                    coords = vector3(Config.Job.coords.intreactionCoords.x, Config.Job.coords.intreactionCoords.y,
                        Config.Job.coords.intreactionCoords.z + 0.5),
                    distance = 3.0,
                    interactDst = 3.0,
                    id = interactionId,
                    name = interactionId,
                    options = {
                        {
                            label = Locales[Config.Locale]['openJobMenu'],
                            action = function(entity, coords, args)
                                if canOpen() then
                                    openJobMenu()
                                end
                            end,

                            canInteract = function(entity, coords, args)
                                return true
                            end
                        }
                    }
                })
            elseif Config.InteractionHandler == "drawtext" then
                Config.drawTextActive = true
                Citizen.CreateThread(function()
                    while Config.drawTextActive do
                        local wait = 1500
                        local playerPed = PlayerPedId()
                        local coords = GetEntityCoords(playerPed)
                        local distance = #(coords - Config.Job.coords.intreactionCoords)
                        if distance < 1.5 then
                            wait = 0
                            DrawText3D(Config.Job.coords.intreactionCoords.x,
                                Config.Job.coords.intreactionCoords.y,
                                Config.Job.coords.intreactionCoords.z + 1.0,
                                Locales[Config.Locale]['pedDrawText'])
                            if IsControlJustReleased(0, 38) then
                                if canOpen() then
                                    openJobMenu()
                                end
                            end
                        end
                        Citizen.Wait(wait)
                    end
                end)
            end
        end
    end
end)

Citizen.CreateThread(function()
    local sleep = 2000
    while true do
        Citizen.Wait(sleep)
        local isJobing = CoopDataClient and CoopDataClient.roomSetting and true or false
        if isJobing then
            sleep = 0
            local playerPed = PlayerPedId()
            if GetIsTaskActive(playerPed, 160) and isPlacingObject then
                ClearPedTasks(playerPed)
                ClearPedSecondaryTask(playerPed)
                Config.sendNotification(Config.NotificationText['cantentervehicle'])
            end
        end
    end
end)

function showProgressBar(title, time)
    if showBar then return end
    showBar = true
    NuiMessage('showProgressBar', { label = title, time = time })

    Citizen.SetTimeout(time * 1000, function()
        showBar = false
    end)
end

function LoadAnimation(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
end

function PlayEffect(dict, particleName, entity, off, rot, time, cb)
    CreateThread(function()
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Wait(0)
        end
        UseParticleFxAssetNextCall(dict)
        Wait(10)
        local particleHandle = StartParticleFxLoopedOnEntity(particleName, entity, off.x, off.y, off.z, rot.x, rot.y,
            rot.z, 1.0)
        SetParticleFxLoopedColour(particleHandle, 0, 255, 0, 0)
        Wait(time)
        StopParticleFxLooped(particleHandle, false)
        cb()
    end)
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function GetVehicles()
    return GetGamePool('CVehicle')
end

function GetVehiclesInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end
    return nearbyEntities
end

function v2(coords) return vec3(coords.x, coords.y, 0.0) end

function CreateProp(modelHash, ...)
    if not IsModelInCdimage(modelHash) then
        return
    end
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local obj = CreateObject(modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    return obj
end

function GiveJobClothing()
    if Config.ChangeClothesSystem then
        local gender
        if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
            gender = 'male'
        elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
            gender = 'female'
        else
            return
        end
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerEvent("esx_skin:setLastSkin", skin)
        end)

        local clothes = Config.JobClothes[gender]
        if clothes then
            for _, cloth in ipairs(clothes) do
                for part, id in pairs(cloth) do
                    if part ~= "texture" then
                        ChangeClothes(part, id, cloth.texture)
                    end
                end
            end
        end
    end
end

function ChangeClothes(key, value, texture)
    local playerPed = PlayerPedId()
    value = tonumber(value)
    texture = tonumber(texture)

    if key == 'jacket' then
        SetPedComponentVariation(playerPed, 11, value, texture, 2)
    end
    if key == 'shirt' then
        SetPedComponentVariation(playerPed, 8, value, texture, 2)
    end
    if key == 'arms' then
        SetPedComponentVariation(playerPed, 3, value, texture, 2)
    end
    if key == 'legs' then
        SetPedComponentVariation(playerPed, 4, value, texture, 2)
    end
    if key == 'shoes' then
        SetPedComponentVariation(playerPed, 6, value, texture, 2)
    end
    if key == 'mask' then
        SetPedComponentVariation(playerPed, 1, value, texture, 2)
    end
    if key == 'chain' then
        SetPedComponentVariation(playerPed, 7, value, texture, 2)
    end
    if key == 'decals' then
        SetPedComponentVariation(playerPed, 10, value, texture, 2)
    end
    if key == 'helmet' then
        SetPedPropIndex(playerPed, 0, value, texture, 2)
    end
    if key == 'glasses' then
        SetPedPropIndex(playerPed, 1, value, texture, 2)
    end
    if key == 'watches' then
        SetPedPropIndex(playerPed, 6, value, texture, 2)
    end
    if key == 'bracelets' then
        SetPedPropIndex(playerPed, 7, value, texture, 2)
    end
end

function RefreshSkin()
    Config.RefreshSkin()
end

--- Yields the current thread until a non-nil value is returned by the function.
---@generic T
---@param cb fun(): T?
---@param errMessage string?
---@param timeout? number | false Error out after `~x` ms. Defaults to 1000, unless set to `false`.
---@return T
---@async
function waitForClient(cb, errMessage, timeout)
    local value = cb()
    if value ~= nil then return value end

    if timeout or timeout == nil then
        if type(timeout) ~= 'number' then timeout = 1000 end
    end

    local startTime = timeout and GetGameTimer()

    while value == nil do
        Wait(0)

        if timeout then
            local elapsed = GetGameTimer() - startTime
            if elapsed > timeout then
                return error(('%s (waited %.1fms)'):format(errMessage or 'failed to resolve callback', elapsed), 2)
            end
        end

        value = cb()
    end

    return value
end

local isPlayAnim = false
function PlayAnim(dataName)
    local playerPed = PlayerPedId()
    if dataName == 'openBox' then
        showProgressBar(Locales[Config.Locale]['openBoxProgress'], 2.9)
        LoadAnimation('mini@repair')
        TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_ped', 8.0, -8.0, -1, 2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(3000)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    elseif dataName == 'placeFurnite' then
        showProgressBar(Locales[Config.Locale]['placeFurniteProgress'], 0.9)
        LoadAnimation('anim@mp_fireworks')
        TaskPlayAnim(playerPed, 'anim@mp_fireworks', 'place_firework_box2', 8.0, -8.0, -1, 2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(3000)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if isPlacingObject then
            if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
                carryObject()
            end
        end
    end
end)

function carryObject()
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        RequestAnimDict("anim@heists@box_carry@")
        Citizen.Wait(100)
    end

    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 4.0, 4.0, -1, 51, 0, false, false, false)
end

function LoadParticleLib(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Citizen.Wait(0)
        end
    end
    UseParticleFxAssetNextCall(dict)
end

function CreateCamera()
    local invehicle = IsPedInAnyVehicle(PlayerPedId(), false)
    if invehicle then return end

    local defaultCoords = Config.Job.coords.pedCoords
    local defaultHeading = Config.Job.coords.pedHeading
    local offset = vector3(2.1, 1.6, 0.2)
    local coords = defaultCoords + offset

    RenderScriptCams(true, true, 500, true, true)
    DestroyCam(cam, false)

    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 5.0, 0.0, defaultHeading - 180.0)
        SetCamNearClip(cam, 0.1)
        SetCamFarClip(cam, 1000.0)
        SetCamFov(cam, 20.0)
        SetCamDofFnumberOfLens(cam, 24.0)
        SetCamDofFocalLengthMultiplier(cam, 50.0)
    end
end

--[[Citizen.CreateThread(function()
    local wait = 1000
    while true do
        Citizen.Wait(wait)
        if openUI or camera then
            wait = 0
            SetEntityAlpha(PlayerPedId(), 0, false)
            SetLocalPlayerInvisibleLocally(true)
        end
    end
end)]]

function ExitCamera()
    SetEntityAlpha(PlayerPedId(), 255, false)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(cam, false)
    ClearFocus()
    cam = nil
end

function CreateFinishCamera()
    local invehicle = IsPedInAnyVehicle(PlayerPedId(), false)
    if invehicle then return end
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -0.3, -2.0, 0.0)

    RenderScriptCams(true, true, 500, true, true)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 5.0, 0.0, GetEntityHeading(PlayerPedId()))
        SetCamNearClip(cam, 0.1)
        SetCamFarClip(cam, 1000.0)
        SetCamFov(cam, 40.0)
        SetCamDofFnumberOfLens(camera, 24.0)
        SetCamDofFocalLengthMultiplier(camera, 50.0)
        local heading = GetEntityHeading(PlayerPedId())
        SetEntityHeading(PlayerPedId(), heading + 180.0)
    end
end

CreateThread(function()
    if Config.InteractionHandler == "ox-target" then
        AddModelToTarget = function(model, data)
            exports.ox_target:addModel(model, {
                name = data.name,
                event = data.event,
                icon = data.icon,
                label = data.label,
                canInteract = data.handler
            })
        end
        AddCoordsToTarget = function(coords, data)
            exports.ox_target:addSphereZone({
                coords = coords,
                radius = data.radius or 2.0,
                options = {
                    {
                        name = data.name,
                        event = data.event,
                        icon = data.icon,
                        label = data.label,
                        canInteract = data.handler
                    }
                }
            })
        end
        addBoxToTarget = function(coords, data)
            exports.ox_target:addBoxZone({
                coords = coords,
                radius = data.radius or 2.0,
                options = {
                    {
                        name = data.name,
                        event = data.event,
                        icon = data.icon,
                        label = data.label,
                        canInteract = data.handler
                    }
                }
            })
        end
        addBoxLocalEntity = function(entities, options)
            exports.ox_target:addLocalEntity(entities, options)
        end
        removeBoxLocalEntity = function(entities)
            exports.ox_target:removeLocalEntity(entities)
        end
        -- Network Entity Functions for ox-target
        addNetworkEntityTarget = function(netId, options)
            if not NetworkDoesNetworkIdExist(netId) then return nil end

            -- ox-target options format düzenlemesi
            local formattedOptions = {}
            for i, option in ipairs(options) do
                formattedOptions[i] = {
                    name = option.label,
                    icon = option.icon,
                    label = option.label,
                    onSelect = function(data)
                        -- ox-target'da entity'ye erişim için güvenli yöntem
                        local targetEntity = NetworkGetEntityFromNetworkId(netId) -- Network ID'den entity al
                        if type(data) == "table" then
                            targetEntity = data.entity or data.ent or targetEntity
                        end

                        if option.action and targetEntity then
                            option.action(targetEntity)
                        end
                    end,
                    canInteract = function(targetEntity, distance, coords, name, bone)
                        if option.canInteract then
                            return option.canInteract(targetEntity, distance, coords)
                        end
                        return true
                    end
                }
            end

            -- Network entity için addEntity kullan
            exports.ox_target:addEntity(netId, formattedOptions)
            return netId
        end
        removeNetworkEntityTarget = function(netId, interactionId)
            if not NetworkDoesNetworkIdExist(netId) then return end
            exports.ox_target:removeEntity(netId)
        end
        -- Coordinate-based Interaction Functions for ox-target
        addCoordinateInteraction = function(data)
            local zoneName = data.name or data.id
            local zoneId = exports.ox_target:addSphereZone({
                name = zoneName,
                coords = data.coords,
                radius = data.distance or 2.0,
                debug = Config.Debug or false,
                options = {
                    {
                        name = data.options[1].label,
                        icon = data.options[1].icon,
                        label = data.options[1].label,
                        onSelect = function(targetData)
                            if data.options[1].action then
                                data.options[1].action()
                            end
                        end,
                        canInteract = function(entity, distance, coords, name, bone)
                            if data.options[1].canInteract then
                                return data.options[1].canInteract()
                            end
                            return true
                        end
                    }
                }
            })

            -- Zone ID'sini döndür, bu sayede doğru zone'u silebiliriz
            return zoneId
        end
        removeCoordinateInteraction = function(interactionId)
            if interactionId and interactionId ~= true then
                -- ox-target'da removeZone fonksiyonu zone ID'si veya zone name'i ile çalışır
                if type(interactionId) == "number" then
                    -- Zone ID ile silme
                    exports.ox_target:removeZone(interactionId)
                else
                    -- Zone name ile silme
                    exports.ox_target:removeZone(interactionId)
                end
            end
        end
    elseif Config.InteractionHandler == "qb-target" then
        AddModelToTarget = function(model, data)
            exports['qb-target']:AddTargetModel({ model }, {
                options = {
                    {
                        event = data.event,
                        icon = data.icon,
                        label = data.label,
                        canInteract = data.handler
                    },
                },
                distance = 2.5,
            })
        end
        AddCoordsToTarget = function(coords, data)
            exports['qb-target']:AddCircleZone(data.name, coords, data.radius or 2.0, {
                name = data.name,
                useZ = true,
            }, {
                options = {
                    {
                        event = data.event,
                        icon = data.icon,
                        label = data.label,
                        canInteract = data.handler
                    }
                },
                distance = data.radius or 2.0
            })
        end
        addBoxToTarget = function(coords, data)
            exports['qb-target']:AddBoxZone(data.name, coords, data.radius or 2.0, {
                name = data.name,
                useZ = true,
            }, {
                options = {
                    {
                        event = data.event,
                        icon = data.icon,
                        label = data.label,
                        canInteract = data.handler
                    }
                },
                distance = data.radius or 2.0
            })
        end
        addBoxLocalEntity = function(entities, options)
            for key, option in pairs(options) do
                option.action = option.onSelect
            end
            exports['qb-target']:AddTargetEntity(entities, {
                options = options,
            })
        end
        removeBoxLocalEntity = function(entities)
            exports['qb-target']:RemoveTargetEntity(entities)
        end
        -- Network Entity Functions for qb-target
        addNetworkEntityTarget = function(netId, options)
            if not NetworkDoesNetworkIdExist(netId) then return nil end
            local entity = NetworkGetEntityFromNetworkId(netId)
            if not DoesEntityExist(entity) then return nil end

            -- qb-target options format düzenlemesi
            local formattedOptions = {}
            for i, option in ipairs(options) do
                formattedOptions[i] = {
                    type = "client",
                    icon = option.icon,
                    label = option.label,
                    action = option.action,
                    canInteract = option.canInteract
                }
            end

            exports['qb-target']:AddTargetEntity(entity, {
                options = formattedOptions,
                distance = 2.5
            })
            return entity
        end
        removeNetworkEntityTarget = function(netId, interactionId)
            if not NetworkDoesNetworkIdExist(netId) then return end
            local entity = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(entity) then
                exports['qb-target']:RemoveTargetEntity(entity)
            end
        end
        -- Coordinate-based Interaction Functions for qb-target
        addCoordinateInteraction = function(data)
            local zoneName = data.name or data.id
            exports['qb-target']:AddCircleZone(zoneName, data.coords, data.distance or 2.0, {
                name = zoneName,
                useZ = true,
                debugPoly = Config.Debug or false,
            }, {
                options = {
                    {
                        type = "client",
                        icon = data.options[1].icon,
                        label = data.options[1].label,
                        action = function()
                            if data.options[1].action then
                                data.options[1].action()
                            end
                        end,
                        canInteract = function()
                            if data.options[1].canInteract then
                                return data.options[1].canInteract()
                            end
                            return true
                        end
                    }
                },
                distance = data.distance or 2.0
            })
            return zoneName
        end
        removeCoordinateInteraction = function(interactionId)
            if interactionId and interactionId ~= true then
                -- qb-target'da RemoveZone fonksiyonu zone name'i ile çalışır
                exports['qb-target']:RemoveZone(interactionId)
            end
        end
    elseif Config.InteractionHandler == "scriptbase" then
        addBoxLocalEntity = function(entities, options)
            if not options or type(options) ~= 'table' or #options == 0 then
                if Config.Debug then
                    print(Locales[Config.Locale]['debugOptionsParameterError'])
                end
                return
            end

            for key, option in pairs(options) do
                option.action = option.onSelect
            end

            exports[base.resource]:AddLocalEntityInteraction({
                entity = entities,
                offset = vector3(0.0, 0.0, 0.1),
                distance = options.distance or 1.5,
                interactDst = options.distance or 1.5,
                id = _event('mission' .. entities),
                name = 'interactionName' .. entities,
                options = options,
                ignoreLos = true,
                groups = false
            })
        end
        removeBoxLocalEntity = function(entities)
            local entityId = _event('mission' .. entities)
            exports[base.resource]:RemoveLocalEntityInteraction(entities, entityId)
        end
        -- Network Entity Functions for scriptbase (same as before)
        addNetworkEntityTarget = function(netId, options)
            return exports[base.resource]:AddEntityInteraction({
                netId = netId,
                offset = vector3(0.0, 0.0, 0.5),
                distance = 2.5,
                interactDst = 2.5,
                options = options,
                ignoreLos = true
            })
        end
        removeNetworkEntityTarget = function(netId, interactionId)
            exports[base.resource]:RemoveEntityInteraction(netId, interactionId)
        end
        -- Coordinate-based Interaction Functions for scriptbase
        addCoordinateInteraction = function(data)
            local interactionId = exports[base.resource]:AddInteraction({
                coords = data.coords,
                distance = data.distance or 2.0,
                interactDst = data.interactDst or 2.0,
                id = data.id,
                name = data.name,
                options = data.options,
                ignoreLos = data.ignoreLos or true
            })

            -- Interaction ID'sini döndür
            return interactionId
        end

        removeCoordinateInteraction = function(interactionId)
            if interactionId and interactionId ~= true then
                -- scriptbase'de RemoveInteraction fonksiyonu interaction ID'si ile çalışır
                exports[base.resource]:RemoveInteraction(interactionId)
            end
        end
    end
    targetLoaded = true
end)

function TriggerCallback(name, data)
    local incomingData = false
    local status = 'UNKOWN'
    local counter = 0
    while Core == nil do
        Wait(0)
    end
    if Config.Framework == 'esx' then
        Core.TriggerServerCallback(name, function(payload)
            status = 'SUCCESS'
            incomingData = payload
        end, data)
    else
        Core.Functions.TriggerCallback(name, function(payload)
            status = 'SUCCESS'
            incomingData = payload
        end, data)
    end
    CreateThread(function()
        while incomingData == 'UNKOWN' do
            Wait(1000)
            if counter == 4 then
                status = 'FAILED'
                incomingData = false
                break
            end
            counter = counter + 1
        end
    end)

    while status == 'UNKOWN' do
        Wait(0)
    end
    return incomingData
end

Citizen.CreateThread(function()
    while true do
        local sleepTime = 1000
        Citizen.Wait(sleepTime)
        local StartJob = getStartJob()
        if StartJob then
            sleepTime = 0
            if isPlacingObject then
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
            end
        end
    end
end)

function ToggleVehicleDeliveryInteractionTransport(state)
    if state then
        local function setupDeliveryCoords()
            if CoopDataClient and CoopDataClient.roomSetting then
                if CoopDataClient.roomSetting.jobDeliverCoords then
                    local coords = CoopDataClient.roomSetting.jobDeliverCoords
                    -- vector3, vector4 veya tablo formatını destekle
                    if type(coords) == "vector3" then
                        return coords
                    elseif coords.x and coords.y and coords.z then
                        return vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z))
                    end
                elseif CoopDataClient.roomSetting.Mission and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords.truckCoords then
                    local coords = CoopDataClient.roomSetting.Mission.vehicleSpawnCoords.truckCoords
                    if type(coords) == "vector3" then
                        return coords
                    elseif coords.x and coords.y and coords.z then
                        return vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z))
                    end
                elseif jobDeliverCoords then
                    if type(jobDeliverCoords) == "vector3" then
                        return jobDeliverCoords
                    elseif jobDeliverCoords.x and jobDeliverCoords.y and jobDeliverCoords.z then
                        return vector3(tonumber(jobDeliverCoords.x), tonumber(jobDeliverCoords.y),
                            tonumber(jobDeliverCoords.z))
                    end
                end
            end
            return nil
        end

        jobDeliverCoordsInteraction = setupDeliveryCoords()

        if Config.Debug then
            print("^3[DEBUG] jobDeliverCoordsInteraction: " .. tostring(jobDeliverCoordsInteraction) .. "^0")
        end

        if not jobDeliverCoordsInteraction then
            local attempts = 0
            local maxAttempts = 10

            while not jobDeliverCoordsInteraction and attempts < maxAttempts do
                Wait(1000)
                attempts = attempts + 1

                jobDeliverCoordsInteraction = setupDeliveryCoords()

                if attempts >= 5 and not jobDeliverCoordsInteraction and CoopDataClient and CoopDataClient.roomSetting then
                    if Config.Job.coords.intreactionCoords then
                        jobDeliverCoordsInteraction = vector3(
                            Config.Job.coords.intreactionCoords.x,
                            Config.Job.coords.intreactionCoords.y,
                            Config.Job.coords.intreactionCoords.z
                        )
                        break
                    end
                end
            end

            if not jobDeliverCoordsInteraction then
                if Config.Debug then
                    print("^1[DEBUG] " .. Locales[Config.Locale]['debugVehicleDeliveryLocationNotFound'] .. "^0")
                end
                Config.sendNotification({
                    text = "Teslimat konumu bulunamadı! Lütfen görevi yeniden başlatın.",
                    type =
                    "error"
                })
                return false
            end
        end

        -- canInteract kontrol fonksiyonu
        local function canInteractWithDelivery()
            local vehicles = getVehicle("truck")

            local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if not currentVehicle or currentVehicle == 0 then return false end

            local currentPlate = GetVehicleNumberPlateText(currentVehicle)
            local isPlayerInRegisteredVehicle = false
            local allVehiclesInDeliveryZone = true

            -- TÜM ARAÇLARIN MESAFE KONTROLÜ - 15.0 mesafe
            local maxDeliveryDistance = 15.0
            local vehicleCount = #vehicles
            local checkedVehicles = 0

            for _, vehData in ipairs(vehicles) do
                if vehData.plate == currentPlate then
                    isPlayerInRegisteredVehicle = true
                end

                local veh = NetworkGetEntityFromNetworkId(vehData.netID)

                -- Eğer araç nil ise veya yoksa, teslimat yapılamaz
                if not veh or veh == 0 or not DoesEntityExist(veh) then
                    allVehiclesInDeliveryZone = false
                    if Config.Debug then
                        print("^1[DEBUG] Araç bulunamadı veya yüklenmedi! Plaka: " ..
                            vehData.plate .. " NetID: " .. vehData.netID .. "^0")
                    end
                    Config.sendNotification({
                        text =
                        "Tüm araçlar teslimat alanına getirilmeli! Bazı araçlar bulunamıyor.",
                        type = "error"
                    })
                    break
                else
                    -- Araç varsa mesafe kontrolü yap
                    local vehCoords = GetEntityCoords(veh)
                    local distance = #(vehCoords - vector3(jobDeliverCoordsInteraction.x, jobDeliverCoordsInteraction.y, jobDeliverCoordsInteraction.z))
                    checkedVehicles = checkedVehicles + 1

                    if distance > maxDeliveryDistance then
                        allVehiclesInDeliveryZone = false
                        if Config.Debug then
                            print("^1[DEBUG] Araç teslimat alanından uzakta! Plaka: " ..
                                vehData.plate .. " Mesafe: " .. math.floor(distance) .. "m^0")
                        end
                        Config.sendNotification({
                            text = "Tüm araçlar teslimat alanına " ..
                                maxDeliveryDistance ..
                                " metre yakınlıkta olmalı! (" .. math.floor(distance) .. "m uzakta)",
                            type =
                            "error"
                        })
                        break
                    end
                end
            end

            -- Tüm araçların kontrol edildiğinden emin ol
            if checkedVehicles ~= vehicleCount then
                allVehiclesInDeliveryZone = false
                if Config.Debug then
                    print("^1[DEBUG] Bazı araçlar kontrol edilemedi! Toplam: " ..
                        vehicleCount .. " Kontrol edilen: " .. checkedVehicles .. "^0")
                end
            end

            local serverID = GetPlayerServerId(PlayerId())
            local isOwner = false
            if tostring(CoopDataClient.roomSetting.ownersrc) == tostring(serverID) then
                isOwner = true
            end

            return isPlayerInRegisteredVehicle and allVehiclesInDeliveryZone and IsPedInAnyVehicle(PlayerPedId(), false) and
                not isInteracting and isOwner
        end

        -- Delivery action fonksiyonu
        local function performDeliveryAction()
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local plate = GetVehicleNumberPlateText(vehicle)
            local vehicles = getVehicle('truck')

            for _, vehData in ipairs(vehicles) do
                if vehData.plate == plate then
                    StartInteraction()
                    Config.sendNotification(Config.NotificationText['vehicleDeliveryCompleted'])
                    TriggerServerEvent(_event('server:LeaveVehicle'),
                        CoopDataClient.roomSetting.owneridentifier)
                    clearMissionData()
                    Citizen.SetTimeout(1000, function()
                        EndInteraction()
                    end)
                    break
                end
            end
        end

        VehicleDeliveryInteraction = true

        if Config.Debug then
            print("^2[DEBUG] DrawText3D delivery system başlatıldı^0")
            Config.sendNotification(Config.NotificationText['vehicleDeliverySetupComplete'])
        end

        -- DrawLine ve DrawText3D Thread
        Citizen.CreateThread(function()
            local corners = {
                vector3(-2.7, -7.5, 0.0),
                vector3(2.7, -7.5, 0.0),
                vector3(2.7, 7.5, 0.0),
                vector3(-2.7, 7.5, 0.0)
            }

            while VehicleDeliveryInteraction do
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local markerCoords = vector3(jobDeliverCoordsInteraction.x, jobDeliverCoordsInteraction.y,
                    jobDeliverCoordsInteraction.z)
                local dist = #(playerCoords - markerCoords)

                if dist < 50.0 then
                    local baseZ = jobDeliverCoordsInteraction.z - 0.5
                    local height = 3.0

                    local isInCorrectVehicle = false
                    if IsPedInAnyVehicle(playerPed, false) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        local plate = GetVehicleNumberPlateText(vehicle)
                        local vehicles = getVehicle('truck')

                        for _, vehData in ipairs(vehicles) do
                            if vehData.plate == plate then
                                isInCorrectVehicle = true
                                break
                            end
                        end
                    end

                    -- Renk ayarlaması güncellendi - 15 metre kontrolü
                    local r, g, b, a1, a2 = 255, 255, 255, 120, 60
                    if dist <= 15.0 and isInCorrectVehicle then
                        r, g, b = 0, 255, 0
                    elseif isInCorrectVehicle then
                        r, g, b = 255, 255, 0
                    end

                    -- Heading hesaplama
                    local heading = 0.0
                    if CoopDataClient and CoopDataClient.roomSetting then
                        if CoopDataClient.roomSetting.jobDeliverCoords and CoopDataClient.roomSetting.jobDeliverCoords.w then
                            heading = CoopDataClient.roomSetting.jobDeliverCoords.w
                        elseif CoopDataClient.roomSetting.Mission and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords.truckCoords and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords.truckCoords.w then
                            heading = CoopDataClient.roomSetting.Mission.vehicleSpawnCoords.truckCoords.w
                        end
                    end

                    local rad = math.rad(heading)
                    local sinH = math.sin(rad)
                    local cosH = math.cos(rad)

                    local transformedCorners = {}
                    for i, corner in ipairs(corners) do
                        local rotX = corner.x * cosH - corner.y * sinH
                        local rotY = corner.x * sinH + corner.y * cosH

                        transformedCorners[i] = vector3(
                            jobDeliverCoordsInteraction.x + rotX,
                            jobDeliverCoordsInteraction.y + rotY,
                            baseZ
                        )
                    end

                    -- Alt dikdörtgen
                    DrawLine(transformedCorners[1].x, transformedCorners[1].y, baseZ, transformedCorners[2].x,
                        transformedCorners[2].y, baseZ, r, g, b, a1)
                    DrawLine(transformedCorners[2].x, transformedCorners[2].y, baseZ, transformedCorners[3].x,
                        transformedCorners[3].y, baseZ, r, g, b, a1)
                    DrawLine(transformedCorners[3].x, transformedCorners[3].y, baseZ, transformedCorners[4].x,
                        transformedCorners[4].y, baseZ, r, g, b, a1)
                    DrawLine(transformedCorners[4].x, transformedCorners[4].y, baseZ, transformedCorners[1].x,
                        transformedCorners[1].y, baseZ, r, g, b, a1)

                    -- Üst dikdörtgen
                    DrawLine(transformedCorners[1].x, transformedCorners[1].y, baseZ + height, transformedCorners[2].x,
                        transformedCorners[2].y, baseZ + height, r, g, b, a2)
                    DrawLine(transformedCorners[2].x, transformedCorners[2].y, baseZ + height, transformedCorners[3].x,
                        transformedCorners[3].y, baseZ + height, r, g, b, a2)
                    DrawLine(transformedCorners[3].x, transformedCorners[3].y, baseZ + height, transformedCorners[4].x,
                        transformedCorners[4].y, baseZ + height, r, g, b, a2)
                    DrawLine(transformedCorners[4].x, transformedCorners[4].y, baseZ + height, transformedCorners[1].x,
                        transformedCorners[1].y, baseZ + height, r, g, b, a2)

                    -- Dikey çizgiler
                    DrawLine(transformedCorners[1].x, transformedCorners[1].y, baseZ, transformedCorners[1].x,
                        transformedCorners[1].y, baseZ + height, r, g, b, a2)
                    DrawLine(transformedCorners[2].x, transformedCorners[2].y, baseZ, transformedCorners[2].x,
                        transformedCorners[2].y, baseZ + height, r, g, b, a2)
                    DrawLine(transformedCorners[3].x, transformedCorners[3].y, baseZ, transformedCorners[3].x,
                        transformedCorners[3].y, baseZ + height, r, g, b, a2)
                    DrawLine(transformedCorners[4].x, transformedCorners[4].y, baseZ, transformedCorners[4].x,
                        transformedCorners[4].y, baseZ + height, r, g, b, a2)

                    -- DrawText3D sistemi - 5 metre içinde göster
                    if dist <= 5.0 and canInteractWithDelivery() then
                        DrawText3D(jobDeliverCoordsInteraction.x, jobDeliverCoordsInteraction.y,
                            jobDeliverCoordsInteraction.z + 1.5,
                            "~g~[E]~w~ " .. Locales[Config.Locale]['deliveryVehicle'])

                        -- E tuşu kontrolü
                        if IsControlJustReleased(0, 38) then -- E tuşu
                            performDeliveryAction()
                        end
                    elseif dist <= 5.0 then
                        DrawText3D(jobDeliverCoordsInteraction.x, jobDeliverCoordsInteraction.y,
                            jobDeliverCoordsInteraction.z + 1.5, "~r~" .. Locales[Config.Locale]['deliveryVehicle'])
                    end
                end

                Citizen.Wait(0)
            end
        end)

        -- Notification Thread (Interaction Refresh yerine)
        Citizen.CreateThread(function()
            local lastNotificationTime = 0
            while VehicleDeliveryInteraction do
                Citizen.Wait(5000)

                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    local vehCoords = GetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), false))
                    local distance = #(vehCoords - vector3(jobDeliverCoordsInteraction.x, jobDeliverCoordsInteraction.y, jobDeliverCoordsInteraction.z))
                    local currentTime = GetGameTimer()

                    if distance < 30.0 and distance > 15.0 and (currentTime - lastNotificationTime) > 10000 then
                        Config.sendNotification(Config.NotificationText['deliveryVehicleArea'])
                        lastNotificationTime = currentTime
                    end
                end
            end
        end)
    elseif not state and VehicleDeliveryInteraction then
        VehicleDeliveryInteraction = false
        if Config.Debug then
            print("^1[DEBUG] DrawText3D delivery system durduruldu^0")
        end
    end
end

-- =======================================
-- POLICE ALERT SYSTEM FUNCTIONS
-- =======================================
local policeAlertCooldown = {}
local lastPoliceAlert = 0

function isIllegalMission()
    if not CoopDataClient or not CoopDataClient.roomSetting then
        return false
    end

    return CoopDataClient.roomSetting.Mission and CoopDataClient.roomSetting.Mission.illegalMission == true
end

function getVehicleInfo(vehicle)
    if not DoesEntityExist(vehicle) then
        return {}
    end

    local info = {}

    if Config.PoliceAlert.vehicleDetails.includePlate then
        info.plate = GetVehicleNumberPlateText(vehicle)
    end

    if Config.PoliceAlert.vehicleDetails.includeModel then
        local modelHash = GetEntityModel(vehicle)
        info.model = GetDisplayNameFromVehicleModel(modelHash)
    end

    if Config.PoliceAlert.vehicleDetails.includeColor then
        local primaryColor, secondaryColor = GetVehicleColours(vehicle)
        info.firstColor = GetVehicleColourName(primaryColor)
        info.secondaryColor = GetVehicleColourName(secondaryColor)
    end

    if Config.PoliceAlert.vehicleDetails.includeSpeed then
        info.speed = math.floor(GetEntitySpeed(vehicle) * 3.6) -- km/h
    end

    if Config.PoliceAlert.vehicleDetails.includeDoorCount then
        info.doorCount = GetVehicleMaxNumberOfPassengers(vehicle)
    end

    if Config.PoliceAlert.vehicleDetails.includeHeading then
        info.heading = GetEntityHeading(vehicle)
        info.cardinalDirection = getCardinalDirectionFromHeading(info.heading)
    end

    return info
end

function getPlayerInfo()
    local info = {}

    if Config.PoliceAlert.vehicleDetails.includeGender then
        local playerPed = PlayerPedId()
        if GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01") then
            info.gender = Locales[Config.Locale]['genderMale']
        elseif GetEntityModel(playerPed) == GetHashKey("mp_f_freemode_01") then
            info.gender = Locales[Config.Locale]['genderFemale']
        else
            info.gender = Locales[Config.Locale]['genderUnknown']
        end
    end

    return info
end

function getLocationInfo(coords)
    local streetName, crossingRoad = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetNameStr = GetStreetNameFromHashKey(streetName)
    local crossingRoadStr = crossingRoad ~= 0 and GetStreetNameFromHashKey(crossingRoad) or nil

    local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)
    local zoneLabel = GetLabelText(zoneName)

    local locationString = streetNameStr
    if crossingRoadStr then
        locationString = locationString .. " / " .. crossingRoadStr
    end
    if zoneLabel and zoneLabel ~= "NULL" then
        locationString = locationString .. " (" .. zoneLabel .. ")"
    end

    return {
        street = streetNameStr,
        crossing = crossingRoadStr,
        zone = zoneLabel,
        fullLocation = locationString
    }
end

function getCardinalDirectionFromHeading(heading)
    if heading >= 315 or heading < 45 then
        return Locales[Config.Locale]['directionNorth']
    elseif heading >= 45 and heading < 135 then
        return Locales[Config.Locale]['directionEast']
    elseif heading >= 135 and heading < 225 then
        return Locales[Config.Locale]['directionSouth']
    elseif heading >= 225 and heading < 315 then
        return Locales[Config.Locale]['directionWest']
    end
    return Locales[Config.Locale]['directionUnknown']
end

function GetVehicleColourName(colorIndex)
    local colorKeys = {
        [0] = 'vehicleColorMetallicBlack',
        [1] = 'vehicleColorMetallicGraphiteBlack',
        [2] = 'vehicleColorMetallicBlackSteel',
        [3] = 'vehicleColorMetallicDarkSilver',
        [4] = 'vehicleColorMetallicSilver',
        [5] = 'vehicleColorMetallicBlueSilver',
        [6] = 'vehicleColorMetallicSteelGray',
        [7] = 'vehicleColorMetallicShadowSilver',
        [8] = 'vehicleColorMetallicStoneSilver',
        [9] = 'vehicleColorMetallicMidnightSilver',
        [10] = 'vehicleColorMetallicGunMetal',
        [11] = 'vehicleColorMetallicAnthraciteGray',
        [12] = 'vehicleColorMatteBlack',
        [13] = 'vehicleColorMatteGray',
        [14] = 'vehicleColorMatteLightGray',
        [15] = 'vehicleColorUtilBlack',
        [16] = 'vehicleColorUtilBlackPoly',
        [17] = 'vehicleColorUtilDarkSilver',
        [18] = 'vehicleColorUtilSilver',
        [19] = 'vehicleColorUtilGunMetal',
        [20] = 'vehicleColorUtilShadowSilver',
        [21] = 'vehicleColorWornBlack',
        [22] = 'vehicleColorWornGraphite',
        [23] = 'vehicleColorWornSilverGray',
        [24] = 'vehicleColorWornSilver',
        [25] = 'vehicleColorWornBlueSilver',
        [26] = 'vehicleColorWornShadowSilver',
        [27] = 'vehicleColorMetallicRed',
        [28] = 'vehicleColorMetallicTorinoRed',
        [29] = 'vehicleColorMetallicFormulaRed',
        [30] = 'vehicleColorMetallicBlazeRed',
        [31] = 'vehicleColorMetallicGracefulRed',
        [32] = 'vehicleColorMetallicGarnetRed',
        [33] = 'vehicleColorMetallicDesertRed',
        [34] = 'vehicleColorMetallicCabernetRed',
        [35] = 'vehicleColorMetallicCandyRed',
        [36] = 'vehicleColorMetallicSunriseOrange',
        [37] = 'vehicleColorMetallicClassicGold',
        [38] = 'vehicleColorMetallicOrange',
        [39] = 'vehicleColorMatteRed',
        [40] = 'vehicleColorMatteDarkRed',
        [41] = 'vehicleColorMatteOrange',
        [42] = 'vehicleColorMatteYellow',
        [43] = 'vehicleColorUtilRed',
        [44] = 'vehicleColorUtilBrightRed',
        [45] = 'vehicleColorUtilGarnetRed',
        [46] = 'vehicleColorWornRed',
        [47] = 'vehicleColorWornGoldRed',
        [48] = 'vehicleColorWornDarkRed',
        [49] = 'vehicleColorMetallicDarkGreen',
        [50] = 'vehicleColorMetallicRacingGreen',
        [51] = 'vehicleColorMetallicSeaGreen',
        [52] = 'vehicleColorMetallicOliveGreen',
        [53] = 'vehicleColorMetallicGreen',
        [54] = 'vehicleColorMetallicGasolineBlue',
        [55] = 'vehicleColorMatteLimeGreen',
        [56] = 'vehicleColorUtilDarkGreen',
        [57] = 'vehicleColorUtilGreen',
        [58] = 'vehicleColorWornDarkGreen',
        [59] = 'vehicleColorWornGreen',
        [60] = 'vehicleColorWornSeaGreen',
        [61] = 'vehicleColorMetallicMidnightBlue',
        [62] = 'vehicleColorMetallicDarkBlue',
        [63] = 'vehicleColorMetallicSaxonyBlue',
        [64] = 'vehicleColorMetallicBlue',
        [65] = 'vehicleColorMetallicMarinerBlue',
        [66] = 'vehicleColorMetallicHarborBlue',
        [67] = 'vehicleColorMetallicDiamondBlue',
        [68] = 'vehicleColorMetallicSurfBlue',
        [69] = 'vehicleColorMetallicNauticalBlue',
        [70] = 'vehicleColorMetallicBrightBlue',
        [71] = 'vehicleColorMetallicPurpleBlue',
        [72] = 'vehicleColorMetallicSpinnakerBlue',
        [73] = 'vehicleColorMetallicUltraBlue',
        [74] = 'vehicleColorMetallicBrightBlue',
        [75] = 'vehicleColorUtilDarkBlue',
        [76] = 'vehicleColorUtilMidnightBlue',
        [77] = 'vehicleColorUtilBlue',
        [78] = 'vehicleColorUtilSeaFoamBlue',
        [79] = 'vehicleColorUtilLightningBlue',
        [80] = 'vehicleColorUtilMauiBlue',
        [81] = 'vehicleColorUtilBrightBlue',
        [82] = 'vehicleColorMatteDarkBlue',
        [83] = 'vehicleColorMatteBlue',
        [84] = 'vehicleColorMatteMidnightBlue',
        [85] = 'vehicleColorWornDarkBlue',
        [86] = 'vehicleColorWornBlue',
        [87] = 'vehicleColorWornLightBlue',
        [88] = 'vehicleColorMetallicTaxiYellow',
        [89] = 'vehicleColorMetallicRacingYellow',
        [90] = 'vehicleColorMetallicBronze',
        [91] = 'vehicleColorMetallicChampagneYellow',
        [92] = 'vehicleColorMetallicPuebloBeige',
        [93] = 'vehicleColorMetallicDarkIvory',
        [94] = 'vehicleColorMetallicChestnutBrown',
        [95] = 'vehicleColorMetallicGoldBrown',
        [96] = 'vehicleColorMetallicLightBrown',
        [97] = 'vehicleColorMetallicStrawBeige',
        [98] = 'vehicleColorMetallicMossBrown',
        [99] = 'vehicleColorMetallicBistonBrown',
        [100] = 'vehicleColorMetallicBeechwood',
        [101] = 'vehicleColorMetallicDarkBeige',
        [102] = 'vehicleColorMetallicChocoOrange',
        [103] = 'vehicleColorMetallicBeachSand',
        [104] = 'vehicleColorMetallicSunBleechedSand',
        [105] = 'vehicleColorMetallicCream',
        [106] = 'vehicleColorUtilBrown',
        [107] = 'vehicleColorUtilMediumBrown',
        [108] = 'vehicleColorUtilLightBrown',
        [109] = 'vehicleColorMetallicWhite',
        [110] = 'vehicleColorMetallicFrostWhite',
        [111] = 'vehicleColorWornHoneyBeige',
        [112] = 'vehicleColorWornBrown',
        [113] = 'vehicleColorWornDarkBrown',
        [114] = 'vehicleColorWornStrawBeige',
        [115] = 'vehicleColorBrushedWhite',
        [116] = 'vehicleColorUtilOffWhite',
        [117] = 'vehicleColorUtilCream',
        [118] = 'vehicleColorUtilHoney',
        [119] = 'vehicleColorUtilBrown',
        [120] = 'vehicleColorUtilMediumBrown2',
        [121] = 'vehicleColorUtilLightBrown2',
        [122] = 'vehicleColorMetallicGold',
        [123] = 'vehicleColorMetallicOrange',
        [124] = 'vehicleColorMatteYellow',
        [125] = 'vehicleColorMatteGold',
        [126] = 'vehicleColorMatteOrange2',
        [127] = 'vehicleColorMatteRed2',
        [128] = 'vehicleColorMatteDarkRed2',
        [129] = 'vehicleColorMatteOiliveDrab',
        [130] = 'vehicleColorMatteForestGreen',
        [131] = 'vehicleColorMatteFoliageGreen',
        [132] = 'vehicleColorMatteOlive',
        [133] = 'vehicleColorMatteDesertBrown',
        [134] = 'vehicleColorMatteDesertTan',
        [135] = 'vehicleColorMatteFoliageGreen',
        [136] = 'vehicleColorDefaultAlloy',
        [137] = 'vehicleColorEpsilonBlue',
        [138] = 'vehicleColorPureGold',
        [139] = 'vehicleColorBrushedGold'
    }

    local colorKey = colorKeys[colorIndex]
    if colorKey and Locales[Config.Locale] and Locales[Config.Locale][colorKey] then
        return Locales[Config.Locale][colorKey]
    end
    return Locales[Config.Locale]['directionUnknown'] or "Unknown"
end

function checkPoliceAlertCooldown(alertType)
    local currentTime = GetGameTimer()
    local cooldownTime = Config.PoliceAlert.settings.cooldownMinutes * 60 * 1000 -- milisaniye

    if policeAlertCooldown[alertType] and (currentTime - policeAlertCooldown[alertType]) < cooldownTime then
        if Config.Debug then
            print("[DEBUG] Police Alert cooldown active:", alertType)
        end
        return false
    end

    policeAlertCooldown[alertType] = currentTime
    return true
end

function getOnlinePoliceCount()
    return TriggerServerCallback(_event('server:getPoliceCount'))
end

function isValidForPoliceAlert()
    if not Config.PoliceAlert.enabled then
        if Config.Debug then
            print("Police Alert sistemi deaktif")
        end
        return false
    end

    if not isIllegalMission() then
        if Config.Debug then
            print(Locales[Config.Locale]['debugIllegalMissionNot'])
        end
        return false
    end

    local policeCount = getOnlinePoliceCount()
    if policeCount < Config.PoliceAlert.settings.minPlayersForAlert then
        if Config.Debug then
            print("Yeterli polis yok:", policeCount, "/", Config.PoliceAlert.settings.minPlayersForAlert)
        end
        return false
    end

    if not Config.PoliceAlert.testMode then
        local chance = math.random(1, 100)
        if chance > Config.PoliceAlert.settings.alertChance then
            if Config.Debug then
                print(Locales[Config.Locale]['debugChanceNotHit'], chance, "/", Config.PoliceAlert.settings.alertChance)
            end
            return false
        end
    end

    return true
end

-- Ana polis bildirimi gönderme fonksiyonu
function sendPoliceAlert(alertType, additionalData)
    if not isValidForPoliceAlert() then
        return false
    end

    if not checkPoliceAlertCooldown(alertType) then
        return false
    end

    local alertConfig = Config.PoliceAlert.alerts[alertType]
    if not alertConfig then
        if Config.Debug then
            print(Locales[Config.Locale]['debugAlertConfigNotFound'], alertType)
        end
        return false
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    -- Temel alert verisi
    local alertData = {
        coords = coords,
        message = alertConfig.message,
        dispatchCode = alertConfig.code,
        description = alertConfig.description,
        priority = alertConfig.priority,
        sprite = alertConfig.sprite,
        color = alertConfig.color,
        length = alertConfig.length
    }

    -- Konum bilgileri
    local locationInfo = getLocationInfo(coords)
    alertData.locationInfo = locationInfo.fullLocation

    -- Araç bilgileri
    if vehicle and vehicle ~= 0 then
        local vehicleInfo = getVehicleInfo(vehicle)
        for key, value in pairs(vehicleInfo) do
            alertData[key] = value
        end
    end

    -- Oyuncu bilgileri
    local playerInfo = getPlayerInfo()
    for key, value in pairs(playerInfo) do
        alertData[key] = value
    end

    -- Ek veri ekle
    if additionalData then
        for key, value in pairs(additionalData) do
            alertData[key] = value
        end
    end

    -- Dispatch sistemine gönder
    local dispatchSystem = Config.PoliceAlert.dispatchSystem
    local dispatchConfig = Config.PoliceAlert.dispatchExports[dispatchSystem]

    if not dispatchConfig then
        if Config.Debug then
            print(Locales[Config.Locale]['debugDispatchSystemNotFound'], dispatchSystem)
        end
        return false
    end

    -- Sistem yüklü mü kontrol et
    if GetResourceState(dispatchConfig.resourceName) ~= "started" and dispatchSystem ~= "custom" then
        if Config.Debug then
            print(Locales[Config.Locale]['debugDispatchResourceNotLoaded'], dispatchConfig.resourceName)
        end
        return false
    end

    -- Bildirimi gönder
    pcall(function()
        dispatchConfig.customAlert(alertData)
    end)

    if Config.Debug then
        print(Locales[Config.Locale]['debugPoliceAlertSent'], alertType, json.encode(alertData))
    end

    lastPoliceAlert = GetGameTimer()
    return true
end

function sendIllegalTransportAlert()
    return sendPoliceAlert('illegalTransport')
end

-- Otomatik bildirim sistemi
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.PoliceAlert.settings.alertIntervalMinutes * 60 * 1000) -- dakika to milisaniye

        if isIllegalMission() and isValidForPoliceAlert() then
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle and vehicle ~= 0 then
                sendIllegalTransportAlert()
            end
        end
    end
end)

-- =======================================
-- POLICE SEARCH AND IMPOUND SYSTEM
-- =======================================


local policeSearchData = {}
local searchedVehicles = {}
local impoundedVehicles = {}
local activeSearchOperations = {}
local activeImpoundOperations = {}
local policeInteractions = {}

function isPlayerPolice()
    if not Config.PoliceAlert.policeSearch.enabled then
        return false
    end

    local Player = nil
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        if Core and Core.GetPlayerData then
            Player = Core.GetPlayerData()
            if Player and Player.job then
                for _, policeJob in ipairs(Config.PoliceAlert.policeSearch.policeJobs) do
                    if Player.job.name == policeJob then
                        return true
                    end
                end
            end
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        if Core and Core.Functions.GetPlayerData then
            Player = Core.Functions.GetPlayerData()
            if Player and Player.job then
                for _, policeJob in ipairs(Config.PoliceAlert.policeSearch.policeJobs) do
                    if Player.job.name == policeJob then
                        return true
                    end
                end
            end
        end
    end

    return false
end

function findNearbyIllegalTrucks(playerCoords, maxDistance)
    local nearbyTrucks = {}
    local playerServerId = GetPlayerServerId(PlayerId())



    local players = GetActivePlayers()


    for _, player in ipairs(players) do
        if player ~= PlayerId() then
            local targetPed = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)
            local targetServerId = GetPlayerServerId(player)
            if distance < 500.0 then
                local missionData = TriggerServerCallback(_event('server:getPlayerMissionData'), targetServerId)


                if missionData and missionData.isIllegal and missionData.vehicleNetIds then
                    for _, netId in ipairs(missionData.vehicleNetIds) do
                        local vehicle = NetToVeh(netId)
                        if DoesEntityExist(vehicle) then
                            local vehCoords = GetEntityCoords(vehicle)
                            local vehDistance = #(playerCoords - vehCoords)

                            if vehDistance <= maxDistance then
                                local plate = GetVehicleNumberPlateText(vehicle)
                                local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))


                                table.insert(nearbyTrucks, {
                                    vehicle = vehicle,
                                    netId = netId,
                                    plate = plate,
                                    model = model,
                                    distance = vehDistance,
                                    ownerServerId = targetServerId,
                                    ownerIdentifier = missionData.ownerIdentifier,
                                    coords = vehCoords
                                })
                            end
                        end
                    end
                end
            end
        end
    end

    return nearbyTrucks
end

function searchVehicle(vehicleData)
    local vehicle = vehicleData.vehicle
    local plate = vehicleData.plate

    if searchedVehicles[plate] then
        Config.sendNotification({ text = Config.PoliceAlert.policeSearch.searchResults.alreadySearched, type = "error" })
        return false
    end

    if activeSearchOperations[plate] then
        Config.sendNotification({ text = Config.PoliceAlert.policeSearch.searchResults.searchInProgress, type = "error" })
        return false
    end

    activeSearchOperations[plate] = true

    Config.sendNotification({ text = Config.PoliceAlert.policeSearch.searchResults.searching, type = "info" })
    showProgressBar(Locales[Config.Locale]['policeSearchProgressBar'],
        Config.PoliceAlert.policeSearch.searchSettings.searchTime / 1000)

    local playerPed = PlayerPedId()
    TaskTurnPedToFaceEntity(playerPed, vehicle, 2000)
    Wait(1000)

    LoadAnimation("mini@repair")
    TaskPlayAnim(playerPed, "mini@repair", "fixing_a_ped", 8.0, 8.0, -1, 16, 0, false, false, false)

    Wait(Config.PoliceAlert.policeSearch.searchSettings.searchTime)

    ClearPedTasks(playerPed)
    activeSearchOperations[plate] = nil
    searchedVehicles[plate] = true

    if policeInteractions[plate] then
        exports[base.resource]:RemoveInteraction(policeInteractions[plate])
        policeInteractions[plate] = nil
    end

    local chance = math.random(1, 100)
    --local foundIllegal = chance <= Config.PoliceAlert.policeSearch.searchSettings.illegalChance
    local foundIllegal = true

    if foundIllegal then
        local randomItem = Config.PoliceAlert.policeSearch.illegalItems
            [math.random(#Config.PoliceAlert.policeSearch.illegalItems)]
        local message = Config.PoliceAlert.policeSearch.searchResults.illegal .. "\n\nBulunan: " .. randomItem
        Config.sendNotification({ text = message, type = "success" })


        policeSearchData[plate] = {
            vehicle = vehicle,
            vehicleData = vehicleData,
            illegalFound = true,
            foundItem = randomItem
        }


        SetTimeout(1000, function()
            createImpoundInteraction(vehicleData, randomItem)
        end)

        return true
    else
        Config.sendNotification({ text = Config.PoliceAlert.policeSearch.searchResults.clean, type = "info" })
        policeSearchData[plate] = {
            vehicle = vehicle,
            vehicleData = vehicleData,
            illegalFound = false
        }

        return false
    end
end

function impoundVehicle(vehicleData)
    local vehicle = vehicleData.vehicle
    local plate = vehicleData.plate

    if impoundedVehicles[plate] then
        return false
    end

    if activeImpoundOperations[plate] then
        Config.sendNotification({ text = Config.PoliceAlert.policeSearch.searchResults.impoundInProgress, type = "error" })
        return false
    end

    activeImpoundOperations[plate] = true


    Config.sendNotification({ text = Locales[Config.Locale]['policeImpoundingVehicle'], type = "info" })
    showProgressBar(Locales[Config.Locale]['policeImpoundingVehicleProgress'], 5)


    local playerPed = PlayerPedId()
    LoadAnimation("mp_arresting")
    TaskPlayAnim(playerPed, "mp_arresting", "a_uncuff", 8.0, 8.0, -1, 16, 0, false, false, false)

    Wait(5000)
    ClearPedTasks(playerPed)


    TriggerServerEvent(_event('server:policeImpoundVehicle'), vehicleData.ownerIdentifier, plate,
        vehicleData.foundItem or Locales[Config.Locale]['policeUnknownIllegalItem'])

    impoundedVehicles[plate] = true
    activeImpoundOperations[plate] = nil

    Config.sendNotification({ text = Config.PoliceAlert.policeSearch.searchResults.impounded, type = "success" })


    if policeInteractions[plate] then
        exports[base.resource]:RemoveInteraction(policeInteractions[plate])
        policeInteractions[plate] = nil
    end

    return true
end

function clearPoliceInteractions()
    for _, interactionId in pairs(policeInteractions) do
        if interactionId and interactionId ~= true then
            exports[base.resource]:RemoveInteraction(interactionId)
        end
    end
    policeInteractions = {}
end

function createImpoundInteraction(vehicleData, foundItem)
    local plate = vehicleData.plate

    if impoundedVehicles[plate] or policeInteractions[plate] then
        return
    end

    local interactionId = exports[base.resource]:AddInteraction({
        coords = vehicleData.coords,
        distance = 4.0,
        interactDst = 4.0,
        id = 'police_impound_' .. plate,
        name = 'PoliceImpound_' .. plate,
        options = {
            {
                label = 'Impound Vehicle (' .. plate .. ')',
                action = function()
                    if isPlayerPolice() then
                        vehicleData.foundItem = foundItem
                        impoundVehicle(vehicleData)
                    else
                        Config.sendNotification({
                            text = Config.PoliceAlert.policeSearch.searchResults.notPolice,
                            type =
                            "error"
                        })
                    end
                end,
                canInteract = function()
                    local pPed = PlayerPedId()
                    local pCoords = GetEntityCoords(pPed)
                    local vCoords = GetEntityCoords(vehicleData.vehicle)
                    local vDistance = #(pCoords - vCoords)
                    return vDistance <= Config.PoliceAlert.policeSearch.searchSettings.impoundDistance and
                        not IsPedInAnyVehicle(pPed, false) and isPlayerPolice()
                end
            }
        }
    })

    if interactionId then
        policeInteractions[plate] = interactionId
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        if isPlayerPolice() then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            local nearbyTrucks = findNearbyIllegalTrucks(playerCoords, 50.0)
            local currentInteractions = {}

            for _, truckData in ipairs(nearbyTrucks) do
                local plate = truckData.plate
                local distance = #(playerCoords - truckData.coords)
                if distance <= 8.0 and not impoundedVehicles[plate] then
                    currentInteractions[plate] = truckData

                    if not policeInteractions[plate] then
                        local interactionId = nil

                        if not searchedVehicles[plate] then
                            interactionId = exports[base.resource]:AddInteraction({
                                coords = truckData.coords,
                                distance = 4.0,
                                interactDst = 4.0,
                                id = 'police_search_' .. plate,
                                name = 'PoliceSearch_' .. plate,
                                options = {
                                    {
                                        label = 'Search Vehicle (' .. plate .. ')',
                                        action = function()
                                            if isPlayerPolice() then
                                                searchVehicle(truckData)
                                            else
                                                Config.sendNotification({
                                                    text = Config.PoliceAlert.policeSearch
                                                        .searchResults.notPolice,
                                                    type = "error"
                                                })
                                            end
                                        end,
                                        canInteract = function()
                                            local pPed = PlayerPedId()
                                            local pCoords = GetEntityCoords(pPed)
                                            local vDistance = #(pCoords - truckData.coords)
                                            return vDistance <=
                                                Config.PoliceAlert.policeSearch.searchSettings.searchDistance and
                                                not IsPedInAnyVehicle(pPed, false) and isPlayerPolice()
                                        end
                                    }
                                }
                            })

                            if interactionId then
                                policeInteractions[plate] = interactionId
                            end
                        elseif policeSearchData[plate] and policeSearchData[plate].illegalFound then
                            createImpoundInteraction(truckData, policeSearchData[plate].foundItem)
                        end
                    end
                end
            end

            for plate, interactionId in pairs(policeInteractions) do
                if not currentInteractions[plate] then
                    exports[base.resource]:RemoveInteraction(interactionId)
                    policeInteractions[plate] = nil
                end
            end
        else
            if next(policeInteractions) then
                clearPoliceInteractions()
            end
        end
    end
end)
