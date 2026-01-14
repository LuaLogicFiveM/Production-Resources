Config = {}

-- Debug Information
Config.Debug = true

-- Locales
Config.Language = 'en' -- Locale language

-- Framework Related
Config.Framework = 'ESX' -- Supports Qbox, QB, ESX & Mythic
Config.UseTarget = true -- If you don't want to use target, will use HelpNotify in bridge/functions
Config.Target = "ox_target" -- Supports ox_target, qb-target & mythic-targeting

-- Interface Related Options
Config.Notifications = "ox_lib" -- Supports ox_lib, qb, esx, mythic, okok, sd-notify, wasabi_notify, gta or custom
Config.Progress = "ox_lib_bar" -- Support ox_lib_bar, ox_lib_circle or mythic

-- Police & Dispatch Related
Config.Dispatch = "cd_dispatch" -- Supports cd_dispatch, qs-dispatch, ps-dispatch, rcore_dispatch, mythic-mdt, custom
Config.DispatchJobs = { "sheriff", "sahp" } -- Only for Qbox, QB & ESX
Config.NetworkAlertTimeout = 120 -- How often in seconds it limits the network alert so it can only be sent once and then have to wait this long before sending again (prevents spam)
Config.RequiredPolice = 2 -- How many police on duty to start heist

-- Cooldown
Config.GlobalCooldown = 900 -- In seconds currently at 15 minutes
Config.UseStoreCooldown = true -- Individual cooldown for different stores aswell as global
Config.StoreCooldown = 2700 -- In seconds currently at 45 minutes

-- Robbery Loot
Config.UseMoneyItem = true -- Whether or not to give them dirty money as an item (only setup for Qbox, QB & Mythic)
Config.TillValue = { min = 1000, max = 5000 }
Config.SafeItems = {
    {
        item = "ls_iron_ingot",
        amount = { min = 10, max = 20 },
        chance = 25
    },
    {
        item = "rifle_lower",
        amount = { min = 1, max = 1 },
        chance = 5
    },
    {
        item = "handgun_slide",
        amount = { min = 1, max = 1 },
        chance = 5
    },
    {
        item = "handgun_barrel",
        amount = { min = 1, max = 1 },
        chance = 5
    },
    {
        item = "handgun_trigger",
        amount = { min = 1, max = 1 },
        chance = 5
    },
    {
        item = "arpistol_upper",
        amount = { min = 1, max = 1 },
        chance = 5
    },
    {
        item = "black_money",
        amount = { min = 2500, max = 5000},
    }
}

-- All the different store location data
Config.Locations = {
    { -- Done
        ped = vec4(2676.61, 3280.18, 54.24, 328.88),
        safe = vec4(2671.78564453125, 3282.963134765625, 51.1290283203125, 60.99758148193359+180.0),
        network = {
            coords = vec3(2673.7368, 3280.7915, 52.5),
            radius = 0.6
        }
    },
    { -- Liquor Store
        ped = vec4(-2966.25, 391.53, 15.04, 86.9),
        safe = vec4(-2959.03, 387.61, 13.04, 0.58),
        network = {
            coords = vec3(-2957.36474609375, 390.2129211425781, 14.49756336212158),
	        radius = 0.6,
        }
    },
    { -- Sandy Shores 24/7
        ped = vec4(1959.43, 3741.15, 32.34, 300.68),
        safe = vec4(1956.483154296875, 3746.212158203125, 28.23163986206054, 29.81001472473144+180.0),
        network = {
            coords = vec3(1957.1350, 3743.4358, 29.65),
	        radius = 0.6,
        }
    },
    { -- Grapeseed LTD
        ped = vec4(1703.2390, 4924.2485, 42.0681, 57.0052),
        safe = vec4(1705.9361572265625, 4918.14453125, 41.06539535522461, -124.22879791259766+180.0),
        network = {
            coords = vec3(1703.7783, 4920.4961, 42.4531),
	        radius = 0.6,
        }
    },
    { -- 594 24/7 Vinewood
        ped = vec4(372.85, 327.87, 103.57, 247.13),
        safe = vec4(374.29339599609375, 333.3893127441406, 99.45428466796876, -13.93221950531005+180.0),
        network = {
            coords = vec3(372.7628, 330.8979, 101.0),
	        radius = 0.6,
        }
    },
    { -- Liquor Store Default
        ped = vec4(1134.15, -983.28, 46.42, 277.94),
        safe = vec4(1126.24, -980.77, 44.42, 184.81),
        network = {
            coords = vec3(1125.1610107421876, -983.6082763671875, 45.8283805847168),
	        radius = 0.6,
        }
    },
    { -- Done
        ped = vec4(1160.0796, -319.9303, 69.2095, 187.2648),
        safe = vec4(1162.506591796875, -313.8871154785156, 68.20684051513672, 11.82876300811767+180.0),
        network = {
            coords = vec3(1162.2623, -316.9412, 69.5),
	        radius = 0.6,
        }
    },
    { -- Done
        ped = vec4(-710.1788, -910.1434, 19.2200, 185.9678),
        safe = vec4(-706.7337646484375, -904.6083374023438, 18.21734046936035, 180.0),
        network = {
            coords = vec3(-707.5270, -907.4628, 19.75),
	        radius = 0.6,
        }
    },
    { -- Liquor Store
        ped = vec4(-1221.29, -908.03, 12.33, 34.85),
        safe = vec4(-1220.04, -916.32, 10.33, 302.49),
        network = {
            coords = vec3(-1216.9649658203126, -915.9669799804688, 11.73851585388183),
	        radius = 0.6,
        }
    },
    { -- Liquor Store
        ped = vec4(-1486.7, -377.5, 40.16, 138.08),
        safe = vec4(-1479.06, -374.17, 38.16, 50.64),
        network = {
            coords = vec3(-1479.7227783203126, -371.64654541015627, 39.5917854309082),
	        radius = 0.6,
        }
    },
    { -- Done
        ped = vec4(-47.6256, -1752.6582, 29.4254, 141.6769),
        safe = vec4(-41.41897583007812, -1750.6085205078125, 28.42274665832519, -36.50972747802734+180.0),
        network = {
            coords = vec3(-43.8785, -1752.3425, 30.0),
	        radius = 0.6,
        }
    },
    { -- Done
        ped = vec4(24.14, -1345.66, 29.5, 272.08),
        safe = vec4(24.50496292114257, -1340.0870361328125, 25.38491058349609, 180.0),
        network = {
            coords = vec3(23.6889, -1342.8601, 26.65),
            radius = 0.6
        }
    }
}

-- List of peds used for the cashier
Config.Peds = {
    `mp_m_shopkeep_01`
}

Config.ResetAccess = {
    Jobs = { ['sheriff'] = 10, ['sahp'] = 7 },
    Groups = { "owner", "manager", "admin" }
}
