Config = {}

Config.Locale = "en" -- Locale: "en" or "nl"

Config.Framework = "esx" -- Framework: "qbcore", "qbox", or "esx"
Config.TargetSystem = "ox_target" -- Target System: "qtarget", "ox_target", or "esx"
Config.InventorySystem = "ox_inventory" -- Inventory System: "ox_inventory" or "qb-inventory"
Config.RateLimit = 3 -- Rate limiting in seconds between requests
Config.WeighDistance = 5.0 -- Distance check for weigh coordinate
Config.WeighZoneSize = 5.0 -- Size of the weigh zone (smaller = more precise)
Config.ComputerDistance = 1.0 -- Distance check for computer coordinate
Config.Debug = false -- true/false to enable debug zones
Config.WeightStations = {
    {
        name = "Weight Station",
        weighCoord = vector3(1532.0195, 839.2594, 77.7300), -- Vehicle position
        computerCoord = vector3(1543.0238, 850.4061, 78.3917), -- Player interaction position
        allowedJobs = {"sheriff", "sahp"}, -- Jobs with access
        blip = {
            enabled = true,
            sprite = 478,
            color = 5,
            scale = 0.8,
            label = "Weight Station" -- Optional: Leave empty for locale, or set custom name
        }
    },
}

-- Vehicle Class Weights (kg)
-- Fallback weights per vehicle class if GetVehicleHandlingFloat fails
Config.VehicleClassWeights = {
    [0] = 1200,   -- Compacts
    [1] = 1500,   -- Sedans
    [2] = 2200,   -- SUVs
    [3] = 1400,   -- Coupes
    [4] = 1600,   -- Muscle
    [5] = 1500,   -- Sports Classics
    [6] = 1300,   -- Sports
    [7] = 1350,   -- Super
    [8] = 200,    -- Motorcycles
    [9] = 1800,   -- Off-road
    [10] = 3500,  -- Industrial
    [11] = 2000,  -- Utility
    [12] = 2500,  -- Vans
    [13] = 15,    -- Cycles
    [14] = 2000,  -- Boats
    [15] = 2000,  -- Helicopters
    [16] = 5000,  -- Planes
    [17] = 1800,  -- Service
    [18] = 2000,  -- Emergency
    [19] = 3000,  -- Military
    [20] = 4000,  -- Commercial
    [21] = 50000, -- Trains
    ["default"] = 1500 -- Default fallback
}

-- NUI Theme Settings
Config.NUI = {
    theme = {
        primaryColor = "#c0392b",      -- Primary color
        secondaryColor = "#e74c3c",   -- Secondary color
        backgroundColor = "rgba(26, 26, 26, 0.95)", -- Background color
        textColor = "#ffffff",        -- Text color
        accentColor = "#e74c3c"       -- Accent color
    }
}