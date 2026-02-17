if Config.QBCore.enabled then
    QBCore = exports['qb-core']:GetCoreObject()

    QBCore.Functions.CreateUseableItem(Config.flipperInstall.itemName, function(source, item)
        local src = source
        TriggerClientEvent('pd_plate_flipper:client:installFlipper', src)
    end)

    function RemoveItem(player, itemName)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        xPlayer.Functions.RemoveItem(itemName, 1)
    end
end