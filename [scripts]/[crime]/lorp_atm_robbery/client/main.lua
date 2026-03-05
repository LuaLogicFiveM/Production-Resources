local cashObjects = {}
local atmModels = {
    ["prop_atm_01"] = vector3(0.072237, 0.50293, 0.779063),
    ["prop_atm_02"] = vector3(0.01,0.11,0.92),
    ["prop_atm_03"] = vector3(-0.14,-0.01,0.88),
    ["prop_fleeca_atm"] = vector3(0.127, 0.017, 1.0)
}

CreateThread(function()
    for _, model in ipairs(Config.AtmModels) do
        local options = {}
        if Config.EnableHacking then
            table.insert(options, {
                event = 'lorp_atm_heist:hack',
                label = locale('hack_atm_label'),
                icon = 'fas fa-laptop-code',
                model = model,
                distance = 1,
                items = Config.HackingItem,
            })
        end
        if Config.EnableDrilling then
            table.insert(options, {
                event = 'pl_atmrobbery_drill',
                label = locale('drill_atm_label'),
                icon = 'fas fa-tools',
                model = model,
                distance = 1,
                items = Config.DrillItem,
            })
        end
        exports.ox_target:addModel(model, options)
    end
end)

local function AddCashToTarget(cash,atmCoords)
    exports.ox_target:addLocalEntity(cash, {
        {
            event = "lorp_atm_heist:pickupCash",
            icon = "fas fa-money-bill-wave",
            label = locale('pick_up_cash'),
            args = atmCoords
        }
    })
end

RegisterNetEvent('lorp_atm_heist:notification')
AddEventHandler('lorp_atm_heist:notification', function(message, type)
    TriggerEvent('ox_lib:notify', {description = message, type = type or "success"})
end)

local function DispatchAlert()
    local data = exports['cd_dispatch3d']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'bcso', 'sasp'},
        coords = data.coords,
        title = '10-38 - ATM Robbery',
        message = 'A '..data.sex..' robbing a store at '..data.street,
        flash = 1,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false, 
            text = '911 - Store Robbery',
            time = 5,
            radius = 0,
        }
    })
end

local function LootATM(atmCoords)
    lib.progressBar({
        duration = Config.Hacking.LootAtmDuration,
        label = 'Collecting Cash',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'oddjobs@shop_robbery@rob_till',
            clip = 'loop', 
        }
    })
    TriggerServerEvent('lorp_atm_heist:robbery',atmCoords)
end

RegisterNetEvent('pl_atmrobbery_drill')
AddEventHandler('pl_atmrobbery_drill', function(data)
    local entity = data.entity
    local atmModel = GetEntityModel(entity)

    if entity and DoesEntityExist(entity) then
        local atmCoords = GetEntityCoords(entity)
        if not IsPedHeadingTowardsPosition(PlayerPedId(), atmCoords.x,atmCoords.y,atmCoords.z,10.0) then
			TaskTurnPedToFaceCoord(PlayerPedId(), atmCoords.x,atmCoords.y,atmCoords.z, 1500)
		end
        local enoughpolice = lib.callback.await('lorp_atm_heist:checkforpolice', false)
        if enoughpolice then
            local checktime = lib.callback.await('lorp_atm_heist:checktime', false)
            if checktime then
                Wait(1000)
                if Config.Police.notify then
                    DispatchAlert()
                end
                TriggerEvent("Drilling:Start",function(success)
                    if (success) then
                        TriggerServerEvent('lorp_atm_heist:MinigameResult', true, 'drill')
                        if not Config.MoneyDrop then
                            LootATM(atmCoords)
                        else

                            TriggerEvent('pl_atmrobbery_drill:success',entity, atmCoords, atmModel)
                        end
                    else
                      TriggerServerEvent('lorp_atm_heist:MinigameResult', false, 'drill')
                    end
                end)
            else
                TriggerEvent('lorp_atm_heist:notification', locale('wait_robbery'),'error')
            end
        else
            TriggerEvent('lorp_atm_heist:notification', locale('not_enough_police'),'error')
        end
    end
end)

RegisterNetEvent('lorp_atm_heist:hack')
AddEventHandler('lorp_atm_heist:hack', function(data)
    local entity = data.entity
    local atmModel = GetEntityModel(entity)

    if entity and DoesEntityExist(entity) then
        local atmCoords = GetEntityCoords(entity)
        if not IsPedHeadingTowardsPosition(cache.ped, atmCoords.x,atmCoords.y,atmCoords.z,10.0) then
			TaskTurnPedToFaceCoord(cache.ped, atmCoords.x,atmCoords.y,atmCoords.z, 1500)
		end
        local enoughpolice = lib.callback.await('lorp_atm_heist:checkforpolice', false)
        if enoughpolice then
            local checktime = lib.callback.await('lorp_atm_heist:checktime', false)
            if checktime then
                Wait(1000)
                if Config.Police.notify then
                    DispatchAlert()
                end
                lib.progressBar({
                    duration = Config.Hacking.InitialHackDuration,
                    label = 'Initializing Hack',
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        car = true,
                        move = true,
                        combat = true,
                    },
                    anim = {
                        dict = 'missheist_jewel@hacking',
                        clip = 'hack_loop',
                    }
                })
                TriggerEvent('lorp_atm_heist:StartMinigame', entity, atmCoords, atmModel)
            else
                TriggerEvent('lorp_atm_heist:notification', locale('wait_robbery'),'error')
            end
        else
            TriggerEvent('lorp_atm_heist:notification', locale('not_enough_police'),'error')
        end
    end
    
end)

RegisterNetEvent('lorp_atm_heist:StartMinigame', function(entity, atmCoords, atmModel)
    local function handleResult(success)
        if success then
            TriggerServerEvent('lorp_atm_heist:MinigameResult', true, 'hack')
            if Config.MoneyDrop then
                TriggerEvent("lorp_atm_heist:spitCash", entity, atmCoords, atmModel)
            else
                LootATM(atmCoords)
            end
        else
            TriggerServerEvent('lorp_atm_heist:MinigameResult', false)
            TriggerEvent('lorp_atm_heist:notification', locale('failed_robbery'), 'error')
        end
    end

    local minigame = Config.Hacking.Minigame

    if minigame == 'utk_fingerprint' then
        TriggerEvent("utk_fingerprint:Start", 1, 6, 1, function(outcome, _)
            handleResult(outcome == true)
        end)
    elseif minigame == 'ox_lib' then
        local outcome = lib.skillCheck({'easy', 'easy', { areaSize = 60, speedMultiplier = 1 }, 'easy'}, { 'w', 'a', 's', 'd' })
        handleResult(outcome == true)
    elseif minigame == 'ps-ui-circle' then
        exports['ps-ui']:Circle(function(success)
            handleResult(success)
        end, 4, 60)
    elseif minigame == 'ps-ui-maze' then
        exports['ps-ui']:Maze(function(success)
            handleResult(success)
        end, 120)
    elseif minigame == 'ps-ui-scrambler' then
        exports['ps-ui']:Scrambler(function(success)
            handleResult(success)
        end, 'numeric', 120, 1)
    elseif minigame == 'bl-ui' then
        local success = exports.bl_ui:PathFind(1, { numberOfNodes = 10, duration = 10000 })
        handleResult(success == true)
    else
        TriggerEvent('lorp_atm_heist:notification', 'Invalid minigame configuration.', 'error')
    end
end)

RegisterNetEvent("lorp_atm_heist:pickupCash")
AddEventHandler("lorp_atm_heist:pickupCash", function(data)
    local entity = data.entity
    local playerPed = PlayerPedId()
    local atmCoords
    if Config.Target == 'ox-target' then
        atmCoords = data.args
    elseif Config.Target == 'qb-target' then
        atmCoords = data.atmCoords
    end
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Wait(10)
    end

    TaskPlayAnim(playerPed, "pickup_object", "pickup_low", 8.0, -8.0, -1, 48, 0, false, false, false)

    Wait(1000)

    if DoesEntityExist(entity) then
        DeleteEntity(entity)
        TriggerServerEvent('lorp_atm_heist:robbery', atmCoords)
    end
    ClearPedTasks(playerPed)
end)

local function getModelNameFromHash(hash)
    for modelName, _ in pairs(atmModels) do
        if GetHashKey(modelName) == hash then
            return modelName
        end
    end
    return nil -- Not found
end

RegisterNetEvent("pl_atmrobbery_drill:success")
AddEventHandler("pl_atmrobbery_drill:success", function(atmEntity, atmCoords, atmModel)
    local cashModel = "hei_prop_heist_cash_pile"
    RequestModel(cashModel)
    while not HasModelLoaded(cashModel) do
        Wait(10)
    end

    local atmForward = GetEntityForwardVector(atmEntity)
    local atmHeading = GetEntityHeading(atmEntity)

    local dropOffset
    local atmModelName = getModelNameFromHash(atmModel)
    if atmModels[atmModelName] then
        dropOffset = atmModels[atmModelName]
    end
    local dropPosition = atmCoords + dropOffset
    for i = 1, Config.Reward.drill_cash_pile do 
        Wait(150)

        local cash = CreateObject(GetHashKey(cashModel), dropPosition.x, dropPosition.y, dropPosition.z, true, true, true)
        SetEntityHeading(cash, atmHeading)

        local forceX = atmForward.x * 2
        local forceY = atmForward.y * 2
        local forceZ = 0.2
        if atmModelName ~= "prop_atm_01" then
            SetEntityNoCollisionEntity(cash, atmEntity, false)
            SetEntityNoCollisionEntity(atmEntity, cash, false)
        end
        SetEntityVelocity(cash, forceX, forceY, forceZ)
        AddCashToTarget(cash,atmCoords)
        table.insert(cashObjects, cash)
    end
end)

RegisterNetEvent("lorp_atm_heist:spitCash")
AddEventHandler("lorp_atm_heist:spitCash", function(atmEntity, atmCoords, atmModel)
    local cashModel = "prop_anim_cash_pile_01"
    RequestModel(cashModel)
    while not HasModelLoaded(cashModel) do
        Wait(10)
    end

    local atmForward = GetEntityForwardVector(atmEntity)
    local atmHeading = GetEntityHeading(atmEntity)

    local dropOffset
    local atmModelName = getModelNameFromHash(atmModel)
    if atmModels[atmModelName] then
        dropOffset = atmModels[atmModelName]
    end

    local dropPosition = atmCoords + dropOffset
    for i = 1, Config.Reward.hack_cash_pile do 
        Wait(150)

        local cash = CreateObject(GetHashKey(cashModel), dropPosition.x, dropPosition.y, dropPosition.z, true, true, true)
        SetEntityHeading(cash, atmHeading)
        local forceX = atmForward.x * 2 
        local forceY = atmForward.y * 2
        local forceZ = 0.2
        if atmModelName ~= "prop_atm_01" then
            SetEntityNoCollisionEntity(cash, atmEntity, false)
            SetEntityNoCollisionEntity(atmEntity, cash, false)
        end
        
        SetEntityVelocity(cash, forceX, forceY, forceZ)
        AddCashToTarget(cash,atmCoords)
        table.insert(cashObjects, cash)
    end
end)

local function DeleteCashObjects()
    for _, cash in pairs(cashObjects) do
        exports.ox_target:removeEntity(cash)
        DeleteEntity(cash)
    end
    cashObjects = {}
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        DeleteCashObjects()
    end
end)

