local config = require 'resource.switch.shared'
local ox_inventory = exports.ox_inventory
local CURRENT_SWITCH = nil

local function GetRPM(num)
    local result = ((1.000001 - (num)) * 200)
    result = (result > 200 and 200 or result)
    result = (result < 1 and 1 or result)
    return math.floor(result)
end

local function CheckCurrentSwitch(data)
    if not CURRENT_SWITCH or not data then return false end
    for k, v in pairs(CURRENT_SWITCH) do
        if (type(v) == "string" or type(v) == "number") then
            if (v ~= data[k]) then
                return false
            end
        end
    end
    return true
end

local function SetSwitchData(data)
    if CheckCurrentSwitch(data) then return else CURRENT_SWITCH = data end
    if (CURRENT_SWITCH == nil) then return end
    CreateThread(function()
        local weaponRPM = config.weapons[data.name]
        while CheckCurrentSwitch(data) do 
            if cache.weapon and IsControlPressed(1, 24) and not cache.vehicle then
                local _, ammo = GetAmmoInClip(cache.ped, GetHashKey(data.name))
                if IsPedShooting(cache.ped) then
                elseif ammo > 0 then
                    SetCurrentPedWeapon(cache.ped, GetHashKey("WEAPON_UNARMED"), true)
                    ClearPedTasks(cache.ped)
                    SetCurrentPedWeapon(cache.ped, GetHashKey(data.name), true)
                    Wait(GetRPM(weaponRPM))
                end
            end
            Wait(0)
        end
    end)
end

RegisterNetEvent("ox_inventory:currentWeapon", function(item)
    if (item ~= nil and item.metadata.switch ~= nil) then
        SetSwitchData({name = item.name, serial = item.metadata.serial})
    else
        SetSwitchData(nil)
    end
end)

RegisterNetEvent("lorp_packed:client:applySwitch", function(item, removed)
    local item <const> = item
    if (not removed and item.metadata.switch ~= nil) then
        if lib.progressCircle({
            label = 'Installing Switch...',
            duration = 3000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                combat = true,
            },
            anim = {
                dict = 'anim@cover@weapon@reloads@pistol@doubleaction',
                clip = 'reload_low_left'
            },
        }) then
            SetSwitchData({name = item.name, serial = item.metadata.serial})
            ox_inventory:displayMetadata('switch', 'Switch')
        else
            lib.notify({
                title = 'Switches',
                description = 'You stopped installing the switch...',
                showDuration = true,
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'ban',
                iconColor = '#C53030'
            })
        end
    else
        if lib.progressCircle({
            label = 'Removing Switch...',
            duration = 3000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                combat = true,
            },
            anim = {
                dict = 'anim@cover@weapon@reloads@pistol@doubleaction',
                clip = 'reload_low_left'
            },
        }) then
            SetSwitchData(nil)
        else
            lib.notify({
                title = 'Switches',
                description = 'You stopped removing the switch...',
                showDuration = true,
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'ban',
                iconColor = '#C53030'
            })
        end
    end
end)

local function activate()
    ExecuteCommand('switch')
end exports('activate', activate)