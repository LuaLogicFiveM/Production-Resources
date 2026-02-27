exports.cd_bridge:RegisterServerCallback('cd_dispatch3d:LargeUIData', function(src, ...)
if Config.GpsTracker.ENABLE and HasGpsTrackerPerms(GetJobName(source)) and not GpsTrackerEnabled[source] then
            InitializeGpsTracker(source)
        end
    return GetLargeUIData(src, ...)
end)

exports.cd_bridge:RegisterServerCallback('cd_dispatch3d:GetHeatMapData', function(src, ...)
    return GetHeatmapData(src, ...)
end)

exports.cd_bridge:RegisterServerCallback('cd_dispatch3d:GetPlannerData', function(src, ...)
    return GetPlannerData(src, ...)
end)

exports.cd_bridge:RegisterServerCallback('cd_dispatch3d:GetGpsTrackerState', function(src, ...)
    return IsGpsTrackerActive(src)
end)