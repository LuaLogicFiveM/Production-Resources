if not Config.PanicButton.ENABLE then return end

RegisterServerEvent('cd_dispatch:PanicSoundInDistance', function(players)
    for c, d in pairs(players) do
        TriggerClientEvent('cd_dispatch:PanicSoundInDistance', d)
    end
end)