if Config.ESX.enabled then
    Citizen.CreateThread(function()
        while ESX == nil do
            if Config.ESX.useNewESXExport then
                ESX = exports['es_extended']:getSharedObject()
            else
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
            end
            Citizen.Wait(0)
        end
    end)


    function HasJob(jobName)
        return (ESX.GetPlayerData().job.name == jobName)
    end


    function HasItem(itemName)
        return exports.ox_inventory:Search('count', itemName) > 0
    end

end