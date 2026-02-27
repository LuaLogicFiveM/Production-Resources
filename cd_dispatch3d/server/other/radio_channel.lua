RegisterServerEvent('cd_dispatch:GetRadioChannel', function(radio_channel)
    local source = source
    if not radio_channel or not AllPlayers[source] then return end

    if GetMultiJob(AllPlayers[source].job) then
        AllPlayers[source].radio_channel = tonumber(radio_channel)
        RefreshLargeUI(AllPlayers[source].job)
        PlayerBlipsActions(source, 'update')
    end
end)