Config = {}

-- This enabled additional debug commands and logs
Config.debug = false

--- If you're testing the script and editing the values DO NOT simply restart the script. As this script is using custom models (wheelBalancers)
--- it will crash if you just restart it. Instead use the `/kq_drifttires_restart` command. It will safely restart the script without causing you to crash

-- Multiplier of the traction loss when using drift tires
-- Min = 0.1 | Max = 10 | Default = 1.0
Config.tractionLossMultiplier = 1.0

----------------------------------------------------------------------------------------------
--- FRAMEWORK OPTIONS
----------------------------------------------------------------------------------------------

--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = true,

    -- Account that will be used for tire shop purchases
    moneyAccount = 'money',

    sqlDriver = 'oxmysql', -- oxmysql or mysql

    -- Whether or not to use the new ESX export method
    useNewESXExport = true,

    -- Set to `true` if you're on a very old version of esx
    oldEsx = false,
}


--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = false,

    -- Account that will be used for tire shop purchases
    moneyAccount = 'cash',

    sqlDriver = 'oxmysql', -- oxmysql or mysql

    useNewQBExport = true, -- Make sure to uncomment the old export inside fxmanifest.lua if you're still using it
}


--- SETTINGS FOR STANDALONE
Config.standaloneSettings = {
    enabled = false,
    sqlDriver = 'mysql', -- oxmysql or mysql

    -------------------------
    --- Standalone commands:
    -- /jackvehicle     - Jacks up the nearest vehicle
    -- /getdrifttire    - Puts a drift tire in players hands
    -- /getregulartire  - Puts a regular tire in players hands
}



-- If you're using an older version of oxmysql you can set that here
Config.newOxMysql = true

----------------------------------------------------------------------------------------------
---
--- ADVANCED MODE (Wheel balancers)
--- Whether or not to use the "advanced mode"
---
--- ADVANCED MODE: Players will be required to take off wheels, bring them to the wheel balancer to swap the tire
--- on the wheel using the balancer.
---
--- SIMPLE MODE: Players will be able to take off wheels (those will then disappear/go into their inventory)
--- after that players will need to USE an tire type item in their inventory to get a wheel in their hands to
--- put it on back on the vehicle (This will allow players to swap tires without a wheel balancer)
---
--- beware - server restart is highly recommended after changing this option.
Config.advancedMode = true


----------------------------------------------------------------------------------------------
--- TARGET SYSTEM
----------------------------------------------------------------------------------------------

--- SIDENOTE: If you want to fully disable the 3d text you'll have to disable the screwing minigame as well (Config.screwdriverMinigame)

Config.target = {
    enabled = false,
    system = 'ox_target' -- 'ox_target', 'qtarget' or 'qb-target'  (Other systems might work as well)
}

----------------------------------------------------------------------------------------------
--- ITEMS
----------------------------------------------------------------------------------------------

-- Item names
Config.items = {
    driftTireItem = 'kq_drifttire',
    regularTireItem = 'kq_regulartire',
    carjackItem = 'kq_carjack',
}



----------------------------------------------------------------------------------------------
--- WHITE/BLACKLISTING
----------------------------------------------------------------------------------------------

-- Disallow certain vehicles or classes of vehicles from being tire swapped
Config.blacklist = {
    -- List of models that should not be able to swap tires
    vehiclesEnabled = false,
    vehicles = {
        'police',
        'taxi',
    },

    -- Classes that should not be allowed to swap tires (numerical values) https://docs.fivem.net/natives/?_0x29439776AAA00A62
    classesEnabled = false,
    classes = {
        8, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22
    },
}

-- Opposite of the blacklist. Only allows certain models/vehicle models to be swapped
Config.whitelist = {
    vehiclesEnabled = false,
    -- List of models that should be able to swap tires
    vehicles = {
        'futo',
        'futo2',
        'rt3000',
        'yosemite2',
        'comet6',
        'gauntlet4',
        'euros',
        'zr350',
        'dominator8',
    },

    classesEnabled = true,
    -- The only classes that should be allowed to swap tires (numerical values) https://docs.fivem.net/natives/?_0x29439776AAA00A62
    classes = {
        3, 4, 5, 6
    },
}


----------------------------------------------------------------------------------------------
--- EVENTS
----------------------------------------------------------------------------------------------
Config.wheelTakeOff = {
    -- Duration in ms of how long taking a wheel off will take (excl. the minigame)
    duration = 2500,
}

Config.wheelPutOn = {
    -- Duration in ms of how long putting a wheel on will take (excl. the minigame)
    duration = 2500,
}

Config.screwdriverMinigame = {
    -- Whether or not to enable the minigame
    enabled = true,
    -- How many times players will need to press
    presses = 12,
    -- How long players will need to wait if they miss click
    messedUpDuration = 2000,
    -- Keybinds used in the screw minigame
    keybinds = {
        'A', 'S', 'D', 'W'
    },


    ---
    -- https://lith.store/package/6174416
    -- Enables an alternative bolts minigame for taking off the wheels
    useLithStudiosBoltsMinigame = true,
}


----------------------------------------------------------------------------------------------
--- EXTRA
----------------------------------------------------------------------------------------------

-- Whether or not to apply a slight boost to vehicles engine power while mid drift (Helps lower powered vehicles stay in drift) (1.0 is the base car power)
Config.driftBoost = {
    enabled = true,
    power = 2.5
}


-- Only available for advanced mode
Config.jobWhitelist = {
    enabled = true,
    jobs = {
        'stanceandreas',
    }
}

-- Whether or not to enable KQ_CARLIFT support (https://kuzquality.com/package/5030175)
Config.kq_carliftSupport = {
    enabled = false,
}

-- Scale of the 3d text
Config.fontScale = 1.0

----------------------------------------------------------------------------------------------
--- WHEEL BALANCERS
--- Only applicable while using the 'Advanced Mode'
----------------------------------------------------------------------------------------------
Config.wheelBalancers = {
    -- Max wobble of a wheel when on a balancer (range between 2 and 10, lower = more realistic, higher = more visible)
    maxWobble = 3.0,

    -- Max spinning speed of a wheel when on a balancer (range between 2 and 15)
    maxSpinningSpeed = 5.0,

    -- Whether or not to show colored lights on the wheel balancers (uses more resources / higher resmon when using the balancer)
    enableLights = true,

    -- (Only when lights are diabled) How long each animation frame should take (lower = smoother, higher = less smooth)
    animationFrameTime = 30,

    -- Whether or not the wheel balancer should make a sound
    enableSounds = true,

    -- Locations where the wheel balancers will be created
    spawnLocations = {
        { x = 748.3369,  y = -774.2254,  z = 26.3665, h = 5.0 }, -- Rusty's Garage
        { x = 741.0521,  y = 1281.7485,  z = 360.294, h = 2.2144 }, -- Stance Andreas
    },
}

-------------------------------------------------------------------------------------------------
--- TIRE PRESSURE
-------------------------------------------------------------------------------------------------

Config.tirePressure = {
    enabled = true,
    models = {
        'prop_gas_airunit01',
        'imp_prop_air_compressor_01a',
        'prop_compressor_01',
        'prop_compressor_02',
        'prop_compressor_03',
    },
    cableLength = 5.0,
}


-------------------------------------------------------------------------------------------------
--- SHOPS
-------------------------------------------------------------------------------------------------
Config.tireShops = {
    enabled = true,
    -- Whether or not to show the shop blips on the map
    showBlip = false,

    -- Whether or not anyone can buy the items or just players who are allowed to swap the tires (jobs) (based off Config.jobWhitelist)
    anyoneCanBuy = false,

    -- Whether or not to let players buy the car jack set (Could be disabled to only use kq_carlift lifts)
    sellCarJack = true,

    prices = {
        carjack = 2500,
        driftTire = 750,
        regularTire = 250,
    },

    models = {
        driftTire = {
            model = 'prop_tyre_rack_01',
        },
        regularTire = {
            model = 'prop_wheel_tyre',
            offset = {
                pos = { x = 1.5, y = -0.7, z = -0.05 },
                rot = { x = 0.0, y = 0.0, z = -35.0 },
            },
        },
        carjack = {
            model = 'imp_prop_car_jack_01a',
            offset = {
                pos = { x = -1.5, y = -0.7, z = -0.43 },
                rot = { x = 0.0, y = 0.0, z = -25.0 },
            },
        },
    },

    -- Locations at which the shops will be created
    locations = {
        { x = 72.0948, y = -1582.5962, z = 29.5, h = 191.0 }, -- Auto Parts Store
        { x = 730.5756, y = -793.1351, z = 29.58, h = 311.0 }, -- Rusty's Garage
        { x = 753.1606, y = 1289.3107, z = 360.2946, h = 78.7669 }, -- Stance Andreas
    }
}


----------------------------------------------------------------------------------------------
--- KEYBINDS
----------------------------------------------------------------------------------------------
-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    takeOffWheel = {
        label = 'E',
        input = 38,
    },
    putOnWheel = {
        label = 'E',
        input = 38,
    },
    lowerVehicle = {
        label = 'G',
        input = 58,
    },
    cancelMinigame = {
        label = 'H',
        input = 74,
    },
    putAwayTire = {
        label = 'H',
        input = 74,
    },
    useBalancer = {
        label = 'G',
        input = 58,
    },
    changeTireType = {
        label = 'H',
        input = 74,
    },
    addBalancerWeights = {
        label = '⬆',
        input = 172,
    },
    removeBalancerWeights = {
        label = '⬇',
        input = 173,
    },
    removeWheelByForce = {
        label = 'G',
        input = 58,
    },
    purchase = {
        label = 'E',
        input = 38,
    },
    useAirCompressor = {
        label = 'E',
        input = 38,
    },
    addAir = {
        label = '⬆',
        input = 172,
    },
    removeAir = {
        label = '⬇',
        input = 173,
    },
    startOnKqCarlift = {
        label = 'G',
        input = 58,
    },
}
