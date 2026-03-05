-- ███████╗████████╗ █████╗ ███╗   ██╗ ██████╗███████╗    ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗
-- ██╔════╝╚══██╔══╝██╔══██╗████╗  ██║██╔════╝██╔════╝    ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║
-- ███████╗   ██║   ███████║██╔██╗ ██║██║     █████╗      ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║
-- ╚════██║   ██║   ██╔══██║██║╚██╗██║██║     ██╔══╝      ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║
-- ███████║   ██║   ██║  ██║██║ ╚████║╚██████╗███████╗    ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝    ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝
Config.UseStanceSystem = true

---@class DefaultStanceValues default settings for vehicles
Config.DefaultStanceValues = {
    ['offset-front'] = {min = 70, max = 90},
    ['offset-rear'] = {min = 70, max = 90},
    ['rotation-front'] = {min = 0, max = 20},
    ['rotation-rear'] = {min = 0, max = 20},
}

---@class StanceCustomValues  
Config.StanceCustomValues = {
    ---@class byClasses
    byClasses = {
        -- [0] = {}, -- Compacts
        -- [1] = {}, -- Sedans
        -- [2] = {}, -- SUVs
        -- [3] = {}, -- Coupes
        -- [4] = {}, -- Muscle
        -- [5] = {}, -- Sports Classics
        -- [6] = {}, -- Sports
        -- [7] = {}, -- Super
        [8] = false, -- Motorcycles: (Setting false will prevent any modification of the wheels stance)
        -- [9] = {}, -- Off-road
        [10] = false, -- Industrial
        [11] = false, -- Utility
        [12] = false, -- Vans
        [13] = false, -- Cycles
        [14] = false, -- Boats
        [15] = false, -- Helicopters
        [16] = false, -- Planes
        [17] = false, -- Service
        [18] = false, -- Emergency
        [19] = false, -- Military
        [20] = false, -- Commercial
        [21] = false, -- Trains
        [22] = false, -- Open Wheel
    },

    ---@class byModels 
    byModels = {
        [GetHashKey('adder')] = false, -- By setting false for a model that is not plotted in byClasses, you prevent stance wheels from tuning in it

        [GetHashKey('zr350')] = {
            ['offset-front'] = {min = 70, max = 99},
            ['offset-rear'] = {min = 70, max = 99},
            ['rotation-front'] = {min = 0, max = 40},
            ['rotation-rear'] = {min = 0, max = 40},
        },
    }
}



-- ███████╗██╗   ██╗███████╗██████╗ ███████╗███╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗    ██╗  ██╗███████╗██╗ ██████╗ ██╗  ██╗████████╗
-- ██╔════╝██║   ██║██╔════╝██╔══██╗██╔════╝████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║    ██║  ██║██╔════╝██║██╔════╝ ██║  ██║╚══██╔══╝
-- ███████╗██║   ██║███████╗██████╔╝█████╗  ██╔██╗ ██║███████╗██║██║   ██║██╔██╗ ██║    ███████║█████╗  ██║██║  ███╗███████║   ██║   
-- ╚════██║██║   ██║╚════██║██╔═══╝ ██╔══╝  ██║╚██╗██║╚════██║██║██║   ██║██║╚██╗██║    ██╔══██║██╔══╝  ██║██║   ██║██╔══██║   ██║   
-- ███████║╚██████╔╝███████║██║     ███████╗██║ ╚████║███████║██║╚██████╔╝██║ ╚████║    ██║  ██║███████╗██║╚██████╔╝██║  ██║   ██║   
-- ╚══════╝ ╚═════╝ ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
Config.UseSuspensionHeight = true

Config.SuspensionHeightMin = -0.2
Config.SuspensionHeightMax = 0.14


-- ██╗    ██╗██╗  ██╗███████╗███████╗██╗     ███████╗    ███████╗██╗███████╗███████╗
-- ██║    ██║██║  ██║██╔════╝██╔════╝██║     ██╔════╝    ██╔════╝██║╚══███╔╝██╔════╝
-- ██║ █╗ ██║███████║█████╗  █████╗  ██║     ███████╗    ███████╗██║  ███╔╝ █████╗  
-- ██║███╗██║██╔══██║██╔══╝  ██╔══╝  ██║     ╚════██║    ╚════██║██║ ███╔╝  ██╔══╝  
-- ╚███╔███╔╝██║  ██║███████╗███████╗███████╗███████║    ███████║██║███████╗███████╗
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝    ╚══════╝╚═╝╚══════╝╚══════╝
Config.UseWheelsSize = true

Config.WheelsSizeMin = 0.4
Config.WheelsSizeMax = 1.2


-- ██╗    ██╗██╗  ██╗███████╗███████╗██╗     ███████╗    ██╗    ██╗██╗██████╗ ████████╗██╗  ██╗
-- ██║    ██║██║  ██║██╔════╝██╔════╝██║     ██╔════╝    ██║    ██║██║██╔══██╗╚══██╔══╝██║  ██║
-- ██║ █╗ ██║███████║█████╗  █████╗  ██║     ███████╗    ██║ █╗ ██║██║██║  ██║   ██║   ███████║
-- ██║███╗██║██╔══██║██╔══╝  ██╔══╝  ██║     ╚════██║    ██║███╗██║██║██║  ██║   ██║   ██╔══██║
-- ╚███╔███╔╝██║  ██║███████╗███████╗███████╗███████║    ╚███╔███╔╝██║██████╔╝   ██║   ██║  ██║
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝     ╚══╝╚══╝ ╚═╝╚═════╝    ╚═╝   ╚═╝  ╚═╝
Config.UseWheelsWidth = true

Config.WheelsWidthMin = 0.4
Config.WheelsWidthMax = 1.2


-- ███████╗███╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗    ███████╗██╗    ██╗ █████╗ ██████╗ 
-- ██╔════╝████╗  ██║██╔════╝ ██║████╗  ██║██╔════╝    ██╔════╝██║    ██║██╔══██╗██╔══██╗
-- █████╗  ██╔██╗ ██║██║  ███╗██║██╔██╗ ██║█████╗      ███████╗██║ █╗ ██║███████║██████╔╝
-- ██╔══╝  ██║╚██╗██║██║   ██║██║██║╚██╗██║██╔══╝      ╚════██║██║███╗██║██╔══██║██╔═══╝ 
-- ███████╗██║ ╚████║╚██████╔╝██║██║ ╚████║███████╗    ███████║╚███╔███╔╝██║  ██║██║     
-- ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝    ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     
Config.UseEngineSwaps = true

Config.EngineSwaps = {
    {label = '1.2 R4',                soundModel = 'blista',           tax = 'tuning', price = 25000},
    {label = '1.8 I4',                soundModel = 'pony',             tax = 'tuning', price = 30000},
    {label = '2.0 R4',                soundModel = 'futo',             tax = 'tuning', price = 33000},
    {label = '2.5 I4',                soundModel = 'buffalo',          tax = 'tuning', price = 40000},
    {label = '3.0 V6',                soundModel = 'kuruma',           tax = 'tuning', price = 55000},
    {label = '3.5 V6',                soundModel = 'brawler',          tax = 'tuning', price = 68000},
    {label = '4.0 V8',                soundModel = 'casco',            tax = 'tuning', price = 74000},
    {label = '5.5 V8',                soundModel = 'blade',            tax = 'tuning', price = 95000},
    {label = '6.2 V8',                soundModel = 'ratloader2',       tax = 'tuning', price = 145000},
    {label = '7.0 V12',               soundModel = 'penetrator',       tax = 'tuning', price = 174000},
    {label = '7.2 V12',               soundModel = 'gp1',              tax = 'tuning', price = 174000},
    {label = '8.0 W16',               soundModel = 'btype2',           tax = 'tuning', price = 250000},
    {label = 'Übermacht (N55 V6)',    soundModel = 'n55b30t0',         tax = 'tuning', price = 1},
    {label = 'Übermacht (S55 V6)',    soundModel = 's55b30',           tax = 'tuning', price = 1},
    {label = 'Benefactor (M113 V8)',  soundModel = 'mercedesm113',     tax = 'tuning', price = 1},
    {label = 'Benefactor (M155 V8)',  soundModel = 'mercedesm155',     tax = 'tuning', price = 1},
    {label = 'Benefactor (M177 V8)',  soundModel = 'ta176m177',        tax = 'tuning', price = 1},
    {label = 'Benefactor (M178 V8)',  soundModel = 'ta178amgb',        tax = 'tuning', price = 1},
    {label = 'Pegassi (L539 V12)',    soundModel = 'ta023l539',        tax = 'tuning', price = 1},
}

---@class VehiclesSwaps in this section, you can configure the availability of the engine swap option for a specific vehicle model
Config.VehiclesSwaps = {
    ['dubsta'] = {'brawler', 'blade', 'ratloader2'}, -- entered names must be available in Config.EngineSwaps (config.tuningmenu.lua) as soundModel
}

---@class VehiclesSwapsByClass in this section, you can configure the availability of engine swap options for specific classes of vehicles
Config.VehiclesSwapsByClass = {
    [0] = {'blista', 'pony', 'futo', 'buffalo'}, -- Compacts
    [1] = {'pony', 'futo', 'buffalo', 'kuruma', 'brawler', 'n55b30t0', 's55b30', 'mercedesm113', 'mercedesm155', 'ta176m177', 'ta178amgb'}, -- Sedans
    [2] = {'pony', 'futo', 'buffalo', 'kuruma', 'brawler', 'casco', 'blade', 'ratloader2'}, -- SUVs
    [3] = {'pony', 'futo', 'buffalo', 'kuruma', 'brawler', 'casco', 'blade', 'ratloader2', 'n55b30t0', 's55b30', 'mercedesm113', 'mercedesm155', 'ta176m177', 'ta178amgb'}, -- Coupes
    [4] = {'kuruma', 'brawler', 'casco', 'blade', 'ratloader2', 'btype2'}, -- Muscle
    [5] = {'kuruma', 'brawler', 'casco', 'blade', 'ratloader2', 'btype2', 'n55b30t0', 's55b30', 'mercedesm113', 'mercedesm155', 'ta176m177', 'ta178amgb', 'ta023l539'}, -- Sports Classics
    [6] = {'buffalo', 'kuruma', 'brawler', 'casco', 'blade', 'ratloader2', 'penetrator', 'gp1', 'btype2', 'n55b30t0', 's55b30', 'mercedesm113', 'mercedesm155', 'ta176m177', 'ta178amgb', 'ta023l539'}, -- Sports
    [7] = {'buffalo', 'kuruma', 'brawler', 'casco', 'blade', 'ratloader2', 'penetrator', 'gp1', 'btype2', 'n55b30t0', 's55b30', 'mercedesm113', 'mercedesm155', 'ta176m177', 'ta178amgb', 'ta023l539'}, -- Super
    [8] = nil, -- Motorcycles
    [9] = {'buffalo', 'kuruma', 'brawler', 'casco', 'blade', 'ratloader2'}, -- Off-road
    [10] = nil, -- Industrial
    [11] = {'blista', 'pony', 'futo', 'buffalo'}, -- Utility
    [12] = {'blista', 'pony', 'futo', 'buffalo'}, -- Vans
    [13] = nil, -- Cycles
    [14] = nil, -- Boats
    [15] = nil, -- Helicopters
    [16] = nil, -- Planes
    [17] = {'blista', 'pony', 'futo', 'buffalo'}, -- Service
    [18] = nil, -- Emergency
    [19] = nil, -- Military
    [20] = nil, -- Commercial
    [21] = nil, -- Trains
    [22] = {'penetrator', 'gp1'}, -- Open Wheel
}