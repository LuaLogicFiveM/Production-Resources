local Config = lib.load('config')

local announces = Config.Announces
local jobsCache = {}
local lastCacheUpdate = 0

-- Function to get all available jobs from database with caching
local function getAllJobs()
    local currentTime = GetGameTimer()

    -- Check if cache is still valid
    if currentTime - lastCacheUpdate < (Config.JobsCacheDuration or 300000) and #jobsCache > 0 then
        return jobsCache
    end

    local jobs = {}
    local tableName = Config.JobsTableName or 'jobs'

    -- Get jobs from database synchronously
    local success, dbJobs = pcall(function()
        return MySQL.Sync.fetchAll('SELECT name, label FROM ' .. tableName .. ' WHERE name != ?', {'unemployed'})
    end)

    if success and dbJobs then
        for _, row in ipairs(dbJobs) do
            table.insert(jobs, {
                name = row.name,
                label = row.label
            })
        end
    else
        -- Fallback: get jobs from connected players if database query fails
        local connectedJobs = {}
        for _, playerId in ipairs(GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
            if xPlayer then
                local jobName = xPlayer.job.name
                local jobLabel = xPlayer.job.label

                if jobName ~= 'unemployed' and not connectedJobs[jobName] then
                    connectedJobs[jobName] = {
                        name = jobName,
                        label = jobLabel
                    }
                end
            end
        end

        for _, job in pairs(connectedJobs) do
            table.insert(jobs, job)
        end

        print(string.format("[lorp_announce] Fallback: Found %d jobs from connected players", #jobs))
    end

    -- Sort alphabetically by label
    table.sort(jobs, function(a, b)
        return a.label < b.label
    end)

    -- Update cache
    jobsCache = jobs
    lastCacheUpdate = currentTime

    return jobs
end

-- Command to open the announcement creation interface (configurable)
RegisterCommand(Config.Command, function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local jobName = xPlayer.getGroup()
    local jobInfo = announces[jobName]

    if not jobInfo then
        return lib.notify(source, { title = 'Announcements', position = 'top', description = Config.Texts.Notifications.NoPermission, type = 'error' })
    end

    -- Get all available jobs
    local availableJobs = getAllJobs()

    -- Send job data to client to open interface
    TriggerClientEvent('lorp_announce:openCreateInterface', source, {
        jobName = jobInfo.name,
        jobImage = jobInfo.image,
        availableJobs = availableJobs,
        config = {
            enableCategories = Config.EnableCategories,
            enableDurationSelection = Config.EnableDurationSelection,
            enableVisibilitySelection = Config.EnableVisibilitySelection,
            defaultDuration = Config.DefaultDuration,
            durationOptions = Config.DurationOptions,
            texts = Config.Texts
        }
    })
end, false)

-- Function to determine who can see the announcement
local function getTargetPlayers(source, visibility)
    local players = {}

    if visibility == 'all' then
        -- All players
        local targetPlayers = ESX.GetExtendedPlayers()
        for i, xTarget in ipairs(targetPlayers) do
            table.insert(players, tonumber(xTarget.source))
        end
    elseif visibility == 'job' then
        -- Only players from the same job
        local xPlayer = ESX.GetPlayerFromId(source)
        local targetPlayers = ESX.GetExtendedPlayers('group', xPlayer.getGroup())

        for i, xTarget in ipairs(targetPlayers) do
            table.insert(players, tonumber(xTarget.source))
        end
    else
        -- Specific job
        local targetPlayers = ESX.GetExtendedPlayers('job', visibility)

        for i, xTarget in ipairs(targetPlayers) do
            table.insert(players, tonumber(xTarget.source))
        end
    end

    return players
end

-- Function to get category information
local function getCategoryInfo(categoryData)
    return categoryData and categoryData.id == "custom" and categoryData or nil
end

-- Event to create announcement from interface
RegisterNetEvent('lorp_announce:createAnnounce')
AddEventHandler('lorp_announce:createAnnounce', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local jobName = xPlayer.getGroup()
    local jobInfo = announces[jobName]

    if not jobInfo then
        return lib.notify(source, { title = 'Announcements', position = 'top', description = Config.Texts.Notifications.NoPermission, type = 'error' })
    end

    local content = data.content or data
    local duration = data.duration or Config.DefaultDuration
    local visibility = data.visibility or 'all'
    local category = data.category

    if not content or content == "" then
        return lib.notify(source, { title = 'Announcements', position = 'top', description = Config.Texts.Notifications.NoContent, type = 'error' })
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local adData = {
        type = "anuncio",
        title = jobInfo.name,
        content = content,
        image = jobInfo.image,
        duration = duration,
        coords = { x = playerCoords.x, y = playerCoords.y, z = playerCoords.z },
        gpsText = Config.Texts.Interface.GPSButtonText
    }

    -- Add category if it exists and is enabled
    if Config.EnableCategories and category then
        local categoryInfo = getCategoryInfo(category)
        if categoryInfo then
            adData.category = categoryInfo
        end
    end

    -- Get target players according to visibility
    local targetPlayers = getTargetPlayers(source, visibility)

    -- Send announcement only to target players
    for _, playerId in ipairs(targetPlayers) do
        TriggerClientEvent('lorp_announce:showAd', playerId, adData)
    end

    -- Confirmation message with visibility and category information
    local visibilityMessage = Config.Texts.Notifications.VisibilityAll
    local categoryMessage = ''

    if visibility == 'job' then
        visibilityMessage = Config.Texts.Notifications.VisibilityJob
    elseif visibility ~= 'all' then
        -- Search for the specific job label
        local allJobs = getAllJobs()
        for _, job in ipairs(allJobs) do
            if job.name == visibility then
                visibilityMessage = job.label
                break
            end
        end
    end

    if Config.EnableCategories and category then
        categoryMessage = string.format(Config.Texts.Notifications.PublishSuccessWithCategory, category.name)
    end

    lib.notify(source, { title = 'Announcements', position = 'top', description = string.format(Config.Texts.Notifications.PublishSuccess, categoryMessage, visibilityMessage), type = 'success' })
    exports.lorp_packed:SendLog('__**Announcement Logs**__', '### Name: '..GetPlayerName(source)..'\n ### Coords: ' ..json.encode(data.playerCoords)..'\n ### Message: ' ..content..'\n ### Restriction: '..visibilityMessage, '')
end)

-- Initialize jobs cache on resource start
CreateThread(function()
    Wait(5000) -- Wait 5 seconds for database to be ready
    getAllJobs()
end)