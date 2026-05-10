local playerSpawned = false

AddEventHandler("playerSpawned", function()
    if not playerSpawned then
        playerSpawned = true
        Wait((1000 * 20))
        TriggerServerEvent('lorp_discord_api:playerLoaded')
    end
end)