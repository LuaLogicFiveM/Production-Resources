---@diagnostic disable: param-type-mismatch

local cl_utils = require 'utils.client'

local cl_config = {
    disableSprint = true,
    disableWeapons = true,
    crutchModel = `prop_mads_crutch01`,
    clipSet = "move_lester_CaneUp",
    jobs = {['safd'] = 0},
    pickupAnim = {
        dict = "pickup_object",
        name = "pickup_low"
    }
}

local localization = {
    ['ragdoll'] = "You can't use a crutch while you are in ragdoll!",
    ['falling'] = "You can't use a crutch while you are falling!",
    ['combat'] = "You can't use a crutch while you are in combat!",
    ['dead'] = "You can't use a crutch while you are dead!",
    ['vehicle'] = "You can't use a crutch while you are in a vehicle!",
    ['weapon'] = "You can't use a crutch while having a weapon out!",
    ['pickup'] = "Press ~INPUT_PICKUP~ to pick up your crutch!",
    ['forced'] = "You need to use the Crutch for a little longer!"
}

-- Variables --
local isUsingCrutch = false
local crutchObject = nil
local walkStyle = nil

-- Functions --
local function LoadClipSet(set)
    RequestClipSet(set)
    while not HasClipSetLoaded(set) do
        Wait(10)
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

local function DisplayHelpText(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, 50)
end

local function CreateCrutch()
    if not HasModelLoaded(cl_config.crutchModel) then
        LoadModel(cl_config.crutchModel)
    end
    local coords = GetEntityCoords(cache.ped)
    crutchObject = CreateObject(cl_config.crutchModel, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(crutchObject, cache.ped, 70, 1.18, -0.36, -0.20, -20.0, -87.0, -20.0, true, true, false, true, 1, true)
end

local function DeleteCrutchObject()
    if DoesEntityExist(crutchObject) then
        DeleteEntity(crutchObject)
    end
end

local function UnequipCrutch()
    DeleteCrutchObject()
    isUsingCrutch = false
    LocalPlayer.state.crutch = false

    lib.disableControls:Clear(22)

    if cl_config.disableSprint then
        SetPlayerSprint(cache.playerId, true)
    end

    if walkStyle then
        LoadClipSet(walkStyle)
        SetPedMovementClipset(cache.ped, walkStyle, 1.0)
        RemoveClipSet(walkStyle)
    else
        ResetPedMovementClipset(cache.ped, 1.0)
    end
end

local function TraceCrutchObject()
    local traceObject = true
    local wait = 0

    while traceObject do
        wait = 0
        if DoesEntityExist(crutchObject) then
            if not IsPedFalling(cache.ped) and not IsPedRagdoll(cache.ped) then
                local dist = #(GetEntityCoords(cache.ped)-GetEntityCoords(crutchObject))
                if dist < 2.0 then
                    DisplayHelpText(localization['pickup'])
                    if IsControlJustReleased(0, 38) then
                        LoadAnimDict(cl_config.pickupAnim.dict)
                        TaskPlayAnim(cache.ped, cl_config.pickupAnim.dict, cl_config.pickupAnim.name, 2.0, 2.0, -1, 0, 0, false, false, false)

                        local failCount = 0
                        while not IsEntityPlayingAnim(cache.ped, cl_config.pickupAnim.dict, cl_config.pickupAnim.name, 3) and failCount < 25 do
                            failCount = failCount + 1
                            Wait(50)
                        end

                        if failCount >= 25 then
                            ClearPedTasks(cache.ped)
                        else
                            Wait(800)
                        end

                        RemoveAnimDict(cl_config.pickupAnim.dict)
                        DeleteCrutchObject()
                        Wait(900)
                        CreateCrutch()
                        traceObject = false
                    end
                elseif dist < 200.0 then
                    wait = dist * 10
                else
                    traceObject = false
                end
            else
                wait = 250
            end
        else
            traceObject = false
        end

        Wait(wait)
    end
end

local function MainThread()
    CreateThread(function()
        local fallCount = 0
        while true do
            Wait(250)
            if not isUsingCrutch then
                break
            end

            local isCrutchHidden = false

            SetPedCanPlayAmbientAnims(cache.ped, false)

            if cache.weapon then
                if cl_config.disableWeapons then
                    TriggerEvent('ox_inventory:disarm')
                elseif not isCrutchHidden then
                    isCrutchHidden = true
                    DeleteCrutchObject()
                end
            elseif IsPedInAnyVehicle(cache.ped, true) then
                if not isCrutchHidden then
                    isCrutchHidden = true
                    DeleteCrutchObject()
                end
            elseif not DoesEntityExist(crutchObject) then
                Wait(750)
                CreateCrutch()
                isCrutchHidden = false
            elseif not IsEntityAttachedToEntity(crutchObject, cache.ped) then
                TraceCrutchObject()
            elseif IsPedRagdoll(cache.ped) or cl_utils.playerDead() then
                DetachEntity(crutchObject, true, true)
            elseif IsPedInMeleeCombat(cache.ped) then
                Wait(500)
                DetachEntity(crutchObject, true, true)
            elseif IsPedFalling(cache.ped) then
                fallCount = fallCount + 1
                if fallCount > 3 then
                    DetachEntity(crutchObject, true, true)
                    fallCount = 0
                end
            elseif fallCount > 0 then
                fallCount = fallCount - 1
            end
        end
    end)
end

local function EquipCrutch()
    LoadClipSet(cl_config.clipSet)
    SetPedMovementClipset(cache.ped, cl_config.clipSet, 1.0)
    RemoveClipSet(cl_config.clipSet)

    CreateCrutch()
    isUsingCrutch = true
    LocalPlayer.state.crutch = true

    if cl_config.disableSprint then
        SetPlayerSprint(cache.playerId, false)
    end

    lib.disableControls:Add(22)
    MainThread()
end

local function ToggleCrutch()
    if isUsingCrutch then
        UnequipCrutch()
    else
        EquipCrutch()
    end
end

-- Exports --
exports('SetWalkStyle', function(walk)
    walkStyle = walk
end)

exports('EquipCrutch', function()
    if isUsingCrutch then return end

    EquipCrutch()
end)

exports('hasCrutch', function()
    return isUsingCrutch
end)

exports('UnequipCrutch', function()
    if not isUsingCrutch then return end

    UnequipCrutch()
end)

exports('ToggleCrutch', function()
    ToggleCrutch()
end)

local function ForceCrutch(time)
    if time > 30 then return end
    if isUsingCrutch then return end

    EquipCrutch()
    SetTimeout(time * 60000, function()
        UnequipCrutch()
    end)
end

exports('ForceCrutch', function(time)
    ForceCrutch(time)
end)

lib.onCache('weapon', function(weapon)
    if cl_config.disableWeapons and weapon and weapon ~= `WEAPON_UNARMED` and LocalPlayer.state.crutch then
        TriggerEvent('ox_inventory:disarm')
    end
end)

local currentResource = GetCurrentResourceName()
AddEventHandler('onResourceStop', function(resource)
    if resource ~= currentResource then return end

    if isUsingCrutch then
        UnequipCrutch()
    end
end)

RegisterCommand('crutch', function(source, args)
    local src = source
    local timer = tonumber(args[1])

    if timer > 15 then
        return lib.notify(src, {title = 'Crutch System', description = 'You are not allowed to set a crutch more than 15 minutes', type = 'error', position = 'top'})
    end

    if not utils.hasJobGrade(cl_config.jobs) then
        return lib.notify(src, {title = 'Crutch System', description = 'You do not have permission to access this', type = 'error', position = 'top'})
    end

    ForceCrutch(timer)
end, false)