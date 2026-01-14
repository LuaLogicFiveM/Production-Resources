if not Config.GpsTracker.ENABLE then return end

GpsTrackerEnabled = {}

function HasGpsTrackerPerms(job)
    for c, d in pairs(Config.GpsTracker.AllowedJobs) do
        if d == job then
            return true
        end
    end
    return false
end

function IsGpsTrackerActive(source)
    local job = GetJobName(source)
    if HasGpsTrackerPerms(job) then
        if HasItem(source, Config.GpsTracker.item_name, 1) then
            return true
        end
    end
    return false
end

function InitializeGpsTracker(source)
    GpsTrackerEnabled[source] = true
end

function EnableGpsTracker(source)
    GpsTrackerEnabled[source] = true
    TriggerEvent('cd_dispatch:PlayerLoaded', source)
end

CreateThread(function()
    while true do
        Wait(1000)
        for c, d in pairs(GpsTrackerEnabled) do
            local source = c
            local trackerEnabled = d
            local has_item = HasItem(source, Config.GpsTracker.item_name, 1)
            GpsTrackerEnabled[source] = has_item

            if trackerEnabled and not has_item then
                DisableGpsTracker(source)
            elseif not trackerEnabled and has_item  then
                EnableGpsTracker(source)
            end
        end
    end
end)

RegisterServerEvent('cd_dispatch:GpsTrackerEnable', function(src)
    local source = (source ~= nil and source ~= '') and source or src

    local job = GetJobName(source)
    if GetMultiJob(job) and HasGpsTrackerPerms(job) then
        EnableGpsTracker(source)
    end
end)

RegisterServerEvent('cd_dispatch:GpsTrackerDisable', function(src)
    local source = (source ~= nil and source ~= '') and source or src    local job = GetJobName(source)

    local job = GetJobName(source)
    if GetMultiJob(job) and HasGpsTrackerPerms(job) then
        DisableGpsTracker(source)
    end
end)