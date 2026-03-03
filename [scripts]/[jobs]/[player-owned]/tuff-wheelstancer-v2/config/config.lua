Config = Config or {}
Menu   = {}

--[[
    ===============================
    ⚙️ Developer Debug Settings
    ===============================
]]

Config.RefreshTime = 2000  -- Interval in ms to refresh zone checks (0 disables)
Config.debugPoly   = false -- Enables drawing of polyzone outlines (used for debugging zone shapes)
Config.debug       = false  -- Enables printing debug info to console

--[[
    ===============================
    ⚙️ Core Settings
    ===============================
]]

Config.Framework              =
"standalone"                                -- "qb", "esx", "auto","standalone" If you dont want to use any provided framework functions, Checkout sv_editable.lua
Config.AllowOnlyOwnedVehicles = false -- Only allow stancing for vehicles the player owns (logic handled in sv_editable.lua)
Config.Notify                 =
"ox_lib"                              -- Notification system to use (supports: codem, esx, qb, okok, wasabi, t-notify, r_notify, pNotify, mythic, ox_lib)
Config.StanceRenderDistance   = 250.0 -- Max distance (in meters) at which stance changes are applied to vehicles

--[[
    ===============================
    📍 Location & Blip Settings
    ===============================
]]

-- Global Settings for all Stance Locations
Config.DisableWheelSize = false -- If true, disables wheel size in the main stancer UI and ignores ALL_WHEELS_SIZE changes

Config.GeneralBlip = {
    Sprite  = 545,                   -- Blip icon (https://docs.fivem.net/docs/game-references/blips/)
    Display = 4,                     -- Blip display mode
    Scale   = 0.8,                   -- Size of the blip
    Colour  = 70,                    -- Blip color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
    Name    = "Stancer Menu" -- Name that appears on the map
}

Config.PreviewExitKey = {
    controlId = 200,    -- https://docs.fivem.net/docs/game-references/controls/
    displayName = "ESC" -- The Button name shown in the UI of the stancer.
}
-- Locations where stancer is available
Config.Stance_Locations = {
    ["1"] = {
        enable               = true,                                      -- Enables this location
        coords               =  vec4(-373.714294, -115.292305, 38.682007, 175.748032), -- Coordinates and heading for the interaction
        interactDistance     = 5.0,                                       -- Max distance to trigger interaction
        ItemRequired         = false,                                     -- Whether specific item(s) are required
        ItemChecks           = { toolkit = true, stancekit = true },      -- If ItemRequired is true, list items that can be accepted (set any to true)
        ItemRemoval          = false,                                     -- Remove one of the required items
        IgnoreCarLiftSection = true,                                     -- Set true to allow stancing without using the carlift to apply it
        DynamicPricings      = {                                          -- Dynamic Pricing for each option
            WHEEL_TYPE               = 500,
            WHEEL_NUMBER             = 500,
            ALL_WHEELS_WIDTH         = 100,
            ALL_WHEELS_SIZE          = 100,
            ALL_WHEELS_OFFSET        = 100,
            ALL_WHEELS_CAMBER        = 100,
            SUSPENSION_HEIGHT        = 100,
            WHEEL_FRONT_LEFT_OFFSET  = 100,
            WHEEL_FRONT_RIGHT_OFFSET = 100,
            WHEEL_REAR_LEFT_OFFSET   = 100,
            WHEEL_REAR_RIGHT_OFFSET  = 100,
            WHEEL_FRONT_LEFT_CAMBER  = 100,
            WHEEL_FRONT_RIGHT_CAMBER = 100,
            WHEEL_REAR_LEFT_CAMBER   = 100,
            WHEEL_REAR_RIGHT_CAMBER  = 100,
        },
        Options              = { -- Disable/Enable any options for this location
            WHEEL_TYPE               = true,
            WHEEL_NUMBER             = true,
            ALL_WHEELS_WIDTH         = true,
            ALL_WHEELS_SIZE          = true,
            ALL_WHEELS_OFFSET        = true,
            ALL_WHEELS_CAMBER        = true,
            SUSPENSION_HEIGHT        = true,
            WHEEL_FRONT_LEFT_OFFSET  = true,
            WHEEL_FRONT_RIGHT_OFFSET = true,
            WHEEL_REAR_LEFT_OFFSET   = true,
            WHEEL_REAR_RIGHT_OFFSET  = true,
            WHEEL_FRONT_LEFT_CAMBER  = true,
            WHEEL_FRONT_RIGHT_CAMBER = true,
            WHEEL_REAR_LEFT_CAMBER   = true,
            WHEEL_REAR_RIGHT_CAMBER  = true,
        },
        JobLock              = {
            JobRequired = false,         -- Whether a job check is required to access stancing
            jobs = {
                mechanic = { 1, 2, 3 }, -- Mechanic job allowed with grade 1, 2 or 3
                police   = true         -- Police job allowed, all grades
            }
        },
        Invoice              = {
            AllowInvoice = false,
            InvoiceSocietyName = 'mechanic'
        },
        blip                 = true, -- Whether to display a blip for this location
        blipDetails          = {}    -- Datas that are in this will be callbacked to the global blip details (Config.Generalblip)
        -- Example custom blipDetails:
        -- blipDetails = {
        --     Sprite = 446,
        --     Scale = 0.5,
        --     Name = "Custom Stancer Shop"
        -- }
    },
    ["2"] = {
        enable               = true,                                      -- Enables this location
        coords               =  vec4(1725.8990, 3723.7935, 34.0586, 292.8712), -- Coordinates and heading for the interaction
        interactDistance     = 5.0,                                       -- Max distance to trigger interaction
        ItemRequired         = false,                                     -- Whether specific item(s) are required
        ItemChecks           = { toolkit = true, stancekit = true },      -- If ItemRequired is true, list items that can be accepted (set any to true)
        ItemRemoval          = false,                                     -- Remove one of the required items
        IgnoreCarLiftSection = true,                                     -- Set true to allow stancing without using the carlift to apply it
        DynamicPricings      = {                                          -- Dynamic Pricing for each option
            WHEEL_TYPE               = 500,
            WHEEL_NUMBER             = 500,
            ALL_WHEELS_WIDTH         = 100,
            ALL_WHEELS_SIZE          = 100,
            ALL_WHEELS_OFFSET        = 100,
            ALL_WHEELS_CAMBER        = 100,
            SUSPENSION_HEIGHT        = 100,
            WHEEL_FRONT_LEFT_OFFSET  = 100,
            WHEEL_FRONT_RIGHT_OFFSET = 100,
            WHEEL_REAR_LEFT_OFFSET   = 100,
            WHEEL_REAR_RIGHT_OFFSET  = 100,
            WHEEL_FRONT_LEFT_CAMBER  = 100,
            WHEEL_FRONT_RIGHT_CAMBER = 100,
            WHEEL_REAR_LEFT_CAMBER   = 100,
            WHEEL_REAR_RIGHT_CAMBER  = 100,
        },
        Options              = { -- Disable/Enable any options for this location
            WHEEL_TYPE               = true,
            WHEEL_NUMBER             = true,
            ALL_WHEELS_WIDTH         = true,
            ALL_WHEELS_SIZE          = true,
            ALL_WHEELS_OFFSET        = true,
            ALL_WHEELS_CAMBER        = true,
            SUSPENSION_HEIGHT        = true,
            WHEEL_FRONT_LEFT_OFFSET  = true,
            WHEEL_FRONT_RIGHT_OFFSET = true,
            WHEEL_REAR_LEFT_OFFSET   = true,
            WHEEL_REAR_RIGHT_OFFSET  = true,
            WHEEL_FRONT_LEFT_CAMBER  = true,
            WHEEL_FRONT_RIGHT_CAMBER = true,
            WHEEL_REAR_LEFT_CAMBER   = true,
            WHEEL_REAR_RIGHT_CAMBER  = true,
        },
        JobLock              = {
            JobRequired = false,         -- Whether a job check is required to access stancing
            jobs = {
                mechanic = { 1, 2, 3 }, -- Mechanic job allowed with grade 1, 2 or 3
                police   = true         -- Police job allowed, all grades
            }
        },
        Invoice              = {
            AllowInvoice = false,
            InvoiceSocietyName = 'mechanic'
        },
        blip                 = true, -- Whether to display a blip for this location
        blipDetails          = {}    -- Datas that are in this will be callbacked to the global blip details (Config.Generalblip)
        -- Example custom blipDetails:
        -- blipDetails = {
        --     Sprite = 446,
        --     Display = 4,
        --     Scale = 0.5,
        --     Colour = 5,
        --     Name = "Custom Stancer Shop"
        -- }
    },
}


--[[
    ===============================
    🔐 Admin Settings
    ===============================
]]

Config.Administration = {
    StanceCommand        = "adminstancer",   -- Command to force-open stancer UI as admin
    RemoveStancerCommand = "adminrestancer", -- Command to remove stance from target vehicle
    RemovePrice          = 0                 -- Price to charge for removing stance (0 = free)
}

--[[
    ===================
    TEXTUI Settings
    ===================
]]

-- Determines how the interaction UI is triggered.
-- Options:
--   "buttonPress" - Press a key (e.g. "E") to interact.
--   "RadialMenu"  - Uses a radial menu to interact.
Config.Interact = "buttonPress"

-- If Config.Interact is set to "RadialMenu", specify which radial menu system to use.
-- Options:
--   "qb-radialmenu" - Default QB-core radial menu.
--   "ox_lib"        - ox_lib radial menu support.
--   "custom"        - Use your own custom implementation (handled in cl_editable.lua).
Config.RadialMenu = "ox_lib"

-- Which text UI system to use for showing interaction hints.
-- Options:
--   "ox_lib"        - Uses ox_lib's built-in text UI.
--   "cd_drawtextui" - Uses cd_drawtextui system.
--   "jg-textui"     - Uses jg-textui system.
--   "lab-HintUI"    - Uses lab-HintUI system.
--   "okokTextUI"    - Uses okokTextUI system.
Config.DrawTextScript = 'ox_lib'

-- Configuration for displaying the interaction text UI.
Config.DrawTextUI = {
    enable     = true,                           -- Enable or disable the text UI system.
    hotkey     = "e",                            -- Key to press for interaction if using "buttonPress".
    text       = "Press %s to open Stance Menu", -- Text to show. "%s" will be replaced by the hotkey automatically.
    custom     = function(text)                  -- Function to show the text UI using the selected DrawTextScript.
        if Config.DrawTextScript == 'ox_lib' and lib then
            lib.showTextUI(text, {
                position = "top-center",
                icon = 'hand',
                style = {
                    borderRadius = 0,
                    backgroundColor = '#48BB78',
                    color = 'white'
                }
            })
        elseif Config.DrawTextScript == 'cd_drawtextui' then
            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
        elseif Config.DrawTextScript == 'jg-textui' then
            exports['jg-textui']:DrawText(text)
        elseif Config.DrawTextScript == 'lab-HintUI' then
            exports['lab-HintUI']:Show(text, "Wheel Stancer")
        elseif Config.DrawTextScript == 'okokTextUI' then
            exports['okokTextUI']:Open(text, 'darkblue')
        end
    end,
    customhide = function() -- Function to hide the text UI depending on which DrawTextScript is used.
        if Config.DrawTextScript == 'ox_lib' and lib then
            lib.hideTextUI()
        elseif Config.DrawTextScript == 'cd_drawtextui' then
            TriggerEvent('cd_drawtextui:HideUI')
        elseif Config.DrawTextScript == 'jg-textui' then
            exports['jg-textui']:HideText()
        elseif Config.DrawTextScript == 'lab-HintUI' then
            exports['lab-HintUI']:Hide()
        elseif Config.DrawTextScript == 'okokTextUI' then
            exports['okokTextUI']:Close()
        end
    end,
}

-- Dynamically change the text shown in DrawTextUI based on the interaction method. [#DONT TOUCH!]
if Config.DrawTextUI.enable and Config.Interact == "RadialMenu" then
    Config.DrawTextUI.text = "Open Radial Menu To Stance the vehicle."
elseif Config.DrawTextUI.enable and Config.Interact == "buttonPress" then
    -- If using buttonPress, inject the hotkey into the text string.
    Config.DrawTextUI.text = string.format(Config.DrawTextUI.text, string.upper(Config.DrawTextUI.hotkey))
end

-- Configuration for drawing a marker on the ground at stance locations.
Config.DrawMarker = {
    enabled         = true, -- Enable or disable marker drawing.
    Scale           = 1.0,
    MarkerType      = 20,   -- Marker type. Reference: https://docs.fivem.net/docs/game-references/markers/

    -- Marker color values. Reference RGBA values from: https://rgbacolorpicker.com/
    red             = 255,  -- Red component (0–255)
    green           = 255,  -- Green component (0–255)
    blue            = 252,  -- Blue component (0–255)
    alpha           = 100,  -- Transparency (0–255)

    MarkerUpAndDown = true, -- If true, marker has vertical pulsing animation.
    MarkerRotate    = true, -- If true, marker rotates in place.
}


--[[
    ===============================
    🧾 Inventory Settings
    ===============================
]]

Config.Inventory = {
    Enable_Inventory = true,          -- Enable inventory-based item check
    Inventory_Name   = "ox_inventory" -- Inventory resource name (e.g., qb-inventory, ox_inventory, etc.)
}

--[[
    ==============================
    REMOVE STANCE COMMAND SETTINGS
    ==============================
]]

-- Configuration for the command that removes a stance from a vehicle.
-- The Ui Will Automatically Put the Plate on the Input If the Player is within a Vehicle
-- Default usage: /dv_stance
Config.Remove_Stance_Command = {
    Enable                = true,        -- Enable or disable the /dv_stance command entirely.
    ResetWheelTypeAndWheelNumber = true,        -- You can set this to false to prevent dv_stance from resseting the wheels if they were changed by stancer itself
    Command_name          = "stancer_reset", -- The actual command players will use to remove a vehicle's stance.
    IgnoreStanceLocations = true,        -- If true, the command can be used anywhere. If false, it only works within defined stance locations.
    RemovePrice           = 0,           -- Price to remove the stance. Set to 0 for free.
    Requires_Jobs         = false,        -- If true, only players with specific jobs and grades can use the command.
    Jobs                  = {
        ["mechanic"] = { 1, 2, 3 },      -- Only grades 1, 2, and 3 from 'mechanic' job can use the command.
        ["police"]   = true,             -- All police grades can use the command.
    },
    ItemRequired          = false,       -- If true, using the command requires a specific item in inventory.
    ItemChecks            = {
        ["toolkit"]   = true,            -- Players with a "toolkit" can use the command (if ItemRequired = true).
        ["stancekit"] = true,            -- Players with a "stancekit" can also use the command.
    },
    ItemRemoval                  = false,       -- Remove One of the required items
}


--[[
    =======================
    🚗 Car lift Settings
    =======================
]]

Config.Carlift = {
    Enable = true, -- Enable/disable car lift system
    Locations = {  -- Car lift locations with heading
        ['shop_927_lift'] = {
            x = 124.94,
            y = -3035.2,
            z = 7.04,
            heading = 266.57,
            displayName = 'Bennys 3' -- Shown in wheel storage UI as the name.
        },
    },
    WheelStorages = {
        ['shop_927_storange'] = {
            x = 121.0933,
            y = -3028.5286,
            z = 6.9230,
            LiftDistance = 50.0 -- Vehicles on lifts within this distance will be shown as presets for the wheel storage UI
        }
    },
    -- Fallback search radius for matching lifts to wheel storage locations.
    -- If nil, LiftDistance is used. Recommended to keep this >= actual lift-to-storage distance.
    WheelStorageSearchDistance = 50.0,
    Requires_Jobs = false,           -- Restrict the lift usage to jobs
    Jobs = {
        ["vice"] = true           -- All grades allowed
    },
    Interaction = {
        type = "ox",                     -- "ox", "DrawText", "qb"
        TargetResourceName = 'ox_target' -- 'ox_target' , 'qb-target'
    },
    MiniGame = {
        OnRemoval = true,     -- Enable minigame on wheel removal
        OnInstall = true,     -- Enable minigame on wheel install
        BoltMovements = 0.0008 -- Movement speed of bolts, only increase by small amounts! (example : 0.0015)
    },
    UseProgressbar = true,     -- Use OX progress bar for actions
    ProgressBarDetails = {
        type = 'circle',       -- "circle" or "box"
        duration = 3000,       -- Time in ms
        label = 'Adjusting...',
        position = 'bottom',   -- "middle" or "bottom"
        useWhileDead = false,
        canCancel = false,
        anim = {
            dict = 'amb@prop_human_movie_bulb@idle_a',
            clip = 'idle_b'
        },
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
            sprint = true
        }
    }
}

-- If a addon vehicle has a Long model name, Use this to make sure stancer knows the actual display name.
Config.AddonDisplayNames = { -- [`Vehicle Name`] = 'Vehicle Name'
    [`rrdominators197`] = 'rrdominators197'
}

--[[
    =======================
    Set Limit to Menu Settings
    =======================
]]


Config.Limits = { -- the key values beside global can be either vehicle class number, or vehicle model itself for more info on vehicle class : https://docs.fivem.net/natives/?_0x29439776AAA00A62
    Suspension = {
        Global = {
            max = 0.05,
            min = -0.05
        }
    },
    WheelSize = {
        Global = {
            max = 1.5,
            min = 0.5
        }
    },
    WheelWidth = {
        Global = {
            max = 1.5,
            min = 0.5
        }
    },
    -- Min and maximums of rightsides and leftsides should be exact opposite of each other. otherwise [All Wheels] will break.
    WheelxRotationRight = { -- X rotoation for wheels on the right side of the vehicle
        Global = {
            max = 0.8,
            min = -0.5
        }
    },
    WheelxRotationLeft = { -- X rotoation for wheels on the left side of the vehicle
        Global = {
            max = 0.5,
            min = -0.8
        }
    },
    WheelyRotationRight = { -- Y rotoation for wheels on the right side of the vehicle
        Global = {
            max = 0.15,
            min = -0.1
        }
    },
    WheelyRotationLeft = { -- Y rotoation for wheels on the left side of the vehicle
        Global = {
            max = 0.1,
            min = -0.15
        }
    }
}


-------------------------------
------- BLACKLIST Vehicles!
-------------------------------



Config.BlacklistedVehicles = { -- Blacklist Vehicle by Name.
    [`adder`] = true,
}

Config.BlackListedVehicleClass = { -- Blacklist by Vehicle Class, uncomment (remove --) any class to blacklist it from doing stances!
    --[1] = true, -- Sedans
    --[0] = true, -- Compacts
    --[2] = true, -- SUVs
    --[3] = true, -- Coupes
    --[5] = true, -- Sports Classics
    --[4] = true, -- Muscle
    --[6] = true, -- Sports
    --[7] = true, -- Super
    [8] = true,  -- Motorcycles
    --[9] = true, -- Off-road
    --[10] = true, -- Industrial
    --[11] = true, -- Utility
    --[12] = true, -- Vans
    [13] = true, -- Cycles
    [14] = true, -- Boats
    [15] = true, -- Helicopters
    [16] = true, -- Planes
    --[17] = true, -- Service
    [18] = true, -- Emergency
    --[19] = true, -- Military
    --[20] = true, -- Commercial
    [21] = true, -- Trains
    [22] = true, -- Open Wheel
}


--[[
    =======================
    Webhooks Settings
    =======================
]]

Config.EnableWebhooks  = false -- true/false
Config.WebhooksOptions = {
    SendOptions      = {
        OnRemoval      = true,
        RemoveColor    = 'red',
        OnAppliance    = true,
        ApplianceColor = 'green'
    },
    TagEveryone      = false,
    IncludeAdminJobs = true,
    Details          = {
        TargetPlate      = true,
        PlayerName       = true,
        PlayerJob        = true, -- Player Job
        PlayerId         = true, -- Player Server ID
        PlayerIdentifier = true, -- Player Identifier
        PlayerMoney      = false
    }
}
-- Note: To add WebhookURL you need to open sv_webhook.lua file add it there !
Config.Webhooks        = {
    HeaderImageURL = 'YOUR_IMAGE_LINK',      -- If you Want Image Header For The Logs insert The URL
    LogHeader      = 'Wheel Stancer', -- What Will be the Header Of Your logs
    WebhookTitle   = 'Wheel Stancer Log:'
}


--[[
    =======================
    Framework Settings
    =======================
]]

-- ### IF YOU KNOW WHAT YOU ARE DOING YOU CAN CHANGE THIS ###

Config.PlayerSpawnEvents = {
    'esx:playerLoaded',
    'playerSpawned',
    'QBCore:Client:OnPlayerLoaded'
}

if Config.Framework == "auto" then
    if GetResourceState("es_extended") == "started" then
        Config.Framework = "esx"
    elseif GetResourceState("qb-core") == "started" or GetResourceState("qbx_core") == "started" then
        Config.Framework = "qb"
    else
        Config.Framework = 'standalone'
    end
end

Config.FrameworkSharedObject = nil

Config.FrameworkSharedObjects = {
    ['qb'] = function()
        if Config.FrameworkSharedObject == nil then
            Config.FrameworkSharedObject = exports['qb-core']:GetCoreObject()
        end
        return Config.FrameworkSharedObject
    end,
    ['esx'] = function()
        if Config.FrameworkSharedObject == nil then
            Config.FrameworkSharedObject = exports['es_extended']:getSharedObject()
        end

        return Config.FrameworkSharedObject
    end,
    ['old_esx'] = function()
        if Config.FrameworkSharedObject == nil then
            local ESX = nil

            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
                Citizen.Wait(30)
            end

            Config.FrameworkSharedObject = ESX
        end

        return Config.FrameworkSharedObject
    end
}



NormalizePlate = function(plate)
    if plate == nil then return "" end
    plate = tostring(plate)
    plate = plate:gsub("^%s*(.-)%s*$", "%1")
    return plate
end
