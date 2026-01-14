local pills, blunts = 0, 0
local popping, smoking = false, false

local function PopPill()
    if popping then return end
    popping = true
    pills = pills + 1
    if lib.progressCircle({
        label = 'Popping Pill...',
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = false,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = 'mp_suicide',
            clip = 'pill'
        },
    }) then
        lib.notify({ title = 'Drugs', description = 'You popped a pill, these symptoms will last for 2 minutes.', type = 'success', position = 'top' })
        SetPedMoveRateOverride(cache.playerId, 1.1)
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.1)
        SetTimecycleModifier("vehicle_subint")
        SetTimecycleModifierStrength(1.0)
        ShakeGameplayCam("DRUNK_SHAKE", 0.5)
        ExecuteCommand('walk hipster')
    end
    Wait(120000)
    if pills > 1 then
        lib.notify({ title = 'Drugs', description = 'You passed out from popping too many pills', type = 'error', position = 'top' })
        SetPedToRagdoll(cache.ped, 5000, 5000, 0, false, false, false)
        if lib.progressCircle({
            label = 'Passed Out...',
            duration = 5000,
            position = 'middle',
            useWhileDead = false,
            allowRagdoll = true,
            canCancel = false,
            disable = {
                car = false,
                move = true,
                mouse = false,
                combat = true,
            },
        }) then
            lib.notify({ title = 'Drugs', description = 'Your symptoms have cleared up', type = 'success', position = 'top' })
            ClearTimecycleModifier()
            StopGameplayCamShaking(true)
            SetPedMoveRateOverride(cache.playerId, 1.0)
            SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
            ExecuteCommand('walk reset')
        end
    else
        lib.notify({ title = 'Drugs', description = 'Your symptoms have cleared up', type = 'success', position = 'top' })
        ClearTimecycleModifier()
        StopGameplayCamShaking(true)
        SetPedMoveRateOverride(cache.playerId, 1.0)
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
        ExecuteCommand('walk reset')
    end
    popping = false
end exports('PopPill', PopPill)

local function SmokeJointLarge()
    if smoking then return end
    smoking = true
    blunts = blunts+1
    local coords = GetEntityCoords(cache.ped)
    local obj = CreateObject(GetHashKey('brum_joint_challenge_lit'), coords.x, coords.y, coords.z+0.2, true, true, true)
    AttachEntityToEntity(obj, cache.ped, GetPedBoneIndex(cache.ped, 28422), -0.2, 0.0, 0.0, 0.0, 0.0, 270.0, true, true, false, true, 1, true)
    if lib.progressCircle({
        label = 'Smoking Joint...',
        duration = 15000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = false,
            move = false,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = 'amb@world_human_aa_smoke@male@idle_a',
            clip = 'idle_c'
        },
    }) then
        DeleteEntity(obj)
        SetPedMoveRateOverride(cache.playerId, 1.1)
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.1)
        SetTimecycleModifier("vehicle_subint")
        SetTimecycleModifierStrength(1.0)
        ShakeGameplayCam("DRUNK_SHAKE", 0.5)
        ExecuteCommand('walk hipster')
    end
    Wait(60000)
    if blunts > 5 then
        lib.notify({
            title = 'Drugs',
            description = 'You greened out from smoking too much weed',
            type = 'error',
            position = 'top'
        })
        SetPedToRagdoll(cache.ped, 5000, 5000, 0, false, false, false)
        if lib.progressCircle({
            label = 'Passed Out...',
            duration = 5000,
            position = 'middle',
            useWhileDead = false,
            allowRagdoll = true,
            canCancel = false,
            disable = {
                car = false,
                move = true,
                mouse = false,
                combat = true,
            },
        }) then
            lib.notify({ title = 'Drugs', description = 'Your symptoms have cleared up', type = 'success', position = 'top' })
            ClearTimecycleModifier()
            StopGameplayCamShaking(true)
            SetPedMoveRateOverride(cache.playerId, 1.0)
            SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
            ExecuteCommand('walk reset')
        end
    else
        lib.notify({ title = 'Drugs', description = 'Your symptoms have cleared up', type = 'success', position = 'top' })
        ClearTimecycleModifier()
        StopGameplayCamShaking(true)
        SetPedMoveRateOverride(cache.playerId, 1.0)
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
        ExecuteCommand('walk reset')
    end
    smoking = false
end

exports('SmokeJointLarge', SmokeJointLarge)

local function SmokeJoint()
    if smoking then return end
    smoking = true
    blunts = blunts + 1
    local coords = GetEntityCoords(cache.ped)
    local obj = CreateObject(GetHashKey('brum_joint_super_lit'), coords.x, coords.y, coords.z+0.2, true, true, true)
    AttachEntityToEntity(obj, cache.ped, GetPedBoneIndex(cache.ped, 28422), -0.085, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    if lib.progressCircle({
        label = 'Smoking Joint...',
        duration = 10000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = false,
            move = false,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = 'amb@world_human_aa_smoke@male@idle_a',
            clip = 'idle_c'
        },
    }) then
        DeleteEntity(obj)
        SetPedMoveRateOverride(cache.playerId, 1.1)
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.1)
        SetTimecycleModifier("vehicle_subint")
        SetTimecycleModifierStrength(1.0)
        ShakeGameplayCam("DRUNK_SHAKE", 0.5)
        ExecuteCommand('walk hipster')
    end
    Wait(45000)
    if blunts > 10 then
        lib.notify({ title = 'Drugs', description = 'You greened out from smoking too much weed', type = 'error', position = 'top' })
        SetPedToRagdoll(cache.ped, 5000, 5000, 0, false, false, false)
        if lib.progressCircle({
            label = 'Passed Out...',
            duration = 5000,
            position = 'middle',
            useWhileDead = false,
            allowRagdoll = true,
            canCancel = false,
            disable = {
                car = false,
                move = true,
                mouse = false,
                combat = true,
            },
        }) then
            lib.notify({ title = 'Drugs', description = 'Your symptoms have cleared up', type = 'success', position = 'top' })
            ClearTimecycleModifier()
            StopGameplayCamShaking(true)
            SetPedMoveRateOverride(cache.playerId, 1.0)
            SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
            ExecuteCommand('walk reset')
        end
    else
        lib.notify({ title = 'Drugs', description = 'Your symptoms have cleared up', type = 'success', position = 'top' })
        ClearTimecycleModifier()
        StopGameplayCamShaking(true)
        SetPedMoveRateOverride(cache.playerId, 1.0)
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
        ExecuteCommand('walk reset')
    end
    smoking = false
end

exports('SmokeJoint', SmokeJoint)