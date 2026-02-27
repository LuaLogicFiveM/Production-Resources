------------------------------------------------------------
-- ROBBERIES / BURGLARIES
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:StoreRobbery', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-15 - Store Robbery',
        message   = 'A ' .. data.sex .. ' robbing a store at ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=431, scale=1.2, colour=3, flashes=true, text='911 - Store Robbery', time=5, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:BankRobbery', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-90 - Bank Robbery',
        message   = 'Silent alarm triggered at a bank on ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=500, scale=1.2, colour=1, flashes=true, text='911 - Bank Robbery', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:JewelryRobbery', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-16 - Jewelry Robbery',
        message   = 'Break-in reported at a jewelry store near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=617, scale=1.2, colour=5, flashes=true, text='911 - Jewelry Robbery', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:HouseBurglary', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-62B - Burglary in Progress',
        message   = 'Residential burglary reported at ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=40, scale=1.15, colour=46, flashes=true, text='911 - Burglary', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:Carjacking', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-16C - Carjacking',
        message   = 'Carjacking in progress by a ' .. data.sex .. ' at ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=225, scale=1.15, colour=1, flashes=true, text='911 - Carjacking', time=5, radius=0 }
    })
end)

------------------------------------------------------------
-- WEAPONS / VIOLENCE
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:ShotsFired', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-71 - Shots Fired',
        message   = 'Multiple shots fired by a ' .. data.sex .. ' near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=313, scale=1.2, colour=1, flashes=true, text='911 - Shots Fired', time=5, radius=75 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:PersonWithGun', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-32 - Person With a Gun',
        message   = 'Armed ' .. data.sex .. ' seen at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=119, scale=1.1, colour=1, flashes=false, text='911 - Person With Gun', time=5, radius=50 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:Stabbing', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-54 - Stabbing',
        message   = 'Reported stabbing near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=153, scale=1.1, colour=1, flashes=true, text='911 - Stabbing', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:FightInProgress', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-10 - Fight in Progress',
        message   = 'Physical altercation on ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=175, scale=1.1, colour=5, flashes=false, text='911 - Fight', time=5, radius=40 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:Kidnapping', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-92 - Kidnapping / Hostage',
        message   = 'Possible kidnapping near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=480, scale=1.2, colour=1, flashes=true, text='911 - Kidnapping', time=6, radius=0 }
    })
end)

------------------------------------------------------------
-- OFFICER / PURSUIT / BACKUP
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:OfficerDown', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-13 - Officer Down',
        message   = 'Officer requires immediate assistance at ' .. data.street,
        flash     = true,
        sound     = 3,
        blip = { sprite=480, scale=1.3, colour=1, flashes=true, text='10-13 Officer Down', time=8, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:PanicButton', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = 'Panic Button',
        message   = 'Active panic near ' .. data.street,
        flash     = true,
        sound     = 3,
        blip = { sprite=161, scale=1.3, colour=1, flashes=true, text='Panic Button', time=8, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:BackupRequest', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-78 - Backup Request',
        message   = 'Unit requesting Code 3 backup at ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=161, scale=1.2, colour=3, flashes=true, text='Requesting Backup', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:Pursuit', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-80 - Pursuit',
        message   = 'Pursuit in progress near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=56, scale=1.2, colour=38, flashes=true, text='10-80 Pursuit', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:PrisonBreak', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-98 - Prison Break',
        message   = 'Prison break reported! All units respond.',
        flash     = true,
        sound     = 2,
        blip = { sprite=188, scale=1.15, colour=1, flashes=true, text='Prison Break', time=8, radius=150 }
    })
end)

------------------------------------------------------------
-- VEHICLES / TRAFFIC
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:StolenVehicle', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-60 - Stolen Vehicle',
        message   = 'Reported stolen vehicle near ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=225, scale=1.1, colour=1, flashes=false, text='911 - Stolen Vehicle', time=5, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:SuspiciousVehicle', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-66 - Suspicious Vehicle',
        message   = 'Suspicious vehicle at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=380, scale=1.1, colour=5, flashes=false, text='911 - Suspicious Vehicle', time=5, radius=30 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:RecklessDriver', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-76 - Reckless Driving',
        message   = 'Reckless driver reported on ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=380, scale=1.0, colour=5, flashes=false, text='911 - Reckless Driver', time=5, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:TrafficCollision', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-50 - Vehicle Accident',
        message   = 'Traffic collision at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=380, scale=1.1, colour=47, flashes=false, text='911 - Traffic Collision', time=6, radius=30 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:StreetRacing', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-70 - Street Racing',
        message   = 'Illegal racing near ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=315, scale=1.15, colour=46, flashes=false, text='911 - Street Racing', time=6, radius=120 }
    })
end)

------------------------------------------------------------
-- ALARMS / TAMPERING
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:ATMAlarm', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-52A - ATM Tampering',
        message   = 'ATM tamper alarm at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=108, scale=1.05, colour=46, flashes=false, text='911 - ATM Alarm', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:BusinessAlarm', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-52 - Business Alarm',
        message   = 'Commercial alarm at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=106, scale=1.05, colour=46, flashes=false, text='911 - Alarm', time=6, radius=0 }
    })
end)

------------------------------------------------------------
-- DRUGS / SUSPICIOUS
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:DrugActivity', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-72 - Drug Activity',
        message   = 'Possible narcotics activity near ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=403, scale=1.05, colour=2, flashes=false, text='911 - Drug Activity', time=6, radius=50 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:SuspiciousPerson', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-37 - Suspicious Person',
        message   = 'Suspicious ' .. data.sex .. ' at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=280, scale=1.0, colour=5, flashes=false, text='911 - Suspicious Person', time=5, radius=30 }
    })
end)

------------------------------------------------------------
-- FIRE / EXPLOSION / MEDICAL
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:StructureFire', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance', 'fire'},
        coords    = data.coords,
        title     = '10-70F - Structure Fire',
        message   = 'Structure fire at ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=436, scale=1.2, colour=1, flashes=true, text='Fire - Structure', time=8, radius=120 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:VehicleFire', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance', 'fire'},
        coords    = data.coords,
        title     = '10-70V - Vehicle Fire',
        message   = 'Vehicle fire reported near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=436, scale=1.15, colour=1, flashes=true, text='Fire - Vehicle', time=7, radius=80 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:Explosion', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance', 'fire'},
        coords    = data.coords,
        title     = '10-44 - Explosion',
        message   = 'Explosion near ' .. data.street,
        flash     = true,
        sound     = 2,
        blip = { sprite=436, scale=1.2, colour=1, flashes=true, text='Explosion', time=8, radius=120 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:MedicalEmergency', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'ambulance', 'police'},
        coords    = data.coords,
        title     = 'Medical - Emergency',
        message   = 'Medical call at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=153, scale=1.1, colour=2, flashes=false, text='911 - Medical', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:Overdose', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'ambulance', 'police'},
        coords    = data.coords,
        title     = 'Medical - Overdose',
        message   = 'Possible overdose at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=153, scale=1.1, colour=1, flashes=false, text='911 - Overdose', time=6, radius=0 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:DeadBody', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'ambulance', 'police'},
        coords    = data.coords,
        title     = 'Medical - Possible DOA',
        message   = 'Possible deceased person at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=153, scale=1.1, colour=1, flashes=false, text='911 - DOA', time=6, radius=0 }
    })
end)

------------------------------------------------------------
-- MISC
------------------------------------------------------------

RegisterNetEvent('cd_dispatch:PreSet:NoiseComplaint', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police'},
        coords    = data.coords,
        title     = '10-85 - Noise Complaint',
        message   = 'Loud noise reported at ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=280, scale=1.0, colour=5, flashes=false, text='911 - Noise Complaint', time=6, radius=35 }
    })
end)

RegisterNetEvent('cd_dispatch:PreSet:AnimalAttack', function()
    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance'},
        coords    = data.coords,
        title     = '10-91 - Animal Attack',
        message   = 'Animal attack reported near ' .. data.street,
        flash     = false,
        sound     = 1,
        blip = { sprite=141, scale=1.0, colour=31, flashes=false, text='911 - Animal', time=6, radius=40 }
    })
end)


--[[
cd_dispatch:PreSet:StoreRobbery

cd_dispatch:PreSet:BankRobbery

cd_dispatch:PreSet:JewelryRobbery

cd_dispatch:PreSet:HouseBurglary

cd_dispatch:PreSet:Carjacking

cd_dispatch:PreSet:ShotsFired

cd_dispatch:PreSet:PersonWithGun

cd_dispatch:PreSet:Stabbing

cd_dispatch:PreSet:FightInProgress

cd_dispatch:PreSet:Kidnapping

cd_dispatch:PreSet:OfficerDown

cd_dispatch:PreSet:PanicButton

cd_dispatch:PreSet:BackupRequest

cd_dispatch:PreSet:Pursuit

cd_dispatch:PreSet:PrisonBreak

cd_dispatch:PreSet:StolenVehicle

cd_dispatch:PreSet:SuspiciousVehicle

cd_dispatch:PreSet:RecklessDriver

cd_dispatch:PreSet:TrafficCollision

cd_dispatch:PreSet:StreetRacing

cd_dispatch:PreSet:ATMAlarm

cd_dispatch:PreSet:BusinessAlarm

cd_dispatch:PreSet:DrugActivity

cd_dispatch:PreSet:SuspiciousPerson

cd_dispatch:PreSet:StructureFire

cd_dispatch:PreSet:VehicleFire

cd_dispatch:PreSet:Explosion

cd_dispatch:PreSet:MedicalEmergency

cd_dispatch:PreSet:Overdose

cd_dispatch:PreSet:DeadBody

cd_dispatch:PreSet:NoiseComplaint

cd_dispatch:PreSet:AnimalAttack
]]