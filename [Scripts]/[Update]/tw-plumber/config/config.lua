Config                       = {}
Locales                      = Locales or {}
Config.Framework             = 'esx'       -- esx, oldesx, qb, oldqb, vrp, qb = qbox -- || type qb if you are using qbox
Config.Locale                = 'en'
Config.CurrencyUnit          = '$'        -- '€' -- '₺'  '$'
Config.SQL                   = "oxmysql"  -- oxmysql / mysql-async / ghmattimysql
Config.Inventory             =
"ox_inventory"                            -- qb_inventory / esx_inventory / ox_inventory / qs_inventory / need Config.missioncompletedItems
Config.ServerName            = "LORP"   -- Server Name MAX 10
Config.MoneyType             = "$"        -- Money Type
Config.MoneyType2            = "bank"     -- Money Type bank / cash
Config.InteractionHandler    = 'scriptbase' --  drawtext, scriptbase -- currently only drawtext will be updated soon
Config.ExampleProfilePicture = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png"

Config.Command               = {
    jobReset = "jobresetplumber",
    jobLeave = "jobleaveplumber",
    openTutorial = "opentutorialplumber",
}

Config.MaxPlayersInLobby     = 4             -- max [4] Max players in lobby

Config.jobCoolDownHours      = 0             -- Job Cooldown Hours if 0 no cooldowns
Config.ChangeClothesSystem   = false         -- true / false
Config.ClothingScript        = "illenium-appearance" -- fivem-appearance / illenium-appearance  / esx_skin / qb-clothing
Config.TebexSystem           = false          -- true / false -- There is currently no tebex system, infrastructure for future addition
Config.Debug                 = false         -- true / false
Config.jobLevelCheck         = false         -- true / false  -- Everyone in the lobby is checked for level.
Config.closeInvisable        = false         -- prevents the player from being invisible during UI
Config.DefaultUIPositions    = {
    teamList = { top = '77.22vh', left = '85.94vw' },
    scoreList = { top = '2.64vh', left = '1.61vw' },
    inviteSide = { top = '90.07vh', left = '50.07vw' },
    notificationDiv = { top = '40.48vh', left = '81.54vw' }
}

Config.Job                   = {
    ['coords'] = {
        ['intreactionCoords'] = vector3(1383.89, -2079.51, 52.0),
        ['ped'] = true,
        ['pedCoords'] = vector3(1383.89, -2079.51, 52.0),
        ['pedHeading'] = 35.78,
        ['pedHash'] = 0x49EA5685,
    },
    ['job'] = 'all',
    ['blip'] = {
        show = true,
        blipName = Locales[Config.Locale]['jobName'],
        blipType = 544,
        blipColor = 3,
        blipScale = 1.0
    },
    ['missionBlips'] = {
        [1] = {
            SetBlipSprite = 544,
            SetBlipColour = 3,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionOneBlips']
        },
        [2] = {
            SetBlipSprite = 544,
            SetBlipColour = 3,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionTwoBlips']
        },
        [3] = {
            SetBlipSprite = 544,
            SetBlipColour = 3,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionThreeBlips']
        },
        [4] = {
            SetBlipSprite = 544,
            SetBlipColour = 3,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionFourBlips']
        },
        [5] = {
            SetBlipSprite = 544,
            SetBlipColour = 3,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionFiveBlips']
        },
        ['vehicleBlips'] = {
            SetBlipSprite = 67,
            SetBlipColour = 0,
            SetBlipScale = 0.8,
        },

        ['deliveryBlips'] = {
            SetBlipSprite = 38,
            SetBlipColour = 29,
            SetBlipScale = 0.80,
        },

    },
    ['missioncompletedItems'] = {
        giveItemPlayer = false, -- true / false
        itemList = {
            { item = "sandwich", count = math.random(1, 4) },
            { item = "sandwich", count = 1 },
        },
    },
    ['drawtext'] = {
        ['deliveryVehicle'] = Locales[Config.Locale]['deliveryVehicle'],
    },
    ['regionData'] = {
        {
            regionID = 1,
            regionInfo = {
                regionName = "El Burro Heights",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 0
            },
            regionAwards = {
                money = 5000,
                xp = 1000,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                vehicle = "tolboru",
            },
            vehicleSpawnCoords = {
                vector4(1370.2, -2080.13, 52.02, 39.56),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "repairpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 2,
                    jobName = "insertpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 3,
                    jobName = "toiletchoked",
                    missionCount = {
                        minAmount = 2,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "openvalve",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "fixswitch",
                    bonusJob = true,
                    missionCount = {
                        minAmount = 3,
                        maxAmount = 3
                    },
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                }
            },
        },
        {
            regionID = 2,
            regionInfo = {
                regionName = "Alta Building",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 2
            },
            regionAwards = {
                money = 7500,
                xp = 1500,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                vehicle = "tolboru",
            },
            vehicleSpawnCoords = {
                vector4(1370.2, -2080.13, 52.02, 39.56),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "repairpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 2,
                    jobName = "insertpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 3,
                    jobName = "toiletchoked",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "openvalve",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "fixswitch",
                    bonusJob = true,
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                }
            },
        },
        {
            regionID = 3,
            regionInfo = {
                regionName = "Paleto Bay",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 4
            },
            regionAwards = {
                money = 10000,
                xp = 2000,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                vehicle = "tolboru",
            },
            vehicleSpawnCoords = {
                vector4(1370.2, -2080.13, 52.02, 39.56),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "repairpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 2,
                    jobName = "insertpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 3,
                    jobName = "toiletchoked",
                    missionCount = {
                        minAmount = 2,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "openvalve",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "fixswitch",
                    bonusJob = true,
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                }
            },
        },
        {
            regionID = 4,
            regionInfo = {
                regionName = "Redwood Lights Track",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 6
            },
            regionAwards = {
                money = 12500,
                xp = 2500,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                vehicle = "tolboru",
            },
            vehicleSpawnCoords = {
                vector4(1370.2, -2080.13, 52.02, 39.56),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "repairpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 2,
                    jobName = "insertpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 3,
                    jobName = "toiletchoked",
                    missionCount = {
                        minAmount = 2,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "openvalve",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "fixswitch",
                    bonusJob = true,
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                }
            },
        },
        {
            regionID = 5,
            regionInfo = {
                regionName = "Redwood Lights Track",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 8
            },
            regionAwards = {
                money = 12500,
                xp = 2500,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                vehicle = "tolboru",
            },
            vehicleSpawnCoords = {
                vector4(1370.2, -2080.13, 52.02, 39.56),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "repairpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 2,
                    jobName = "insertpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 3,
                    jobName = "toiletchoked",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "openvalve",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "fixswitch",
                    bonusJob = true,
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                }
            },
        },
        {
            regionID = 6,
            regionInfo = {
                regionName = "Redwood Lights Track",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 10
            },
            regionAwards = {
                money = 12500,
                xp = 2500,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                vehicle = "tolboru",
            },
            vehicleSpawnCoords = {
                vector4(1370.2, -2080.13, 52.02, 39.56),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "repairpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 2,
                    jobName = "insertpipe",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 3,
                    jobName = "toiletchoked",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "openvalve",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "fixswitch",
                    bonusJob = true,
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                }
            },
        },
    },
    ['dailyMission'] = {
        {
            name = 'jobtask_one',
            header = Locales[Config.Locale]['jobtask'] .. " 1",
            label = Locales[Config.Locale]['dailyjobone'],
            count = 50,
            xp = 2500,
            money = 1000,
        },
        {
            name = 'jobtask_two',
            header = Locales[Config.Locale]['jobtask'] .. " 2",
            label = Locales[Config.Locale]['dailyjobtwo'],
            count = 10,
            xp = 1000,
            money = 3000

        },
        {
            name = 'jobtask_three',
            header = Locales[Config.Locale]['jobtask'] .. " 3",
            label = Locales[Config.Locale]['dailyjobthree'],
            count = 10000,
            xp = 2000,
            money = 3000
        },

        {
            name = 'jobtask_four',
            header = Locales[Config.Locale]['jobtask'] .. " 4",
            label = Locales[Config.Locale]['dailyjobfour'],
            count = 20,
            xp = 2000,
            money = 3000
        },
    },
}

Config.TutorialList          = {
    { id = 1, title = Locales[Config.Locale]['tutorialTitle1'], description = Locales[Config.Locale]['tutorialDescription1'], name = 'https://r2.fivemanage.com/tM2PEEacUkwu1dgBsfJoa/video1-480p.mp4' },
    { id = 2, title = Locales[Config.Locale]['tutorialTitle2'], description = Locales[Config.Locale]['tutorialDescription2'], name = 'https://r2.fivemanage.com/tM2PEEacUkwu1dgBsfJoa/video2-480p.mp4' },
    { id = 3, title = Locales[Config.Locale]['tutorialTitle3'], description = Locales[Config.Locale]['tutorialDescription3'], name = 'https://r2.fivemanage.com/tM2PEEacUkwu1dgBsfJoa/video3-480p.mp4' },
    { id = 4, title = Locales[Config.Locale]['tutorialTitle4'], description = Locales[Config.Locale]['tutorialDescription4'], name = 'https://r2.fivemanage.com/tM2PEEacUkwu1dgBsfJoa/video4-480p.mp4' },
    { id = 5, title = Locales[Config.Locale]['tutorialTitle5'], description = Locales[Config.Locale]['tutorialDescription5'], name = 'https://r2.fivemanage.com/tM2PEEacUkwu1dgBsfJoa/video5-480p.mp4' },
    { id = 6, title = Locales[Config.Locale]['tutorialTitle6'], description = Locales[Config.Locale]['tutorialDescription6'], name = 'https://r2.fivemanage.com/tM2PEEacUkwu1dgBsfJoa/video6-480p.mp4' },
}

Config.AttachProp            = {
    veo_pipes_d = { bone = 69, xPos = -0.10980337500882, yPos = 0.0, zPos = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0 },
    veo_pipes_c = { bone = -1, xPos = 0.066625254232804, yPos = 0.176476193847, zPos = 0.5001202591005, xRot = -11.60269728722, yRot = -9.9392333795735e-17, zRot = 5.8245836525592 },
    veo_pipes_e = { bone = -1, xPos = 0.10185807778362, yPos = 0.10512230684996, zPos = 0.54538547358594, xRot = 110.52579870854, yRot = 44.583402110164, zRot = -81.507312291467 },
    veo_pipes_f = { bone = -1, xPos = 0.10995076257564, yPos = 0.14734413971728, zPos = 0.42637980688143, xRot = 15.25612243415, yRot = 87.423636694755, zRot = 61.193519096172 },
    veo_pipes_p = { bone = -1, xPos = 0.13919280500215, yPos = -0.026384197481539, zPos = 0.53245736475773, xRot = -9.1771023557932, yRot = 0, zRot = 13.613682231314 },
    veo_pipes_asd = { bone = -1, xPos = 0.103638297614, yPos = 0.1884275037985, zPos = 0.53968474838491, xRot = -16.168986263152, yRot = 4.961052230535, zRot = 16.607927577766 },
    prop_oil_valve_01 = { bone = -1, xPos = -0.0600245803696, yPos = 0.1208740150124, zPos = 0.4883093957821, xRot = -35.441278108726, yRot = 0.65117224616426, zRot = -179.0852056791 },
}

Config.JobClothes            = {
    male = {
        { jacket = 97,   texture = 0 },
        { shirt = 59,    texture = 0 },
        { arms = 0,      texture = 0 },
        { legs = 9,      texture = 6 },
        { shoes = 12,    texture = 3 },
        { mask = 0,      texture = 0 },
        { chain = 0,     texture = 11 },
        { decals = 0,    texture = 11 },
        { helmet = 0,    texture = 11 },
        { glasses = 0,   texture = 11 },
        { watches = 0,   texture = 11 },
        { bracelets = 0, texture = 11 }
    },
    female = {
        { jacket = 97,   texture = 0 },
        { shirt = 59,    texture = 0 },
        { arms = 0,      texture = 0 },
        { legs = 9,      texture = 6 },
        { shoes = 12,    texture = 3 },
        { mask = 0,      texture = 0 },
        { chain = 0,     texture = 11 },
        { decals = 0,    texture = 11 },
        { helmet = 0,    texture = 11 },
        { glasses = 0,   texture = 11 },
        { watches = 0,   texture = 11 },
        { bracelets = 0, texture = 11 }
    }
}

Config.Vehiclekey            = true

Config.GiveVehicleKey        = function(plate, model, vehicle) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if GetResourceState("cd_garage") == "started" then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif GetResourceState("qs-vehiclekeys") == "started" then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
        elseif GetResourceState("wasabi-carlock") == "started" then
            exports.wasabi_carlock:GiveKey(plate)
        elseif GetResourceState("qb-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        elseif GetResourceState("qbx-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        elseif GetResourceState('MrNewbVehicleKeys') == 'started' then
            exports.MrNewbVehicleKeys:GiveKeysByPlate(plate)
        else
            if Config.Framework == "qb" or Config.Framework == "oldqb" then
                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
            else
                print("No vehicle key system found")
            end
        end
    end
end

Config.Removekeys            = true

Config.RemoveVehiclekey      = function(plate, model, vehicle)
    if Config.Removekeys then
        if GetResourceState("cd_garage") == "started" then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif GetResourceState("qs-vehiclekeys") == "started" then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif GetResourceState("wasabi-carlock") == "started" then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif GetResourceState("qb-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        elseif GetResourceState("qbx-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        elseif GetResourceState('MrNewbVehicleKeys') == 'started' then
            exports.MrNewbVehicleKeys:RemoveKeysByPlate(plate)
        else
            if Config.Framework == "qb" or Config.Framework == "oldqb" then
                TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
            else
                print("No vehicle key system found")
            end
        end
    end
end

Config.SetVehicleFuel        = function(vehicle) -- you can change LegacyFuel export if you use another fuel system
    if GetResourceState("LegacyFuel") == "started" then
        return exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
    elseif GetResourceState("x-fuel") == "started" then
        return exports["x-fuel"]:SetFuel(vehicle, 100.0)
    elseif GetResourceState("ox_fuel") == "started" then
        return SetVehicleFuelLevel(vehicle, 100.0)
    elseif GetResourceState("cdn-fuel") == "started" then
        return exports['cdn-fuel']:SetFuel(vehicle, 100.0)
    elseif GetResourceState("ps-fuel") == "started" then
        return exports['ps-fuel']:SetFuel(vehicle, 100.0)
    elseif GetResourceState("lc_fuel") == "started" then
        exports["lc_fuel"]:SetFuel(vehicle, 100)
    else
        return SetVehicleFuelLevel(vehicle, 100.0)
    end
end

Config.RefreshSkin           = function()
    if Config.ChangeClothesSystem then
        if Config.ChangeClothesSystem then
            if Config.ClothingScript == 'fivem-appearance' then
                -- wasabi-fivem-appearance
                Core.TriggerServerCallback('esx_skin:getPlayerSkin', function(appearance)
                    exports['fivem-appearance']:setPlayerAppearance(appearance)
                end)

                --normal fivem-appearance
                -- TriggerEvent("fivem-appearance:client:reloadSkin")
            end
            if Config.ClothingScript == 'illenium-appearance' then
                TriggerEvent("illenium-appearance:client:reloadSkin")
            end
            if Config.ClothingScript == 'esx_skin' then
                TriggerEvent("esx_skin:getLastSkin", function(lastSkin)
                    TriggerEvent('skinchanger:loadSkin', lastSkin)
                end)
            end
            if Config.ClothingScript == 'qb-clothing' then
                TriggerEvent("qb-clothing:reloadSkin")
                --[[
                    // Add this code in qb-clothing client/main.lua

                    RegisterNetEvent("qb-clothing:reloadSkin")
                    AddEventHandler("qb-clothing:reloadSkin", function()
                        local playerPed = PlayerPedId()
                        local health = GetEntityHealth(playerPed)
                        reloadSkin(health)
                    end)
                --]]
                ExecuteCommand('refreshskin')
            end
        end
    end
end

Config.sendNotification      = function(messages, value)
    NuiMessage('NOTIFICATION', { message = messages, type = value })
end

-- This function is called for each player in the lobby before starting the job
-- Return true to allow the player to start, false to prevent
-- @param source: Player's server ID
-- @param owneridentifier: Player's identifier (license/steam/etc)
Config.startJobFunction      = function(source, owneridentifier)
    -- Example: Check if player has specific job
    -- local Player = GetPlayer(source)
    -- if Player and Player.job and Player.job.name == "mechanic" then
    --     return true
    -- end
    -- return false

    return true -- Default: Allow everyone
end

Config.endJobFunction        = function(source, owneridentifier, scoreAmount)
end

Config.NotificationText      = {
    ['vehicleexist'] = {
        text = Locales[Config.Locale]['vehicleexist'],
        type = "error"
    },
    ['wrongjob'] = {
        text = Locales[Config.Locale]['wrongjob'],
        type = "error"
    },
    ['jobcooldown'] = {
        text = Locales[Config.Locale]['jobcooldown'],
        type = "error"
    },
    ['delivervehicle'] = {
        text = Locales[Config.Locale]['delivervehicle'],
        type = "info"
    },
    ['playerfaraway'] = {
        text = Locales[Config.Locale]['playerfaraway'],
        type = "info"
    },
    ['lobbyfull'] = {
        text = Locales[Config.Locale]['lobbyfull'],
        type = "success"
    },
    ['jobnotstarted'] = {
        text = Locales[Config.Locale]['jobnotstarted'],
        type = "error"
    },
    ['jobalreadystarted'] = {
        text = Locales[Config.Locale]['jobalreadystarted'],
        type = "error"
    },
    ['maxlevel'] = {
        text = Locales[Config.Locale]['maxlevel'],
        type = "error"
    },
    ['joblevelnotenough'] = {
        text = Locales[Config.Locale]['joblevelnotenough'],
        type = "error"
    },
    ['playeralreadyinlobby'] = {
        text = Locales[Config.Locale]['playeralreadyinlobby'],
        type = "error"
    },

    ['missionnotselected'] = {
        text = Locales[Config.Locale]['missionnotselected'],
        type = "error"
    },
    ['playerleftlobby'] = {
        text = Locales[Config.Locale]['playerleftlobby'],
        type = "error"
    },
    ['deliverVehile'] = {
        text = Locales[Config.Locale]['deliverVehile'],
        type = "info"
    },
    ['resetJob'] = {
        text = Locales[Config.Locale]['resetJob'],
        type = "error"
    },
    ['notowner'] = {
        text = Locales[Config.Locale]['notowner'],
        type = "error"
    },
    ['usedtbxid'] = {
        text = Locales[Config.Locale]['usedtbxid'],
        type = "error"
    },
    ['successfullyExp'] = {
        text = Locales[Config.Locale]['successfullyExp'],
        type = "success"
    },
    ['notfoundtbxid'] = {
        text = Locales[Config.Locale]['notfoundtbxid'],
        type = "error"
    },
    ['getontruck'] = {
        text = Locales[Config.Locale]['getontruck'],
        type = "info"
    },
    ['alreadyarea'] = {
        text = Locales[Config.Locale]['alreadyarea'],
        type = "error"
    },
    ['alreadyHaveItem'] = {
        text = Locales[Config.Locale]['alreadyHaveItem'],
        type = "error"
    },
    ['isownernotleave'] = {
        text = Locales[Config.Locale]['isownernotleave'],
        type = "error"
    },
    ['bonusjobtask'] = {
        text = Locales[Config.Locale]['bonusjobtask'],
        type = "success"
    },
    ['invehicle'] = {
        text = Locales[Config.Locale]['invehicle'],
        type = "error"
    },

    ['cantentervehicle'] = {
        text = Locales[Config.Locale]['cantentervehicle'],
        type = "error"
    },
    ['settingssaved'] = {
        text = Locales[Config.Locale]['settingssaved'],
        type = "success"
    },

    -- fix Mission Notification
    ['successSwitch'] = {
        text = Locales[Config.Locale]['successSwitch'],
        type = "success"
    },
    ['failedSwitch'] = {
        text = Locales[Config.Locale]['failedSwitch'],
        type = "error"
    },

    -- insert Pipe Notification
    ['notCorrectPipe'] = {
        text = Locales[Config.Locale]['notCorrectPipe'],
        type = "error"
    },
    ['pipeAlreadyProcessing'] = {
        text = Locales[Config.Locale]['pipeAlreadyProcessing'],
        type = "error"
    },
    ['valveReparing'] = {
        text = Locales[Config.Locale]['valveReparing'],
        type = "error"
    },
    ['successOpenValve'] = {
        text = Locales[Config.Locale]['successOpenValve'],
        type = "success"
    },
    ['allPipesPlaced'] = {
        text = Locales[Config.Locale]['allPipesPlaced'],
        type = "success"
    },
    ['valvePlaced'] = {
        text = Locales[Config.Locale]['valvePlaced'],
        type = "success"
    },
    -- open Valve Notification
    ['successValve'] = {
        text = Locales[Config.Locale]['successValve'],
        type = "success",
    },
    ['failedValve'] = {
        text = Locales[Config.Locale]['failedValve'],
        type = "error",
    },
    -- repair Pipe Notification
    ['valveBeingUsed'] = {
        text = Locales[Config.Locale]['valveBeingUsed'],
        type = "success"
    },
    ['allPipesRepaired'] = {
        text = Locales[Config.Locale]['allPipesRepaired'],
        type = "success"
    },
    ['valveClosed'] = {
        text = Locales[Config.Locale]['valveClosed'],
        type = "success"
    },
    ['valvePressureFailed'] = {
        text = Locales[Config.Locale]['valvePressureFailed'],
        type = "error"
    },
    ['successToilet'] = {
        text = Locales[Config.Locale]['successToilet'],
        type = "success"
    },
    ['failedToilet'] = {
        text = Locales[Config.Locale]['failedToilet'],
        type = "error",
    },
}

Config.RequiredXP            = {
    [1] = 1000,
    [2] = 1500,
    [3] = 2000,
    [4] = 2500,
    [5] = 3000,
    [6] = 3500,
    [7] = 4000,
    [8] = 4500,
    [9] = 5000,
    [10] = 5500,
    [11] = 6000,
    [12] = 6500,
    [13] = 7000,
    [14] = 7500,
    [15] = 8000,
    [16] = 8500,
    [17] = 9000,
    [18] = 9500,
    [19] = 10000,
    [20] = 10500,
    [21] = 11000,
    [22] = 11500,
    [23] = 12000,
    [24] = 12500,
    [25] = 13000,
    [26] = 13500,
    [27] = 14000,
    [28] = 14500,
    [29] = 15000,
    [30] = 15500,
    [31] = 16000,
    [32] = 16500,
    [33] = 17000,
    [34] = 17500,
    [35] = 18000,
    [36] = 18500,
    [37] = 19000,
    [38] = 19500,
    [39] = 20000,
    [40] = 20500,
    [41] = 21000,
    [42] = 21500,
    [43] = 22000,
    [44] = 22500,
    [45] = 23000,
    [46] = 23500,
    [47] = 24000,
    [48] = 24500,
    [49] = 25000,
    [50] = 25500,
    [51] = 26500,
    [52] = 27500,
    [53] = 28500,
    [54] = 29500,
    [55] = 30500,
    [56] = 31500,
    [57] = 32500,
    [58] = 33500,
    [59] = 34500,
    [60] = 35500,
    [61] = 36500,
    [62] = 37500,
    [63] = 38500,
    [64] = 39500,
    [65] = 40500,
    [66] = 41500,
    [67] = 42500,
    [68] = 43500,
    [69] = 44500,
    [70] = 45500,

}

Config.Disable               = {
    onDeath = true,    -- Disable interactions on death
    onNuiFocus = true, -- Disable interactions while NUI is focused
    onVehicle = false, -- Disable interactions while in a vehicle
    onHandCuff = true, -- Disable interactions while handcuffed
}

Config.EntityOptimization    = {
    enabled = true,           -- Enable/disable entity optimization
    updateInterval = 5000,    -- Update interval in milliseconds (5 seconds)
    movementThreshold = 50.0, -- Player movement threshold to trigger update
    scanDistance = 75.0,      -- Entity scan distance (reduced from 100.0)
    checkInterval = 1000,     -- How often to check for updates (1 second)
}

Config.LanguageTitle         = {
    { value = 'en', label = 'English' },
    { value = 'tr', label = 'Turkish' },
    { value = 'ar', label = 'Arabic' },
    { value = 'de', label = 'German' },
    { value = 'fr', label = 'French' },
    { value = 'pt', label = 'Portuguese' },
    { value = 'ru', label = 'Russian' },
}
