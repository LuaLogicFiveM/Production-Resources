if not Config.Ping.ENABLE then return end

RegisterKeyMapping(Config.Ping.command, Locale('ping_description'), 'keyboard', Config.Ping.key)
TriggerEvent('chat:addSuggestion', '/'..Config.Ping.command, Locale('ping_description'))

local cooldown = 0
local function StartPingCooldown()
    cooldown = Config.Ping.cooldown
    CreateThread(function()
        while cooldown do
            Wait(1000)
            cooldown = cooldown - 1
            if cooldown <= 0 then cooldown = 0 break end
        end
    end)
end

RegisterCommand(Config.Ping.command, function()
    if cooldown > 0 then
        return Notif(3, 'ping_cooldown', cooldown)
        end

    if not IsAllowed() then
        return
    end

    local data = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = GetMultiJob(GetJobName()),
        coords = data.coords,
        title = Locale('ping_title', GetJobLabel()),
        message = Locale('ping_message', SortDisplayName(PlayerData.callsign, PlayerData.char_name), data.street),
        flash = 0,
        sound = 1,
        blip = {
            sprite = 792, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = Locale('ping_title', GetJobLabel()),
            time = 5,
            radius = 0,
        }
    })
    StartPingCooldown()
end, false)
