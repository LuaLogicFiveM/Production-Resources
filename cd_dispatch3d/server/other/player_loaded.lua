-- Loads the player's data and sends it to the client.
RegisterServerEvent('cd_dispatch:PlayerLoaded', function(src)
    local source = (source ~= nil and source ~= '') and source or src
    if not GetPlayer(source) then return end

    local job = GetJobName(source)

    local multijob = GetMultiJob(job)
    if not multijob then return end

    if Config.GpsTracker.ENABLE and not IsGpsTrackerActive(source) then
        return
    end

    if AllPlayers[source] then
        PlayerDropped(source)
        Wait(2000)
    end

    AllPlayers[source] = {
        source = source,
        callsign = GetCallsign(source),
        char_name = GetCharacterName(source),
        phone_number = GetPhoneNumber(source),
        job = job,
        on_duty = GetJobDuty(source),
        radio_channel = 0,
        vehicle = 'foot',
        status = {
            name = 'Available',
            color = '#539D1B'
        },
    }

    while not CachedAllData do
        Wait(100)
    end

    TriggerClientEvent('cd_dispatch:LoadPlayerData', source,
        AllPlayers[source],
        GetGroupData(job),
        {follow_player = Config.FollowPlayer.ENABLE}
    )

    PlayerBlipsActions(source, 'update')
    SyncNotifications(source, job)

    if multijob then
        RefreshLargeUI(job)
    end

    if Config.GpsTracker.ENABLE and HasGpsTrackerPerms(job) then
        InitializeGpsTracker(source)
    end
end)