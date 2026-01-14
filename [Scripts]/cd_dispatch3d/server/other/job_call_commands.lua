if not Config.JobCallCommands.ENABLE then return end

RegisterServerEvent('cd_dispatch:CallCommand', function(data, data_2)
    local _source = source
    local OnDuty = 0

    if Config.AntiCheat.ENABLE then
        if Config.AntiCheat.EventSpam.ENABLE then
            if IsBeingSpammed(_source, 'cd_dispatch:CallCommand') then return end
        end

        if Config.AntiCheat.BannedWords.ENABLE then
            if ContainsBannedWords(_source, 'cd_dispatch:CallCommand', {data_2.title, data_2.message, data_2.char_name, data_2.phone_number or 'N/A', data_2.job_label, data.street, data.sex}) then return end
        end
    end

    for _, d in pairs(AllPlayers) do
        for _, dd in pairs(data_2.job_table) do
            if d.job == dd then
                OnDuty = OnDuty + 1
                break
            end
        end
        if OnDuty > 0 then break end
    end

    if OnDuty > 0 then
        Notif(_source, 2, 'dispatch_callcommand', data_2.job_label, data_2.message)
        if not data_2.anonymous then
            AddNotification({
                coords = data.coords,
                job_table = data_2.job_table,
                title = Locale('dispatch_call_reply_title'),
                message = Locale('dispatch_call_message_1', data_2.char_name, data_2.phone_number or 'N/A', _source, data.street, data_2.message),
                flash = 0,
                blip = {
                    sprite = 487,
                    scale = 1.5,
                    colour = 3,
                    flashes = true,
                    text = data_2.job_label..' '..Locale('call'),
                    time = 5,
                    sound = 1,
                    radius = 0,
                }
            })
        else
            AddNotification({
                coords = data.coords,
                job_table = data_2.job_table,
                title = Locale('dispatch_call_reply_title'),
                message = Locale('dispatch_call_message_2', _source, data.street, data_2.message),
                flash = 0,
                blip = {
                    sprite = 487,
                    scale = 1.5,
                    colour = 3,
                    flashes = true,
                    text = data_2.job_label..' '..Locale('call'),
                    time = 5,
                    sound = 1,
                    radius = 100,
                }
            })
        end
    else
        Notif(_source, 2, 'dispatch_call_nonduty', data_2.job_label)
    end
end)


RegisterServerEvent('cd_dispatch:CallCommand:Reply', function(data)
    local _source = source
    if GetPlayerName(data.target_id) then
        for c, d in pairs(AllPlayers) do
            if d.job == data.job then
                Notif(d.source, 2, 'dispatch_call_reply_1', data.job_label, data.char_name, data.target_id, data.message)
            end
        end

        Notif(data.target_id, 2, 'dispatch_call_reply_2', data.job_label, data.char_name, data.message)
    else
        Notif(_source, 3, 'player_not_found')
    end
end)