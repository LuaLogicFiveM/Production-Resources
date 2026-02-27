if not Config.JobCallCommands.ENABLE then return end

for _, d in pairs(Config.JobCallCommands.Civilian_Commands) do
    TriggerEvent('chat:addSuggestion', '/'..d.command, Locale('chatsuggestion_jobcommands', d.job_label))
    RegisterCommand(d.command, function()
        SendNUIMessage({ action = 'create_player_notification' , data = d})
        EnableNuiFocus()
    end, false)
end


RegisterNUICallback('create_player_notification', function(data)
    TriggerServerEvent('cd_dispatch:CallCommand', GetPlayerInfo(), {
        job_label = data.data.job_label,
        job_table = data.data.job_table,
        anonymous = data.anonymous,
        message = data.message,
        phone_number = PlayerData.phone_number,
        char_name = PlayerData.char_name
    })
    PlayAnimation('cellphone@', 'cellphone_call_listen_base', 5000)
    DisableNuiFocus()
end)

local function JobCallCommandReplyData(job)
    for _, d in pairs(Config.JobCallCommands.Civilian_Commands) do
        for _, dd in pairs(d.job_table) do
            if dd == job then
                return {job_table = d.job_table, job_label = d.job_label}
            end
        end
    end
end

TriggerEvent('chat:addSuggestion', '/'..Config.JobCallCommands.JobReply_Command, Locale('chatsuggestion_jobreply'), {{ name=Locale('chatsuggestion_playerid_1'), help=Locale('chatsuggestion_playerid_1')}, { name=Locale('chatsuggestion_message_1'), help=Locale('chatsuggestion_message_2')}})
RegisterCommand(Config.JobCallCommands.JobReply_Command, function(source, args)
    local job = GetJobName()
    local job_data = JobCallCommandReplyData(job)
    if job_data then
        local target_id = args[1]
        if target_id then
            local message = table.concat(args, ' '):sub(tonumber(#target_id+1))
            if #message > 0 then
                TriggerServerEvent('cd_dispatch:CallCommand:Reply', {job = job, job_label = job_data.job_label, job_table = job_data.job_table, target_id = tonumber(target_id), message = message, char_name = SortDisplayName(PlayerData.callsign, PlayerData.char_name)})
            else
                Notif(3, 'enter_message_2')
            end
        else
            Notif(3, 'enter_playerid')
        end
    else
        Notif(3, 'no_perms')
    end
end, false)