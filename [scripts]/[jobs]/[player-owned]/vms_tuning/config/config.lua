Config = {}

-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
local frameworkAutoFind = function()
    if GetResourceState('es_extended') ~= 'missing' then
        return "ESX"
    elseif GetResourceState('qb-core') ~= 'missing' then
        return "QB-Core"
    end
end

Config.Core = frameworkAutoFind()
Config.CoreExport = function()
    if Config.Core == "ESX" then
        return exports['es_extended']:getSharedObject()
    elseif Config.Core == "QB-Core" then
        return exports['qb-core']:GetCoreObject()
    end
end

---@field PlayerLoaded: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = Config.Core == "ESX" and "esx:playerLoaded" or "QBCore:Client:OnPlayerLoaded"

---@field PlayerLogoutServer: ESX: "esx:playerDropped" / QB-Core: "QBCore:Server:OnPlayerUnload"
Config.PlayerLogoutServer = Config.Core == "ESX" and "esx:playerDropped" or "QBCore:Server:OnPlayerUnload"

---@field PlayerSetJob: ESX: "esx:setJob" / QB-Core: "QBCore:Client:OnJobUpdate"
Config.PlayerSetJob = Config.Core == "ESX" and "esx:setJob" or "QBCore:Client:OnJobUpdate"

Config.Notification = function(message, time, type)
    if type == "success" then
        TriggerEvent('esx:showNotification', message)
    elseif type == "error" then
        TriggerEvent('esx:showNotification', message)
    elseif type == "info" then
        TriggerEvent('esx:showNotification', message)
    end
end

Config.Hud = {
    Enable = function()
        DisplayRadar(true)
    end,
    Disable = function()
        DisplayRadar(false)
    end
}

Config.Interact = {
    Enabled = false,
    Open = function(message)
        -- exports["interact"]:Open("E", message) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
        -- exports['qb-core']:DrawText(message, 'right')
    end,
    Close = function()
        -- exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
        -- exports['qb-core']:HideText()
    end
}



-- ███╗   ███╗ █████╗ ██╗███╗   ██╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ████╗ ████║██╔══██╗██║████╗  ██║    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ██╔████╔██║███████║██║██╔██╗ ██║    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
---@field AutoExecuteQuery boolean: Automatic execution of the creation of the vms_business table in database
Config.AutoExecuteQuery = false

---@field Debug boolean: By running debugging, you will receive prints at various activities, in case of any problems, this will be able to help you find the cause of the misconfiguration.
Config.Debug = false

---@field UseProgressbar boolean: If you want to use a progress bar for part installation, you can do so below.
Config.UseProgressBar = false

---@field UseSkillbar boolean: If you want to use the skill bar to install parts, you can do so below.
Config.UseSkillbar = false

---@field UseTarget boolean: Do you want to use target system
Config.UseTarget = false
Config.TargetResource = 'ox_target' -- 'ox_target' / 'qb-target'
Config.UseTargetSystemForTuningPoints = false
Config.UseTargetSystemForBossMenu = false

---@field Menu string: Menu that will appear to the mechanic if the player sends a tuning request
Config.Menu = 'ox_lib' -- 'esx_menu_default' / 'esx_context' / 'qb-menu' / 'ox_lib'
Config.ESXMenuDefault_Align = 'right'
Config.UseCustomQuestionMenu = false -- if you want to use for example vms_notify Question Menu, set it true, if you want to use default menu from Config.Menu set it false

Config.KeyToAccess = 38 -- E

Config.UseMarkers = true
Config.UseText3D = true
Config.UseHelpNotify = true

Config.Markers = {
    part = {
        id = 21,
        size = vec(0.4, 0.4, 0.4),
        rotation = {0.0, 0.0, 0.0},
        color = {r=87, g=60, b=250, a=120},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.0
    },
    installation = {
        id = 20,
        size = vec(0.35, 0.35, 0.35),
        rotation = {0.0, 180.0, 0.0},
        color = {r=87, g=60, b=250, a=120},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.0
    },
    talkWithNpc = { -- talk with npc marker from missions
        id = 20,
        size = vec(0.28, 0.28, 0.28),
        rotation = {0.0, 180.0, 0.0},
        color = {r=50, g=207, b=91, a=185},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.0
    },
    collectMoney = { -- Collect Money marker from missions
        id = 29,
        size = vec(0.28, 0.28, 0.28),
        rotation = {0.0, 0.0, 0.0},
        color = {r=50, g=207, b=91, a=185},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.0
    },
    returnVehicle = { -- Return vehicle marker from missions
        id = 1,
        size = vec(2.7, 2.7, 0.72),
        rotation = {0.0, 0.0, 0.0},
        color = {r=50, g=207, b=91, a=185},
        bobUpAndDown = false,
        rotate = false,
        distanceToSee = 25.0,
        distanceToAccess = 4.0
    },
}

---@field RequiredJobToBeHired string | nil: Do you want a player to have to be unemployed to be hired?
Config.RequiredJobToBeHired = 'unemployed'

---@field LoadPricesFromDatabase boolean: You can load vehicle prices from the database to automate the configuration process, but make sure that your database match to the function SV.getPricesFromDatabase in config.server.lua
Config.LoadPricesFromDatabase = true

---@field UseSharedVehiclesFromQB boolean: Automatic loading of vehicle prices from QBCore.Shared.Vehicles
Config.UseSharedVehiclesFromQB = false

---@field LiveriesUseCustomNames boolean: When using this option, it will search if a name other than NULL exists, if found, it will display the custom name, otherwise, it will set 'Livery ID' as before.
Config.LiveriesUseCustomNames = true

---@field RemoveGunsTuningMods boolean: Do you want tuning parts that add weapons to the vehicle to be automatically detected and removed from the purchase option
Config.RemoveGunsTuningMods = true
Config.DebugModsNames = false -- you will receive name prints that can be entered into Config.BlacklistArmedMods
Config.BlacklistArmedMods = {
    -- This works as a string.find, so for example if you debug the names of the mods and there is GUN_MOD1, GUN_MOD2 etc., just enter "GUN" as below
    "GUN", "ARMOR", "TORPEDO", "MISSILE", "REMOTE", "WIRE", "ROCKET", "HSW"
}

---@field VehiclePropertiesStateBag string: State bag to update vehicle properties, recommended no modification, default name should work for most users, unless you use another.
Config.VehiclePropertiesStateBag = "VehicleProperties"

---@field DefaultVehiclePrice number: Default price if the vehicle is not defined in Config.Vehicles (config.vehicles.lua)
Config.DefaultVehiclePrice = 15000

---@field ForMotorcyclesOnlyMotoWheels boolean: When a player wants to tune the wheels of a motorcycle, he will only be able to choose from the 'Motorcycle' section, because by using other types of rims, there may be problems for motorcycles
Config.ForMotorcyclesOnlyMotoWheels = true



-- ██████╗ ██╗███████╗ ██████╗ ██████╗ ██╗   ██╗███╗   ██╗████████╗     ██████╗ ██████╗ ██████╗ ███████╗███████╗
-- ██╔══██╗██║██╔════╝██╔════╝██╔═══██╗██║   ██║████╗  ██║╚══██╔══╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║██║███████╗██║     ██║   ██║██║   ██║██╔██╗ ██║   ██║       ██║     ██║   ██║██║  ██║█████╗  ███████╗
-- ██║  ██║██║╚════██║██║     ██║   ██║██║   ██║██║╚██╗██║   ██║       ██║     ██║   ██║██║  ██║██╔══╝  ╚════██║
-- ██████╔╝██║███████║╚██████╗╚██████╔╝╚██████╔╝██║ ╚████║   ██║       ╚██████╗╚██████╔╝██████╔╝███████╗███████║
-- ╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝
---@field UseDiscountCodes boolean: Do you want it to be possible to use the discount code for tuning
Config.UseDiscountCodes = true

---@field DiscountCodeLength number: from how many characters the code will be generated
Config.DiscountCodeLength = 12

---@field EnableDiscountsForWorkshops boolean: This allows in the boss-menu to create discount codes for the heads of tuning workshops
Config.EnableDiscountsForWorkshops = true

---@class DiscountCodesPercentages Percentages available to generate codes in boss menu for player
Config.DiscountCodesPercentages = {5, 10, 15, 20}

---@class DiscountCodesUsablesCount Number of coupons available to generate codes in player's boss menu
Config.DiscountCodesUsablesCount = {1, 2, 3, 4, 5, 10, 15, 20}

---@class AdminDiscountCodesCommand Commands for administrators to generate and delete discount codes
Config.AdminDiscountCodesCommand = {
    generate = {
        enabled = true,
        oldESX = false, -- oldESX only for ESX which use essentialmode script.
        commandName = "generatetuningcode",
        argumentsLabels = {
            [1] = "Code name or 0 - if you want to be random", 
            [2] = "Mechanic Point name or all", 
            [3] = "Percentage of discount", 
            [4] = "Count to use"
        },
        helpLabel = "Generate a discount code for tuning.",
        groups = "admin", -- example: string: "admin" or table: {"admin", "moderator"}
    },
    remove = {
        enabled = true,
        oldESX = false, -- oldESX only for ESX which use essentialmode script.
        commandName = "removetuningcode",
        argumentsLabels = {
            [1] = "Code name"
        },
        helpLabel = "Remove tuning discount code by name.",
        groups = "admin", -- example: string: "admin" or table: {"admin", "moderator"}
    }
}



---@field UseBuildInCompanyBalance boolean: If you dont want to use the balance built into the Management Menu, set this to false and configure config.server.lua to be compatible with your server, for example a script for banks that may have company accounts
Config.UseBuildInCompanyBalance = true
Config.RemoveBalanceFromMenu = false -- if you are using other than our prepared esx_society or buildet-in balance, set it true

Config.ESXSocietyEvents = {
    ['check'] = 'esx_society:checkSocietyBalance',
    ['withdraw'] = 'esx_society:withdrawMoney',
    ['deposit'] = 'esx_society:depositMoney',
}

---@field BillMoneyToSocietyPercent number: Do you want the company to receive a % from paid billing of tuning a vehicle?
Config.BillMoneyToSocietyPercent = 80

---@field BillMoneyToTunerPercent number: Do you want the tuner to receive a % from paid billing of tuning a vehicle?
Config.BillMoneyToTunerPercent = 20

---@field RequestMoneyToTunerPercent number: Do you want the tuner to receive a % from request of tuning a vehicle?
Config.RequestMoneyToTunerPercent = 5

---@field AddSocietyMoneyForTuningPercent number: Do you want the company to receive a % from price of tuning a vehicle?
Config.AddSocietyMoneyForTuningPercent = 10 -- number or false



--- ██╗   ██╗███╗   ███╗███████╗     ██████╗██╗████████╗██╗   ██╗██╗  ██╗ █████╗ ██╗     ██╗     
--- ██║   ██║████╗ ████║██╔════╝    ██╔════╝██║╚══██╔══╝╚██╗ ██╔╝██║  ██║██╔══██╗██║     ██║     
--- ██║   ██║██╔████╔██║███████╗    ██║     ██║   ██║    ╚████╔╝ ███████║███████║██║     ██║     
--- ╚██╗ ██╔╝██║╚██╔╝██║╚════██║    ██║     ██║   ██║     ╚██╔╝  ██╔══██║██╔══██║██║     ██║     
---  ╚████╔╝ ██║ ╚═╝ ██║███████║    ╚██████╗██║   ██║      ██║   ██║  ██║██║  ██║███████╗███████╗
---   ╚═══╝  ╚═╝     ╚═╝╚══════╝     ╚═════╝╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
Config.VMSCityHallResource = 'vms_cityhall'
Config.UseVMSCityHall = GetResourceState(Config.VMSCityHallResource) == 'started'

---@field UseCityHallResumes boolean: If you are using vms_cityhall and using the job center section and want players to send resumes to companies, set true
Config.UseCityHallResumes = false

---@field UseCityHallTaxes boolean: If you are using vms_cityhall and you use the tax option and want companies to have to pay tax on the money they earn, set true
Config.UseCityHallTaxes = false

---@field UseCityHallIncludedTaxes boolean: If you use taxes, do you want the taxes to be included in the default amounts you configure in vms_barber, or do you want them to be price + tax paid by the customer
Config.UseCityHallIncludedTaxes = false

---@field ApplyDiscountForInsuredVehicles boolean: If you're using VMS City Hall with the vehicle insurance system, enabling this option will reduce tuning prices for insured vehicles.
Config.ApplyDiscountForInsuredVehicles = true
Config.InsuredVehicleDiscount = 20 -- Vehicles with valid insurance will have 20% cheaper parts



-- ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗██╗  ██╗ ██████╗ ██████╗ ███████╗
-- ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝██║  ██║██╔═══██╗██╔══██╗██╔════╝
-- ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗███████║██║   ██║██████╔╝███████╗
-- ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║██╔══██║██║   ██║██╔═══╝ ╚════██║
-- ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║██║  ██║╚██████╔╝██║     ███████║
--  ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚══════╝
---@field UseTuningPoints boolean: Do you want to use the points provided by the vms_tuning resource, if you want to use export with another resource set false
Config.UseTuningPoints = true

Config.TuningPoints = {
     ['mlo260/4024'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-1144.6677, -2080.6841, 13.4069),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(1326.0176, 2630.9724, 38.2984),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo526'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-1144.6677, -2080.6841, 13.4069),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(770.3914, 1300.8390, 359.3622),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo685'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-1144.6677, -2080.6841, 13.4069),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(-2061.5737, -471.3734, 12.1860),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo887'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-1144.6677, -2080.6841, 13.4069),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(-1144.6677, -2080.6841, 12.4069),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo228'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-222.41, -1329.52, 29.89),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(181.8319, 2774.2329, 42.5230),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo686'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-222.41, -1329.52, 29.89),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(-1666.2178, -785.9500, 9.1747),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo618'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-222.41, -1329.52, 29.89),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(-99.5844, -436.4632, 36.4280),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['mlo592'] = { -- BennyS: Interior Benny'S.
    --[[useIndividualWebhooks = false,
    individualWebhooks = {
        ['BILL'] = true,
        ['TUNING'] = true,

        ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
        ['GENERATED_DISCOUNT_CODE'] = true,

        ['EMPLOYEE_BONUS'] = true,
        ['EMPLOYEE_CHANGE_GRADE'] = true,
        ['EMPLOYEE_FIRE'] = true,
        ['EMPLOYEE_HIRE'] = true,

        ['WITHDRAW'] = true,
        ['DEPOSIT'] = true,

        ['ANNOUNCEMENT'] = true,
    },]]
    blip = {
        enabled = false,
        sprite = 72,
        display = 4,
        scale = 0.85,
        color = 83,
        coords = vec(-222.41, -1329.52, 29.89),
        name = "LS Customs",
    },
    marker = {
        enabled = true,
        id = 1,
        size = vec(2.7, 2.7, 0.25),
        color = {r=87, g=60, b=250, a=125},
        rotate = false,
        distanceToSee = 15.0,
        distanceToAccess = 1.9
    },
    --[[markerBossMenu = {
        enabled = false,
        id = 29,
        coords = vector3(-197.97, -1341.61, 34.7),
        size = vec(0.55, 0.55, 0.55),
        color = {r=87, g=60, b=250, a=125},
        rotate = true,
        distanceToSee = 15.0,
        distanceToAccess = 1.3,
    },
    whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        vehicleClasses = {
            [0] = true, -- Compacts
            [1] = true, -- Sedans
            [2] = true, -- SUVs
            [3] = true, -- Coupes
            [4] = true, -- Muscle
            [5] = true, -- Sports Classics
            [6] = true, -- Sports
            [7] = true, -- Super
            [8] = true, -- Motorcycles
            [9] = true, -- Off-road
            -- [10] = true, -- Industrial
            -- [11] = true, -- Utility
            [12] = true, -- Vans
            [13] = true, -- Cycles
            -- [14] = true, -- Boats
            -- [15] = true, -- Helicopters
            -- [16] = true, -- Planes
            -- [17] = true, -- Service
            [18] = true, -- Emergency
            -- [19] = true, -- Military
            [20] = true, -- Commercial
            -- [21] = true, -- Trains
            -- [22] = true, -- Open Wheel
        },
        -- indexedColors = {},
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },
    blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
        -- vehicleClasses = {},
        -- indexedColors = {
        --     ['chameleon'] = true,
        -- },
        -- menus = {},
        -- parts = {},
        -- actions = {},
    },]]
    points = { --# Points where you can tune vehicles
        [1] = vector3(673.3151, 156.7120, 79.7716),
        -- [2] = vector3(-223.26, -1323.21, 29.89),
        -- [3] = vector(0.0, 0.0, 0.0),
    },
    --[[jobGradesToSet = {
        {grade = 0, label = 'Recruit'},
        {grade = 1, label = 'Employee'},
        {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
    },

    vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

    client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

    send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

    pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
    society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

    -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
    --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
    grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
    manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
    boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
    cityhall_grades = { -- Grades for sections from vms_cityhall
        ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
    },]]
},
    ['BennyS'] = { -- BennyS: Interior Benny'S.
        --[[useIndividualWebhooks = false,
        individualWebhooks = {
            ['BILL'] = true,
            ['TUNING'] = true,

            ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = true,
            ['GENERATED_DISCOUNT_CODE'] = true,

            ['EMPLOYEE_BONUS'] = true,
            ['EMPLOYEE_CHANGE_GRADE'] = true,
            ['EMPLOYEE_FIRE'] = true,
            ['EMPLOYEE_HIRE'] = true,

            ['WITHDRAW'] = true,
            ['DEPOSIT'] = true,

            ['ANNOUNCEMENT'] = true,
        },]]
        blip = {
            enabled = true,
            sprite = 72,
            display = 4,
            scale = 0.85,
            color = 83,
            coords = vec(-222.41, -1329.52, 29.89),
            name = "LS Customs",
        },
        marker = {
            enabled = true,
            id = 1,
            size = vec(2.7, 2.7, 0.25),
            color = {r=87, g=60, b=250, a=125},
            rotate = false,
            distanceToSee = 15.0,
            distanceToAccess = 1.9
        },
        --[[markerBossMenu = {
            enabled = false,
            id = 29,
            coords = vector3(-197.97, -1341.61, 34.7),
            size = vec(0.55, 0.55, 0.55),
            color = {r=87, g=60, b=250, a=125},
            rotate = true,
            distanceToSee = 15.0,
            distanceToAccess = 1.3,
        },
        whitelist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
            vehicleClasses = {
                [0] = true, -- Compacts
                [1] = true, -- Sedans
                [2] = true, -- SUVs
                [3] = true, -- Coupes
                [4] = true, -- Muscle
                [5] = true, -- Sports Classics
                [6] = true, -- Sports
                [7] = true, -- Super
                [8] = true, -- Motorcycles
                [9] = true, -- Off-road
                -- [10] = true, -- Industrial
                -- [11] = true, -- Utility
                [12] = true, -- Vans
                [13] = true, -- Cycles
                -- [14] = true, -- Boats
                -- [15] = true, -- Helicopters
                -- [16] = true, -- Planes
                -- [17] = true, -- Service
                [18] = true, -- Emergency
                -- [19] = true, -- Military
                [20] = true, -- Commercial
                -- [21] = true, -- Trains
                -- [22] = true, -- Open Wheel
            },
            -- indexedColors = {},
            -- menus = {},
            -- parts = {},
            -- actions = {},
        },
        blacklist = { -- https://docs.vames-store.com/assets/vms_tuning/guides/
            -- vehicleClasses = {},
            -- indexedColors = {
            --     ['chameleon'] = true,
            -- },
            -- menus = {},
            -- parts = {},
            -- actions = {},
        },]]
        points = { --# Points where you can tune vehicles
            [1] = vector3(-222.41, -1329.52, 29.89),
            [2] = vector3(-223.26, -1323.21, 29.89),
            -- [3] = vector(0.0, 0.0, 0.0),
        },
        --[[jobGradesToSet = {
            {grade = 0, label = 'Recruit'},
            {grade = 1, label = 'Employee'},
            {grade = 2, label = 'Manager', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
            {grade = 3, label = 'Boss', needToBeBoss = true}, -- needToBeBoss means that only the boss can give this grade, the manager will not be able to do so
        },

        vehicleSpawn = vector4(-181.4, -1289.19, 30.3, 175.67), -- The point where the vehicle with which you will be going on the mission is spawned

        client_can_select_tuning = true, -- This results in each player being able to select parts for his vehicle, and then paying, he selects the nearest mechanic who will install all the selected parts for him.

        send_bill_to_player = true, -- This allows the mechanic to send a bill for the nearest player to whom he is tuning the vehicle

        pay_from_society_money = false, -- Do you want the payment to be made with money from the society, if so, you need to enter the account name in society_name
        society_name = 'society_mechanic', -- Society name will be requiered for pay_from_society_money or for Config.AddSocietyMoneyForTuningPercent or for Config.BillMoneyToSocietyPercent only if you are using esx_society/qb-management | example: 'society_mechanic',

        -- Job Configuration common errors: https://docs.vames-store.com/assets/vms_tuning/common-errors#i-dont-see-tuning-points
        --job = 'mechanic', -- job name - not required if you want to use this public removing this line.
        grades_access = nil, -- nil: for every user with job, string: 'name', table: {'name', 'name2'}
        manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
        boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },]]
    },
    ['BennyS-Paintshop'] = {
        -- BennyS: Interior Benny'S.
        blip = {
            enabled = false,
        },
        marker = {
            enabled = true,
            id = 1,
            size = vec(2.7, 2.7, 0.25),
            color = {r=87, g=60, b=250, a=125},
            rotate = false,
            distanceToSee = 15.0,
            distanceToAccess = 1.9
        },
        whitelist = {
            -- vehicleClasses = {},
            -- indexedColors = {},
            menus = {
                ['visual'] = true, 
                ['paint'] = true,
                ['color1'] = true, 
                ['color2'] = true, 
            },
            parts = {
                ['color1'] = true, 
                ['color2'] = true, 
                ['pearlescentColor'] = true, 
                ['paintType1'] = true, 
                ['paintType2'] = true,
            },
            -- actions = {}
        },
        blacklist = {
            -- vehicleClasses = {},
            -- indexedColors = {},
            -- menus = {},
            -- parts = {},
            actions = {
                ['repair'] = true
            },
        },
        points = {
            [1] = vector3(-200.73, -1324.29, 29.71),
            -- [2] = vector(0.0, 0.0, 0.0),
        },

        isPaintBooth = true,
        paintBoothSettings = {
            --[[
                Explanation of how paintBoothSettings works:
                - offset: Offset from vehicle - position from which particles spray appears (X = left/right, Y = forward/backward, Z = up/down)
                - rotation: Rotation towards the vehicle (Default facing the vehicle, no need to modify this)
                - coords: Static coordinates in which the spray appears (NOT RECOMMENDED USAGE)
                - rotation: Rotation for option `coords` (NOT RECOMMENDED USAGE - it requires a carefully set rotation to coords)
                - scale: Scale of the spray (default is 1.4, you can set it to 0.5 for smaller spray or 2.0 for larger spray)
            ]]
            
            [1] = { -- Point Number 1 from points
                { -- Front Left
                    -- offset = vec(-3.2, 2.35, 0.6), -- Offset from vehicle - position from which particles spray appears (X = left/right, Y = forward/backward, Z = up/down)
                    -- rotation = vec(-100.0, 100.0, -10.0), -- Rotation towards the vehicle (Default facing the vehicle, no need to modify this)

                    coords = vector3(-201.76, -1327.09, 32.06), -- Static coordinates in which the spray appears (NOT RECOMMENDED USAGE)
                    rotation = vec(-110.131271362305, 0.054827820509672, -25.16682434082), -- Rotation for option `coords` (NOT RECOMMENDED USAGE)
                    
                    scale = 1.4,
                },
                { -- Front Right
                    -- offset = vec(3.2, 2.35, 0.6),
                    -- rotation = vec(100.0, -100.0, 30.0),
                    
                    coords = vector3(-201.89, -1321.74, 32.04), -- Static coordinates in which the spray appears (NOT RECOMMENDED USAGE)
                    rotation = vec(-110.294807434082, 0.056433282792568, -165.65940856934), -- Rotation for option `coords` (NOT RECOMMENDED USAGE)

                    scale = 1.4,
                },
                { -- Rear Left
                    -- offset = vec(-3.2, -2.35, 0.6),
                    -- rotation = vec(-100.0, 100.0, 30.0),
                    
                    coords = vector3(-196.8, -1321.74, 32.06), -- Static coordinates in which the spray appears (NOT RECOMMENDED USAGE)
                    rotation = vec(-110.892490386963, 0.053344376385212, 140.25662231445), -- Rotation for option `coords` (NOT RECOMMENDED USAGE)

                    scale = 1.4,
                },
                { -- Rear Right
                    -- offset = vec(3.2, -2.35, 0.6),
                    -- rotation = vec(100.0, -100.0, -10.0),

                    coords = vector3(-196.56, -1327.09, 32.09), -- Static coordinates in which the spray appears (NOT RECOMMENDED USAGE)
                    rotation = vec(-110.091567993164, 0.060863707214594, 34.872100830078), -- Rotation for option `coords` (NOT RECOMMENDED USAGE)
                    
                    scale = 1.4,
                }
            },
            -- [2] = {},
        },

        --[[external_acoount = 'BennyS', -- Then it will use the built-in company account from BennyS tuning

        client_can_select_tuning = true,
        
        send_bill_to_player = true,

        pay_from_society_money = false,
        society_name = nil,

        --job = 'mechanic', -- not required if you want to use this public.
        grades_access = {'recruit', 'employee', 'boss'},
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },]]
    },
    ['LSCustoms2'] = {
        -- LSCustoms2: Interior LS Customs located near the central airport.
        blip = {
            enabled = true,
            sprite = 72,
            display = 4,
            scale = 0.85,
            color = 83,
            coords = vec(-1155.1, -2006.39, 12.15),
            name = "LS Customs",
        },
        marker = {
            enabled = true,
            id = 1,
            size = vec(2.7, 2.7, 0.25),
            color = {r=87, g=60, b=250, a=125},
            rotate = false,
            distanceToSee = 15.0,
            distanceToAccess = 1.9
        },
        --[[whitelist = {
            vehicleClasses = {},
            indexedColors = {},
            menus = {},
            parts = {},
            actions = {}
        },]]
        --[[blacklist = {
            vehicleClasses = {},
            indexedColors = {},
            menus = {},
            parts = {},
            actions = {},
        },]]
        points = {
            [1] = vector3(-1155.1, -2006.39, 12.15),
        },
        -- jobGradesToSet = {
        --     {grade = 'recruit', label = 'Recruit'},
        --     {grade = 'employee', label = 'Employee'},
        --     {grade = 'manager', label = 'Manager', needToBeManager = true},
        --     {grade = 'boss', label = 'Boss', needToBeBoss = true},
        -- },
        -- client_can_select_tuning = false,
        -- send_bill_to_player = false,
        -- job = 'mechanic', -- not required if you want to use this public.
        -- grades_access = {'tuning'},
        -- manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
        -- boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
        -- cityhall_grades = { -- Grades for sections from vms_cityhall
        --     ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        --     ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        -- },
    },
    ['LSCustoms3'] = {
        -- LSCustoms3: Interior LS Customs located over the bridge from Mission Row police station.
        blip = {
            enabled = true,
            sprite = 72,
            display = 4,
            scale = 0.85,
            color = 83,
            coords = vec(731.63, -1088.84, 21.1),
            name = "LS Customs",
        },
        marker = {
            enabled = true,
            id = 1,
            size = vec(2.7, 2.7, 0.25),
            color = {r=87, g=60, b=250, a=125},
            rotate = false,
            distanceToSee = 15.0,
            distanceToAccess = 1.9
        },
        --[[whitelist = {
            vehicleClasses = {},
            indexedColors = {},
            menus = {},
            parts = {},
            actions = {}
        },]]
        --[[blacklist = {
            vehicleClasses = {},
            indexedColors = {},
            menus = {},
            parts = {},
            actions = {},
        },]]
        points = {
            [1] = vector3(731.63, -1088.84, 21.1),
        },
        -- jobGradesToSet = {
        --     {grade = 'recruit', label = 'Recruit'},
        --     {grade = 'employee', label = 'Employee'},
        --     {grade = 'manager', label = 'Manager', needToBeManager = true},
        --     {grade = 'boss', label = 'Boss', needToBeBoss = true},
        -- },
        -- client_can_select_tuning = false,
        -- send_bill_to_player = false,
        -- job = 'mechanic', -- not required if you want to use this public.
        -- grades_access = {'tuning'},
        -- manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
        -- boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
        -- cityhall_grades = { -- Grades for sections from vms_cityhall
        --     ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        --     ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        -- },
    },
    ['BeekersGarage'] = {
        -- BeekersGarage: Interior Beekers Garage & Parts located in Paleto Bay.
        blip = {
            enabled = true,
            sprite = 72,
            display = 4,
            scale = 0.85,
            color = 83,
            coords = vec(110.45, 6626.54, 30.8),
            name = "LS Customs",
        },
        marker = {
            enabled = true,
            id = 1,
            size = vec(2.7, 2.7, 0.25),
            color = {r=87, g=60, b=250, a=125},
            rotate = false,
            distanceToSee = 15.0,
            distanceToAccess = 1.9
        },
        --[[whitelist = {
            vehicleClasses = {},
            indexedColors = {},
            menus = {},
            parts = {},
            actions = {}
        },]]
        --[[blacklist = {
            vehicleClasses = {},
            indexedColors = {},
            menus = {},
            parts = {},
            actions = {},
        },]]
        points = {
            [1] = vector3(110.45, 6626.54, 30.8),
        },
        -- jobGradesToSet = {
        --     {grade = 'recruit', label = 'Recruit'},
        --     {grade = 'employee', label = 'Employee'},
        --     {grade = 'manager', label = 'Manager', needToBeManager = true},
        --     {grade = 'boss', label = 'Boss', needToBeBoss = true},
        -- },
        -- client_can_select_tuning = false,
        -- send_bill_to_player = false,
        -- job = 'mechanic', -- not required if you want to use this public.
        -- grades_access = {'tuning'},
        -- manager_grades = 'manager', -- string: 'name', table: {'name', 'name2'}
        -- boss_grades = 'boss', -- string: 'name', table: {'name', 'name2'}
        -- cityhall_grades = { -- Grades for sections from vms_cityhall
        --     ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        --     ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        -- },
    },
}