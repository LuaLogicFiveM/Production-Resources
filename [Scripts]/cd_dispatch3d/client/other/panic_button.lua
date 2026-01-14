if not Config.PanicButton.ENABLE then return end

if Config.PanicButton.key ~= '' then
    RegisterKeyMapping(Config.PanicButton.command, Locale('panic_description'), 'keyboard', Config.PanicButton.key)
end
TriggerEvent('chat:addSuggestion', '/'..Config.PanicButton.command, Locale('panic_description'))

local cooldown = 0
local function StartPanicCooldown()
    cooldown = Config.PanicButton.cooldown
    CreateThread(function()
        while cooldown do
            Wait(1000)
            cooldown = cooldown - 1
            if cooldown <= 0 then cooldown = 0 break end
        end
    end)
end

RegisterCommand(Config.PanicButton.command, function()
    if cooldown > 0 then return Notif(3, 'panic_cooldown', cooldown) end
    TriggerEvent('cd_dispatch:PanicButtonEvent')
    StartPanicCooldown()
end, false)

RegisterNetEvent('cd_dispatch:PanicButtonEvent', function()
    local hasPerms = HasJob(Config.PanicButton.job_table)
    if hasPerms then
        local data = GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config.PanicButton.job_table,
            coords = data.coords,
            title = Locale('panic_title'),
            message = Locale('panic_message', SortDisplayName(PlayerData.callsign, PlayerData.char_name), data.street),
            flash = 1,
            sound = 4,
            blip = {
                sprite = 58,
                scale = 1.5,
                colour = 3,
                flashes = true,
                text = Locale('panic_title'),
                time = 5,
                radius = 0,
            }
        })
        PlayAnimation('random@arrests', 'generic_radio_chatter', 1000)
    else
        Notif(3, 'no_perms')
    end
end)