-- ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║███████╗
-- ██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║╚════██║
-- ██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
---@param UseMissions boolean: Are the missions to be accessible to players?
Config.UseMissions = true

---@param RefreshNewMissions number: Here you specify every time to add a mission to the menu
Config.RefreshNewMissions = 7 * 60 * 1000 -- 7 Minutes

---@param MissionMoneyToSocietyPercent number: What percentage of a player's earnings from a mission should go to the company's money
Config.MissionMoneyToSocietyPercent = 0

---@param MissionMoneyToMechanicPercent number: What percentage of a player's earnings from a mission should go to him
Config.MissionMoneyToMechanicPercent = 50

Config.MissionBlips = {
    ['mission'] = {
        sprite = 380,
        display = 4,
        scale = 0.85,
        color = 30,
        routeColor = 30
    },
    ['back'] = {
        sprite = 728,
        display = 4,
        scale = 0.85,
        color = 30,
        routeColor = 30
    },
}

Config.MissionsPeds = {
    {model = "s_m_m_lifeinvad_01", image = "s_m_m_lifeinvad_01", name = "Jack"},
    {model = "s_m_m_trucker_01", image = "s_m_m_trucker_01", name = "Ben"},
    {model = "s_m_o_busker_01", image = "s_m_o_busker_01", name = "Mark"},
    {model = "s_m_y_strvend_01", image = "s_m_y_strvend_01", name = "Roger"},
    {model = "ig_agent", image = "ig_agent", name = "Jose"},
    {model = "ig_car3guy2", image = "ig_car3guy2", name = "Frank"},
    {model = "ig_claypain", image = "ig_claypain", name = "Carl"},
    {model = "ig_jimmyboston", image = "ig_jimmyboston", name = "Leo"},
    {model = "ig_manuel", image = "ig_manuel", name = "Manuel"},
    {model = "ig_maude", image = "ig_maude", name = "Maude"},
    {model = "ig_natalia", image = "ig_natalia", name = "Natalia"},
    {model = "ig_mrs_thornhill", image = "ig_mrs_thornhill", name = "Sara"},
    {model = "ig_screen_writer", image = "ig_screen_writer", name = "Camila"},
}

Config.PedsAnimations = {
    {"random@domestic", "f_distressed_loop"},
    {"rcmjosh1leadinout", "idle_josh"},
    {"friends@fra@ig_1", "base_idle"},
}

Config.Missions = {
    {
        reward = {240, 700}, -- draws between $240 and $700 or set a fixed number
        typeDamage = '1',
        mechanicVehicle = "burrito2",
        localizations = {
            {vehicle = vector4(2549.57, 1528.85, 29.62, 359.88), ped = vector4(2549.76, 1534.51, 29.58, 159.25)},
            {vehicle = vector4(667.61, 3202.42, 38.3, 82.73), ped = vector4(671.05, 3201.03, 38.4, 204.25)},
            {vehicle = vector4(1509.74, -1487.85, 68.23, 315.25), ped = vector4(1512.13, -1484.29, 68.63, 89.07)},
            {vehicle = vector4(642.2, -2667.51, 4.48, 25.51), ped = vector4(642.96, -2670.84, 5.09, 77.74)},
            {vehicle = vector4(1656.48, -2527.38, 74.3, 317.36), ped = vector4(1660.42, -2522.23, 75.47, 133.9)},
            {vehicle = vector4(-301.01, 2903.7, 44.05, 93.54), ped = vector4(-306.36, 2903.96, 44.32, 225.77)},
            {vehicle = vector4(-668.53, 5904.92, 15.0, 359.47), ped = vector4(-667.58, 5899.47, 15.61, 41.45)},
            {vehicle = vector4(1446.27, 6442.89, 19.64, 249.03), ped = vector4(1450.65, 6439.61, 20.1, 7.04)},
            {vehicle = vector4(2349.22, 4680.06, 34.39, 210.6), ped = vector4(2345.92, 4682.15, 34.76, 305.17)},
            {vehicle = vector4(-301.08, 1214.29, 318.27, 124.63), ped = vector4(-296.88, 1217.85, 318.19, 157.97)},
        },
        vehicles = {
            'sentinel',
            'sultan2',
            'taxi',
            'tulip2',
            'virgo3',
            'vamos',
        },
    },
}