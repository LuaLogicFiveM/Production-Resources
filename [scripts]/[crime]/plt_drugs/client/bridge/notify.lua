local notificationSystem = nil
local QBCore = nil

if GetResourceState("ox_lib") == 'started' then
    notificationSystem = 'ox'
elseif GetResourceState("es_extended") == 'started' then
    notificationSystem = 'esx'
elseif GetResourceState("qb-core") == 'started' then
    notificationSystem = 'qb'
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState("mythic_notify") == 'started' then
    notificationSystem = 'mythic'
elseif GetResourceState("okokNotify") == 'started' then
    notificationSystem = 'okok'
elseif GetResourceState("codem-notification") == 'started' then
    notificationSystem = 'codem'
end

RegisterNetEvent('plt_drugs:notify', function(title, message)
    if not notificationSystem then
        print(
            '^1 FATAL ERROR: There is no compatible notification system, add your own system in plt_drugs/client/bridge/notify.lua^7')
        return
    end

    if notificationSystem == 'ox' then
        exports['ox_lib']:notify({
            title = title,
            description = message,
            type = 'inform'
        })
    elseif notificationSystem == 'esx' then
        TriggerEvent('esx:showNotification', message)
    elseif notificationSystem == 'qb' then
        QBCore.Functions.Notify(message, 'success', 5000)
    elseif notificationSystem == 'mythic' then
        exports['mythic_notify']:SendAlert('inform', message)
    elseif notificationSystem == 'okok' then
        exports['okokNotify']:Alert(title, message, 5000, 'neutral', true)
    elseif notificationSystem == 'codem' then
        TriggerEvent('codem-notification:Create', message, 'info', title, 5000)
    end
end)
