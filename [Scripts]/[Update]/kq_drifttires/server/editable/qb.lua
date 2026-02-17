if Config.qbSettings.enabled then
    if Config.qbSettings.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    QBCore.Functions.CreateUseableItem(Config.items.carjackItem, function(source)
        TriggerClientEvent('kq_drifttires:client:useJackstand', source)
    end)
    
    
    if not Config.advancedMode or Config.debug then
        QBCore.Functions.CreateUseableItem(Config.items.driftTireItem, function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 1)
        end)
        
        QBCore.Functions.CreateUseableItem(Config.items.regularTireItem, function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 0)
        end)
    end
    
    
    ----------------------------------------------------------------
    
    function CanAfford(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        if xPlayer.Functions.GetMoney(Config.qbSettings.moneyAccount) == nil then
            print('^6Invalid money account set!')
        end
        
        if xPlayer.Functions.GetMoney(Config.qbSettings.moneyAccount) < amount then
            return false
        end
        
        return true
    end
    
    function RemoveMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        if not xPlayer then
            return false
        end
        
        return xPlayer.Functions.RemoveMoney(Config.qbSettings.moneyAccount, amount)
    end
    
    function AddMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        if not xPlayer then
            return false
        end
        
        xPlayer.Functions.AddMoney(Config.qbSettings.moneyAccount, amount)
    end
    
    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        return xPlayer.Functions.GetItemByName(item) and xPlayer.Functions.GetItemByName(item).amount >= (amount or 1)
    end
    
    function RemovePlayerItem(player, item, amount)
        if DoesPlayerHaveItem(player, item) then
            local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
            xPlayer.Functions.RemoveItem(item, amount)
            
            return true
        end
        return true
    end
    
    function AddPlayerItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        return xPlayer.Functions.AddItem(item, amount)
    end
    
    function _GetPlayerIdentifier(player)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        
        return xPlayer.PlayerData.citizenid
    end
    ----------------------------------------------------------------
end
