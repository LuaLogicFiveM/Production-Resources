
Config = {}                             -- Config Table (DO NOT REMOVE THIS LINE)

Config.Target = false             -- Targeting System: ox_target, qb-target, inside-interaction (Set to false to use the default GTA help message system)
Config.TargetName = false               -- Default: false - Targeting system resource name (if you changed the resource names of ox_target, qb-target, inside-interaction)
Config.TargetDistance = 3.0             -- Default: 5.0 - Targeting distance

Config.UseTextUI = true                 -- Use Text UI for help messages    
Config.TextUIPosition = "right-center"  -- Text UI Position: top-left, top-center, top-right, left-center, right-center, bottom-left, bottom-center, bottom-right

Config.OtherKeybind = "E"              -- Keybind to toggle the help text message or inside-interaction (Default: E)

Config.AllowConnectAny = true           -- Allow attaching any trailer

Config.ConnectMessage = true           -- Enable or disable the connect message
Config.ConnectDistance = 3.0            -- Distance to check for a trailer bone (Defaults to 0.6 for double trailers)
Config.ConnectKeybind = "J"             -- Keybind to connect any compatible trailer (Default: J)

Config.AttachHelpers = {
    Enable = true,                      -- Enable or disable the attach helpers
    Size = vec3(0.4, 0.4, 0.6),         -- Size of the attach helper
}

Config.StaticHelper = {
    Enable = true,                      -- Enable or disable the rampless helper marker
    Size = vec3(2.5, 6.0, 1.0),         -- Size of the rampless helper
}

Config.BTrain = {                       -- BTrain/Double trailer system
    Enable = true,                      -- Enable or disable the BTrain system
    Limit = 3,                          -- Number of trailers allowed to be attached to a B-Train
    AllowInvisible = true,              -- Allow setting the player invisible while double trailer attempts are made
    Attempts = 3,                       -- Number of attempts to attached a double trailer (If exists)
}

Config.AttachMessage = true             -- Enable or disable the attach message
Config.AttachKeybind = "E"              -- Keybind to attach/detach to/from trailer (Default: E)
Config.AttachDistance = 3.0             -- Attach dstance for boat and static trailers

Config.ForcedWhitelist = false          -- Force whitelist trailers only

Config.TrailerBlacklist = {             -- Trailer Blacklist (If you want to blacklist a trailer. Typically flatbeds for a flatbed script)
    -- [`112towmfd5`] = true,
}

Config.Trailers = {                     -- Trailer Whitelist & Trailer Info
--  [`MODEL_NAME`] = {
--      isBoat = false,                 -- Is the trailer a boat trailer
--      isDolly = false,                -- Force the dolly direction until attached to another trailer (ONLY USE FOR DOLLYS)   
--      onAttachedExtras = {},          -- Extras to enable when a vehicle is attached to the trailer
--      ramp = {                        -- Ramp Configuration (Can add multiple ramps/doors/lifts) (Set to false if there is none)
--          {                           -- Ramp/Door 1  
--              label = 'Ramp & Doors', -- Label for the ramp
--              instant = false,        -- Instantly close the ramp when the close button is pressed
--              doors = {5, 4},         -- Door ID's to open/close when the ramp is opened/closed
--              wait = 1500,            -- Wait time between open/close functions to employ some special mechanics
--              extras = {},            -- Extras to enable when the ramp is opened/closed
--              extrasHealth = false,   -- Initiate a simple repair on the extras when the ramp is opened/closed
--          },
--      },
--      static = {                      -- Static Configuration (Set to false if there is none)
--          load = {offset = vec3(0.0, 0.0, 0.0), rotation = vec3(0.0, 0.0, 0.0)},  -- Load Position
--          bed = {
--              {offset = vec3(0.0, 0.0, 0.0), rotation = vec3(0.0, 0.0, 0.0)},     -- Bed Position 1
--              {offset = vec3(0.0, 0.0, 0.0), rotation = vec3(0.0, 0.0, 0.0)}      -- Bed Position 2
--         }
--      },
--  },
    [`dollyy`] = {  
        isBoat = false,           
        onAttachedExtras = {},
        ramp = false,
        isDolly = true,
    },
    [`boattrailer`] = {
        isBoat = true,           
        onAttachedExtras = {},
        ramp = false,
        offset = vec3(0.0, -1.0, 0.25),
    },
    [`jetskitrailer`] = {
        isBoat = true,           
        onAttachedExtras = {},
        ramp = false,
    },
    [`yftrailer`] = {
        isBoat = true,           
        onAttachedExtras = {},
        ramp = false,
        offset = vec3(0.0, -0.5, 1.6),
    },
    [`ftrailer`] = {
        isBoat = true,           
        onAttachedExtras = {},
        ramp = false,
        offset = vec3(0.0, 0.0, 1.5),
    },
    [`tr2`] = {  
        isBoat = false,           
        onAttachedExtras = {},
        ramp = {
            {
                label = 'Main Ramp',
                instant = true,
                doors = {5},
                extras = {},
            },
            {
                label = 'Top Ramp',
                instant = false,
                doors = {4},
                extras = {},
            },
        },
    },
    [`3ctrailer`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`cotrailer`] = {       
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`shauler`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`bigtex40`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },   
    },
    [`bigtex20`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },    
    },
    [`godzcoe`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`thauler`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`btrailer`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`bclandscape`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`trailersmall`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`camperman`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {4},
                extras = {},
            },
        },
    },
    [`chauler`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`godzhauler`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },  
    },
    [`GODzDUBTDHAULER`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {0},
                extras = {},
            },
        },   
    },
    [`godzenclosed`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {},
                extras = {3},
            },
            {
                label = 'Other Ramp',
                instant = false,
                doors = {},
                extras = {2},
            },
        },
  
    },
    [`enclosedgoose`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },    
    },
    [`godzbenson`] = {  
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`trailers3`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = true,
                doors = {5},
                extras = {},
            },
        },    
    },
    [`17fontaine`] = {  
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },    
    },
    [`17fontainev2`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },  
    },
    [`17fontainev3`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },    
    },
    [`17fontainev4`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },   
    },
    [`20fttrailer`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {},
                extras = {3},
            },
        },
   
    },
    [`pjutility`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`bigtexb`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`cartrailer`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {},
                extras = {1},
                extrasHealth = true,
            },
        },
    },
    [`semihauler`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },   
    },
    [`ehauler`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`pjtrailer`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },    
    },
    [`8220b`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`8220`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`8250`] = { 
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },   
    },
    [`ctrailer`] = {  
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },   
    },
    [`btex20`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`40ft`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {},
                extras = {3},
            },
        },
    },
    [`eagerbeaver`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`valdeztrailer`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {5},
                extras = {},
            },
        },
    },
    [`zJuksCarHauler40ft`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {},
                extras = {6},
            },
        },
    },
    [`alwayshaulin`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Main Ramp',
                instant = false,
                doors = {},
                extras = {1},
                extrasHealth = true,
            },
        },
        static = {
            load = {offset = vec3(0.033892679959536, -9.952220916748, 0.22392764687538), rotation = vec3(-1.1869255304337, 0.91369551420212, 0.47817993164062)},
            bed = {
                {offset = vec3(0.024883376434445, 1.2543928623199, 3.0684070587158), rotation = vec3(5.9934682846069, 0.25322663784027, -0.38055419921875)},
                {offset = vec3(0.0011255908757448, -5.157576084137, 2.7621600627899), rotation = vec3(-0.57490485906601, 0.22213354706764, -0.29159545898438)}
            }
        },
    },
    [`GODzATCHAULER`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Ramp & Doors',
                instant = false,
                doors = {5, 4},
                extras = {},
            },
            {
                label = 'Inside Lift',
                instant = false,
                wait = 3000,
                doors = {0},
                extras = {},
            },
        },
    },
    [`trflat`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = false,
        static = {
            load = {offset = vec3(-0.015930283814669, -11.456136703491, -0.57656562328339), rotation = vec3(0.0, 0.0, 0.0)},
            bed = {
                {offset = vec3(-0.0092795277014375, 2.9069042205811, 0.85275667905807), rotation = vec3(0.0, 0.0, 0.0)},
                {offset = vec3(-0.01694655045867, -2.3402237892151, 0.85348111391068), rotation = vec3(0.0, 0.0, 0.0)}
            }
        },
    },
    [`purplerain`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = false,
        static = {
            load = {offset = vec3(-0.11661037802696, 6.8088603019714, -0.22011266648769), rotation = vec3(0.0, 0.0, 0.0)},
            bed = {
                {offset = vec3(0.057612288743258, 0.85853165388107, 2.494416475296), rotation = vec3(-1.5376853942871, 0.46284732222557, 0.19818115234375)},
                {offset = vec3(0.08884759247303, -4.246741771698, 2.0897567272186), rotation = vec3(7.8704376220703, 0.48643493652344, -0.1363525390625)}
            }
        },
    },
    [`cargoplane`] = {
        isBoat = false,           
        onAttachedExtras = {}, 
        ramp = {
            {
                label = 'Ramp',
                instant = false,
                doors = {2},
                extras = {},
            },
        },
    },
}