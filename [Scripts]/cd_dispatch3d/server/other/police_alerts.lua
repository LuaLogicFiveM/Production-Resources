if not Config.PoliceAlerts.ENABLE then return end

local function CheckVehicleOwner(source, all_plates)
    local identifier = GetIdentifier(source)
    local Result = DB.fetch('SELECT '..Config.FrameworkSQLtables.vehicle_identifier..' FROM '..Config.FrameworkSQLtables.vehicle_table..' WHERE plate=@plate1 or plate=@plate2 or plate=@plate3', {
        ['@plate1'] = all_plates.trimmed,
        ['@plate2'] = all_plates.with_spaces,
        ['@plate3'] = all_plates.mixed
    })

    local is_owner, owner = false, nil
    if Result and Result[1] then
        if Config.Framework == 'esx' then
            owner = Result[1].owner
        elseif Config.Framework == 'qbcore' then
            owner = Result[1].citizenid
        end
        if owner and owner == identifier then
            is_owner = true
        end
    end
    return is_owner
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                             GUNSHOTS                             │
-- └──────────────────────────────────────────────────────────────────┘

RegisterServerEvent('cd_dispatch:pdalerts:Gunshots', function(data)
    if GetResourceState('cd_radar') == 'started' then
        TriggerEvent('cd_radar:RadarDatabase_ADD', {
            plate = data.vehicle_plate,
            model = data.vehicle_label,
            colour = data.vehicle_colour,
            reason = 'Firearms',
            type = 'bolo',
            name = Locale('dispatch')..Locale('policealerts_gunshots_title'),
            notes = nil,
            date = nil,
        })
    end
end)

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           SPEED TRAPS                            │
-- └──────────────────────────────────────────────────────────────────┘

RegisterServerEvent('cd_dispatch:pdalerts:Speedtrap', function(data, config_data, speed, all_plates)
    local _source = source
    if (config_data.fine_amount > 0 and not Config.PoliceAlerts.SpeedTrap.check_owner_for_fine) or (config_data.fine_amount > 0 and Config.PoliceAlerts.SpeedTrap.check_owner_for_fine and CheckVehicleOwner(_source, all_plates)) then
        RemovePlayerMoney(_source, config_data.fine_amount, 'bank', 'speeding_fine')
        Notif(_source, 2, 'speedtrap_1', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street, config_data.fine_amount)
    else
        Notif(_source, 2, 'speedtrap_2', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street)
    end

    if Config.PoliceAlerts.add_bolos and GetResourceState('cd_radar') == 'started' then
        TriggerEvent('cd_radar:RadarDatabase_ADD', {
            plate = data.vehicle_plate,
            model = data.vehicle_label,
            colour = data.vehicle_colour,
            reason = 'Speeding',
            type = 'bolo',
            name = Locale('dispatch')..Locale('policealerts_speedtrap_title'),
            notes = nil,
            date = nil,
        })
    end
end)