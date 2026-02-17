if Config.ESX.enabled then
    if Config.ESX.useNewESXExport then
        ESX = exports["es_extended"]:getSharedObject()
    else
        ESX = nil
        
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end


    ESX.RegisterUsableItem(Config.flipperInstall.itemName, function(source)
        TriggerClientEvent('pd_plate_flipper:client:installFlipper', source)
    end)

    function RemoveItem(player, itemName)
        local xPlayer = ESX.GetPlayerFromId(player)
        xPlayer.removeInventoryItem(itemName, 1)
    end
end