--[[lib.cron.new('* */3 * * *', function()
    local players = ESX.GetExtendedPlayers()
    for target, player in ipairs(players) do
        player.addInventoryItem('money', 15000)
        lib.notify(target, {title = 'Automatic Giveaway', description = 'You have automatically been given $15,000 for playing the server!', type = 'success', position = 'top', duration = 10000})
    end
end)]]