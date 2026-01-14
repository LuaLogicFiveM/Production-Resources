local knockedOut = false

local function wakeUp()
    if not knockedOut then return end
    ClearTimecycleModifier()
    lib.hideTextUI()
    knockedOut = false
end

local function knockedOutLoop()
    SetTimecycleModifier('hud_def_blur')
    lib.showTextUI('You are currently knocked out..', { position = 'top-center' })

    CreateThread(function()
        while GetEntityHealth(cache.ped) < GetEntityMaxHealth(cache.ped) and knockedOut do
            Wait(2000)
            SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) + 5)
        end
    end)

    CreateThread(function()
        while knockedOut do
            Wait(100)
            SetPedToRagdoll(cache.ped, 500, 500, 0, 0, 0, 0)
            ResetPedRagdollTimer(cache.ped)
            if IsEntityDead(cache.ped) then
                wakeUp()
            end
        end
    end)
end

AddEventHandler('gameEventTriggered', function(event, data)
    if event ~= "CEventNetworkEntityDamage" then return end

    local victim = NetworkGetPlayerIndexFromPed(data[1])
    if victim ~= cache.playerId or not IsPedInMeleeCombat(cache.ped) then return end

    if HasPedBeenDamagedByWeapon(cache.ped, `WEAPON_UNARMED`, 0) then
        if GetEntityHealth(cache.ped) < 120 and not knockedOut then
            knockedOut = true
            knockedOutLoop()
            SetTimeout(10 * 1000, wakeUp)
        end
    end
end)
