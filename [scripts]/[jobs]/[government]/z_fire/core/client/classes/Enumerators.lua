---@script core/client/classes/Enumerators.lua

---@alias NotificationType
---| "success"
---| "error"
---| "info"
---| "warning"

---@alias UserInputKey string

---@class Enum
---@field eUserInputs table<UserInputKey, integer>
---@field eVehicleClasses table<integer, string>
---@field eVehicleColours table[]
---@field eWorldZones table<string, string>
---@field eMaterials table[]

---@type Enum
Enum = Enum or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Enumerations

---@enum eUserInputs
Enum.eUserInputs = {
    ---|> Function Keys
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,

    ---|> Special Keys
    ["ESC"] = 322,
    ["~"] = 243,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["ENTER"] = 18,
    ["CAPSLOCK"] = 137,
    ["LEFT_SHIFT"] = 21,
    ["LEFT_CTRL"] = 36,
    ["LEFT_ALT"] = 19,
    ["SPACEBAR"] = 22,
    ["RIGHT_SHIFT"] = 229,
    ["RIGHT_CTRL"] = 70,
    ["RIGHT_ALT"] = 230,
    ["HOME"] = 213,
    ["PAGE_UP"] = 10,
    ["PAGE_DOWN"] = 11,
    ["INSERT"] = 121,
    ["DELETE"] = 178,
    ["END"] = 168,
    ["PAUSE"] = 197,

    ---|> Number Keys
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["0"] = 48,

    ---|> Letters
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["J"] = 311,
    ["K"] = 311,
    ["L"] = 182,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,

    ---|> Punctuation
    [","] = 82,
    ["."] = 81,
    ["/"] = 43,
    [";"] = 58,

    ---|> Arrow Keys
    ["ARROW_UP"] = 172,
    ["ARROW_DOWN"] = 173,
    ["ARROW_LEFT"] = 174,
    ["ARROW_RIGHT"] = 175,

    ---|> Mouse Buttons
    ["RIGHT_MOUSE_BUTTON"] = 25,
    ["LEFT_MOUSE_BUTTON"] = 24,
    ["MIDDLE_MOUSE_BUTTON"] = 14,
    ["SCROLLWHEEL_UP"] = 17,
    ["SCROLLWHEEL_DOWN"] = 16,
    ["MOUSE_X"] = 1,
    ["MOUSE_Y"] = 2,

    ---|> Numpad Keys
    ["NUMPAD_0"] = 48,
    ["NUMPAD_1"] = 49,
    ["NUMPAD_2"] = 50,
    ["NUMPAD_3"] = 51,
    ["NUMPAD_4"] = 52,
    ["NUMPAD_5"] = 53,
    ["NUMPAD_6"] = 54,
    ["NUMPAD_7"] = 55,
    ["NUMPAD_8"] = 56,
    ["NUMPAD_9"] = 57,
    ["NUMPAD_PLUS"] = 96,
    ["NUMPAD_MINUS"] = 97,
    ["NUMPAD_ENTER"] = 98,
    ["NUMPAD_DOT"] = 99,

    ---|> Controller Keys
    ["CONTROLLER_A"] = 18,
    ["CONTROLLER_B"] = 45,
    ["CONTROLLER_X"] = 22,
    ["CONTROLLER_Y"] = 23,
    ["CONTROLLER_DPAD_UP"] = 27,
    ["CONTROLLER_DPAD_DOWN"] = 19,
    ["CONTROLLER_DPAD_LEFT"] = 20,
    ["CONTROLLER_DPAD_RIGHT"] = 21,
    ["CONTROLLER_LEFT_BUMPER"] = 37,
    ["CONTROLLER_RIGHT_BUMPER"] = 44,
    ["CONTROLLER_LEFT_TRIGGER"] = 10,
    ["CONTROLLER_RIGHT_TRIGGER"] = 11,
    ["CONTROLLER_LEFT_STICK"] = 13,
    ["CONTROLLER_RIGHT_STICK"] = 14,
    ["CONTROLLER_LEFT_AXIS_X"] = 1,
    ["CONTROLLER_LEFT_AXIS_Y"] = 2,
    ["CONTROLLER_RIGHT_AXIS_X"] = 3,
    ["CONTROLLER_RIGHT_AXIS_Y"] = 4,
    ["CONTROLLER_SELECT"] = 0,
    ["CONTROLLER_START"] = 1
}

---@enum eVehicleClasses
Enum.eVehicleClasses = {
    [0] = 'Compacts',
    [1] = 'Sedans',
    [2] = 'SUVs',
    [3] = 'Coupes',
    [4] = 'Muscle',
    [5] = 'Sports Classics',
    [6] = 'Sports',
    [7] = 'Super',
    [8] = 'Motorcycles',
    [9] = 'Off-Road',
    [10] = 'Industrial',
    [11] = 'Utility',
    [12] = 'Vans',
    [13] = 'Cycles',
    [14] = 'Boats',
    [15] = 'Helicopters',
    [16] = 'Planes',
    [17] = 'Service',
    [18] = 'Emergency',
    [19] = 'Military',
    [20] = 'Commercial',
    [21] = 'Trains',
    [22] = 'Open Wheels'
}

---@enum eVehicleColours
---@reference https://pastebin.com/pwHci0xK
Enum.eVehicleColours = {
    { 1,   3 },   -- Red & Black
    { 12,  13 },  -- Blue & Silver
    { 27,  42 },  -- Green & White
    { 54,  91 },  -- Orange & Gray
    { 111, 112 }, -- Yellow & Brown
    { 2,   13 },  -- Dark Red & Silver
    { 24,  118 }, -- Maroon & Beige
    { 76,  0 },   -- Midnight Blue & Black
    { 135, 8 },   -- Light Blue & Navy
    { 142, 141 }, -- Olive Green & Dark Green
    { 94,  92 },  -- Bright Orange & Yellow
    { 12,  132 }, -- Sky Blue & Aqua
    { 134, 122 }, -- Sand & Off-White
    { 145, 101 }, -- Light Brown & White
    { 149, 147 }, -- Pale Pink & Hot Pink
    { 71,  74 },  -- Steel Gray & Metallic Gray
    { 86,  1 },   -- Light Green & Black
    { 53,  4 },   -- Bright Red & Burgundy
    { 36,  38 },  -- Plum & Purple
    { 120, 122 }  -- Cream & Tan
}

---@enum eWorldZones
Enum.eWorldZones = {
    AIRP = "Los Santos International Airport",
    ALAMO = "Alamo Sea",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Canyon Dr",
    BANNING = "Banning",
    BEACH = "Vespucci Beach",
    BHAMCA = "Banham Canyon",
    BRADP = "Braddock Pass",
    BRADT = "Braddock Tunnel",
    BURTON = "Burton",
    CALAFB = "Calafia Bridge",
    CANNY = "Raton Canyon",
    CCREAK = "Cassidy Creek",
    CHAMH = "Chamberlain Hills",
    CHIL = "Vinewood Hills",
    CHU = "Chumash",
    CMSW = "Chiliad Mountain State Wilderness",
    CYPRE = "Cypress Flats",
    DAVIS = "Davis",
    DELBE = "Del Perro Beach",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Grand Senora Desert",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "East Vinewood",
    EBURO = "El Burro Heights",
    ELGORL = "El Gordo Lighthouse",
    ELYSIAN = "Elysian Island",
    GALFISH = "Galilee",
    GOLF = "GWC and Golfing Society",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Racetrack",
    HUMLAB = "Humane Labs and Research",
    JAIL = "Bolingbroke Penitentiary",
    KOREAT = "Little Seoul",
    LACT = "Land Act Reservoir",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Dam",
    LEGSQU = "Legion Square",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Mount Chiliad",
    MTGORDO = "Mount Gordo",
    MTJOSE = "Mount Josiah",
    MURRI = "Murrieta Heights",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E",
    OCEANA = "Pacific Ocean",
    PALCOV = "Paleto Cove",
    PALETO = "Paleto Bay",
    PALFOR = "Paleto Forest",
    PALHIGH = "Palomino Highlands",
    PALMPOW = "Palmer‑Taylor Power Station",
    PBLUFF = "Pacific Bluffs",
    PBOX = "Pillbox Hill",
    PROCOB = "Procopio Beach",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Hills",
    RTRAK = "Redwood Lights Track",
    SANAND = "San Andreas",
    SANCHIA = "San Chianski Mountain Range",
    SANDY = "Sandy Shores",
    SKID = "Mission Row",
    SLAB = "Stab City",
    STAD = "Maze Bank Arena",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Mountains",
    TERMINA = "Terminal",
    TEXTI = "Textile City",
    TONGVAH = "Tongva Hills",
    TONGVAV = "Tongva Valley",
    VCANA = "Vespucci Canals",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Ron Alternates Wind Farm",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo River",
    ZP_ORT = "Port of South Los Santos",
    ZQ_UAR = "Davis Quartz"
}

---@enum eMaterials
Enum.eMaterials = {
    ["0x0"] = {
        string = "None",
        spreadChance = 0.0
    },
    ["0x962C3F7B"] = {
        string = "Default",
        spreadChance = 0.1
    },
    ["0x46CA81E8"] = {
        string = "Concrete",
        spreadChance = 0.0
    },
    ["0x1567BF52"] = {
        string = "ConcretePothole",
        spreadChance = 0.0
    },
    ["0xBF59B491"] = {
        string = "ConcreteDusty",
        spreadChance = 0.0
    },
    ["0x10DD5498"] = {
        string = "Tarmac",
        spreadChance = 0.0
    },
    ["0xB26EEFB0"] = {
        string = "TarmacPainted",
        spreadChance = 0.0
    },
    ["0x70726A55"] = {
        string = "TarmacPothole",
        spreadChance = 0.0
    },
    ["0xF116BC2D"] = {
        string = "RumbleStrip",
        spreadChance = 0.0
    },
    ["0xC72165D6"] = {
        string = "BreezeBlock",
        spreadChance = 0.05
    },
    ["0xCDEB5023"] = {
        string = "Rock",
        spreadChance = 0.0
    },
    ["0xF8902AC8"] = {
        string = "RockMossy",
        spreadChance = 0.01
    },
    ["0x2D9C1E0D"] = {
        string = "Stone",
        spreadChance = 0.0
    },
    ["0x2257A573"] = {
        string = "Cobblestone",
        spreadChance = 0.0
    },
    ["0x61B1F936"] = {
        string = "Brick",
        spreadChance = 0.0
    },
    ["0x73EF7697"] = {
        string = "Marble",
        spreadChance = 0.0
    },
    ["0x71AB3FEE"] = {
        string = "PavingSlab",
        spreadChance = 0.0
    },
    ["0x23500534"] = {
        string = "SandstoneSolid",
        spreadChance = 0.0
    },
    ["0x7209440E"] = {
        string = "SandstoneBrittle",
        spreadChance = 0.0
    },
    ["0xA0EBF7E4"] = {
        string = "SandLoose",
        spreadChance = 0.0
    },
    ["0x1E6D775E"] = {
        string = "SandCompact",
        spreadChance = 0.0
    },
    ["0x363CBCD5"] = {
        string = "SandWet",
        spreadChance = 0.0
    },
    ["0x8E4D8AFF"] = {
        string = "SandTrack",
        spreadChance = 0.0
    },
    ["0xBC4922A4"] = {
        string = "SandUnderwater",
        spreadChance = 0.0
    },
    ["0x1E5E7A48"] = {
        string = "SandDryDeep",
        spreadChance = 0.0
    },
    ["0x4CCC2AFF"] = {
        string = "SandWetDeep",
        spreadChance = 0.0
    },
    ["0xD125AA55"] = {
        string = "Ice",
        spreadChance = 0.0
    },
    ["0x8CE6E7D9"] = {
        string = "IceTarmac",
        spreadChance = 0.0
    },
    ["0x8C8308CA"] = {
        string = "SnowLoose",
        spreadChance = 0.0
    },
    ["0xCBA23987"] = {
        string = "SnowCompact",
        spreadChance = 0.0
    },
    ["0x608ABC80"] = {
        string = "SnowDeep",
        spreadChance = 0.0
    },
    ["0x5C67C62A"] = {
        string = "SnowTarmac",
        spreadChance = 0.0
    },
    ["0x38BBD00C"] = {
        string = "GravelSmall",
        spreadChance = 0.0
    },
    ["0x7EDC5571"] = {
        string = "GravelLarge",
        spreadChance = 0.0
    },
    ["0xEABD174E"] = {
        string = "GravelDeep",
        spreadChance = 0.0
    },
    ["0x72C668B6"] = {
        string = "GravelTrainTrack",
        spreadChance = 0.0
    },
    ["0x8F9CD58F"] = {
        string = "DirtTrack",
        spreadChance = 0.01
    },
    ["0x8C31B7EA"] = {
        string = "MudHard",
        spreadChance = 0.01
    },
    ["0x129ECA2A"] = {
        string = "MudPothole",
        spreadChance = 0.01
    },
    ["0x61826E7A"] = {
        string = "MudSoft",
        spreadChance = 0.01
    },
    ["0xEFB2DF09"] = {
        string = "MudUnderwater",
        spreadChance = 0.0
    },
    ["0x42251DC0"] = {
        string = "MudDeep",
        spreadChance = 0.0
    },
    ["0xD4C07E2"] = {
        string = "Marsh",
        spreadChance = 0.05
    },
    ["0x5E73A22E"] = {
        string = "MarshDeep",
        spreadChance = 0.02
    },
    ["0xD63CCDDB"] = {
        string = "Soil",
        spreadChance = 0.2
    },
    ["0x4434DFE7"] = {
        string = "ClayHard",
        spreadChance = 0.05
    },
    ["0x216FF3F0"] = {
        string = "ClaySoft",
        spreadChance = 0.1
    },
    ["0xE47A3E41"] = {
        string = "GrassLong",
        spreadChance = 0.8
    },
    ["0x4F747B87"] = {
        string = "Grass",
        spreadChance = 0.7
    },
    ["0xB34E900D"] = {
        string = "GrassShort",
        spreadChance = 0.6
    },
    ["0x92B69883"] = {
        string = "Hay",
        spreadChance = 0.9
    },
    ["0x22AD7B72"] = {
        string = "Bushes",
        spreadChance = 0.8
    },
    ["0xC98F5B61"] = {
        string = "Twigs",
        spreadChance = 0.85
    },
    ["0x8653C6CD"] = {
        string = "Leaves",
        spreadChance = 0.75
    },
    ["0xED932E53"] = {
        string = "Woodchips",
        spreadChance = 0.6
    },
    ["0x8DD4EBB9"] = {
        string = "TreeBark",
        spreadChance = 0.4
    },
    ["0xA9BC4217"] = {
        string = "MetalSolidSmall",
        spreadChance = 0.0
    },
    ["0xEA34E8F8"] = {
        string = "MetalSolidMedium",
        spreadChance = 0.0
    },
    ["0x2CD49BD1"] = {
        string = "MetalSolidLarge",
        spreadChance = 0.0
    },
    ["0xF3B93B"] = {
        string = "MetalHollowSmall",
        spreadChance = 0.0
    },
    ["0x6E3DBFB8"] = {
        string = "MetalHollowMedium",
        spreadChance = 0.0
    },
    ["0xDD3CDCF9"] = {
        string = "MetalHollowLarge",
        spreadChance = 0.0
    },
    ["0x2D6E26CD"] = {
        string = "MetalChainLinkSmall",
        spreadChance = 0.0
    },
    ["0x781FA34"] = {
        string = "MetalChainLinkLarge",
        spreadChance = 0.0
    },
    ["0x31B80AD6"] = {
        string = "MetalCorrugatedIron",
        spreadChance = 0.0
    },
    ["0xE699F485"] = {
        string = "MetalGrille",
        spreadChance = 0.0
    },
    ["0x7D368D93"] = {
        string = "MetalRailing",
        spreadChance = 0.0
    },
    ["0x68FEB9FD"] = {
        string = "MetalDuct",
        spreadChance = 0.0
    },
    ["0xF2373DE9"] = {
        string = "MetalGarageDoor",
        spreadChance = 0.0
    },
    ["0xD2FFA63D"] = {
        string = "MetalManhole",
        spreadChance = 0.0
    },
    ["0xE82A6F1C"] = {
        string = "WoodSolidSmall",
        spreadChance = 0.5
    },
    ["0x2114B37D"] = {
        string = "WoodSolidMedium",
        spreadChance = 0.5
    },
    ["0x309F8BB7"] = {
        string = "WoodSolidLarge",
        spreadChance = 0.5
    },
    ["0x789C7AB"] = {
        string = "WoodSolidPolished",
        spreadChance = 0.4
    },
    ["0xD35443DE"] = {
        string = "WoodFloorDusty",
        spreadChance = 0.6
    },
    ["0x76D9AC2F"] = {
        string = "WoodHollowSmall",
        spreadChance = 0.5
    },
    ["0xEA3746BD"] = {
        string = "WoodHollowMedium",
        spreadChance = 0.5
    },
    ["0xC8D738E7"] = {
        string = "WoodHollowLarge",
        spreadChance = 0.5
    },
    ["0x461D0E9B"] = {
        string = "WoodChipboard",
        spreadChance = 0.6
    },
    ["0x2B13503D"] = {
        string = "WoodOldCreaky",
        spreadChance = 0.7
    },
    ["0x981E5200"] = {
        string = "WoodHighDensity",
        spreadChance = 0.5
    },
    ["0x77E08A22"] = {
        string = "WoodLattice",
        spreadChance = 0.5
    },
    ["0xB94A2EB5"] = {
        string = "Ceramic",
        spreadChance = 0.0
    },
    ["0x689E0E75"] = {
        string = "RoofTile",
        spreadChance = 0.1
    },
    ["0xAB87C845"] = {
        string = "RoofFelt",
        spreadChance = 0.3
    },
    ["0x50B728DB"] = {
        string = "Fiberglass",
        spreadChance = 0.1
    },
    ["0xD9B1CDE0"] = {
        string = "Tarpaulin",
        spreadChance = 0.2
    },
    ["0x846BC4FF"] = {
        string = "Plastic",
        spreadChance = 0.3
    },
    ["0x25612338"] = {
        string = "PlasticHollow",
        spreadChance = 0.3
    },
    ["0x9F154729"] = {
        string = "PlasticHighDensity",
        spreadChance = 0.2
    },
    ["0x9126E8CB"] = {
        string = "PlasticClear",
        spreadChance = 0.2
    },
    ["0x2E0ECF63"] = {
        string = "PlasticHollowClear",
        spreadChance = 0.2
    },
    ["0xB038852E"] = {
        string = "PlasticHighDensityClear",
        spreadChance = 0.2
    },
    ["0xD256ED46"] = {
        string = "FiberglassHollow",
        spreadChance = 0.1
    },
    ["0xF7503F13"] = {
        string = "Rubber",
        spreadChance = 0.2
    },
    ["0xD1461B30"] = {
        string = "RubberHollow",
        spreadChance = 0.2
    },
    ["0x11436942"] = {
        string = "Linoleum",
        spreadChance = 0.4
    },
    ["0x6E02C9AA"] = {
        string = "Laminate",
        spreadChance = 0.4
    },
    ["0x27E49616"] = {
        string = "CarpetSolid",
        spreadChance = 0.7
    },
    ["0x973AE44"] = {
        string = "CarpetSolidDusty",
        spreadChance = 0.7
    },
    ["0xACC354B1"] = {
        string = "CarpetFloorboard",
        spreadChance = 0.7
    },
    ["0x7519E5D"] = {
        string = "Cloth",
        spreadChance = 0.8
    },
    ["0xDDC7963F"] = {
        string = "PlasterSolid",
        spreadChance = 0.1
    },
    ["0xF0FC7AFE"] = {
        string = "PlasterBrittle",
        spreadChance = 0.1
    },
    ["0xE18DFF5"] = {
        string = "CardboardSheet",
        spreadChance = 0.9
    },
    ["0xAC038918"] = {
        string = "CardboardBox",
        spreadChance = 0.9
    },
    ["0x1C42F3BC"] = {
        string = "Paper",
        spreadChance = 1.0
    },
    ["0x30341454"] = {
        string = "Foam",
        spreadChance = 0.4
    },
    ["0x4FFB413F"] = {
        string = "FeatherPillow",
        spreadChance = 0.7
    },
    ["0x97476A9D"] = {
        string = "Polystyrene",
        spreadChance = 0.5
    },
    ["0xDDFF4E0C"] = {
        string = "Leather",
        spreadChance = 0.3
    },
    ["0x553BE97C"] = {
        string = "TvScreen",
        spreadChance = 0.1
    },
    ["0x2827CBD9"] = {
        string = "SlattedBlinds",
        spreadChance = 0.2
    },
    ["0x37E12A0B"] = {
        string = "GlassShootThrough",
        spreadChance = 0.0
    },
    ["0xE931A0E"] = {
        string = "GlassBulletproof",
        spreadChance = 0.0
    },
    ["0x596C55D1"] = {
        string = "GlassOpaque",
        spreadChance = 0.0
    },
    ["0x9F73E76C"] = {
        string = "Perspex",
        spreadChance = 0.0
    },
    ["0xFA73FCA1"] = {
        string = "CarMetal",
        spreadChance = 0.0
    },
    ["0x7F630AE2"] = {
        string = "CarPlastic",
        spreadChance = 0.2
    },
    ["0xC59BC28A"] = {
        string = "CarSoftTop",
        spreadChance = 0.5
    },
    ["0x7EFDF110"] = {
        string = "CarSoftTopClear",
        spreadChance = 0.5
    },
    ["0x4A57FFCA"] = {
        string = "CarGlassWeak",
        spreadChance = 0.0
    },
    ["0x23EF48BC"] = {
        string = "CarGlassMedium",
        spreadChance = 0.0
    },
    ["0x3FD6150A"] = {
        string = "CarGlassStrong",
        spreadChance = 0.0
    },
    ["0x995DA5E6"] = {
        string = "CarGlassBulletproof",
        spreadChance = 0.0
    },
    ["0x1E94B2B7"] = {
        string = "CarGlassOpaque",
        spreadChance = 0.0
    },
    ["0x19F81600"] = {
        string = "Water",
        spreadChance = 0.0
    },
    ["0x4FE54A"] = {
        string = "Blood",
        spreadChance = 0.0
    },
    ["0xDA2E9567"] = {
        string = "Oil",
        spreadChance = 0.3
    },
    ["0x9E98536C"] = {
        string = "Petrol",
        spreadChance = 0.9
    },
    ["0x33C7D38F"] = {
        string = "FreshMeat",
        spreadChance = 0.4
    },
    ["0xA9DC9A13"] = {
        string = "DriedMeat",
        spreadChance = 0.6
    },
    ["0x5978A2ED"] = {
        string = "EmissiveGlass",
        spreadChance = 0.0
    },
    ["0x3F28ABAC"] = {
        string = "EmissivePlastic",
        spreadChance = 0.3
    },
    ["0xED92FC47"] = {
        string = "VfxMetalElectrified",
        spreadChance = 0.0
    },
    ["0x2473B1BF"] = {
        string = "VfxMetalWaterTower",
        spreadChance = 0.0
    },
    ["0xD6CBF212"] = {
        string = "VfxMetalSteam",
        spreadChance = 0.0
    },
    ["0x13D5CB0D"] = {
        string = "VfxMetalFlame",
        spreadChance = 0.0
    },
    ["0x63545F03"] = {
        string = "PhysNoFriction",
        spreadChance = 0.0
    },
    ["0x9B0A74CA"] = {
        string = "PhysGolfBall",
        spreadChance = 0.0
    },
    ["0xF0B2FF05"] = {
        string = "PhysTennisBall",
        spreadChance = 0.0
    },
    ["0xF1F990E5"] = {
        string = "PhysCaster",
        spreadChance = 0.0
    },
    ["0x7830C8F1"] = {
        string = "PhysCasterRusty",
        spreadChance = 0.0
    },
    ["0x50384F9D"] = {
        string = "PhysCarVoid",
        spreadChance = 0.0
    },
    ["0xEE9E1045"] = {
        string = "PhysPedCapsule",
        spreadChance = 0.0
    },
    ["0xBA428CAB"] = {
        string = "PhysElectricFence",
        spreadChance = 0.0
    },
    ["0x87F87187"] = {
        string = "PhysElectricMetal",
        spreadChance = 0.0
    },
    ["0xA402C0C0"] = {
        string = "PhysBarbedWire",
        spreadChance = 0.0
    },
    ["0x241B6C19"] = {
        string = "PhysPoolTableSurface",
        spreadChance = 0.0
    },
    ["0x39FDE2BB"] = {
        string = "PhysPoolTableCushion",
        spreadChance = 0.0
    },
    ["0xD36536C6"] = {
        string = "PhysPoolTableBall",
        spreadChance = 0.0
    },
    ["0x1CD01A28"] = {
        string = "Buttocks",
        spreadChance = 0.0
    },
    ["0xE48CC7C1"] = {
        string = "ThighLeft",
        spreadChance = 0.0
    },
    ["0x26E885F4"] = {
        string = "ShinLeft",
        spreadChance = 0.0
    },
    ["0x72D0C8E7"] = {
        string = "FootLeft",
        spreadChance = 0.0
    },
    ["0xF1DFF3F9"] = {
        string = "ThighRight",
        spreadChance = 0.0
    },
    ["0xE56A0745"] = {
        string = "ShinRight",
        spreadChance = 0.0
    },
    ["0xAE64A1D4"] = {
        string = "FootRight",
        spreadChance = 0.0
    },
    ["0x8D6C3ADC"] = {
        string = "Spine0",
        spreadChance = 0.0
    },
    ["0xBC0B421B"] = {
        string = "Spine1",
        spreadChance = 0.0
    },
    ["0x56E0CA1D"] = {
        string = "Spine2",
        spreadChance = 0.0
    },
    ["0x1F3C404"] = {
        string = "Spine3",
        spreadChance = 0.0
    },
    ["0xA8676EAF"] = {
        string = "ClavicleLeft",
        spreadChance = 0.0
    },
    ["0xE194CB2A"] = {
        string = "UpperArmLeft",
        spreadChance = 0.0
    },
    ["0x3E4A6464"] = {
        string = "LowerArmLeft",
        spreadChance = 0.0
    },
    ["0x6BDCCA1"] = {
        string = "HandLeft",
        spreadChance = 0.0
    },
    ["0xA32DA7DA"] = {
        string = "ClavicleRight",
        spreadChance = 0.0
    },
    ["0x5979C903"] = {
        string = "UpperArmRight",
        spreadChance = 0.0
    },
    ["0x69F8EE36"] = {
        string = "LowerArmRight",
        spreadChance = 0.0
    },
    ["0x774441B4"] = {
        string = "HandRight",
        spreadChance = 0.0
    },
    ["0x666B1694"] = {
        string = "Neck",
        spreadChance = 0.0
    },
    ["0xD42ACC0F"] = {
        string = "Head",
        spreadChance = 0.0
    },
    ["0x110F7216"] = {
        string = "AnimalDefault",
        spreadChance = 0.0
    },
    ["0x8DBDD298"] = {
        string = "CarEngine",
        spreadChance = 0.5
    },
    ["0x3B982E13"] = {
        string = "Puddle",
        spreadChance = 0.0
    },
    ["0x78239B1A"] = {
        string = "ConcretePavement",
        spreadChance = 0.0
    },
    ["0xBB9CA6D8"] = {
        string = "BrickPavement",
        spreadChance = 0.0
    },
    ["0x85F61AC9"] = {
        string = "PhysDynamicCoverBound",
        spreadChance = 0.0
    },
    ["0x3B7F59CE"] = {
        string = "VfxWoodBeerBarrel",
        spreadChance = 0.6
    },
    ["0x8070DCF9"] = {
        string = "WoodHighFriction",
        spreadChance = 0.5
    },
    ["0x79E4953"] = {
        string = "RockNoinst",
        spreadChance = 0.0
    },
    ["0x55E5AAEE"] = {
        string = "BushesNoinst",
        spreadChance = 0.8
    },
    ["0xD48AA0F2"] = {
        string = "MetalSolidRoadSurface",
        spreadChance = 0.0
    },
    ["0x8388FA6C"] = {
        string = "StuntRampSurface",
        spreadChance = 0.0
    },
    ["0x2C848051"] = {
        string = "Temp01",
        spreadChance = 0.0
    },
    ["0x8A1A9241"] = {
        string = "Temp02",
        spreadChance = 0.0
    },
    ["0x71E96559"] = {
        string = "Temp03",
        spreadChance = 0.0
    },
    ["0x72ADD5E0"] = {
        string = "Temp04",
        spreadChance = 0.0
    },
    ["0xACEE6610"] = {
        string = "Temp05",
        spreadChance = 0.0
    },
    ["0x3F4163F1"] = {
        string = "Temp06",
        spreadChance = 0.0
    },
    ["0x96C43F1E"] = {
        string = "Temp07",
        spreadChance = 0.0
    },
    ["0x5016ECD6"] = {
        string = "Temp08",
        spreadChance = 0.0
    },
    ["0x3D285B19"] = {
        string = "Temp09",
        spreadChance = 0.0
    },
    ["0x3C5F90A"] = {
        string = "Temp10",
        spreadChance = 0.0
    },
    ["0x2D45692"] = {
        string = "Temp11",
        spreadChance = 0.0
    },
    ["0x29E0C642"] = {
        string = "Temp12",
        spreadChance = 0.0
    },
    ["0x9E65F2A7"] = {
        string = "Temp13",
        spreadChance = 0.0
    },
    ["0xD97F800A"] = {
        string = "Temp14",
        spreadChance = 0.0
    },
    ["0xA1961C15"] = {
        string = "Temp15",
        spreadChance = 0.0
    },
    ["0xA5D57DD7"] = {
        string = "Temp16",
        spreadChance = 0.0
    },
    ["0x3C514932"] = {
        string = "Temp17",
        spreadChance = 0.0
    },
    ["0x50C38DF2"] = {
        string = "Temp18",
        spreadChance = 0.0
    },
    ["0xD0356F62"] = {
        string = "Temp19",
        spreadChance = 0.0
    },
    ["0x85A387EB"] = {
        string = "Temp20",
        spreadChance = 0.0
    },
    ["0xC2251964"] = {
        string = "Temp21",
        spreadChance = 0.0
    },
    ["0xDB059FFF"] = {
        string = "Temp22",
        spreadChance = 0.0
    },
    ["0x1BB7608F"] = {
        string = "Temp23",
        spreadChance = 0.0
    },
    ["0x750D8481"] = {
        string = "Temp24",
        spreadChance = 0.0
    },
    ["0x745D8E31"] = {
        string = "Temp25",
        spreadChance = 0.0
    },
    ["0xBD775456"] = {
        string = "Temp26",
        spreadChance = 0.0
    },
    ["0x3500F64A"] = {
        string = "Temp27",
        spreadChance = 0.0
    },
    ["0xB9AF9A0E"] = {
        string = "Temp28",
        spreadChance = 0.0
    },
    ["0x40475AB5"] = {
        string = "Temp29",
        spreadChance = 0.0
    },
    ["0xCFEBB4"] = {
        string = "Temp30",
        spreadChance = 0.0
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
