-- Seat Swap
local function switchSeat(_, args)
    local seatIndex = tonumber(args[1]) - 1

    if seatIndex < -1 or seatIndex >= 4 then
        lib.notify({title = 'Vehicle', description = 'That seat is not recognized', type = 'error', position = 'top'})
    else
        if cache.vehicle then
            SetPedIntoVehicle(cache.ped, cache.vehicle, seatIndex)
        end
    end
end

RegisterCommand("seat", switchSeat, false)

-- Reload Phone
RegisterCommand("reloadphone", function()
    exports['lb-phone']:ReloadPhone()
end, false)

-- Delete Vehicle
RegisterCommand( "dv", function()
    if cache.vehicle then
        local modelName = GetDisplayNameFromVehicleModel(cache.vehicle)
        if modelName ~= 'djn_yacht_veh' then
            SetEntityAsMissionEntity(cache.vehicle, true, true)
            DeleteVehicle(cache.vehicle)
        end
    else
        lib.notify({
            title = 'System',
            description = 'You are not in a vehicle',
            type = 'warning',
            position = 'top',
        })
    end
end, false)

-- Texture Loss Fix
RegisterCommand("fixtextures", function()
    local coords = GetEntityCoords(cache.ped)
    SetFocusPosAndVel(coords.x+3000.0, coords.y+3000.0, coords.z+200.0, 0.0, 0.0, 0.0)
    Wait(250)
    SetFocusEntity(cache.ped)
end, false)

-- Hair Fix
local currentHair = {
    id = -1,
    color_1 = 0,
    color_2 = 0,
}

RegisterCommand("fixhair", function()
    if currentHair.id == -1 then
        currentHair.id = GetPedDrawableVariation(cache.ped, 2)
        currentHair.color_1 = GetPedTextureVariation(cache.ped, 2)
        currentHair.color_2 = GetPedPaletteVariation(cache.ped, 2)
        SetPedComponentVariation(cache.ped, 2, 0, 0, 0)
    else
        SetPedComponentVariation(cache.ped, 2, currentHair.id, currentHair.color_1, currentHair.color_2)
        currentHair.id = -1
    end
end, false)

-- Toggle Radio Clicks
local voice = exports['pma-voice']
RegisterCommand('toggleradioclicks', function(source, args)
    if not args[1] then
        return lib.notify({title = 'Radio', description = 'You must provide a state. 0 = off, 1 = on', position = 'top', type = 'error'})
    end

    local toggle = tonumber(args[1])

    if toggle == 0 or toggle == 1 then
        voice:setVoiceProperty('micClicks', toggle)
        local bool = toggle == 0 and 'off' or 'on'
        lib.notify({title = 'Radio', description = 'You set your radio clicks to ' .. bool, position = 'top', type = 'success'})
    else
        lib.notify({title = 'Radio', description = 'You must provide a 1 or 0', position = 'top', type = 'error'})
    end
end, false)

-- Admin Marker Teleport
RegisterCommand("tpm", function()
    local hasPerms = lib.callback.await('lorp_packed:server:hasPerms', false)
    if not hasPerms then return end
    local waypointBlip = GetFirstBlipInfoId(8)
    if DoesBlipExist(waypointBlip) then
        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())
        local x  = coord.x
        local y = coord.y
        for z = 1, 1000 do
            SetPedCoordsKeepVehicle(cache.ped, x, y, z + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(x, y, z + 0.0)
            if foundGround then
                SetPedCoordsKeepVehicle(cache.ped, x, y, z + 0.0)
                break
            end
            Wait(5)
        end
    end
end, false)

-- Idle Camera
RegisterCommand('idlecam', function()
    local status = GetResourceKvpInt("idle_cam")

    if status == 0 then
        DisableIdleCamera(true)
        SetPedCanPlayAmbientAnims(cache.ped, false)
        SetResourceKvpInt("idle_cam", 1)
    elseif status == 1 then
        DisableIdleCamera(false)
        SetPedCanPlayAmbientAnims(cache.ped, true)
        SetResourceKvpInt("idle_cam", 0)
    end
end, false)

CreateThread(function()
    local idle_cam_kvp = GetResourceKvpInt("idle_cam")
    if idle_cam_kvp == 0 then return end

    DisableIdleCamera(true)
    SetPedCanPlayAmbientAnims(cache.ped, false)
end)

-- weapon inspect
local weaponAnimations = {
    [`GROUP_PISTOL`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_THROWN`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_SHOTGUN`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_SMG`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_RIFLE`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_SNIPER`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_MELEE`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_MG`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_STUNGUN`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_HEAVY`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
}

local function playFidgetAnim()
    local weapon = GetSelectedPedWeapon(cache.ped)
    local weaponGroup = GetWeapontypeGroup(weapon)
    local animData = weaponAnimations[weaponGroup]

    if not animData then return end

    local animDict = animData.dict
    local animName = animData.anim

    if not IsPedArmed(cache.ped, 7) then return end
    if IsEntityPlayingAnim(cache.ped, animDict, animName, 3) then return end

    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
    end

    TaskPlayAnim(cache.ped, animDict, animName, 8.0, -8.0, -1, 48, 0, false, false, false)

    CreateThread(function()
        while IsEntityPlayingAnim(cache.ped, animDict, animName, 3) do
            if IsPedShooting(cache.ped) then
                StopAnimTask(cache.ped, animDict, animName, 1.0)
                break
            end
            Wait(0)
        end
    end)
end

RegisterCommand("inspectweapon", function()
    playFidgetAnim()
end, false)

RegisterKeyMapping("inspectweapon", "~g~[Anim]~s~ Inspect Weapon", "MOUSE_BUTTON", "MOUSE_MIDDLE")