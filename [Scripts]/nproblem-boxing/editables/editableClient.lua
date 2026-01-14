if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']

RegisterNetEvent('nm_boxing_reviveClient', function()
    TriggerEvent('hospital:client:Revive')
end)

RegisterNetEvent('nproblem_boxing_showNotifyToPlayer', function(title, textdata, type31, duration, stringFormatBased)
    local whichOneTitle
    local whichOne
    if not stringFormatBased then
        whichOneTitle = Locales[NMConfig['General']['currentLocaleLanguage']]['notifications']['titles'][title]
        whichOne = Locales[NMConfig['General']['currentLocaleLanguage']]['notifications']['notify'][textdata]
        if not whichOne then
            whichOne = 'Something went wrong with the notify you wanted to send. Please check if the notify string is correct.'
        end
        if not whichOneTitle then
            whichOneTitle = 'Something went wrong'
        end
    else
        whichOneTitle = Locales[NMConfig['General']['currentLocaleLanguage']]['notifications']['titles'][title]
        whichOne = textdata
    end
    if NMConfig['General']['currentNotifyResource'] == 'native' then
        SetNotificationTextEntry("STRING")
        AddTextComponentString(whichOne)
        DrawNotification(false, false)
    elseif NMConfig['General']['currentNotifyResource'] == 'qb' then
        QBCore.Functions.Notify(whichOne, type31)
    elseif NMConfig['General']['currentNotifyResource'] == 'ox' then
        lib.notify({
            title = whichOneTitle or 'Boxing',
            description = whichOne,
            type = type31,
            duration = duration or 5000,
        })
    elseif NMConfig['General']['currentNotifyResource'] == 'okok' then
        exports['okokNotify']:Alert(whichOneTitle or 'Boxing', whichOne, duration or 5000, type31, true)
    end
end)

function useDoping()
    RequestAnimDict('rcmpaparazzo1ig_4')

    while not HasAnimDictLoaded('rcmpaparazzo1ig_4') do
        Citizen.Wait(150)
    end

    RequestModel('prop_syringe_01')

    while not HasModelLoaded('prop_syringe_01') do
        Citizen.Wait(150)
    end

    local playerPed = exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()
    local syringeObj = CreateObject('prop_syringe_01', 0.0, 0.0, 0.0, true, true, false)
    local syringeBoneIndex = GetPedBoneIndex(playerPed, 28422)

    SetCurrentPedWeapon(playerPed, `weapon_unarmed`, true)
    AttachEntityToEntity(syringeObj, playerPed, syringeBoneIndex, vector3(0, 0, 0), vector3(0, 0, 0), false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded('prop_syringe_01')

    TaskPlayAnimAdvanced(playerPed, 'rcmpaparazzo1ig_4', 'miranda_shooting_up', vector3(exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(playerPed)), vector3(GetEntityRotation(playerPed)), 3.0, 8.0, -1, 16, 0.55, nil, nil)
    
    Wait(4000)
    ShakeGameplayCam('SKY_DIVING_SHAKE', 0.2)
    StartScreenEffect("DefaultFlash", 8000, false)
    Citizen.Wait(8000)
    StopAnimTask(playerPed, 'rcmpaparazzo1ig_4', 'miranda_shooting_up', 1.0)
    DeleteObject(syringeObj)
    StopGameplayCamShaking(true)
end

RegisterNetEvent('nm_boxing_useDoping', function()
    exports['nproblem-boxing']:geriCagriGetir(framework, 'nm_boxing_checkDoping', function(result)
        if result ~= nil and not result then
            local alert = lib.alertDialog({
                header = '**Warning!**',
                content = 'Are you sure you want to use the doping? If detected, you may be blacklisted from the club.',
                size = 'xl',
                centered = true,
                cancel = true,
                labels = {
                    cancel = 'CANCEL',
                    confirm = 'USE DOPING'
                }
            })
            
            if alert == 'confirm' then
                useDoping()
                TriggerServerEvent('nm_boxing_insertDoping', exports['nproblem-boxing']:ConvertToSeconds(NMConfig['General']['dopingEffectTime'])) 
            end            
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'dopingUseCheck', 'error', 5000)
        end
    end, playerCID)
end)

function dopingCheck()

    local playerPed = exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()
    RequestAnimDict("amb@medic@standing@kneel@enter")
    while not HasAnimDictLoaded("amb@medic@standing@kneel@enter") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, "amb@medic@standing@kneel@enter", "enter", 8.0, -8.0, -1, 50, 0, false, false, false)
    Wait(8000)

    exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(playerPed)
end
RegisterNetEvent('nm_boxing_checkPlayer')
AddEventHandler('nm_boxing_checkPlayer', function()
    local playerPed = exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()
    local playerCoords = exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(playerPed)

    local jobFound = false
    for _, v in ipairs(NMConfig['General']['dopingCheckJobs']) do
        if v == exports['nproblem-boxing']:alisiOyuncu(framework) then
            jobFound = true
        end
    end

    if not jobFound then
        TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'dopingJobCheck', 'error', 5000)
        return
    end

    local closestPlayer = -1
    local closestDistance = 3.0

    for _, playerId in ipairs(GetActivePlayers()) do
        local targetPed = exports['nproblem-boxing']:G2M0I6l00W6n4VJQnvrbbjHc1e6xpyix(playerId)
        if targetPed ~= playerPed then
            local targetCoords = exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(targetPed)
            local distance = #(playerCoords - targetCoords)

            if distance < 3.0 then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end

    if closestPlayer ~= -1 then
        local closestServerId = GetPlayerServerId(closestPlayer)
        dopingCheck()
        exports['nproblem-boxing']:geriCagriGetir(framework, 'nm_boxing_checkDopingFromID', function(result)
            if result ~= nil and result then
                TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'dopingTestTrue', 'error', 5000)
            else
                TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'dopingTestFalse', 'success', 5000)
            end
        end, closestServerId)
    else
        TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'noOneClose', 'error', 5000)
    end
end)

-- Commands
RegisterCommand(NMConfig['General']['getYourCidCommand'], function()
    print('Your Identifier: ', playerCID)
end)