local ox_inventory = exports.ox_inventory
local loaded, reloading, taser = true, false, `WEAPON_STUNGUN`

local keybind = lib.addKeybind({
    name = 'taser_reload',
    description = 'Reload Taser',
    defaultKey = 'R',
    onPressed = function(self)
        if loaded or reloading then return end
        ReloadTaser()
    end,
})

function ReloadTaser()
    if ox_inventory:Search('count', 'taser_cartridge') ~= 0 then
        reloading = true
        if lib.progressCircle({
            label = 'Reloading Taser...',
            duration = 2000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = false,
                combat = true,
                mouse = false,
                car = false,
            },
            anim = {
                dict = 'cover@weapon@reloads@heavy@rail_gun',
                clip = 'reload_low_left'
            },
        }) then
            ox_inventory:useSlot(ox_inventory:GetSlotIdWithItem('taser_cartridge'))
            reloading = false
            loaded = true
            lib.notify({
                title = 'Taser',
                description = 'You reloaded your taser.',
                type = 'success',
                position = 'top',
            })
        else
            reloading = false
            lib.notify({
                title = 'Taser',
                description = 'You cancelled the reload.',
                type = 'error',
                position = 'top',
            })
        end
    else
        lib.notify({
            title = 'Taser',
            description = 'You do not have any cartridges.',
            type = 'error',
            position = 'top',
        })
    end
end

lib.onCache('weapon', function(weapon)
    if weapon ~= taser then keybind:disable(true) return end
    keybind:disable(false)
    CreateThread(function()
        while cache.weapon == taser do
            Wait(0)
            if not loaded then
                SetPlayerCanDoDriveBy(cache.ped, false)
                DisablePlayerFiring(cache.ped, true)
            end
        end
    end)
end)

AddEventHandler('CEventGunShot', function(entities, eventEntity, args)
    if eventEntity ~= cache.ped  then return end
    if cache.weapon ~= taser then return end

    if loaded then
        loaded = false
    else
        lib.notify({
            title = 'Taser',
            description = 'You are out of cartridges.',
            type = 'error',
            position = 'top',
        })
    end
end)
