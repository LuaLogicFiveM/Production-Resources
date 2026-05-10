AddEventHandler('esx:onPlayerDeath', function (data)
    if data then
        lib.notify({ title = 'Death System', description = string.format("You were killed by %s from %s meters away.", data.killerServerId, data.distance), position = 'top', type = 'error' })
    end

    SetTimeout(10000, function()
        ExecuteCommand('+open_ems_menu')
    end)
end)