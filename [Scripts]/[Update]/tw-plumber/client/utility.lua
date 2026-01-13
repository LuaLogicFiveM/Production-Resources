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
    elseif Config.Framework ~= 'vrp' then
        Core = GetCore()
    else
        Core = true
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
        jobData.jobname = "plumber"
        jobData.job_grade_name = "Plumber"
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
        -- vRP não usa sistema de job tradicional
        jobData.jobname = "plumber"
        jobData.job_grade_name = "Plumber"
        jobData.job_grade = 0
    end
end

function WaitPlayer()
    -- Standalone framework (no player data waiting needed)
    if Config.Framework == 'standalone' then
        return
    elseif Config.Framework == "esx" or Config.Framework == 'oldesx' then
        while Core == nil do
            Wait(0)
        end
        while Core.GetPlayerData() == nil do
            Wait(0)
        end
        while Core.GetPlayerData().job == nil do
            Wait(0)
        end
    elseif Config.Framework == "qb" or Config.Framework == "oldqb" then
        while Core == nil do
            Wait(0)
        end
        while Core.Functions.GetPlayerData() == nil do
            Wait(0)
        end
        while Core.Functions.GetPlayerData().metadata == nil do
            Wait(0)
        end
    elseif Config.Framework == "vrp" then
        while Core == nil do
            Wait(0)
        end
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
        SetBlipDisplay(blips, 4)
        SetBlipScale(blips, Config.Job['blip'].blipScale)
        SetBlipColour(blips, Config.Job['blip'].blipColor)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(Config.Job['blip'].blipName))
        EndTextCommandSetBlipName(blips)
    end
end

function canOpen()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        return false
    end
    if Config.Job['job'] then
        if Config.Job['job'] == 'all' then
            return true
        end

        if type(Config.Job['job']) == 'table' then
            local hasJob = false
            for _, allowedJob in ipairs(Config.Job['job']) do
                if allowedJob == jobData.jobname then
                    hasJob = true
                    break
                end
            end
            if not hasJob then
                Config.sendNotification(Config.NotificationText['wrongjob'].text, Config.NotificationText['wrongjob'].type)
                return false
            end
        elseif type(Config.Job['job']) == 'string' then
            if Config.Job['job'] ~= jobData.jobname then
                Config.sendNotification(Config.NotificationText['wrongjob'].text, Config.NotificationText['wrongjob'].type)
                return false
            end
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
    local distance = #(vector3(px, py, pz) - vector3(x, y, z))
    local scale = 0.35
    if distance > 3.0 and distance <= 7.0 then
        scale = 0.35 - ((distance - 3.0) / 4.0) * 0.1
    elseif distance > 7.0 then
        scale = 0.25
    end


    if onScreen and distance < 10.0 then
        SetTextScale(scale, scale)
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

Citizen.CreateThread(function()
    Config.OpenTrigger = function(bool)
        if not bool then
            if Config.InteractionHandler == "qb-target" then
                exports['qb-target']:RemoveZone(base.resource .. "_1" .. 1)
            elseif Config.InteractionHandler == "ox-target" then
                exports['ox_target']:removeZone(base.resource .. "_1")
            elseif Config.InteractionHandler == "drawtext" then
                Config.drawTextActive = false
            end
        else
            if Config.InteractionHandler == "qb-target" then
                exports['qb-target']:AddBoxZone(base.resource .. "_1" .. 1,
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
                local data = {
                    name = base.resource .. "_1",
                    radius = 2.0,
                    icon = 'fas fa-credit-card',
                    label = Locales[Config.Locale]['openJobMenu'],
                    event = _event('openMenu'),
                    handler = false
                }
                addBoxToTarget(
                    vector3(Config.Job.coords.intreactionCoords.x, Config.Job.coords.intreactionCoords.y,
                        Config.Job.coords.intreactionCoords.z), data)
            elseif Config.InteractionHandler == "drawtext" or Config.InteractionHandler == "scriptbase" then
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

local function CheckPlayerHandObjects()
    if playerHandObject.object then
        return true
    end
    return false
end

Citizen.CreateThread(function()
    local sleep = 2000
    while true do
        Citizen.Wait(sleep)
        local isJobing = CoopDataClient and CoopDataClient.roomSetting and true or false
        if isJobing then
            sleep = 0
            local playerPed = PlayerPedId()
            if GetIsTaskActive(playerPed, 160) and CheckPlayerHandObjects() then
                ClearPedTasks(playerPed)
                ClearPedSecondaryTask(playerPed)
                Config.sendNotification(Locales[Config.Locale]['cantentervehicle'], 'error')
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
    if dataName == 'insertPipe' then
        showProgressBar(Locales[Config.Locale]['insertPipeProgress'], 0.9)
        LoadAnimation('anim@mp_fireworks')
        TaskPlayAnim(playerPed, 'anim@mp_fireworks', 'place_firework_3_box', 8.0, -8.0, -1, 2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(3000)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    elseif dataName == 'insertValve' then
        showProgressBar(Locales[Config.Locale]['insertValveProgress'], 0.9)
        LoadAnimation('anim@mp_fireworks')
        TaskPlayAnim(playerPed, 'anim@mp_fireworks', 'place_firework_3_box', 8.0, -8.0, -1, 2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(3000)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    elseif dataName == 'removePipe' then
        showProgressBar(Locales[Config.Locale]['removePipeProgress'], 0.9)
        LoadAnimation('anim@mp_fireworks')
        TaskPlayAnim(playerPed, 'anim@mp_fireworks', 'place_firework_3_box', 8.0, -8.0, -1, 2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(3000)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    elseif dataName == 'vehicletoPed' then
        LoadAnimation('anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@normal')
        showProgressBar(Locales[Config.Locale]['receivingMaterials'], 3.3)
        TaskPlayAnim(playerPed, 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@normal', 'pickup', 8.0, -8.0, -1,
            2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(3300)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    elseif dataName == 'pedtoVehicle' then
        LoadAnimation('anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@normal')
        showProgressBar(Locales[Config.Locale]['putBackMaterials'], 2.2)
        TaskPlayAnim(playerPed, 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@normal', 'pickup', 8.0, -8.0, -1,
            2, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        Wait(2200)
        ClearPedTasksImmediately(playerPed)
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        return true
    end
end

function startPipeCarryThread()
    Citizen.CreateThread(function()
        if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
            carryPipe()
        end
    end)
end

function carryPipe()
    while (not HasAnimDictLoaded("missfinale_c2mcs_1")) do
        RequestAnimDict("missfinale_c2mcs_1")
        Citizen.Wait(100)
    end

    TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 4.0, 4.0, -1, 51, 0, false, false, false)
end

Citizen.CreateThread(function()
    local wasSwitchMission = false
    local sleep = 1000

    while true do
        if isSwitchMission then
            sleep = 0
            if not wasSwitchMission then
                wasSwitchMission = true
                local playerPed = PlayerPedId()
                LoadAnimation('missheist_agency2aig_3')
            end

            if not IsEntityPlayingAnim(PlayerPedId(), "missheist_agency2aig_3", "chat_a_worker2", 3) then
                TaskPlayAnim(PlayerPedId(), 'missheist_agency2aig_3', 'chat_a_worker2', 8.0, -8.0, -1, 51, 0, false,
                    false, false)
            end
        elseif wasSwitchMission then
            sleep = 1000
            wasSwitchMission = false
            ClearPedTasksImmediately(PlayerPedId())
            ClearPedTasks(PlayerPedId())
        end

        Citizen.Wait(sleep)
    end
end)


Citizen.CreateThread(function()
    local wasOpenValveMission = false
    local sleep = 1000

    while true do
        if isOpenValveMission then
            sleep = 0
            if not wasOpenValveMission then
                wasOpenValveMission = true
                local playerPed = PlayerPedId()
                LoadAnimation('missheistdockssetup1ig_3@talk')
            end

            if not IsEntityPlayingAnim(PlayerPedId(), "missheistdockssetup1ig_3@talk", "oh_hey_vin_dockworker", 3) then
                TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1ig_3@talk', 'oh_hey_vin_dockworker', 8.0, -8.0, -1, 51,
                    0, false, false, false)
            end
        elseif wasOpenValveMission then
            sleep = 1000
            wasOpenValveMission = false
            ClearPedTasksImmediately(PlayerPedId())
            ClearPedTasks(PlayerPedId())
        end

        Citizen.Wait(sleep)
    end
end)

function addPlayerHandObject(object, modelName, isPipe)
    if not object or not modelName then return end
    playerHandObject.object = object
    local objectNetId = NetworkGetNetworkIdFromEntity(object)
    playerHandObject.objectNetId = objectNetId
    playerHandObject.objectModel = modelName
    if isPipe then
        playerHandObject.pipe = true
    else
        playerHandObject.valve = true
    end
    startPipeCarryThread()
    startDisableThread()
end

function ResetPlayerHandObject()
    playerHandObject.pipe = false
    playerHandObject.valve = false
    playerHandObject.object = nil
    playerHandObject.objectModel = nil
    playerHandObject.objectNetId = nil

    ClearPedTasks(PlayerPedId())
    ClearPedTasksImmediately(PlayerPedId())
    stopDisableThread()
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
    local offset = vector3(-0.9, 1.6, 0.3)
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
        if openUI or camera and not Config.closeInvisable then
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

local disableThreadRunning = false

function startDisableThread()
    if disableThreadRunning then return end
    disableThreadRunning = true
    Citizen.CreateThread(function()
        while disableThreadRunning do
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            Wait(0)
        end
    end)
end

function stopDisableThread()
    disableThreadRunning = false
end

local deliveryDrawThread = nil

function ToggleVehicleDeliveryInteraction(state)
    if state then
        local jobDeliverCoords = CoopDataClient and CoopDataClient.roomSetting and
            CoopDataClient.roomSetting.jobDeliverCoords

        while not jobDeliverCoords or not jobDeliverCoords.x or not jobDeliverCoords.y or not jobDeliverCoords.z do
            print("[DEBUG] jobDeliverCoords bekleniyor...", json.encode(jobDeliverCoords))
            Wait(1000)

            -- CoopDataClient.roomSetting nil kontrolü ekle
            if not CoopDataClient or not CoopDataClient.roomSetting then
                print("[DEBUG] CoopDataClient.roomSetting nil oldu, thread durduruluyor...")
                deliveryDrawThread = false
                VehicleDeliveryInteraction = false
                return
            end

            jobDeliverCoords = CoopDataClient.roomSetting.jobDeliverCoords or
                (CoopDataClient.roomSetting.Mission and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords and CoopDataClient.roomSetting.Mission.vehicleSpawnCoords[1])
        end

        VehicleDeliveryInteraction = true

        -- Başlat thread
        if not deliveryDrawThread then
            deliveryDrawThread = true

            Citizen.CreateThread(function()
                while deliveryDrawThread do
                    Wait(0)

                    -- CoopDataClient.roomSetting nil kontrolü ekle
                    if not CoopDataClient or not CoopDataClient.roomSetting then
                        deliveryDrawThread = false
                        VehicleDeliveryInteraction = false
                        break
                    end

                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local vehicles = getVehicle() or {}
                    local isOwner = tostring(GetPlayerServerId(PlayerId())) ==
                        tostring(CoopDataClient.roomSetting.ownersrc)
                    local isPlayerInValidVehicle = false

                    for _, vehData in ipairs(vehicles) do
                        if vehData.plate == plate then
                            isPlayerInValidVehicle = true
                            break
                        end
                    end

                    if isOwner and isPlayerInValidVehicle and IsPedInAnyVehicle(playerPed, false) and not isInteracting then
                        local playerCoords = GetEntityCoords(playerPed)
                        local dist = #(playerCoords - vector3(jobDeliverCoords.x, jobDeliverCoords.y, jobDeliverCoords.z))

                        if dist < 10.0 then
                            DrawText3D(jobDeliverCoords.x, jobDeliverCoords.y, jobDeliverCoords.z + 1.5,
                                'E - ' .. Locales[Config.Locale]['deliveryVehicle'])

                            if IsControlJustReleased(0, 38) then -- E tuşu
                                StartInteraction()
                                -- clearMissionData'dan önce gerekli değeri al
                                local owneridentifier = CoopDataClient and CoopDataClient.roomSetting and
                                    CoopDataClient.roomSetting.owneridentifier
                                if owneridentifier then
                                    TriggerServerEvent(_event('server:LeaveVehicle'), owneridentifier)
                                end
                                clearMissionData()
                                -- Thread'i durdur çünkü mission temizlendi
                                deliveryDrawThread = false
                                VehicleDeliveryInteraction = false
                                Citizen.SetTimeout(1000, function()
                                    EndInteraction()
                                end)
                            end
                        end
                    end
                end
            end)
        end
    elseif not state and VehicleDeliveryInteraction then
        -- Thread kapat
        deliveryDrawThread = false
        VehicleDeliveryInteraction = false
    end
end
