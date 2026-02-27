if not Config.PoliceAlerts.ENABLE then return end

local PedIsCurrentlyCallingPolice = {}
local LastAlertAt = {}
local CooldownDurations = {}

local function IsPedModelBlacklistedFromCallingPolice(ped)
    local model = GetEntityModel(ped)
    for _, wmodel in pairs(Config.PoliceAlerts.WitnessPeds.BlacklistedPedModels) do
        if wmodel == model then
            return true
        end
    end
    return false
end

-- Draws a sphere around a ped.
local function DrawPedSphere(ped, radius, r, g, b, a)
    if not DoesEntityExist(ped) or IsEntityDead(ped) then return end
    local c = GetEntityCoords(ped)
    DrawMarker(28, c.x, c.y, c.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, radius, r, g, b, a, false, false, 2, false, nil, nil, false)
end

-- Returns true if witnessPed can see the player.
local function CanWitnessSeePlayer(witnessPed, playerPed)
    if not DoesEntityExist(witnessPed) or IsEntityDead(witnessPed) then return false end
    if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then return false end

    local from = GetPedBoneCoords(witnessPed, 31086, 0.0, 0.0, 0.0)
    local to = GetEntityCoords(playerPed)

    local ignore = { [witnessPed] = true }
    local maxSteps = 6

    for _ = 1, maxSteps do
        local flags = 1 + 2 + 4 + 8
        local handle = StartShapeTestRay(from.x, from.y, from.z, to.x, to.y, to.z, flags, 0, 7)
        local _, hit, endCoords, _, entityHit = GetShapeTestResult(handle)

        if hit == 0 then
            return true
        end

        if entityHit and entityHit ~= 0 and entityHit == playerPed then
            return true
        end

        if entityHit and entityHit ~= 0 then
            if ignore[entityHit] then
                from = vector3(endCoords.x + 0.05, endCoords.y + 0.05, endCoords.z + 0.05)
            else
                ignore[entityHit] = true
                local dir = (to - vector3(endCoords.x, endCoords.y, endCoords.z))
                local len = #(dir)
                if len > 0.001 then
                    dir = dir / len
                end
                from = vector3(endCoords.x + (dir.x * 0.15), endCoords.y + (dir.y * 0.15), endCoords.z + (dir.z * 0.15))
            end
        else
            return false
        end
    end

    return false
end

-- Returns true if any ped is within the given radius of the player.
local function IsAnyPedInRadius(radius)
    local player_ped = PlayerPedId()
    local player_coords = GetEntityCoords(player_ped)

    local peds = GetGamePool('CPed')
    for cd = 1, #peds do
        local ped = peds[cd]
        if ped ~= 0 and ped ~= player_ped and DoesEntityExist(ped) and not IsPedAPlayer(ped) and IsPedHuman(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, false) and not IsPedModelBlacklistedFromCallingPolice(ped) then
            local dist = #(player_coords - GetEntityCoords(ped))
            if dist <= radius then
                return true
            end
        end
    end

    return false
end

-- Returns true if the weapon is whitelisted.
function IsWeaponWhitelisted(tbl, weaponHash)
    for _, w in pairs(tbl) do
        if w == weaponHash then
            return true
        end
    end
    return false
end

-- Returns true if the player is on duty and their job is in the whitelist.
function IsPlayerJobWhitelisted()
    if Config.Debug then return false end
    return HasJob(Config.PoliceAlerts.whitelisted_jobs)
end

-- Returns true if the player is within any whitelisted zone for gunshots.
function IsPlayerInGunshotWhitelistZone()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for _, zone in pairs(Config.PoliceAlerts.GunShots.WhitelistedZones) do
        if #(coords - zone.coords) <= zone.radius then
            return true
        end
    end
    if IsPlayingPaintball() then
        return true
    end
    return false
end

-- Returns true if the player is within any no-snitching zone.
function IsPlayerInNoSnitchingZone()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for _, zone in pairs(Config.PoliceAlerts.WitnessPeds.NoSnitchingZones) do
        if #(coords - zone.coords) <= zone.radius then
            return true
        end
    end
    return false
end

-- Returns true if a random roll is successful based on the given chance percent (0-100).
function RandomPoliceCallChance(chancePercent)
    chancePercent = math.max(0, math.min(100, chancePercent))

    local roll = math.random()

    local noise = (math.random() - 0.5) * 0.25
    local threshold = (chancePercent / 100) + noise

    if Config.Debug then return true end
    return roll <= threshold
end

-- Start cooldown timer.
function StartCooldown(key, seconds)
    LastAlertAt[key] = GetGameTimer()
    CooldownDurations[key] = seconds
end

-- Get cooldown is avctive.
function IsCooldownActive(key)
    if not LastAlertAt[key] or not CooldownDurations[key] then
        return false
    end

    local now = GetGameTimer()
    local cdMs = CooldownDurations[key] * 1000

    if LastAlertAt[key] and (now - LastAlertAt[key]) < cdMs then
        return true
    end
    return false
end

-- Clear cooldown timer.
function ClearCooldown(key)
    LastAlertAt[key] = nil
    CooldownDurations[key] = nil
end

-- Have any peds heard the gunshots outside the default radius?
function HasWitnessHeardGunshots()
    local Cfg = Config.PoliceAlerts.WitnessPeds

    if not Cfg.ENABLE then
        return true, 'seen'
    end

    local heardRadius = (Cfg.radius * 2.0)
    local hasHeardWitness = IsAnyPedInRadius(heardRadius)
    if not hasHeardWitness then
        return false, nil
    end

    return true, 'heard'
end

-- Have any peds seen the player commit the crime and called police?
function HasWitnessCalledPolice(victimn)
    local Cfg = Config.PoliceAlerts.WitnessPeds
    if not Cfg.ENABLE then
        return true
    end

    local required_distance = Cfg.radius
    local kill_timer = Cfg.time_to_kill_caller
    local max_callers = Cfg.max_callers

    local debug = Config.Debug
    local debug_radius = 0.55
    local reason = 'no_peds_nearby'

    local player_ped = PlayerPedId()
    local player_coords = GetEntityCoords(player_ped)

    local candidates = {}
    local peds = GetGamePool('CPed')

    local debugActive = false
    local debugCandidates = {}
    local debugChosen = {}

    if debug then
        debugActive = true
        CreateThread(function()
            while debugActive do
                Wait(0)

                DrawMarker(28, player_coords.x, player_coords.y, player_coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, required_distance+0.0, required_distance+0.0, required_distance+0.0, 255, 0, 170, 170, false, false, 2, false, nil, nil, false)

                for cd = 1, #debugCandidates do
                    DrawPedSphere(debugCandidates[cd], debug_radius, 255, 255, 0, 110)
                end

                for cd = 1, #debugChosen do
                    local ped = debugChosen[cd]
                    if DoesEntityExist(ped) and not IsEntityDead(ped) then
                        DrawPedSphere(ped, debug_radius + 0.08, 0, 255, 0, 170)
                        local c = GetEntityCoords(ped)
                        Draw3DText(c.x, c.y, c.z + 1.05, 'CALLING POLICE')
                    end
                end
            end
        end)
    end

    for cd = 1, #peds do
        local ped = peds[cd]
        if ped ~= player_ped and ped ~= victimn and DoesEntityExist(ped) and not IsPedAPlayer(ped) and IsPedHuman(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and not PedIsCurrentlyCallingPolice[ped] and not IsPedModelBlacklistedFromCallingPolice(ped) then
            local dist = #(player_coords - GetEntityCoords(ped))
            if dist < required_distance and CanWitnessSeePlayer(ped, player_ped) then
                candidates[#candidates+1] = { ped = ped, health = GetEntityHealth(ped) }

                if debug then
                    debugCandidates[#debugCandidates+1] = ped
                end
            end
        end
    end

    if #candidates == 0 then
        for cd = 1, #peds do
            local ped = peds[cd]
            if ped ~= player_ped and ped ~= victimn and DoesEntityExist(ped) and not IsPedAPlayer(ped) and IsPedHuman(ped) and not IsEntityDead(ped) and not PedIsCurrentlyCallingPolice[ped] then
                local dist = #(player_coords - GetEntityCoords(ped))
                if dist < required_distance and CanWitnessSeePlayer(ped, player_ped) then
                    candidates[#candidates+1] = { ped = ped, health = GetEntityHealth(ped) }

                    if debug then
                        debugCandidates[#debugCandidates+1] = ped
                    end
                end
            end
        end
    end

    if #candidates == 0 then
        if debug then
            debugActive = false
        end
        return false, reason
    end

    local chosen = {}
    for n = 1, math.min(max_callers, #candidates) do
        local idx = math.random(1, #candidates)
        chosen[#chosen+1] = candidates[idx]
        table.remove(candidates, idx)
    end

    local policeCalled = false

    RequestAnimDict('cellphone@')
    while not HasAnimDictLoaded('cellphone@') do Wait(0) end

    for _, c in ipairs(chosen) do
        PedIsCurrentlyCallingPolice[c.ped] = true
        ClearPedTasks(c.ped)
        SetBlockingOfNonTemporaryEvents(c.ped, true)
        SetPedAlertness(c.ped, 3)
        SetPedFleeAttributes(c.ped, 0, false)
        TaskTurnPedToFaceEntity(c.ped, player_ped, kill_timer * 1000)
        TaskPlayAnim(c.ped, 'cellphone@', 'cellphone_call_listen_base', 8.0, -8.0, -1, 49, 0, false, false, false)
        PlayPedAmbientSpeechNative(c.ped, 'GENERIC_SHOCKED_HIGH', 'SPEECH_PARAMS_FORCE')

        if debug then
            debugChosen[#debugChosen+1] = c.ped
        end
    end

    local function RemoveFromDebugChosen(ped)
        if not debug then return end
        for cd = #debugChosen, 1, -1 do
            if debugChosen[cd] == ped then
                table.remove(debugChosen, cd)
                return
            end
        end
    end

    local endtime = GetGameTimer() + (kill_timer * 1000)
    local nextSpeechAt = GetGameTimer() + 2000

    while GetGameTimer() < endtime do
        Wait(100)

        local harmedCount = 0
        for _, c in ipairs(chosen) do
            local harmed = (not DoesEntityExist(c.ped)) or IsEntityDead(c.ped) or (GetEntityHealth(c.ped) < c.health)
            if harmed then
                harmedCount = harmedCount + 1
                RemoveFromDebugChosen(c.ped)
            end
        end

        if harmedCount >= #chosen then
            reason = 'all_witnesses_harmed'
            break
        end

        if GetGameTimer() >= nextSpeechAt then
            for _, c in ipairs(chosen) do
                if DoesEntityExist(c.ped) and not IsEntityDead(c.ped) then
                    PlayPedAmbientSpeechNative(c.ped, 'GENERIC_SHOCKED_HIGH', 'SPEECH_PARAMS_FORCE')
                end
            end
            nextSpeechAt = GetGameTimer() + 2000
        end
    end

    if GetGameTimer() >= endtime then
        policeCalled = true
    end

    for _, c in ipairs(chosen) do
        if DoesEntityExist(c.ped) then
            StopAnimTask(c.ped, 'cellphone@', 'cellphone_call_listen_base', 8.0)
            SetBlockingOfNonTemporaryEvents(c.ped, false)
            TaskReactAndFleePed(c.ped, player_ped)
        end
        PedIsCurrentlyCallingPolice[c.ped] = nil
    end

    if debug then
        debugActive = false
        debugCandidates = {}
        debugChosen = {}
    end

    return policeCalled, reason
end

if Config.Debug and Config.PoliceAlerts.WitnessPeds.ENABLE then
    CreateThread(function()
        while true do
            Wait(0)
            for _, zone in pairs(Config.PoliceAlerts.WitnessPeds.NoSnitchingZones) do
                DrawMarker(28, zone.coords.x, zone.coords.y, zone.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, zone.radius+0.0, zone.radius+0.0, zone.radius+0.0, 255, 0, 0, 80, false, false, 2, false, nil, nil, false)
            end
        end
    end)
end