-- [[ Events ]]

-- Initialize framework based on the configuration
if Config.AutoRemoveEmptyItems.framework.ESX then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.AutoRemoveEmptyItems.framework.QBCore then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('r_pepperspray:server:removeItem', function(itemName)
    if Config.AutoRemoveEmptyItems.framework.ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeWeapon(itemName)
    elseif Config.AutoRemoveEmptyItems.framework.QBCore then
        exports['qb-inventory']:RemoveItem(source, itemName, 1, false)
    elseif Config.AutoRemoveEmptyItems.framework.OXInventory then
        exports.ox_inventory:RemoveItem(source, itemName, 1)
    end
end)