local function running(res)
    return GetResourceState(res) == 'started'
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
        end
    end

    if Cfg.Database == 'auto_detect' then
        Cfg.Database = detect({
            'oxmysql',
            'mysql-async',
            'ghmattimysql',
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
            'gcphone',
            'lb-phone',
            'npwd',
            'okokPhone',
            'qb-phone'
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
end

RunAutoDetect()

local function DetectResourceStart(resourceName)
    if resourceName == 'cd_garage' then
        while GetResourceState('cd_garage') ~= 'started' do
            Wait(100)
        end
        local ok, config = pcall(function()
            return exports['cd_garage']:GetConfig()
        end)
        if ok and config ~= nil and config.VehicleKeys.ENABLE then
            Cfg.VehicleKeys = 'cd_garage'
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