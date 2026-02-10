local PlayerData = nil

function loadFramework()
    while GetResourceState('es_extended') ~= 'started' do
        Wait(50)
    end

    ESX = exports['es_extended']:getSharedObject()
    PlayerData = ESX.GetPlayerData()
    hunger, thirst = 100

    AddEventHandler("esx_status:onTick", function(data)
        local values = {}
        for i = 1, #data do
            if data[i].name == "thirst" then
                values.thirst = math.floor(data[i].percent)
            end
            if data[i].name == "hunger" then
                values.hunger = math.floor(data[i].percent)
            end
        end
        hunger = values.hunger
        thirst = values.thirst
    end)

    RegisterNetEvent("esx:setAccountMoney", function(accountNew)
        if accountNew.name == "money" then
            if PlayerData.accounts then
                for _, account in pairs(PlayerData.accounts) do
                    if account.name == 'money' then
                        account.money = accountNew.money
                    end
                end
            end
        elseif accountNew.name == "bank" then
            if PlayerData.accounts then
                for _, account in pairs(PlayerData.accounts) do
                    if account.name == 'bank' then
                        account.money = accountNew.money
                    end
                end
            end
        end
    end)

    RegisterNetEvent("esx:setJob")
    AddEventHandler("esx:setJob", function(job)
        PlayerData.job = job
    end)
end

local ox_inventory = exports.ox_inventory
local lorp_packed = exports.lorp_packed
--local gangs = exports['FearX-Turfs']

local function GetLocalTime12Hour(hour, minute)
    local suffix = "AM"
    if hour >= 12 then
        suffix = "PM"
    end

    local hour12 = hour % 12
    if hour12 == 0 then
        hour12 = 12
    end

    local minuteStr = string.format("%02d", minute)

    return string.format("%d:%s %s", hour12, minuteStr, suffix)
end

local lastDataTable = {}
function updateHud()
    if (triggeredUpdateHud) then return end 
    triggeredUpdateHud = true
    loadFramework()
    CreateThread(function()
        local playerServerId = GetPlayerServerId(PlayerId())
        while true do
            Wait(cfg.UpdateTimeInterval)

            local year, month, day, hour, minute, second = GetLocalTime()
            dataTable = {}
            dataTable['health'] = GetEntityHealth(ped)
            if dataTable['health'] < 0 then dataTable['health'] = 0 end

            dataTable['mic'] = LocalPlayer.state['proximity'] and LocalPlayer.state['proximity'].distance or 1.5
            dataTable['playerCount'] = GlobalState.playerCount or 0
            dataTable['hour'] = GetClockHours()
            dataTable['playerId'] = playerServerId

            if PlayerData and PlayerData.job then
                dataTable['health'] = math.floor((GetEntityHealth(ped) - 100) / 100 * 200)
                dataTable['hunger'] = hunger
                dataTable['thirst'] = thirst

                local bank = 0

                if PlayerData.accounts then
                    for _, account in pairs(PlayerData.accounts) do
                        if account.name == 'bank' then
                            bank = account.money
                        end
                    end
                end

                dataTable['postal'] = lorp_packed and lorp_packed:getNearestPostal() or 'N/A'
                dataTable['wallet'] = ox_inventory:Search('count', 'money')
                dataTable['walletDirty'] = ox_inventory:Search('count', 'black_money')
                dataTable['bank'] = bank
                dataTable['userJob'] = ('%s - %s (%i)'):format(PlayerData.job.label, PlayerData.job.grade_label, PlayerData.job.grade)

                if PlayerData.group ~= 'user' then
                    dataTable['userGroup'] = PlayerData.group
                else
                    dataTable['userGroup'] = nil
                end

                local isDead = IsEntityDead(ped) or PlayerData.dead
                dataTable['inlaststand'] = isDead
                if (isDead) then dataTable['health'] = 0 end
            end

            dataTable['armor'] = GetPedArmour(ped)
            dataTable['date'] = GetLocalTime12Hour(hour, minute)

            if IsPedSwimmingUnderWater(ped) then
                dataTable['stamina'] = (GetPlayerUnderwaterTimeRemaining(pedId)/cfg.maxOxygenTime) * 100
            else
                dataTable['stamina'] = (GetPlayerStamina(pedId)/GetPlayerMaxStamina(pedId)) * 100.0
            end

            if (dataTable.mic == nil) then dataTable.mic = 1.5 end

            local changeSpotted = false 
            for k, j in pairs(dataTable) do 
                if (lastDataTable[k] ~= j) then 
                    changeSpotted = true
                end
            end

            if (changeSpotted) then
                SendNUIMessage({ updateMain = dataTable })
                lastDataTable = dataTable
            end

            if (IsPauseMenuActive()) then
                if (pauseMenu) then 
                    pauseMenu = false
                    showHud(false)
                end
            else
                if (not pauseMenu) then 
                    pauseMenu = true
                    showHud(true)
                end
            end
        end
    end)

    CreateThread(function()
        local pedId = PlayerId()
        local lastTalkingState = false
        while true do
            Wait(500)
            local talkState = NetworkIsPlayerTalking(pedId)
            if (lastTalkingState ~= talkState) then
                lastTalkingState = talkState
                SendNUIMessage({
                    isTalking = talkState
                })
            end
        end
    end)
end

function notifyF(data)
    if (cfg.notify) then
        lib.notify({
            description = data.description,
            type = data.type,
            position = cfg.notifyPos
        })
    end
end

local seatbelt = exports.mst_seatbelt

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function() 
    seatbelt = seatbelt:HasSeatbelt()
end)

DisplayRadar(false)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ped = PlayerPedId()
    pedId = PlayerId()
    while (ped == 0 or not ped) do 
        Wait(10)
    end
    PlayerData = xPlayer 
    lib.callback('IS_hud:loadHud', false, function(lData)
        displayRadarFunctionRevert()
        loadHud(lData)
    end)
end)

function getVehicleFuel(vehicleId)
    if (not DoesEntityExist(vehicleId)) then return 0 end

    return exports["lc_fuel"]:GetFuel(vehicleId)
end

local stockedDataLocation = {direction = nil, streetNames = nil}

function startLocation()
    if (debugM) then print('startLocation called') end
    CreateThread(function()
        while true do
            Wait(1000)
            local direction = getCardinalDirection(playerHeading)
            local streetNames = getStreetNames()
            if ((stockedDataLocation.direction ~= direction) or (stockedDataLocation.streetNames[1] ~= streetNames[1]) or (stockedDataLocation.streetNames[2] ~= streetNames[2])) then 
                stockedDataLocation.direction = direction
                stockedDataLocation.streetNames = streetNames
                SendNUIMessage({
                    updateLocation = true,
                    sNames = streetNames, 
                    nDirection = direction
                })
            end
        end
    end)
end