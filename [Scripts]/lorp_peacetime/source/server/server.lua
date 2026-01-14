--local ESX = exports["es_extended"]:getSharedObject()
--local groups = { ['owner'] = true, ['manager'] = true }

AddEventHandler('esx:playerLoaded', function(playerId)
    if GlobalState.peacetime then
        TriggerClientEvent('lorp_peacetime:client:toggle', playerId)
    else
        GlobalState.peacetime = false
    end
end)

-- Peace Time Command
RegisterCommand('peacetime', function(source, args, rawCommand)
    --local xPlayer = ESX.GetPlayerFromId(source)
    --if not xPlayer then return end

    --local xPlayerGroup = xPlayer.getGroup()
    --if groups[xPlayerGroup] then
    GlobalState.peacetime = not GlobalState.peacetime
    Wait(1)
    TriggerClientEvent('lorp_peacetime:client:toggle', -1)
    --else
    --    lib.notify(source, { title = 'Peace Time', description = 'You don\'t have permission to use this command.', type = 'error', position = 'top', icon = "fa-solid fa-clock" })
    --end
end, true)