Config = {}

-- ===========================================
-- GENERAL SETTINGS
-- ===========================================
Config.Debug = false -- Enable debug prints in console (set to false in production for cleaner logs)
Config.Language = 'en' -- Language selection: 'en' for English, 'bn' for Bengali
Config.Notify = 'ox' -- Notification system: 'qb', 'esx', 'qbx', 'ox', 'custom' (custom = built-in UI)
Config.Fuel = 'lc_fuel' -- Fuel system integration: 'ox_fuel', 'LegacyFuel', 'ps-fuel', 'cdn-fuel', 'lj-fuel', 'BigDaddy-Fuel', 'esx-sna-fuel', 'lc_fuel', 'okokGasStation', 'qb-fuel', 'qs-fuelstations', 'Renewed-Fuel'

-- ===========================================
-- AMBULANCE JOB SETTINGS
-- ===========================================
Config.AmbulanceJob = "default"  -- Ambulance job integration: "default" (uses framework functions), "VisnAre", "wasabi_ambulance", "brutal_ambulancejob", "ars_ambulancejob", "osp_ambulance"
Config.AllowAIEMSWithOffDuty = true  -- Allow AI EMS calls even when ambulance workers are off-duty
Config.AlivePlayerCanCall = false  -- Allow living players to call AI EMS (normally only dead players can call)

-- ===========================================
-- VEHICLE MODELS
-- ===========================================
Config.HeliModel = "polmav"        -- Helicopter model for air EMS
Config.CarModel = "ambulance"      -- Ambulance car model for ground EMS
Config.BoatModel = "seashark2"     -- Boat model for marine EMS
Config.SubModel = "Submersible"    -- Submarine model for underwater EMS

-- ===========================================
-- DOCTOR & REVIVE SETTINGS
-- ===========================================
Config.Doctor = 0                  -- Max online doctors before AI EMS is disabled (0 = AI works only when no doctors online)
Config.CallPayment = 5000           -- Cost for regular players to call EMS (doctors calling for others = FREE)
Config.RevivePayment = 1500        -- Payment received by ambulance society after successful revive
Config.ReviveTime = 5000           -- Time in milliseconds for revive animation (5000 = 5 seconds)
Config.EMSArrivalTime = 60         -- Time in seconds for EMS vehicle to arrive after call
Config.UseProgressBar = true       -- Show progress bar during revive process
Config.SetHealthAmount = false     -- Override default health after revive
Config.ReviveHealthAmount = 80     -- Health percentage after revive (60-100 recommended)

-- ===========================================
-- INVENTORY MANAGEMENT
-- ===========================================
Config.ClearInventoryOnRevive = false  -- Clear player's inventory when they are revived by AI EMS
Config.KeepItemsOnRevive = {           -- Items that will NOT be removed during inventory clearing
    "phone",                           -- Essential communication device
    "radio"                            -- Emergency communication device
}

-- ===========================================
-- KEYBINDS & COMMANDS
-- ===========================================
Config.RegisterKeybind = true          -- Enable keybind registration for opening EMS menu
Config.Keybind = 'G'                   -- Key to open EMS menu when dead

-- Quick Action Settings (Instant EMS call with single keypress)
Config.QuickAction = false              -- Enable quick action keybind
Config.QuickActionKey = ''            -- Key for instant EMS call
Config.QuickActionCommand = 'car'      -- Default vehicle type for quick action: 'car', 'heli', 'boat', 'sub'

-- Command Settings
Config.CallCommand = "ems"           -- Main command for calling AI EMS
Config.VehicleArgs = {                 -- Vehicle type arguments for /aiems command
    Heli = "heli",                     -- Helicopter EMS
    Car = "car",                       -- Ambulance car
    Boat = "boat",                     -- Rescue boat
    Sub = "merin"                      -- Submarine (use "sub" for cleaner command)
}
Config.CancelCommand = "emscancel"   -- Command to cancel active EMS call
Config.SendEMSCommand = "emsrequest"      -- Doctor-only command to call EMS for other players

-- ===========================================
-- VEHICLE SPAWN SETTINGS
-- ===========================================
Config.HeliSpawnHeight = 100       -- Height above player where helicopter spawns (units)
Config.HeliDescendDistance = 15     -- Distance above player where helicopter hovers before landing
Config.CarSpawnRange = 100          -- Search radius for suitable road spawn location (meters)
Config.BoatSpawnRange = 200         -- Search radius for suitable water spawn location (meters)
Config.SubSpawnRange = 50           -- Search radius for suitable underwater spawn location (meters)


-- ===========================================
-- PED (PARAMEDIC) CONFIGURATION
-- ===========================================
Config.UseCustomPED = false         -- Use custom paramedic appearance (set to true for custom PED below)
Config.DefaultPedModel = 's_m_m_paramedic_01' -- Default male paramedic model (used when UseCustomPED = false)

-- Custom PED configuration (only used when UseCustomPED = true)

Config.CustomPED = {
    model = 'mp_f_freemode_01', -- Female freemode model (change to male: 'mp_m_freemode_01')
    face = {
        shapeFirst = 21, -- Mother
        shapeSecond = 25, -- Father
        skinFirst = 10, -- Mother's skin tone
        skinSecond = 12, -- Father's skin tone
        shapeMix = 0.2, -- Mix between parents
        skinMix = 0.1,
    },
    hair = {
        hair = 1,
    },
    makeup = {
        makeupType = 4,
        makeupOpacity = 0.4,
        makeupColor = 24,
        makeupSecondaryColor = 0,
        blushOpacity = 0.4,
        blushColor = 22,
        lipstickOpacity = 1,
        lipstickColor = 0,
    },
    clothes = {
        { componentId = 11, drawableId = 565, textureId = 0 }, -- Jackets
        { componentId = 8, drawableId = 15, textureId = 0 }, -- Shirts
        { componentId = 3, drawableId = 15, textureId = 0 }, -- Hands
        { componentId = 4, drawableId = 6, textureId = 0 }, -- Pants
        { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
    }
}

-- ===========================================
-- RESTRICTED ZONES
-- ===========================================
-- Areas where AI EMS cannot be called (e.g., hospitals, safe zones)
Config.RestrictedZones = {
    --[[{
        coords = vector3(342.34, -584.84, 74.16), -- Example: Hospital area
        radius = 50.0                            -- Zone radius in meters
    },]]
}

-- ===========================================
-- BLIP SETTINGS
-- ===========================================
-- Radar blip configuration for different EMS vehicle types
Config.BlipSettings = {
    car = {sprite = 61, color = 5, flash = true},    -- Ambulance car blip
    boat = {sprite = 410, color = 5, flash = true},  -- Rescue boat blip
    heli = {sprite = 43, color = 5, flash = true},   -- Helicopter blip
    sub = {sprite = 308, color = 5, flash = true}    -- Submarine blip
}

-- ===========================================
-- HOSPITAL REVIVE SETTINGS
-- ===========================================
Config.HospitalRevive = false       -- Teleport player to hospital bed instead of reviving on spot
Config.HospitalSendDelayMs = 2500   -- Delay before teleporting to hospital (milliseconds)
Config.HospitalGetUpKey = 38        -- Key code for getting out of hospital bed (38 = E key)

-- Hospital Locations and Beds (used when HospitalRevive = true)
-- Players will be teleported to available beds in these hospitals for revive
Config.Hospitals = {
    --[[{
        name = "Pillbox Hospital",                    -- Hospital display name
        center = vector3(315.27, -591.35, 43.28),    -- Hospital center coordinates
        radius = 100.0,                              -- Hospital zone radius
        beds = {                                      -- Available hospital beds (vector4: x, y, z, heading)
            vector4(314.55, -584.38, 44.20, 345.99), -- Bed 1 coordinates
            vector4(317.84, -585.29, 44.20, 348.97), -- Bed 2 coordinates
        }
    },
    {
        name = "Sandy Shores Hospital",
        center = vector3(1839.6, 3672.93, 34.28),
        radius = 75.0,
        beds = {
            vector4(1848.53, 3702.34, 34.76, 120.90), -- Bed 1 coordinates
            vector4(1841.97, 3698.68, 34.72, 122.00), -- Bed 2 coordinates
        }
    },]]
}

-- ===========================================
-- SUBMARINE BEACH RESCUE LOCATIONS
-- ===========================================
-- Locations where submarine EMS will transport rescued players for treatment
-- After underwater pickup, players are brought to one of these beach coordinates
Config.SubmarineBeachLocations = {
    vector3(-650.03, 6336.33, 1.52), vector3(-202.01, 6686.95, 2.01), vector3(-26.18, 6993.72, 1.26), vector3(50.52, 7256.19, 1.03),
    vector3(-1006.77, 6274.56, 1.16), vector3(-922.35, 5778.50, 0.86), vector3(-1264.98, 5401.47, 0.53), vector3(-1413.02, 5235.45, 0.94),
    vector3(-1821.50, 4861.68, 0.61), vector3(-1821.58, 4861.77, 0.57), vector3(-2297.35, 4474.04, 1.05), vector3(-2529.17, 4030.54, 0.63),
    vector3(-2593.25, 3670.85, 0.78), vector3(-3052.03, 3534.38, 0.66), vector3(-3190.73, 3260.15, 0.61), vector3(-2961.95, 2242.83, 1.12),
    vector3(-3107.75, 1893.60, -0.01), vector3(-3229.04, 1366.65, 0.66), vector3(-3177.22, 269.13, 0.82), vector3(-2443.48, -335.43, 1.23),
    vector3(-1822.86, -959.80, 0.36), vector3(-1260.65, -1853.46, 0.64), vector3(-1977.27, -3144.69, 0.81), vector3(-988.92, -3593.75, 0.15),
    vector3(-856.11, -3073.98, 0.54), vector3(1373.26, -2752.88, 1.25), vector3(2280.79, -2164.77, 1.18), vector3(2677.90, -1722.71, 1.16),
    vector3(2844.28, -784.48, 0.84), vector3(2936.95, 322.76, 1.02), vector3(2963.72, 736.09, 0.63), vector3(2793.27, 1250.11, 1.28),
    vector3(3031.26, 1841.59, 1.02), vector3(3303.44, 2208.01, 0.41), vector3(3390.66, 2674.25, 0.81), vector3(3762.91, 3816.08, 0.73),
    vector3(3828.91, 4519.88, 1.34), vector3(3306.72, 5253.30, 0.80), vector3(3446.90, 5914.59, 0.68), vector3(2988.93, 6384.88, 0.46),
    vector3(1507.84, 6639.83, 1.16), vector3(1067.14, 6636.42, 1.10), vector3(802.27, 6674.50, 0.78), vector3(411.44, 6921.15, 1.07),
    vector3(242.74, 7073.42, 1.11), vector3(-2753.47, -106.27, 0.80), vector3(-2527.18, -278.47, 0.97), vector3(-2104.02, -583.44, 1.11),
    vector3(-1939.21, -776.15, 0.96), vector3(-1525.04, -1351.92, 0.98), vector3(-1448.77, -1533.06, 1.21), vector3(-1309.13, -1767.01, 0.90),
    vector3(-1120.85, -1855.58, 0.76), vector3(-782.50, -1497.76, 1.06), vector3(625.11, -1980.69, 8.55), vector3(1037.46, -666.47, 55.87),
    vector3(815.90, 3680.34, 30.14), vector3(1919.13, 3999.26, 30.10), vector3(2357.53, 4498.60, 30.10), vector3(1897.37, 4510.35, 30.43),
    vector3(1361.77, 4272.29, 30.18), vector3(782.97, 4141.48, 30.41), vector3(217.30, 4288.58, 30.15), vector3(-143.40, 3910.47, 30.83),
    vector3(-591.05, 4404.69, 15.40), vector3(-1477.78, 2597.57, 0.81),
    vector3(-1381.02, -3468.01, 0.55), vector3(-1699.31, -3355.35, 1.07), vector3(-1896.26, -3238.14, 0.40), vector3(-1997.38, -2979.57, 0.48),
    vector3(-1875.62, -2753.76, 0.49), vector3(-1737.85, -2510.25, 0.94), vector3(-1524.82, -2195.00, 0.86), vector3(-1289.53, -2031.70, 0.86),
    vector3(1074.17, -2685.91, 0.59), vector3(1838.91, -2703.54, 0.32),
    vector3(-821.75, -3415.64, 0.30), vector3(36.89, -2243.40, 0.59),
    vector3(1906.83, 254.68, 160.53), vector3(1925.74, 379.53, 160.50), vector3(1995.35, 351.43, 160.62)
}
