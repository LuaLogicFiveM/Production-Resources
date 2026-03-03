local State = Tworst.State
local RequestId = 0
local serverRequests = {}
targetLoaded = false
showBar = false
local jobNpc = nil
local jobNpcClipboard = nil
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

RegisterNetEvent("esx:removeInventoryItem")
AddEventHandler("esx:removeInventoryItem", function()
    if Config.Framework == 'standalone' then return end
    local inventory = TriggerServerCallback(_event('server:GetPlayerInventory'))
    NuiMessage('SET_INVENTORY', inventory)
end)

RegisterNetEvent("esx:addInventoryItem")
AddEventHandler("esx:addInventoryItem", function()
    if Config.Framework == 'standalone' then return end
    local inventory = TriggerServerCallback(_event('server:GetPlayerInventory'))
    NuiMessage('SET_INVENTORY', inventory)
end)

RegisterNetEvent(_event(":RefreshInventory"))
AddEventHandler(_event(":RefreshInventory"), function()
    if Config.Framework == 'standalone' then return end
    local inventory = TriggerServerCallback(_event('server:GetPlayerInventory'))
    NuiMessage('SET_INVENTORY', inventory)
end)

RegisterNetEvent("QBCore:Player:SetPlayerData")
AddEventHandler("QBCore:Player:SetPlayerData", function(PlayerData)
    if Config.Framework == 'standalone' then return end
    local items = PlayerData.items
    local formattedItems = FormatItems(items)
    NuiMessage('SET_INVENTORY', formattedItems)
end)


function ChecklistItem(item)
    for _, v in pairs(Config.InventoryAccess.allowedItems) do
        if item == v then
            return true
        end
    end
    return false
end

function FormatItems(items)
    local data = {}
    for _, v in pairs(items) do
        local amount = v.count or v.amount
        if amount > 0 and ChecklistItem(v.name) then
            local formattedData = v
            formattedData.name = v.name
            formattedData.label = v.label
            formattedData.amount = amount
            formattedData.metadata = v.metadata or v.info
            formattedData.image = v.image or (v.name .. '.png')
            if formattedData.metadata and next(formattedData.metadata) == nil then
                formattedData.metadata = false
            end
            table.insert(data, formattedData)
        end
    end
    return data
end

CreateThread(function()
    if Config.Framework == 'standalone' then
        Core = true
    elseif Config.Framework ~= 'vrp' and Config.Framework ~= 'vrp2' then
        Core = GetCore()
    else
        Core = true
    end

    spawnPed()
    createBlips()
    SetPlayerJob()
end)

AddEventHandler('onResourceStop', function(resource)
    if (resource == GetCurrentResourceName()) then
        ClearPedTasks(PlayerPedId())
        deletePed()
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if (resource == GetCurrentResourceName()) then
        Wait(3000)

        TriggerServerEvent(_event('server:loadData'))
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

    if Config.Framework == 'standalone' then
        jobData.jobname = "scrapyard"
        jobData.job_grade_name = "Scrapyard Worker"
        jobData.job_grade = 0
    elseif Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local PlayerData = Core.GetPlayerData()
        jobData.jobname = PlayerData.job.name
        jobData.job_grade_name = PlayerData.job.label
        jobData.job_grade = tonumber(PlayerData.job.grade)
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local PlayerData = Core.Functions.GetPlayerData()
        jobData.jobname = PlayerData["job"].name
        jobData.job_grade_name = PlayerData["job"].label
        jobData.job_grade = PlayerData["job"].grade.level
    elseif Config.Framework == 'vrp' or Config.Framework == 'vrp2' then
        jobData.jobname = "scrapyard"
        jobData.job_grade_name = "Scrapyard"
        jobData.job_grade = 0
    end
end

function WaitPlayer()
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
    elseif Config.Framework == "vrp" or Config.Framework == "vrp2" then
        return
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

function deletePed()
    if jobNpcClipboard and DoesEntityExist(jobNpcClipboard) then
        DeleteEntity(jobNpcClipboard)
        jobNpcClipboard = nil
    end

    if jobNpc and DoesEntityExist(jobNpc) then
        DeleteEntity(jobNpc)
        jobNpc = nil
    end
end

function spawnPed()
    deletePed()

    if Config.Job.coords.ped then
        WaitForModel(Config.Job.coords.pedHash)
        local createNpc = CreatePed("PED_TYPE_PROSTITUTE", Config.Job.coords.pedHash, Config.Job.coords.pedCoords.x,
            Config.Job.coords.pedCoords.y, Config.Job.coords.pedCoords.z - 0.98, Config.Job.coords.pedHeading, false,
            false)
        FreezeEntityPosition(createNpc, true)
        SetEntityInvincible(createNpc, true)
        SetBlockingOfNonTemporaryEvents(createNpc, true)

        RequestAnimDict("amb@world_human_clipboard@male@idle_a")
        while not HasAnimDictLoaded("amb@world_human_clipboard@male@idle_a") do
            Wait(10)
        end
        TaskPlayAnim(createNpc, "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, -8.0, -1, 1, 0, false, false,
            false)

        local propModel = GetHashKey("p_amb_clipboard_01")
        RequestModel(propModel)
        while not HasModelLoaded(propModel) do
            Wait(10)
        end
        local clipboard = CreateObject(propModel, 0, 0, 0, false, true, true)
        AttachEntityToEntity(clipboard, createNpc, GetPedBoneIndex(createNpc, 18905), 0.10, 0.02, 0.08, -130.0, -50.0,
            0.0, true, true, false, true, 1, true)

        jobNpc = createNpc
        jobNpcClipboard = clipboard
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

activeOpenTriggerZone = nil
local drawtextThreadActive = false

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
                drawtextThreadActive = false
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
            elseif Config.InteractionHandler == "drawtext" then
                Config.drawTextActive = false
                drawtextThreadActive = false
                Wait(100)

                Config.drawTextActive = true
                if not drawtextThreadActive then
                    drawtextThreadActive = true
                    Citizen.CreateThread(function()
                        while Config.drawTextActive and drawtextThreadActive do
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
                        drawtextThreadActive = false
                    end)
                end
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
    local offset = vector3(-1.4, 0.35, 0.33)
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
        SetCamFov(cam, 30.0)
        SetCamDofFnumberOfLens(cam, 24.0)
        SetCamDofFocalLengthMultiplier(cam, 50.0)
    end
end

function ExitCamera()
    SetEntityAlpha(PlayerPedId(), 255, false)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(cam, false)
    ClearFocus()
    cam = nil
end

function CreateFinishCamera()
    --local invehicle = IsPedInAnyVehicle(PlayerPedId(), false)
    --if invehicle then return end
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

Citizen.CreateThread(function()
    local sleepJob = 2000
    local sleepAnim = 200
    local sleepAlpha = 1000

    local lastJobCheck = GetGameTimer()
    local lastAnimCheck = GetGameTimer()
    local lastAlphaCheck = GetGameTimer()

    while true do
        -- Optimize: Skip everything if not in job
        local isJobing = CoopDataClient and CoopDataClient.roomSetting and true or false
        local now = GetGameTimer()
        local playerPed = PlayerPedId()
        local hasAnyItem = isPlacingObject
            or (carryingObject and carryingObject.active)
            or (ItemPickup and ItemPickup.carryingItem)
            or (State and State.hasLongTongs)
            or (State and State.carryingCase)

        if not isJobing then
            Wait(1000)
            goto continue
        end

        if now - lastJobCheck >= sleepJob then
            lastJobCheck = now
            sleepJob = 0

            if GetIsTaskActive(playerPed, 160) and hasAnyItem then
                ClearPedTasks(playerPed)
                ClearPedSecondaryTask(playerPed)
                Config.sendNotification(Config.NotificationText['cantentervehicle'])
            end
        end

        if now - lastAnimCheck >= sleepAnim then
            lastAnimCheck = now

            if isPlacingObject then
                if not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) then
                    carryObject()
                end
            elseif carryingObject and carryingObject.active then
                if not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) then
                    RequestAnimDict("anim@heists@box_carry@")
                    while not HasAnimDictLoaded("anim@heists@box_carry@") do
                        Wait(0)
                    end
                    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                end
            elseif State and State.carryingCase then
                if not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) then
                    RequestAnimDict("anim@heists@box_carry@")
                    while not HasAnimDictLoaded("anim@heists@box_carry@") do
                        Wait(0)
                    end
                    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                end
            end
        end

        if now - lastAlphaCheck >= sleepAlpha then
            lastAlphaCheck = now
            if openUI or camera then
                sleepAlpha = 0
                SetEntityAlpha(PlayerPedId(), 0, false)
                SetLocalPlayerInvisibleLocally(true)
            else
                sleepAlpha = 1000
            end
        end


        if hasAnyItem then
            DisableControlAction(0, 24, true)  -- Attack
            DisableControlAction(0, 25, true)  -- Aim
            DisableControlAction(0, 37, true)  -- Weapon Wheel
            DisableControlAction(0, 47, true)  -- Weapon Special
            DisableControlAction(0, 58, true)  -- Weapon Special Two
            DisableControlAction(0, 140, true) -- Melee Attack Light
            DisableControlAction(0, 141, true) -- Melee Attack Heavy
            DisableControlAction(0, 142, true) -- Melee Attack Alternate
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 264, true) -- Melee Attack 2

            SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
        end

        ::continue::
        Citizen.Wait(math.max(sleepJob, sleepAnim, sleepAlpha, 200))
    end
end)
