local savedJobs = {}
local cachedLeaderboards = {}
local societyMenus = {}
local adminIdentifiers = {}
local registeredStashes = {}
local lastWeeklyReset = nil
local firedEmployees = {} -- Track fired employees: [identifier][jobName] = true
local locale = Locale.T

-- Performance caching for boss data
local bossDataCache = {}
local bossDataCacheDuration = 60000  -- 60 seconds

--- Clear boss data cache for a specific job (called when boss data changes)
--- @param jobName string The job to clear cache for
local ClearBossDataCache = function(jobName)
    for cacheKey, _ in pairs(bossDataCache) do
        if cacheKey:find(jobName .. '_') == 1 then
            bossDataCache[cacheKey] = nil
        end
    end
    
    TriggerClientEvent('sd-multijob:client:clearBossCache', -1, jobName)
end

local logConfig = require('server/logs')
Logger.Setup(logConfig.logs)

-- Function to initialize the database and load both tables.
CreateThread(function()
    local success, err = pcall(function()
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS saved_jobs (
                identifier   VARCHAR(100) NOT NULL,
                jobs         JSON            DEFAULT NULL,
                job_stats    JSON            DEFAULT NULL,
                PRIMARY KEY (identifier)
            );
        ]])

        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS boss_menus (
                jobIdentifier VARCHAR(100) NOT NULL,
                data          JSON            DEFAULT NULL,
                applications  JSON            DEFAULT NULL,
                PRIMARY KEY (jobIdentifier)
            );
        ]])
        
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS sd_multijob_settings (
                setting_key   VARCHAR(50) NOT NULL,
                setting_value TEXT,
                PRIMARY KEY (setting_key)
            );
        ]])
    end)

    if not success then
        print('^1Error creating database tables:', err)
        return
    end

    local sj = MySQL.query.await('SELECT * FROM saved_jobs', {})
    if sj then
        for _, rec in ipairs(sj) do
            savedJobs[rec.identifier] = rec.jobs and json.decode(rec.jobs) or {}
        end
        print(('^2Loaded %d record(s) from saved_jobs.^0'):format(#sj))
    end

    local bm = MySQL.query.await('SELECT * FROM boss_menus', {})
    if bm then
        for _, rec in ipairs(bm) do
            local data = rec.data and json.decode(rec.data) or {}

            data.messages = data.messages or {}

            local apps = rec.applications and json.decode(rec.applications) or {}
            apps.questions   = apps.questions   or {}
            apps.submissions = apps.submissions or {}

            societyMenus[rec.jobIdentifier] = {
                data         = data,
                applications = apps
            }
            
            if data.firedEmployees then
                for identifier, _ in pairs(data.firedEmployees) do
                    firedEmployees[identifier] = firedEmployees[identifier] or {}
                    firedEmployees[identifier][rec.jobIdentifier] = true
                end
            end
        end
        print(('^2Loaded %d record(s) from boss_menus (with applications).^0'):format(#bm))
    end
end)

--- Helper function to get the lowest grade for a job from Config.Jobs
--- @param jobName string The job name
--- @return number The lowest grade available for the job
local GetLowestJobGrade = function(jobName)
    local jobConfig = Config.Jobs[jobName]
    if not jobConfig or not jobConfig.gradeLabels then
        return 0
    end
    
    local lowestGrade = math.huge
    for grade, _ in pairs(jobConfig.gradeLabels) do
        if tonumber(grade) < lowestGrade then
            lowestGrade = tonumber(grade)
        end
    end
    
    return lowestGrade == math.huge and 0 or lowestGrade
end

-- Function to add or update a job for a given identifier.
--- @param src number The server id of the player
--- @param jobName string The job to add or update.
--- @param grade number|nil The grade for the job. If nil, uses the lowest grade available.
local AddJob = function(src, jobName, grade)
    local identifier = GetIdentifier(src)

    if not Config.Jobs[jobName] then
        -- print(('Job "%s" not found in Config.Jobs for player %s (%s). Skipping job update.'):format(jobName, fullName or 'Unknown', identifier))
        return
    end

    local player = GetPlayer(src)
    if not player then
        return
    end

    if not savedJobs[identifier] then
        savedJobs[identifier] = {}
    end

    if not grade then
        grade = GetLowestJobGrade(jobName)
    end

    local jobConfig = Config.Jobs[jobName] or {}
    local isBossFlag = false
    if type(jobConfig.bossGrades) == "table" then
        for _, bossGrade in ipairs(jobConfig.bossGrades) do
            if tonumber(grade) == bossGrade then
                isBossFlag = true
                break
            end
        end
    end

    player.setJob(jobName, grade)
    savedJobs[identifier][jobName] = {
        grade   = tonumber(grade),
        stats   = {
            minutesWorked  = 0,
            weeklyMinutesWorked = 0,
        },
        isBoss  = isBossFlag
    }

    -- print(('Added job %s (Grade: %s, isBoss: %s) to identifier %s'):format(jobName, tostring(grade), tostring(isBossFlag), identifier))
    if logConfig.logs.events.job_selected then
        Logger.Log(nil, 'job_selected', locale('logs.job_selected', { jobName = jobName, srcName = nil, identifier = identifier }))
    end
end

exports('addJob', AddJob)

-- Function to set a player's job
--- @param src number The player's source
--- @param jobName string The job to set
--- @param grade number The grade to assign
--- @return boolean True on success, false otherwise
local SetPlayerJob = function(src, jobName, grade)
    local player     = GetPlayer(src)
    local identifier = player and GetIdentifier(src)
    if not player or not identifier then return false end

    player.setJob(jobName, grade)
    TriggerClientEvent('sd-multijob:client:setDuty', src, false)

    return true
end

lib.callback.register('sd-multijob:server:setPlayerJob', function(src, jobName, grade)
    if logConfig.logs.events.set_player_job then
        local srcName    = GetPlayerName(src)
        local charName   = GetFullName(src)
        local identifier = GetIdentifier(src)
        Logger.Log(src, 'set_player_job', locale('logs.set_player_job', { source=src, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, grade=grade }))
    end
    return SetPlayerJob(src, jobName, grade)
end)

-- Function to remove a job for a given identifier.
--- @param src number the server id for the player
--- @param jobName string The job to remove.
local RemoveJob = function(src, jobName)
    local player     = GetPlayer(src)
    local identifier = player and GetIdentifier(src)
    if not player or not identifier then return false end
    if savedJobs[identifier] then
        savedJobs[identifier][jobName] = nil
        player.setJob('unemployed', 0)
        TriggerClientEvent('sd-multijob:client:setDuty', src, false)
    end
end

exports('removeJob', RemoveJob)

-- Function to remove a player's job
--- @param src number The player's source
--- @param jobName string The job to remove
--- @return boolean True on success, false otherwise
local RemovePlayerJob = function(src, jobName)
    local identifier = GetIdentifier(src)
    if not identifier or not savedJobs[identifier][jobName] then return false end
    RemoveJob(src, jobName)

    -- Remove from framework's job system (important for Qbox multi-job support)
    RemovePlayerFromFrameworkJob(identifier, jobName)

    local player = GetPlayer(src)
    if player and player.job.name == jobName then
        player.setJob('unemployed', 0)
        TriggerClientEvent('sd-multijob:client:setDuty', src, false)
    end
    return true
end

lib.callback.register('sd-multijob:server:removeJobFromPlayer', function(src, jobName)
    if logConfig.logs.events.remove_job then
        local srcName    = GetPlayerName(src)
        local charName   = GetFullName(src)
        local identifier = GetIdentifier(src)
        Logger.Log(src, 'remove_job', locale('logs.remove_job', { source=src, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName }))
    end
    return RemovePlayerJob(src, jobName)
end)

lib.callback.register('sd-multijob:server:adminRemoveJob', function(src, targetIdentifier, jobName)
    local identifier = GetIdentifier(src)
    if not adminIdentifiers[identifier] then
        return false
    end

    if not targetIdentifier or not jobName then
        return false, locale('adminmenu.invalid_parameters')
    end

    if not savedJobs[targetIdentifier] or not savedJobs[targetIdentifier][jobName] then
        return false, locale('adminmenu.job_not_found')
    end

    savedJobs[targetIdentifier][jobName] = nil

    -- Remove from framework's job system (important for Qbox multi-job support)
    RemovePlayerFromFrameworkJob(targetIdentifier, jobName)

    for _, playerId in ipairs(GetPlayers()) do
        local playerSrc = tonumber(playerId)
        local playerIdentifier = GetIdentifier(playerSrc)
        if playerIdentifier == targetIdentifier then
            local player = GetPlayer(playerSrc)
            if player and player.job and player.job.name == jobName then
                player.setJob('unemployed', 0)
                TriggerClientEvent('sd-multijob:client:setDuty', playerSrc, false)
                TriggerClientEvent('sd-multijob:notification', playerSrc, locale('adminmenu.job_removed_notification', { jobName = jobName }), 'info')
            end
            break
        end
    end
    
    if logConfig.logs.events.remove_job then
        local srcName    = GetPlayerName(src)
        local charName   = GetFullName(src)
        local adminIdentifier = GetIdentifier(src)
        Logger.Log(src, 'admin_remove_job', locale('logs.admin_remove_job', { 
            source = src, 
            srcName = srcName, 
            charName = charName, 
            identifier = adminIdentifier, 
            targetIdentifier = targetIdentifier,
            jobName = jobName 
        }))
    end
    
    return true, locale('adminmenu.job_removed_success')
end)

-- Retrieve all jobs and grades for a given player.
--- @param srcOrIdent number|string  Player source ID or identifier string
--- @return table Map of jobName -> grade
local GetSavedJobs = function(srcOrIdent)
    local identifier = srcOrIdent
    if type(srcOrIdent) == "number" then
        identifier = GetIdentifier(srcOrIdent)
    end
    if not identifier or type(identifier) ~= "string" then
        return {}
    end
    local jobs = savedJobs[identifier] or {}
    local out  = {}
    for jobName, info in pairs(jobs) do
        out[jobName] = info.grade or 0
    end
    return out
end

exports('getSavedJobs', GetSavedJobs)

-- Toggle the player's duty status
--- @param src number The player's source
--- @return boolean True on success, false otherwise
local ToggleDuty = function(src)
    local player = GetPlayer(src)
    if not player or not player.job then
        return false
    end
    player.setJob('unemployed', 0)
    TriggerClientEvent('sd-multijob:client:setDuty', src, false)
    return true
end

lib.callback.register('sd-multijob:server:toggleDuty', function(src)
    return ToggleDuty(src)
end)

--- Force the player off-duty, but never back on.
--- @param src number The player's source
--- @return boolean   True on success, false otherwise
local ForceOffDuty = function(src)
    local player = GetPlayer(src)
    if not player or not player.job or player.job.name == 'unemployed' then
        return false
    end

    TriggerClientEvent('sd-multijob:client:setDuty', src, false)

    if logConfig.logs.events.toggle_duty then
        local srcName    = GetPlayerName(src)
        local charName   = GetFullName(src)
        local identifier = GetIdentifier(src)
        Logger.Log(src, 'toggle_duty', locale('logs.toggle_duty', { source=src, srcName=srcName, charName=charName, identifier=identifier, newDuty=false }))
    end

    return true
end

lib.callback.register('sd-multijob:server:forceOffDuty', function(src)
    return ForceOffDuty(src)
end)

--- Function to update the player's job stats.
--- Increments a specific stat by a given amount for a given job.
--- @param src number The player's source.
--- @param jobName string The job for which the stat is updated.
--- @param statName string The name of the stat to increment.
--- @param amount number The amount to increment.
--- @param doLog boolean wether or not to do log
local UpdateStats = function(src, jobName, statName, amount, doLog)
    if logConfig.logs.events.update_stats and doLog then
        local srcName    = GetPlayerName(src)
        local charName   = GetFullName(src)
        local identifier = GetIdentifier(src)
        Logger.Log(src, 'update_stats', locale('logs.update_stats', { source=src, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, statName=statName, amount=amount }))
    end
    local identifier = GetIdentifier(src)
    if identifier and savedJobs[identifier] and savedJobs[identifier][jobName] then
        savedJobs[identifier][jobName].stats[statName] = (savedJobs[identifier][jobName].stats[statName] or 0) + amount
    else
        print('Failed to update stat for', identifier, jobName)
    end
end

exports('updateStats', UpdateStats)

--- Callback: retrieve job stats including the weekly-target & reward info.
--- @param source number    The player’s source
--- @param jobName string   The job key
--- @return table           Stats including minutesWorked, targetWeeklyHours, weeklyRewardEnabled, weeklyRewardAmount, weeklyRewardRedeemed
lib.callback.register('sd-multijob:server:getJobStats', function(source, jobName)
    local identifier = GetIdentifier(source)
    if not identifier
       or not savedJobs[identifier]
       or not savedJobs[identifier][jobName] then
        return {}
    end

    local entry = savedJobs[identifier][jobName]
    local stats = entry.stats or {}

    local cfg   = (societyMenus[jobName] or { data = {} }).data
    stats.targetWeeklyHours    = cfg.weeklyTargetHours
    stats.weeklyRewardEnabled  = cfg.weeklyRewardEnabled
    stats.weeklyRewardAmount   = cfg.weeklyRewardAmount
    stats.weeklyRewardRedeemed = stats.weeklyRewardRedeemed or false

    return stats
end)

-- Callback function to retrieve jobs for a player.
lib.callback.register('sd-multijob:server:retrieveJobs', function(source)
    if logConfig.logs.events.retrieve_jobs then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'retrieve_jobs', locale('logs.retrieve_jobs', { source=source, srcName=srcName, charName=charName, identifier=identifier }))
    end
    local identifier = GetIdentifier(source)
    return savedJobs[identifier] or {}
end)

--- Callback: retrieve an employee’s job stats for display in the info menu
--- @param source        number  The boss’s player source
--- @param empIdentifier string  The hired employee’s unique identifier
--- @return table                The stats table (e.g. minutesWorked, arrests, etc.)
lib.callback.register('sd-multijob:server:getEmployeeJobStats', function(source, empIdentifier)
    local bossId = GetIdentifier(source)
    if not bossId then
        return {}
    end

    local bossJob
    for jobName, info in pairs(savedJobs[bossId] or {}) do
        if info.isBoss then
            bossJob = jobName
            break
        end
    end
    if not bossJob then
        return {}
    end

    if logConfig.logs.events.get_employee_stats then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'get_employee_stats', locale('logs.get_employee_stats', { source=source, srcName=srcName, charName=charName, identifier=identifier, empIdentifier=empIdentifier }))
    end

    local empJobs = savedJobs[empIdentifier] or {}
    local entry   = empJobs[bossJob] or {}

    return entry.stats or {}
end)

-- Helper function to get all job names from the Config.Jobs table.
--- @return table Array of job names
local GetAllJobNames = function()
    local jobs = {}
    for jobName, _ in pairs(Config.Jobs) do
        table.insert(jobs, jobName)
    end
    return jobs
end

local allJobNames = GetAllJobNames()

-- Get the player's active job group and duty status
--- @param source number The player's source
--- @return table { job=string, grade=number, onDuty=boolean } or nil if no multijob
lib.callback.register('sd-multijob:server:getActiveGroup', function(source)
    local player = GetPlayer(source)
    if not player then
        return nil
    end

    local job, grade = HasGroup(source, allJobNames, true)
    if not job then
        return { job = nil, grade = nil, onDuty = (player.job and player.job.onduty) or false }
    end

    if logConfig.logs.events.get_active_group then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'get_active_group', locale('logs.get_active_group', { source=source, srcName=srcName, charName=charName, identifier=identifier }))
    end

    return {
        job    = job,
        grade  = grade,
        onDuty = player.job and not player.job.name == 'unemployed'
    }
end)

if Config.Leaderboard.enable then
    CreateThread(function()
        Wait(5000)
        while true do
            for jobName, cfg in pairs(Config.Leaderboard) do
                if jobName ~= "enable" then
                    local board = {}
                    for identifier, jobs in pairs(savedJobs) do
                        local jd = jobs[jobName]
                        if jd then
                            local stats = jd.stats or {}
                            local pts   = (stats.minutesWorked or 0) * (cfg.timeWeight or 1)

                            for statKey, w in pairs(cfg.statWeights or {}) do
                                pts = pts + (stats[statKey] or 0) * w
                            end

                            table.insert(board, {
                                name  = jd.name or 'Unknown',
                                score = pts,
                            })
                        end
                    end

                    table.sort(board, function(a, b)
                        return a.score > b.score
                    end)
                    for i = #board, 6, -1 do
                        board[i] = nil
                    end
                    cachedLeaderboards[jobName] = board
                end
            end

            Wait(600000)
        end
    end)
end

--- Function to perform weekly reset of stats
--- Archives last week's minutes and resets weekly counters
local WeeklyReset = function()
    local jobsReset = 0
    local playersProcessed = 0
    
    for identifier, jobs in pairs(savedJobs) do
        if type(jobs) == "table" then
            playersProcessed = playersProcessed + 1
            for jobName, entry in pairs(jobs) do
                if type(entry) == "table" and entry.grade ~= nil then
                    if entry.stats then
                        local oldWeekly = entry.stats.weeklyMinutesWorked or 0
                        local oldRedeemed = entry.stats.weeklyRewardRedeemed
                        
                        entry.stats.lastWeekMinutes = oldWeekly
                        entry.stats.weeklyMinutesWorked = 0
                        entry.stats.weeklyRewardRedeemed = false
                        
                        jobsReset = jobsReset + 1
                        
                        if Config.Debug then
                            print(string.format("Reset %s job %s: weekly %d->0, redeemed %s->false", 
                                identifier, jobName, oldWeekly, tostring(oldRedeemed)))
                        end
                    else
                        entry.stats = {
                            minutesWorked = 0,
                            weeklyMinutesWorked = 0,
                            lastWeekMinutes = 0,
                            weeklyRewardRedeemed = false
                        }
                    end
                end
            end
        end
    end
    
    SaveAllData()
    
    lastWeeklyReset = os.time()
    MySQL.Async.execute('INSERT INTO sd_multijob_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = ?', 
        {'last_weekly_reset', tostring(lastWeeklyReset), tostring(lastWeeklyReset)})
    
    print(string.format('⏰ Weekly reset completed at %s - Processed %d players, reset %d job entries', 
        os.date('%Y-%m-%d %H:%M:%S', lastWeeklyReset), playersProcessed, jobsReset))
end

--- Function to check if weekly reset is needed
--- Resets on Monday at 00:00 server time
local CheckWeeklyReset = function()
    local now = os.time()
    local dt = os.date('*t', now)
    
    local daysSinceMonday = (dt.wday - 2 + 7) % 7
    local mondayMidnight = now - (daysSinceMonday * 86400) - (dt.hour * 3600) - (dt.min * 60) - dt.sec
    
    if not lastWeeklyReset or lastWeeklyReset < mondayMidnight then
        WeeklyReset()
    end
end

--- Initialize weekly reset system on resource start
CreateThread(function()
    Wait(1000)
    
    local result = MySQL.Sync.fetchAll('SELECT setting_value FROM sd_multijob_settings WHERE setting_key = ?', {'last_weekly_reset'})
    if result[1] then
        lastWeeklyReset = tonumber(result[1].setting_value)
    end
    
    CheckWeeklyReset()
    
    while true do
        Wait(60000)
        CheckWeeklyReset()
    end
end)

-- Callback function to retrieve the leaderboard for the passed job.
--- @param source number The player's source.
--- @param jobName string The job for which to leaderboard data.
--- @return table a table containing the leaderboard entries as well as the users own score
lib.callback.register('sd-multijob:server:getJobLeaderboard', function(source, jobName)
    local identifier = GetIdentifier(source)
    local board = cachedLeaderboards[jobName] or {}
    local personal = 0
    local entry = identifier and savedJobs[identifier] and savedJobs[identifier][jobName]
    if entry then
        local stats = entry.stats or {}
        local cfg   = Config.Leaderboard[jobName] or {}
        personal = (stats.minutesWorked or 0) * (cfg.timeWeight or 1)
        for statKey, w in pairs(cfg.statWeights or {}) do
            personal = personal + (stats[statKey] or 0) * w
        end
    end
    return { board = board, personal = personal }
end)

lib.callback.register('sd-multijob:server:isPlayerBoss', function(source, jobName)
    local ply = GetPlayer(source)
    return ply and ply.job and ply.job.grade_name == 'boss' and ply.job.name == jobName
end)

-- Admin command to add a job to a player manually.
lib.addCommand('addjob', {
    help = 'Add a job to a player',
    restricted = 'group.admin',
    params = {
        {
            name = 'source',
            type = 'playerId',
            help = "Target player's source ID"
        },
        {
            name = 'job',
            type = 'string',
            help = 'Job name to add'
        },
        {
            name = 'grade',
            type = 'number',
            help = 'Job grade (number)'
        }
    }
}, function(source, args, raw)
    local src = source
    local adminIdentifier = GetIdentifier(src)
    adminIdentifiers[adminIdentifier] = true
    
    local targetSource = args.source
    local jobName = args.job
    local grade = args.grade
    local identifier = GetIdentifier(targetSource)
    if not identifier then
        TriggerClientEvent('sd-multijob:notification', src, 'Identifier not found for source: ' .. tostring(targetSource), 'error')
        return
    end
    AddJob(targetSource, jobName, grade)
    TriggerClientEvent('sd-multijob:notification', src, 'Job ' .. jobName .. ' added with grade ' .. tostring(grade), 'success')
end)

-- Admin command to remove a job from a player manually.
lib.addCommand('removejob', {
    help = 'Remove a job from a player',
    restricted = 'group.admin',
    params = {
        {
            name = 'source',
            type = 'playerId',
            help = "Target player's source ID"
        },
        {
            name = 'job',
            help = 'Job name to remove'
        }
    }
}, function(source, args, raw)
    local src = source
    local adminIdentifier = GetIdentifier(src)
    adminIdentifiers[adminIdentifier] = true
    
    local targetSource = args.source
    local jobName = args.job
    local identifier = GetIdentifier(targetSource)
    if not identifier then
        TriggerClientEvent('sd-multijob:notification', src, 'Identifier not found for source: ' .. tostring(targetSource), 'error')
        return
    end
    RemoveJob(targetSource, jobName)
    TriggerClientEvent('sd-multijob:notification', src, 'Job ' .. jobName .. ' removed from identifier ' .. identifier, 'success')
end)

-- Admin command to view a player's saved jobs.
lib.addCommand('viewjobs', {
    help = 'View a player\'s saved jobs',
    restricted = 'group.admin',
    params = {
        {
            name = 'target',
            help = 'Target player source ID or identifier (accepts both numbers and strings)'
        }
    }
}, function(source, args, raw)
    local src = source
    local target = args.target
    local identifier
    local targetName = 'Unknown'

    local adminIdentifier = GetIdentifier(src)
    adminIdentifiers[adminIdentifier] = true
    
    local targetSource = tonumber(target)
    if targetSource then
        identifier = GetIdentifier(targetSource)
        if not identifier then
            TriggerClientEvent('sd-multijob:notification', src, 'Player not found or identifier not available for source: ' .. tostring(targetSource), 'error')
            return
        end
        targetName = GetPlayerName(targetSource) or GetFullName(targetSource) or 'Unknown'
    else
        identifier = target
        for _, playerId in ipairs(GetPlayers()) do
            local playerSrc = tonumber(playerId)
            if GetIdentifier(playerSrc) == identifier then
                targetName = GetPlayerName(playerSrc) or GetFullName(playerSrc) or 'Unknown'
                break
            end
        end
    end
    
    local playerJobs = savedJobs[identifier] or {}
    
    if next(playerJobs) == nil then
        TriggerClientEvent('sd-multijob:notification', src, 'No saved jobs found for identifier: ' .. identifier, 'info')
        return
    end
    
    local jobData = {
        identifier = identifier,
        playerName = targetName,
        jobs = {}
    }
    
    for jobName, jobInfo in pairs(playerJobs) do
        if jobName ~= 'notifications' then
            local jobConfig = Config.Jobs[jobName] or {}
            table.insert(jobData.jobs, {
                name = jobName,
                label = jobConfig.label or jobName,
                grade = jobInfo.grade or 0,
                gradeLabel = (jobConfig.gradeLabels and jobConfig.gradeLabels[jobInfo.grade]) or ('Grade ' .. (jobInfo.grade or 0)),
                isBoss = jobInfo.isBoss or false,
                stats = jobInfo.stats or {}
            })
        end
    end
    
    table.sort(jobData.jobs, function(a, b) return a.name < b.name end)
    
    TriggerClientEvent('sd-multijob:client:openAdminJobsMenu', src, jobData)
    
    TriggerClientEvent('sd-multijob:notification', src, 'Viewing jobs for: ' .. targetName .. ' (' .. identifier .. ')', 'success')
end)

--- Helper: save both savedJobs and bossMenus (including applications) for a given identifier
--- @param identifier string
local SavePlayerData = function(identifier)
    if logConfig.logs.events.save_player_data then
        Logger.Log(nil, 'save_player_data', locale('logs.save_player_data', { identifier = identifier }))
    end
    if savedJobs[identifier] then
        local jobData = json.encode(savedJobs[identifier])
        MySQL.query.await([[
            INSERT INTO saved_jobs (identifier, jobs)
            VALUES (?, ?)
            ON DUPLICATE KEY UPDATE
            jobs = VALUES(jobs)
        ]], { identifier, jobData })
        print(('Saved jobs for identifier %s on disconnect.'):format(identifier))
    end
    
    for jobName, menu in pairs(societyMenus) do
        if menu.data then
            -- Sync firedEmployees to menu data
            menu.data.firedEmployees = menu.data.firedEmployees or {}
            if firedEmployees[identifier] then
                for job, _ in pairs(firedEmployees[identifier]) do
                    if job == jobName then
                        menu.data.firedEmployees[identifier] = true
                    end
                end
            end
        end
    end
end

-- Override existing playerDropped handler to use SaveAllData
AddEventHandler('playerDropped', function(reason)
    local src        = source
    local identifier = GetIdentifier(src)
    if not identifier then return end

    SavePlayerData(identifier)
end)

--- Helper: batch-save all savedJobs and societyMenus (with applications) in a single transaction
--- @return nil
SaveAllData = function()
    if logConfig.logs.events.save_all_data then
        Logger.Log(nil, 'save_all_data', locale('logs.save_all_data', {}))
    end

    print('Attempting to batch-save all multijob data…')
    local queries = {}
    local warnings = {}

    for id, jobs in pairs(savedJobs) do
        local encoded = json.encode(jobs)
        if #encoded > 65000 then
            table.insert(warnings, string.format('Large data for %s: %d bytes', id, #encoded))
        end
        queries[#queries+1] = {
            query  = [[
              INSERT INTO saved_jobs (identifier, jobs)
              VALUES (?, ?)
              ON DUPLICATE KEY UPDATE jobs = VALUES(jobs)
            ]],
            values = { id, encoded }
        }
    end

    for jobName, menu in pairs(societyMenus) do
        local appData = menu.applications or { questions = {}, submissions = {} }
        local dataToSave = menu.data or {}
        
        if firedEmployees then
            dataToSave.firedEmployees = dataToSave.firedEmployees or {}
            for identifier, jobs in pairs(firedEmployees) do
                if jobs[jobName] then
                    dataToSave.firedEmployees[identifier] = true
                end
            end
        end
        
        local appJson = json.encode(appData)
        if #appJson > 60000 then
            print('^3[sd-multijob] WARNING: Applications for ' .. jobName .. ' are large (' .. #appJson .. ' bytes)^0')
            
            if appData.submissions and #appData.submissions > 50 then
                table.sort(appData.submissions, function(a, b)
                    return (a.createdAt or 0) > (b.createdAt or 0)
                end)
                
                local newSubmissions = {}
                for i = 1, math.min(50, #appData.submissions) do
                    table.insert(newSubmissions, appData.submissions[i])
                end
                appData.submissions = newSubmissions
                appJson = json.encode(appData)
                print('^2[sd-multijob] Trimmed to 50 most recent applications for ' .. jobName .. '^0')
            end
        end
        
        queries[#queries+1] = {
            query  = [[
              INSERT INTO boss_menus (jobIdentifier, data, applications)
              VALUES (?, ?, ?)
              ON DUPLICATE KEY UPDATE
                data         = VALUES(data),
                applications = VALUES(applications)
            ]],
            values = {
                jobName,
                json.encode(dataToSave),
                appJson
            }
        }
    end

    if #warnings > 0 then
        print('^3[sd-multijob] Data size warnings:^0')
        for _, warning in ipairs(warnings) do
            print('  - ' .. warning)
        end
    end

    if #queries == 0 then
        print('No multijob data to save.')
        return
    end

    MySQL.Async.transaction(queries, {}, function()
        print('Successfully batch-saved all multijob data.')
    end, function(err)
        print('^1Error batch-saving multijob data:^0', err)
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SaveAllData()
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    SaveAllData()
end)

if Config.Stats.enable then
    CreateThread(function()
        while true do
            Wait(60000)
            for _, playerId in ipairs(GetPlayers()) do
                local src = tonumber(playerId)
                local ply = GetPlayer(src)
                if ply and ply.job and ply.job.onduty then
                    local activeJob = HasGroup(src, allJobNames)
                    if activeJob then
                        UpdateStats(src, activeJob, 'minutesWorked', 1, false)
                        UpdateStats(src, activeJob, 'weeklyMinutesWorked', 1, false)
                    end
                end
            end
        end
    end)
end

-- Clean up expired notifications every minute
CreateThread(function()
    while true do
        Wait(60000)
        local now = os.time()

        for identifier, jobs in pairs(savedJobs) do
            local list = jobs.notifications
            if list then
                for i = #list, 1, -1 do
                    if list[i].expireAt <= now then
                        table.remove(list, i)
                    else
                        list[i].timeLeft = list[i].expireAt - now
                    end
                end
            end
        end
    end
end)

-- Create all boss stashes on resource start
CreateThread(function()
    Wait(1000)
    
    for jobName, jobConfig in pairs(Config.Jobs) do
        if jobConfig.stash and jobConfig.stash.enabled then
            local stashId = 'boss_stash_' .. jobName
            local jobLabel = jobConfig.label or jobName
            local slots = jobConfig.stash.slots or 50
            local weight = jobConfig.stash.weight or 100000
            
            exports.ox_inventory:RegisterStash(stashId, 'Boss Stash - ' .. jobLabel, slots, weight)
            registeredStashes[jobName] = true
        end
    end
end)

RegisterNetEvent('sd-multijob:server:onPlayerLoad', function()
    local src        = source
    local identifier = GetIdentifier(src)
    local player     = GetPlayer(src)
    if not identifier or not player or not player.job then
        return
    end

    -- Check and clean up ALL fired jobs for this player (handles server restart scenarios)
    if firedEmployees[identifier] then
        local currentJobWasFired = false
        local currentJobName = player.job.name
        local jobsToUpdateInDb = {}

        -- Iterate through all jobs this player was fired from
        for firedJobName, _ in pairs(firedEmployees[identifier]) do
            -- Remove from savedJobs if it somehow persisted (e.g., server restart before save)
            if savedJobs[identifier] and savedJobs[identifier][firedJobName] then
                savedJobs[identifier][firedJobName] = nil
            end

            -- Remove from framework's job system (important for Qbox multi-job support)
            RemovePlayerFromFrameworkJob(identifier, firedJobName)

            -- Clean up the firedEmployees entry in memory and track for DB update
            local menu = societyMenus[firedJobName]
            if menu and menu.data and menu.data.firedEmployees then
                menu.data.firedEmployees[identifier] = nil
                jobsToUpdateInDb[firedJobName] = menu
            end

            -- Track if their current primary job was one of the fired jobs
            if firedJobName == currentJobName then
                currentJobWasFired = true
            end
        end

        -- Clear all fired entries for this player
        firedEmployees[identifier] = nil

        -- Persist the cleanup to database
        MySQL.query([[
            INSERT INTO saved_jobs (identifier, jobs)
            VALUES (?, ?)
            ON DUPLICATE KEY UPDATE jobs = VALUES(jobs)
        ]], { identifier, json.encode(savedJobs[identifier] or {}) })

        -- Update boss_menus to clear firedEmployees for this player
        for jobName, menu in pairs(jobsToUpdateInDb) do
            local menuData = menu.data or {}
            local appData = menu.applications or { questions = {}, submissions = {} }
            MySQL.query([[
                INSERT INTO boss_menus (jobIdentifier, data, applications)
                VALUES (?, ?, ?)
                ON DUPLICATE KEY UPDATE data = VALUES(data), applications = VALUES(applications)
            ]], { jobName, json.encode(menuData), json.encode(appData) })
        end

        -- If their current primary job was fired, set them to unemployed
        if currentJobWasFired then
            player.setJob('unemployed', 0)
            TriggerClientEvent('sd-multijob:client:setDuty', src, false)
            -- TriggerClientEvent('sd-multijob:notification', src, locale('notifications.you_been_fired', { jobName = currentJobName }), 'error')
            return
        end
    end
    
    -- Re-fetch player in case job was changed
    player = GetPlayer(src)
    if not player or not player.job then
        return
    end
    
    local jobName    = player.job.name
    local grade      = player.job.grade
    local isBossFlag = player.job.grade_name == 'boss'
    local fullName   = GetFullName(src)

    if not Config.Jobs[jobName] then
        return
    end

    savedJobs[identifier] = savedJobs[identifier] or {}
    local entry = savedJobs[identifier][jobName]
    
    -- Don't add job if player was fired from it (this check remains for safety)
    if firedEmployees[identifier] and firedEmployees[identifier][jobName] then
        return
    end

    if entry then
        entry.grade  = grade
        entry.isBoss = isBossFlag
        entry.name   = fullName
        entry.stats  = entry.stats or {}
    else
        savedJobs[identifier][jobName] = {
            grade  = grade,
            stats  = {},
            name   = fullName,
            isBoss = isBossFlag
        }
    end
end)

--- Register and open boss stash for ox_inventory
--- @param jobName string The job name
RegisterNetEvent('sd-multijob:server:openBossStash', function(jobName)
    local src = source
    local player = GetPlayer(src)
    
    if not player or not player.job or player.job.name ~= jobName or not player.job.grade_name == 'boss' then
        return
    end
    
    local jobConfig = Config.Jobs[jobName]
    if not jobConfig or not jobConfig.stash or not jobConfig.stash.enabled then
        TriggerClientEvent('sd-multijob:notification', src, 'Stash is not available for this job', 'error')
        return
    end
    
    local stashId = 'boss_stash_' .. jobName
    
    if not registeredStashes[jobName] then
        print(('Warning: Boss stash for job %s was not registered on resource start'):format(jobName))
        return
    end
    
    exports.ox_inventory:forceOpenInventory(src, 'stash', stashId)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(src, newJob)
    local identifier = GetIdentifier(src)
    if not identifier or not newJob then
        return
    end

    if firedEmployees[identifier] and firedEmployees[identifier][newJob.name] then
        firedEmployees[identifier][newJob.name] = nil
        if next(firedEmployees[identifier]) == nil then
            firedEmployees[identifier] = nil
        end
        
        local menu = societyMenus[newJob.name]
        if menu and menu.data and menu.data.firedEmployees then
            menu.data.firedEmployees[identifier] = nil
        end
    end

    local jobName    = newJob.name
    local grade      = newJob.grade.level
    local isBossFlag = newJob.isboss == true
    local fullName   = GetFullName(src)

    if not Config.Jobs[jobName] then
        return
    end

    savedJobs[identifier] = savedJobs[identifier] or {}
    local entry = savedJobs[identifier][jobName]

    if entry then
        entry.grade  = grade
        entry.isBoss = isBossFlag
        entry.name   = fullName
    else
        if Config.Multijob.jobsLimit.enable then
            local count = 0
            for _ in pairs(savedJobs[identifier]) do
                count = count + 1
                if count >= Config.Multijob.jobsLimit.amount then
                    if Config.Multijob.jobsLimit.notify then 
                        TriggerClientEvent('sd-multijob:notification', src, locale('notifications.jobs_limit_reached', { amount = Config.Multijob.jobsLimit.amount }),'error')
                    end
                    return
                end
            end
        end

        savedJobs[identifier][jobName] = {
            grade  = grade,
            stats  = {},
            name   = fullName,
            isBoss = isBossFlag
        }
    end

    TriggerClientEvent('sd-multijob:client:activeJobChanged', src, newJob and newJob.name or nil)
end)

--- Helper: ensure societyMenus entry exists for this job
--- @param jobName string The job’s key (e.g. 'police')
--- @return table The menu object { data = {...}, applications = {...} }
local EnsureSocietyMenu = function(jobName)
    societyMenus[jobName] = societyMenus[jobName] or { data = {}, applications = {} }
    return societyMenus[jobName]
end

--- Helper: ensure society sub‐table exists
--- @param jobName string The job’s key
--- @return table society data (with .balance)
local EnsureSocietyData = function(jobName)
    local menu = EnsureSocietyMenu(jobName)
    menu.data.society = menu.data.society or { balance = 0 }
    return menu.data.society
end

--- Helper: ensure transactions log exists
--- @param jobName string The job’s key
--- @return table list of transaction entries
local EnsureTransactionLog = function(jobName)
    local menu = EnsureSocietyMenu(jobName)
    menu.data.transactions = menu.data.transactions or {}
    return menu.data.transactions
end

--- Ensure the “applications” slot exists for this job.
--- @param jobName string  The job’s unique identifier
--- @return table { questions = {}, submissions = {} }
local EnsureApplications = function(jobName)
    local menu = EnsureSocietyMenu(jobName)
    if type(menu.applications) ~= 'table' then
        menu.applications = { questions = {}, submissions = {} }
    else
        menu.applications.questions   = menu.applications.questions   or {}
        menu.applications.submissions = menu.applications.submissions or {}
    end

    return menu.applications
end

--- Helper: ensure notifications list exists for a player
--- @param identifier string  Player identifier
--- @return table             List of notifications
local EnsureNotifications = function(identifier)
    savedJobs[identifier] = savedJobs[identifier] or {}
    savedJobs[identifier].notifications = savedJobs[identifier].notifications or {}
    return savedJobs[identifier].notifications
end

--- Helper: ensure a job's message list exists (now backed by societyMenus.data.messages)
--- @param jobName string
--- @return table
local EnsureJobMessages = function(jobName)
    local menu = EnsureSocietyMenu(jobName)
    menu.data.messages = menu.data.messages or {}
    return menu.data.messages
end

--- Retrieve the questions & submissions for this job’s form.
--- @param source number  Any player source
--- @param jobName string The job key
lib.callback.register('sd-multijob:server:getApplicationData', function(source, jobName)
    local apps = EnsureApplications(jobName)
    return {
        questions   = apps.questions   or {},
        submissions = apps.submissions or {}
    }
end)

--- Boss sets the application zone coordinates for a job.
--- @param source   number The boss’s player source
--- @param jobName  string The job key
--- @param coords   table  { x = number, y = number, z = number }
--- @return boolean True on success
lib.callback.register('sd-multijob:server:setApplicationLocation', function(source, jobName, coords)
    local ply = GetPlayer(source)
    if not ply or not coords then
        return false
    end

    local apps = EnsureApplications(jobName)

    if apps.location then
        apps.location = nil
        TriggerClientEvent('sd-multijob:client:removeApplicationZone', -1, jobName)
    end

    apps.location = { x = coords.x, y = coords.y, z = coords.z }
    local coordsStr = string.format('%.2f, %.2f, %.2f', coords.x, coords.y, coords.z)

    if logConfig.logs.events.set_application_location then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'set_application_location', locale('logs.set_application_location', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, coords=coordsStr }))
    end

    TriggerClientEvent('sd-multijob:client:updateApplicationZone', -1, jobName, apps.location)

    return true
end)

--- Retrieve every job that has an application location set.
--- @param source number  Any player source
--- @return table Array of { job = string, coords = { x, y, z } }
lib.callback.register('sd-multijob:server:getApplicationLocations', function(source)
    local locations = {}
    for jobName, menu in pairs(societyMenus) do
        local apps = menu.applications
        if apps and apps.location then
            table.insert(locations, {
                job    = jobName,
                coords = apps.location
            })
        end
    end

    if logConfig.logs.events.get_application_locations then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'get_application_locations', locale('logs.get_application_locations', { source=source, srcName=srcName, charName=charName, identifier=identifier }))
    end

    return locations
end)

--- Boss adds a new question to the application form.
--- @param source   number   The boss's player source
--- @param jobName  string   The job key
--- @param question string   The question text
lib.callback.register('sd-multijob:server:addApplicationQuestion', function(source, jobName, question)
    local identifier = GetIdentifier(source)
    local info       = (savedJobs[identifier] or {})[jobName]
    if not info or not info.isBoss then return false end

    local apps = EnsureApplications(jobName)
    
    if #apps.questions >= 20 then
        TriggerClientEvent('sd-multijob:notification', source, 
            'Maximum of 20 questions allowed per application form.', 'error')
        return false
    end
    
    if #question > 200 then
        question = string.sub(question, 1, 197) .. '...'
    end
    
    table.insert(apps.questions, question)
    for _, sub in ipairs(apps.submissions) do
        table.insert(sub.answers, '')
    end

    if logConfig.logs.events.add_application_question then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'add_application_question', locale('logs.add_application_question', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, question=question }))
    end

    return true
end)

--- Boss removes a question by its index from this job’s form.
--- @param source   number   The boss’s player source
--- @param jobName  string   The job key
--- @param idx      number   The question index to remove
lib.callback.register('sd-multijob:server:removeApplicationQuestion', function(source, jobName, idx)
    local identifier = GetIdentifier(source)
    local info       = (savedJobs[identifier] or {})[jobName]
    if not info or not info.isBoss then return false end

    local apps = EnsureApplications(jobName)
    if not apps.questions[idx] then return false end

    table.remove(apps.questions, idx)
    for _, sub in ipairs(apps.submissions) do
        table.remove(sub.answers, idx)
    end

    if logConfig.logs.events.remove_application_question then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'remove_application_question', locale('logs.remove_application_question', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, idx=idx }))
    end

    return true
end)

--- Edit an existing application question for a given job.
--- @param source      number The boss’s player source
--- @param jobName     string The job key
--- @param idx         number The index of the question to edit
--- @param newQuestion string The updated question text
lib.callback.register('sd-multijob:server:editApplicationQuestion', function(source, jobName, idx, newQuestion)
    local identifier = GetIdentifier(source)
    local info       = (savedJobs[identifier] or {})[jobName]
    if not info or not info.isBoss then return false end

    local apps = EnsureApplications(jobName)
    if not apps.questions[idx] then return false end

    apps.questions[idx] = newQuestion

    if logConfig.logs.events.edit_application_question then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'edit_application_question', locale('logs.edit_application_question', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, idx=idx, newQuestion=newQuestion }))
    end

    return true
end)

--- Send application to Discord webhook
--- @param jobName string The job key
--- @param applicantName string The applicant's name
--- @param identifier string The applicant's identifier
--- @param answers table Array of answers
--- @param questions table Array of questions
--- @return boolean success
local SendApplicationToWebhook = function(jobName, applicantName, identifier, answers, questions)
    local webhookConfig = ApplicationWebhooks.jobs[jobName]
    if not webhookConfig or not webhookConfig.webhook or webhookConfig.webhook == '' then
        return false
    end

    local defaults = ApplicationWebhooks.default or {}
    local username = webhookConfig.username or defaults.username or 'Job Applications'
    local avatarUrl = webhookConfig.avatar_url or defaults.avatar_url or ''
    local color = webhookConfig.color or defaults.color or 3066993

    local jobConfig = Config.Jobs[jobName]
    local jobLabel = jobConfig and jobConfig.label or jobName

    -- Build the embed fields from questions and answers
    local fields = {}
    for i, answer in ipairs(answers) do
        local question = questions[i] or ('Question ' .. i)
        table.insert(fields, {
            name = question,
            value = tostring(answer):sub(1, 1024) or 'No answer provided',
            inline = false
        })
    end

    local embed = {
        title = 'New Application: ' .. jobLabel,
        description = ('**Applicant:** %s\n**Identifier:** %s\n**Submitted:** <t:%d:F>'):format(
            applicantName,
            identifier,
            os.time()
        ),
        color = color,
        fields = fields,
        footer = {
            text = 'sd-multijob Application System'
        },
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
    }

    local payload = {
        username = username,
        embeds = { embed }
    }

    if avatarUrl and avatarUrl ~= '' then
        payload.avatar_url = avatarUrl
    end

    PerformHttpRequest(webhookConfig.webhook, function(statusCode, response, headers)
        if statusCode >= 200 and statusCode < 300 then
            print(('[sd-multijob] Application webhook sent successfully for job: %s'):format(jobName))
        else
            print(('[sd-multijob] Failed to send application webhook for job: %s (Status: %d)'):format(jobName, statusCode))
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })

    return true
end

--- Submit a new application for this job (default status = 'Pending').
--- @param source  number  Player source
--- @param jobName string  The job key
--- @param answers table   Array of answers
--- @return boolean
lib.callback.register('sd-multijob:server:submitApplication', function(source, jobName, answers)
    local ply = GetPlayer(source)
    if not ply then return false end

    for i, answer in ipairs(answers) do
        if type(answer) == 'string' then
            if #answer > 1000 then
                answers[i] = string.sub(answer, 1, 497) .. '...'
            end
            answers[i] = answers[i]:gsub('[%c]', ' '):gsub('"', "'")
        end
    end

    -- Check total application size
    local testData = {
        identifier = GetIdentifier(source),
        name = GetFullName(source),
        answers = answers,
        status = 'Pending',
        createdAt = os.time()
    }

    local testEncode = json.encode(testData)
    if #testEncode > 15000 then
        TriggerClientEvent('sd-multijob:notification', source,
            'Your application is too long. Please shorten your answers.', 'error')
        return false
    end

    local apps = EnsureApplications(jobName)
    local identifier = GetIdentifier(source)
    local applicantName = GetFullName(source)

    -- Check if webhooks are enabled and configured for this job
    local useWebhook = ApplicationWebhooks.enabled
        and ApplicationWebhooks.jobs[jobName]
        and ApplicationWebhooks.jobs[jobName].webhook
        and ApplicationWebhooks.jobs[jobName].webhook ~= ''

    local alsoStoreInDb = not useWebhook
        or (ApplicationWebhooks.jobs[jobName] and ApplicationWebhooks.jobs[jobName].alsoStoreInDatabase)

    -- If storing in database, check for existing pending application
    if alsoStoreInDb then
        for _, sub in ipairs(apps.submissions) do
            if sub.identifier == identifier and sub.status == 'Pending' then
                TriggerClientEvent('sd-multijob:notification', source,
                    'You already have a pending application for this job.', 'error')
                return false
            end
        end
    end

    -- Send to webhook if configured
    if useWebhook then
        local questions = apps.questions or {}
        SendApplicationToWebhook(jobName, applicantName, identifier, answers, questions)
    end

    -- Store in database if needed
    if alsoStoreInDb then
        table.insert(apps.submissions, {
            identifier = identifier,
            name       = applicantName,
            answers    = answers,
            status     = 'Pending',
            createdAt  = os.time()
        })
    end

    if logConfig.logs.events.submit_application then
        local srcName, charName = GetPlayerName(source), GetFullName(source)
        Logger.Log(source, 'submit_application', locale('logs.submit_application', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName }))
    end

    return true
end)

--- Return the player’s own application for this job, if any.
--- @param source number
--- @param jobName string
--- @return table|nil { answers = {...}, status = string, interview = table|nil, timeLeft = number|nil }
lib.callback.register('sd-multijob:server:getPlayerApplication', function(source, jobName)
    local myId = GetIdentifier(source)
    local apps = societyMenus[jobName] and societyMenus[jobName].applications
    if not apps then return nil end

    for _, sub in ipairs(apps.submissions) do
        if sub.identifier == myId then
            local now = os.time()
            local remaining = sub.deleteAt and math.max(0, sub.deleteAt - now) or nil
            return {
                answers   = sub.answers,
                status    = sub.status or 'Pending',
                interview = sub.interview or nil,
                timeLeft  = remaining
            }
        end
    end
    return nil
end)

--- Allows a player to overwrite their existing submission (resets status to Pending).
--- @param source     number
--- @param jobName    string
--- @param newAnswers table
--- @return boolean
lib.callback.register('sd-multijob:server:editSubmission', function(source, jobName, newAnswers)
    local myId = GetIdentifier(source)
    local apps = societyMenus[jobName] and societyMenus[jobName].applications
    if not apps then return false end

    for _, sub in ipairs(apps.submissions) do
        if sub.identifier == myId then
            sub.answers = newAnswers
            sub.status  = 'Pending'
            return true
        end
    end
    return false
end)

--- Boss updates the status of a specific submission.
--- @param source    number   Boss’s player source
--- @param jobName   string   The job key
--- @param idx       number   The submission index
--- @param newStatus string   'Accepted' or 'Denied'
lib.callback.register('sd-multijob:server:setApplicationStatus', function(source, jobName, idx, newStatus, ttlSeconds)
    local identifier = GetIdentifier(source)
    local info       = (savedJobs[identifier] or {})[jobName]
    if not info or not info.isBoss then return false end

    local apps = EnsureApplications(jobName)
    local sub  = apps.submissions[idx]
    if not sub then return false end

    sub.status = newStatus

    if newStatus == 'Denied' and type(ttlSeconds) == 'number' then
        sub.deleteAt = os.time() + ttlSeconds
    else
        sub.deleteAt = nil
    end

    return true
end)

lib.callback.register('sd-multijob:server:deleteSubmission', function(source, jobName, idx)
    local identifier = GetIdentifier(source)
    local info = (savedJobs[identifier] or {})[jobName]
    if not info or not info.isBoss then return false end
    local apps = EnsureApplications(jobName)
    if not apps.submissions[idx] then return false end
    table.remove(apps.submissions, idx)
    return true
end)

CreateThread(function()
    while true do
        Wait(60 * 1000)
        local now = os.time()
        local totalCleaned = 0

        for jobName, menu in pairs(societyMenus) do
            local apps = menu.applications
            if apps and apps.submissions then
                local originalCount = #apps.submissions
                
                for i = #apps.submissions, 1, -1 do
                    local sub = apps.submissions[i]
                    if sub.status == 'Denied' and sub.deleteAt and sub.deleteAt <= now then
                        table.remove(apps.submissions, i)
                    elseif sub.status == 'Pending' and sub.createdAt then
                        if (now - sub.createdAt) > (30 * 24 * 60 * 60) then
                            table.remove(apps.submissions, i)
                        end
                    elseif sub.status == 'Accepted' and sub.createdAt then
                        if (now - sub.createdAt) > (7 * 24 * 60 * 60) then
                            table.remove(apps.submissions, i)
                        end
                    end
                end
                
                if #apps.submissions > 100 then
                    table.sort(apps.submissions, function(a, b)
                        return (a.createdAt or 0) > (b.createdAt or 0)
                    end)
                    for i = 101, #apps.submissions do
                        apps.submissions[i] = nil
                    end
                end
                
                local cleaned = originalCount - #apps.submissions
                if cleaned > 0 then
                    totalCleaned = totalCleaned + cleaned
                end
            end
        end
        
        if totalCleaned > 0 then
            print('^2[sd-multijob]^0 Cleaned ' .. totalCleaned .. ' old applications')
        end
    end
end)

--- Boss schedules an interview for a given application.
--- @param source    number   Boss’s player source
--- @param jobName   string   The job key
--- @param index     number   The submission index
--- @param interview table    { date=ms since epoch, time=ms since epoch, location=string }
--- @return boolean           True on success
lib.callback.register('sd-multijob:server:scheduleInterview', function(source, jobName, index, interview)
    local identifier = GetIdentifier(source)
    local info       = (savedJobs[identifier] or {})[jobName]
    if not info or not info.isBoss then return false end

    local apps = EnsureApplications(jobName)
    local sub  = apps.submissions[index]
    if not sub then return false end

    local dateStr = os.date('%Y-%m-%d', math.floor(interview.date/1000))
    local timeStr = os.date('%H:%M',   math.floor(interview.time/1000))

    if logConfig.logs.events.schedule_interview then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'schedule_interview ', locale('logs.schedule_interview', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, attending=tostring(attending) }))
    end

    sub.interview = {
        date     = dateStr,
        time     = timeStr,
        location = interview.location,
        status   = 'Scheduled'
    }
    return true
end)

--- Player responds to their scheduled interview invitation.
--- @param source    number   Player’s source
--- @param jobName   string   The job key
--- @param attending boolean  True if attending, false if declining
--- @return boolean          True on success
lib.callback.register('sd-multijob:server:respondInterview', function(source, jobName, attending)
    local myId = GetIdentifier(source)
    local apps = societyMenus[jobName] and societyMenus[jobName].applications
    if not apps then return false end

    if logConfig.logs.events.respond_interview then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'respond_interview', locale('logs.respond_interview', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, attending=tostring(attending) }))
    end

    for _, sub in ipairs(apps.submissions) do
        if sub.identifier == myId and sub.interview then
            sub.interview.response = attending and 'Confirmed' or 'Declined'
            return true
        end
    end
    return false
end)

--- Helper: record a deposit/withdrawal transaction
--- @param source     number  Player source who performed the action
--- @param action     string  'deposit' or 'withdraw'
--- @param amount     number  Amount of money moved
local LogTransaction = function(src, action, amount, jobName)
    local identifier = GetIdentifier(src)
    local txLog = EnsureTransactionLog(jobName)
    table.insert(txLog, {
        date   = os.date('%Y-%m-%d %H:%M:%S'),
        who    = identifier,
        name   = GetFullName(src),
        action = action,
        amount = amount
    })
end

exports('logTransaction', LogTransaction)

--- Callback: fetch all boss data (society, employees, transactions, notifications)
--- now also includes weekly target & reward info.
--- @param source number  The boss’s player source
--- @return table|false   Data or false if not a boss
lib.callback.register('sd-multijob:server:getBossData', function(source)
    local ply = GetPlayer(source)
    if not ply or not ply.job then
        return false
    end

    local currentJob = ply.job.name
    local identifier = GetIdentifier(source)
    local entry      = savedJobs[identifier] and savedJobs[identifier][currentJob]

    if not entry or entry.isBoss ~= true then
        return false
    end

    local now = GetGameTimer()
    local cacheKey = currentJob .. '_' .. identifier
    local cached = bossDataCache[cacheKey]
    
    if cached and (now - cached.timestamp) < bossDataCacheDuration then
        return cached.data
    end

    local onDuty     = ply.job.onduty
    local menu      = EnsureSocietyMenu(currentJob)
    local soc       = menu.data.society or { balance = 0 }
    local txHistory = menu.data.transactions or {}

    local emps = {}
    table.insert(emps, {
        identifier = identifier,
        name       = entry.name or 'Unknown',
        grade      = entry.grade,
        online     = true,
        onDuty     = onDuty
    })
    for pid, jobs in pairs(savedJobs) do
    if pid ~= identifier and jobs[currentJob] and not jobs[currentJob].fired then
        local e     = jobs[currentJob]
        local other = GetPlayerFromIdentifier(pid)
        local isOn  = other and other.job.name  == currentJob and other.job.onduty
        table.insert(emps, {
            identifier = pid,
            name       = e.name or 'Unknown',
            grade      = e.grade,
            online     = isOn,
            onDuty     = isOn
        })
    end
    end

    local osTime   = os.time()
    local msgs     = EnsureJobMessages(currentJob)
    local msgCount = 0
    for _, m in ipairs(msgs) do
        if m.expireAt > osTime then msgCount = msgCount + 1 end
    end

    local cfg       = menu.data
    local targetHrs = cfg.weeklyTargetHours   or 1
    local rewardOn  = cfg.weeklyRewardEnabled or false
    local rewardAmt = cfg.weeklyRewardAmount  or 0

    if logConfig.logs.events.get_boss_data then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'get_boss_data', locale('logs.get_boss_data', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=currentJob  }))
    end

    local result = {
        jobName             = currentJob,
        society             = { balance = soc.balance or 0 },
        employees           = emps,
        transactions        = txHistory,
        notificationsCount  = msgCount,
        weeklyTargetHours   = targetHrs,
        weeklyRewardEnabled = rewardOn,
        weeklyRewardAmount  = rewardAmt,
    }

    bossDataCache[cacheKey] = {
        data = result,
        timestamp = now
    }

    return result
end)

--- Callback: add a new employee to the society roster.
--- @param source    number  The boss's player source
--- @param targetSrc number  The new employee's server ID
lib.callback.register('sd-multijob:server:addEmployee', function(source, targetSrc)
    local bossPly = GetPlayer(source)
    if not bossPly or not bossPly.job or not bossPly.job.grade_name == 'boss' then
        return false
    end

    local bossJob = bossPly.job.name
    if targetSrc == source then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.cannot_hire_self'), 'error')
        return false
    end

    local ply = GetPlayer(targetSrc)
    if not ply then
        return false
    end

    local empId = GetIdentifier(targetSrc)
    
    if savedJobs[empId] and savedJobs[empId][bossJob] and not savedJobs[empId][bossJob].fired then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.already_employed_error', { name = GetFullName(targetSrc), identifier = empId, jobName = bossJob }), 'error')
        return false
    end
    
    if savedJobs[empId] and savedJobs[empId][bossJob] and savedJobs[empId][bossJob].fired then
        savedJobs[empId][bossJob].fired = false
        savedJobs[empId][bossJob].firedAt = nil
        savedJobs[empId][bossJob].firedBy = nil
    end

    local empName = GetFullName(targetSrc)
    local menu = EnsureSocietyMenu(bossJob)
    menu.data.employees = menu.data.employees or {}
    table.insert(menu.data.employees, { identifier = empId, name = empName })

    local lowestGrade = GetLowestJobGrade(bossJob)
    AddJob(targetSrc, bossJob, lowestGrade)
    savedJobs[empId][bossJob].name = empName

    if Config.SetJobOnHire then
        SetPlayerJob(targetSrc, bossJob, lowestGrade)
    end

    if logConfig.logs.events.add_employee then
        local srcName    = GetPlayerName(source)
        local charName   = GetFullName(source)
        local identifier = GetIdentifier(source)
        Logger.Log(source, 'add_employee', locale('logs.add_employee', {source = source, srcName = srcName, charName = charName, identifier = identifier, empIdentifier = empId, empName   = empName, jobName   = bossJob}))
    end

    TriggerClientEvent('sd-multijob:notification', targetSrc, locale('notifications.you_been_hired', { jobName = bossJob }), 'success')

    ClearBossDataCache(bossJob)
    return true
end)

--- Callback to remove an employee from a job
--- @param source number The boss's player source
--- @param empId string The employee's identifier to remove
lib.callback.register('sd-multijob:server:removeEmployee', function(source, empId)
    local bossPly = GetPlayer(source)
    if not bossPly or not bossPly.job then
        return false
    end

    local bossJob   = bossPly.job.name
    local bossIdent = GetIdentifier(source)

    if not bossPly.job.grade_name == 'boss' then
        return false
    end

    local bossEntry = savedJobs[bossIdent] and savedJobs[bossIdent][bossJob]
    if not bossEntry or not bossEntry.isBoss then
        return false
    end

    if not ( savedJobs[empId] and savedJobs[empId][bossJob] ) then
        return false
    end

    local bossGrade = bossEntry.grade or 0
    local empGrade = savedJobs[empId][bossJob].grade or 0

    if bossGrade <= empGrade then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.cannot_fire_higher_grade'), 'error')
        return false
    end

    firedEmployees[empId] = firedEmployees[empId] or {}
    firedEmployees[empId][bossJob] = true

    local menu = EnsureSocietyMenu(bossJob)
    menu.data.firedEmployees = menu.data.firedEmployees or {}
    menu.data.firedEmployees[empId] = true

    savedJobs[empId][bossJob] = nil

    -- Remove from framework's job system (important for Qbox multi-job support)
    RemovePlayerFromFrameworkJob(empId, bossJob)

    -- Immediately persist to database (important for offline firing to survive restarts)
    MySQL.query([[
        INSERT INTO saved_jobs (identifier, jobs)
        VALUES (?, ?)
        ON DUPLICATE KEY UPDATE jobs = VALUES(jobs)
    ]], { empId, json.encode(savedJobs[empId] or {}) })

    -- Save the firedEmployees state to boss_menus
    local menuData = menu.data or {}
    local appData = menu.applications or { questions = {}, submissions = {} }
    MySQL.query([[
        INSERT INTO boss_menus (jobIdentifier, data, applications)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE data = VALUES(data), applications = VALUES(applications)
    ]], { bossJob, json.encode(menuData), json.encode(appData) })

    local empPly = GetPlayerFromIdentifier(empId)
    if empPly then
        if empPly.job.name == bossJob then
            empPly.setJob('unemployed', 0)
            TriggerClientEvent('sd-multijob:client:setDuty', empPly.source, false)
        end
    end

    if logConfig.logs.events.remove_employee then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'remove_employee', locale('logs.remove_employee', { source=source, srcName=srcName, charName=charName, identifier=identifier, empIdentifier=empId, jobName=bossJob }))
    end

    ClearBossDataCache(bossJob)
    return true
end)

lib.callback.register('sd-multijob:server:giveEmployeeBonus', function(source, empId, amount)
    local bossPly = GetPlayer(source)
    if not bossPly or not bossPly.job or not bossPly.job.grade_name == 'boss' then
        TriggerClientEvent('sd-multijob:notification', source,
          locale('notifications.no_permission_give_bonus'), 'error')
        return false
    end

    local bossJob   = bossPly.job.name
    local bossIdent = GetIdentifier(source)
    if not (savedJobs[bossIdent] and savedJobs[empId] and savedJobs[empId][bossJob]) then
        TriggerClientEvent('sd-multijob:notification', source,
          locale('notifications.invalid_employee_selected'), 'error')
        return false
    end
    if type(amount) ~= 'number' or amount <= 0 then
        TriggerClientEvent('sd-multijob:notification', source,
          locale('notifications.bonus_amount_positive'), 'error')
        return false
    end

    local ok, newBalance
    if not Config.UseSociety.useCustomLogic then
        local menu = EnsureSocietyMenu(bossJob)
        local soc  = menu.data.society or { balance = 0 }
        if soc.balance < amount then
            TriggerClientEvent('sd-multijob:notification', source,
              locale('notifications.insufficient_society_funds'), 'error')
            return false
        end
        soc.balance = soc.balance - amount
        LogTransaction(source, 'bonus', amount, bossJob)
    else
        local bal = Config.UseSociety.getBalance(source, bossJob)
        if bal < amount then
            TriggerClientEvent('sd-multijob:notification', source,
              locale('notifications.insufficient_society_funds'), 'error')
            return false
        end
        ok, newBalance = Config.UseSociety.withdraw(source, bossJob, amount, 'bank')
        if not ok then return false end
    end

    local entry = savedJobs[empId][bossJob]
    entry.stats.bonuses      = (entry.stats.bonuses    or 0) + amount
    entry.pendingBonuses     = (entry.pendingBonuses  or 0) + amount

    if logConfig.logs.events.give_bonus then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'give_bonus', locale('logs.give_bonus', {
          source=source, srcName=srcName, charName=charName,
          identifier=identifier, empId=empId, amount=amount
        }))
    end

    local notifs = EnsureNotifications(empId)
    table.insert(notifs, {
        id       = tostring(os.time())..'_'..empId,
        type     = 'bonus',
        amount   = amount,
        message  = locale('notifications.bonus_received', { amount=amount }),
        expireAt = os.time() + Config.NotificationDuration,
        timeLeft = math.ceil(Config.NotificationDuration/60)
    })

    return true
end)

lib.callback.register('sd-multijob:server:sendEmployeeMessage', function(source, empId, subject, message)
    local bossPly = GetPlayer(source)
    if not bossPly or not bossPly.job or not bossPly.job.grade_name == 'boss' then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.no_permission_send_messages'), 'error')
        return false
    end

    local bossIdent = GetIdentifier(source)
    if not (savedJobs[bossIdent] and savedJobs[empId] and savedJobs[empId][bossPly.job.name]) then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.invalid_employee_selected'), 'error')
        return false
    end

    if type(subject) ~= 'string' or subject == '' then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.subject_cannot_be_empty'), 'error')
        return false
    end
    if type(message) ~= 'string' or message == '' then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.message_cannot_be_empty'), 'error')
        return false
    end

    local senderName = GetFullName(source)
    local notifs     = EnsureNotifications(empId)
    local duration   = Config.NotificationDuration

    if logConfig.logs.events.send_employee_message then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'send_employee_message', locale('logs.send_employee_message', { source=source, srcName=srcName, charName=charName, identifier=identifier, empId=empId, subject=subject }))
    end

    table.insert(notifs, {
        id       = tostring(os.time()) .. '_' .. empId,
        type     = 'message',
        subject  = subject,
        message  = message,
        sender   = senderName,
        expireAt = os.time() + duration,
        timeLeft = math.max(0, duration)
    })

    return true
end)

--- Callback: send a message from an employee to all bosses of their job
---   - Validates the sender holds the specified job
---   - Stores subject, message, sender, and 72-hour expiry in job-level storage
--- @param source   number   Employee’s player source
--- @param jobName  string   The key of the job
--- @param subject  string   Message subject
--- @param message  string   Message body
--- @return boolean          True on success
lib.callback.register('sd-multijob:server:sendBossMessage', function(source, jobName, subject, message)
    local ply = GetPlayer(source)
    if not ply or not ply.job or ply.job.name ~= jobName then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.no_permission_hold_job'), 'error')
        return false
    end
    if type(subject) ~= 'string' or subject == '' then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.subject_cannot_be_empty'), 'error')
        return false
    end
    if type(message) ~= 'string' or message == '' then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.message_cannot_be_empty'), 'error')
        return false
    end

    local senderName = GetFullName(source)
    local now        = os.time()
    local duration   = Config.NotificationDuration

    if logConfig.logs.events.send_boss_message then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'send_boss_message', locale('logs.send_boss_message', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, subject=subject }))
    end

    local msgs = EnsureJobMessages(jobName)
    table.insert(msgs, {
        id       = tostring(now) .. '_' .. jobName,
        subject  = subject,
        message  = message,
        sender   = senderName,
        expireAt = now + duration
    })

    return true
end)

--- Callback: get all pending notifications for the caller
--- Updates each notification’s timeLeft before returning
--- @param source number  Player’s source
--- @return table         Array of { id, type, amount?, message, timeLeft }
lib.callback.register('sd-multijob:server:getNotifications', function(source)
    local identifier = GetIdentifier(source)
    if not identifier or not savedJobs[identifier] then
        return {}
    end

    local notifs = savedJobs[identifier].notifications or {}
    local now    = os.time()

    for _, n in ipairs(notifs) do
        n.timeLeft = math.max(0, n.expireAt - now)
    end

    return notifs
end)

--- Callback: retrieve all pending messages for bosses of a job
---   - Validates boss permissions
---   - Filters out expired messages and adds timeLeft
--- @param source   number   Boss’s player source
--- @param jobName  string   The key of the job
--- @return table            Array of { id, subject, message, sender, timeLeft }
lib.callback.register('sd-multijob:server:getBossMessages', function(source, jobName)
    local ply = GetPlayer(source)
    if not ply or not ply.job.grade_name == 'boss' or ply.job.name ~= jobName then
        return {}
    end

    local now  = os.time()
    local out  = {}
    for _, m in ipairs(EnsureJobMessages(jobName)) do
        local remaining = m.expireAt - now
        if remaining > 0 then
            table.insert(out, {
                id       = m.id,
                subject  = m.subject,
                message  = m.message,
                sender   = m.sender,
                timeLeft = remaining
            })
        end
    end

    return out
end)

--- Callback: redeem a bonus notification and deposit into bank.
--- @param source number    Player's source ID.
--- @param notifId string   Notification ID to redeem.
--- @return boolean, number True if successful and the amount paid out.
lib.callback.register('sd-multijob:server:redeemBonus', function(source, notifId)
    local identifier = GetIdentifier(source)
    local notifs = (savedJobs[identifier] or {}).notifications or {}
    
    local player = GetPlayer(source)
    if not player or not player.job then
        TriggerClientEvent('sd-multijob:notification', source, 'Unable to determine your current job', 'error')
        return false, 0
    end
    
    local currentJob = player.job.name
    
    for i, n in ipairs(notifs) do
        if n.id == notifId and n.type == 'bonus' then
            local amount = n.amount
            
            if Config.UseSociety.enable then
                local societyBalance
                if Config.UseSociety.useCustomLogic then
                    societyBalance = Config.UseSociety.getBalance(source, currentJob)
                else
                    local soc = EnsureSocietyData(currentJob)
                    societyBalance = soc.balance or 0
                end
                
                if not societyBalance or societyBalance < amount then
                    TriggerClientEvent('sd-multijob:notification', source, 
                        locale('notifications.insufficient_society_funds') or 'The society does not have enough funds to pay this bonus', 
                        'error')
                    return false, 0
                end
                
                if Config.UseSociety.useCustomLogic then
                    local ok = Config.UseSociety.withdraw(source, currentJob, amount, 'bank')
                    if not ok then
                        TriggerClientEvent('sd-multijob:notification', source, 'Failed to withdraw from society', 'error')
                        return false, 0
                    end
                else
                    local soc = EnsureSocietyData(currentJob)
                    soc.balance = soc.balance - amount
                end
                
                LogTransaction(source, 'bonus_redeemed', amount, currentJob)
                
                ClearBossDataCache(currentJob)
            end
            
            Money.AddMoney(source, 'bank', amount)
            
            if logConfig.logs.events.redeem_bonus then
                local srcName    = GetPlayerName(source)
                local charName   = GetFullName(source)
                Logger.Log(source, 'redeem_bonus', locale('logs.redeem_bonus', { 
                    source=source, 
                    srcName=srcName, 
                    charName=charName, 
                    identifier=identifier, 
                    notifId=notifId,
                    jobName=currentJob
                }))
            end
            
            table.remove(notifs, i)
            return true, amount
        end
    end
    return false, 0
end)

--- Callback: delete any notification (message or bonus).
--- @param source number    Player’s source ID.
--- @param notifId string   Notification ID to delete.
--- @return boolean         True on success.
lib.callback.register('sd-multijob:server:deleteNotification', function(source, notifId)
    local identifier = GetIdentifier(source)
    local notifs = (savedJobs[identifier] or {}).notifications or {}
    for i, n in ipairs(notifs) do
        if n.id == notifId then
            if logConfig.logs.events.delete_notification then
                local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
                Logger.Log(source, 'delete_notification', locale('logs.delete_notification', { source=source, srcName=srcName, charName=charName, identifier=identifier, notifId=notifId }))
            end
            table.remove(notifs, i)
            return true
        end
    end
    return false
end)

--- Boss sets the weekly-hours target and optional weekly bonus for their job.
--- @param source number          The boss’s player source
--- @param jobName string         The job key
--- @param hours number           Number of hours target
--- @param rewardEnabled boolean  Whether to award a bonus upon reaching the target
--- @param rewardAmount number    Bonus amount in dollars
--- @return boolean True on success
lib.callback.register('sd-multijob:server:setWeeklyTarget', function(source, jobName, hours, rewardEnabled, rewardAmount)
    local ply = GetPlayer(source)
    if not ply
       or not ply.job
       or ply.job.name     ~= jobName
       or not ply.job.grade_name == 'boss' then
        return false
    end

    local menu = societyMenus[jobName] or { data = {}, applications = {} }
    societyMenus[jobName] = menu

    local d = menu.data
    d.weeklyTargetHours    = tonumber(hours) or 0
    d.weeklyRewardEnabled  = (rewardEnabled == true)
    d.weeklyRewardAmount   = tonumber(rewardAmount) or 0

    if logConfig.logs.events.set_weekly_target then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'set_weekly_target', locale('logs.set_weekly_target', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, hours=hours, rewardEnabled=tostring(rewardEnabled), rewardAmount=rewardAmount }))
    end

    return true
end)

--- Callback: employee claims the weekly bonus if eligible.
--- @param source number    The player's source
--- @param jobName string   The job key
--- @return boolean, number True on success and amount awarded
lib.callback.register('sd-multijob:server:claimWeeklyReward', function(source, jobName)
    local ply = GetPlayer(source)
    if not ply
       or not ply.job
       or ply.job.name ~= jobName then
        return false
    end

    local identifier = GetIdentifier(source)
    local entry      = savedJobs[identifier] and savedJobs[identifier][jobName]
    if not entry then return false end

    local stats = entry.stats or {}
    local cfg   = (societyMenus[jobName] or { data = {} }).data

    if not cfg.weeklyRewardEnabled or stats.weeklyRewardRedeemed then
        return false
    end

    local amount = cfg.weeklyRewardAmount or 0
    if amount <= 0 then
        return false
    end

    local societyBalance
    if Config.UseSociety.useCustomLogic then
        societyBalance = Config.UseSociety.getBalance(source, jobName)
    else
        local soc = EnsureSocietyData(jobName)
        societyBalance = soc.balance or 0
    end

    if not societyBalance or societyBalance < amount then
        TriggerClientEvent('sd-multijob:notification', source, 
            locale('notifications.insufficient_society_funds_weekly_reward') or 'The society does not have enough funds to pay the weekly reward', 
            'error')
        return false, 0
    end

    if Config.UseSociety.useCustomLogic then
        local ok = Config.UseSociety.withdraw(source, jobName, amount, 'bank')
        if not ok then
            TriggerClientEvent('sd-multijob:notification', source, 'Failed to process weekly reward', 'error')
            return false, 0
        end
    else
        local soc = EnsureSocietyData(jobName)
        soc.balance = soc.balance - amount
    end

    Money.AddMoney(source, 'bank', amount)
    
    stats.weeklyRewardRedeemed = true

    LogTransaction(source, 'weekly_reward', amount, jobName)

    ClearBossDataCache(jobName)

    if logConfig.logs.events.claim_weekly_reward then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'claim_weekly_reward', locale('logs.claim_weekly_reward', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, amount=amount }))
    end

    return true, amount
end)

--- Callback: delete a specific boss message from job-level storage
--- @param source   number   Boss’s player source
--- @param jobName  string   The key of the job
--- @param msgId    string   Message ID to delete
--- @return boolean          True on successful deletion
lib.callback.register('sd-multijob:server:deleteBossMessage', function(source, jobName, msgId)
    local ply = GetPlayer(source)
    if not ply or not ply.job.grade_name == 'boss' or ply.job.name ~= jobName then
        return false
    end

    local msgs = EnsureJobMessages(jobName)
    for i, m in ipairs(msgs) do
        if m.id == msgId then
            if logConfig.logs.events.delete_boss_message then
                local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
                Logger.Log(source, 'delete_boss_message', locale('logs.delete_boss_message', { source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, msgId=msgId }))
            end
            table.remove(msgs, i)
            return true
        end
    end

    return false
end)

--- Callback: get & clear the caller’s available bonuses for their active job.
---   - Returns how much pending bonus they have.
---   - Clears pendingBonuses so they can't redeem twice.
--- @param source number    Employee’s player source.
--- @return number          Total bonuses available right now.
lib.callback.register('sd-multijob:server:getEmployeeBonuses', function(source)
    local ply = GetPlayer(source)
    if not ply or not ply.job then
        return 0
    end

    local job        = ply.job.name
    local identifier = GetIdentifier(source)
    local entry      = savedJobs[identifier] and savedJobs[identifier][job]
    if not entry then
        return 0
    end

    local available = entry.pendingBonuses or 0
    entry.pendingBonuses = 0
    return available
end)

--- Callback: change an employee’s grade.
--- @param source number            The boss’s player source
--- @param empIdentifier string     The employee’s unique identifier
--- @param grade number             The new grade to assign
--- @return boolean                 True on success
lib.callback.register('sd-multijob:server:setEmployeeGrade', function(source, empIdentifier, grade)
    local bossPly = GetPlayer(source)
    if not bossPly or not bossPly.job or not bossPly.job.grade_name == 'boss' then
        return false
    end

    local bossJob = bossPly.job.name
    if not grade then
        return false
    end

    if not (savedJobs[empIdentifier] and savedJobs[empIdentifier][bossJob]) then
        return false
    end

    savedJobs[empIdentifier][bossJob].grade = grade

    if logConfig.logs.events.set_employee_grade then
        local srcName, charName, identifier = GetPlayerName(source), GetFullName(source), GetIdentifier(source)
        Logger.Log(source, 'set_employee_grade', locale('logs.set_employee_grade', { source=source, srcName=srcName, charName=charName, identifier=identifier, empIdentifier=empIdentifier, grade=grade }))
    end

    local empPly = GetPlayerFromIdentifier(empIdentifier)
    if empPly and empPly.job.name == bossJob then
        empPly.setJob(bossJob, grade)
        TriggerClientEvent('sd-multijob:notification', empPly.source, locale('notifications.promotion_success', { grade = grade, jobName = bossJob }), 'success')
    end

    ClearBossDataCache(bossJob)
    return true
end)

-- DepositSocietyFunds: internal helper
--- @param source    number   The player’s source
--- @param jobName   string   The society/job key (e.g. 'police')
--- @param amount    number   Amount to deposit
--- @param moneyType string   'cash' or 'bank'
--- @return number|false      New balance or false on error
local DepositSocietyFunds = function(source, jobName, amount, moneyType)
    if type(amount) ~= 'number' or amount <= 0 then return false end
    if moneyType ~= 'cash' and moneyType ~= 'bank' then return false end

    local identifier = GetIdentifier(source)
    local jobs       = savedJobs[identifier] or {}
    if not jobs[jobName] or not jobs[jobName].isBoss then return false end

    local funds = Money.GetPlayerAccountFunds(source, moneyType)
    if funds < amount then 
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.not_enough_money_to_deposit', { moneyType = moneyType }), 'error') 
        return false   
    end

    Money.RemoveMoney(source, moneyType, amount)

    if logConfig.logs.events.deposit_society then 
        local srcName, charName = GetPlayerName(source), GetFullName(source) 
        Logger.Log(source, 'deposit_society', locale('logs.deposit_society',{ source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, amount=amount, moneyType=moneyType }))   
    end

    LogTransaction(source, 'deposit', amount, jobName)

    if Config.UseSociety.useCustomLogic then
        local result = Config.UseSociety.deposit(source, jobName, amount, moneyType)
        if result then
            ClearBossDataCache(jobName)
        end
        return result
    end

    local soc = EnsureSocietyData(jobName)
    soc.balance = soc.balance + amount
    ClearBossDataCache(jobName)
    return soc.balance
end

-- WithdrawSocietyFunds: internal helper
--- @param source    number   The player’s source
--- @param jobName   string   The society/job key (e.g. 'police')
--- @param amount    number   Amount to withdraw
--- @param moneyType string   'cash' or 'bank'
--- @return number|false      New balance or false on error
local WithdrawSocietyFunds = function(source, jobName, amount, moneyType)
    if type(amount) ~= 'number' or amount <= 0 then return false end
    if moneyType ~= 'cash' and moneyType ~= 'bank' then return false end

    local identifier = GetIdentifier(source)
    local jobs       = savedJobs[identifier] or {}
    if not jobs[jobName] or not jobs[jobName].isBoss then return false end

    local currentBalance = Config.UseSociety.useCustomLogic and Config.UseSociety.getBalance(source, jobName) or EnsureSocietyData(jobName).balance

    if not currentBalance or currentBalance < amount then
        TriggerClientEvent('sd-multijob:notification', source, locale('notifications.society_not_enough_funds_withdraw'), 'error')
        return false
    end

    Money.AddMoney(source, moneyType, amount)

    if logConfig.logs.events.withdraw_society then 
        local srcName, charName = GetPlayerName(source), GetFullName(source) 
        Logger.Log(source, 'withdraw_society', locale('logs.withdraw_society',{ source=source, srcName=srcName, charName=charName, identifier=identifier, jobName=jobName, amount=amount, moneyType=moneyType }))   
    end
    
    LogTransaction(source, 'withdrawal', amount, jobName)

    if Config.UseSociety.useCustomLogic then
        local result = Config.UseSociety.withdraw(source, jobName, amount, moneyType)
        if result then
            ClearBossDataCache(jobName)  -- Clear cache when society balance changes
        end
        return result
    end

    local soc = EnsureSocietyData(jobName)
    soc.balance = soc.balance - amount
    ClearBossDataCache(jobName)  -- Clear cache when society balance changes
    return soc.balance
end

-- GetSocietyBalance: internal helper
--- @param source  number   The player’s source
--- @return number|false    Current balance or false
--- @return table|nil       Transaction history
local GetSocietyBalance = function(source)
    local player = GetPlayer(source)
    if not player or not player.job then
        return false
    end

    local jobName    = player.job.name
    local identifier = GetIdentifier(source)
    if not identifier then
        return false
    end

    local jobs = savedJobs[identifier] or {}
    local info = jobs[jobName]
    if not info or not info.isBoss then
        return false
    end

    local txHistory = EnsureTransactionLog(jobName)

    if Config.UseSociety.useCustomLogic then
        local balance = Config.UseSociety.getBalance(source, jobName)
        return balance, txHistory
    end

    local soc = EnsureSocietyData(jobName)
    return soc.balance or 0.0, txHistory
end

lib.callback.register('sd-multijob:server:depositSocietyFunds', DepositSocietyFunds)
lib.callback.register('sd-multijob:server:withdrawSocietyFunds', WithdrawSocietyFunds)
lib.callback.register('sd-multijob:server:getSocietyBalance', GetSocietyBalance)

-- expose as exports
exports('addSocietyDeposit', DepositSocietyFunds)   -- (source, jobName, amount, moneyType) -> balance|false
exports('withdrawSocietyFunds', WithdrawSocietyFunds)  -- (source, jobName, amount, moneyType) -> balance|false
exports('getSocietyBalance', GetSocietyBalance)     -- (source) -> balance|false, history|nil

--- Callback: get player’s name and identifier by server ID
--- @param source    number   The boss’s player source (ignored)
--- @param targetSrc number   The target player’s server ID
--- @return table|false       { name=string, identifier=string } or false if not found
lib.callback.register('sd-multijob:server:getPlayerInfo', function(source, targetSrc)
    local ply = GetPlayer(targetSrc)
    if not ply then
        return false
    end

    local identifier = GetIdentifier(targetSrc)
    local name       = GetFullName(targetSrc)

    return { name = name, identifier = identifier }
end)

CheckVersion('sd-versions/sd-multijob') -- Check version of specified resource
