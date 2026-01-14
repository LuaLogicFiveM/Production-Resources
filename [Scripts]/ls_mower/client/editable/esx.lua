if Config.esxSettings.enabled then

    ESX = nil
    ESX = exports['es_extended']:getSharedObject()

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        Citizen.CreateThread(function()
            Citizen.Wait(1)
            if ESX and ESX.GetPlayerData() and ESX.GetPlayerData().job then
                if ESX.GetPlayerData().job.name == Config.job.jobName then
                    drawSubtitles(L('Go to the marker [~g~Lawn Mowing Job~w~] to pick up your ~g~lawn mower.'), 10000)
                end
            end
        end)
    end)

    function HasJob(jobName) 
        return (ESX.GetPlayerData().job.name == jobName)         
    end

    function GiveWorkVehicleKey(vehicle)
        
    end

    RegisterNetEvent('ls_mower:removeMower')
    AddEventHandler('ls_mower:removeMower', function (lawnMower)
        local vehicleProps = ESX.Game.GetVehicleProperties(lawnMower)
        ESX.TriggerServerCallback('esx_garage:checkVehicleOwner', function(owner)
            if owner then
                ESX.Game.DeleteVehicle(lawnMower)
                TriggerServerEvent('ls_mower:owned_vehicles', true, 'SanAndreasAvenue', nil,
                    {vehicleProps = vehicleProps})
            else
                ESX.ShowNotification("You do not own this vehicle", 'error')
            end
        end, vehicleProps.plate)
    end)
end