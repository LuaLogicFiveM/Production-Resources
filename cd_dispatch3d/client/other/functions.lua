--#####################################################################
-- Perms
--#####################################################################

function IsAllowed()
    local hasCorrectJob = GetMultiJob(GetJobName())
    local isOnDuty = GetJobDuty()

    if hasCorrectJob and isOnDuty then
        return true
    else
        return false, ('Job: %s, On Duty: %s'):format(tostring(hasCorrectJob), tostring(isOnDuty))
    end
end

function IsAllowed_features(perm)
    local job = GetJobName()
    local perms = Config.Perms[perm][job]
    if not perms then return false end
    return HasJob(perms)
end

--#####################################################################
-- NUI Focus
--#####################################################################

function ToggleNUIFocus_2()
    NUI_status = true

    CreateThread(function()
        SetUserRadioControlEnabled(false)

        local disabled_keys = {1,2,21,24,25,47,58,75,106,140,141,142,143,245,257,263,264}

        while NUI_status do
            Wait(5)
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)

            for _, key in ipairs(disabled_keys) do
                DisableControlAction(0, key, true)
            end

            SetPlayerCanDoDriveBy(PlayerId(), false)
            HudWeaponWheelIgnoreSelection()
        end

        -- Once NUI_status is false, disable everything
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        SetUserRadioControlEnabled(true)
        SetPlayerCanDoDriveBy(PlayerId(), true)

        local count = 0
        local extra_keys = {177, 200, 202, 322}
        while count < 100 do
            Wait(0)
            count = count + 1
            for _, key in ipairs(extra_keys) do
                DisableControlAction(0, key, true)
            end
        end
    end)
end

--#####################################################################
-- Small UI Visibility
--#####################################################################

CreateThread(function()
    local small_ui_hidden = false
    while true do
        Wait(1000)

        if not NUI_status then
            local pause_menu_open = IsPauseMenuActive()
            local should_hide = pause_menu_open and not small_ui_hidden and UI_open.small
            local should_show = not pause_menu_open and small_ui_hidden

            if should_hide then
                HideSmallUI()
                small_ui_hidden = true
            elseif should_show then
                ShowSmallUI()
                small_ui_hidden = false
            end
        end
    end
end)

--#####################################################################
-- Dispatch Call Sound
--#####################################################################

function BlipSound(sound)
    local s = tostring(sound)
    if s == '1' then
        DispatchSound('normal')
    elseif s == '2' then
        DispatchSound('normal')
        Wait(800)
        DispatchSound('normal')
    elseif s == '3' or s == '4' then
        if Config.PanicButton.play_sound_in_distance then
            TriggerServerEvent('cd_dispatch:PanicSoundInDistance', GetClosestPlayers(5, 'serverid'))
        else
            DispatchSound('panic')
        end
    end
end

RegisterNetEvent('cd_dispatch:PanicSoundInDistance', function()
    DispatchSound('panic')
end)

--#####################################################################
-- Animations & Props
--#####################################################################

tablet_prop = nil

function TabletAnimation(toggle)
    local ped = PlayerPedId()
    if toggle then
        PlayAnimation('amb@world_human_seat_wall_tablet@female@base', 'base', -1)
        tablet_prop = CreateObject(`prop_cs_tablet`, 0.0, 0.0, 0.0, true, true, true)
        AttachEntityToEntity(
            tablet_prop,
            ped,
            GetPedBoneIndex(ped, 57005),
            0.17, 0.10, -0.13,
            20.0, 180.0, 180.0,
            true, true, false, true, 1, true
        )
        SetModelAsNoLongerNeeded(tablet_prop)
    else
        StopAnimTask(ped, 'amb@world_human_seat_wall_tablet@female@base', 'base', 8.0)
        if tablet_prop then
            NetworkRequestControlOfEntity(tablet_prop)
            SetEntityAsMissionEntity(tablet_prop, true, true)
            DeleteEntity(tablet_prop)
            tablet_prop = nil
        end
    end
end

--#####################################################################
-- Vehicle Utilities
--#####################################################################

function GetVehicleColour(vehicle)
    local primary, _ = GetVehicleColours(vehicle)
    for _, colourTable in pairs(CarColours) do
        for _, colour in pairs(colourTable) do
            if colour.index == primary then
                return colour.label
            end
        end
    end
    return nil
end

function GetVehicleLabel(vehicle)
    local vehicle_model = GetEntityModel(vehicle)
    local vehiclesData = GetSharedVehicles()
    if vehiclesData[vehicle_model] and vehiclesData[vehicle_model].label then
        return vehiclesData[vehicle_model].label
    end

    return GetDefaultVehicleLabel(vehicle)
end

function GetHeading(heading)
    if heading >= 315 or heading < 45 then
        return Locale('north_bound')
    elseif heading >= 45 and heading < 135 then
        return Locale('west_bound')
    elseif heading >= 135 and heading < 225 then
        return Locale('south_bound')
    elseif heading >= 225 and heading < 315 then
        return Locale('east_bound')
    end
    return ''
end

function GetPlate(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    if GetResourceState('cd_garage') == 'started' then
        local garage_cfg = exports['cd_garage']:GetConfig().PlateFormats

        if garage_cfg == 'trimmed' then
            return Trim(plate)

        elseif garage_cfg == 'with_spaces' then
            return plate

        elseif garage_cfg == 'mixed' then
            return (plate:gsub("^%s*(.-)%s*$", "%1"))

        end
    end
    return (plate:gsub("^%s*(.-)%s*$", "%1"))
end

function GetAllPlateFormats(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    return {
        trimmed     = Trim(plate),
        with_spaces = plate,
        mixed       = (plate:gsub("^%s*(.-)%s*$", "%1"))
    }
end

--#####################################################################
-- Player Utilities
--#####################################################################

function IsDeadOrCuffed()
    local ped = PlayerPedId()

    if IsPedCuffed(ped) then
        return true
    end

    if IsEntityDead(ped) or IsPedDeadOrDying(ped, true) then
        return true
    end

    return false
end

function GetPedSex(ped)
    if IsPedModel(ped, `mp_f_freemode_01`) then
        return Locale('female')
    elseif IsPedModel(ped, `mp_m_freemode_01`) then
        return Locale('male')
    else
        return Locale('person')
    end
end

--#####################################################################
-- Get Street Names
--#####################################################################

function GetStreetNames(coords)
    local s1 = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    local zone = GetNameOfZone(coords.x, coords.y, coords.z)
    return {
        street1 = s1 or '',
        street2 = ZoneNames[zone] or ''
    }
end

--#####################################################################
-- Resource Cleanup on Stop
--#####################################################################

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    StopAnimTask(PlayerPedId(), 'amb@world_human_seat_wall_tablet@female@base', 'base', 8.0)
    NetworkRequestControlOfEntity(tablet_prop)
    SetWaypointOff()
    if tablet_prop then
        SetEntityAsMissionEntity(tablet_prop, true, true)
        DeleteEntity(tablet_prop)
    end
end)

--#####################################################################
-- Test Command
--#####################################################################

if Config.EnableTestCommand then
    RegisterCommand('dispatchtest', function()
        -- THIS IS A TEST COMMAND. Example usage only.
        local data = exports['cd_dispatch3d']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = { GetJobName() },
            coords    = data.coords,
            title     = '10-15 - Store Robbery',
            message   = 'A ' .. data.sex .. ' robbing a store at ' .. data.street,
            flash     = false,
            sound     = 1,
            blip = {
                sprite  = 431,
                scale   = 1.2,
                colour  = 3,
                flashes = false,
                text    = '911 - Store Robbery',
                time    = 5,
                radius  = 0,
            }
        })
    end, false)
end