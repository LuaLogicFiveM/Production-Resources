local RESOURCE = GetCurrentResourceName()
local KVP_PREFIX = 'crossfire:'

local settings = nil
local mode = nil
local nuiOpen = false
local lastVisible = nil
local sentInitialSettings = false
-- highlight throttle state
local lastHighlightCheck = 0
local lastHighlightState = false

-- math helper: camera rot -> world direction
local function RotationToDirection(rot)
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

local function getFirstPedAimedAt()
    local playerPed = PlayerPedId()
    local camPos = GetGameplayCamCoord()
    local FLAGS = 1 + 2 + 4 + 8 + 16 -- map, mission, vehicles, peds, objects

    local function firstHit(from, to)
        local h = StartShapeTestRay(from.x, from.y, from.z, to.x, to.y, to.z, FLAGS, playerPed, 7)
        local _, hit, _, _, ent = GetShapeTestResult(h)
        if hit == 1 then return ent or 0 end
        return 0
    end

    -- 1) Prefer native aimed entity; verify LOS to head so cars/objects block it
    local aiming, ent = GetEntityPlayerIsFreeAimingAt(PlayerId())
    if aiming and ent and ent ~= 0 and DoesEntityExist(ent) and IsEntityAPed(ent) and not IsEntityDead(ent) then
        local head = GetPedBoneCoords(ent, 31086, 0.0, 0.0, 0.0) -- SKEL_Head
        local hitEnt = firstHit(camPos, head)
        if hitEnt == ent then
            return ent
        end
    end

    -- 2) Fallback: straight ray; highlight only if FIRST impact is a living ped (so vehicles/objects block it)
    local dir = RotationToDirection(GetGameplayCamRot(2))
    local dist = 200.0
    local dest = vector3(camPos.x + dir.x * dist, camPos.y + dir.y * dist, camPos.z + dir.z * dist)
    local hitEnt = firstHit(camPos, dest)
    if hitEnt ~= 0 and IsEntityAPed(hitEnt) and not IsEntityDead(hitEnt) then
        return hitEnt
    end
    return 0
end

local function loadSettings()
    local kv = GetResourceKvpString(KVP_PREFIX .. 'settings')
    if kv then
        local ok, data = pcall(json.decode, kv)
        if ok and type(data) == 'table' then
            settings = data
        end
    end
    if not settings then
        settings = Config.DefaultSettings
    end

    local kvMode = GetResourceKvpString(KVP_PREFIX .. 'mode')
    mode = kvMode or Config.DefaultMode
end

local function saveSettings()
    SetResourceKvp(KVP_PREFIX .. 'settings', json.encode(settings))
    SetResourceKvp(KVP_PREFIX .. 'mode', mode)
end

local function sendUI(name, data)
    SendNUIMessage({ action = name, data = data })
end

local function shouldShowCrosshair()
    local ped = PlayerPedId()
    if mode == 'always' then return true end

    local hasWeapon = GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED`
    if mode == 'armed' then
        return hasWeapon
    end
    if mode == 'aiming' then
        return IsPlayerFreeAiming(PlayerId()) or IsAimCamActive()
    end
    return false
end

local function hideDefaultReticleTick()
    if not Config.HideDefaultReticle then return end
    local ped = PlayerPedId()
    local aiming = IsPlayerFreeAiming(PlayerId()) or IsAimCamActive()
    -- Hide default reticle except when in vehicle with weapons that require it? We'll respect config only.
    HideHudComponentThisFrame(14) -- reticle
    -- Optionally hide when aiming: still hide to avoid double
end

RegisterCommand('crosshair', function()
    nuiOpen = true
    SetNuiFocus(true, true)
    sentInitialSettings = false
    sendUI('open', { settings = settings, mode = mode })
    -- hide overlay while editing; preview inside NUI handles visualization
    sendUI('hide', {})
end, false)

--RegisterKeyMapping('cross', 'Open Crosshair menu', 'keyboard', 'HOME')

RegisterNUICallback('close', function(_, cb)
    nuiOpen = false
    -- force re-evaluation of visibility on next tick
    lastVisible = nil
    SetNuiFocus(false, false)
    cb({ ok = true })
end)

RegisterNUICallback('save', function(data, cb)
    if data and data.settings then
        settings = data.settings
    end
    if data and data.mode then
        mode = data.mode
    end
    saveSettings()
    -- do not force show here; visibility is controlled by the main loop
    -- optionally send settings-only update
    sendUI('settings', { settings = settings })
    nuiOpen = false
    -- force re-evaluation of visibility on next tick (e.g., Always mode)
    lastVisible = nil
    SetNuiFocus(false, false)
    cb({ ok = true })
end)

-- Apply live updates
RegisterNUICallback('update', function(data, cb)
    if data and data.settings then
        settings = data.settings
    end
    if data and data.mode then
        mode = data.mode
        -- recompute visibility immediately on next loop
        lastVisible = nil
    end
    cb({ ok = true })
end)

CreateThread(function()
    loadSettings()
    -- send an initial hide to ensure we start hidden until logic decides otherwise
    sendUI('hide', {})
    while true do
        Wait(0)

        -- default reticle (only when crosshair is visible or aiming to avoid extra calls)
        if lastVisible or IsPlayerFreeAiming(PlayerId()) or IsAimCamActive() then
            hideDefaultReticleTick()
        end

        -- crosshair visibility (do not display while panel is open)
        if not nuiOpen then
            local show = shouldShowCrosshair()
            if lastVisible == nil or show ~= lastVisible then
                if show then
                    -- send settings on first show to initialize overlay
                    if not sentInitialSettings then
                        sendUI('show', { settings = settings })
                        sentInitialSettings = true
                    else
                        sendUI('show', {}) -- show again after being hidden
                    end
                else
                    sendUI('hide', {})
                end
                lastVisible = show
            end
        else
            -- ensure overlay stays hidden while editing
            if lastVisible then
                sendUI('hide', {})
                lastVisible = false
            end
        end

        -- do not force overlay while editing; preview inside panel handles live view

        -- enemy highlight: temporarily override color while aiming at an NPC
        -- Highlight detection (throttled) – only when the FIRST hit is a living ped; optional players
        if Config.EnemyAimHighlight and lastVisible and (not Config.HighlightOnlyWhenAiming or IsPlayerFreeAiming(PlayerId()) or IsAimCamActive()) then
            local now = GetGameTimer()
            if now - lastHighlightCheck > 120 then
                lastHighlightCheck = now
                local ped = getFirstPedAimedAt()
                local highlight = false
                if ped ~= 0 then
                    if IsPedAPlayer(ped) then
                        highlight = Config.HighlightPlayers == true
                    else
                        highlight = true
                    end
                end
                if highlight ~= lastHighlightState then
                    lastHighlightState = highlight
                    if highlight then
                        sendUI('highlight', { color = Config.EnemyColor })
                    else
                        sendUI('highlight', { color = false })
                    end
                end
            end
        else
            if lastHighlightState then
                lastHighlightState = false
                sendUI('highlight', { color = false })
            end
        end
    end
end)
