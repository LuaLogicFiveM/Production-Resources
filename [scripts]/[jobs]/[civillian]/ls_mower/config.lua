Config = {}

-- Use an alternative player identifier (e.g., Discord, license, etc.)
Config.alternativeIdentifier = {
    enabled = true,
    identifier = "discord" -- OPTIONS: license, xbl, live, discord, fivem, license2
}

-- SQL driver used by the resource
Config.sqlDriver = "oxmysql"

-- ESX framework settings
Config.esxSettings = {
    enabled = true,
    oldEsx = false,    -- Use legacy ESX?
    account = 'money', -- ESX account to withdraw/deposit from
}

-- QB framework settings
Config.qbSettings = {
    enabled = false,
    UseNewQBExport = true, -- Set to false if using the old export method (uncomment in fxmanifest)
    account = 'cash',
}

-- Standalone mode settings
Config.standaloneSettings = {
    enabled = false,
    payment = false, -- Whether to use payment system in standalone
}

-- Targeting system settings
Config.target = {
    enabled = false,
    system = 'ox_target' -- OPTIONS: 'ox_target', 'qtarget', 'qb-target'
}

-- Debug mode settings
Config.debugMode = {
    debug = false,          -- Enables debug mode
    debugLocationIndex = 1 -- Which location to debug
}

-- Job restrictions
Config.job = {
    enabled = false,
    jobName = 'mower', -- Name of required job to start mowing
}

-- Rocks spawn and damage settings
Config.rocksAmount = {
    min = 3,              -- Minimum rocks per session
    max = 8,              -- Maximum rocks per session
    damagePerRock = 50.0, -- Damage to mower when hitting a rock
}

-- Grass spawn settings
Config.grassAmount = {
    min = 10,
    max = 25,
}

-- Minimum required task completion to get paid
Config.percentage = {
    enabled = true,        -- Whether to use percentage-based job completion
    minPercentGrass = 0.8, -- Minimum percentage of grass that needs to be cut
    minPercentRocks = 0.8, -- Minimum percentage of rocks that need to be picked
}

-- Anti-exploit and balance limitations
Config.limits = {
    streakMax = 5,     -- Max allowed streak
    paymentMax = 3000, -- Max allowed payment per job
}

-- Duration of mower movement animation
Config.mowerMovingAnim = {
    duration = 2000 -- Duration in milliseconds
}

-- Whether the player must use their own mower
Config.useOwnMower = false

-- Whether to use custom license plates
Config.customPlates = false

-- Mower speed configuration (in m/s)
Config.mowerSpeed = {
    default = 1.4, -- Base speed
    levelUp = 0.7  -- Speed bonus per level
}

-- List of grass models used in the game
Config.grassModels = {
    'prop_veg_grass_01_a',
    'prop_grass_dry_02',
    'prop_veg_grass_01_c',
}

-- List of rock models used in the game
Config.rockModels = {
    'rock_4_cl_2_2',
}

-- Vehicle model names
Config.vehiclesModels = {
    truck = 'lawntacoma',
    trailer = 'trailersmall',
    mower = 'mower'
}

-- Whether mower spawns attached to trailer
Config.lawnMowerAttached = true

-- Offset for mower spawn relative to vehicle
Config.lawnMowerSpawnOffset = {
    x = 0.5,
    y = -8.0
}

-- 3D text display settings
Config.Draw3dTextOptions = {
    fontId = 4,
    scaleX = 0.1,
    scaleY = 0.1
}

-- Vehicle door lock setting (refer to the list below)
Config.doorLockStatus = 1
-- 0: None
-- 1: Unlocked
-- 2: Locked
-- 3: Lockout Player Only
-- 4: Locked Player Inside
-- 5: Locked Initially
-- 6: Force Shut Doors
-- 7: Locked But Can Be Damaged

-- Target interaction settings
Config.targetInteract = {
    distance = 2.0 -- Max distance to interact with mower
}

-- Vehicle spawning locations and behavior

-- Out-of-bounds detection
Config.strictRules = {
    enabled = true,
    distanceAllowed = 200, -- Max allowed distance from main zone
    timeToReturn = 15      -- Time in seconds to return before punishment
}

-- Main job zone
Config.mainJobPlace = {
    showJobPlaceBlip = true,
    detectDistance = 30.0 -- Distance within which vehicles can be detected for returning deposit
}

-- Player level system (experience thresholds)
Config.levelTable = {
    [1] = 100,
    [2] = 250,
    [3] = 750,
    [4] = 1500,
    [5] = 2000,
}

-- Level name labels
Config.levelNames = {
    [1] = { name = "Beginner" },
    [2] = { name = "Intermediate" },
    [3] = { name = "Advanced" },
    [4] = { name = "Master" },
    [5] = { name = "Grass Artist" }
}

-- XP rewards
Config.experience = {
    perRock = 1,
    perGrass = 1,
    extra = 10
}

-- Payment configuration
Config.payments = {
    reward = math.random(15, 25), -- Payment per grass patch
    bonus = 50,
    depositForVehicles = 100, -- Deposit required for using vehicles
    perLevel = 500              -- Bonus per player level
}

Config.vehiclesSpawning = {
    vehiclesCount = 3, -- Number of vehicles (2 = truck + mower, 3 = truck + trailer + mower)

    truck = {
        x = -173.1445,
        y = -51.271,
        z = 53.492,
        heading = 157.06
    },
    trailer = {
        x = -171.5,
        y = -45.703,
        z = 52.54393,
        heading = 78.694
    },
    attachmentOffset = {
        x = 0.0,
        y = -1.0,
        z = 0.5,
    },
    mowerOff = {
        {
            x = -2.5, -- Left side unload position
            y = 0.0,
            z = -1.0,
        },
        {
            x = 2.5, -- Right side unload position
            y = 0.0,
            z = -1.0,
        },
        {
            x = 0.0, -- Rear unload position
            y = -4.5,
            z = -1.0,
        },
    },
}

-- Job marker and map blip settings
Config.jobMarkersAndBlips = {
    distanceJobMarker = 20.0, -- Radius of marker

    jobMarkerColor = {
        r = 0,
        g = 100,
        b = 0,
        a = 100
    },

    jobBlipSettings = {
        headquarters = {
            x = -153.903,
            y = -41.235,
            z = 54.326,
            heading = 95.497
        },
        configure = {
            sprite = 71,
            color = 25,
            alpha = 255,
            scale = 1.0,
        }
    },
}


Config.locations = {
    --1
    {
        coords = {
            x = -1315.29,
            y = 172.92,
            z = 58.02
        },
        pedCoords = {
            x = -1341.66,
            y = 161.57,
            z = 57.79,
            heading = 297.0
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }
    },
    --2
    {
        coords = {
            x = -782.512,
            y = -940.36,
            z = 17.48
        },
        pedCoords = {
            x = -769.69,
            y = -932.81,
            z = 17.94,
            heading = 160.7
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }

    },
    --3
    {
        coords = {
            x = -1051.695,
            y = -683.10,
            z = 22.844
        },
        pedCoords = {

            x = -1054.36,
            y = -703.99,
            z = 20.94,
            heading = 287.54
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }


    },


    --4--
    {
        coords = {
            x = -1301.893,
            y = -1435.82,
            z = 4.21
        },
        pedCoords = {
            x = -1301.83,
            y = -1419.19,
            z = 4.54,
            heading = 352.6
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }
    },
    --5


    {
        coords = {
            x = -1329.69,
            y = -1360.884,
            z = 4.425
        },
        pedCoords = {
            x = -1324.43,
            y = -1356.55,
            z = 4.79,
            heading = 279.28
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }
    },
    --6
    {
        coords = {
            x = -810.15,
            y = 861.17,
            z = 202.59
        },
        pedCoords = {
            x = -799.35,
            y = 865.67,
            z = 203.16,
            heading = 132.41
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }
    },
    --7
    {
        coords = {
            x = 1010.668,
            y = 226.648,
            z = 82.904
        },
        pedCoords = {
            x = 1007.966,
            y = 219.4,
            z = 82.29,
            heading = 239.159
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {
            {
                x = 1002.91,
                y = 219.673,
                z = 82.77,
                radius = 2.8
            }, -- blacklisted areas are the areas where grass won't spawn with a given radius
            {
                x = 1014.977,
                y = 231.231,
                z = 82.986,
                radius = 4.0
            }
        }
    },

    --8
    {
        coords = {
            x = 915.355,
            y = 109.89,
            z = 79.02
        },
        pedCoords = {
            x = 915.355,
            y = 109.89,
            z = 79.02,
            heading = 155.35
        },
        radius = {
            from = -10,
            to = 10,
        },
        blacklistedAreas = {

        }
    },
    --9
    {
        coords = {
            x = 1276.0,
            y = -643.50,
            z = 68.14,
        },
        pedCoords = {
            x = 1278.781,
            y = -651.6232,
            z = 67.72,
            heading = 338.68,
        },
        radius = {
            from = -7,
            to = 7,
        },
        blacklistedAreas = {
            {
                x = 1269.04,
                y = -651.25,
                z = 71.34,
                radius = 2.8
            }, -- blacklisted areas are the areas where grass won't spawn with a given radius
        }
    },
    --10
    {
        coords = {
            x = -678.364,
            y = -1853.236,
            z = 29.523
        },
        pedCoords = {
            x = -689.702,
            y = -1843.449,
            z = 29.00031,
            heading = 202.093
        },
        radius = {
            from = -7,
            to = 7
        },
        blacklistedAreas = {

        }
    },
    --11
    {
        coords = {
            x = -699.614,
            y = -1655.592,
            z = 25.166
        },
        pedCoords = {
            x = -687.185,
            y = -1661.338,
            z = 24.897,
            heading = 15.525
        },
        radius = {
            from = -7,
            to = 7
        },
        blacklistedAreas = {

        }
    },
    --12
    {
        coords = {
            x = -606.011,
            y = -1312.524,
            z = 11.864
        },
        pedCoords = {
            x = -609.720,
            y = -1302.114,
            z = 11.446,
            heading = 159.302
        },
        radius = {
            from = -7,
            to = 7
        },
        blacklistedAreas = {

        }
    },
    --13
    {
        coords = {
            x = -793.808,
            y = -25.058,
            z = 38.910
        },
        pedCoords = {
            x = -790.582,
            y = -36.146,
            z = 37.987,
            heading = 52.070
        },
        radius = {
            from = -7,
            to = 7
        },
        blacklistedAreas = {

        }
    },
    --14
    {
        coords = {
            x = -677.253,
            y = -35.667,
            z = 38.372
        },
        pedCoords = {
            x = -678.201,
            y = -45.674,
            z = 38.131,
            heading = 105.680
        },
        radius = {
            from = -7,
            to = 7
        },
        blacklistedAreas = {

        }
    },


}
