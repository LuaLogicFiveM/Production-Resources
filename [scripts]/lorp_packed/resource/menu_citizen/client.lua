local ox_inventory = exports.ox_inventory
local lorp_packed = exports.lorp_packed

CreateThread(function()
    lib.registerMenu({
        id = 'citizen_menu',
        title = 'Citizen Menu',
        position = 'bottom-right',
        options = {
            {icon = 'user', label = 'Player Options'},
            {icon = 'car', label = 'Vehicle Options'},
            {icon = 'people-arrows', label = 'Misc Options'},
            {icon = 'skull', label = 'Gang Options'},
            {icon = 'ranking-star', label = 'Rank Options'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            lib.showMenu('citizen_menu_player')
        elseif selected == 2 then
            lib.showMenu('citizen_menu_vehicle')
        elseif selected == 3 then
            lib.showMenu('citizen_menu_misc')
        elseif selected == 4 then
            lib.showMenu('citizen_menu_gang')
        elseif selected == 5 then
            lib.showMenu('citizen_menu_ranks')
        end
    end)

    lib.registerMenu({
        id = 'citizen_menu_vehicle',
        title = 'Vehicle Options',
        position = 'bottom-right',
        onClose = function(keyPressed)
            lib.showMenu('citizen_menu')
        end,
        options = {
            {icon = 'truck-monster', label = '4x4 Mode'},
            {icon = 'car', label = 'Launch Control'},
            {icon = 'play', label = 'Line Lock'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            ExecuteCommand('4x4')
        elseif selected == 2 then
            ExecuteCommand('launch')
        elseif selected == 3 then
            ExecuteCommand('linelock')
        end
    end)

    lib.registerMenu({
        id = 'citizen_menu_player',
        title = 'Player Options',
        position = 'bottom-right',
        onClose = function(keyPressed)
            lib.showMenu('citizen_menu')
        end,
        options = {
            {icon = 'people-arrows', label = 'Carry'},
            {icon = 'shirt', label = 'Clothing'},
            {icon = 'people-arrows', label = 'Crosshair'},
            {icon = 'person', label = 'Emotes'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            ExecuteCommand('carry')
        elseif selected == 2 then
            exports['p-clothing']:ToggleMenu()
        elseif selected == 3 then
            ExecuteCommand('crosshair')
        elseif selected == 4 then
            ExecuteCommand('emotemenu')
        end
    end)

    lib.registerMenu({
        id = 'citizen_menu_misc',
        title = 'Misc Options',
        position = 'bottom-right',
        onClose = function(keyPressed)
            lib.showMenu('citizen_menu')
        end,
        options = {
            {icon = 'location-dot', label = 'Postal Waypoint'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            local input = lib.inputDialog('What Postal?', { {type = 'number', label = 'Postal Code', description = '0 to remove current marker', icon = 'hashtag'} })
            if input[1] == 0 then
                SetWaypointOff()
            else
                ExecuteCommand('postal ' ..input[1])
            end
        end
    end)

    local storageRanks = {
        ['Emerald'] = true,
        ['Diamond'] = true,
        ['Platinum'] = true,
    }

    lib.registerMenu({
        id = 'citizen_menu_ranks',
        title = 'Rank Options',
        position = 'bottom-right',
        onClose = function(keyPressed)
            lib.showMenu('citizen_menu')
        end,
        options = {
            {icon = 'screwdriver-wrench', label = 'Repair Bench'},
            {icon = 'box-open', label = 'Personal Storage'},
            {icon = 'people-arrows', label = 'Ped Menu'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            local playerRank = lib.callback.await('lorp_packed:server:getPlayerRank', false)
            if playerRank and storageRanks[playerRank] then
                local playerCoords = GetEntityCoords(cache.ped)
                local playerHeading = GetEntityHeading(cache.ped)
                lorp_packed:RepairBenchMenu({ bench = { model = "gr_prop_gr_bench_01a", coords = vector4(playerCoords.x, playerCoords.y, playerCoords.z, playerHeading) }, required = {{ count = 25, item = "scrap_metal" }, { count = 10000, item = "money" }}})
            else
                lib.notify({title = 'Citizen Menu', description = 'You do not have access to this feature', type = 'error', position = 'top'})
            end
        elseif selected == 2 then
            local storageIdentifier = lib.callback.await('lorp_packed:server:requestStorageData', false)
            if storageIdentifier then
                if LocalPlayer.state.cuffs then
                    return lib.notify({title = 'Citizen Menu', description = 'You are unable to use this feature while cuffed', type = 'error', position = 'top'})
                end
                ox_inventory:openInventory('stash', {id = 'paid', identifier = storageIdentifier})
            else
                lib.notify({title = 'Citizen Menu', description = 'You do not have access to this feature', type = 'error', position = 'top'})
            end
        elseif selected == 3 then
            ExecuteCommand('pedmenu')
        end
    end)

    lib.registerMenu({
        id = 'citizen_menu_gang',
        title = 'Gang Options',
        position = 'bottom-right',
        onClose = function(keyPressed)
            lib.showMenu('citizen_menu')
        end,
        options = {
            {icon = 'screwdriver-wrench', label = 'Manage Gang'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            ExecuteCommand('gangmanagement')
        end
    end)
end)

RegisterCommand('citizen_menu', function()
    lib.showMenu('citizen_menu')
end, false)

RegisterKeyMapping('citizen_menu', 'Open Citizen Menu', 'keyboard', 'f5')