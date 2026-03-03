if Config.framework ~= 'esx' then
    QBCore = exports['qb-core']:GetCoreObject()
    local spacerVar = spacer
    local cooldown = false

    for k, spacer in pairs(Config.spacers) do
        QBCore.Functions.CreateUseableItem(spacer.name, function(source)
            if Config.debug then

                print('spacerVar', json.encode(spacerVar))
                print('Player(source).state.isWorking', Player(source).state.isWorking)
                print('cooldown', cooldown)
            end
            if not spacerVar and (HasJob(source) or not Config.job.jobOnly) then

                if not cooldown then
                    SetCooldown(1000)
                    TriggerClientEvent('ls_wheelspacers:SpacerUsed', source, k)
                    spacerVar = spacer
                end
            else
                TriggerClientEvent('ls_wheelspacers:Client:Notify', source, L('You can not equip this spacer'))
            end
        end)
    end

    QBCore.Functions.CreateUseableItem(Config.jackStand, function(source)
        if not cooldown then
            TriggerClientEvent('ls_wheelspacers:StartWork', source)
            SetCooldown(4000)
        end
    end)

    function UseItem(source, item)
        local xPlayer = QBCore.Functions.GetPlayer(source)

        xPlayer.Functions.RemoveItem(item, 1)
    end

    function TakeMoney(source, amount)
        local xPlayer = QBCore.Functions.GetPlayer(source)

        if not xPlayer then
            return false
        end

        if xPlayer.Functions.GetMoney(Config.shop.accountName) >= amount then
            xPlayer.Functions.RemoveMoney(Config.shop.accountName, amount)
        end
    end

    function RetrieveItem(source, itemId)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
        --local item = xPlayer.Functions.GetItemByName(itemId)
        xPlayer.Functions.AddItem(itemId, 1)
    end

    function HasJob(source)
        local xPlayer = QBCore.Functions.GetPlayer(source)

        if not xPlayer then
            return false
        end

        local job = xPlayer.PlayerData.job

        return Contains(Config.job.names, job.name)
    end

    function ResetSpacerValue(spacerValue)
        spacerVar = spacerValue
    end

    function SetCooldown(time)
        cooldown = true
        Citizen.CreateThread(function()
            Citizen.Wait(time)
            cooldown = false
        end)
    end
end