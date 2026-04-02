Config                       = {}
Locales                      = Locales or {}

-- Framework Selection
-- 'standalone' = No framework required, money system only (no inventory script needed)
-- Other options: esx, oldesx, qb, oldqb, vrp, vrp2 (requires respective frameworks)
Config.Framework             = 'esx'

Config.Locale                = 'en'
Config.CurrencyUnit          = '$'       -- '€' -- '₺'  '$'
Config.SQL                   = "oxmysql" -- oxmysql / mysql-async / ghmattimysql

-- NOTE: Inventory setting is ignored in standalone mode (no inventory system)
Config.Inventory             =
"ox_inventory"                            -- qb_inventory / esx_inventory / ox_inventory / qs_inventory (only for framework modes)
Config.InventoryImagePath    =
"nui://ox_inventory/web/images/"         -- Inventory images path (change based on your inventory system)
Config.DefaultItemImage      =
"nui://tw-scrapyard/html/img/gun.png"     -- Default/fallback image when item image not found (from script's own img folder)
Config.ServerName            = "LORP"   -- Server Name MAX 10
Config.MoneyType             = "$"        -- Money Type
Config.MoneyType2            = "bank"     -- Money Type bank / cash
Config.InteractionHandler    = 'ox-target' -- drawtext / ox-target
Config.ExampleProfilePicture = "https://i.ibb.co/YLLNHJP/lorp-logo-main.png"

Config.Keys                  = {
    inviteAccept  = 246, -- Y key
    inviteDecline = 306, -- N key
}

Config.Command               = {
    jobReset = "scrapyardreset",
    jobLeave = "scrapyardleave",
    openTutorial = "scrapyardtutorial",
}
Config.MaxPlayersInLobby     = 4     -- Max players in lobby
Config.jobCoolDownHours      = 0     -- Job Cooldown Hours if 0 no cooldowns
Config.ChangeClothesSystem   = false -- true / false
Config.ClothingScript        =
"illenium-appearance"                        -- fivem-appearance / illenium-appearance  / esx_skin / qb-clothing / rcore_clothing
Config.TebexSystem           = false -- true / false -- There is currently no tebex system, infrastructure for future addition
Config.Debug                 = false  -- true / false
Config.DebugCommands         = false  -- true / false (debug commands like tube_status, tube_respawn etc.)
Config.jobLevelCheck         = false -- true / false


Config.DefaultUIPositions = {
    teamList = { top = '77.22vh', left = '85.94vw' },
    scoreList = { top = '2.64vh', left = '1.61vw' },
    inviteSide = { top = '2.85vh', left = '73.07vw' },
    notificationDiv = { top = '40.48vh', left = '81.54vw' },
    keyInfoSide = { top = '50%', right = '2.0833vw' },
    dumpsterInfo = { top = '1.3542vw', left = '50%' }
}

Config.Job                = {
    ['coords'] = {
        ['intreactionCoords'] = vector3(1213.85, -1251.17, 36.32),
        ['ped'] = true,
        ['pedCoords'] = vector3(1213.85, -1251.17, 36.32),
        ['pedHeading'] = 87.43,
        ['pedHash'] = 0xC5FEFADE
    },
    ['job'] = 'all',
    ['blip'] = {
        show = true,
        blipName = Locales[Config.Locale]['jobName'],
        blipType = 317,
        blipColor = 17,
        blipScale = 0.70
    },
    ['missionBlips'] = {
        [1] = {
            SetBlipSprite = 317,
            SetBlipColour = 17,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionOneBlips']
        },
        [2] = {
            SetBlipSprite = 317,
            SetBlipColour = 17,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionTwoBlips']
        },
        [3] = {
            SetBlipSprite = 317,
            SetBlipColour = 17,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionThreeBlips']
        },
        [4] = {
            SetBlipSprite = 317,
            SetBlipColour = 17,
            SetBlipScale = 0.8,
            SetBlipDisplay = 4,
            blipName = Locales[Config.Locale]['missionFourBlips']
        },
        [5] = {
            SetBlipSprite = 317,
            SetBlipColour = 17,
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
        giveItemPlayer = true, -- true / false
        dropMode = "perItem", -- "perItem" = each item rolls independently | "weightedPool" = 1 item from weighted pool
        itemList = {
            { item = "black_money", count = math.random(250, 500), chance = 25 },
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
                money = math.random(5000, 7500),
                xp = 1000,
                onlineJobExtraAwards = 1,
                bonusExtraMoney = 500,
                bonusExtraXP = 200,
            },
            missioncompletedItems = {
                giveItemPlayer = true,
                dropMode = "perItem",
                itemList = {
                    { item = "black_money", count = math.random(250, 500), chance = 50 },
                },
            },
            regionJobTask = {
                {
                    id = 1,
                    jobName = "rent_vehicle",
                    missionCount = {
                        minAmount = 1,  -- 2
                        maxAmount = 999 -- 4
                    },
                    madeCountFinish = true,
                    jobLabel = Locales[Config.Locale]['missionOneBlips']
                },
                {
                    id = 2,
                    jobName = "scrap_createobject",
                    missionCount = {
                        minAmount = -1,           -- -1 = spawn all available coordinates, positive number = spawn that many
                        maxAmount = -1,           -- -1 = spawn all available coordinates, positive number = spawn that many
                        multiplyByPlayers = false -- true: spawn count = (random between min-max) * player_count in lobby
                    },
                    madeCountFinish = true,
                    jobLabel = Locales[Config.Locale]['missionTwoBlips']
                },
                {
                    id = 3,
                    jobName = "scrap_press",
                    madeCountFinish = true,
                    jobLabel = Locales[Config.Locale]['missionThreeBlips']
                },
                {
                    id = 4,
                    jobName = "shredding_press",
                    madeCountFinish = true,
                    jobLabel = Locales[Config.Locale]['missionFourBlips']
                },
                {
                    id = 5,
                    jobName = "melt_scrap",
                    madeCountFinish = true,
                    jobLabel = Locales[Config.Locale]['missionFiveBlips']
                },
                {
                    id = 6,
                    jobName = "fill_moulds",
                    madeCountFinish = true,
                    jobLabel = Locales[Config.Locale]['missionSixBlips']
                },
            },
        },

    },

    ['craftWeaponEnabled'] = true, -- true = enabled, false = disabled (Illegal weapon crafting)
    ['craftLegalEnabled'] = true, -- true = enabled, false = disabled (Legal item crafting)
    ['sellNPCs'] = {
        -- Legal Sell NPC (Normal scrap items: iron, gold_dust)
        ['legal'] = {
            enabled = true,
            coords = vector3(1158.79, -1311.61, 33.75), -- Legal NPC location
            heading = 172.89,
            pedModel = 'a_m_m_business_01',             -- Business man model
            drawText = Locales[Config.Locale]['sell_scrap_items'],
            blip = {
                enabled = true,
                sprite = 473, -- Dollar icon
                color = 2,    -- Green
                scale = 0.7,
                name = Locales[Config.Locale]['legal_scrap_buyer']
            }
        },

        ['illegal'] = {
            enabled = true,
            coords = vector3(1165.4, -1311.26, 33.87), -- Illegal NPC location (different location)
            heading = 160.67,
            pedModel = 's_m_y_dealer_01',              -- Drug dealer model
            drawText = Locales[Config.Locale]['black_market_dealer'],
            blip = {
                enabled = true,
                sprite = 486, -- Gun icon
                color = 1,    -- Red
                scale = 0.7,
                name = Locales[Config.Locale]['black_market_dealer_blip']
            }
        }
    },

    -- Illegal Area Door Lock System
    ['illegalDoor'] = {
        enabled = true,                            -- Enable/disable door lock system (true/false)
        doorHash = 1300820402,                      -- Door model hash
        coords = vector3(1163.42, -1251.99, 34.57), -- Door coordinates
        locked = true,                              -- Initial state (true = locked, false = unlocked)
        distance = 2.0,                             -- Interaction distance
        interactionKey = 47,                        -- Key to interact with door (47 = G, 38 = E)
        authorizedJobs = {},                        -- Jobs that can toggle the door (empty = everyone can use)
        checkCarryingItem = false,                   -- Block interaction if player is carrying items
        openRotation = 2.0,                         -- Door rotation when system is disabled (open state)
        checkRequiredItem = true,                  -- Enable/disable required item check (default: false)
        requiredItem = 'lockpick_door',                      -- Item required to toggle door (only checked if checkRequiredItem = true)
        requiredAmount = 1,                         -- Amount of item required (default: 1)
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

Config.TutorialList       = {
    { id = 1,  title = Locales[Config.Locale]['tutorialTitle1'],  description = Locales[Config.Locale]['tutorialDescription1'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video1.mp4' },
    { id = 2,  title = Locales[Config.Locale]['tutorialTitle2'],  description = Locales[Config.Locale]['tutorialDescription2'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video2.mp4' },
    { id = 3,  title = Locales[Config.Locale]['tutorialTitle3'],  description = Locales[Config.Locale]['tutorialDescription3'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video3.mp4' },
    { id = 4,  title = Locales[Config.Locale]['tutorialTitle4'],  description = Locales[Config.Locale]['tutorialDescription4'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video4.mp4' },
    { id = 5,  title = Locales[Config.Locale]['tutorialTitle5'],  description = Locales[Config.Locale]['tutorialDescription5'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video5.mp4' },
    { id = 6,  title = Locales[Config.Locale]['tutorialTitle6'],  description = Locales[Config.Locale]['tutorialDescription6'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video6.mp4' },
    { id = 7,  title = Locales[Config.Locale]['tutorialTitle7'],  description = Locales[Config.Locale]['tutorialDescription7'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video7.mp4' },
    { id = 8,  title = Locales[Config.Locale]['tutorialTitle8'],  description = Locales[Config.Locale]['tutorialDescription8'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video8.mp4' },
    { id = 9,  title = Locales[Config.Locale]['tutorialTitle9'],  description = Locales[Config.Locale]['tutorialDescription9'],  name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video9.mp4' },
    { id = 10, title = Locales[Config.Locale]['tutorialTitle10'], description = Locales[Config.Locale]['tutorialDescription10'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video10.mp4' },
    { id = 11, title = Locales[Config.Locale]['tutorialTitle11'], description = Locales[Config.Locale]['tutorialDescription11'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video11.mp4' },
    { id = 12, title = Locales[Config.Locale]['tutorialTitle12'], description = Locales[Config.Locale]['tutorialDescription12'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video12.mp4' },
    { id = 13, title = Locales[Config.Locale]['tutorialTitle13'], description = Locales[Config.Locale]['tutorialDescription13'], name = 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/video13.mp4' },
}

Config.JobClothes         = {
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

Config.Vehiclekey         = true

Config.GiveVehicleKey     = function(plate, model, vehicle) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if GetResourceState("cd_garage") == "started" then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif GetResourceState("qs-vehiclekeys") == "started" then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
        elseif GetResourceState("wasabi_carlock") == "started" then
            exports.wasabi_carlock:GiveKey(plate)
        elseif GetResourceState("qb-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        elseif GetResourceState("qbx-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        elseif GetResourceState("Renewed-Vehiclekeys") == "started" then
            exports['Renewed-Vehiclekeys']:addKey(plate)
        else
            if Config.Framework == "qb" or Config.Framework == "oldqb" then
                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
            else
                print("No vehicle key system found")
            end
        end
    end
end

Config.Removekeys         = true

Config.RemoveVehiclekey   = function(plate, model, vehicle)
    if Config.Removekeys then
        if GetResourceState("cd_garage") == "started" then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif GetResourceState("qs-vehiclekeys") == "started" then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif GetResourceState("wasabi_carlock") == "started" then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif GetResourceState("qb-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        elseif GetResourceState("qbx-vehiclekeys") == "started" then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        elseif GetResourceState("Renewed-Vehiclekeys") == "started" then
            exports['Renewed-Vehiclekeys']:removeKey(plate)
        else
            if Config.Framework == "qb" or Config.Framework == "oldqb" then
                TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
            else
                print("No vehicle key system found")
            end
        end
    end
end

Config.SetVehicleFuel     = function(vehicle) -- you can change LegacyFuel export if you use another fuel system
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

Config.RefreshSkin        = function()
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
            if Config.ClothingScript == 'rcore_clothing' then
                TriggerServerEvent('rcore_clothing:reloadSkin')
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

Config.sendNotification   = function(messageData)
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
Config.startJobFunction   = function(source, owneridentifier)
    -- Example: Check if player has specific job
    -- local Player = GetPlayer(source)
    -- if Player and Player.job and Player.job.name == "mechanic" then
    --     return true
    -- end
    -- return false

    return true -- Default: Allow everyone
end
Config.endJobFunction     = function(source, owneridentifier, scoreAmount)
end

Config.NotificationText   = {
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
    ['vehicleDeliveryCompleted'] = {
        text = Locales[Config.Locale]['vehicleDeliveryCompleted'],
        type = "success"
    },
    ['vehicleDeliverySetupComplete'] = {
        text = Locales[Config.Locale]['vehicleDeliverySetupComplete'],
        type = "success"
    },

    -- Vehicle Rental
    ['rentVehicle'] = {
        text = Locales[Config.Locale]['rentVehicle'],
        type = "info"
    },
    ['rentVehicleUI'] = {
        text = Locales[Config.Locale]['rentVehicleUI'],
        type = "info"
    },
    ['rentPrompt'] = {
        text = Locales[Config.Locale]['rentPrompt'],
        type = "info"
    },
    ['returnVehicleUI'] = {
        text = Locales[Config.Locale]['returnVehicleUI'],
        type = "info"
    },
    ['returnVehiclePrompt'] = {
        text = Locales[Config.Locale]['returnVehiclePrompt'],
        type = "info"
    },
    ['wrongPlateVehicle'] = {
        text = Locales[Config.Locale]['wrongPlateVehicle'],
        type = "error"
    },
    ['bringRentalVehicle'] = {
        text = Locales[Config.Locale]['bringRentalVehicle'],
        type = "info"
    },
    ['vehicleRented'] = {
        text = Locales[Config.Locale]['vehicleRented'],
        type = "success"
    },
    ['vehicleReturned'] = {
        text = Locales[Config.Locale]['vehicleReturned'],
        type = "success"
    },
    ['vehicleRentalFailed'] = {
        text = Locales[Config.Locale]['vehicle_rental_failed'],
        type = "error"
    },
    ['vehicleReturnFailed'] = {
        text = Locales[Config.Locale]['vehicle_return_failed'],
        type = "error"
    },

    -- Item Pickup & Vehicle Interaction

    ['operationInProgress'] = {
        text = Locales[Config.Locale]['operationInProgress'],
        type = "error"
    },
    ['cannotPickupWithTongs'] = {
        text = Locales[Config.Locale]['cannotPickupWithTongs'],
        type = "error"
    },
    ['cannotPickupWithCase'] = {
        text = Locales[Config.Locale]['cannotPickupWithCase'],
        type = "error"
    },
    ['alreadyCarryingVehicleItem'] = {
        text = Locales[Config.Locale]['alreadyCarryingVehicleItem'],
        type = "error"
    },
    ['alreadyCarryingItem'] = {
        text = Locales[Config.Locale]['alreadyCarryingItem'],
        type = "error"
    },
    ['returningCase'] = {
        text = Locales[Config.Locale]['returningCase'],
        type = "info"
    },
    ['caseReturned'] = {
        text = Locales[Config.Locale]['caseReturned'],
        type = "success"
    },
    ['cannotPickupInVehicle'] = {
        text = Locales[Config.Locale]['cannotPickupInVehicle'],
        type = "error"
    },
    ['vehicleInUse'] = {
        text = Locales[Config.Locale]['vehicleInUse'],
        type = "error"
    },
    ['vehicleMoved'] = {
        text = Locales[Config.Locale]['vehicleMoved'],
        type = "error"
    },
    ['movedAwayFromVehicle'] = {
        text = Locales[Config.Locale]['movedAwayFromVehicle'],
        type = "error"
    },
    ['cannotTakeItemAbove'] = {
        text = Locales[Config.Locale]['cannotTakeItemAbove'],
        type = "error"
    },
    ['noItemsInVehicle'] = {
        text = Locales[Config.Locale]['noItemsInVehicle'],
        type = "info"
    },
    ['noItemsLeft'] = {
        text = Locales[Config.Locale]['noItemsLeft'],
        type = "info"
    },


    -- Crafting Tables
    ['cannotUseTableWithTongs'] = {
        text = Locales[Config.Locale]['cannotUseTableWithTongs'],
        type = "error"
    },
    ['cannotUseTableWithCase'] = {
        text = Locales[Config.Locale]['cannotUseTableWithCase'],
        type = "error"
    },
    ['cannotUseTableWithItem'] = {
        text = Locales[Config.Locale]['cannotUseTableWithItem'],
        type = "error"
    },
    ['cannotUseTableWithVehicleItem'] = {
        text = Locales[Config.Locale]['cannotUseTableWithVehicleItem'],
        type = "error"
    },
    ['enterTableId'] = {
        text = Locales[Config.Locale]['enterTableId'],
        type = "info"
    },
    ['tableNotFound'] = {
        text = Locales[Config.Locale]['tableNotFound'],
        type = "error"
    },
    ['bucketPositionNotFound'] = {
        text = Locales[Config.Locale]['bucketPositionNotFound'],
        type = "error"
    },
    ['fullBucketAdded'] = {
        text = Locales[Config.Locale]['fullBucketAdded'],
        type = "success"
    },
    ['bucketCreationFailed'] = {
        text = Locales[Config.Locale]['bucketCreationFailed'],
        type = "error"
    },
    ['modelLoadFailed'] = {
        text = Locales[Config.Locale]['modelLoadFailed'],
        type = "error"
    },

    -- Manual Placement
    ['selectAnotherPosition'] = {
        text = Locales[Config.Locale]['selectAnotherPosition'],
        type = "info"
    },
    ['alreadyPlacing'] = {
        text = Locales[Config.Locale]['alreadyInPlacement'],
        type = "error"
    },
    ['cannotPlaceInVehicle'] = {
        text = Locales[Config.Locale]['cannotPlaceInVehicle'],
        type = "error"
    },
    ['notLobbyMember'] = {
        text = Locales[Config.Locale]['cannotPlaceNotMember'],
        type = "error"
    },
    ['noLobbyVehicle'] = {
        text = Locales[Config.Locale]['noSuitableVehicle'],
        type = "error"
    },

    -- Press Machine
    ['pressAlreadyRunning'] = {
        text = Locales[Config.Locale]['pressMachineRunning'],
        type = "error"
    },
    ['pressBroken'] = {
        text = Locales[Config.Locale]['pressMachineBroken'],
        type = "error"
    },
    ['operationCompleted'] = {
        text = Locales[Config.Locale]['operationCompleted'],
        type = "success"
    },
    ['cannotTakeWithTongs'] = {
        text = Locales[Config.Locale]['cannotTakeWithTongs'],
        type = "error"
    },

    -- Dust & Grate
    ['cannotCleanWithCase'] = {
        text = Locales[Config.Locale]['cannotCleanDustWithCase'],
        type = "error"
    },
    ['cannotCleanWithItem'] = {
        text = Locales[Config.Locale]['cannotCleanDustHolding'],
        type = "error"
    },
    ['openGrateFirst'] = {
        text = Locales[Config.Locale]['mustOpenGrate'],
        type = "error"
    },
    ['cleanDust'] = {
        text = Locales[Config.Locale]['cleanDust'],
        type = "info"
    },


    -- Scrap Object Pickup
    ['cannotPickupScrapWithCase'] = {
        text = Locales[Config.Locale]['cannotPickupScrapWithCase'],
        type = "error"
    },
    ['noObjectToCarry'] = {
        text = Locales[Config.Locale]['noObjectToCarry'],
        type = "error"
    },

}

Config.RequiredXP         = {
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

Config.LanguageTitle      = {
    { value = 'en', label = 'English' },
    { value = 'tr', label = 'Turkish' },
    { value = 'de', label = 'German' },
    { value = 'fr', label = 'French' },
    { value = 'pt', label = 'Portuguese' },
    { value = 'ru', label = 'Russian' },
    { value = 'ar', label = 'Arabic' },
}

-- ====================================================================
-- RECONNECTION & LOBBY MANAGEMENT SYSTEM
-- ====================================================================
Config.Reconnection       = {
    -- Enable/disable reconnection system (if false, disconnected players are immediately removed from lobby)
    enabled = true,

    -- Grace period duration in seconds (0 = unlimited until lobby closes)
    -- If set to 0, players can reconnect anytime as long as lobby exists
    -- If set to a number (e.g., 300), players have 5 minutes to reconnect
    gracePeriodSeconds = 0,

    -- Maximum reconnection attempts per session (0 = unlimited)
    -- Prevents abuse where players repeatedly disconnect/reconnect
    maxReconnectAttempts = 3,

    -- Reset reconnection attempts when player successfully stays for X seconds
    -- This allows players to reconnect multiple times if they stay connected between disconnects
    resetAttemptsAfterSeconds = 300, -- 5 minutes of stable connection resets counter

    -- Enable automatic cleanup of disconnected players after grace period expires
    autoCleanupExpired = true,

    -- Owner transfer settings
    ownerTransfer = {
        -- Enable owner transfer when owner disconnects (if false, lobby closes immediately)
        enabled = true,

        -- Allow disconnected owner to rejoin as member (not owner) after transfer
        allowRejoinAsMember = true,

        -- Prioritize player with highest score for owner transfer
        prioritizeByScore = true,

        -- Minimum time (seconds) a player must be in lobby to be eligible for owner transfer
        minimumLobbyTime = 60,
    },

    -- Debug logging for reconnection system
    debugLogs = false,

    -- Notification settings
    notifications = {
        -- Notify other players when someone disconnects
        notifyOnDisconnect = true,

        -- Notify other players when someone reconnects
        notifyOnReconnect = true,

        -- Notify player how many reconnection attempts they have left
        notifyAttemptsRemaining = true,
    },
}
