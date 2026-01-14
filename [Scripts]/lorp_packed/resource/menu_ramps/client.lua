---@diagnostic disable: undefined-global
local zoneActive, zoneBypass = false, false
local config = require 'resource.menu_ramps.shared'
local cl_utils = require 'utils.client'
local weaponOptions = {}

local function RevivePlayer()
    if cl_utils.playerDead() and isPlayerInZone and not IsBypassing then
        TriggerEvent('ak47_ambulancejob:revive')
        SetPedArmour(cache.ped, 100)
    else
        cl_utils.notify('Ramps Menu', "You have to be dead and died in the ramps zone", "error")
    end
end

RegisterCommand('r', function()
    RevivePlayer()
end, false)

RegisterCommand('ramps', function()
    if zoneActive and not zoneBypass and not lib.getOpenMenu() then
        lib.showMenu("main_menu")
    end
end, false)

CreateThread(function()
    Wait(500)

    for _, locationData in ipairs(config.locations) do
        function onEnter(self)
            zoneActive = true
            zoneBypass = cl_utils.playerDead()
            LocalPlayer.state.invBusy = true
            exports.ox_inventory:weaponWheel(true)
        end

        function onExit(self)
            SetPedArmour(cache.ped, 0)
            cl_utils.hideTextUI()
            zoneActive = false
            LocalPlayer.state.invBusy = false
            exports.ox_inventory:weaponWheel(false)
            RemoveAllPedWeapons(cache.ped, false)
        end

        function inside(self)
            if IsControlJustPressed(0, 311) then
                ExecuteCommand('ramps')
            end
        end

        local box = lib.zones.box({
            coords = locationData.coords,
            size = locationData.size,
            rotation = locationData.rotation,
            debug = false,
            inside = inside,
            onEnter = onEnter,
            onExit = onExit
        })
    end

    for weaponHash, weaponLabel in pairs(config.weapons) do
        weaponOptions[#weaponOptions+1] = {label = weaponLabel, value = weaponHash}
    end

    lib.registerMenu({
        id = 'main_menu',
        title = 'Ramps Menu',
        position = 'bottom-right',
        options = {
            {label = 'Teleport Options', icon = 'fa-plane'},
            {label = 'Self Options', icon = 'fa-heart-pulse'},
            {label = 'Game Modes', icon = 'fa-people-group'},
        },
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            if cl_utils.playerDead() then return lib.showMenu('main_menu'), cl_utils.notify('Ramps Menu', 'You must be alive to use the teleport menu.', 'error') end
            lib.showMenu('teleport_menu')
        elseif selected == 2 then
            lib.showMenu('self_options')
        elseif selected == 3 then
            if cl_utils.playerDead() then return lib.showMenu('main_menu'), cl_utils.notify('Ramps Menu', 'You must be alive to use the game modes menu.', 'error') end
            lib.showMenu('game_modes')
        end
    end)

    lib.registerMenu({
        id = 'game_modes',
        title = 'Game Modes',
        position = 'bottom-right',
        onClose = function(keyPresses)
            if keyPresses then
                lib.showMenu('main_menu')
            end
        end,
        options = {
            {label = 'Matchmaking', icon = 'fa-people-group'},
            --{label = 'Battle Royale', icon = 'fa-people-group'},
        },
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            if cl_utils.playerDead() then return lib.showMenu('main_menu'), cl_utils.notify('Ramps Menu', 'You must be alive to use the matchmaking menu.', 'error') end
            exports.lorp_matchmaking:OpenMenu()
        --[[elseif selected == 2 then
            exports.lualogic_royale:OpenMenu()]]
        end
    end)

    local teleports = {}
    for _, teleportdata in pairs(config.teleports) do
        teleports[#teleports + 1] = {
            label = teleportdata.label,
            icon = teleportdata.icon,
            close = false,
            args = {
                loc = teleportdata.loc
            }
        }
    end

    lib.registerMenu({
        id = 'teleport_menu',
        title = 'Teleport Options',
        position = 'bottom-right',
        onClose = function(keyPresses)
            if keyPresses then
                lib.showMenu('main_menu')
            end
        end,
        options = teleports
    }, function(selected, scrollIndex, args)
        cl_utils.teleportPlayer(args.loc)
    end)

    lib.registerMenu({
        id = 'self_options',
        title = 'Self Options',
        position = 'bottom-right',
        onClose = function(keyPresses)
            if keyPresses then
                lib.showMenu('main_menu')
            end
        end,
        options = {
            {label = 'Revive', icon = 'fa-notes-medical', close = false},
            {label = 'Heal', icon = 'fa-kit-medical', close = false},
            {label = 'Armour', icon = 'fa-shield-halved', close = false},
            {label = 'Guns', icon = 'fa-shield-halved'},
        },
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            if cl_utils.playerDead() and zoneActive and not zoneBypass then
                TriggerEvent('ak47_ambulancejob:revive')
            else
                cl_utils.notify('Ramps Menu', 'You have to be dead or died in the ramps zone', 'error')
            end
        elseif selected == 2 then
            if cl_utils.playerDead() then return cl_utils.notify('Ramps Menu', 'You are dead, you have to revive.', 'error') end
            if GetEntityHealth(cache.ped) == 200 then
                cl_utils.notify('Ramps Menu', 'You are already at max health', 'error')
            else
                SetEntityHealth(cache.ped, 200)
                TriggerEvent('ak47_ambulancejob:skellyfix')
                cl_utils.notify('Ramps Menu', 'Sucessfully added health', 'success')
            end
        elseif selected == 3 then
            if cl_utils.playerDead() then return cl_utils.notify('Ramps Menu', 'You are dead, you have to revive.', 'error') end
            if GetPedArmour(cache.ped) == 100 then
                cl_utils.notify('Ramps Menu', 'You are already at max armour', 'error')
            else
                SetPedArmour(cache.ped, 100)
                TriggerEvent('ak47_ambulancejob:skellyfix')
                cl_utils.notify('Ramps Menu', 'Sucessfully added armour', 'success')
            end
        elseif selected == 4 then
            if cl_utils.playerDead() then return cl_utils.notify('Ramps Menu', 'You are dead, you have to revive.', 'error') end
            local input = lib.inputDialog('Spawn Weapon', {
                {type = 'select', label = 'Weapon', required = true, options = weaponOptions}
            })

            if not input then
                return lib.showMenu('self_options')
            end

            local playerPed = cache.ped
            local playerWeapon = input[1]

            GiveWeaponToPed(playerPed, playerWeapon, 1000, false, true)
            SetCurrentPedWeapon(playerPed, playerWeapon, true)
            SetPedCurrentWeaponVisible(playerPed, true, false, false, false)
            SetWeaponsNoAutoswap(true)
            SetPedAmmo(playerPed, lobbyData.weapon, 1000)
            SetTimeout(0, function() RefillAmmoInstantly(playerPed) end)
            cl_utils.notify('Ramps Menu', 'You have received the weapon', 'success')
        end
    end)
end)