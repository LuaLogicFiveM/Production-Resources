Config                       = {}
Locales                      = Locales or {}
Config.Framework             = 'esx'         -- esx, oldesx, qb, oldqb, vrp, qb = qbox -- || type qb if you are using qbox
Config.Locale                = 'en'
Config.CurrencyUnit          = '$'          -- '€' -- '₺'  '$'
Config.SQL                   = "oxmysql"    -- oxmysql / mysql-async / ghmattimysql
Config.Inventory             =
"ox_inventory"                              -- qb_inventory / esx_inventory / ox_inventory / qs_inventory / need Config.missioncompletedItems
Config.ServerName            = "LORP"     -- Server Name MAX 10
Config.MoneyType             = "$"          -- Money Type
Config.MoneyType2            = "bank"       -- Money Type bank / cash
Config.InteractionHandler    = 'ox-target' --  qb-target, drawtext,ox-target,scriptbase
Config.ExampleProfilePicture = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png"

Config.Command               = {
    jobReset = "jobresettransport",
    jobLeave = "jobleavetransport",
    openTutorial = "openTutorialtransport",
}

Config.jobCoolDownHours      = 0             -- Job Cooldown Hours if 0 no cooldowns
Config.ChangeClothesSystem   = false         -- true / false
Config.ClothingScript        = "illenium-appearance" -- fivem-appearance / illenium-appearance  / esx_skin / qb-clothing
Config.TebexSystem           = false          -- true / false -- There is currently no tebex system, infrastructure for future addition
Config.Debug                 = false         -- true / false
Config.jobLevelCheck         = false         -- true / false

Config.MaxPlayersInLobby     = 4             -- max [4] Max players in lobby

Config.DefaultUIPositions    = {
    teamList = { top = '77.22vh', left = '85.94vw' },
    scoreList = { top = '2.64vh', left = '1.61vw' },
    inviteSide = { top = '2.85vh', left = '73.07vw' },
    notificationDiv = { top = '40.48vh', left = '81.54vw' }
}

Config.Job                   = {
    ['coords'] = {
        ['intreactionCoords'] = vector3(-424.27, -2789.87, 6.53),
        ['ped'] = true,
        ['pedCoords'] = vector3(-424.27, -2789.87, 6.53),
        ['pedHeading'] = 312.55,
        ['pedHash'] = 0x9FC37F22
    },
    ['job'] = 'all',
    ['blip'] = {
        show = true,
        blipName = Locales[Config.Locale]['jobName'],
        blipType = 67,
        blipColor = 5,
        blipScale = 0.55
    },
    ['missionBlips'] = {
        [1] = {
            SetBlipSprite = 1,
            SetBlipColour = 5,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionOneBlips']
        },
        [2] = {
            SetBlipSprite = 1,
            SetBlipColour = 5,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionTwoBlips']
        },
        [3] = {
            SetBlipSprite = 1,
            SetBlipColour = 5,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionThreeBlips']
        },
        [4] = {
            SetBlipSprite = 1,
            SetBlipColour = 5,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionFourBlips']
        },
        [5] = {
            SetBlipSprite = 1,
            SetBlipColour = 5,
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
                money = math.random(10000, 15000),
                xp = 1000,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 5000,
                bonusExtraXP = 250,
            },
            regionJobVehicle = {
                truckVehicle = "tolpounder",
                forkliftVehicle = "forklift",
            },
            vehicleSpawnCoords = {
                truckCoords = vector4(-448.08, -2787.84, 6.07, 47.42),
                extraTruckCoords = vector4(-452.5, -2793.1, 6.08, 47.88),
                forkliftCoords = vector4(-496.69, -2807.83, 6.0, 127.03),
                extraForkliftCoords = vector4(-501.88, -2814.19, 6.1, 144.04),
            },

            regionJobTask = {
                {
                    id = 1,
                    jobName = "transport_trailer_loading",
                    missionCount = {
                        minAmount = 2, -- 2
                        maxAmount = 4  -- 4
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 2,
                    jobName = "transport_delivery_truck",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 3,
                    jobName = "transport_open_box",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "transport_delivery_furniture",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                }
            },
        },
        {
            regionID = 2,
            regionInfo = {
                regionName = "El Burro Heights",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 2
            },
            regionAwards = {
                money = math.random(15000, 20000),
                xp = 3000,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                truckVehicle = "tolpounder",
                forkliftVehicle = "forklift",
            },
            vehicleSpawnCoords = {
                truckCoords = vector4(-458.68, -2796.18, 6.07, 44.24),
                extraTruckCoords = vector4(-463.57, -2799.6, 6.07, 45.48),
                forkliftCoords = vector4(-496.75, -2835.44, 5.45, 42.24),
                extraForkliftCoords = vector4(-498.55, -2838.15, 5.45, 50.68),
            },

            regionJobTask = {
                {
                    id = 1,
                    jobName = "transport_trailer_loading",
                    missionCount = {
                        minAmount = 4,
                        maxAmount = 8
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 2,
                    jobName = "transport_delivery_truck",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 3,
                    jobName = "transport_open_box",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "transport_delivery_furniture",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                }
            },
        },
        {
            regionID = 3,
            regionInfo = {
                regionName = "El Burro Heights",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 4
            },
            regionAwards = {
                money = math.random(20000, 25000),
                xp = 5000,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                truckVehicle = "tolpounder",
                forkliftVehicle = "forklift",
            },
            vehicleSpawnCoords = {
                truckCoords = vector4(-468.53, -2804.3, 6.06, 44.91),
                extraTruckCoords = vector4(-471.14, -2810.11, 6.07, 43.71),
                forkliftCoords = vector4(-508.24, -2847.52, 5.45, 49.09),
                extraForkliftCoords = vector4(-503.69, -2846.63, 5.46, 43.1),
            },

            regionJobTask = {
                {
                    id = 1,
                    jobName = "transport_trailer_loading",
                    missionCount = {
                        minAmount = 4,
                        maxAmount = 8
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 2,
                    jobName = "transport_delivery_truck",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 3,
                    jobName = "transport_open_box",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "transport_delivery_furniture",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                }
            },
        },
        {
            regionID = 4,
            illegalMission = true,
            regionInfo = {
                regionName = "El Burro Heights",
                regionJobTask = Locales[Config.Locale] and Locales[Config.Locale]['regionJobTask'],
                regionImage = "region.png",
                regionMinimumLevel = 6
            },
            regionAwards = {
                money = 25000,
                xp = 10000,
                onlineJobExtraAwards = 2,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            regionJobVehicle = {
                truckVehicle = "tolpounder",
                forkliftVehicle = "forklift",
            },
            vehicleSpawnCoords = {
                truckCoords = vector4(-480.32, -2819.44, 6.07, 42.13),
                extraTruckCoords = vector4(-485.16, -2822.4, 6.08, 46.02),
                forkliftCoords = vector4(-487.09, -2833.12, 5.45, 42.92),
                extraForkliftCoords = vector4(-487.76, -2828.99, 5.46, 45.93),
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "transport_trailer_loading",
                    missionCount = {
                        minAmount = 2,
                        maxAmount = 2
                    },
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 2,
                    jobName = "transport_delivery_truck",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 3,
                    jobName = "transport_open_box",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "transport_delivery_furniture",
                    missionCount = {
                        minAmount = 1,
                        maxAmount = 1
                    },
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
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
    { id = 1, title = Locales[Config.Locale]['tutorialTitle1'], description = Locales[Config.Locale]['tutorialDescription1'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/1video480p.mp4' },
    { id = 2, title = Locales[Config.Locale]['tutorialTitle2'], description = Locales[Config.Locale]['tutorialDescription2'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/2video480p.mp4' },
    { id = 3, title = Locales[Config.Locale]['tutorialTitle3'], description = Locales[Config.Locale]['tutorialDescription3'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/3video480p.mp4' },
    { id = 4, title = Locales[Config.Locale]['tutorialTitle4'], description = Locales[Config.Locale]['tutorialDescription4'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/4video480p.mp4' },
    { id = 5, title = Locales[Config.Locale]['tutorialTitle5'], description = Locales[Config.Locale]['tutorialDescription5'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/5video480p.mp4' },
    { id = 6, title = Locales[Config.Locale]['tutorialTitle6'], description = Locales[Config.Locale]['tutorialDescription6'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/6video480p.mp4' },
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
        { jacket = 239,  texture = 8 },
        { shirt = 15,    texture = 0 },
        { arms = 0,      texture = 0 },
        { legs = 35,     texture = 0 },
        { shoes = 26,    texture = 0 },
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
    local result = false
    if GetResourceState("LegacyFuel") == "started" then
        result = exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
    elseif GetResourceState("x-fuel") == "started" then
        result = exports["x-fuel"]:SetFuel(vehicle, 100.0)
    elseif GetResourceState("ox_fuel") == "started" then
        result = SetVehicleFuelLevel(vehicle, 100.0)
    elseif GetResourceState("cdn-fuel") == "started" then
        result = exports['cdn-fuel']:SetFuel(vehicle, 100.0)
    elseif GetResourceState("ps-fuel") == "started" then
        result = exports['ps-fuel']:SetFuel(vehicle, 100.0)
    else
        result = SetVehicleFuelLevel(vehicle, 100.0)
    end

    return result
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
            if Config.ClothingScript == 'rcore_clothing' then
                TriggerServerEvent('rcore_clothing:reloadSkin')
            end
        end
    end
end

Config.sendNotification      = function(messageData)
    local message, messageType
    if type(messageData) == "table" then
        message = messageData.text
        messageType = messageData.type or "info"
    elseif type(messageData) == "string" then
        for key, value in pairs(Config.NotificationText) do
            if value.text == messageData then
                message = value.text
                messageType = value.type or "info"
                break
            end
        end

        if not message then
            message = messageData
            messageType = "info"
        end
    end

    NuiMessage('NOTIFICATION', { message = message, type = messageType or "info" })
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

    ['systemReady'] = {
        text = Locales[Config.Locale]['systemReady'],
        type = "success"
    },
    ['vehicleDeliveryCompleted'] = {
        text = Locales[Config.Locale]['vehicleDeliveryCompleted'],
        type = "success"
    },
    ['vehicleDeliverySetupComplete'] = {
        text = Locales[Config.Locale]['vehicleDeliverySetupComplete'],
        type = "success"
    },
    ['vehicleDeliverySetupFailed'] = {
        text = Locales[Config.Locale]['vehicleDeliverySetupFailed'],
        type = "error"
    },

    -- Transport messages
    ['forkliftLoadingInfo'] = {
        text = Locales[Config.Locale]['forkliftLoadingInfo'],
        type = "info"
    },
    ['boxPickedUpSuccess'] = {
        text = Locales[Config.Locale]['boxPickedUpSuccess'],
        type = "success"
    },
    ['boxAlreadyOpening'] = {
        text = Locales[Config.Locale]['boxAlreadyOpening'],
        type = "error"
    },
    ['waitSlowDown'] = {
        text = Locales[Config.Locale]['waitSlowDown'],
        type = "error"
    },
    ['deliveryInstructions'] = {
        text = Locales[Config.Locale]['deliveryInstructions'],
        type = "info"
    },
    ['allTrucksAlreadyParked'] = {
        text = Locales[Config.Locale]['allTrucksAlreadyParked'],
        type = "error"
    },
    ['allTrucksParkedSuccess'] = {
        text = Locales[Config.Locale]['allTrucksParkedSuccess'],
        type = "success"
    },
    ['otherTrucksReminder'] = {
        text = Locales[Config.Locale]['otherTrucksReminder'],
        type = "info"
    },
    ['multipleTruckParkInstruction'] = {
        text = Locales[Config.Locale]['multipleTruckParkInstruction'],
        type = "info"
    },
    ['singleTruckParkInstruction'] = {
        text = Locales[Config.Locale]['singleTruckParkInstruction'],
        type = "info"
    },

    -- Forklift messages
    ['forkliftExitFirst'] = {
        text = Locales[Config.Locale]['forkliftExitFirst'],
        type = "info"
    },
    ['forkliftNeedGetInOut'] = {
        text = Locales[Config.Locale]['forkliftNeedGetInOut'],
        type = "error"
    },
    ['validForkliftNotFound'] = {
        text = Locales[Config.Locale]['validForkliftNotFound'],
        type = "error"
    },
    ['forkliftAlreadyAttached'] = {
        text = Locales[Config.Locale]['forkliftAlreadyAttached'],
        type = "error"
    },
    ['forkliftPositionWrong'] = {
        text = Locales[Config.Locale]['forkliftPositionWrong'],
        type = "error"
    },
    ['forkliftAttachRequested'] = {
        text = Locales[Config.Locale]['forkliftAttachRequested'],
        type = "info"
    },
    ['noSuitablePosition'] = {
        text = Locales[Config.Locale]['noSuitablePosition'],
        type = "error"
    },
    ['forkliftNotFound'] = {
        text = Locales[Config.Locale]['forkliftNotFound'],
        type = "error"
    },
    ['attachPointNotFound'] = {
        text = Locales[Config.Locale]['attachPointNotFound'],
        type = "error"
    },
    ['positionAlreadyOccupied'] = {
        text = Locales[Config.Locale]['positionAlreadyOccupied'],
        type = "error"
    },
    ['forkliftAttachedSuccess'] = {
        text = Locales[Config.Locale]['forkliftAttachedSuccess'],
        type = "success"
    },
    ['noValidForkliftToDetach'] = {
        text = Locales[Config.Locale]['noValidForkliftToDetach'],
        type = "error"
    },
    ['allForkliftsDetachedNoTrailer'] = {
        text = Locales[Config.Locale]['allForkliftsDetachedNoTrailer'],
        type = "warning"
    },
    ['vehicleNotFound'] = {
        text = Locales[Config.Locale]['vehicleNotFound'],
        type = "error"
    },
    ['forkliftMarkersVisible'] = {
        text = Locales[Config.Locale]['forkliftMarkersVisible'],
        type = "info"
    },
    ['forkliftMarkersHidden'] = {
        text = Locales[Config.Locale]['forkliftMarkersHidden'],
        type = "info"
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

Config.LanguageTitle         = {
    { value = 'en', label = 'English' },
    { value = 'tr', label = 'Turkish' },
    { value = 'de', label = 'German' },
    { value = 'fr', label = 'French' },
    { value = 'pt', label = 'Portuguese' },
    { value = 'ru', label = 'Russian' },
}

Config.attachBoneID          = 72

Config.trailerOffsetList     = {
    { x = 0.852605,  y = -0.298814, z = 0.226404, id = 1,     front = false },
    { x = -0.805852, y = -0.298814, z = 0.226404, id = 2,     front = true },
    { x = 0.852605,  y = -2.313935, z = 0.226404, id = 3,     front = false },
    { x = -0.805852, y = -2.313935, z = 0.226404, id = 4,     front = true },
    { x = 0.852605,  y = -0.298814, z = 1.578694, id = 5,     front = false },
    { x = -0.805852, y = -0.298814, z = 1.578694, id = 6,     front = true },
    { x = 0.852605,  y = -2.313935, z = 1.578694, id = 7,     front = false },
    { x = -0.805852, y = -2.313935, z = 1.578694, id = 8,     front = true },
    { x = 0.003373,  y = -6.066750, z = 0.616759, forkid = 1, forklift = true },
}

Config.AttachEntityCoords    = {
    default = { bone = 61, xPos = 0.47349669522805, yPos = -0.19379999092237, zPos = -0.013656052553275, xRot = -43.010151498465, yRot = -55.048333906983, zRot = 5.8805530782743 },
    prop_chair_01a = { bone = 61, xPos = 0.47349669522805, yPos = -0.19379999092237, zPos = -0.013656052553275, xRot = -43.010151498465, yRot = -55.048333906983, zRot = 5.8805530782743 },
    v_res_m_armchair = { bone = -1, xPos = -0.049261728299598, yPos = 0.62508276145068, zPos = -0.085980604455681, xRot = 0, yRot = 0, zRot = 0 },
    apa_mp_h_stn_chairarm_02 = { bone = -1, xPos = -0.058271732051594, yPos = 1.0167816468096, zPos = -0.21793057988849, xRot = 0, yRot = 0, zRot = 0 },
    prop_yaught_chair_01 = { bone = -1, xPos = -0.00030360744324298, yPos = 0.58991504888641, zPos = 0.57405603965735, xRot = 0, yRot = 0, zRot = 0 },
    prop_chair_02 = { bone = -1, xPos = -0.030511647025605, yPos = 0.43732729501283, zPos = -0.34793702767999, xRot = 0, yRot = 0, zRot = 0 },
    prop_chair_03 = { bone = -1, xPos = -0.055478577650433, yPos = 0.54063230234128, zPos = -0.32704680153742, xRot = 0, yRot = 0, zRot = 0 },
    prop_chair_01b = { bone = -1, xPos = -0.076176085399993, yPos = 0.60664481176064, zPos = -0.40166600335167, xRot = 0, yRot = 0, zRot = 0 },
    --Mission 1

    prop_bench_01b = { bone = -1, xPos = -0.0013073564781507, yPos = 0.63923810227709, zPos = -0.18799727375261, xRot = 0, yRot = 0, zRot = 0 },
    prop_bench_01a = { bone = -1, xPos = 0.011856944311376, yPos = 0.20952302600693, zPos = -0.26698992694612, xRot = 14.412201183942, yRot = 1.0469216673302, zRot = -175.84835530492 },
    v_ind_meatboxsml = { bone = -1, xPos = -0.0090688108211907, yPos = 0.40097237540322, zPos = 0.092886124463358, xRot = 0, yRot = 0, zRot = 0 },
    prop_tv_cabinet_03 = { bone = -1, xPos = 0.0, yPos = 0.41638962850591, zPos = 0.034031537780843, xRot = 0, yRot = 0, zRot = 0 },
    v_corp_offchair = { bone = -1, xPos = -0.049601344964799, yPos = 0.60363444397267, zPos = -0.24866129256545, xRot = 31.067919104292, yRot = 0, zRot = 0 },
    p_clb_officechair_s = { bone = -1, xPos = -0.049601344964799, yPos = 0.60363444397267, zPos = -0.24866129256545, xRot = 31.067919104292, yRot = 0, zRot = 0 },
    prop_cementmixer_02a = { bone = -1, xPos = -0.061071041070363, yPos = 1.1124199828196, zPos = -1.1426439164107, xRot = -1.670177174125, yRot = -1.3574099154678, zRot = 3.0991955287967 },
    prop_wheelbarrow02a = { bone = -1, xPos = -0.060892184136378, yPos = 0.71732085653631, zPos = -0.25513088569604, xRot = 0, yRot = 0, zRot = 95.781216867238 },
    prop_fire_exting_1a = { bone = -1, xPos = -0.36837068203238, yPos = 0.3784415077497, zPos = 0.07174601989667, xRot = -1.8943393692525, yRot = 80.662112072319, zRot = -5.5734598162199 },
    v_ind_rc_shovel = { bone = -1, xPos = -0.26600606441525, yPos = 0.34636467471989, zPos = 0.051917839694118, xRot = -135.76781044891, yRot = -55.25576397285, zRot = -89.240431846364 },
    prop_tool_shovel3 = { bone = -1, xPos = 0.28670214017177, yPos = 0.42933696541723, zPos = 0.043280360629215, xRot = -68.118863473717, yRot = -4.8070410562659, zRot = 97.602742426486 },
    prop_tool_box_01 = { bone = -1, xPos = -0.05429082588023, yPos = 0.40840252140706, zPos = 0.024424211104177, xRot = 0, yRot = 0, zRot = 0 },

    v_res_fa_chair02 = { bone = -1, xPos = -0.05431384364897, yPos = 0.64751787117384, zPos = -0.1292074290774, xRot = 48.906037353826, yRot = -0.0072739571363973, zRot = -1.5320576279292 },
    v_med_hosptable = { bone = -1, xPos = -0.015597460705976, yPos = 0.43712956107485, zPos = -0.13484785015971, xRot = -64.683825433471, yRot = 69.86533006695, zRot = 64.648295353681 },
    prop_tv_cabinet_05 = { bone = -1, xPos = 0.00090084123564793, yPos = 0.63476874552709, zPos = 0.018491138850727, xRot = 20.123558445494, yRot = 0, zRot = 0 },
    prop_wheel_tyre = { bone = -1, xPos = -0.038803399726817, yPos = 0.35823293535516, zPos = 0.13480557285313, xRot = 38.254944407197, yRot = 0, zRot = 0 },
    prop_tool_box_04 = { bone = -1, xPos = -0.060221988575222, yPos = 0.37468712787304, zPos = 0.078005316106807, xRot = 0, yRot = 0, zRot = 0 },
    prop_tool_broom = { bone = -1, xPos = -0.099017082165233, yPos = 0.35464677386099, zPos = 0.15049749067721, xRot = 4.0618529872228, yRot = -79.46893358168, zRot = -4.1090585900001 },
    prop_tool_rake = { bone = -1, xPos = -0.055758797919225, yPos = 0.38926051921437, zPos = 0.10206583415697, xRot = -167.38181002057, yRot = 82.706951852639, zRot = 98.516438033931 },

    prop_box_ammo03a = { bone = -1, xPos = -0.025969929575808, yPos = 0.60419125812969, zPos = 0.034852628260122, xRot = 0, yRot = 0, zRot = 0 },
    ch_prop_ch_box_ammo_06a = { bone = -1, xPos = -0.079105075415214, yPos = 0.42946380317623, zPos = 0.10777711527785, xRot = 0, yRot = 0, zRot = 0 },
    hei_prop_heist_weed_block_01 = { bone = -1, xPos = -0.068743137037018, yPos = 0.31456260778065, zPos = 0.10598441058411, xRot = 0, yRot = 0, zRot = 0 },
    bkr_prop_weed_bigbag_03a = { bone = -1, xPos = -0.064177809200032, yPos = 0.52557273800381, zPos = 0.020276954317355, xRot = 0, yRot = 0, zRot = 0 },
}

Config.DrawMarker            = {
    dropBoxesOnTrailer = {
        value = 27,
        color = { r = 0, g = 255, b = 0, a = 128 },
    },
    vehicleMarker = {
        value = 2,
        color = { r = 255, g = 255, b = 255, a = 210 },
    },
    dropBoxesOnTrailerDelivery = {
        value = 30,
    },
    pickupBoxMarker = {
        value = 25,
        color = { r = 139, g = 69, b = 19, a = 80 },
    }
}

-- ===================================
-- POLICE ALERT SYSTEM CONFIGURATION
-- ===================================
Config.PoliceAlert           = {
    enabled = true,   -- Enable/disable police notification system
    testMode = false, -- Test mode: true = send precise notification, false = according to chance ratio

    -- Bildirim Ayarları
    settings = {
        alertChance = 75,          -- Chance of sending notifications in normal mode (1-100)
        cooldownMinutes = 2,       -- Cooldown between notifications (minutes)
        minPlayersForAlert = 0,    -- Minimum number of police (for notification)
        alertIntervalMinutes = 10, -- How many minutes of notification during illegal operation
    },

    -- Supported Dispatch Systems
    dispatchSystem = "ps-dispatch", -- ps-dispatch, ls-dispatch, fl-dispatch, bixbi_dispatch, cd_dispatch, linden_outlawalert, custom

    -- Dispatch System Functions (changes automatically)
    dispatchExports = {
        ["ps-dispatch"] = {
            resourceName = "ps-dispatch",
            customAlert = function(data)
                exports["ps-dispatch"]:CustomAlert({
                    coords = data.coords,
                    message = data.message,
                    dispatchCode = data.dispatchCode,
                    description = data.description,
                    radius = data.radius or 0,
                    sprite = data.sprite or 161,
                    color = data.color or 1,
                    scale = data.scale or 1.0,
                    length = data.length or 5,
                    plate = data.plate,
                    gender = data.gender,
                    model = data.model,
                    firstColor = data.firstColor,
                    heading = data.heading,
                    priority = data.priority or 2
                })
            end
        },

        ["ls-dispatch"] = {
            resourceName = "ls-dispatch",
            customAlert = function(data)
                exports["ls-dispatch"]:CustomAlert({
                    coords = data.coords,
                    message = data.message,
                    dispatchCode = data.dispatchCode,
                    description = data.description,
                    radius = data.radius or 0,
                    sprite = data.sprite or 161,
                    color = data.color or 1,
                    scale = data.scale or 1.0,
                    length = data.length or 5,
                    plate = data.plate,
                    gender = data.gender,
                    model = data.model,
                    firstColor = data.firstColor,
                    heading = data.heading,
                    priority = data.priority or 2
                })
            end
        },

        ["fl-dispatch"] = {
            resourceName = "fl-dispatch",
            customAlert = function(data)
                local currentPos = data.coords
                TriggerServerEvent("dispatch:server:notify", {
                    dispatchcodename = "illegal_transport",
                    dispatchCode = data.dispatchCode,
                    firstStreet = data.locationInfo,
                    gender = data.gender,
                    model = data.model,
                    plate = data.plate,
                    priority = data.priority or 2,
                    firstColor = data.firstColor,
                    automaticGunfire = false,
                    origin = {
                        x = currentPos.x,
                        y = currentPos.y,
                        z = currentPos.z
                    },
                    dispatchMessage = data.message,
                    job = { "police" }
                })
            end
        },

        ["bixbi_dispatch"] = {
            resourceName = "bixbi_dispatch",
            customAlert = function(data)
                TriggerEvent('bixbi_dispatch:Add', GetPlayerServerId(PlayerId()), 'police', 'illegal_transport',
                    data.message, data.coords)
            end
        },

        ["cd_dispatch"] = {
            resourceName = "cd_dispatch",
            customAlert = function(data)
                local dispatchData = {
                    message = data.message,
                    codeName = data.dispatchCode,
                    code = data.dispatchCode,
                    icon = 'fas fa-truck',
                    priority = data.priority or 2,
                    coords = data.coords,
                    street = data.locationInfo,
                    gender = data.gender,
                    model = data.model,
                    plate = data.plate,
                    color = data.firstColor,
                    heading = data.heading,
                    jobs = { 'police' }
                }
                TriggerServerEvent('cd_dispatch:AddNotification', dispatchData)
            end
        },

        ["linden_outlawalert"] = {
            resourceName = "linden_outlawalert",
            customAlert = function(data)
                local alertData = {
                    displayCode = data.dispatchCode,
                    description = data.message,
                    isImportant = data.priority >= 3 and 1 or 0,
                    recipientList = { 'police' },
                    length = (data.length or 5) * 1000,
                    infoM = 'fa-truck',
                    info = data.description
                }
                local dispatchData = {
                    dispatchData = alertData,
                    caller = 'Sivil',
                    coords = data.coords
                }
                TriggerEvent('wf-alerts:svNotify', dispatchData)
            end
        },

        ["custom"] = {
            resourceName = "custom",
            customAlert = function(data)
                -- Kullanıcılar kendi sistemlerini buraya ekleyebilir
                print("Özel dispatch sistemi için kodu kendin ekle!")
                print("Data:", json.encode(data))
            end
        }
    },

    -- Alert Messages and Codes
    alerts = {
        suspiciousActivity = {
            code = "10-66",
            priority = 2,
            message = Locales[Config.Locale]['policeAlertSuspiciousActivity'],
            description = Locales[Config.Locale]['policeAlertSuspiciousActivityDesc'],
            sprite = 161,
            color = 1,
            length = 5
        },

        illegalTransport = {
            code = "10-71",
            priority = 3,
            message = Locales[Config.Locale]['policeAlertIllegalTransport'],
            description = Locales[Config.Locale]['policeAlertIllegalTransportDesc'],
            sprite = 67,
            color = 1,
            length = 8
        },

        speedingVehicle = {
            code = "10-11",
            priority = 1,
            message = Locales[Config.Locale]['policeAlertSpeedingVehicle'],
            description = Locales[Config.Locale]['policeAlertSpeedingVehicleDesc'],
            sprite = 380,
            color = 17,
            length = 3
        }
    },

    -- Vehicle Information Details
    vehicleDetails = {
        includeSpeed = true,     -- Hız bilgisi dahil et
        includePlate = true,     -- Plaka bilgisi dahil et
        includeColor = true,     -- Renk bilgisi dahil et
        includeModel = true,     -- Araç modeli dahil et
        includeDoorCount = true, -- Kapı sayısı dahil et
        includeHeading = true,   -- Yön bilgisi dahil et
        includeGender = true,    -- Şoför cinsiyeti dahil et
    },

    -- Alert Messages are now in Locales

    -- Police Search and Lock System
    policeSearch = {
        enabled = true, -- Enable/disable police search system

        -- Search Settings
        searchSettings = {
            searchTime = 8000,     -- Search time (milliseconds)
            illegalChance = 65,    -- Chance of finding illegal items (%)
            searchDistance = 4.0,  -- Search distance
            impoundDistance = 4.0, -- Impound distance
        },

        -- Police Jobs (expandable)
        policeJobs = { 'police', 'sheriff', 'state', 'lspd', 'bcso', 'sahp', 'park', 'pd', 'policia' },

        -- Search Results Messages are now in Locales
        searchResults = {
            searching = Locales[Config.Locale]['policeSearching'],
            clean = Locales[Config.Locale]['policeSearchClean'],
            illegal = Locales[Config.Locale]['policeSearchIllegal'],
            alreadySearched = Locales[Config.Locale]['policeSearchAlreadySearched'],
            impounded = Locales[Config.Locale]['policeSearchImpounded'],
            operationFailed = Locales[Config.Locale]['policeSearchOperationFailed'],
            notPolice = Locales[Config.Locale]['policeSearchNotPolice'],
            vehicleNotFound = Locales[Config.Locale]['policeSearchVehicleNotFound'],
            tooFarAway = Locales[Config.Locale]['policeSearchTooFarAway'],
            playerNotInArea = Locales[Config.Locale]['policeSearchPlayerNotInArea'],
            searchInProgress = Locales[Config.Locale]['policeSearchInProgress'],
            impoundInProgress = Locales[Config.Locale]['policeSearchImpoundInProgress'],
            jobReset = Locales[Config.Locale]['policeSearchJobReset'],
        },
        illegalItems = {
            Locales[Config.Locale]['illegalWeapons'],
            Locales[Config.Locale]['illegalDrugs'],
        }
    }
}

-- ===================================

Config.EntityOptimization    = {
    enabled = true,           -- Enable/disable entity optimization
    updateInterval = 5000,    -- Update interval in milliseconds (5 seconds)
    movementThreshold = 50.0, -- Player movement threshold to trigger update
    scanDistance = 75.0,      -- Entity scan distance (reduced from 100.0)
    checkInterval = 1000,     -- How often to check for updates (1 second)
}
