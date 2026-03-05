local onDuty = false  -- Whether the player is on duty.
local activeJob = nil  -- The currently active job, updated from the server.
local applicationZones = {}  -- applicationZones[jobName] = zoneId -- Track all spawned application zones so we can remove them by ID
local currentJobName, currentJobGrade, currentDisplayName
local _lastMenu = nil  -- 'boss' or 'active'
local locale = Locale.T -- Variable to abbreviate the locale function/translation
local dutyZoneEnterHandler = {}
local dutyZoneExitHandler  = {}
local offDutyTimers = {}
local zones = {}
local registeredTargets = {}
local registeredLocations = {}  -- tracks registered locations to prevent duplicates
local isLoadingZones = false  -- prevents multiple simultaneous OnPlayerLoad calls
local insideDutyZone = {}  -- tracks whether the player is currently inside each job’s dutyZone


-- holds the last-fetched boss data
local bossData = {
    society   = { balance = 0 },
    employees = {},
    activityLog = {}
}

-- Performance caching
local bossStatusCache = {}  -- Cache boss status per job
local bossDataCache = {}    -- Cache boss data with timestamp
local bossDataCacheDuration = 60000  -- 60 seconds cache duration

--- Clear performance caches (called when job changes or when needed)
local ClearPerformanceCaches = function()
    bossStatusCache = {}
    bossDataCache = {}
end

--- Clear boss cache for a specific job (called from server)
--- @param jobName string The job to clear cache for
local ClearBossCacheForJob = function(jobName)
    if bossStatusCache[jobName] then
        bossStatusCache[jobName] = nil
    end
    
    if bossDataCache[jobName] then
        bossDataCache[jobName] = nil
    end
end

--- Toggles the player's duty state via server callback and notifies with on/off
local ToggleZoneDuty = function()
    lib.callback('sd-multijob:server:toggleDuty', false, function(success)
    end)
end

--- Forces the player off duty via server callback (no accidental on-duty).
local ForceOffDuty = function()
    lib.callback('sd-multijob:server:forceOffDuty', false, function(success)
    end)
end

--- Checks whether the player is boss of the given job (with caching)
--- @param job string  The job key
--- @param cb function(boolean)  Called with true if the player is boss
local CheckIsBoss = function(job, cb)
    local now = GetGameTimer()
    local cached = bossStatusCache[job]
    
    if cached and (now - cached.timestamp) < bossDataCacheDuration then
        cb(cached.isBoss)
        return
    end
    
    lib.callback('sd-multijob:server:isPlayerBoss', false, function(isBoss)
        bossStatusCache[job] = {
            isBoss = isBoss,
            timestamp = now
        }
        cb(isBoss)
    end, job)
end

--- Cancels any active off-duty timer for the specified job.
--- @param job string  The job identifier.
local CancelExitTimer = function(job)
    local timer = offDutyTimers[job]
    if not timer then return end

    timer.canceled = true
    offDutyTimers[job] = nil
end

--- Starts an off-duty timer for a given job.
--- @param job string   The job identifier.
--- @param secs number  The number of seconds before auto–offduty.
local StartExitTimer = function(job, secs)
    CancelExitTimer(job)

    local timer = { canceled = false }
    offDutyTimers[job] = timer

    timer.id = SetTimeout(secs * 1000, function()
        offDutyTimers[job] = nil

        if not timer.canceled then
            ForceOffDuty()
        end
    end)
end

-- Prepare per-job handlers for zone exit and duty-zone enter/exit
for job, cfg in pairs(Config.Zones) do
  local function doOffDuty()
    if cfg.dutyZone.timeout.enabled then
      StartExitTimer(job, cfg.dutyZone.timeout.seconds)
    else
      ForceOffDuty()
    end
  end

  if cfg.dutyZone and cfg.dutyZone.enabled then
    dutyZoneEnterHandler[job] = function()
      insideDutyZone[job] = true

      if onDuty and activeJob == job then
        CancelExitTimer(job)
      end
    end

    dutyZoneExitHandler[job] = function()
      insideDutyZone[job] = false

      if not (onDuty and activeJob == job) then
        return
      end

      if cfg.dutyZone.bossImmune then
        CheckIsBoss(job, function(isBoss)
          if not isBoss then
            doOffDuty()
          end
        end)
      else
        doOffDuty()
      end
    end
  end
end

local ClearZones = function()
    for job, jobZones in pairs(zones) do
        for key, zoneData in pairs(jobZones) do
            if type(zoneData) == 'table' then
                if zoneData[1] ~= nil then
                    for _, zoneObj in pairs(zoneData) do
                        if type(zoneObj) == 'table' and type(zoneObj.remove) == 'function' then
                            zoneObj:remove()
                        elseif type(zoneObj) == 'string' then
                            registeredTargets[zoneObj] = nil
                        end
                    end
                elseif type(zoneData.remove) == 'function' then
                    zoneData:remove()
                elseif type(zoneData) == 'string' then
                    registeredTargets[zoneData] = nil
                end
            end
        end
    end
    zones = {}
    registeredLocations = {}  -- Clear registered locations when clearing zones
end

--- Registers a duty or boss-menu interaction zone for a job.
--- @param job string The job key.
--- @param cfg table Configuration for the zone.
--- @param key string 'duty' or 'bossMenu'.
--- @param titleKey string The locale key for the prompt text.
--- @param callback function The function to call when interacting.
--- @param bossCheck boolean Whether to enforce “must be boss” on interact.
local RegisterZone = function(job, cfg, key, titleKey, callback, bossCheck)
    local itype = cfg.interactionType or 'marker'

    local function tryOpen()
        if bossCheck then
            CheckIsBoss(job, function(isBoss)
                if isBoss then
                    callback()
                end
            end)
        else
            callback()
        end
    end

    local locations = cfg.locations or {}
    
    if cfg.coords then
        locations = {{
            coords = cfg.coords,
            distance = cfg.distance,
            marker = cfg.marker
        }}
    end

    if not zones[job][key] then
        zones[job][key] = {}
    end

    for i, location in ipairs(locations) do
        local locationKey = string.format("%.2f_%.2f_%.2f", location.coords.x, location.coords.y, location.coords.z)
        
        if registeredLocations[locationKey] then
            goto continue
        end
        registeredLocations[locationKey] = true

        if itype == 'marker' then
            local pt = lib.points.new({ 
                coords = location.coords, 
                distance = location.distance,
                onExit = function() lib.hideTextUI() end 
            })
            function pt:nearby()
                if self.currentDistance > location.distance or activeJob ~= job then
                    return lib.hideTextUI()
                end

                DrawMarker(location.marker.type, self.coords.x, self.coords.y, self.coords.z, 0,0,0,0,0,0, 1.0,1.0,1.0, location.marker.red, location.marker.green, location.marker.blue, location.marker.opacity, false, true, 2, false, nil, nil, false)

                if self.currentDistance < location.distance then
                    if not lib.isTextUIOpen() then
                        lib.showTextUI('[E] ' .. locale(titleKey))
                    end
                    if IsControlJustReleased(0, 38) then
                        tryOpen()
                    end
                else
                    lib.hideTextUI()
                end
            end
            zones[job][key][i] = pt

        elseif itype == 'textui' then
            local pt = lib.points.new({ 
                coords = location.coords, 
                distance = location.distance,
                onExit = function() lib.hideTextUI() end 
            })
            function pt:nearby()
                if self.currentDistance > location.distance or activeJob ~= job then
                    return lib.hideTextUI()
                end

                if not lib.isTextUIOpen() then
                    lib.showTextUI('[E] ' .. locale(titleKey))
                end
                if IsControlJustReleased(0, 38) then
                    tryOpen()
                end
            end
            zones[job][key][i] = pt

        else
            local zoneName = (key == 'duty' and 'duty_toggle_' or 'boss_menu_') .. job .. '_' .. i

            if registeredTargets[zoneName] then
                goto continue
            end

            Interaction.AddCircleZone(
                itype, zoneName, location.coords, location.distance,
                {
                    options = {{
                        label       = locale(titleKey),
                        icon        = (key == 'duty') and Config.TargetIcons.duty or Config.TargetIcons.boss,
                        action      = tryOpen,
                        canInteract = function()
                            return activeJob == job
                        end,
                    }},
                },
                Config.Debug
            )
            registeredTargets[zoneName] = true
            zones[job][key][i] = zoneName
        end
        ::continue::
    end
end

local OnPlayerLoad = function()
    if isLoadingZones then
        return
    end
    isLoadingZones = true

    ClearZones()

    lib.callback('sd-multijob:server:getActiveGroup', false, function(res)
        if not res or type(res) ~= 'table' or res.job == nil then
            isLoadingZones = false
            return
        end
        activeJob, onDuty = res.job, res.onDuty

        for job, cfg in pairs(Config.Zones) do
            zones[job] = {}

            if cfg.duty and cfg.duty.enabled then
                RegisterZone(job, cfg.duty, 'duty', 'multijobmenu.toggle_duty_title', ToggleZoneDuty, false)
            end

            if cfg.dutyZone and cfg.dutyZone.enabled then
                local dutyZones = cfg.dutyZone.zones or {}
                
                if cfg.dutyZone.points then
                    dutyZones = {{
                        points = cfg.dutyZone.points,
                        thickness = cfg.dutyZone.thickness
                    }}
                end

                zones[job].dutyZone = {}
                
                for i, zoneData in ipairs(dutyZones) do
                    zones[job].dutyZone[i] = lib.zones.poly({
                        points    = zoneData.points,
                        thickness = zoneData.thickness,
                        debug     = Config.Debug,
                        onEnter   = dutyZoneEnterHandler[job],
                        onExit    = dutyZoneExitHandler[job],
                    })
                end
            end

            if cfg.bossMenu and cfg.bossMenu.enabled then
                RegisterZone(job, cfg.bossMenu, 'bossMenu', 'bossmenu.open_title', OpenBossMenu, true)
            end
        end

        TriggerServerEvent('sd-multijob:server:onPlayerLoad')
        isLoadingZones = false
    end)
end

CreateThread(function()
    OnPlayerLoad()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    OnPlayerLoad()
end)

--- Function to open the job confirmation window.
--- Prompts the player with a confirmation dialog before changing roles.
--- Provides an option to remove the job from the profile.
--- @param selectedJobName string The key of the job to change to.
--- @param selectedJobGrade number The grade of the job.
--- @param displayJobName string The formatted name of the job for display.
local OpenJobConfirmation = function(selectedJobName, selectedJobGrade, displayJobName)
    local confirmationOptions = {
        {
            title       = locale('multijobmenu.job_confirmation_option_confirm_change_title'),
            description = locale('multijobmenu.job_confirmation_option_confirm_change_description', { displayJobName = displayJobName }),
            icon        = 'check-circle',
            onSelect    = function()
                lib.callback('sd-multijob:server:setPlayerJob', false, function(success)
                    if success then
                        activeJob = selectedJobName
                        ClearPerformanceCaches()
                        ShowNotification(
                            locale('notifications.job_confirmation_change_success', { displayJobName = displayJobName }), 'success')
                    else
                        ShowNotification(
                            locale('notifications.job_confirmation_change_failure'),
                            'error'
                        )
                    end
                    TriggerEvent('sd-multijob:client:openJobsMenu')
                end, selectedJobName, selectedJobGrade)
            end,
        },
        {
            title       = locale('multijobmenu.job_confirmation_option_remove_job_title'),
            description = locale('multijobmenu.job_confirmation_option_remove_job_description'),
            icon        = 'trash',
            onSelect    = function()
                local choice = lib.alertDialog({
                    header   = locale('multijobmenu.job_confirmation_confirm_removal_header'),
                    content  = locale('multijobmenu.job_confirmation_confirm_removal_content', { displayJobName = displayJobName }),
                    centered = true,
                    cancel   = true,
                    size     = 'md',
                    overflow = true,
                    labels   = {
                        confirm = locale('multijobmenu.job_confirmation_confirm_removal_yes'),
                        cancel  = locale('multijobmenu.job_confirmation_confirm_removal_cancel')
                    }
                })
                if choice == 'confirm' then
                    lib.callback('sd-multijob:server:removeJobFromPlayer', false, function(success)
                        if success then
                            ShowNotification(
                                locale('notifications.job_confirmation_remove_success', { displayJobName = displayJobName }),'success')
                        else
                            ShowNotification(
                                locale('notifications.job_confirmation_remove_failure', { displayJobName = displayJobName }),'error')
                        end
                        TriggerEvent('sd-multijob:client:openJobsMenu')
                    end, selectedJobName)
                else
                    OpenJobConfirmation(selectedJobName, selectedJobGrade, displayJobName)
                end
            end,
        },
        {
            title       = locale('multijobmenu.job_confirmation_option_go_back_title'),
            description = locale('multijobmenu.job_confirmation_option_go_back_description'),
            icon        = 'arrow-left',
            onSelect    = function()
                TriggerEvent('sd-multijob:client:openJobsMenu')
            end,
        },
    }

    lib.registerContext({
        id       = 'job_confirmation_menu',
        title    = locale('multijobmenu.job_confirmation_title'),
        canClose = true,
        options  = confirmationOptions,
    })
    lib.showContext('job_confirmation_menu')
end

--- Utility: turn raw minutes into a flavourful string
--- @param amount number           The total minutes worked.
--- @param pronoun string?         Subject pronoun ('You', 'They', etc.). Defaults to locale('misc.minutes_worked_pronoun_default').
--- @return string                 Formatted string with hours, minutes and optional total minutes.
local FormatMinutesWorked = function(amount, pronoun)
    pronoun = pronoun or locale('misc.minutes_worked_pronoun_default')

    local hrs  = math.floor(amount / 60)
    local mins = amount % 60

    local hrText = ''
    if hrs > 0 then
        local key = (hrs == 1)
            and 'misc.minutes_worked_hr_singular'
            or 'misc.minutes_worked_hr_plural'
        hrText = locale(key, { count = hrs })
    end

    local minText = ''
    if mins > 0 then
        local key = (mins == 1)
            and 'misc.minutes_worked_min_singular'
            or 'misc.minutes_worked_min_plural'
        minText = locale(key, { count = mins })
    end

    local combined
    if hrText ~= '' and minText ~= '' then
        combined = hrText .. locale('misc.minutes_worked_and') .. minText
    elseif hrText ~= '' then
        combined = hrText
    else
        combined = minText
    end

    local extra = ''
    if hrs > 0 then
        extra = locale('misc.minutes_worked_total', { amount = amount })
    end

    return locale('misc.minutes_worked_desc', {
        pronoun  = pronoun,
        combined = combined,
        extra    = extra
    })
end

--- Show full stats for the currently active job
--- @param jobName string The internal key of the job.
--- @param selectedJobGrade number The grade level the player holds.
--- @param displayJobName string The friendly name to show in the menu header.
local ShowJobStats = function(jobName, selectedJobGrade, displayJobName)
    lib.callback('sd-multijob:server:getJobStats', false, function(stats)
        local options = {}
        local cfg = Config.Stats[jobName] or {}

        for _, statInfo in ipairs(cfg) do
            local amt  = stats[statInfo.key] or 0
            local desc

            if statInfo.key == 'minutesWorked' then
                desc = FormatMinutesWorked(amt)
            else
                desc = (statInfo.description or ''):gsub('{amount}', tostring(amt))
            end

            table.insert(options, {
                title    = statInfo.title,
                description = desc,
                icon     = statInfo.icon,
                readOnly = true
            })
        end

        if #options == 0 then
            table.insert(options, {
                title    = locale('multijobmenu.job_stats_no_stats'),
                icon     = 'exclamation-triangle',
                readOnly = true
            })
        end

        table.insert(options, {
            title    = locale('multijobmenu.job_stats_back'),
            icon     = 'arrow-left',
            onSelect = function()
                TriggerEvent(
                    'sd-multijob:client:openActiveJobs',
                    jobName, selectedJobGrade, displayJobName
                )
            end
        })

        lib.registerContext({
            id       = 'job_stats_menu',
            title    = locale('multijobmenu.job_stats_title', { displayJobName = displayJobName }),
            options  = options,
            canClose = true
        })
        lib.showContext('job_stats_menu')
    end, jobName)
end

--- Function to open the job leaderboard.
--- Retrieves and displays the leaderboard for the specified job.
--- @param jobName string The key of the job.
--- @param selectedJobGrade number The grade of the job.
--- @param displayJobName string The formatted name of the job for display.
OpenJobLeaderboard = function(jobName, selectedJobGrade, displayJobName)
    lib.callback('sd-multijob:server:getJobLeaderboard', false, function(data)
        local options = {}

        for i = 1, 5 do
            local ent = data.board[i]
            if ent then
                table.insert(options, {
                    title       = locale('multijobmenu.job_leaderboard_slot_title', { rank = i, name = ent.name }),
                    description = locale('multijobmenu.job_leaderboard_slot_description', { score = ent.score }),
                    icon        = 'user',
                    readOnly    = true
                })
            else
                table.insert(options, {
                    title       = locale('multijobmenu.job_leaderboard_empty_slot_title', { rank = i }),
                    description = locale('multijobmenu.job_leaderboard_empty_slot_description'),
                    icon        = 'user-slash',
                    readOnly    = true
                })
            end
        end

        table.insert(options, {
            title       = locale('multijobmenu.job_leaderboard_your_score_title'),
            description = locale('multijobmenu.job_leaderboard_your_score_description', { score = data.personal }),
            icon        = 'star',
            readOnly    = true
        })

        table.insert(options, {
            title    = locale('multijobmenu.job_leaderboard_go_back'),
            icon     = 'arrow-left',
            onSelect = function()
                if _lastMenu == 'boss' then
                    OpenBossMenu()
                else
                    OpenActiveJobOptions(jobName, selectedJobGrade, displayJobName)
                end
            end
        })

        lib.registerContext({
            id       = 'job_leaderboard_menu',
            title    = locale('multijobmenu.job_leaderboard_title', { displayJobName = displayJobName }),
            options  = options,
            canClose = true
        })
        lib.showContext('job_leaderboard_menu')
    end, jobName)
end

--- Function to open options for the currently active job.
--- @param jobName string           The key of the job.
--- @param selectedJobGrade number  The grade of the job.
--- @param displayJobName string    The formatted name to display.
OpenActiveJobOptions = function(jobName, selectedJobGrade, displayJobName)
    _lastMenu = 'active'
    currentJobName, currentJobGrade, currentDisplayName = jobName, selectedJobGrade, displayJobName

    lib.callback('sd-multijob:server:getJobStats', false, function(stats)
        local lifetimeMin        = stats.minutesWorked or 0
        local weeklyMin          = stats.weeklyMinutesWorked or 0
        local weeklyHours        = weeklyMin / 60
        local targetWeeklyHours  = stats.targetWeeklyHours or 1
        local percentage         = math.min(100, math.floor((weeklyHours / targetWeeklyHours) * 100))
        local reachedTarget      = weeklyHours >= targetWeeklyHours

        local rewardEnabled      = stats.weeklyRewardEnabled or false
        local rewardAmount       = stats.weeklyRewardAmount or 0
        local rewardRedeemed     = stats.weeklyRewardRedeemed or false

        local hoursDesc
        if reachedTarget then
            hoursDesc = locale('multijobmenu.weekly_goal_achieved', { targetWeeklyHours = targetWeeklyHours })
        else
            hoursDesc = locale('multijobmenu.weekly_hours_status', {
                weeklyHours       = string.format('%.1f', weeklyHours),
                targetWeeklyHours = targetWeeklyHours
            })
        end

        if rewardEnabled then
            if reachedTarget then
                if not rewardRedeemed then
                    hoursDesc = hoursDesc .. locale('multijobmenu.claim_bonus_tap', { rewardAmount = rewardAmount })
                else
                    hoursDesc = hoursDesc .. locale('multijobmenu.bonus_claimed',    { rewardAmount = rewardAmount })
                end
            else
                hoursDesc = hoursDesc .. locale('multijobmenu.earn_bonus_when', {
                    rewardAmount       = rewardAmount,
                    targetWeeklyHours  = targetWeeklyHours
                })
            end
        end

        lib.callback('sd-multijob:server:getNotifications', false, function(notifs)
            local count     = #notifs
            local notifColor
            if count >= 4 then
                notifColor = 'red'
            elseif count >= 2 then
                notifColor = 'orange'
            elseif count == 1 then
                notifColor = 'yellow'
            end

            local options = {}

            if Config.Stats.enable then
                table.insert(options, {
                    title       = locale('multijobmenu.active_option_view_stats_title'),
                    description = locale('multijobmenu.active_option_view_stats_desc', { displayJobName = displayJobName }),
                    icon        = 'chart-bar',
                    onSelect    = function()
                        ShowJobStats(jobName, selectedJobGrade, displayJobName)
                    end
                })
            end

            table.insert(options, {
                title       = locale('multijobmenu.active_option_weekly_hours_title', {
                    weeklyHours       = string.format('%.1f', weeklyHours),
                    targetWeeklyHours = targetWeeklyHours
                }),
                description = hoursDesc,
                icon        = 'clock',
                iconColor   = reachedTarget and 'gold' or nil,
                progress    = percentage,
                colorScheme = reachedTarget and 'gold' or 'blue',
                readOnly    = not (rewardEnabled and reachedTarget and not rewardRedeemed),
                arrow       = (rewardEnabled and reachedTarget and not rewardRedeemed) or nil,
                onSelect    = function()
                    if rewardEnabled and reachedTarget and not rewardRedeemed then
                        lib.callback('sd-multijob:server:claimWeeklyReward', false, function(ok, amt)
                            if ok then
                                ShowNotification(locale('multijobmenu.notify_message_sent'), 'success')
                            else
                                ShowNotification(locale('multijobmenu.notify_message_failed'), 'error')
                            end
                            OpenActiveJobOptions(jobName, selectedJobGrade, displayJobName)
                        end, jobName)
                    else
                        ShowNotification(locale('multijobmenu.weekly_hours_status', {
                            weeklyHours       = string.format('%.1f', weeklyHours),
                            targetWeeklyHours = targetWeeklyHours
                        }), 'success')
                    end
                end
            })

            if Config.Leaderboard.enable then
                table.insert(options, {
                    title       = locale('multijobmenu.job_leaderboard_title', { displayJobName = displayJobName }),
                    description = locale('multijobmenu.job_leaderboard_desc', { job = displayJobName }),
                    icon        = 'trophy',
                    arrow       = true,
                    onSelect    = function()
                        OpenJobLeaderboard(jobName, selectedJobGrade, displayJobName)
                    end
                })
            end

            if Config.EnableBonuses or Config.EnableMessages.enable then
                table.insert(options, {
                    title       = locale('multijobmenu.active_option_notifications_title', { count = count }),
                    description = locale('multijobmenu.active_option_notifications_desc'),
                    icon        = 'bell',
                    iconColor   = notifColor,
                    arrow       = true,
                    onSelect    = OpenNotificationsMenu
                })
            end

            if Config.EnableMessages.enable and Config.EnableMessages.enableMessagesToBoss then
                table.insert(options, {
                    title       = locale('multijobmenu.active_option_send_message_title'),
                    description = locale('multijobmenu.active_option_send_message_desc'),
                    icon        = 'envelope',
                    onSelect    = function()
                        local values = lib.inputDialog(
                            locale('multijobmenu.active_option_send_message_title'),
                            {
                                { type = 'input',    label = locale('multijobmenu.send_message_label_subject') },
                                { type = 'textarea', label = locale('multijobmenu.send_message_label_message') }
                            },
                            { allowCancel = true }
                        )
                        if not values then
                            return OpenActiveJobOptions(jobName, selectedJobGrade, displayJobName)
                        end

                        local subject, msg = values[1], values[2]
                        local choice = lib.alertDialog({
                            header   = locale('multijobmenu.send_message_confirm_header'),
                            content  = locale('multijobmenu.send_message_confirm_content', {
                                displayJobName = displayJobName,
                                subject        = subject,
                                msg            = msg
                            }),
                            centered = true,
                            cancel   = true,
                            size     = 'md',
                            overflow = true,
                            labels   = {
                                confirm = locale('multijobmenu.send_message_confirm_yes'),
                                cancel  = locale('multijobmenu.send_message_confirm_no')
                            }
                        })
                        if choice == 'confirm' then
                            lib.callback('sd-multijob:server:sendBossMessage', false, function(success)
                                if success then
                                    ShowNotification(locale('multijobmenu.notify_message_sent'), 'success')
                                else
                                    ShowNotification(locale('multijobmenu.notify_message_failed'), 'error')
                                end
                                OpenActiveJobOptions(jobName, selectedJobGrade, displayJobName)
                            end, jobName, subject, msg)
                        else
                            OpenActiveJobOptions(jobName, selectedJobGrade, displayJobName)
                        end
                    end
                })
            end

            table.insert(options, {
                title       = locale('multijobmenu.active_option_remove_job_title'),
                description = locale('multijobmenu.active_option_remove_job_desc', { displayJobName = displayJobName }),
                icon        = 'trash',
                onSelect    = function()
                    local choice = lib.alertDialog({
                        header   = locale('multijobmenu.job_confirmation_confirm_removal_header'),
                        content  = locale('multijobmenu.job_confirmation_confirm_removal_content', { displayJobName = displayJobName }),
                        centered = true,
                        cancel   = true,
                        size     = 'md',
                        overflow = true,
                        labels   = {
                            confirm = locale('multijobmenu.job_confirmation_confirm_removal_yes'),
                            cancel  = locale('multijobmenu.job_confirmation_confirm_removal_cancel')
                        }
                    })
                    if choice == 'confirm' then
                        lib.callback('sd-multijob:server:removeJobFromPlayer', false, function(success)
                            if success then
                                ShowNotification(locale('multijobmenu.notify_remove_permanent_success', { displayJobName = displayJobName }), 'success')
                            else
                                ShowNotification(locale('multijobmenu.notify_remove_permanent_failure', { displayJobName = displayJobName }), 'error')
                            end
                            TriggerEvent('sd-multijob:client:openJobsMenu')
                        end, jobName)
                    else
                        OpenActiveJobOptions(jobName, selectedJobGrade, displayJobName)
                    end
                end
            })

            table.insert(options, {
                title    = locale('multijobmenu.active_option_return_to_selector'),
                icon     = 'arrow-left',
                onSelect = function()
                    TriggerEvent('sd-multijob:client:openJobsMenu')
                end
            })

            lib.registerContext({
                id       = 'active_job_options_menu',
                title    = locale('multijobmenu.main_title', { job = displayJobName }),
                canClose = true,
                options  = options
            })
            lib.showContext('active_job_options_menu')
        end)
    end, jobName)
end

RegisterNetEvent('sd-multijob:client:openActiveJobs', OpenActiveJobOptions)

--- Show the notifications submenu.
--- Fetches all pending notifications (bonuses and messages), displays time until expiry,
--- and lets the player either redeem a bonus or read/delete a message.
OpenNotificationsMenu = function()
    lib.callback('sd-multijob:server:getNotifications', false, function(notifs)
        local opts = {}

        if #notifs == 0 then
            table.insert(opts, {
                title       = locale('multijobmenu.notifications_no_notifications_title'),
                description = locale('multijobmenu.notifications_no_notifications_description'),
                icon        = 'bell-slash',
                readOnly    = true
            })
        else
            for _, n in ipairs(notifs) do
                local expiresText
                if n.timeLeft and n.timeLeft > 0 then
                    local secs    = n.timeLeft
                    local days    = math.floor(secs / 86400);   secs = secs % 86400
                    local hours   = math.floor(secs / 3600);    secs = secs % 3600
                    local minutes = math.ceil(secs / 60)
                    expiresText   = locale('multijobmenu.notifications_expires_in', {
                        days    = days,
                        hours   = hours,
                        minutes = minutes
                    })
                else
                    expiresText = locale('multijobmenu.notifications_expired')
                end

                if n.type == 'bonus' then
                    table.insert(opts, {
                        title       = n.message,
                        description = expiresText,
                        icon        = 'gift',
                        iconColor   = 'gold',
                        arrow       = true,
                        onSelect    = function()
                            local choice = lib.alertDialog({
                                header   = locale('multijobmenu.notifications_bonus_available_header'),
                                content  = locale('multijobmenu.notifications_bonus_content', {
                                    amount     = n.amount,
                                    expiresText = expiresText
                                }),
                                centered = true,
                                cancel   = true,
                                size     = 'md',
                                overflow = true,
                                labels   = {
                                    confirm = locale('multijobmenu.notifications_bonus_confirm'),
                                    cancel  = locale('multijobmenu.notifications_bonus_cancel')
                                }
                            })
                            if choice == 'confirm' then
                                lib.callback('sd-multijob:server:redeemBonus', false, function(ok, amt)
                                    if ok then
                                        ShowNotification(locale('notifications.bonus_redeemed', { amount = amt }), 'success')
                                    else
                                        ShowNotification(locale('notifications.bonus_redeem_failed'), 'error')
                                    end
                                    OpenNotificationsMenu()
                                end, n.id)
                            else
                                OpenNotificationsMenu()
                            end
                        end
                    })
                elseif n.type == 'message' then
                    table.insert(opts, {
                        title       = locale('multijobmenu.notifications_message_title', { subject = n.subject }),
                        description = locale('multijobmenu.notifications_message_description', {
                            sender     = n.sender,
                            expiresText = expiresText
                        }),
                        icon        = 'envelope',
                        arrow       = true,
                        onSelect    = function()
                            lib.registerContext({
                                id       = 'notif_action_' .. n.id,
                                title    = locale('multijobmenu.notifications_message_menu_title'),
                                canClose = true,
                                options  = {
                                    {
                                        title       = locale('multijobmenu.notifications_action_read_title'),
                                        description = locale('multijobmenu.notifications_action_read_description'),
                                        icon        = 'envelope-open',
                                        onSelect    = function()
                                            lib.alertDialog({
                                                header   = n.subject,
                                                content  = string.format(
                                                    'From: %s\n\n%s\n\n%s',
                                                    n.sender, n.message, expiresText
                                                ),
                                                centered = true,
                                                cancel   = true,
                                                size     = 'md',
                                                overflow = true,
                                                labels   = {
                                                    confirm = locale('multijobmenu.notifications_ok')
                                                }
                                            })
                                            OpenNotificationsMenu()
                                        end
                                    },
                                    {
                                        title    = locale('multijobmenu.notifications_action_delete_title'),
                                        description = locale('multijobmenu.notifications_action_delete_description'),
                                        icon     = 'trash',
                                        onSelect = function()
                                            lib.callback('sd-multijob:server:deleteNotification', false, function(ok)
                                                if ok then
                                                    ShowNotification(locale('notifications.notification_removed'), 'success')
                                                else
                                                    ShowNotification(locale('notifications.notification_remove_failed'), 'error')
                                                end
                                                OpenNotificationsMenu()
                                            end, n.id)
                                        end
                                    },
                                    {
                                        title    = locale('multijobmenu.notifications_back'),
                                        icon     = 'arrow-left',
                                        onSelect = OpenNotificationsMenu
                                    }
                                }
                            })
                            lib.showContext('notif_action_' .. n.id)
                        end
                    })
                end
            end
        end

        table.insert(opts, {
            title    = locale('multijobmenu.notifications_back'),
            icon     = 'arrow-left',
            onSelect = function()
                OpenActiveJobOptions(currentJobName, currentJobGrade, currentDisplayName)
            end
        })

        lib.registerContext({
            id       = 'notifications_menu',
            title    = locale('multijobmenu.notifications_title'),
            options  = opts,
            canClose = true
        })
        lib.showContext('notifications_menu')
    end)
end

RegisterNetEvent('sd-multijob:client:activeJobChanged', function(jobName)
    activeJob = jobName
    ClearPerformanceCaches()
end)

--- Toggle the player's duty status via server callback
local ToggleDuty = function()
    lib.callback('sd-multijob:server:toggleDuty', false, function(success)
        TriggerEvent('sd-multijob:client:openJobsMenu')
    end)
end

RegisterNetEvent('sd-multijob:client:setDuty', function(duty)
    if duty == nil then
        ShowNotification(locale('notifications.duty_toggle_error'), 'error')
        return
    end

    onDuty = duty

    local stateText = duty  and locale('notifications.duty_on_short')  or locale('notifications.duty_off_short')

    ShowNotification(locale('notifications.toggle_duty_notification', { state = stateText }), 'success')
end)

-- Event handler for clearing boss cache when server cache is cleared
RegisterNetEvent('sd-multijob:client:clearBossCache', function(jobName)
    ClearBossCacheForJob(jobName)
end)


--- Open the main jobs menu
--- Retrieves the player's active job, duty status, and saved jobs, then displays them.
local OpenMyJobsMenu = function()
    lib.callback('sd-multijob:server:getActiveGroup', false, function(activeData)
        local newActiveJob = activeData and activeData.job or nil
        if activeJob ~= newActiveJob then
            ClearPerformanceCaches()
        end
        activeJob = newActiveJob
        onDuty    = activeData and activeData.onDuty or false

        lib.callback('sd-multijob:server:retrieveJobs', false, function(jobs)
            if not jobs or next(jobs) == nil then
                ShowNotification(locale('notifications.no_roles_error'), 'error')
                return
            end

            local cfg = activeJob and Config.Zones[activeJob]
            local outsideZone = cfg
                and cfg.dutyZone
                and cfg.dutyZone.enabled
                and not insideDutyZone[activeJob]

            local function buildMenu(isBoss)
                local options       = {}

                local disableToggle = (not onDuty)
                    and outsideZone
                    and (not (cfg.dutyZone.bossImmune and isBoss))

  

                table.insert(options, {
                    title       = locale('multijobmenu.toggle_duty_title'),
                    icon        = onDuty and 'toggle-on' or 'toggle-off',
                    iconColor   = onDuty and 'green' or 'red',
                    onSelect    = ToggleDuty,
                    disabled    = disableToggle,
                })

                local activeJobOption
                local otherJobOptions = {}

                for jobName, data in pairs(jobs) do
                    local grade = data.grade or 1
                    local jobCfg = Config.Jobs[jobName]
                    if not jobCfg then goto continue end

                    local displayName = jobCfg.label
                      or (jobName:sub(1,1):upper() .. jobName:sub(2))
                    local marker    = (jobName == activeJob)
                      and locale('multijobmenu.current_marker') or ''
                    local titleText = displayName .. marker
                    local iconColor = (jobName == activeJob) and 'gold' or 'white'
                    local gradeLabel = jobCfg.gradeLabels[grade] or tostring(grade)
                    local salary     = jobCfg.salaries[grade] or 0
                    local description = locale('multijobmenu.grade_salary_description', {
                        gradeLabel = gradeLabel,
                        grade      = grade,
                        salary     = salary
                    })

                    local entry = {
                        title       = titleText,
                        description = description,
                        icon        = jobCfg.icon or 'briefcase',
                        iconColor   = iconColor,
                        arrow       = true,
                        onSelect    = function()
                            if jobName == activeJob then
                                OpenActiveJobOptions(jobName, grade, displayName)
                            else
                                OpenJobConfirmation(jobName, grade, displayName)
                            end
                        end,
                    }

                    if jobName == activeJob then
                        activeJobOption = entry
                    else
                        table.insert(otherJobOptions, entry)
                    end

                    ::continue::
                end

                if activeJobOption then
                    table.insert(options, activeJobOption)
                end
                for _, opt in ipairs(otherJobOptions) do
                    table.insert(options, opt)
                end

                lib.registerContext({
                    id       = 'my_jobs_menu',
                    title    = locale('multijobmenu.my_jobs_title'),
                    canClose = true,
                    options  = options,
                })
                lib.showContext('my_jobs_menu')
            end

            if outsideZone and cfg.dutyZone.bossImmune then
                CheckIsBoss(activeJob, function(isBoss)
                    buildMenu(isBoss)
                end)
            else
                buildMenu(false)
            end
        end)
    end)
end


RegisterNetEvent('sd-multijob:client:openJobsMenu', OpenMyJobsMenu)

if Config.Multijob.enable then
    RegisterCommand(Config.Command.name, OpenMyJobsMenu, false)

    if Config.Command.keybind.enabled then
        local description = 'Open MultiJob Menu'
        RegisterKeyMapping(Config.Command.name, description, 'keyboard', Config.Command.keybind.key)
    end
end
--- Fetch all boss data in one go, then invoke cb(data) (with performance caching).
--- If player isn't a boss, show error and do not call cb.
--- @param cb function
--- @param forceRefresh boolean Optional - force refresh cache
local FetchBossData = function(cb, forceRefresh)
    local now = GetGameTimer()
    local cached = bossDataCache[activeJob]


    if not forceRefresh and cached and (now - cached.timestamp) < bossDataCacheDuration then
        bossData = cached.data
        cb(bossData)
        return
    end
    
    lib.callback('sd-multijob:server:getBossData', false, function(data)
        if data == false then
            ShowNotification(
                locale('notifications.boss_not_assigned_error'),'error')
            return
        end
        
        bossData = data or bossData
        bossDataCache[activeJob] = {
            data = bossData,
            timestamp = now
        }
        
        cb(bossData)
    end)
end

--- Utility: get iconColor based on online/on-duty status
--- @param emp table Employee entry with `online` and `onDuty` booleans
--- @return string 'green', 'orange', or 'red'
local GetEmployeeStatusColor = function(emp)
    if not emp.online then
        return 'red'
    elseif emp.onDuty then
        return 'green'
    else
        return 'orange'
    end
end

--- Show detailed info and weekly progress for one employee
--- @param emp table  Employee entry
local OpenEmployeeInformation = function(emp)
    lib.callback('sd-multijob:server:getEmployeeJobStats', false, function(stats)
        local cfg     = Config.Stats[bossData.jobName] or {}
        local options = {}

        local statusDesc = not emp.online
            and locale('bossmenu.emp_info_status_offline')
            or emp.onDuty
                and locale('bossmenu.emp_info_status_on_duty')
                or locale('bossmenu.emp_info_status_off_duty')

        table.insert(options, {
            title       = locale('bossmenu.emp_info_details_title'),
            description = locale('bossmenu.emp_info_details_description', {
                name       = emp.name,
                identifier = emp.identifier,
                status     = statusDesc
            }),
            icon     = emp.online and (emp.onDuty and 'briefcase' or 'wifi') or 'times-circle',
            readOnly = true
        })

        local lifetimeMin = stats.minutesWorked or 0
        table.insert(options, {
            title       = locale('bossmenu.emp_info_time_on_duty_title'),
            description = FormatMinutesWorked(lifetimeMin, locale('misc.minutes_worked_pronoun_default')),
            icon        = 'clock',
            readOnly    = true
        })

        local weeklyMin       = stats.weeklyMinutesWorked or 0
        local weeklyHrs       = weeklyMin / 60
        local targetWeeklyHrs = stats.targetWeeklyHours  or 1
        local pct             = math.min(100, math.floor((weeklyHrs / targetWeeklyHrs) * 100))
        local reachedTarget   = weeklyHrs >= targetWeeklyHrs

        table.insert(options, {
            title       = locale('bossmenu.emp_info_weekly_hours_title', {
                weeklyHrs        = string.format('%.1f', weeklyHrs),
                targetWeeklyHours = targetWeeklyHrs
            }),
            description = locale('bossmenu.emp_info_weekly_hours_description', {
                weeklyHrs        = string.format('%.1f', weeklyHrs),
                targetWeeklyHours = targetWeeklyHrs
            }),
            icon        = 'chart-bar',
            iconColor   = reachedTarget and 'gold' or nil,
            progress    = pct,
            colorScheme = reachedTarget and 'gold' or 'blue',
            readOnly    = true
        })

        for _, statInfo in ipairs(cfg) do
            if statInfo.key ~= 'minutesWorked' and statInfo.key ~= 'weeklyMinutesWorked' then
                local amt  = stats[statInfo.key] or 0
                local desc = (statInfo.description or '')
                    :gsub('{amount}', tostring(amt))
                    :gsub('^You ', 'They have ')
                table.insert(options, {
                    title       = statInfo.title,
                    description = desc,
                    icon        = statInfo.icon,
                    readOnly    = true
                })
            end
        end

        table.insert(options, {
            title    = locale('bossmenu.emp_info_back'),
            icon     = 'arrow-left',
            onSelect = function() OpenEmployeeStats(emp) end
        })

        lib.registerContext({
            id       = 'boss_emp_info_' .. emp.identifier,
            title    = emp.name .. ' — ' .. locale('bossmenu.emp_info_details_title'),
            canClose = true,
            options  = options
        })
        lib.showContext('boss_emp_info_' .. emp.identifier)
    end, emp.identifier)
end

--- Show one employee’s management menu
--- @param emp table  Employee entry with identifier, name, grade, online, onDuty
OpenEmployeeStats = function(emp)
    local options = {
        {
            title       = locale('bossmenu.emp_stats_information_title'),
            description = locale('bossmenu.emp_stats_information_description'),
            icon        = 'info-circle',
            onSelect    = function()
                OpenEmployeeInformation(emp)
            end
        },
        {
            title       = locale('bossmenu.emp_stats_change_grade_title'),
            description = locale('bossmenu.emp_stats_change_grade_description'),
            icon        = 'level-up',
            onSelect    = function()
                local gradeLabels = Config.Jobs[bossData.jobName].gradeLabels or {}
                local gradeOptions = {}

                for grade, lbl in pairs(gradeLabels) do
                    table.insert(gradeOptions, {
                        value = grade,
                        label = string.format('%s [%d]', lbl, grade)
                    })
                end

                table.sort(gradeOptions, function(a, b)
                    return a.value < b.value
                end)

                local values = lib.inputDialog(
                    locale('bossmenu.emp_stats_change_grade_title'),
                    {
                        {
                            type    = 'select',
                            label   = locale('bossmenu.emp_stats_change_grade_title'),
                            options = gradeOptions,
                            default = emp.grade
                        }
                    },
                    { allowCancel = true }
                )
                if not values then
                    return OpenEmployeeStats(emp)
                end

                local newGrade = tonumber(values[1])
                local newLabel = gradeLabels[newGrade] or tostring(newGrade)

                local choice = lib.alertDialog({
                    header   = locale('bossmenu.emp_stats_confirm_grade_change_header'),
                    content  = locale('bossmenu.emp_stats_confirm_grade_change_content', {
                        name       = emp.name,
                        identifier = emp.identifier,
                        newLabel   = newLabel,
                        newGrade   = newGrade
                    }),
                    centered = true,
                    cancel   = true,
                    size     = 'md',
                    overflow = true,
                    labels   = {
                        confirm = locale('bossmenu.emp_stats_confirm_yes'),
                        cancel  = locale('bossmenu.emp_stats_confirm_no')
                    }
                })

                if choice == 'confirm' then
                    lib.callback(
                        'sd-multijob:server:setEmployeeGrade',
                        false,
                        function(success)
                            if success then
                                ShowNotification(
                                    locale('bossmenu.emp_stats_change_grade_success', {
                                        name     = emp.name,
                                        newLabel = newLabel
                                    }),
                                    'success'
                                )
                                for i, employee in ipairs(bossData.employees) do
                                    if employee.identifier == emp.identifier then
                                        bossData.employees[i].grade = newGrade
                                        break
                                    end
                                end
                            else
                                ShowNotification(
                                    locale('bossmenu.emp_stats_change_grade_failure'),
                                    'error'
                                )
                            end
                            OpenEmployeeStats(emp)
                        end,
                        emp.identifier,
                        newGrade
                    )
                else
                    OpenEmployeeStats(emp)
                end
            end
        },
        {
            title       = locale('bossmenu.emp_stats_fire_title'),
            description = locale('bossmenu.emp_stats_fire_description'),
            icon        = 'user-minus',
            onSelect    = function()
                local choice = lib.alertDialog({
                    header   = locale('bossmenu.emp_stats_confirm_termination_header'),
                    content  = locale('bossmenu.emp_stats_confirm_termination_content', {
                        name       = emp.name,
                        identifier = emp.identifier
                    }),
                    centered = true,
                    cancel   = true,
                    size     = 'md',
                    overflow = true,
                    labels   = {
                        confirm = locale('bossmenu.emp_stats_fire_title'),
                        cancel  = locale('bossmenu.emp_stats_back')
                    }
                })

                if choice == 'confirm' then
                    lib.callback(
                        'sd-multijob:server:removeEmployee',
                        false,
                        function(success)
                            if success then
                                ShowNotification(
                                    locale('bossmenu.emp_stats_fire_success', { name = emp.name }),
                                    'success'
                                )
                                for i = #bossData.employees, 1, -1 do
                                    if bossData.employees[i].identifier == emp.identifier then
                                        table.remove(bossData.employees, i)
                                        break
                                    end
                                end
                                TriggerEvent('sd-multijob:client:openEmployeeMenu')
                            end
                        end,
                        emp.identifier
                    )
                else
                    OpenEmployeeStats(emp)
                end
            end
        }
    }

    if Config.EnableBonuses then
        table.insert(options, {
            title       = locale('bossmenu.emp_stats_bonus_title'),
            description = locale('bossmenu.emp_stats_bonus_description'),
            icon        = 'gift',
            onSelect    = function()
                local values = lib.inputDialog(
                    locale('bossmenu.emp_stats_bonus_title'),
                    {
                        { type = 'number', label = locale('bossmenu.emp_stats_bonus_title'), min = 1 }
                    },
                    { allowCancel = true }
                )
                if not values then
                    return OpenEmployeeStats(emp)
                end

                local bonus = tonumber(values[1])

                local choice = lib.alertDialog({
                    header   = locale('bossmenu.emp_stats_confirm_bonus_header'),
                    content  = locale('bossmenu.emp_stats_confirm_bonus_content', {
                        bonus      = bonus,
                        name       = emp.name,
                        identifier = emp.identifier
                    }),
                    centered = true,
                    cancel   = true,
                    size     = 'md',
                    overflow = true,
                    labels   = {
                        confirm = locale('bossmenu.emp_stats_confirm_yes'),
                        cancel  = locale('bossmenu.emp_stats_confirm_no')
                    }
                })

                if choice == 'confirm' then
                    lib.callback(
                        'sd-multijob:server:giveEmployeeBonus',
                        false,
                        function(success)
                            if success then
                                ShowNotification(
                                    locale('bossmenu.emp_stats_bonus_success', {
                                        bonus = bonus,
                                        name  = emp.name
                                    }),
                                    'success'
                                )
                            else
                                ShowNotification(
                                    locale('bossmenu.emp_stats_bonus_failure'),
                                    'error'
                                )
                            end
                            OpenEmployeeStats(emp)
                        end,
                        emp.identifier,
                        bonus
                    )
                else
                    OpenEmployeeStats(emp)
                end
            end
        })
    end

    if Config.EnableMessages.enable and Config.EnableMessages.enableMessagesToEmployees then
        table.insert(options, {
            title       = locale('bossmenu.emp_stats_send_message_title'),
            description = locale('bossmenu.emp_stats_send_message_description'),
            icon        = 'envelope',
            onSelect    = function()
                local values = lib.inputDialog(
                    locale('bossmenu.emp_stats_send_message_title'),
                    {
                        { type = 'input',    label = locale('bossmenu.emp_stats_send_message_title') },
                        { type = 'textarea', label = locale('bossmenu.emp_stats_send_message_title') }
                    },
                    { allowCancel = true }
                )
                if not values then
                    return OpenEmployeeStats(emp)
                end

                local subject, msg = values[1], values[2]

                local choice = lib.alertDialog({
                    header   = locale('bossmenu.emp_stats_confirm_send_header'),
                    content  = locale('bossmenu.emp_stats_confirm_send_content', {
                        name       = emp.name,
                        identifier = emp.identifier,
                        subject    = subject,
                        msg        = msg
                    }),
                    centered = true,
                    cancel   = true,
                    size     = 'md',
                    overflow = true,
                    labels   = {
                        confirm = locale('bossmenu.emp_stats_confirm_yes'),
                        cancel  = locale('bossmenu.emp_stats_confirm_no')
                    }
                })

                if choice == 'confirm' then
                    lib.callback(
                        'sd-multijob:server:sendEmployeeMessage',
                        false,
                        function(success)
                            if success then
                                ShowNotification(
                                    locale('bossmenu.emp_stats_message_sent', { name = emp.name }),
                                    'success'
                                )
                            else
                                ShowNotification(
                                    locale('bossmenu.emp_stats_message_failed'),
                                    'error'
                                )
                            end
                            OpenEmployeeStats(emp)
                        end,
                        emp.identifier,
                        subject,
                        msg
                    )
                else
                    OpenEmployeeStats(emp)
                end
            end
        })
    end

    table.insert(options, {
        title    = locale('bossmenu.emp_stats_back'),
        icon     = 'arrow-left',
        onSelect = function()
            TriggerEvent('sd-multijob:client:openEmployeeMenu')
        end
    })

    lib.registerContext({
        id       = 'boss_emp_stats_' .. emp.identifier,
        title    = emp.name .. ' — ' .. locale('bossmenu.emp_stats_information_title'),
        options  = options,
        canClose = true
    })
    lib.showContext('boss_emp_stats_' .. emp.identifier)
end

RegisterNetEvent('sd-multijob:client:openEmployeeStats', OpenEmployeeStats)


--- Opens a dialog to search employees, with one checkbox per grade.
local OpenEmployeeSearch = function()
    local inputs = {
        { type = 'input', label = locale('bossmenu.search_input_placeholder') }
    }
    local grades = {}
    for grade, label in pairs(Config.Jobs[bossData.jobName].gradeLabels or {}) do
        table.insert(inputs, {
            type  = 'checkbox',
            label = locale('bossmenu.search_checkbox_grade_label', {
                        label = label,
                        grade = grade
                      })
        })
        table.insert(grades, grade)
    end

    local values = lib.inputDialog(
        locale('bossmenu.search_title'),
        inputs,
        { allowCancel = true }
    )
    if not values then
        return TriggerEvent('sd-multijob:client:openEmployeeMenu')
    end

    local query = values[1]:lower()
    local gradeFilter = {}
    for i, grade in ipairs(grades) do
        if values[i + 1] then
            table.insert(gradeFilter, grade)
        end
    end

    local results = {}
    for _, emp in ipairs(bossData.employees) do
        local nameMatch  = emp.name:lower():find(query, 1, true)
        local idMatch    = emp.identifier:lower():find(query, 1, true)
        local gradeMatch = #gradeFilter == 0 or lib.table.contains(gradeFilter, emp.grade or 1)
        if (nameMatch or idMatch) and gradeMatch then
            table.insert(results, emp)
        end
    end

    local options = {}

    -- Search Again
    table.insert(options, {
        title       = locale('bossmenu.search_again_title'),
        description = locale('bossmenu.search_again_description'),
        icon        = 'search',
        onSelect    = function()
            TriggerEvent('sd-multijob:client:openEmployeeSearch')
        end
    })

    if #results == 0 then
        table.insert(options, {
            title       = locale('bossmenu.search_no_results_title'),
            description = locale('bossmenu.search_no_results_description'),
            icon        = 'user-slash',
            readOnly    = true
        })
    else
        for _, emp in ipairs(results) do
            local gradeLabels = Config.Jobs[bossData.jobName].gradeLabels or {}
            local grade       = emp.grade or 1
            local gradeLabel  = gradeLabels[grade] or tostring(grade)

            table.insert(options, {
                title       = emp.name,
                description = string.format(
                    '%s [%d]\nID: %s',
                    gradeLabel, grade, emp.identifier
                ),
                icon        = 'user',
                iconColor   = GetEmployeeStatusColor(emp),
                arrow       = true,
                onSelect    = function() OpenEmployeeStats(emp) end
            })
        end
    end

    -- Back
    table.insert(options, {
        title    = locale('bossmenu.menu_back'),
        icon     = 'arrow-left',
        onSelect = function() TriggerEvent('sd-multijob:client:openEmployeeMenu') end
    })

    lib.registerContext({
        id       = 'boss_employee_search_results',
        title    = locale('bossmenu.search_results_title'),
        options  = options,
        canClose = true
    })
    lib.showContext('boss_employee_search_results')
end

RegisterNetEvent('sd-multijob:client:openEmployeeSearch', OpenEmployeeSearch)

--- Opens the Employee Management submenu.
--- Shows a list of employees or a no-employees message if none exist.
local OpenEmployeeMenu = function()
    local options = {}

    if #bossData.employees == 0 then
        table.insert(options, {
            title       = locale('bossmenu.menu_no_employees_title'),
            description = locale('bossmenu.menu_no_employees_description'),
            icon        = 'user-slash',
            readOnly    = true
        })
        table.insert(options, {
            title    = locale('bossmenu.menu_back'),
            icon     = 'arrow-left',
            onSelect = function() OpenBossMenu() end
        })
    else
        -- Search Employees
        table.insert(options, {
            title       = locale('bossmenu.menu_search_title'),
            description = locale('bossmenu.menu_search_description'),
            icon        = 'search',
            onSelect    = function() OpenEmployeeSearch() end
        })

        for _, emp in ipairs(bossData.employees) do
            local gradeLabels = Config.Jobs[bossData.jobName].gradeLabels or {}
            local grade       = emp.grade or 1
            local gradeLabel  = gradeLabels[grade] or tostring(grade)

            table.insert(options, {
                title       = emp.name,
                description = string.format(
                    '%s [%d]\nID: %s',
                    gradeLabel, grade, emp.identifier
                ),
                icon        = 'user',
                iconColor   = GetEmployeeStatusColor(emp),
                arrow       = true,
                onSelect    = function() OpenEmployeeStats(emp) end
            })
        end

        -- Back
        table.insert(options, {
            title    = locale('bossmenu.menu_back'),
            icon     = 'arrow-left',
            onSelect = function() OpenBossMenu() end
        })
    end

    lib.registerContext({
        id       = 'boss_employee_menu',
        title    = locale('bossmenu.menu_title'),
        options  = options,
        canClose = true
    })
    lib.showContext('boss_employee_menu')
end

RegisterNetEvent('sd-multijob:client:openEmployeeMenu', OpenEmployeeMenu)

--- Opens the Society / Money Management submenu.
--- @param jobName string The job/society key
local OpenSocietyMenu = function(jobName)
    lib.callback('sd-multijob:server:getSocietyBalance', false, function(balance, txHistory)
        if balance == nil then
            ShowNotification(
                locale('notifications.society_data_error'),
                'error'
            )
            return
        end

        local options = {
            {
                title    = locale('bossmenu.society_balance_title', { balance = balance }),
                icon     = 'wallet',
                readOnly = true
            },
            {
                title       = locale('bossmenu.society_deposit_title'),
                description = locale('bossmenu.society_deposit_description'),
                icon        = 'arrow-circle-down',
                onSelect    = function()
                    local vals = lib.inputDialog(
                        locale('bossmenu.society_deposit_dialog_title'),
                        {
                            {
                                type    = 'select',
                                label   = locale('bossmenu.society_select_source_label'),
                                options = {
                                    { value = 'cash', label = locale('bossmenu.society_option_cash') },
                                    { value = 'bank', label = locale('bossmenu.society_option_bank') }
                                },
                                default = 'cash'
                            },
                            {
                                type  = 'number',
                                label = locale('bossmenu.amount_label'),
                                min   = 1
                            }
                        },
                        { allowCancel = true }
                    )
                    if not vals then
                        return TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
                    end

                    local moneyType = vals[1]
                    local amt       = tonumber(vals[2])
                    if not amt or amt <= 0 then
                        ShowNotification(
                            locale('notifications.invalid_amount'),
                            'error'
                        )
                        return TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
                    end

                    lib.callback('sd-multijob:server:depositSocietyFunds', false, function(newBalance)
                        if newBalance then
                            ShowNotification(locale('notifications.society_deposit_success', {amount = amt, moneyType = moneyType, newBalance = newBalance}),'success')
                        end
                        TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
                    end, jobName, amt, moneyType)
                end
            },
            {
                title       = locale('bossmenu.society_withdraw_title'),
                description = locale('bossmenu.society_withdraw_description'),
                icon        = 'arrow-circle-up',
                onSelect    = function()
                    local vals = lib.inputDialog(
                        locale('bossmenu.society_withdraw_dialog_title'),
                        {
                            {
                                type    = 'select',
                                label   = locale('bossmenu.society_select_destination_label'),
                                options = {
                                    { value = 'cash', label = locale('bossmenu.society_option_cash') },
                                    { value = 'bank', label = locale('bossmenu.society_option_bank') }
                                },
                                default = 'cash'
                            },
                            {
                                type  = 'number',
                                label = locale('bossmenu.amount_label'),
                                min   = 1
                            }
                        },
                        { allowCancel = true }
                    )
                    if not vals then
                        return TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
                    end

                    local moneyType = vals[1]
                    local amt       = tonumber(vals[2])
                    if not amt or amt <= 0 then
                        ShowNotification(
                            locale('notifications.invalid_amount'),
                            'error'
                        )
                        return TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
                    end

                    lib.callback('sd-multijob:server:withdrawSocietyFunds', false, function(newBalance)
                        if newBalance then
                            ShowNotification(locale('notifications.society_withdraw_success', {amount = amt, moneyType = moneyType, newBalance = newBalance}), 'success')
                        end
                        TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
                    end, jobName, amt, moneyType)
                end
            },
            {
                title       = locale('bossmenu.society_history_title', {
                                  jobName = jobName:sub(1,1):upper() .. jobName:sub(2)
                              }),
                description = locale('bossmenu.society_history_desc'),
                icon        = 'history',
                arrow       = true,
                onSelect    = function()
                    OpenTransactionHistoryMenu(jobName, txHistory)
                end
            },
            {
                title    = locale('bossmenu.menu_back'),
                icon     = 'arrow-left',
                onSelect = function() OpenBossMenu() end
            }
        }

        lib.registerContext({
            id       = 'boss_society_menu_' .. jobName,
            title    = locale('bossmenu.society_main_title', {
                          jobName = jobName:sub(1,1):upper() .. jobName:sub(2)
                      }),
            canClose = true,
            options  = options
        })
        lib.showContext('boss_society_menu_' .. jobName)
    end, jobName)
end

RegisterNetEvent('sd-multijob:client:openSocietyMenu', OpenSocietyMenu)

--- Opens the Transaction History submenu.
--- @param jobName string
--- @param txs     table Array of transactions
OpenTransactionHistoryMenu = function(jobName, txs)
    local options = {}

    if not txs or #txs == 0 then
        table.insert(options, {
            title       = locale('bossmenu.society_no_transactions_title'),
            description = locale('bossmenu.society_no_transactions_description'),
            icon        = 'exclamation-circle',
            readOnly    = true
        })
    else
        for i = #txs, 1, -1 do
            local tx    = txs[i]
            local key   = tx.action == 'deposit'
                and 'bossmenu.society_tx_deposit'
                or 'bossmenu.society_tx_withdrawal'
            local title = locale(key) .. ' — $' .. tx.amount

            local descKey = tx.action == 'deposit'
                and 'bossmenu.society_tx_deposited_desc'
                or 'bossmenu.society_tx_withdrawn_desc'
            local desc = locale(descKey, {
                name = tx.name,
                who  = tx.who,
                date = tx.date
            })

            local icon = tx.action == 'deposit'
                and 'arrow-circle-down'
                or 'arrow-circle-up'

            table.insert(options, {
                title       = title,
                description = desc,
                icon        = icon,
                readOnly    = true
            })
        end
    end

    table.insert(options, {
        title    = locale('bossmenu.menu_back'),
        icon     = 'arrow-left',
        onSelect = function()
            TriggerEvent('sd-multijob:client:openSocietyMenu', jobName)
        end
    })

    lib.registerContext({
        id       = 'boss_tx_history_' .. jobName,
        title    = locale('bossmenu.society_history_title', {
                      jobName = jobName:sub(1,1):upper() .. jobName:sub(2)
                  }),
        canClose = true,
        options  = options
    })
    lib.showContext('boss_tx_history_' .. jobName)
end

RegisterNetEvent('sd-multijob:client:openTransactionHistoryMenu', OpenTransactionHistoryMenu)

--- Show a single applicant’s answers and review options.
--- @param index     number   Submission index
--- @param questions table    Array of question strings
OpenSubmission = function(index, questions)
    lib.callback('sd-multijob:server:getApplicationData', false, function(data)
        local submissions = data.submissions or {}
        local sub = submissions[index]
        if not sub then
            ShowNotification(locale('bossmenu.application_not_found_error'), 'error')
            return OpenApplicationMenu()
        end

        local opts = {}

        table.insert(opts, {
            title       = locale('bossmenu.application_review_full_title'),
            description = locale('bossmenu.application_review_full_desc'),
            icon        = 'book-open',
            onSelect    = function()
                local content = ''
                for i, q in ipairs(questions) do
                    content = content
                        .. '**' .. q .. '**\n'
                        .. '> ' .. (sub.answers[i] or '') .. '\n\n'
                end
                lib.alertDialog({
                    header   = locale('bossmenu.application_alert_header', { name = sub.name }),
                    content  = content,
                    centered = true,
                    cancel   = true,
                    labels   = { confirm = locale('bossmenu.application_alert_ok') },
                    size     = 'md',
                    overflow = true
                })
                OpenSubmission(index, questions)
            end
        })

        table.insert(opts, {
            title       = locale('bossmenu.application_status_title', {
                              status = sub.status or locale('bossmenu.application_status_option_pending')
                          }),
            description = locale('bossmenu.application_status_desc'),
            icon        = 'check-circle',
            arrow       = true,
            onSelect    = function()
                local values = lib.inputDialog(
                    locale('bossmenu.application_status_dialog_title'),
                    {
                        {
                            type    = 'select',
                            label   = locale('bossmenu.application_status_select_label'),
                            options = {
                                { value = 'Accepted', label = locale('bossmenu.application_status_option_accepted') },
                                { value = 'Denied',   label = locale('bossmenu.application_status_option_denied') }
                            },
                            default = sub.status or locale('bossmenu.application_status_option_pending')
                        }
                    },
                    { allowCancel = true }
                )
                if not values then
                    return OpenSubmission(index, questions)
                end

                local newStatus = values[1]
                local ttlSeconds

                if newStatus == 'Denied' then
                    local hoursVal = lib.inputDialog(
                        locale('bossmenu.application_reapply_title', { name = sub.name }),
                        {
                            {
                                type    = 'number',
                                label   = locale('bossmenu.application_reapply_placeholder'),
                                default = 24,
                                min     = 0
                            }
                        },
                        { allowCancel = true }
                    )
                    if not hoursVal then
                        return OpenSubmission(index, questions)
                    end
                    ttlSeconds = (tonumber(hoursVal[1]) or 0) * 3600
                end

                lib.callback('sd-multijob:server:setApplicationStatus', false, function(ok)
                    if ok then
                        ShowNotification(locale('bossmenu.application_status_update_success', { newStatus = newStatus }), 'success')
                    else
                        ShowNotification(locale('bossmenu.application_status_update_failure'), 'error')
                    end
                    OpenSubmission(index, questions)
                end, bossData.jobName, index, newStatus, ttlSeconds)
            end
        })

        if sub.status == 'Accepted' and not sub.interview then
            table.insert(opts, {
                title       = locale('bossmenu.application_schedule_interview_title'),
                description = locale('bossmenu.application_schedule_interview_desc'),
                icon        = 'calendar-alt',
                arrow       = true,
                onSelect    = function()
                    local vals = lib.inputDialog(
                        locale('bossmenu.application_schedule_interview_dialog_title'),
                        {
                            {
                                type    = 'date',
                                label   = locale('bossmenu.application_schedule_interview_label_date'),
                                default = true
                            },
                            {
                                type    = 'time',
                                label   = locale('bossmenu.application_schedule_interview_label_time'),
                                default = true
                            },
                            {
                                type  = 'input',
                                label = locale('bossmenu.application_schedule_interview_label_location')
                            }
                        },
                        { allowCancel = true }
                    )
                    if not vals then
                        return OpenSubmission(index, questions)
                    end

                    local interview = {
                        date     = vals[1],
                        time     = vals[2],
                        location = vals[3]
                    }

                    lib.callback('sd-multijob:server:scheduleInterview', false, function(ok)
                        if ok then
                            ShowNotification(locale('bossmenu.application_schedule_interview_success'), 'success')
                        else
                            ShowNotification(locale('bossmenu.application_schedule_interview_failure'), 'error')
                        end
                        OpenSubmission(index, questions)
                    end, bossData.jobName, index, interview)
                end
            })
        end

        if sub.interview then
            local statusText = sub.interview.response
                or sub.interview.status
                or locale('bossmenu.application_interview_status_scheduled')
            table.insert(opts, {
                title       = locale('bossmenu.application_interview_entry_title', {
                                  date = sub.interview.date,
                                  time = sub.interview.time
                              }),
                description = locale('bossmenu.application_interview_entry_description', {
                                  location = sub.interview.location or 'TBD',
                                  status   = statusText
                              }),
                icon        = 'calendar-alt',
                arrow       = true,
                onSelect    = function()
                    local iopts = {
                        {
                            title       = locale('bossmenu.application_interview_confirm_title'),
                            description = locale('bossmenu.application_interview_confirm_desc', {
                                              date = sub.interview.date,
                                              time = sub.interview.time
                                          }),
                            icon        = 'check',
                            onSelect    = function()
                                lib.callback('sd-multijob:server:respondInterview', false, function(ok)
                                    if ok then
                                        ShowNotification(locale('bossmenu.application_interview_confirm_success'), 'success')
                                    end
                                    OpenSubmission(index, questions)
                                end, bossData.jobName, true)
                            end
                        },
                        {
                            title       = locale('bossmenu.application_interview_decline_title'),
                            description = locale('bossmenu.application_interview_decline_desc'),
                            icon        = 'times',
                            onSelect    = function()
                                lib.callback('sd-multijob:server:respondInterview', false, function(ok)
                                    if ok then
                                        ShowNotification(locale('bossmenu.application_interview_decline_success'), 'success')
                                    end
                                    OpenSubmission(index, questions)
                                end, bossData.jobName, false)
                            end
                        }
                    }
                    lib.registerContext({
                        id       = 'application_interview_' .. index,
                        title    = locale('bossmenu.application_interview_options_title'),
                        options  = iopts,
                        canClose = true
                    })
                    lib.showContext('application_interview_' .. index)
                end
            })
        end

        table.insert(opts, {
            title       = locale('bossmenu.application_delete_title'),
            description = locale('bossmenu.application_delete_desc'),
            icon        = 'trash',
            onSelect    = function()
                local choice = lib.alertDialog({
                    header   = locale('bossmenu.application_delete_confirm_header'),
                    content  = locale('bossmenu.application_delete_confirm_content', { name = sub.name }),
                    centered = true,
                    cancel   = true,
                    labels   = {
                      confirm = locale('bossmenu.application_delete_confirm'),
                      cancel  = locale('bossmenu.application_delete_cancel')
                    },
                    size     = 'md'
                })
                if choice == 'confirm' then
                    lib.callback('sd-multijob:server:deleteSubmission', false, function(ok)
                        if ok then
                            ShowNotification(locale('bossmenu.application_delete_success'), 'success')
                            OpenApplicationMenu()
                        else
                            ShowNotification(locale('bossmenu.application_delete_failure'), 'error')
                            OpenSubmission(index, questions)
                        end
                    end, bossData.jobName, index)
                else
                    OpenSubmission(index, questions)
                end
            end
        })

        table.insert(opts, {
            title    = locale('bossmenu.application_back'),
            icon     = 'arrow-left',
            onSelect = OpenApplicationMenu
        })

        lib.registerContext({
            id       = 'application_' .. index,
            title    = locale('bossmenu.application_entry_title', { name = sub.name }),
            options  = opts,
            canClose = true
        })
        lib.showContext('application_' .. index)
    end, bossData.jobName)
end

--- Manage the questions list for applications
OpenQuestionsMenu = function()
    lib.callback('sd-multijob:server:getApplicationData', false, function(data)
        local qs = data.questions or {}
        local opts = {}

        for idx, q in ipairs(qs) do
            table.insert(opts, {
                title       = q,
                description = locale('bossmenu.question_manage_desc'),
                icon        = 'edit',
                arrow       = true,
                onSelect    = function()
                    lib.registerContext({
                        id    = 'application_question_'..idx,
                        title = locale('bossmenu.question_entry_title', { idx = idx }),
                        options = {
                            {
                                title       = locale('bossmenu.question_edit_title'),
                                description = locale('bossmenu.question_edit_desc'),
                                icon        = 'pencil-alt',
                                onSelect    = function()
                                    local vals = lib.inputDialog(
                                        locale('bossmenu.question_edit_dialog_title'),
                                        {
                                            {
                                                type    = 'input',
                                                label   = locale('bossmenu.question_edit_label'),
                                                default = q
                                            }
                                        },
                                        { allowCancel = true }
                                    )
                                    if not vals then
                                        return OpenQuestionsMenu()
                                    end
                                    lib.callback('sd-multijob:server:editApplicationQuestion', false, function(ok)
                                        ShowNotification(locale(ok and 'bossmenu.question_edit_success' or 'bossmenu.question_edit_failure'), ok and 'success' or 'error')
                                        OpenQuestionsMenu()
                                    end, bossData.jobName, idx, vals[1])
                                end
                            },
                            {
                                title       = locale('bossmenu.question_remove_title'),
                                description = locale('bossmenu.question_remove_desc'),
                                icon        = 'trash',
                                onSelect    = function()
                                    lib.callback('sd-multijob:server:removeApplicationQuestion', false, function(ok)
                                        ShowNotification(locale(ok and 'bossmenu.question_remove_success' or 'bossmenu.question_remove_failure'), ok and 'success' or 'error')
                                        OpenQuestionsMenu()
                                    end, bossData.jobName, idx)
                                end
                            },
                            {
                                title       = locale('bossmenu.application_back'),
                                icon        = 'arrow-left',
                                onSelect    = OpenQuestionsMenu
                            }
                        }
                    })
                    lib.showContext('application_question_'..idx)
                end
            })
        end

        -- Add a new question
        table.insert(opts, {
            title       = locale('bossmenu.question_add_title'),
            description = locale('bossmenu.question_add_desc'),
            icon        = 'plus',
            onSelect    = function()
                local vals = lib.inputDialog(
                    locale('bossmenu.question_add_dialog_title'),
                    {
                        {
                            type  = 'input',
                            label = locale('bossmenu.question_add_label')
                        }
                    },
                    { allowCancel = true }
                )
                if not vals then
                    return OpenQuestionsMenu()
                end
                lib.callback('sd-multijob:server:addApplicationQuestion', false, function(ok)
                    ShowNotification(locale(ok and 'bossmenu.question_add_success' or 'bossmenu.question_add_failure'), ok and 'success' or 'error')
                    OpenQuestionsMenu()
                end, bossData.jobName, vals[1])
            end
        })

        -- Back
        table.insert(opts, {
            title       = locale('bossmenu.application_back'),
            icon        = 'arrow-left',
            onSelect    = OpenApplicationMenu
        })

        lib.registerContext({
            id       = 'application_questions_menu',
            title    = locale('bossmenu.questions_menu_title', { jobName = bossData.jobName }),
            options  = opts,
            canClose = true
        })
        lib.showContext('application_questions_menu')
    end, bossData.jobName)
end

--- Opens the edit-application flow with pre-filled textareas.
RegisterNetEvent('sd-multijob:client:openEditApplicationMenu', function(jobName, existingAnswers)
    lib.callback('sd-multijob:server:getApplicationData', false, function(data)
        local qs = data.questions or {}
        if #qs == 0 then
            ShowNotification(
                locale('notifications.no_form_error', { jobName = jobName }),
                'error'
            )
            return
        end

        local rows = {}
        for i, q in ipairs(qs) do
            table.insert(rows, {
                type        = 'textarea',
                label       = q,
                placeholder = '',
                default     = existingAnswers[i] or '',
                min         = Config.ApplicationInput.minLength or 1,
                max         = Config.ApplicationInput.maxLength or 500,
                autosize    = true
            })
        end

        local newAnswers = lib.inputDialog(
            locale('bossmenu.edit_application_title', { jobName = jobName:sub(1,1):upper() .. jobName:sub(2) }),
            rows,
            { allowCancel = true }
        )
        if not newAnswers then
            ShowNotification(locale('notifications.edit_cancelled'), 'error')
            return
        end

        local content = ''
        for i, q in ipairs(qs) do
            content = content
                .. '**' .. q .. '**\n'
                .. '> ' .. (newAnswers[i] or '') .. '\n\n'
        end

        local choice = lib.alertDialog({
            header   = locale('bossmenu.application_alert_header'),
            content  = content,
            centered = true,
            cancel   = true,
            labels   = {
                confirm = locale('bossmenu.application_alert_submit'),
                cancel  = locale('bossmenu.application_alert_cancel')
            },
            size     = 'md',
            overflow = true
        })

        if choice == 'confirm' then
            lib.callback('sd-multijob:server:editSubmission', false, function(ok)
                ShowNotification(locale(ok and 'notifications.application_updated' or 'notifications.application_update_error'), ok and 'success' or 'error')
            end, jobName, newAnswers)
        else
            ShowNotification(locale('notifications.edit_not_submitted'), 'error')
        end
    end, jobName)
end)

--- Add or replace the in-world application zone for a single job.
--- @param jobName string          The job key
--- @param coords  table {x,y,z}   The location to spawn at
local AddApplicationZone = function(jobName, coords)
    local zoneId = 'multijob_apply_' .. jobName

    if applicationZones[jobName] then
        Interaction.RemoveZone(applicationZones[jobName])
    end

    Interaction.AddCircleZone(zoneId, 'applicationZone_' .. jobName, vector3(coords.x, coords.y, coords.z), 1.5, {
        options = { {
            icon        = 'fas fa-file-signature',
            label       = locale('bossmenu.apply_for_label', { jobName = jobName:sub(1,1):upper() .. jobName:sub(2) }),
            canInteract = function() return true end,
            distance    = 3.0,
            action      = function()
                lib.callback('sd-multijob:server:getPlayerApplication', false, function(app)
                    if app then
                        local statusLabel = app.status
                        local reapplyText = ''
                        if app.timeLeft and app.status == 'Denied' then
                            local hrs  = math.floor(app.timeLeft / 3600)
                            local mins = math.floor((app.timeLeft % 3600) / 60)
                            reapplyText = '\n' .. locale('bossmenu.application_reapply_timer', { hours = hrs, minutes = mins })
                        end

                        local editDisabled = statusLabel ~= 'Pending'
                        local opts = {
                            {
                                title       = locale('bossmenu.application_already_status_title', { status = statusLabel }),
                                description = locale('bossmenu.application_already_desc_applied') .. reapplyText,
                                icon        = 'info-circle',
                                readOnly    = true
                            },
                            {
                                title       = locale('bossmenu.edit_application_option_edit_title'),
                                description = editDisabled
                                    and locale('bossmenu.edit_application_option_edit_disabled_desc', { status = statusLabel })
                                    or locale('bossmenu.edit_application_option_edit_desc'),
                                icon        = 'pencil-alt',
                                disabled    = editDisabled,
                                onSelect    = function()
                                    TriggerEvent('sd-multijob:client:openEditApplicationMenu', jobName, app.answers)
                                end
                            }
                        }

                        if app.interview then
                            local d, t = app.interview.date, app.interview.time
                            table.insert(opts, {
                                title       = locale('bossmenu.application_interview_entry_title', { date = d, time = t }),
                                description = locale('bossmenu.application_interview_entry_description', {
                                    location = app.interview.location or 'TBD',
                                    status   = app.interview.response or app.interview.status or 'Scheduled'
                                }),
                                icon        = 'calendar-alt',
                                arrow       = true,
                                onSelect    = function()
                                    local iopts = {
                                        {
                                            title       = locale('bossmenu.application_interview_confirm_title'),
                                            description = locale('bossmenu.application_interview_confirm_desc', { date = d, time = t }),
                                            icon        = 'check',
                                            onSelect    = function()
                                                lib.callback('sd-multijob:server:respondInterview', false, function(ok)
                                                    if ok then
                                                        ShowNotification(locale('bossmenu.application_interview_confirm_success'), 'success')
                                                    end
                                                end, jobName, true)
                                            end
                                        },
                                        {
                                            title       = locale('bossmenu.application_interview_decline_title'),
                                            description = locale('bossmenu.application_interview_decline_desc'),
                                            icon        = 'times',
                                            onSelect    = function()
                                                lib.callback('sd-multijob:server:respondInterview', false, function(ok)
                                                    if ok then
                                                        ShowNotification(locale('bossmenu.application_interview_decline_success'), 'success')
                                                    end
                                                end, jobName, false)
                                            end
                                        }
                                    }
                                    lib.registerContext({
                                        id       = 'application_interview_' .. jobName,
                                        title    = locale('bossmenu.application_interview_options_title'),
                                        options  = iopts,
                                        canClose = true
                                    })
                                    lib.showContext('application_interview_' .. jobName)
                                end
                            })
                        end

                        table.insert(opts, {
                            title    = locale('bossmenu.application_action_close'),
                            icon     = 'arrow-left',
                            onSelect = function() end
                        })

                        lib.registerContext({
                            id       = 'application_already_' .. jobName,
                            title    = locale('bossmenu.application_already_title', { jobName = jobName:sub(1,1):upper() .. jobName:sub(2) }),
                            options  = opts,
                            canClose = true
                        })
                        lib.showContext('application_already_' .. jobName)
                    else
                        TriggerEvent('sd-multijob:client:openApplyJobMenu', jobName)
                    end
                end, jobName)
            end
        } }
    }, Config.Debug)

    applicationZones[jobName] = zoneId
end

-- listen for single-zone updates from server
RegisterNetEvent('sd-multijob:client:updateApplicationZone', function(jobName, coords)
    AddApplicationZone(jobName, coords)
end)

-- when the server says “remove the old zone”
RegisterNetEvent('sd-multijob:client:removeApplicationZone', function(jobName)
    local zoneId = applicationZones[jobName]
    if zoneId then
        Interaction.RemoveZone(zoneId)
        applicationZones[jobName] = nil
    end
end)

--- Spawn all in-world application targets and handle apply/edit/respond flow
CreateApplicationTargets = function()
    lib.callback('sd-multijob:server:getApplicationLocations', false, function(locations)
        for _, loc in ipairs(locations) do
            AddApplicationZone(loc.job, loc.coords)
        end
    end)
end

-- call once on client start (after jobs load)
CreateThread(function()
    Wait(2000)
    CreateApplicationTargets()
end)

--- Converts a rotation vector to a direction vector.
-- This function converts rotation angles (in degrees) to a normalized direction vector.
---@param rotation vector3 The rotation angles (x, y, z).
---@return vector3 The normalized direction vector.
local RotationToDirection = function(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

--- Performs a raycast from the gameplay camera.
-- This function performs a raycast in the direction the gameplay camera is facing.
---@param distance number The maximum distance for the raycast.
---@return boolean, vector3, number Whether the raycast hit something, the coordinates of the hit, and the entity hit.
local RayCastGamePlayCamera = function(distance)
    local cameraRotation = GetGameplayCamRot(2)
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local rayHandle = StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 7)
    local _, hit, coords, _, entity = GetShapeTestResult(rayHandle)
    return hit, coords, entity
end

local OpenApplicationLocationSelector = function()
    ShowNotification(locale('notifications.location_selector_instructions'), 'success')

    CreateThread(function()
        lib.showTextUI(
            locale('bossmenu.location_selector_text'),
            {
                position    = 'right-center',
                icon        = 'fas fa-map-marker-alt',
                iconColor   = 'green',
                alignIcon   = 'center'
            }
        )

        local selecting = true
        while selecting do
            Wait(0)
            local ped   = PlayerPedId()
            local start = GetEntityCoords(ped)
            local hit, coords = RayCastGamePlayCamera(20.0)
            if hit and coords then
                DrawLine(
                    start.x, start.y, start.z,
                    coords.x, coords.y, coords.z,
                    0, 255, 0, 255
                )
                DrawMarker(
                    28,
                    coords.x, coords.y, coords.z,
                    0, 0, 0, 0, 0, 0,
                    0.3, 0.3, 0.3,
                    0, 255, 0, 100,
                    false, true, 2, nil, nil, false
                )

                if IsControlJustPressed(0, 38) then  -- E
                    lib.hideTextUI()
                    local loc = { x = coords.x, y = coords.y, z = coords.z }
                    lib.callback(
                        'sd-multijob:server:setApplicationLocation',
                        false,
                        function(ok)
                            ShowNotification(locale(ok and 'notifications.application_location_saved' or 'notifications.application_location_save_error'), ok and 'success' or 'error')
                            OpenApplicationMenu()
                        end,
                        bossData.jobName,
                        loc
                    )
                    selecting = false

                elseif IsControlJustPressed(0, 177) then  -- Backspace
                    lib.hideTextUI()
                    selecting = false
                    OpenApplicationMenu()
                end
            end
        end
    end)
end

--- Opens the form‐creation + submissions review menu for bosses.
OpenApplicationMenu = function()
    lib.callback('sd-multijob:server:getApplicationData', false, function(data)
        local subs = data.submissions or {}
        local opts = {}

        -- View Questions
        table.insert(opts, {
            title       = locale('bossmenu.application_menu_view_questions_title'),
            description = locale('bossmenu.application_menu_view_questions_desc'),
            icon        = 'question-circle',
            arrow       = true,
            onSelect    = OpenQuestionsMenu
        })

        -- Set Application Location
        table.insert(opts, {
            title       = locale('bossmenu.application_menu_set_location_title'),
            description = locale('bossmenu.application_menu_set_location_desc'),
            icon        = 'map-marker-alt',
            arrow       = true,
            onSelect    = OpenApplicationLocationSelector
        })

        -- View Submissions
        table.insert(opts, {
            title       = locale('bossmenu.application_menu_view_submissions_title'),
            description = locale('bossmenu.application_menu_view_submissions_desc'),
            icon        = 'eye',
            arrow       = true,
            onSelect    = function()
                if #subs == 0 then
                    lib.registerContext({
                        id      = 'application_empty_menu',
                        title   = locale('bossmenu.submissions_title'),
                        options = {
                            {
                                title       = locale('bossmenu.submissions_empty_title'),
                                description = locale('bossmenu.submissions_empty_desc'),
                                icon        = 'exclamation-circle',
                                readOnly    = true
                            },
                            {
                                title       = locale('bossmenu.application_back'),
                                icon        = 'arrow-left',
                                onSelect    = OpenApplicationMenu
                            }
                        },
                        canClose = true
                    })
                    return lib.showContext('application_empty_menu')
                end

                local so = {}
                for i, sub in ipairs(subs) do
                    table.insert(so, {
                        title       = sub.name,
                        description = locale('bossmenu.submission_entry_desc'),
                        icon        = 'file',
                        arrow       = true,
                        onSelect    = function()
                            OpenSubmission(i, data.questions)
                        end
                    })
                end
                table.insert(so, {
                    title       = locale('bossmenu.application_back'),
                    icon        = 'arrow-left',
                    onSelect    = OpenApplicationMenu
                })

                lib.registerContext({
                    id       = 'application_submissions_menu',
                    title    = locale('bossmenu.submissions_title'),
                    options  = so,
                    canClose = true
                })
                lib.showContext('application_submissions_menu')
            end
        })

        -- Back
        table.insert(opts, {
            title    = locale('bossmenu.application_back'),
            icon     = 'arrow-left',
            onSelect = OpenBossMenu
        })

        lib.registerContext({
            id       = 'boss_application_menu',
            title    = locale('bossmenu.application_menu_title', { jobName = bossData.jobName }),
            options  = opts,
            canClose = true
        })
        lib.showContext('boss_application_menu')
    end, bossData.jobName)
end

RegisterNetEvent('sd-multijob:client:openApplicationMenu', OpenApplicationMenu)

--- Opens the Messages-from-Employees submenu
--- @param jobName string        The key of the job
--- @param displayJobName string The formatted name to display
OpenBossMessagesMenu = function(jobName, displayJobName)
    lib.callback('sd-multijob:server:getBossMessages', false, function(msgs)
        local opts = {}

        if #msgs == 0 then
            table.insert(opts, {
                title       = locale('bossmenu.messages_no_messages_title'),
                description = locale('bossmenu.messages_no_messages_desc'),
                icon        = 'envelope-open',
                readOnly    = true
            })
        else
            for _, m in ipairs(msgs) do
                local expiresText
                if m.timeLeft and m.timeLeft > 0 then
                    local secs    = m.timeLeft
                    local days    = math.floor(secs / 86400); secs = secs % 86400
                    local hours   = math.floor(secs / 3600);  secs = secs % 3600
                    local minutes = math.ceil(secs / 60)
                    expiresText   = locale('notifications.message_expires_in', {
                        days    = days,
                        hours   = hours,
                        minutes = minutes
                    })
                else
                    expiresText = locale('notifications.message_expired')
                end

                table.insert(opts, {
                    title       = locale('bossmenu.message_entry_title', { subject = m.subject }),
                    description = locale('bossmenu.message_entry_desc', {
                        sender     = m.sender,
                        expiresText = expiresText
                    }),
                    icon        = 'envelope',
                    arrow       = true,
                    onSelect    = function()
                        lib.registerContext({
                            id       = 'boss_msg_action_' .. m.id,
                            title    = locale('bossmenu.message_action_menu_title'),
                            canClose = true,
                            options  = {
                                {
                                    title       = locale('bossmenu.message_action_read_title'),
                                    description = locale('bossmenu.message_action_read_desc'),
                                    icon        = 'envelope-open',
                                    onSelect    = function()
                                        lib.alertDialog({
                                            header   = m.subject,
                                            content  = string.format(
                                                'From: %s\n\n%s\n\n%s',
                                                m.sender, m.message, expiresText
                                            ),
                                            centered = true,
                                            cancel   = true,
                                            size     = 'md',
                                            overflow = true,
                                            labels   = { confirm = locale('bossmenu.message_action_ok') }
                                        })
                                        OpenBossMessagesMenu(jobName, displayJobName)
                                    end
                                },
                                {
                                    title       = locale('bossmenu.message_action_delete_title'),
                                    description = locale('bossmenu.message_action_delete_desc'),
                                    icon        = 'trash',
                                    onSelect    = function()
                                        lib.callback('sd-multijob:server:deleteBossMessage', false, function(ok)
                                            if ok then
                                                if bossData.notificationsCount and bossData.notificationsCount > 0 then
                                                    bossData.notificationsCount = bossData.notificationsCount - 1
                                                end
                                            end
                                            ShowNotification(locale(ok and 'notifications.message_deleted' or 'notifications.message_delete_failed'), ok and 'success' or 'error')
                                            OpenBossMessagesMenu(jobName, displayJobName)
                                        end, jobName, m.id)
                                    end
                                },
                                {
                                    title = locale('bossmenu.boss_messages_back'),
                                    icon  = 'arrow-left',
                                    onSelect = function()
                                        OpenBossMessagesMenu(jobName, displayJobName)
                                    end
                                }
                            }
                        })
                        lib.showContext('boss_msg_action_' .. m.id)
                    end
                })
            end
        end

        table.insert(opts, {
            title = locale('bossmenu.boss_messages_back'),
            icon  = 'arrow-left',
            onSelect = function()
                TriggerEvent('sd-multijob:client:openBossMenu')
            end
        })

        lib.registerContext({
            id       = 'boss_messages_menu_' .. jobName,
            title    = locale('bossmenu.messages_menu_title2', { displayJobName = (bossData.displayName or bossData.jobName):sub(1,1):upper() .. (bossData.displayName or bossData.jobName):sub(2) }),
            options  = opts,
            canClose = true
        })
        lib.showContext('boss_messages_menu_' .. jobName)
    end, jobName)
end

--- Opens the main Boss Menu.
OpenBossMenu = function()
    _lastMenu = 'boss'
    FetchBossData(function()
        local currentTarget   = bossData.weeklyTargetHours   or 1
        local rewardEnabled   = bossData.weeklyRewardEnabled or false
        local rewardAmount    = bossData.weeklyRewardAmount  or 0
        local rewardLabel     = rewardEnabled
            and ('$%d'):format(rewardAmount)
            or locale('notifications.weekly_goal_update_failed')

        local opts = {}

        -- only show Society option if enabled
        if Config.UseSociety.enable then
            table.insert(opts, {
                title       = locale('bossmenu.boss_option_society_title'),
                description = locale('bossmenu.boss_option_society_desc'),
                icon        = 'coins',
                arrow       = true,
                onSelect    = function()
                    TriggerEvent('sd-multijob:client:openSocietyMenu', bossData.jobName)
                end,
            })
        end

        table.insert(opts, {
            title       = locale('bossmenu.boss_option_employees_title'),
            description = locale('bossmenu.boss_option_employees_desc'),
            icon        = 'users',
            arrow       = true,
            onSelect    = function()
                TriggerEvent('sd-multijob:client:openEmployeeMenu')
            end,
        })

        table.insert(opts, {
            title       = locale('bossmenu.boss_option_hire_title'),
            description = locale('bossmenu.boss_option_hire_desc'),
            icon        = 'user-plus',
            arrow       = true,
            onSelect    = function()
                local vals = lib.inputDialog(
                    locale('bossmenu.boss_option_hire_title'),
                    {{ type = 'number', label = locale('target') == '' and 'Player Server ID' or locale('target') }},
                    { allowCancel = true }
                )
                if not vals then return OpenBossMenu() end
                local targetSrc = tonumber(vals[1])
                lib.callback('sd-multijob:server:getPlayerInfo', false, function(info)
                    if not info then
                        ShowNotification(locale('notifications.player_not_found'), 'error')
                        return OpenBossMenu()
                    end
                    local choice = lib.alertDialog({
                        header   = locale('bossmenu.boss_hire_dialog_header'),
                        content  = string.format('Hire **%s** (ID: %s)?', info.name, info.identifier),
                        centered = true,
                        cancel   = true,
                        size     = 'md',
                        labels   = {
                            confirm = locale('bossmenu.boss_hire_dialog_confirm'),
                            cancel  = locale('bossmenu.boss_hire_dialog_cancel')
                        }
                    })
                    if choice == 'confirm' then
                        lib.callback('sd-multijob:server:addEmployee', false, function(success)
                            ShowNotification(locale(success and 'notifications.hired_employee_success' or 'notifications.hired_employee_failure', { name = info.name, identifier = info.identifier }), success and 'success' or 'error')
                            OpenBossMenu()
                        end, targetSrc)
                    else
                        OpenBossMenu()
                    end
                end, targetSrc)
            end,
        })

        table.insert(opts, {
            title       = locale('bossmenu.boss_option_applications_title'),
            description = locale('bossmenu.boss_option_applications_desc'),
            icon        = 'file-contract',
            arrow       = true,
            onSelect    = function()
                TriggerEvent('sd-multijob:client:openApplicationMenu')
            end,
        })

        if Config.Leaderboard.enable then
            table.insert(opts, {
                title       = locale('bossmenu.boss_option_leaderboard_title'),
                description = locale('bossmenu.boss_option_leaderboard_desc'),
                icon        = 'trophy',
                arrow       = true,
                onSelect    = function()
                    local dn = bossData.jobName:sub(1,1):upper()..bossData.jobName:sub(2)
                    OpenJobLeaderboard(bossData.jobName, 0, dn)
                end,
            })
        end

        table.insert(opts, {
            title       = locale('bossmenu.boss_option_set_goal_title'),
            description = locale('bossmenu.boss_option_set_goal_desc', {
                                target = currentTarget,
                                bonus  = rewardLabel
                            }),
            icon        = 'clock',
            arrow       = false,
            onSelect    = function()
                local inputs = {
                    { type = 'number',   label = 'Target Hours',        default = currentTarget, min = 0 },
                    { type = 'checkbox', label = 'Enable Weekly Bonus', default = rewardEnabled },
                    { type = 'number',   label = 'Bonus Amount ($)',    default = rewardAmount,  min = 0 },
                }
                local vals = lib.inputDialog('Configure Weekly Goal', inputs, { allowCancel = true })
                if not vals then return OpenBossMenu() end
                local hrs   = tonumber(vals[1]) or 0
                local en    = vals[2] == true
                local bonus = tonumber(vals[3]) or 0
                lib.callback('sd-multijob:server:setWeeklyTarget', false, function(success)
                    ShowNotification(locale(success and 'notifications.weekly_goal_updated' or 'notifications.weekly_goal_update_failed'), success and 'success' or 'error')
                    OpenBossMenu()
                end, bossData.jobName, hrs, en, bonus)
            end,
        })

        local jobConfig = Config.Jobs[bossData.jobName]
        if jobConfig and jobConfig.stash and jobConfig.stash.enabled and GetResourceState('ox_inventory') == 'started' then
            table.insert(opts, {
                title       = locale('bossmenu.boss_option_stash_title'),
                description = locale('bossmenu.boss_option_stash_desc'),
                icon        = 'box',
                arrow       = true,
                onSelect    = function()
                    TriggerServerEvent('sd-multijob:server:openBossStash', bossData.jobName)
                end,
            })
        end

        table.insert(opts, (function()
            local cnt = bossData.notificationsCount or 0
            local clr
            if cnt >= 4 then clr = 'red'
            elseif cnt >= 2 then clr = 'orange'
            elseif cnt == 1 then clr = 'yellow' end
            return {
                title       = locale('bossmenu.messages_menu_title', {
                                    displayJobName = (bossData.displayName or bossData.jobName):sub(1,1):upper() .. (bossData.displayName or bossData.jobName):sub(2),
                                    cnt = cnt
                                }),
                description = locale('bossmenu.messages_menu_desc'),
                icon        = 'envelope',
                iconColor   = clr,
                arrow       = true,
                onSelect    = function()
                    OpenBossMessagesMenu(bossData.jobName, bossData.displayName or bossData.jobName)
                end,
            }
        end)())

        lib.registerContext({
            id       = 'boss_main_menu',
            title    = locale('bossmenu.boss_menu_title'),
            options  = opts,
            canClose = true,
        })
        lib.showContext('boss_main_menu')
    end)
end

RegisterNetEvent('sd-multijob:client:openBossMenu', OpenBossMenu)

--- Opens the in-world application UI for a given job.
--- @param jobName string
RegisterNetEvent('sd-multijob:client:openApplyJobMenu', function(jobName)
    lib.callback('sd-multijob:server:getApplicationData', false, function(data)
        local qs = data.questions or {}
        if #qs == 0 then
            ShowNotification(
                locale('notifications.application_form_unavailable', { jobName = jobName }),
                'error'
            )
            return
        end

        local rows = {}
        for _, q in ipairs(qs) do
            table.insert(rows, {
                type        = 'textarea',
                label       = q,
                placeholder = 'Enter your answer here...',
                min         = Config.ApplicationInput.minLength or 1,
                max         = Config.ApplicationInput.maxLength or 500,
                autosize    = true
            })
        end

        local answers = lib.inputDialog(
            locale('bossmenu.apply_for_label', { jobName = jobName:sub(1,1):upper()..jobName:sub(2) }),
            rows,
            { allowCancel = true }
        )
        if not answers then
            ShowNotification(
                locale('notifications.application_canceled'), 'success')
            return
        end

        local content = ''
        for i, q in ipairs(qs) do
            content = content
                .. '**' .. q .. '**\n'
                .. '> ' .. (answers[i] or ''):gsub('\n',' ') .. '\n\n'
        end

        local choice = lib.alertDialog({
            header   = 'Review Your Application',
            content  = content,
            centered = true,
            cancel   = true,
            labels   = {
                confirm = 'Submit',
                cancel  = 'Cancel'
            },
            size     = 'md',
            overflow = true
        })

        if choice == 'confirm' then
            lib.callback('sd-multijob:server:submitApplication', false, function(ok)
                ShowNotification(locale(ok and 'notifications.application_submitted' or 'notifications.application_submission_failed'), ok and 'success' or 'error')
            end, jobName, answers)
        else
            ShowNotification(
                locale('notifications.application_not_submitted'), 'error')
        end
    end, jobName)
end)

-- Event handler for opening the admin jobs menu
RegisterNetEvent('sd-multijob:client:openAdminJobsMenu', function(jobData)
    local options = {}
    
    table.insert(options, {
        title = locale('adminmenu.player_info', { 
            playerName = jobData.playerName, 
            identifier = jobData.identifier 
        }),
        description = locale('adminmenu.total_jobs', { count = #jobData.jobs }),
        icon = 'user',
        readOnly = true
    })
    
    for _, job in ipairs(jobData.jobs) do
        local statsText = ''
        if job.stats.minutesWorked and job.stats.minutesWorked > 0 then
            local hours = math.floor(job.stats.minutesWorked / 60)
            local minutes = job.stats.minutesWorked % 60
            if hours > 0 then
                statsText = locale('adminmenu.time_worked_hours_minutes', { hours = hours, minutes = minutes })
            else
                statsText = locale('adminmenu.time_worked_minutes', { minutes = minutes })
            end
        end
        
        local bossText = job.isBoss and locale('adminmenu.boss_indicator') or ''
        
        table.insert(options, {
            title = job.label .. ' (' .. job.name .. ')',
            description = job.gradeLabel .. locale('adminmenu.grade_indicator', { grade = job.grade }) .. bossText .. statsText,
            icon = job.isBoss and 'crown' or 'briefcase',
            iconColor = job.isBoss and 'gold' or nil,
            arrow = true,
            onSelect = function()
                local choice = lib.alertDialog({
                    header = locale('adminmenu.remove_job_header'),
                    content = locale('adminmenu.remove_job_content', {
                        jobLabel = job.label,
                        jobName = job.name,
                        playerName = jobData.playerName,
                        identifier = jobData.identifier,
                        gradeLabel = job.gradeLabel,
                        grade = job.grade
                    }),
                    centered = true,
                    cancel = true,
                    size = 'md',
                    overflow = true,
                    labels = {
                        confirm = locale('adminmenu.remove_job_confirm'),
                        cancel = locale('adminmenu.remove_job_cancel')
                    }
                })
                
                if choice == 'confirm' then
                    lib.callback('sd-multijob:server:adminRemoveJob', false, function(success, message)
                        if success then
                            ShowNotification(
                                locale('adminmenu.remove_job_success', { jobLabel = job.label, playerName = jobData.playerName }), 'success')
                        else
                            ShowNotification(message or locale('adminmenu.remove_job_failed'), 'error')
                        end
                    end, jobData.identifier, job.name)
                else
                    TriggerEvent('sd-multijob:client:openAdminJobsMenu', jobData)
                end
            end
        })
    end
    
    table.insert(options, {
        title = locale('adminmenu.close'),
        icon = 'times',
        onSelect = function()
            lib.hideContext()
        end
    })
    
    lib.registerContext({
        id = 'admin_jobs_menu',
        title = locale('adminmenu.title'),
        canClose = true,
        options = options
    })
    
    lib.showContext('admin_jobs_menu')
end)