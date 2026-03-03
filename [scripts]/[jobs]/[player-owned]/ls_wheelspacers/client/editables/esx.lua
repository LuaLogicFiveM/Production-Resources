if Config.framework == 'esx' then
    ESX = nil
    Citizen.CreateThread(function()
        if Config.useNewESXExport then
            ESX = exports["es_extended"]:getSharedObject()
        else
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
                Citizen.Wait(0)
            end
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        ESX.PlayerData = ESX.GetPlayerData()
        playerJob = ESX.PlayerData.job.name
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
        playerJob = job.name
    end)
end
