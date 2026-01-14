ESX.RegisterServerCallback('esx_status:getStatus', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        TriggerEvent('esx_status:getStatus', source, 'hunger', function(hungerStatus)
            TriggerEvent('esx_status:getStatus', source, 'thirst', function(thirstStatus)
                local status = { hunger = hungerStatus and hungerStatus.percent or 100, thirst = thirstStatus and thirstStatus.percent or 100 }
                cb(status)
            end)
        end)
    else
        cb({hunger = 100, thirst = 100})
    end
end)