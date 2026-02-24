Config = {}

Config.debug = false

--- If you're testing the script and editing the values DO NOT simply restart the script. As this script is using custom models (dynos)
--- it will crash if you just restart it. Instead use the `/kq_dyno_restart` command. It will safely restart the script without causing you to crash


--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = true,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = false,
}


--- BASIC

-- Torque units | 'nm' or 'lb-ft'
Config.torqueUnits = 'lb-ft'


--- Horsepower and torque calculation formula
-- If you're not using vanilla or vanilla-like handling:
-- Try out different formulas and see what works best for your server.

-- 'vanilla' = Perfect setup for vanilla handling as well as handling files obeying the principles of vanilla GTA

-- 'highperformance1' = Good for servers using handling files which result in faster vehicles
-- 'highperformance2' = Good for servers using handling files which result in faster vehicles (extra)
-- 'highperformance3' = Good for servers using handling files which result in faster vehicles (extra)
---------------------------------------------
Config.dynoFormula = 'highperformance3'



--- FRAMEWORK OPTIONS (MAKE SURE TO ENABLE YOUR FRAMEWORK IF USING ONE) <!>
Config.jobWhitelist = {
    enabled = false,
    jobs = {
        'mechanic',
        'bennys',
    }
}


-- Time it takes for the screens to turn off after a dyno run (in seconds)
Config.screenTimeout = 15

-- Whether to display the dyno sheet on the screen as UI
Config.displaySheetOnScreen = true

-- Determines the location of the dyno sheet
Config.screenSheetOffset = {
    x = 0.84,
    y = 0.833,
}

-- Dynos setup
-- coords = vector3 of the dyno location
-- heading = heading of the dyno
-- model = model defined in Config.dynoModels (By leaving this out, you will create a dyno without a model. Useful for MLOs with built-in dynos)
-- displays = table of displays
--      displayCoords = vector3 of the display location
--      displayTilt = angle of the display tilt,
--      displayHeading = heading of the display
--      displayType = display defined in Config.displayTypes
-- jobs = Table of jobs which are allowed to use the dyno (false or nil to allow everyone to use it)
Config.dynos = {-- make a new line here and paste after copying ->
    --[[['shop_141'] = {
        coords = vector3(714.2995, 4182.3623, 40.9042),
        heading = 305.1510,

        model = 'default_gray',
    
        displays = {
            {
                displayCoords = vector3(717.1894, 4187.7920, 40.9042),
                displayHeading = 352.1803,
                displayType = 'stand',
            },
        },

        jobs = { },
    },]]--S
    ['mlo_588'] = {
        coords = vector3(850.7446, -177.9, 72.7203),
        heading = 147.1854,

        model = 'default_gray',
    
        displays = {
            {
                displayCoords = vector3(846.3737, -179.8424, 72.7183),
                displayHeading = 97.8115,
                displayType = 'stand',
            },
        },

        jobs = { },
    },
    ['shop_045'] = {
        coords = vector3(-254.8453, 6153.1021, 31.5006),
        heading = 132.7955,

        model = 'default_gray',
    
        displays = {
            {
                displayCoords = vector3(-252.5226, 6154.9448, 32.2559),
                displayHeading = 132.3464-180.0,
                displayType = 'wall_tv',
            },
        },

        jobs = { },
    },
    ['house_486'] = {
        coords = vector3(-316.8296, 708.9149, 204.6036),
        heading = 305.2766,

        model = 'default_gray',
    
        displays = {
            {
                displayCoords = vector3(-315.8873, 706.7217, 204.6036),
                displayHeading = 183.0,
                displayType = 'stand',
            },
        },

        jobs = { },
    },
    ['mlo262'] = {
        coords = vector3(1319.5735, 2617.9241, 39.2983),
        heading = 31.0,
    
        model = 'default_red',
       
        displays = {
            {
            displayCoords = vector3(1316.2849, 2615.9358, 41.6674),
            displayHeading = 127.0,
            displayType = 'wall_tv',
            },
        },

        jobs = {
        },
    },
    ['mlo698'] = {
        coords = vector3(-1178.2971, -1155.1252, 5.6569),
        heading = 193.0,
    
        model = 'default_red',
       
        displays = {
            {
            displayCoords = vector3(-1175.3977, -1152.9526, 6.6597),
            displayHeading = 288.0,
            displayType = 'wall_tv',
            },
        },

        jobs = {
        },
    },
    ['mlo592'] = {
        coords = vector3(677.7377, 171.0900, 80.7716),
        heading = 159.0,
    
        model = 'default_red',

        displays = {
            {
            displayCoords = vector3(673.7054, 174.2429, 81.5716),
            displayHeading = 70.5302,
            displayType = 'wall_tv',
            },
        },

        jobs = {
        },
    },
    ['mlo013'] = {
        coords = vector3(-759.8459, 5890.0889, 16.8444),
        heading = 239.8974,
    
        model = 'default_red',

        displays = {
            {
            displayCoords = vector3(-755.2640, 5892.1807, 18.0784),
            displayHeading = 330.8786,
            displayType = 'wall_tv',
            },
        },

        jobs = {
        },
    },
    ['mlo228'] = {
        coords = vector3(178.43200683594, 2792.9, 43.511001586914),
        heading = -80.36255645752,
    
        model = 'default_red',
    
        displays = {
            {
            displayCoords = vector3(177.5260, 2796.3, 44.6571),
            displayHeading = 10.0,
            displayType = 'wall_tv',
            },
        },

        jobs = {
        },
    },
    ['mlo542'] = { 
        coords = vector3(1441.7538, 1716.5223, 110.9059),
        heading = 294.2933,
        
        model = 'default_gray',
        
        displays = { -- 887
            {
                displayCoords = vector3(1443.5155, 1721.8054, 112.7330),
                displayHeading = 26.2707,
                displayType = 'wall_tv',
            },
        },
                
        jobs = {
        },
    },
    ['mlo111'] = { 
        coords = vector3(2000.7566, 4596.5005, 41.3877),
        heading = 294.6761,
        
        model = 'default_gray',
        
        displays = { -- 111
            {
                displayCoords = vector3(1997.2208, 4596.4253, 42.3031),
                displayHeading = 113.7448,
                displayType = 'wall_tv',
            },
        },
                
        jobs = nil,
    },
    ['mlo876'] = { 
        coords = vector3(-1114.8633, -2048.5107, 13.2617),
        heading = 222.7244,
        
        model = 'default_red',
        
        displays = { -- 887
            {
                displayCoords = vector3(-1117.5314, -2049.0784, 13.2617),
                displayHeading = 98.4357,
                displayType = 'stand',
            },
        },
                
        jobs = nil,
    },
    ['mlo927'] = {
        coords = vector3(123.1490, -3047.2788, 7.0409),
        heading = 265.3944,
        
        model = 'default_red',
        
        displays = { -- 927
            {
                displayCoords = vector3(120.8141, -3049.3979, 7.0409),
                displayHeading = 88.0090,
                displayType = 'stand',
            },
        },
                
        jobs = nil,
    }, -- copy this line
    ['mlo574'] = {
        coords = vector3(1120.4718, -795.1298, 57.7734),
        heading = 359.0,
        
        model = 'default_blue',
        
        displays = {
            {
                displayCoords = vector3(1122.5798, -794.5892, 57.6967),
                displayHeading = 236.4800,
                displayType = 'stand',
            },
        },
        
        jobs = nil,
    },
    ['mlo539'] = {
        coords = vector3(1397.9718, 1041.8899, 114.3322),
        heading = 273.8561,
        
        model = 'default_gray',
        
        displays = {
            {
                displayCoords = vector3(1396.8188, 1041.9906, 115.3322),
                displayHeading = 99.0687,
                displayType = 'wall_tv',
            },
        },
        
        jobs = nil,
    },
    ['mlo099'] = {
        coords = vector3(2731.8035, 4917.4233, 33.6913),
        heading = 315.0,
        
        model = 'default_blue',
        
        displays = {
            {
                displayCoords = vector3(2730.4929, 4916.2891, 34.6913),
                displayHeading = 314.2040-180.0,
                displayType = 'wall_tv',
            },
        },
        
        jobs = nil,
    },
    ['mlo725'] = {
        coords = vector3(118.4321, -1097.3007, 29.1733),
        heading = 271.1152,
        
        model = 'default_blue',
        
        displays = {
            {
                displayCoords = vector3(115.6239, -1097.5012, 31.5730),
                displayHeading = 267.2743-180.0,
                displayType = 'wall_tv',
            },
        },
        
        jobs = nil,
    },
    ['YelloBellyDyno2'] = {
        coords = vector3(-3001.2671, 4292.9629, 24.8779),
        heading = 160.0,
        
        model = 'default_blue',
        
        displays = {
            {
                displayCoords = vector3(-3000.6772, 4294.8193, 25.8779),
                displayHeading = 160.0+175.0,
                displayType = 'wall_tv',
            },
        },
        
        jobs = nil,
    },
    ['YelloBellyDyno'] = {
        coords = vector3(-2996.7483, 4303.3965, 24.8751),
        heading = 245.0,
        
        model = 'default_blue',
        
        displays = {
            {
                displayCoords = vector3(-2998.8999, 4304.5449, 25.8779),
                displayHeading = 245.0-180.0,
                displayType = 'wall_tv',
            },
        },
        
        jobs = nil,
    },
}


-- This is just used to fill the default dynos with their rollers
Config.baseRollers = {
    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(0.18, 0.6, -0.08),
        direction = -1,
        side = 1,
    },
    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(-0.18, 0.6, -0.08),
        direction = -1,
        side = 1,
    },

    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(0.18, -1.18, -0.08),
        direction = -1,
        side = 2,
    },
    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(-0.18, -1.18, -0.08),
        direction = -1,
        side = 2,
    },
}

-- Dyno models
Config.dynoModels = {
    ['default_yellow'] = {
        base = 'kq_dyno2_yellow',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_red'] = {
        base = 'kq_dyno2_red',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_purple'] = {
        base = 'kq_dyno2_purple',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_green'] = {
        base = 'kq_dyno2_green',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_gray'] = {
        base = 'kq_dyno2_gray',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_blue'] = {
        base = 'kq_dyno2_blue',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['basic'] = {
        base = 'kq_dyno',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, 0.0),
        rollers = {
            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(0.18, 0.9, -0.08),
                direction = -1,
                side = 1,
            },
            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(-0.18, 0.9, -0.08),
                direction = -1,
                side = 1,
            },

            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(0.18, -0.9, -0.08),
                direction = -1,
                side = 2,
            },
            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(-0.18, -0.9, -0.08),
                direction = -1,
                side = 2,
            },
        }
    },
}

-- Display types
-- prop = prop of the display
-- offset = offset of the display (texture, not the prop)
-- heading = heading of the display (texture, not the prop)
-- size = size of the display
Config.displayTypes = {
    ['stand'] = {
        prop = 'prop_cs_tv_stand',
        offset = vector3(0.529, -0.08, 1.01),
        heading = 180.0,
        size = vector2(1.098, 0.54),
    },
    ['monitor'] = {
        prop = 'prop_tv_flat_03',
        offset = vector3(0.35, -0.01, 0.025),
        heading = 180.0,
        size = vector2(0.7, 0.4),
    },
    ['wall_tv'] = {
        prop = 'prop_tv_flat_01',
        offset = vector3(1.07, -0.06, -0.12),
        heading = 180.0,
        size = vector2(2.14, 1.2),
    },
    ['wall_tv_2'] = {
        prop = 'xm_prop_x17_tv_flat_01',
        offset = vector3(0.798, -0.046, 0.152),
        heading = 180.0,
        size = vector2(1.5, 0.832),
    },
}

-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    start = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
}
