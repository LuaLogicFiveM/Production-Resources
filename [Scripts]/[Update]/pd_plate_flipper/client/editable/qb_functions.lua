if Config.QBCore.enabled then
    QBCore = exports['qb-core']:GetCoreObject()

    function HasItem(itemName)
        local items = QBCore.Functions.GetPlayerData().items
        for _, item in ipairs(items) do 
            if item.name == itemName then
                if item.amount then
                    return true
                end
            end
        end
        return false
    end

    function HasJob(jobName)
        if QBCore.Functions.GetPlayerData().job ~= nil then 
            return (QBCore.Functions.GetPlayerData().job.name == jobName)
        else
            return false
        end
    end

    RegisterNetEvent('pd_tracker:showOnTheMoveNotif')
    AddEventHandler('pd_tracker:showOnTheMoveNotif', function(trackerName)
        TriggerEvent('QBCore:Notify', _L("{TRACKER NAME} is on the move"):gsub("{TRACKER NAME}", trackerName))
    end)

end