Config = {}

-- █▀ █▀▄ ▄▀▄ █▄ ▄█ ██▀ █   █ ▄▀▄ █▀▄ █▄▀
-- █▀ █▀▄ █▀█ █ ▀ █ █▄▄ ▀▄▀▄▀ ▀▄▀ █▀▄ █ █
local frameworkAutoFind = function()
    if GetResourceState('es_extended') == 'started' then
        return "ESX"
    elseif GetResourceState('qb-core') == 'started' then
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

---@field PlayerLoaded string: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = Config.Core == "ESX" and "esx:playerLoaded" or "QBCore:Client:OnPlayerLoaded"

---@field PlayerLogoutServer string: ESX: "esx:playerDropped" / QB-Core: "QBCore:Server:OnPlayerUnload"
Config.PlayerLogoutServer = Config.Core == "ESX" and "esx:playerDropped" or "QBCore:Server:OnPlayerUnload"

---@field PlayerSetJob string: ESX: "esx:setJob" / QB-Core: "QBCore:Client:OnJobUpdate"
Config.PlayerSetJob = Config.Core == "ESX" and "esx:setJob" or "QBCore:Client:OnJobUpdate"


Config.Notification = function(message, time, type)
    if type == "success" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("VEHICLE SHOP", message, time, "#36f230", "fa-solid fa-shop")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', time)
        end
    elseif type == "error" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("VEHICLE SHOP", message, time, "#f23030", "fa-solid fa-shop")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', time)
        end
    elseif type == "info" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("VEHICLE SHOP", message, time, "#4287f5", "fa-solid fa-shop")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', time)
        end
    end
end

Config.Interact = {
    Enabled = false,
    Open = function(message)
        exports["interact"]:Open("E", message) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end,
    Close = function()
        exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end
}

Config.Hud = {
    Enable = function()
        exports["InsaneScripts_hud"]:showHud()
    end,
    Disable = function()
        exports["InsaneScripts_hud"]:hideHud()
    end
}

---@field UseTarget boolean: Do you want to use target system
Config.UseTarget = false
Config.TargetResource = 'ox_target' -- Prepared for 'ox_target', 'qb-target' (config.client.lua - CL.Target)

Config.UseMarkers = true -- Using a marker to display points
Config.UseText3D = false -- Using a 3D Text to display points
Config.UseHelpNotify = true -- Using a ESX.ShowHelpNotification (only for esx)

---@field AutoExecuteQuery boolean: Automatic execution of the creation of the vms_business table in database
Config.AutoExecuteQuery = true

---@field DebugPolyZone boolean: Option only for developers to recognize the registration of polyzone store object, and facilitate the creation of new
Config.DebugPolyZone = false

---@field PlateFormat string: Set up your license plate generation format, set any way you want, when you set a letter, it will generate a random letter, when you set a number, it will generate a random number, below are sample formats.
--[[
    Examples:
        'ABC 1234'
        '1234 ABC'
        'ABCD1234'
]]
Config.PlateFormat = 'ABC 123'

---@field UsePhotosTool boolean: Photos tool on greenscreen, used prop: 'prop_big_cin_screen' whose creator is nnuu
Config.UsePhotosTool = true
Config.PhotosToolCommand = 'photostool'

---@field UnitOfSpeed string: Speed unit for showroom display and maximum speed calculation
Config.UnitOfSpeed = 'mph' -- 'kmh' or 'mph'

---@field TestDriveOnRoutingBucket boolean: Is the test drive to take place in a dedicated virtual world, players will not see or hear each other
Config.TestDriveOnRoutingBucket = true


Config.Marker = {
    ['delivery'] = {
        distanceSee = 20.0,
        distanceAccess = 1.8,
        type = 20,
        color = {50, 50, 225, 175},
        rotation = vec(0.0, 0.0, 0.0),
        scale = vec(0.7, 0.7, 0.7),
        bobUpAndDown = false,
        rotate = true,
    },
    ['contract'] = {
        distanceSee = 7.75,
        distanceAccess = 2.8,
        type = 29,
        color = {142, 255, 77, 225},
        rotation = vec(0.0, 0.0, 0.0),
        scale = vec(0.28, 0.28, 0.28),
        bobUpAndDown = true,
        rotate = true,
    },
    ['showroom'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {142, 255, 77, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['management'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {252, 198, 3, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
}

Config.Blips = {
    ['delivery'] = {
        sprite = 271,
        display = 4,
        scale = 1.0,
        color = 38,
        routeColor = 38,
        name = "[Dealership] - Delivery"
    },
    ['order'] = {
        sprite = 479,
        display = 6,
        scale = 1.2,
        color = 28,
        routeColor = 28,
        name = "[Dealership] - Order"
    },
}

Config.Stores = {
    ["PDM"] = {
        jobName = 'pdm',
        societyName = 'society_pdm',
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },
        
        brand = "Premium Deluxe Motorsports",
        address = "Power St. Adam Apple Blvd, Pillbox Hill",

        paymentMethods = {'cash', 'bank'},

        wholesaleType = 'cars',
        maxOrderVehicles = 4, -- Maximum number of vehicles that can be ordered per order, due to the limit of space on the trailer for realistic delivery

        realisticDelivery = true, -- Does the player have to drive himself to pick up the vehicles
        orderDeliveryTime = 12 * 60, -- Value given in minutes, only works with realisticDelivery = false

        allowPurchase = true, -- Should there be an option to purchase the vehicle in the showroom?
        allowTestDrive = true, -- Should there be an option to test drive the vehicle in the showroom?
        showPrices = true, -- Should the vehicle price be visible in the showroom?
        abilityCustomLicensePlate = false, -- Should there be an option to set a custom license plate in the showroom/management?
        -- showOnlyAvailable = true, -- Should only vehicles available in stock be visible in the showroom?
 
        allowBuyIfEmployeesOffline = true, -- true allows the player to buy by himself when all employees are offline (you must have allowPurchase = true)

        spawnVehicleOnPurchase = true, -- Vehicle is supposed to spawn after purchase

        testDriveTime = 30, -- seconds
        testDrivePrice = 1000,

        freeCamRadius = 5.5,

        storeArea = {
            vector2(-1039.0804, -1305.2134),
            vector2(-1079.9962, -1462.2202),
            vector2(-1013.2831, -1440.0787),
            vector2(-1006.0475, -1360.5929),
        },

        minZ = 3.0,
        maxZ = 20.0,

        blip = {
            enabled = false,
            coords = vector3(-1054.2761, -1410.1533, 7.2658),
            sprite = 820,
            display = 4,
            scale = 1.0,
            color = 26,
            name = 'Premium Deluxe Motorsports',
        },

        vehiclePoint = vector4(-1035.4758, -1429.9486, 5.4258, 110.0680),
        deliveryPoint = vector3(-1065.1803, -1425.4854, 5.4258),

        onPurchasePoint = vector4(-1059.4860, -1396.4714, 5.4258, 73.4065),

        testDrivePoint = vector4(-1050.2847, -1397.4121, 5.4243, 77.6409),
        testDriveEndPoint = vector3(-1050.2847, -1397.4121, 5.4243),

        showroomPoint = {
            coords = vector3(-1041.3099, -1373.8392, 5.5541),
            targetCoords = vector3(-1041.4052, -1374.4406, 5.6271),
            targetHeading = 169.2435,
            targetSize = vec(3.5, 1.0, 1.8),
        },

        showroomInside = {
            camera = vector3(-1028.36, -1394.60, 5.56),
            cameraFov = 75.0,
            vehicle = vector4(-1032.4808, -1393.1981, 5.1422, 208.8245),
            player = vector4(-1038.9608, -1374.3053, 5.5542, 207.0280),
        },

        managementPoint = {
            coords = vector3(-1030.2158, -1359.8513, 9.4597),
            targetCoords = vector3(-1029.2235, -1359.0387, 9.2596),
            targetHeading = 284.4869,
            targetSize = vec(2.4, 1.35, 1.85),
        },

        vehiclesOnDisplay = {
            [1] = {
                coords = vector4(-1046.1100, -1366.0060, 5.1422, 110.1567),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
            [2] = {
                coords = vector4(-1047.6729, -1370.4139, 5.1211, 113.4159),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
            [3] = {
                coords = vector4(-1028.8784, -1359.7465, 5.1212, 75.2932),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
            [4] = {
                coords = vector4(-1031.3739, -1365.8782, 5.1210, 31.1302),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
            [5] = {
                coords = vector4(-1038.4464, -1366.2837, 5.1210, 344.8455),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
            [6] = {
                coords = vector4(-1046.7196, -1377.7949, 5.5541, 257.1772),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
            [7] = {
                coords = vector4(-1036.1829, -1380.7269, 5.5541, 255.0488),
                --[[primaryColor = 0,
                secondaryColor = 0,
                pearlescentColor = 0,
                wheelColor = 0,]]
            },
        },

        categories = {
            ['compacts'] = true,
            ['luxury'] = true,
            ['motorcycles'] = true,
            ['muscle'] = true,
            ['sedans'] = true,
            ['sports'] = true,
            ['sportsclassics'] = true,
            ['starter'] = true,
            ['super'] = true,
            ['suvs'] = true,
            ['truck'] = true,
            ['vans'] = true,
            ['wagons'] = true,
        },
        vehicles = {
            ['1016rwdevo'] = true,
            ['1016urus'] = true,
            ['16topcargle'] = true,
            ['17mansorypnmr'] = true,
            ['18performante'] = true,
            ['18rs7'] = true,
            ['2018s650p'] = true,
            ['2019chiron'] = true,
            ['2019m5'] = true,
            ['20xb7'] = true,
            ['21rsq8'] = true,
            ['22g63'] = true,
            ['22m5'] = true,
            ['350z'] = true,
            ['356a'] = true,
            ['488'] = true,
            ['488sp'] = true,
            ['600ltwb'] = true,
            ['675lt'] = true,
            ['77Monte'] = true,
            ['812mnsry'] = true,
            ['911gtrs'] = true,
            ['911turbos'] = true,
            ['a80'] = true,
            ['AAQ4'] = true,
            ['aerox155'] = true,
            ['agerars'] = true,
            ['amggt16'] = true,
            ['audirs8'] = true,
            ['bentaygam'] = true,
            ['benzc32'] = true,
            ['benzsl63'] = true,
            ['bmwe39'] = true,
            ['BOSS429'] = true,
            ['brz13varis'] = true,
            ['carrera19'] = true,
            ['cayen19'] = true,
            ['cb650r'] = true,
            ['claw'] = true,
            ['demon'] = true,
            ['demonhawkk'] = true,
            ['DL_G900'] = true,
            ['dle39m5'] = true,
            ['DLGT'] = true,
            ['DLI8'] = true,
            ['DLLAF'] = true,
            ['DLRS3'] = true,
            ['Drag1'] = true,
            ['Drag2'] = true,
            ['Drag3'] = true,
            ['Drag4'] = true,
            ['Drag5'] = true,
            ['Drag6'] = true,
            ['Drag7'] = true,
            ['DragS14'] = true,
            ['e39touring'] = true,
            ['e55'] = true,
            ['e63s'] = true,
            ['e92bb'] = true,
            ['escaladeprime'] = true,
            ['evox'] = true,
            ['f812'] = true,
            ['ferrari812super'] = true,
            ['FGT'] = true,
            ['fk8'] = true,
            ['fnfmk4'] = true,
            ['FORTWO17'] = true,
            ['fpaceprior'] = true,
            ['furai'] = true,
            ['fxxkevo'] = true,
            ['g63'] = true,
            ['g63c'] = true,
            ['G63Sam'] = true,
            ['g65'] = true,
            ['g700brabusretuned'] = true,
            ['g81hr'] = true,
            ['gcma4sedan2021'] = true,
            ['gcmlamboultimae'] = true,
            ['gemera'] = true,
            ['gl63'] = true,
            ['gmcev2'] = true,
            ['GODz95GSX'] = true,
            ['GODzBMWS1000RR'] = true,
            ['GODzDRIFTCAT'] = true,
            ['GODzKSTERZOTACHA'] = true,
            ['GODzRB26SUBI'] = true,
            ['GODzVIPS63AMG'] = true,
            ['GODzYAMR1'] = true,
            ['golf1'] = true,
            ['golf7'] = true,
            ['golf75r'] = true,
            ['golf8gti'] = true,
            ['golf91wideprzemo'] = true,
            ['gt17'] = true,
            ['gt2rs'] = true,
            ['gt3demon'] = true,
            ['gt3hycade'] = true,
            ['gt63'] = true,
            ['gt63mt'] = true,
            ['gta5rp_veh_ferrari19'] = true,
            ['gta5rp_veh_gle1'] = true,
            ['gta5rp_veh_gtr33'] = true,
            ['gto66c'] = true,
            ['gtr50'] = true,
            ['gtrh'] = true,
            ['gtz34be'] = true,
            ['HELLCATF9'] = true,
            ['hellcatlb'] = true,
            ['hexerz2'] = true,
            ['hycadeevo'] = true,
            ['Hycaders6'] = true,
            ['hycadeurus'] = true,
            ['hyundaiveloster'] = true,
            ['ikx3abt20'] = true,
            ['ikx3mc2021'] = true,
            ['ikx3rebel22'] = true,
            ['jes21'] = true,
            ['kart'] = true,
            ['keyrus'] = true,
            ['kgc10'] = true,
            ['kln'] = true,
            ['km1000rr'] = true,
            ['kyza36'] = true,
            ['lbperfs'] = true,
            ['lbwk35'] = true,
            ['lowrider_ballas'] = true,
            ['lpchopper2'] = true,
            ['m135iwb'] = true,
            ['m3e36'] = true,
            ['m3e46'] = true,
            ['m3e92'] = true,
            ['m3g80'] = true,
            ['m3g80mp'] = true,
            ['m3s'] = true,
            ['m4c'] = true,
            ['M4CC'] = true,
            ['m4f82'] = true,
            ['m4speedhunter'] = true,
            ['m5cs22'] = true,
            ['m5e60'] = true,
            ['m6e24'] = true,
            ['mach1'] = true,
            ['machewb'] = true,
            ['manhartx7'] = true,
            ['mans65'] = true,
            ['manscountach'] = true,
            ['mansgt'] = true,
            ['manspana'] = true,
            ['mansrs6'] = true,
            ['manssupersnake'] = true,
            ['mansurus'] = true,
            ['maybach'] = true,
            ['mayg600p'] = true,
            ['mercec63s'] = true,
            ['merse63'] = true,
            ['mlbrabus'] = true,
            ['mlnovitec'] = true,
            ['model3'] = true,
            ['models'] = true,
            ['modelx'] = true,
            ['mteche39'] = true,
            ['mustang65'] = true,
            ['mxpan'] = true,
            ['neonp1'] = true,
            ['nismo20'] = true,
            ['nissanr36'] = true,
            ['nm_ctsv'] = true,
            ['p1lbwk'] = true,
            ['panamturs21'] = true,
            ['passat'] = true,
            ['polestar1'] = true,
            ['polo2018'] = true,
            ['por911gt3'] = true,
            ['porche911speedhunter'] = true,
            ['q8hycade'] = true,
            ['q8prior'] = true,
            ['r35secret'] = true,
            ['r36fp'] = true,
            ['r820'] = true,
            ['r8beastedit'] = true,
            ['rmod240sx'] = true,
            ['rmodbentley1'] = true,
            ['rmodcharger'] = true,
            ['rmodcharger69'] = true,
            ['rmode63s'] = true,
            ['rmodf40'] = true,
            ['rmodg65'] = true,
            ['rmodgt63'] = true,
            ['rmodgtr'] = true,
            ['rmodm3e36'] = true,
            ['rmodm4'] = true,
            ['rmodm4gts'] = true,
            ['rmodmk7'] = true,
            ['rmodp1gtr'] = true,
            ['rmodpagani'] = true,
            ['rmodr50'] = true,
            ['rmodr8c'] = true,
            ['rmodsvj'] = true,
            ['rmodx6'] = true,
            ['rmodzl1'] = true,
            ['RoyalCustome39m5_wb'] = true,
            ['rr21shelbystreet'] = true,
            ['rrphantom'] = true,
            ['rrwraith'] = true,
            ['rs322sedan'] = true,
            ['rs4rk'] = true,
            ['rs5mans'] = true,
            ['rs615'] = true,
            ['rs6abt20'] = true,
            ['rs6c8'] = true,
            ['rs6rabt20'] = true,
            ['rs7'] = true,
            ['rs721'] = true,
            ['rs7bratwa'] = true,
            ['rs7c821'] = true,
            ['rs7c8beast'] = true,
            ['rs7wide'] = true,
            ['rx7'] = true,
            ['rx7veilside'] = true,
            ['s1'] = true,
            ['s15'] = true,
            ['s15lunar'] = true,
            ['s500w222'] = true,
            ['s63msc'] = true,
            ['s8d4'] = true,
            ['scubieblob'] = true,
            ['senna'] = true,
            ['sf90'] = true,
            ['silviagd'] = true,
            ['sinacp'] = true,
            ['singer'] = true,
            ['skyline'] = true,
            ['specialtf'] = true,
            ['suprapandem'] = true,
            ['swl'] = true,
            ['taycan'] = true,
            ['techart17'] = true,
            ['teslaroad'] = true,
            ['topcargt63'] = true,
            ['trhawk'] = true,
            ['TTSTO'] = true,
            ['v60hr'] = true,
            ['van_blacklions'] = true,
            ['van_vagos'] = true,
            ['vanztt'] = true,
            ['vanzur'] = true,
            ['variszupra'] = true,
            ['venatus'] = true,
            ['w140'] = true,
            ['w222wald'] = true,
            ['waldw222'] = true,
            ['xc90'] = true,
            ['yzfr6'] = true,
            ['z8r'] = true,
            ['zl1'] = true,
            ['zlay_gtz35'] = true,
            ['zm_rocket900'] = true,
            ['zm_s500'] = true,
            ['zx10r'] = true,
            ['zx6r'] = true,
        },
    },
}