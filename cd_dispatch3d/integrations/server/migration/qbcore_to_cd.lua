RegisterServerEvent('police:server:policeAlert', function(defaultMessage)
    local src = source
    if not defaultMessage or defaultMessage == '' then return end
    local coords = GetEntityCoords(GetPlayerPed(src))

    if defaultMessage == 'Drug sale in progress' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-72 - Drug Activity',
            message = 'Possible drug sale in progress reported',
            flash = false,
            sound = 1,
            blip = { sprite=403, scale=1.05, colour=2, flashes=false, text='911 - Drug Activity', time=6, radius=50 }
        })

    elseif defaultMessage == 'Robbery in progress' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-16 - Jewelry Robbery',
            message = 'Break-in reported at a jewelry store',
            flash = true,
            sound = 2,
            blip = { sprite=40, scale=1.15, colour=46, flashes=true, text='911 - Burglary', time=6, radius=0 }
        })
    elseif defaultMessage == 'Attempted House Robbery' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-62B - Burglary in Progress',
            message = 'Residential burglary reported',
            flash = true,
            sound = 2,
            blip = { sprite=40, scale=1.15, colour=46, flashes=true, text='911 - Burglary', time=6, radius=0 }
        })
    end
end)

RegisterServerEvent('police:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
    local src = source
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = { 'police' },
        coords = GetEntityCoords(GetPlayerPed(src)),
        title = '10-28 - Flagged Plate',
        message = 'Speeding vehicle detected at '..street1..' and '..street2,
        flash = false,
        sound = 1,
        blip = { sprite=315, scale=1.15, colour=46, flashes=false, text='911 - Flagged Plate', time=6, radius=20 }
    })
    if Config.PoliceAlerts.add_bolos and GetResourceState('cd_radar') == 'started' then
        TriggerEvent('cd_radar:RadarDatabase_ADD', {
            plate = plate,
            model = 'unknown',
            colour = 'unknown',
            reason = 'Speeding',
            type = 'bolo',
            name = Locale('dispatch')..Locale('policealerts_speedtrap_title'),
            notes = nil,
            date = nil,
        })
    end
end)

RegisterServerEvent('hospital:server:ambulanceAlert', function(message)
    local src = source
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = { 'ambulance' },
        coords = GetEntityCoords(GetPlayerPed(src)),
        title = 'Medical - Emergency',
        message = message or 'Medical emergency reported. Immediate assistance required',
        flash = true,
        sound = 1,
        blip = { sprite=153, scale=1.1, colour=2, flashes=false, text='911 - Medical', time=6, radius=0 }
    })
end)

RegisterServerEvent('qb-bankrobbery:server:callCops', function(bankType, bank, coords)
    local src = source
    if bankType == 'small' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-90 - Bank Robbery',
            message = 'Silent alarm triggered at a bank on '..bank,
            flash = true,
            sound = 2,
            blip = { sprite=500, scale=1.2, colour=1, flashes=true, text='911 - Bank Robbery', time=6, radius=0 }
        })

    elseif bankType == 'paleto' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-90 - Bank Robbery',
            message = 'Silent alarm triggered at Paleto Bay Bank',
            flash = true,
            sound = 2,
            blip = { sprite=500, scale=1.2, colour=1, flashes=true, text='911 - Bank Robbery', time=6, radius=0 }
        })

    elseif bankType == 'pacific' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-90 - Bank Robbery',
            message = 'Silent alarm triggered at Pacific Standard Bank',
            flash = true,
            sound = 2,
            blip = { sprite=500, scale=1.2, colour=1, flashes=true, text='911 - Bank Robbery', time=6, radius=0 }
        })
    end
end)

RegisterServerEvent('qb-storerobbery:server:callCops', function(type, safe, street, coords)
    local src = source
    if type == 'safe' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-15 - Store Robbery',
            message = 'Store safe being cracked at '..street,
            flash = true,
            sound = 2,
            blip = { sprite=431, scale=1.2, colour=3, flashes=true, text='911 - Store Robbery', time=5, radius=0 }
        })
        return

    elseif type == 'cashier' then
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = coords,
            title = '10-15 - Store Robbery',
            message = 'Store cashier being robbed at '..street,
            flash = true,
            sound = 2,
            blip = { sprite=431, scale=1.2, colour=3, flashes=true, text='911 - Store Robbery', time=5, radius=0 }
        })
        return
    end
end)

RegisterServerEvent('qb-armoredtruckheist:server:callCops', function(street, coords)
    local src = source
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = { 'police' },
        coords = coords,
        title = '10-90 - Armored Truck Heist',
        message = 'Armored truck robbery in progress at '..street,
        flash = true,
        sound = 2,
        blip = { sprite=497, scale=1.2, colour=1, flashes=true, text='911 - Armored Truck Heist', time=6, radius=0 }
    })
end)