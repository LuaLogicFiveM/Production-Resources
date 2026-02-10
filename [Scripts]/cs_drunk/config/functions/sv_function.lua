if Config.ServerType == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.ServerType == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end

if Config.OpenUI.useCommand then
    lib.addCommand(Config.OpenUI.Command_Name, {
        help = 'Open Breathalyzer ',
    }, function(source)
        TriggerClientEvent('cs:drunk:openUI', source)
    end)
end

if Config.OpenUI.useItem then 
    if Config.ServerType == 'ESX' then
        ESX.RegisterUsableItem(Config.OpenUI.Item_Name, function(source)
            TriggerClientEvent('cs:drunk:openUI', source)
        end)
    elseif Config.ServerType == 'QB' then
        QBCore.Functions.CreateUseableItem(Config.OpenUI.Item_Name, function(source)
            TriggerClientEvent('cs:drunk:openUI', source)
        end)
    else
        --YOU CAN ADD YOUR CUSTOM EVENTS HERE
    end
end