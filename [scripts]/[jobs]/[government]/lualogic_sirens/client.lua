local config = require 'config'

-- soundId Tables --
local sirenVehicles = {}
local hornVehicles = {}
local sirens = {
    ['Code 3 RLS'] = {
        [1] = {
            label = 'Wail',
            name = 'RLS_WAIL',
            ref = 'CODE3RLS_SOUNDSET'
        },
        [2] = {
            label = 'Yelp',
            name = 'RLS_YELP',
            ref = 'CODE3RLS_SOUNDSET'
        },
        [3] = {
            label = 'Warning',
            name = 'RLS_WARNING',
            ref = 'CODE3RLS_SOUNDSET'
        }
    },
    ['Whelen Gamma 2'] = {
        [1] = {
            label = 'Wail',
            name = 'GAMMA_WAIL',
            ref = 'WHELENGAMMA2_SOUNDSET'
        },
        [2] = {
            label = 'Yelp',
            name = 'GAMMA_YELP',
            ref = 'WHELENGAMMA2_SOUNDSET'
        },
        [3] = {
            label = 'Warn',
            name = 'GAMMA_WARN',
            ref = 'WHELENGAMMA2_SOUNDSET'
        },
        [4] = {
            label = 'Riot',
            name = 'GAMMA_RIOT',
            ref = 'WHELENGAMMA2_SOUNDSET'
        },
    },
    ['Federal Signal PA4000'] = {
        [1] = {
            label = 'Wail',
            name = 'PA_WAIL',
            ref = 'FEDSIGPA4000_SOUNDSET'
        },
        [2] = {
            label = 'Yelp',
            name = 'PA_YELP',
            ref = 'FEDSIGPA4000_SOUNDSET'
        },
        [3] = {
            label = 'Warning',
            name = 'PA_WARNING',
            ref = 'FEDSIGPA4000_SOUNDSET'
        },
    },
    ['Powercall DX5'] = {
        [1] = {
            label = 'Wail',
            name = 'DX5WAIL',
            ref = 'DX5_SOUNDSET'
        },
        [2] = {
            label = 'Yelp',
            name = 'DX5YELP',
            ref = 'DX5_SOUNDSET'
        },
        [3] = {
            label = 'Inter',
            name = 'DX5INTER',
            ref = 'DX5_SOUNDSET'
        },
        [4] = {
            label = 'Hi-Lo',
            name = 'DX5HILO',
            ref = 'DX5_SOUNDSET'
        },
        [5] = {
            label = 'Phaser',
            name = 'DX5PCALLP',
            ref = 'DX5_SOUNDSET'
        },
    },
    ['Whelen Cencom Sapphire'] = {
        [1] = {
            label = 'Wail',
            name = 'SAPP_WAIL',
            ref = 'CENCOMSAPPHIRE_SOUNDSET'
        },
        [2] = {
            label = 'Yelp',
            name = 'SAPP_YELP',
            ref = 'CENCOMSAPPHIRE_SOUNDSET'
        },
        [3] = {
            label = 'Pier',
            name = 'SAPP_PIER',
            ref = 'CENCOMSAPPHIRE_SOUNDSET'
        },
    },
    ['Federal Signal Smart Siren'] = {
        [1] = {
            label = 'Wail',
            name = 'SSWAIL',
            ref = 'SMARTSIREN_SOUNDSET'
        },
        [2] = {
            label = 'Yelp',
            name = 'SSYELP',
            ref = 'SMARTSIREN_SOUNDSET'
        },
        [3] = {
            label = 'Prty',
            name = 'SSPRTY',
            ref = 'SMARTSIREN_SOUNDSET'
        },
        [4] = {
            label = 'Hi-Lo',
            name = 'SSHILO',
            ref = 'SMARTSIREN_SOUNDSET'
        }
    }
}

local horns = {
    ['Code 3 RLS'] = {
        label = 'Code 3 Horn',
        name = 'RLS_AIRHORN',
        ref = 'CODE3RLS_SOUNDSET'
    },
    ['Whelen Gamma 2'] = {
        label = 'Hi-Lo',
        name = 'GAMMA_AIRHORN',
        ref = 'WHELENGAMMA2_SOUNDSET'
    },
    ['Federal Signal PA4000'] = {
        label = 'Hi-Lo',
        name = 'PA_AIRHORN',
        ref = 'FEDSIGPA4000_SOUNDSET'
    },
    ['Powercall DX5'] = {
        label = 'Hi-Lo',
        name = 'SAPP_HORN',
        ref = 'DX5_SOUNDSET'
    },
    ['Whelen Cencom Sapphire'] = {
        label = 'Hi-Lo',
        name = 'DX5HORN',
        ref = 'CENCOMSAPPHIRE_SOUNDSET'
    },
    ['Federal Signal Smart Siren'] = {
        label = 'Hi-Lo',
        name = 'SSHORN',
        ref = 'SMARTSIREN_SOUNDSET'
    }
}

-- Natives Used --
local Wait = Wait
local TriggerServerEvent = TriggerServerEvent
local SetVehRadioStation = SetVehRadioStation
local SetVehicleRadioEnabled = SetVehicleRadioEnabled
local DisableControlAction = DisableControlAction
local GetVehicleClass = GetVehicleClass
local IsPedInAnyHeli = IsPedInAnyHeli
local IsPedInAnyPlane = IsPedInAnyPlane
local PlaySoundFromEntity = PlaySoundFromEntity
local GetSoundId = GetSoundId
local DoesEntityExist = DoesEntityExist
local IsEntityDead = IsEntityDead
local StopSound = StopSound
local ReleaseSoundId = ReleaseSoundId
local AddStateBagChangeHandler = AddStateBagChangeHandler
local NetworkGetEntityOwner = NetworkGetEntityOwner
local GetResourceKvpString = GetResourceKvpString
local GetResourceKvpInt = GetResourceKvpInt
local IsVehicleSirenOn = IsVehicleSirenOn

local sirenMax = GetResourceKvpInt('siren_max') ~= 0 and GetResourceKvpInt('siren_max') or 3
local sirenCategory = GetResourceKvpString('siren_category') or 'Code 3 RLS'

-- Localized Functions --
local function releaseSound(veh, soundId, forced)
    if forced and (DoesEntityExist(veh) and not IsEntityDead(veh)) then return end
    StopSound(soundId)
    ReleaseSoundId(soundId)
    return true
end

local function isVehAllowed()
    if cache.seat ~= -1 or GetVehicleClass(cache.vehicle) ~= 18 or IsPedInAnyHeli(cache.vehicle) or IsPedInAnyPlane(cache.vehicle) then
        return false
    end
    return true
end

-- Cleanup Loop --
CreateThread(function()
    RequestScriptAudioBank("DLC_CODE3PACK\\CODE3RLS", true)
    RequestScriptAudioBank("DLC_WHELENPACK\\WHELENGAMMA2", true)
    RequestScriptAudioBank("DLC_FEDSIGPACK\\FEDSIGPA4000", true)
    RequestScriptAudioBank("DLC_DX5PACK\\DX5", true)
    RequestScriptAudioBank("DLC_CENSAPPHIRE\\CENCOMSAPPHIRE", true)
    RequestScriptAudioBank("DLC_SMARTSIREN\\SMARTSIREN", true)
    while true do
        for veh, soundId in pairs(sirenVehicles) do
            if not IsVehicleSirenOn(veh) then
                releaseSound(veh, soundId)
            end

            if releaseSound(veh, soundId, true) then
                sirenVehicles[veh] = nil
            end
        end

        for veh, soundId in pairs(hornVehicles) do
            if releaseSound(veh, soundId, true) then
                hornVehicles[veh] = nil
            end
        end

        Wait(1000)
    end
end)

-- Cache Events --
lib.onCache('seat', function(seat)
    if seat ~= -1 then return end

    SetTimeout(0, function()
        if not isVehAllowed() then return end

        SetVehRadioStation(cache.vehicle, 'OFF')
        SetVehicleRadioEnabled(cache.vehicle, false)

        if not Entity(cache.vehicle).state.stateEnsured then
            TriggerServerEvent('lorp_sirens:server:sync', VehToNet(cache.vehicle))
        end

        while cache.seat == -1 do
            DisableControlAction(0, 80, true) -- R
            DisableControlAction(0, 81, true) -- .
            DisableControlAction(0, 82, true) -- ,
            DisableControlAction(0, 83, true) -- =
            DisableControlAction(0, 84, true) -- -
            DisableControlAction(0, 85, true) -- Q
            DisableControlAction(0, 86, true) -- E
            DisableControlAction(0, 172, true) -- Up arrow
            Wait(0)
        end
    end)
end)

lib.onCache('vehicle', function(value)
    if value or cache.seat ~= -1 then return end

    local state = Entity(cache.vehicle).state
    if not state.stateEnsured then return end

    if config.sirenShutOff then
        if state.sirenMode ~= 0 then
            state:set('sirenMode', 0, true)
        end
    end

    if state.horn then
        state:set('horn', false, true)
    end
end)

-- Statebags & Keybinds --
local function stateBagWrapper(keyFilter, cb)
    return AddStateBagChangeHandler(keyFilter, '', function(bagName, _, value, _, replicated)
        local netId = tonumber(bagName:gsub('entity:', ''), 10)
        local loaded = netId and lib.waitFor(function()
            if NetworkDoesEntityExistWithNetworkId(netId) then return true end
        end, 'Timeout while waiting for entity to exist', 5000)

        local entity = loaded and NetToVeh(netId)
        if entity then
            local amOwner = NetworkGetEntityOwner(entity) == cache.playerId

            if amOwner == replicated then
                cb(entity, value)
            end
        end
    end)
end

-- Police Horns --

local restoreSiren = 0

stateBagWrapper('horn', function(veh, value)
    local relHornId = hornVehicles[veh]

    if relHornId then
        if releaseSound(veh, relHornId) then
            hornVehicles[veh] = nil
        end
    end

    if not value then return end
    local soundId = GetSoundId()

    hornVehicles[veh] = soundId
    local hornData = horns[sirenCategory]
    PlaySoundFromEntity(soundId, hornData.name, veh, hornData.ref, false, 0)
end)

local policeHorn = lib.addKeybind({
    name = 'policeHorn',
    description = 'Hold this button to use your vehicle Horn',
    defaultKey = config.controls.policeHorn,
    onPressed = function()
        if not isVehAllowed() then return end

        local state = Entity(cache.vehicle).state
        if not state.stateEnsured then return end

        if state.sirenMode == 0 then
            restoreSiren = state.sirenMode
            state:set('sirenMode', 0, true)
        end

        state:set('horn', not state.horn, true)
    end,
    onReleased = function()
        if not cache.vehicle or GetVehicleClass(cache.vehicle) ~= 18 then return end

        local state = Entity(cache.vehicle).state
        SetTimeout(0, function()
            if state.horn then
                state:set('horn', false, true)
            end

            if state.sirenMode == 0 and restoreSiren > 0 then
                state:set('sirenMode', restoreSiren, true)
                restoreSiren = 0
            end
        end)
    end,
})

-- Siren Modes and Toggles --
stateBagWrapper('sirenMode', function(veh, soundMode)
    local usedSound = sirenVehicles[veh]
    if usedSound then
        if releaseSound(veh, usedSound) then
            sirenVehicles[veh] = nil
        end
    end

    if soundMode == 0 or not soundMode then return end

    local soundId = GetSoundId()
    sirenVehicles[veh] = soundId

    local sirenData = sirens[sirenCategory][soundMode]
    PlaySoundFromEntity(soundId, sirenData.name, veh, sirenData.ref, false, 0)
end)

stateBagWrapper('lightsOn', function(veh, value)
    SetVehicleHasMutedSirens(veh, true)
    SetVehicleSiren(veh, value)
end)

local policeLights = lib.addKeybind({
    name = 'policeLights',
    description = 'Press this button to use your siren',
    defaultKey = config.controls.policeLights,
    onPressed = function()
        if not isVehAllowed() then return end

        local state = Entity(cache.vehicle).state

        if not state.stateEnsured then return end

        local curMode = state.lightsOn
        state:set('lightsOn', not curMode, true)

        if not curMode or state.sirenMode == 0 then return end

        state:set('sirenMode', 0, true)
    end
})

local sirenToggle = lib.addKeybind({
    name = 'sirenToggle',
    description = 'Press this button to use your siren',
    defaultKey = config.controls.sirenToggle,
    onPressed = function()
        if not isVehAllowed() then return end

        local state = Entity(cache.vehicle).state
        if not state.stateEnsured or not state.lightsOn or state.horn then return end

        if not IsVehicleSirenOn(cache.vehicle) then return end

        local newSiren = state.sirenMode > 0 and 0 or 1
        state:set('sirenMode', newSiren, true)
    end
})

local Rpressed = false
lib.addKeybind({
    name = 'sirenCycle',
    description = 'Press this button to cycle through your sirens',
    defaultKey = config.controls.sirenCycle,
    onPressed = function()
        if not isVehAllowed() then return end

        local state = Entity(cache.vehicle).state
        if not state.stateEnsured then return end

        if not IsVehicleSirenOn(cache.vehicle) then return end

        if state.sirenMode == 0 and not Rpressed then
            local sirenMode = state.sirenMode > 0 and 0 or 1
            state:set('sirenMode', sirenMode, true)
            sirenToggle:disable(true)
            policeLights:disable(true)
            policeHorn:disable(true)
            Rpressed = true
        elseif state.sirenMode > 0 and not Rpressed then
            local newSiren = state.sirenMode + 1 > sirenMax and 1 or state.sirenMode + 1
            state:set('sirenMode', newSiren, true)
            local sirenData = sirens[sirenCategory][newSiren]
            lib.notify({title = 'Sirens', description = ('You have cycled to %s'):format(sirenData.label), type = 'success', position = 'center-left'})
        end
    end,
    onReleased = function()
        if not Rpressed then return end

        sirenToggle:disable(false)
        policeLights:disable(false)
        policeHorn:disable(false)

        if cache.vehicle then
            SetTimeout(0, function()
                local state = Entity(cache.vehicle).state
                if state.sirenMode > 0 then
                    state:set('sirenMode', 0, true)
                end
                Rpressed = false
            end)
        end
    end
})


-- Menu Addon
local function selectSirenPack(label, args)
    SetResourceKvpInt('siren_max', #args)
    SetResourceKvp('siren_category', label)
    sirenCategory = label
    sirenMax = #args
    lib.notify({title = 'Sirens', description = 'You have selected '..label, type = 'success', position = 'top'})
end

local function previewSiren(sirenData)
    local soundId = GetSoundId()
    PlaySoundFromEntity(soundId, sirenData.name, cache.vehicle, sirenData.ref, false, 0)
    SetTimeout(3000, function()
        releaseSound(cache.vehicle, soundId)
        lib.showContext('sirens_main_category')
    end)
end

local function sirensMenuCategory(label, sirenData)
    local menu = {
        id = 'sirens_main_category',
        menu = 'sirens_main',
        title = label,
        options = {}
    }

    for _, data in ipairs(sirenData) do
        menu.options[#menu.options+1] = {
            title = data.label,
            description = 'Click to Preview (3 Seconds)',
            args = data,
            onSelect = function(args)
                if not cache.vehicle then
                    return lib.notify({title = 'Sirens', description = 'You must be in a vehicle to preview a siren', type = 'error', position = 'top'})
                end

                previewSiren(args)
            end,
        }
    end

    menu.options[#menu.options+1] = {
        title = 'Select Siren Pack',
        args = sirenData,
        icon = 'square-check',
        iconColor = 'green',
        onSelect = function(args)
            selectSirenPack(label, args)
        end,
    }

    lib.registerContext(menu)
    lib.showContext(menu.id)
end

local function sirensMenu()
    local menu = {
        id = 'sirens_main',
        title = 'Sirens Menu',
        options = {
            {
                title = 'Selected: '..sirenCategory
            }
        }
    }

    for label, data in pairs(sirens) do
        menu.options[#menu.options+1] = {
            title = label,
            args = data,
            arrow = true,
            onSelect = function(args)
                sirensMenuCategory(label, args)
            end,
        }
    end

    lib.registerContext(menu)
    lib.showContext(menu.id)
end

RegisterCommand('sirens', function()
    sirensMenu()
end, false)