ESX = exports.es_extended:getSharedObject()
PlayerData = {}

Citizen.CreateThread(function()
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(0)
    end
    PlayerData = ESX.GetPlayerData()

    Citizen.Wait(1000)
    print('callback')
    ESX.TriggerServerCallback('ak47_crutch:getstate', function(time)
        if time > 0 then
            forceCrunchStart(time)
        end
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('ak47_crutch:notify')
AddEventHandler('ak47_crutch:notify', function(msg)
    ESX.ShowNotification(msg)
end)