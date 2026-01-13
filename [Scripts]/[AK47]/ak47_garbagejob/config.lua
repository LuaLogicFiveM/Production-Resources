Config = {}
Config.Locale = 'en'

Config.JobRequired = false -- set false if job is not required.
Config.JobName = 'garbage' -- The job name required to perform this work.
Config.Truck = 'master2' -- The vehicle model to be spawned.

-- Job Gameplay Settings
Config.MaxCollection = 10 -- The maximum number of dumpsters to empty per run.
Config.MinCollection = 6 -- The minimum number of dumpsters to empty per run.
Config.RewardPerCollection = math.random(250, 500) -- The base payment for each dumpster emptied.

-- Deposit Settings
Config.EnableDeposit = true -- Require a deposit to start the job?
Config.DepositAmount = 100 -- The amount for the deposit.

-- A list of valid dumpster object models the script can target.
-- NOTE: Removed a duplicate entry for model 218085040.
Config.DumpstersAvaialbe = {
    218085040, 666561306, -58485588, -206690185, 1511880420, 682791951,
    1437508529, 1614656839, -130812911, -93819890, 1329570871, 1143474856, -228596739, -468629664,
    -1426008804, -1187286639, -1096777189, -413198204, 1919238784
}

-- Marker definitions for drawing on the client.
Config.Marker = {
    JobStart = function()
        DrawMarker(20, Config.JobStart, 0.0, 0.0, 0.0, 0, 0.0, -3.0, 0.4, 0.4, 0.3, 0, 100, 0, 200, false, false, 2, false, false, false, false)
    end,
    JobEnd = function()
        DrawMarker(20, Config.JobEnd, 0.0, 0.0, 0.0, 0, 0.0, 90.0, 1.0, 1.0, 0.8, 0, 100, 0, 200, false, false, 2, false, false, false, false)
    end,
    Truck = function(truckpos, vehicle)
        DrawMarker(20, truckpos, 0.0, 0.0, 0.0, GetEntityRotation(vehicle), 0.4, 0.4, 0.3, 0, 100, 0, 200, false, false, 2, false, false, false, false)
    end,
    Dumpster = function(dumpPos, collectionDumpster)
        DrawMarker(20, dumpPos.x, dumpPos.y, dumpPos.z + 2.5, 0.0, 0.0, 0.0, GetEntityRotation(collectionDumpster), 0.8, 0.8, 0.7, 0, 100, 0, 200, true, false, 2, false, false, false, false)
    end
}

-- Locations
Config.VehicleSpawn = vector3(-341.8937, -1520.4663, 27.6202)
Config.VehicleHeading = 269.2906
Config.JobStart = vector3(-322.0021, -1545.9130, 31.0197)
Config.JobEnd = vector3(-330.1674, -1525.8997, 27.5353)

-- A list of all possible areas for trash collection.
Config.Collections = {
    {radius = 150.0, pos = vector3(114.83, -1462.31, 29.29), distanceBonus = 107},
    {radius = 150.0, pos = vector3(-6.04, -1566.23, 29.20), distanceBonus = 97},
    {radius = 150.0, pos = vector3(-1.88, -1729.55, 29.30), distanceBonus = 92},
    {radius = 150.0, pos = vector3(159.09, -1816.69, 27.91), distanceBonus = 76},
    {radius = 150.0, pos = vector3(358.94, -1805.07, 28.96), distanceBonus = 79},
    {radius = 150.0, pos = vector3(481.36, -1274.82, 29.64), distanceBonus = 100},
    {radius = 150.0, pos = vector3(127.94, -1057.73, 29.19), distanceBonus = 136},
    {radius = 150.0, pos = vector3(-1613.12, -509.06, 34.99), distanceBonus = 268},
    {radius = 150.0, pos = vector3(342.78, -1036.47, 29.19), distanceBonus = 127},
    {radius = 150.0, pos = vector3(383.03, -903.60, 29.15), distanceBonus = 134},
    {radius = 150.0, pos = vector3(165.44, -1074.68, 28.90), distanceBonus = 137},
    {radius = 150.0, pos = vector3(50.42, -1047.98, 29.31), distanceBonus = 132},
    {radius = 150.0, pos = vector3(-1463.92, -623.96, 30.20), distanceBonus = 265},
    {radius = 150.0, pos = vector3(443.96, -574.33, 28.49), distanceBonus = 166},
    {radius = 150.0, pos = vector3(-1255.41, -1286.82, 3.58), distanceBonus = 235},
    {radius = 150.0, pos = vector3(-1229.35, -1221.41, 6.44), distanceBonus = 240},
    {radius = 150.0, pos = vector3(-31.94, -93.43, 57.24), distanceBonus = 208},
    {radius = 150.0, pos = vector3(274.31, -164.43, 60.35), distanceBonus = 191},
    {radius = 150.0, pos = vector3(-364.33, -1864.71, 20.24), distanceBonus = 123},
    {radius = 150.0, pos = vector3(-1239.42, -1401.13, 3.75), distanceBonus = 230},
}

Config.MinRadius = 1.0 -- minimum radius to select a dumpstter from an area

Config.MaxRoll = 5 -- increase the value to make it easier to find items, minimum 1

-- Items that can be found in dumpsters.
Config.DumpsterItems = {
    {chance = 15, item = 'ls_iron_ingot', minimum = 1, maximum = 3}, -- chance %
    {chance = 15, item = 'ls_silver_ingot', minimum = 1, maximum = 3},
    {chance = 15, item = 'money', minimum = 1000, maximum = 3000},
    {chance = 15, item = 'black_money', minimum = 1000, maximum = 3000},
    {chance = 5, item = 'rifle_upper', minimum = 1, maximum = 2},
    {chance = 5, item = 'rifle_lower', minimum = 1, maximum = 2},
    {chance = 5, item = 'handgun_slide', minimum = 1, maximum = 2},
    {chance = 5, item = 'arpistol_upper', minimum = 1, maximum = 2},
    {chance = 5, item = 'great_white_shark', minimum = 1, maximum = 1},
    {chance = 5, item = 'ray', minimum = 1, maximum = 1},
    {chance = 5, item = 'hacking_device', minimum = 1, maximum = 1},
    {chance = 5, item = 'drill', minimum = 1, maximum = 1},
    {chance = 25, item = 'la_confidential_joint', minimum = 1, maximum = 5},
    {chance = 25, item = 'hightimebrownies', minimum = 1, maximum = 5},
    {chance = 1, item = 'brick_weed', minimum = 1, maximum = 2},
    {chance = 1, item = 'brick_fent', minimum = 1, maximum = 2},
    {chance = 1, item = 'brick_coke', minimum = 1, maximum = 2},
}