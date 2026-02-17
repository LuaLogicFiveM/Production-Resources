if Config.framework == 'esx' then
    ESX = nil

    local spacerVar = nil
    local cooldown = false

    if Config.useNewESXExport then
        ESX = exports["es_extended"]:getSharedObject()
    else
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
                Citizen.Wait(0)
            end
        end)
    end

    for k, spacer in pairs(Config.spacers) do
        ESX.RegisterUsableItem(spacer.name, function(source)

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

    ESX.RegisterUsableItem(Config.jackStand, function(source)
        if not cooldown then
            TriggerClientEvent('ls_wheelspacers:StartWork', source)
            SetCooldown(4000)
        end
    end)

    function UseItem(source, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(item, 1)
    end

    function TakeMoney(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        local moneyAmount = xPlayer.getAccount(Config.shop.accountName).money
        if moneyAmount >= amount then
            xPlayer.removeAccountMoney(Config.shop.accountName, amount)
        end
    end

    function RetrieveItem(source, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local itemCount = xPlayer.getInventoryItem(item).count
        itemCount = itemCount + 1
        xPlayer.setInventoryItem(item, itemCount)
    end

    function HasJob(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        if not xPlayer then
            return false
        end

        local job = xPlayer.getJob()

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