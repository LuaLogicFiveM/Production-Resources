-- ████████╗██╗   ██╗███╗   ██╗██╗███╗   ██╗ ██████╗     ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ╚══██╔══╝██║   ██║████╗  ██║██║████╗  ██║██╔════╝     ████╗ ████║██╔════╝████╗  ██║██║   ██║
--    ██║   ██║   ██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
--    ██║   ██║   ██║██║╚██╗██║██║██║╚██╗██║██║   ██║    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
--    ██║   ╚██████╔╝██║ ╚████║██║██║ ╚████║╚██████╔╝    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
--    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
Config.TuningMenu = {
    ["mainmenu"] = {
        label = "Tuning Menu",
        onReturnOpen = nil, -- don't change it
        options = {
            {label = "Visual Upgrades", icon = "visual.webp", selectOpen = 'visual'},
            {label = "Mechanical Upgrades", icon = "mechanical.webp", selectOpen = 'mechanical'},
            {label = "Locator", icon = "locator.webp", modType = 'locator', tax = 'tuning', priceMultiplier = 0.08},
            {label = "Clean Vehicle", icon = "clean.webp", action = 'clean', tax = 'tuning', price = 500},
            {label = "Repair Vehicle", icon = "repair.webp", action = 'repair', tax = 'tuning', price = 2000},
        },
    },

    ["visual"] = {
        label = "Visual Upgrades",
        onReturnOpen = 'mainmenu',
        options = {
            {label = 'Body', icon = 'body.webp', selectOpen = 'body'},
            {label = 'Inside', icon = 'inside.webp', selectOpen = 'inside'},
            {label = 'Paint', icon = 'paint.webp', selectOpen = 'paint'},
            {label = 'Wheels', icon = 'wheels.webp', selectOpen = 'wheels'},
            {label = 'License Plate', icon = 'licenseplate.webp', selectOpen = 'licenseplate'},
            {label = 'Xenon', icon = 'xenon.webp', selectOpen = 'xenon'},
            {label = 'Neons', icon = 'neons.webp', modType = 'neonColor', type = 'colorpicker', tax = 'tuning', price = 10000},
            {label = 'Vehicle Livery', icon = 'wrap.webp', modType = 'modLivery', tax = 'tuning', priceMultiplier = 0.08},
            {label = 'Window Tint', icon = 'windowtint.webp', modType = 'windowTint', cameraOnBone = 'window_lf', tax = 'tuning', priceMultiplier = 0.08},
            {label = 'Horn', icon = 'horn.webp', modType = 14, tax = 'tuning', priceMultiplier = 0.05},
            {label = 'Extras', icon = 'extra.webp', modType = 'extras'}
        }
    },
    ["body"] = {
        label = "Body",
        onReturnOpen = 'visual',
        options = {
            {label = 'Spoilers', icon = 'spoiler.webp', modType = 0, tax = 'tuning', priceMultiplier = 0.5, cameraPointDirection = 'rear', cameraPointOffset = vec(0.0, 0.5, 0.5), cameraDirection = 'rear-left', cameraOffset = vec(0.3, -1.65, 1.3)},
            {label = 'Front Bumper', icon = 'front-bumper.webp', modType = 1, tax = 'tuning', priceMultiplier = 0.2, cameraPointDirection = 'front', cameraPointOffset = vec(0.0, -0.5, 0.2), cameraDirection = 'front-right', cameraOffset = vec(0.3, 1.65, 0.5)},
            {label = 'Rear Bumper', icon = 'rear-bumper.webp', modType = 2, tax = 'tuning', priceMultiplier = 0.22, cameraPointDirection = 'rear', cameraPointOffset = vec(0.0, 0.5, 0.2), cameraDirection = 'rear-left', cameraOffset = vec(0.3, -1.65, 0.5)},
            {label = 'Side Skirts', icon = 'side-skirts.webp', modType = 3, tax = 'tuning', priceMultiplier = 0.18, cameraOnBone = 'door_dside_f', cameraOffset = {-2.0, 2.25, 0.2}},
            {label = 'Exhaust', icon = 'exhaust.webp', modType = 4, tax = 'tuning', priceMultiplier = 0.19, cameraOnBone = 'exhaust', cameraOffset = {-1.55, -3.25, 0.2}},
            {label = 'Cage', icon = 'cage.webp', modType = 5, tax = 'tuning', priceMultiplier = 0.12, cameraOnBone = 'window_lf', cameraOffset = {-0.25, 3.5, 1.3}},
            {label = 'Grille', icon = 'grill.webp', modType = 6, tax = 'tuning', priceMultiplier = 0.1, cameraOnBone = 'bumper_f', cameraOffset = {0.25, 4.0, 0.65}},
            {label = 'Hood', icon = 'hood.webp', modType = 7, tax = 'tuning', priceMultiplier = 0.15, cameraOnBone = 'bonnet', cameraOffset = {-0.75, 4.0, 1.25}},
            {label = 'Left Fender', icon = 'left-fender.webp', modType = 8, tax = 'tuning', priceMultiplier = 0.07},
            {label = 'Right Fender', icon = 'right-fender.webp', modType = 9, tax = 'tuning', priceMultiplier = 0.08},
            {label = 'Roof', icon = 'roof.webp', modType = 10, tax = 'tuning', priceMultiplier = 0.12, cameraPointDirection = 'front', cameraPointOffset = vec(0.0, -0.85, 1.0), cameraDirection = 'front-right', cameraOffset = vec(0.9, 1.65, 1.65)},
            {label = 'TrimA', icon = 'other.webp', modType = 27, tax = 'tuning', priceMultiplier = 0.08},
            {label = 'APlate', icon = 'other.webp', modType = 35, tax = 'tuning', priceMultiplier = 0.08},
            {label = 'Speakers', icon = 'speakers.webp', modType = 36, tax = 'tuning', priceMultiplier = 0.09},
            {label = 'Trunk', icon = 'trunk.webp', modType = 37, tax = 'tuning', priceMultiplier = 0.07, openDoors = {5}, cameraOnBone = 'bumper_r', cameraOffset = {-0.85, -2.95, 0.785}},
            {label = 'Hydrolic', icon = 'hydrolic.webp', modType = 38, tax = 'tuning', priceMultiplier = 0.05, openDoors = {5}, cameraOnBone = 'bumper_r', cameraOffset = {-0.85, -2.95, 0.785}},
            {label = 'Engine Block', icon = 'engine.webp', modType = 39, tax = 'tuning', priceMultiplier = 0.1, openDoors = {4}, cameraOnBone = 'engine', cameraOffset = {0.15, 1.35, 0.785}},
            {label = 'Air Filter', icon = 'air_filter.webp', modType = 40, tax = 'tuning', priceMultiplier = 0.09, openDoors = {4}, cameraOnBone = 'engine', cameraOffset = {0.15, 1.35, 0.785}},
            {label = 'Struts', icon = 'other.webp', modType = 41, tax = 'tuning', priceMultiplier = 0.08, openDoors = {4}, cameraOnBone = 'engine', cameraOffset = {0.15, 1.35, 0.785}},
            {label = 'Arch Cover', icon = 'other.webp', modType = 42, tax = 'tuning', priceMultiplier = 0.07},
            {label = 'Aerials', icon = 'aerials.webp', modType = 43, tax = 'tuning', priceMultiplier = 0.06, cameraOnBone = 'bumper_r', cameraOffset = {-2.0, -3.25, 0.65}},
            {label = 'Wings', icon = 'other.webp', modType = 44, tax = 'tuning', priceMultiplier = 0.08},
            {label = 'Tank', icon = 'other.webp', modType = 45, tax = 'tuning', priceMultiplier = 0.06},
            {label = 'Windows', icon = 'windows.webp', modType = 46, tax = 'tuning', priceMultiplier = 0.05},
        }
    },
    ["inside"] = {
        title = 'INSIDE',
        onReturnOpen = 'visual',
        options = {
            {label = 'Ornaments', modType = 28, tax = 'tuning', priceMultiplier = 0.075, cameraOnBone = 'engine', cameraOffset = {0.15, -1.85, 0.485}},
            {label = 'Dashboard', modType = 29, tax = 'tuning', priceMultiplier = 0.095, cameraOnBone = 'engine', cameraOffset = {0.15, -1.85, 0.485}},
            {label = 'Dial', modType = 30, tax = 'tuning', priceMultiplier = 0.05, cameraOnBone = 'engine', cameraOffset = {-0.55, -1.5, 0.485}},
            {label = 'Door Speaker', modType = 31, tax = 'tuning', priceMultiplier = 0.065, openDoors = {0}, cameraOnBone = 'door_dside_f', cameraOffset = {-0.35, -3.5, 1.3}},
            {label = 'Seat', modType = 32, tax = 'tuning', priceMultiplier = 0.035},
            {label = 'Steering Wheel', modType = 33, tax = 'tuning', priceMultiplier = 0.019, cameraOnBone = 'engine', cameraOffset = {-0.55, -1.5, 0.265}},
            {label = 'Shifter Leaver', modType = 34, tax = 'tuning', priceMultiplier = 0.021, cameraOnBone = 'engine', cameraOffset = {0.15, -1.85, 0.485}},
        },
    },
    ["paint"] = {
        label = 'Paint',
        onReturnOpen = 'visual',
        options = {
            {label = 'Primary Color', icon = 'paint.webp', selectOpen = 'color1'},
            {label = 'Secondary Color', icon = 'paint.webp', selectOpen = 'color2'},
            {label = 'Primary Color Type', icon = 'paint.webp', modType = 'paintTypePrimary', tax = 'tuning', priceMultiplier = 0.12},
            {label = 'Secondary Color Type', icon = 'paint.webp', modType = 'paintTypeSecondary', tax = 'tuning', priceMultiplier = 0.1},
            {label = 'Pearlescent', icon = 'paint.webp', modType = 'pearlescentColor', type = "indexes"},
            {label = 'Dashboard', icon = 'paint.webp', modType = 'dashboardColor', type = "indexes"},
            {label = 'Interior', icon = 'paint.webp', modType = 'interiorColor', type = "indexes"},
        },
    },
    ["wheels"] = {
        label = 'Wheels',
        onReturnOpen = 'visual',
        options = {
            {label = 'Wheels Type', icon = 'wheel_sports.webp', selectOpen = 'wheels_type'},
            {label = 'Wheels Color', icon = 'paint.webp', modType = 'wheelColor', type = 'indexes', tax = 'tuning', priceMultiplier = 0.16},
            {label = 'Smoke Color', icon = 'wheel_smoke.webp', modType = 'tyreSmokeColor', type = 'colorpicker', tax = 'tuning', price = 5000},
            {label = 'Wheels Stance', icon = 'wheels_stance.webp', modType = 'wheelsStance', type = 'wheelsstance', tax = 'tuning', price = 25000, dependence = Config.UseStanceSystem},
            {label = 'Wheels Size', icon = 'wheels_size.webp', modType = 'wheelSize', type = 'wheelsize', tax = 'tuning', price = 25000, dependence = Config.UseWheelsSize},
            {label = 'Wheels Width', icon = 'wheels_width.webp', modType = 'wheelWidth', type = 'wheelwidth', tax = 'tuning', price = 25000, dependence = Config.UseWheelsWidth},
            {label = 'Drift Tires', icon = 'drift_tyres.webp', modType = 'driftTyres', tax = 'tuning', priceMultiplier = {0.25}},
        },
    },
    ['wheels_type'] = {
        label = 'Wheels Type',
        onReturnOpen = 'wheels',
        options = {
            {label = "Sports", icon = 'wheel_sports.webp', modType = 23, wheelType = 0, tax = 'tuning', priceMultiplier = 0.2, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Muscle", icon = 'wheel_muscle.webp', modType = 23, wheelType = 1, tax = 'tuning', priceMultiplier = 0.12, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Lowrider", icon = 'wheel_lowrider.webp', modType = 23, wheelType = 2, tax = 'tuning', priceMultiplier = 0.22, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "SUV", icon = 'wheel_suv.webp', modType = 23, wheelType = 3, tax = 'tuning', priceMultiplier = 0.14, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Off Road", icon = 'wheel_offroad.webp', modType = 23, wheelType = 4, tax = 'tuning', priceMultiplier = 0.1, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Tuning", icon = 'wheel_tuning.webp', modType = 23, wheelType = 5, tax = 'tuning', priceMultiplier = 0.14, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Motorcycle", icon = 'wheel_motorcycle.webp', modType = 23, wheelType = 6, tax = 'tuning', priceMultiplier = 0.1, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "High End", icon = 'wheel_highend.webp', modType = 23, wheelType = 7, tax = 'tuning', priceMultiplier = 0.2, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Bennys Originals", icon = 'wheel_orginals.webp', modType = 23, wheelType = 8, tax = 'tuning', priceMultiplier = 0.2, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Bennys Bespoke", icon = 'wheel_bespoke.webp', modType = 23, wheelType = 9, tax = 'tuning', priceMultiplier = 0.2, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Street", icon = 'wheel_street.webp', modType = 23, wheelType = 11, tax = 'tuning', priceMultiplier = 0.2, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
            {label = "Track", icon = 'wheel_track.webp', modType = 23, wheelType = 12, tax = 'tuning', priceMultiplier = 0.2, cameraOnBone = 'wheel_lf', cameraOffset = {-1.0, 0.75, 0.25}},
        },
    },
    ["licenseplate"] = {
        label = "License Plate",
        onReturnOpen = 'visual',
        options = {
            {label = 'Change Numbers', modType = 'customPlateNumbers', type = 'customlicenseplate', tax = 'tuning', price = 120000},
            {label = 'Type', modType = 25, tax = 'tuning', priceMultiplier = 0.02, cameraPointDirection = 'rear', cameraPointOffset = vec(0.0, 0.3, 0.2), cameraDirection = 'rear-left', cameraOffset = vec(0.2, -1.45, 0.2)},
            {label = 'Color', modType = 'plateIndex', tax = 'tuning', priceMultiplier = 0.01, cameraPointDirection = 'rear', cameraPointOffset = vec(0.0, 0.3, 0.2), cameraDirection = 'rear-left', cameraOffset = vec(0.2, -1.45, 0.2)},
            {label = 'Holder', modType = 26, tax = 'tuning', priceMultiplier = 0.08, cameraPointDirection = 'front', cameraPointOffset = vec(0.0, -0.3, 0.2), cameraDirection = 'front-right', cameraOffset = vec(-0.2, 1.45, 0.2)},
        }
    },
    ["xenon"] = {
        label = "Xenon",
        onReturnOpen = 'visual',
        options = {
            {label = 'Xenon', img = 'xenon.webp', modType = 22, tax = 'tuning', priceMultiplier = {0.2}, cameraOnBone = 'bumper_f', cameraOffset = {-2.6, 4.0, 0.65}},
            {label = 'Indexed', icon = 'colors-indexed.webp', modType = 'xenonColor', tax = 'tuning', priceMultiplier = 0.02, cameraOnBone = 'bumper_f', cameraOffset = {-2.6, 4.0, 0.65}},
            -- {label = 'RGB', icon = 'colors-rgb.webp', modType = 'xenonColor', type = 'colorpicker', tax = 'tuning', price = 10000, cameraOnBone = 'bumper_f', cameraOffset = {-2.6, 4.0, 0.65}}, -- RGB Xenons are not synchronized on the server between players
        }
    },

    ["color1"] = {
        label = "Primary Color",
        onReturnOpen = 'paint',
        options = {
            {label = 'Indexed', icon = 'colors-indexed.webp', modType = 'color1', type = "indexes"},
            {label = 'RGB', icon = 'colors-rgb.webp', modType = 'color1', type = 'colorpicker', tax = 'tuning', price = 10000},
        }
    },
    ["color2"] = {
        label = "Secondary Color",
        onReturnOpen = 'paint',
        options = {
            {label = 'Indexed', icon = 'colors-indexed.webp', modType = 'color2', type = "indexes"},
            {label = 'RGB', icon = 'colors-rgb.webp', modType = 'color2', type = 'colorpicker', tax = 'tuning', price = 10000},
        }
    },
    ["mechanical"] = {
        label = "Mechanical Upgrades",
        onReturnOpen = 'mainmenu',
        options = {
            {label = 'Armor', icon = 'armor.webp', modType = 16, tax = 'tuning', priceMultiplier = {0.05, 0.1, 0.15, 0.2, 0.25, 0.3}},
            {label = 'Engine', icon = 'engine.webp', modType = 11, tax = 'tuning', priceMultiplier = {0.1, 0.15, 0.2, 0.25, 0.3, 0.35}},
            {label = 'Brakes', icon = 'brakes.webp', modType = 12, tax = 'tuning', priceMultiplier = {0.075, 0.125, 0.175, 0.225, 0.25}},
            {label = 'Transmission', icon = 'transmission.webp', modType = 13, tax = 'tuning', priceMultiplier = {0.08, 0.16, 0.24, 0.32, 0.38}},
            {label = 'Suspension', icon = 'suspension.webp', modType = 15, tax = 'tuning', priceMultiplier = {0.02, 0.04, 0.06, 0.08, 0.1, 0.12}},
            {label = 'Custom Suspension Height', icon = 'suspension.webp', modType = 'suspensionHeight', type = 'suspensionheight', tax = 'tuning', price = 8000, dependence = Config.UseSuspensionHeight},
            {label = 'Turbo', icon = 'turbo.webp', modType = 18, tax = 'tuning', priceMultiplier = {0.45}},
            {label = 'Engine Swap', icon = 'engineswap.webp', modType = 'engineSwap', cameraPointDirection = 'rear', cameraPointOffset = vec(0.0, 0.3, 0.2), cameraDirection = 'rear-left', cameraOffset = vec(0.2, -1.45, 0.2), dependence = Config.UseEngineSwaps},
        }
    },
}


-- ████████╗██╗   ██╗███╗   ██╗██╗███╗   ██╗ ██████╗     ███╗   ███╗ █████╗ ██╗  ██╗    ██╗   ██╗ █████╗ ██╗     ██╗   ██╗███████╗███████╗
-- ╚══██╔══╝██║   ██║████╗  ██║██║████╗  ██║██╔════╝     ████╗ ████║██╔══██╗╚██╗██╔╝    ██║   ██║██╔══██╗██║     ██║   ██║██╔════╝██╔════╝
--    ██║   ██║   ██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗    ██╔████╔██║███████║ ╚███╔╝     ██║   ██║███████║██║     ██║   ██║█████╗  ███████╗
--    ██║   ██║   ██║██║╚██╗██║██║██║╚██╗██║██║   ██║    ██║╚██╔╝██║██╔══██║ ██╔██╗     ╚██╗ ██╔╝██╔══██║██║     ██║   ██║██╔══╝  ╚════██║
--    ██║   ╚██████╔╝██║ ╚████║██║██║ ╚████║╚██████╔╝    ██║ ╚═╝ ██║██║  ██║██╔╝ ██╗     ╚████╔╝ ██║  ██║███████╗╚██████╔╝███████╗███████║
--    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═══╝  ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝
Config.TuningMaxValues = {
    -- [11]: Engine
    -- [12]: Brakes
    -- [13]: Transmission
    -- [15]: Suspension
    -- [16]: Armor
    -- [18]: Turbo

    [joaat('brioso')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [15] = 3 -- Suspension
    },
    --[[[joaat('buffalo5')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('deveste')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 1 -- Suspension
    },
    [joaat('entity3')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('eurosx32')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
    },
    [joaat('hakuchou2')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
    },
    [joaat('issi8')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('stingertt')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('coureur')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('monstrociti')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('niobe')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
    },
    [joaat('feltzer3')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('turismo2')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 0 -- Suspension
    },
    [joaat('vigero2')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('vigero3')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [13] = 3, -- Transmission
        [15] = 4 -- Suspension
    },
    [joaat('vivanite')] = { -- Model available for GTA+, blocked HSW parts
        [11] = 4, -- Engine
        [12] = 3, -- Brakes
        [15] = 4 -- Suspension
    },]]

}


--  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
-- ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
-- ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
-- ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
--  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
Config.ColorsList = {
    {label = 'Black', name = 'black', tax = 'tuning', price = {
        -- primary = 5000, 
        primaryMultiplier = 0.08, 
        -- secondary = 2000, 
        secondaryMultiplier = 0.06, 
        -- pearlescent = 950, 
        pearlescentMultiplier = 0.03, 
        -- dashboard = 1000, 
        dashboardMultiplier = 0.014, 
        -- interior = 1200, 
        interiorMultiplier = 0.01, 
        -- wheel = 2400, 
        wheelMultiplier = 0.025, 
    }},
	{label = 'Grey', name = 'grey', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950, 
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'White', name = 'white', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950, 
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Red', name = 'red', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950, 
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Orange', name = 'orange', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950, 
        dashboard = 1000, 
        interior = 1200, 
        wheel = 2400, 
    }},
	{label = 'Brown', name = 'brown', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950, 
        dashboard = 1000, 
        interior = 1200, 
        wheel = 2400,
    }},
	{label = 'Yellow', name = 'yellow', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Green', name = 'green', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Blue', name = 'blue', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Purple', name = 'purple', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Pink', name = 'pink', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Chameleon', name = 'chameleon', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Chrome', name = 'chrome', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
	{label = 'Gold', name = 'gold', tax = 'tuning', price = {
        primary = 5000, 
        secondary = 2000, 
        pearlescent = 950,
        dashboard = 1000, 
        interior = 1200,
        wheel = 2400,
    }},
}

Config.IndexedColors = {
    ['chameleon'] = {
        {colorIcon = "linear-gradient(45deg, #440404, #8a2929, #e06445, #8a2929, #2c0404)", label = 'Anodized Red', index = 161},
        {colorIcon = "linear-gradient(45deg, #2d162d, #8d1968, #ba2065, #2d162d)", label = 'Anodized Wine', index = 162},
        {colorIcon = "linear-gradient(45deg, #181228, #3e035d, #6e0180, #172654, #190339)", label = 'Anodized Purple', index = 163},
        {colorIcon = "linear-gradient(45deg, #110a55, #1911b9, #2d3ed4, #110a55)", label = 'Anodized Blue', index = 164},
        {colorIcon = "linear-gradient(45deg, #0b3c02, #31b32f, #2dd443, #002e06)", label = 'Anodized Green', index = 165},
        {colorIcon = "linear-gradient(45deg, #1e3c02, #6fb32f, #85c846, #222f12)", label = 'Anodized Lime', index = 166},
        {colorIcon = "linear-gradient(45deg, #3c2802, #b3712f, #c89446, #f3c889, #2f1e12)", label = 'Anodized Copper', index = 167},
        {colorIcon = "linear-gradient(45deg, #3c3502, #b3962f, #c8ac46, #f3e789, #2f2912)", label = 'Anodized Bronze', index = 168},
        {colorIcon = "linear-gradient(45deg, #423b1f, #6e5d37, #786948, #c6bda9, #5e574c, #484220)", label = 'Anodized Champagne', index = 169},
        {colorIcon = "linear-gradient(45deg, #614e01, #7b5f0b, #b49d53, #ddcf9e, #957a3d, #60551b)", label = 'Anodized Gold', index = 170},
        {colorIcon = "linear-gradient(45deg, #275909, #678500, #bcb51d, #5b9445, #2a681b, #08232a)", label = 'Green Blue Flip', index = 171},
        {colorIcon = "linear-gradient(45deg, #281c1d, #393a0e, #658d01, #b7b901, #3b2a2f)", label = 'Green Red Flip', index = 172},
        {colorIcon = "linear-gradient(45deg, #141e2a, #572b4a, #724c30, #746d25, #724c30, #572b4a, #141e2a)", label = 'Green Brown Flip', index = 173},
        {colorIcon = "linear-gradient(45deg, #1b312e, #013701, #066332, #2b63a8, #34304a)", label = 'Green Turqoise Flip', index = 174},
        {colorIcon = "linear-gradient(45deg, #351b48, #334721, #549064, #4d358a, #423d59)", label = 'Green Purple Flip', index = 175},
        {colorIcon = "linear-gradient(45deg, #49355c, #00642e, #00322e, #635398, #3c4557)", label = 'Teal Purple Flip', index = 176},
        {colorIcon = "linear-gradient(45deg, #630222, #17303e, #1e6a45, #026749, #3a153e, #630222)", label = 'Turqoise Red Flip', index = 177},
        {colorIcon = "linear-gradient(45deg, #012222, #17303e, #1e6a45, #026749, #3a153e, #012222)", label = 'Turqoise Purple Flip', index = 178},
        {colorIcon = "linear-gradient(45deg, #150e24, #361f3f, #173f5f, #884da0, #3a153e, #00172b, #0f0a33, #130726)", label = 'Cyan Purple Flip', index = 179},
        {colorIcon = "linear-gradient(45deg, #512a35, #664c6c, #1e2e76, #292e5c, #070637, #7d507a, #482749)", label = 'Blue Pink Flip', index = 180},
        {colorIcon = "linear-gradient(45deg, #0c171a, #13144f, #060d23, #091111, #3a153e, #191f68, #05282a, #240e20)", label = 'Blue Green Flip', index = 181},
        {colorIcon = "linear-gradient(45deg, #180b18, #200073, #2803ba, #39028c, #110260, #280a29)", label = 'Purple Red Flip', index = 182},
        {colorIcon = "linear-gradient(45deg, #0b0e1d, #1e0057, #6e0074, #650241, #18092a, #001e25, #182b2b)", label = 'Purple Green Flip', index = 183},
        {colorIcon = "linear-gradient(45deg, #1e0b0e, #310e26, #594500, #212802, #71001a, #4a1737, #1e050e)", label = 'Magenta Green Flip', index = 184},
        {colorIcon = "linear-gradient(45deg, #1b0c25, #3a1f4c, #555819, #1a040f, #535817, #17000e, #280544, #1f021d)", label = 'Magenta Yellow Flip', index = 185},
        {colorIcon = "linear-gradient(45deg, #1f2412, #215718, #240121, #365330, #3b182b, #250122, #120120, #317d24, #201010)", label = 'Burgundy Green Flip', index = 186},
        {colorIcon = "linear-gradient(45deg, #2b0e27, #382350, #0b526b, #080520, #0c071b, #1a0829)", label = 'Magenta Cyan Flip', index = 187},
        {colorIcon = "linear-gradient(45deg, #1e1614, #23230b, #171315, #160b28, #431358, #32171c, #13091e)", label = 'Copper Purple Flip', index = 188},
        {colorIcon = "linear-gradient(45deg, #1a0b20, #1d061a, #290419, #420f17, #420019, #35002f, #0f092c)", label = 'Magenta Orange Flip', index = 189},
        {colorIcon = "linear-gradient(45deg, #141318, #171515, #db973d, #c9291a, #db973d, #171515, #0d021c)", label = 'Red Orange Flip', index = 190},
        {colorIcon = "linear-gradient(45deg, #2c1c2d, #42060d, #973601, #b96f00, #5d2300, #730004, #35003b, #240143)", label = 'Orange Purple Flip', index = 191},
        {colorIcon = "linear-gradient(45deg, #2b2a33, #3a3a00, #674e02, #7e5200, #705f00, #150b2f, #120427)", label = 'Orange Blue Flip', index = 192},
        {colorIcon = "linear-gradient(45deg, #101222, #261929, #2b2426, #525846, #6f8887, #1e2c48, #38312f, #321256, #0d1d30, #0c2414, #102315)", label = 'White Purple Flip', index = 193},
        {colorIcon = "linear-gradient(45deg, #0c211b, #07083a, #0b053b, #330119, #360009, #00104f, #004720, #002410)", label = 'Red Rainbow Flip', index = 194},
        {colorIcon = "linear-gradient(45deg, #0b0e0c, #1b140c, #0d1f04, #001f19, #090905, #09160b, #06120f)", label = 'Dark Green Pearl', index = 196},
        {colorIcon = "linear-gradient(45deg, #282a30, #111219, #151a1a, #071f17, #052b5e, #08101a, #0d0b19, #100a17)", label = 'Dark Teal Pearl', index = 197},
        {colorIcon = "linear-gradient(45deg, #0c0c1e, #0b081f, #093832, #0c1c59, #050512, #050630, #0e0320)", label = 'Dark Blue Pearl', index = 198},
        {colorIcon = "linear-gradient(45deg, #1c0b1f, #4f165a, #1e304c, #1e5695, #1b1749, #140733, #50005b, #180326)", label = 'Dark Purple Pearl', index = 199},
        {colorIcon = "linear-gradient(45deg, #0c0e14, #081414, #0f0a04, #160907, #19070d, #0c0a19, #0c1015, #0f0706, #0c0105, #050105)", label = 'Oil Slick Pearl', index = 200},
        {colorIcon = "linear-gradient(45deg, #56758e, #97c7f3, #98d9ef, #7695a4, #66a09d, #b2ddff, #6caaa8)", label = 'Light Green Pearl', index = 201},
        {colorIcon = "linear-gradient(45deg, #61829d, #7196b9, #659eb8, #8ba9b5, #71b0b1, #5daec6, #449abb, #a8cae0, #81c5db, #5bb5cf)", label = 'Light Blue Pearl', index = 202},
        {colorIcon = "linear-gradient(45deg, #607b98, #7287b0, #9ea2e2, #8489bc, #839da9, #79a5a1, #888cbd, #836fb2, #97c2d7, #9b97d1)", label = 'Light Purple Pearl', index = 203},
        {colorIcon = "linear-gradient(45deg, #6f88a3, #9d99b7, #a09dba, #9baec0, #8ab6b1, #a58aa8, #9fb1bf, #a7cee1, #aea2bf)", label = 'Light Pink Pearl', index = 204},
        {colorIcon = "linear-gradient(45deg, #506b7d, #83938f, #7e9c93, #82976b, #976c65, #88577f, #825dab, #567ec0, #3fa1bf, #61b3bc, #aec4c6, #a8b2bb)", label = 'Off White Pearl', index = 205},
        {colorIcon = "linear-gradient(45deg, #3f3b6e, #82568f, #84748b, #943c67, #8a3898, #6251c0, #497ac4, #5683c0, #a393bf, #af99c7, #9d78af)", label = 'Pink Pearl', index = 206},
        {colorIcon = "linear-gradient(45deg, #7e7065, #877f6c, #808d5f, #89773d, #914f4e, #8a4b68, #78598b, #4d7c94, #4a988f, #90a889, #b1b59a, #a9a08d)", label = 'Yellow Pearl', index = 207},
        {colorIcon = "linear-gradient(45deg, #4f8a8a, #5b9291, #539b79, #598b59, #6e615d, #5f5883, #4971b6, #248fbb, #26acb7, #59b4ac, #7cc5be, #76afb0)", label = 'Green Pearl', index = 208},
        {colorIcon = "linear-gradient(45deg, #526e95, #578095, #587d7c, #6b5a65, #6a4869, #61427d, #5b48ad, #3b62c2, #2877c4, #43bfff, #78a1c1, #7a92bc)", label = 'Blue Pearl', index = 209},
        {colorIcon = "linear-gradient(45deg, #797967, #86806d, #7f8f64, #828645, #8e703f, #934f4a, #894e7a, #71608f, #478195, #529b8f, #94aa8b, #b2b1a1)", label = 'Cream Pearl', index = 210},
        {colorIcon = "linear-gradient(45deg, #606681, #606681, #879dc6, #5e75cf, #2e75cb, #2894b6, #1a95ba, #00a682, #30af48, #928d34, #9f4a57, #505279, #9fb4c5, #9cb0bd, #9cb0bd)", label = 'White Prismatic', index = 211},
        {colorIcon = "linear-gradient(45deg, #3c4661, #3c4661, #4f6390, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #5f727e, #343944, #343944)", label = 'Graphite Prismatic', index = 212},
        {colorIcon = "linear-gradient(45deg, #171e30, #171e30, #132d65, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #1f1d45, #001023, #001023)", label = 'Dark Blue Prismatic', index = 213},
        {colorIcon = "linear-gradient(45deg, #1c163b, #1c163b, #222073, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #381256, #120527, #120527)", label = 'Dark Purple Prismatic', index = 214},
        {colorIcon = "linear-gradient(45deg, #721e6a, #721e6a, #b214cc, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #a30084, #7b0161, #7b0161)", label = 'Hot Pink Prismatic', index = 215},
        {colorIcon = "linear-gradient(45deg, #3e0812, #3e0812, #8a1128, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #ae0000, #550000, #550000)", label = 'Dark Red Prismatic', index = 216},
        {colorIcon = "linear-gradient(45deg, #172c1b, #172c1b, #09642e, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #2f6311, #012c01, #012c01)", label = 'Dark Green Prismatic', index = 217},
        {colorIcon = "linear-gradient(45deg, #000000, #000000, #0f131e, #4458a1, #2e75cb, #34c6f7, #1a95ba, #00a682, #4aac33, #928d34, #9f4a57, #505279, #080811, #050505, #050505)", label = 'Black Prismatic', index = 218},
        {colorIcon = "linear-gradient(45deg, #000000, #000000, #5c2526, #136048, #4e521d, #154b58, #0f265a, #000000, #000000)", label = 'Black Oil Spill', index = 219},
        {colorIcon = "linear-gradient(45deg, #000000, #000000, #5a9300, #2c2a98, #510064, #20398c, #35863d, #444357, #000000, #000000)", label = 'Black Rainbow', index = 220},
        {colorIcon = "linear-gradient(45deg, #000000, #469f69, #91505c, #374a9a, #35a3c8, #6cca96, #eeff96, #a66380, #1e1e37, #000000, #000000)", label = 'Black Holographic', index = 221},
        {colorIcon = "linear-gradient(45deg, #a17e95, #469f69, #91505c, #374a9a, #35a3c8, #6cca96, #eeff96, #a66380, #1e1e37, #a17e95, #a17e95)", label = 'White Holographic', index = 222},
    },
	['black'] = {
		{colorIcon = "#0d1116", label = 'Metallic Black', index = 0},
		{colorIcon = "#1c1d21", label = 'Metallic Graphite Black', index = 1},
		{colorIcon = "#32383d", label = 'Metallic Black Steal', index = 2},
		{colorIcon = "#454b4f", label = 'Metallic Dark Silver', index = 3},
		{colorIcon = "#1d2129", label = 'Metallic Anthracite Grey', index = 11},
		{colorIcon = "#13181f", label = 'Matte Black', index = 12},
		{colorIcon = "#151921", label = 'Util Black', index = 15},
		{colorIcon = "#1e2429", label = 'Util Black Poly', index = 16},
		{colorIcon = "#1e232f", label = 'Worn Black', index = 21},
		{colorIcon = "#11141a", label = 'Carbon', index = 147},
	},
	['white'] = {
		{colorIcon = "#dfd5b2", label = 'Metallic Sun Bleeched Sand', index = 106},
		{colorIcon = "#f7edd5", label = 'Metallic Cream', index = 107},
		{colorIcon = "#fffff6", label = 'Metallic White', index = 111},
		{colorIcon = "#eaeaea", label = 'Metallic Frost White', index = 112},
		{colorIcon = "#b0ab94", label = 'Worn Honey Beige', index = 113},
		{colorIcon = "#eae6de", label = 'Worn Off White', index = 121},
		{colorIcon = "#dfddd0", label = 'Util Off White', index = 122},
		{colorIcon = "#fcf9f1", label = 'Matte White', index = 131},
		{colorIcon = "#fffffb", label = 'Worn White', index = 132},
		{colorIcon = "#ffffff", label = 'Pure White', index = 134}
	},
	['grey'] = {
		{colorIcon = "#999da0", label = 'Metallic Silver', index = 4},
		{colorIcon = "#c2c4c6", label = 'Metallic Blue Silver', index = 5},
		{colorIcon = "#979a97", label = 'Metallic Steel Gray', index = 6},
		{colorIcon = "#637380", label = 'Metallic Shadow Silver', index = 7},
		{colorIcon = "#63625c", label = 'Metallic Stone Silver', index = 8},
		{colorIcon = "#3c3f47", label = 'Metallic Midnight Silver', index = 9},
		{colorIcon = "#444e54", label = 'Metallic Gun Metal', index = 10},
		{colorIcon = "#26282a", label = 'Matte Gray', index = 13},
		{colorIcon = "#515554", label = 'Matte Light Grey', index = 14},
		{colorIcon = "#333a3c", label = 'Util Dark Silver', index = 17},
		{colorIcon = "#8c9095", label = 'Util Silver', index = 18},
		{colorIcon = "#39434d", label = 'Util Gun Metal', index = 19},
		{colorIcon = "#506272", label = 'Util Shadow Silver', index = 20},
		{colorIcon = "#363a3f", label = 'Worn Graphite', index = 22},
		{colorIcon = "#a0a199", label = 'Worn Silver Grey', index = 23},
		{colorIcon = "#d3d3d3", label = 'Worn Silver', index = 24},
		{colorIcon = "#b7bfca", label = 'Worn Blue Silver', index = 25},
		{colorIcon = "#778794", label = 'Worn Shadow Silver', index = 26},
		{colorIcon = "#394762", label = 'Metallic Harbor Blue', index = 66},
		{colorIcon = "#9b8c78", label = 'Metallic Champagne', index = 93},
		{colorIcon = "#9f9e8a", label = 'Hunter Green', index = 144},
		{colorIcon = "#81827f", label = 'Alloy', index = 156}
	},
	['red'] = {
		{colorIcon = "#c00e1a", label = 'Metallic Red', index = 27},
		{colorIcon = "#da1918", label = 'Metallic Torino Red', index = 28},
		{colorIcon = "#b6111b", label = 'Metallic Formula Red', index = 29},
		{colorIcon = "#a51e23", label = 'Metallic Blaze Red', index = 30},
		{colorIcon = "#7b1a22", label = 'Metallic Graceful Red', index = 31},
		{colorIcon = "#8e1b1f", label = 'Metallic Garnet Red', index = 32},
		{colorIcon = "#6f1818", label = 'Metallic Desert Red', index = 33},
		{colorIcon = "#49111d", label = 'Metallic Cabernet Red', index = 34},
		{colorIcon = "#b60f25", label = 'Metallic Candy Red', index = 35},
		{colorIcon = "#cf1f21", label = 'Matte Red', index = 39},
		{colorIcon = "#732021", label = 'Matte Dark Red', index = 40},
		{colorIcon = "#9c1016", label = 'Util Red', index = 43},
		{colorIcon = "#de0f18", label = 'Util Bright Red', index = 44},
		{colorIcon = "#a94744", label = 'Worn Red', index = 46},
		{colorIcon = "#0e0d14", label = 'Metallic Black Red', index = 143},
		{colorIcon = "#bc1917", label = 'Metallic Lava Red', index = 150}
	},
	['pink'] = {
		{colorIcon = "#f21f99", label = 'Hot Pink', index = 135},
		{colorIcon = "#fdd6cd", label = 'Salmon pink', index = 136},
		{colorIcon = "#df5891", label = 'Metallic Vermillion Pink', index = 137}
	},
	['blue'] = {
		{colorIcon = "#1b6770", label = 'Metallic Gasoline Blue Green', index = 54},
		{colorIcon = "#65867f", label = 'Worn Sea Wash', index = 60},
		{colorIcon = "#222e46", label = 'Metallic Midnight Blue', index = 61},
		{colorIcon = "#233155", label = 'Metallic Dark Blue', index = 62},
		{colorIcon = "#304c7e", label = 'Metallic Saxony Blue', index = 63},
		{colorIcon = "#47578f", label = 'Metallic Blue', index = 64},
		{colorIcon = "#637ba7", label = 'Metallic Mariner Blue', index = 65},
		{colorIcon = "#d6e7f1", label = 'Metallic Diamond Blue', index = 67},
		{colorIcon = "#76afbe", label = 'Metallic Surf Blue', index = 68},
		{colorIcon = "#345e72", label = 'Metallic Nautical Blue', index = 69},
		{colorIcon = "#0b9cf1", label = 'Metallic Bright Blue', index = 70},
		{colorIcon = "#2354a1", label = 'Metallic Ultra Blue', index = 73},
		{colorIcon = "#6ea3c6", label = 'Metallic Bright Blue', index = 74},
		{colorIcon = "#112552", label = 'Util Dark Blue', index = 75},
		{colorIcon = "#275190", label = 'Util Blue', index = 77},
		{colorIcon = "#608592", label = 'Util Sea Foam Blue', index = 78},
		{colorIcon = "#2446a8", label = 'Util Lightning blue', index = 79},
		{colorIcon = "#4271e1", label = 'Util Maui Blue Poly', index = 80},
		{colorIcon = "#1f2852", label = 'Matte Dark Blue', index = 82},
		{colorIcon = "#253aa7", label = 'Matte Blue', index = 83},
		{colorIcon = "#1c3551", label = 'Matte Midnight Blue', index = 84},
		{colorIcon = "#4c5f81", label = 'Worn Dark blue', index = 85},
		{colorIcon = "#58688e", label = 'Worn Blue', index = 86},
		{colorIcon = "#74b5d8", label = 'Worn Light blue', index = 87},
		{colorIcon = "#4cc3da", label = 'police car blue', index = 127},
		{colorIcon = "#08e9fa", label = 'Blue', index = 140},
		{colorIcon = "#0a0c17", label = 'Mettalic Black Blue', index = 141},
		{colorIcon = "#0b1421", label = 'Metaillic V Dark Blue', index = 146},
		{colorIcon = "#afd6e4", label = 'Epsilon Blue', index = 157}
	},
	['yellow'] = {
		{colorIcon = "#ffc91f", label = 'Matte Yellow', index = 42},
		{colorIcon = "#ffcf20", label = 'Metallic Taxi Yellow', index = 88},
		{colorIcon = "#fbe212", label = 'Metallic Race Yellow', index = 89},
		{colorIcon = "#e0e13d", label = 'Metallic Yellow Bird', index = 91},
		{colorIcon = "#f1cc40", label = 'Worn Taxi Yellow', index = 126}
	},
	['green'] = {
		{colorIcon = "#132428", label = 'Metallic Dark Green', index = 49},
		{colorIcon = "#122e2b", label = 'Metallic Racing Green', index = 50},
		{colorIcon = "#12383c", label = 'Metallic Sea Green', index = 51},
		{colorIcon = "#31423f", label = 'Metallic Olive Green', index = 52},
		{colorIcon = "#155c2d", label = 'Metallic Green', index = 53},
		{colorIcon = "#66b81f", label = 'Matte Lime Green', index = 55},
		{colorIcon = "#22383e", label = 'Util Dark Green', index = 56},
		{colorIcon = "#1d5a3f", label = 'Util Green', index = 57},
		{colorIcon = "#2d423f", label = 'Worn Dark Green', index = 58},
		{colorIcon = "#45594b", label = 'Worn Green', index = 59},
		{colorIcon = "#98d223", label = 'Metallic Lime', index = 92},
		{colorIcon = "#83c566", label = 'Metallic Securicor Green', index = 125},
		{colorIcon = "#4e6443", label = 'Matte Green', index = 128},
		{colorIcon = "#81844c", label = 'Worn Olive Army Green', index = 133},
		{colorIcon = "#b0ee6e", label = 'Green', index = 139},
		{colorIcon = "#2d362a", label = 'Matte Forest Green', index = 151},
		{colorIcon = "#696748", label = 'Matte Olive Drab', index = 152},
		{colorIcon = "#5a6352", label = 'Matte Foilage Green', index = 155}
	},
	['orange'] = {
		{colorIcon = "#d44a17", label = 'Metallic Sunrise Orange', index = 36},
		{colorIcon = "#f78616", label = 'Metallic Orange', index = 38},
		{colorIcon = "#f27d20", label = 'Matte Orange', index = 41},
		{colorIcon = "#f2ad2e", label = 'Worn Orange', index = 123},
		{colorIcon = "#f9a458", label = 'Worn Light Orange', index = 124},
		{colorIcon = "#f8b658", label = 'Worn Orange', index = 130},
		{colorIcon = "#f6ae20", label = 'Orange', index = 138}
	},
	['brown'] = {
		{colorIcon = "#8f1e17", label = 'Util Garnet Red', index = 45},
		{colorIcon = "#b16c51", label = 'Worn Golden Red', index = 47},
		{colorIcon = "#371c25", label = 'Worn Dark Red', index = 48},
		{colorIcon = "#916532", label = 'Metallic Bronze', index = 90},
		{colorIcon = "#503218", label = 'Metallic Pueblo Beige', index = 94},
		{colorIcon = "#473f2b", label = 'Metallic Dark Ivory', index = 95},
		{colorIcon = "#221b19", label = 'Metallic Choco Brown', index = 96},
		{colorIcon = "#653f23", label = 'Metallic Golden Brown', index = 97},
		{colorIcon = "#775c3e", label = 'Metallic Light Brown', index = 98},
		{colorIcon = "#ac9975", label = 'Metallic Straw Beige', index = 99},
		{colorIcon = "#6c6b4b", label = 'Metallic Moss Brown', index = 100},
		{colorIcon = "#402e2b", label = 'Metallic Biston Brown', index = 101},
		{colorIcon = "#a4965f", label = 'Metallic Beechwood', index = 102},
		{colorIcon = "#46231a", label = 'Metallic Dark Beechwood', index = 103},
		{colorIcon = "#752b19", label = 'Metallic Choco Orange', index = 104},
		{colorIcon = "#bfae7b", label = 'Metallic Beach Sand', index = 105},
		{colorIcon = "#3a2a1b", label = 'Util Brown', index = 108},
		{colorIcon = "#785f33", label = 'Util Medium Brown', index = 109},
		{colorIcon = "#b5a079", label = 'Util Light Brown', index = 110},
		{colorIcon = "#453831", label = 'Worn Brown', index = 114},
		{colorIcon = "#2a282b", label = 'Worn Dark Brown', index = 115},
		{colorIcon = "#726c57", label = 'Worn straw beige', index = 116},
		{colorIcon = "#bcac8f", label = 'Matte Brown', index = 129},
		{colorIcon = "#7a6c55", label = 'Matte Desert Brown', index = 153},
		{colorIcon = "#c3b492", label = 'Matte Desert Tan', index = 154}
	},
	['purple'] = {
		{colorIcon = "#2f2d52", label = 'Metallic Purple Blue', index = 71},
		{colorIcon = "#282c4d", label = 'Metallic Spinnaker Blue', index = 72},
		{colorIcon = "#1b203e", label = 'Util Midnight Blue', index = 76},
		{colorIcon = "#3b39e0", label = 'Util Bright Blue', index = 81},
		{colorIcon = "#0c0d18", label = 'Metallic Black Purple', index = 142},
		{colorIcon = "#621276", label = 'Metallic Purple', index = 145},
		{colorIcon = "#6b1f7b", label = 'Matte Purple', index = 148},
		{colorIcon = "#1e1d22", label = 'Matte Dark Purple', index = 149}
	},
	['chrome'] = {
		{colorIcon = "linear-gradient(45deg, #627288, #e0e1e3, #a6acb4, #b8bbc4, #c4c4cb, #bcc4c6, #929ca8, #8790a0, #7b889c)", label = 'Brushed Steel', index = 117},
		{colorIcon = "linear-gradient(45deg, #747c8b, #74848f, #7c8493, #6c7a85, #7c8c99, #747c94, #7c849c, #848c9c, #748088, #748088)", label = 'Brushed Black steel', index = 118},
		{colorIcon = "linear-gradient(45deg, #a9b4c3, #475266, #e8eaee, #ced3dc, #63748b, #d4dce0, #6c7487, #758398, #848c9e, #747c84)", label = 'Brushed Aluminium', index = 119},
		{colorIcon = "linear-gradient(45deg, #bcbcbc, #dee1e6, #f1f3f4, #babcbe, #dee1e6, #f1f3f4, #babcbe, #dee1e6, #f1f3f4, #babcbe, #535353, #202124)", label = 'Chrome', index = 120}
	},
	['gold'] = {
		{colorIcon = "#c2944f", label = 'Metallic Classic Gold', index = 37},
		{colorIcon = "#7a6440", label = 'Pure Gold', index = 158},
		{colorIcon = "#7f6a48", label = 'Brushed Gold', index = 159},
		{colorIcon = "#d9de86", label = 'Light Gold', index = 160}
	}
}


-- ██╗  ██╗███████╗███╗   ██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ╚██╗██╔╝██╔════╝████╗  ██║██╔═══██╗████╗  ██║    ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
--  ╚███╔╝ █████╗  ██╔██╗ ██║██║   ██║██╔██╗ ██║    ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
--  ██╔██╗ ██╔══╝  ██║╚██╗██║██║   ██║██║╚██╗██║    ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
-- ██╔╝ ██╗███████╗██║ ╚████║╚██████╔╝██║ ╚████║    ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
-- ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
Config.IndexedXenonsColors = {
    {label = 'Default Xenon', index = -1},
	{label = 'White', index = 0},
	{label = 'Blue', index = 1},
	{label = 'Electric Blue', index = 2},
	{label = 'Mint Green', index = 3},
	{label = 'Lime Green', index = 4},
	{label = 'Yellow', index = 5},
	{label = 'Golden Shower', index = 6},
	{label = 'Orange', index = 7},
	{label = 'Red', index = 8},
	{label = 'Pony Pink', index = 9},
	{label = 'Hot Pink', index = 10},
	{label = 'Purple', index = 11},
	{label = 'Blacklight', index = 11},
}