if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']

if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']

local staminaCheck = false
local currentPunchStamina = 100.0
local doping = false
local lastPunchTime = GetGameTimer()
local staminaRecoveryRate = NMConfig['General']['staminaRecoveryRate']
local dopingStaminaRecoveryRate = NMConfig['General']['dopingStaminaRecoveryRate']
local recoveryThreshold = NMConfig['General']['recoveryThreshold']
local staminaLossAmountNormal = NMConfig['General']['staminaLossAmountNormal']
local staminaLossAmountDoping = NMConfig['General']['staminaLossAmountDoping']

AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkEntityDamage' then
        if staminaCheck then
            local attacker = args[2]

            if attacker == PlayerPedId() then
                removeStamina()
                lastPunchTime = GetGameTimer()
            end
        end
    end
end)

function removeStamina()
    local staminaLoss

    if doping then
        staminaLoss = math.random() * staminaLossAmountDoping
    else
        staminaLoss = math.random() * staminaLossAmountNormal
    end
    
    staminaLoss = math.floor(staminaLoss * 100) / 100

    currentPunchStamina = currentPunchStamina - staminaLoss
end


Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if staminaCheck then
            sleep = 500
            SendNUIMessage({
                type = 'stamina',
                stamina = currentPunchStamina
            })
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000

        if currentPunchStamina < 0 then currentPunchStamina = 0.0 end
        if GetGameTimer() - lastPunchTime > recoveryThreshold then
            if staminaCheck and currentPunchStamina < 100.0 then
                sleep = 100
                if doping then
                    currentPunchStamina = currentPunchStamina + dopingStaminaRecoveryRate
                    currentPunchStamina = math.min(currentPunchStamina, 100.0)
                else
                    currentPunchStamina = currentPunchStamina + staminaRecoveryRate
                    currentPunchStamina = math.min(currentPunchStamina, 100.0)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000

        if staminaCheck then
            if currentPunchStamina <= 10.0 then
                sleep = 0
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)

                if not isWarningDisplayed then
                    isWarningDisplayed = true
                    TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'notAllowedToPunch', 'error', 5000)
                end
            else
                isWarningDisplayed = false
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('nm_boxing_startStamina',  function(state)
    if state then
        currentPunchStamina = 100.0
        SendNUIMessage({
            type = 'staminaStatus',
            status = 'open'
        })
        exports['nproblem-boxing']:geriCagriGetir(framework, 'nm_boxing_checkDoping', function(result)
            doping = result
        end)
        staminaCheck = true
        exports['nproblem-boxing']:geriCagriGetir(framework, 'nm_boxing_getFightData', function(result)
            if result ~= nil then
                if NMConfig['General']['gymStatsEffectsToStamina'] then
                    if tonumber(result[1].gymStats) > 0 and tonumber(result[1].gymStats) < 100 then
                        staminaRecoveryRate = staminaRecoveryRate + 0.05
                        dopingStaminaRecoveryRate = staminaRecoveryRate + 0.05
                    elseif tonumber(result[1].gymStats) > 100 and tonumber(result[1].gymStats) < 200 then
                        staminaRecoveryRate = staminaRecoveryRate + 0.10
                        dopingStaminaRecoveryRate = staminaRecoveryRate + 0.10
                    elseif tonumber(result[1].gymStats) > 200 and tonumber(result[1].gymStats) < 300 then
                        staminaRecoveryRate = staminaRecoveryRate + 0.15
                        dopingStaminaRecoveryRate = staminaRecoveryRate + 0.15
                    elseif tonumber(result[1].gymStats) > 300 and tonumber(result[1].gymStats) < 400 then
                        staminaRecoveryRate = staminaRecoveryRate + 0.20
                        dopingStaminaRecoveryRate = staminaRecoveryRate + 0.20
                    elseif tonumber(result[1].gymStats) > 400 and tonumber(result[1].gymStats) < 500 then
                        staminaRecoveryRate = staminaRecoveryRate + 0.25
                        dopingStaminaRecoveryRate = staminaRecoveryRate + 0.25
                    end
                end
            end
        end)
    else
        SendNUIMessage({
            type = 'staminaStatus',
            status = 'close'
        })
        doping = false
        staminaCheck = false
    end
end)

local saveNormalPunchDamage = false

RegisterNetEvent('nm_boxing_setPunchDamage')
AddEventHandler('nm_boxing_setPunchDamage', function(state)
    if state then
        saveNormalPunchDamage = GetWeaponDamageModifier(`WEAPON_UNARMED`)
        local damageHesapla = NMConfig['General']['defaultPunchDamage']
        if doping then
            damageHesapla = damageHesapla + NMConfig['General']['DopingDamageIncrease']
        end
        SetWeaponDamageModifier(`WEAPON_UNARMED`, tonumber(damageHesapla))
    else
        SetWeaponDamageModifier(`WEAPON_UNARMED`, tonumber(saveNormalPunchDamage))
    end
end)