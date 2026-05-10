local Config = lib.require('resource.quick_ping.shared')

RegisterNetEvent('lorp_packed:client:receivePing', function(coords, entity, icon)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end
    if not Config.Jobs[xPlayer.job.name] then return end

    local xPlayers = ESX.GetExtendedPlayers('job', xPlayer.job.name)
    lib.notify(xPlayer.source, {description = Config.Strings.placed_desc, title = Config.Strings.placed_title, type = 'info', position = 'top'})

    for _, data in pairs(xPlayers) do
        TriggerClientEvent('lorp_packed:client:receivePing', data.source, {
            coords = coords,
            duration = Config.Jobs[xPlayer.job.name].duration,
            color = Config.Jobs[xPlayer.job.name].color,
            blipColor = Config.Jobs[xPlayer.job.name].blipColor,
            pid = src,
            name = xPlayer.name,
            entity = entity,
            icon = icon,
        })
    end
end)