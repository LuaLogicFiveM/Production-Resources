DependantResources = {
    ['cd_dispatch3d'] = true,
    ['cd_doorlock'] = true,
    ['cd_eventcalendar'] = true,
    ['cd_garage'] = true,
    ['cd_vipshop'] = true
}

local function running(res)
    return GetResourceState(res) == 'started' or GetResourceState(res) == 'starting'
end

local function detect(list, fallback)
    for _, res in ipairs(list) do
        if running(res) then
            return res
        end
    end
    return fallback
end

function RunAutoDetect()
    if Cfg.Framework == 'auto_detect' then
        if running('es_extended') then
            Cfg.Framework = 'esx'
        elseif running('qbx_core') then
            Cfg.Framework = 'qbox'
        elseif running('qb-core') then
            Cfg.Framework = 'qbcore'
        elseif running('vRP') then
            Cfg.Framework = 'vrp'
        else
            Cfg.Framework = 'standalone'
            if Cfg.BridgeDebug then
                Citizen.Trace(string.format('^1[cd_bridge INFO]^7 No supported framework detected — defaulting to %s.\n'), Cfg.Framework)
            end
        end
    end

    if Cfg.Database == 'auto_detect' then
        Cfg.Database = detect({
            'oxmysql',
            'ghmattimysql'
        }, 'none')
    end

    if Cfg.Inventory == 'auto_detect' then
        local inventory = detect({
            'codem-inventory',
            'ox_inventory',
            'qs-inventory',
            'qb-inventory',
            'tgiann-inventory'
        }, nil)

        if inventory then
            Cfg.Inventory = inventory
        else
            if Cfg.Framework == 'esx' then
                Cfg.Inventory = 'esx_inventory'
            elseif Cfg.Framework == 'qbcore' then
                Cfg.Inventory = 'qb-inventory'
            elseif Cfg.Framework == 'qbox' then
                Cfg.Inventory = 'ox_inventory'
            else
                Cfg.Inventory = 'none'
            end
            if Cfg.BridgeDebug then
                Citizen.Trace(string.format('^1[cd_bridge INFO]^7 No supported inventory detected — defaulting to %s.\n'), Cfg.Inventory)
            end
        end
    end

    if Cfg.Notification == 'auto_detect' then
        local notif = detect({
            'cd_notifications',
            'mythic_notify',
            'okokNotify',
            'origen_notify',
            'ox_lib',
            'pNotify',
            'ps-ui',
            'rtx_notify',
            'vms_notifyv2'
        }, nil)

        if notif then
            Cfg.Notification = notif
        else
            if Cfg.Framework == 'esx' or Cfg.Framework == 'qbcore' or Cfg.Framework == 'qbox' then
                Cfg.Notification = Cfg.Framework
            else
                Cfg.Notification = 'chat'
            end
            if Cfg.BridgeDebug then
                Citizen.Trace(string.format('^1[cd_bridge INFO]^7 No supported notification detected — defaulting to %s.\n'), Cfg.Notification)
            end
        end
    end

    if Cfg.DrawTextUI == 'auto_detect' then
        Cfg.DrawTextUI = detect({
            'cd_drawtextui',
            'jg-textui',
            'ox_lib',
            'okokTextUI',
            'ps-ui',
            'vms_notifyv2',
            'ZSX_UIV2',
            'qb-core'
        }, 'none')
    end

    if Cfg.Target == 'auto_detect' then
        Cfg.Target = detect({
            'ox_target',
            'qb-target'
        }, 'none')
    end

    if Cfg.VehicleFuel == 'auto_detect' then
        Cfg.VehicleFuel = detect({
            'BigDaddy-Fuel',
            'cdn-fuel',
            'esx-sna-fuel',
            'FRFuel',
            'lc_fuel',
            'LegacyFuel',
            'lj-fuel',
            'lyre_fuel',
            'mnr_fuel',
            'myFuel',
            'ND_Fuel',
            'okokGasStation',
            'ox_fuel',
            'ps-fuel',
            'qb-sna-fuel',
            'qs-fuelstations',
            'rcore_fuel',
            'Renewed-Fuel',
            'ti_fuel',
            'x-fuel',
            'qb-fuel',
        }, 'none')
    end

    if Cfg.VehicleKeys == 'auto_detect' then
        Cfg.VehicleKeys = detect({
            'ak47_qb_vehiclekeys',
            'ak47_vehiclekeys',
            'F_RealCarKeysSystem',
            'fivecode_carkeys',
            'loaf_keysystem',
            'mk_vehiclekeys',
            'MrNewbVehicleKeys',
            'qs-vehiclekeys',
            'stasiek_vehiclekeys',
            't1ger_keys',
            'tgiann-hotwire',
            'ti_vehicleKeys',
            'vehicles_keys',
            'wasabi_carlock',
            'xd_locksystem',
            'qbx_vehiclekeys',
            'qb-vehiclekeys',
        }, 'none')
    end

    if Cfg.TimeWeather == 'auto_detect' then
        Cfg.TimeWeather = detect({
            'cd_easytime',
            'vsync',
            'qb-weathersync'
        }, 'none')
    end

    if Cfg.Phone == 'auto_detect' then
        Cfg.Phone = detect({
            'esx_phone',
            'gcphone',
            'gksphone',
            'lb-phone',
            'npwd',
            'okokPhone',
            'qb-phone',
            'qbx_npwd'
        }, 'none')
    end

    if Cfg.Dispatch == 'auto_detect' then
        Cfg.Dispatch = detect({
            'cd_dispatch',
            'cd_dispatch3d',
            'codem-dispatch',
            'core_dispatch',
            'esx_outlawalert',
            'emergencydispatch',
            'lb-tablet',
            'ps-dispatch',
            'qs-dispatch',
            'rcore_dispatch',
            'tk_dispatch'
        }, 'none')
    end

    if Cfg.PersistentVehicles == 'auto_detect' then
        Cfg.PersistentVehicles = detect({
            'cd_garage',
            'AdvancedParking'
        }, 'none')
    end

    -- Framework specific SQL table Cfgurations
    if Cfg.Framework == 'esx' then
        Cfg.FrameworkSQLtables = {
            vehicle_table = 'owned_vehicles',
            vehicle_identifier = 'owner',
            vehicle_props = 'vehicle',
            users_table = 'users',
            users_identifier = 'identifier',
        }
    elseif Cfg.Framework == 'qbcore' then
        Cfg.FrameworkSQLtables = {
            vehicle_table = 'player_vehicles',
            vehicle_identifier = 'citizenid',
            vehicle_props = 'mods',
            users_table = 'players',
            users_identifier = 'citizenid',
        }
    elseif Cfg.Framework == 'qbox' then
        Cfg.FrameworkSQLtables = {
            vehicle_table = 'player_vehicles',
            vehicle_identifier = 'citizenid',
            vehicle_props = 'mods',
            users_table = 'players',
            users_identifier = 'citizenid',
        }
    end
    FW = Cfg.FrameworkSQLtables
end

local function DetectResourceStart(resourceName)
    if resourceName == 'cd_garage' then
        while GetResourceState('cd_garage') ~= 'started' do
            Wait(100)
        end
        local ok, config = pcall(function()
            return exports['cd_garage']:GetConfig()
        end)
        if ok and config ~= nil then
            if config.VehicleKeys.ENABLE then
                Cfg.VehicleKeys = 'cd_garage'
            end
            if config.PersistentVehicles.ENABLE then
                Cfg.PersistentVehicles = 'cd_garage'
            end
        end

    elseif resourceName == 'cd_dispatch' then
        Cfg.Dispatch = 'cd_dispatch'

    elseif resourceName == 'cd_dispatch3d' then
        Cfg.Dispatch = 'cd_dispatch3d'
    end
end

if IsDuplicityVersion() then
    AddEventHandler('onResourceStart', function(resourceName)
        DetectResourceStart(resourceName)
    end)
else
    AddEventHandler('onClientResourceStart', function(resourceName)
        DetectResourceStart(resourceName)
    end)
end

RunAutoDetect()

if GetCurrentResourceName() == 'cd_bridge' then
    CreateThread(function()
        Wait(5000)

        local firstDetect = {
            Framework = Cfg.Framework,
            Database = Cfg.Database,
            Inventory = Cfg.Inventory,
            Notification = Cfg.Notification,
            DrawTextUI = Cfg.DrawTextUI,
            Target = Cfg.Target,
            VehicleFuel = Cfg.VehicleFuel,
            VehicleKeys = Cfg.VehicleKeys,
            TimeWeather = Cfg.TimeWeather,
            Phone = Cfg.Phone,
            Dispatch = Cfg.Dispatch,
            PersistentVehicles = Cfg.PersistentVehicles,
        }

        for key, value in pairs(firstDetect) do
            if value == 'none' then
                Cfg[key] = 'auto_detect'
            end
        end

        RunAutoDetect()

        local lateDetected = {}

        for key, before in pairs(firstDetect) do
            local after = Cfg[key]

            if before == 'none' and after ~= 'none' then
                if not DependantResources[after] then
                    table.insert(lateDetected, after)
                end
            end
        end

        for key, value in pairs(firstDetect) do
            Cfg[key] = value
        end

        if #lateDetected > 0 then
           Citizen.Trace(([[
            ^5===============================================================
            ^3[cd_bridge]^7 Late resource start detected

            ^7The following resources were detected ^1AFTER^7 cd_bridge started:

            ^6• %s

            ^7This means these resources are starting ^1AFTER^7 cd_bridge
            ^7and may not auto-detect correctly.

            ^7To fix this:
            ^6• Move ^2cd_bridge^6 below these resources in your ^2server.cfg^6
            ^6• Restart your server

            ^5===============================================================
            ]]):format(table.concat(lateDetected, ', ')) .. '^0\n')
        end
    end)
end