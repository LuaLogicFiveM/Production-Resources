--- Dynamically selects and returns the appropriate function for retrieving a player object
--- based on the configured framework.
---@return function A function that returns the player object when called with server ID
local CreateGetPlayerFunction = function()
    if Framework == 'esx' then
        return function(source)
            return ESX.GetPlayerFromId(source)
        end
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(source)
            return QBCore.Functions.GetPlayer(source)
        end
    else
        return function(source)
            error(string.format("Unsupported framework. Unable to retrieve player object for source: %s", source))
            return nil
        end
    end
end

--- Creates framework-specific function for getting player identifier
---@return function Function to retrieve player identifier
local CreateGetIdentifierFunction = function()
    if Framework == 'esx' then
        return function(player)
            return player.identifier
        end
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(player)
            return player.PlayerData.citizenid
        end
    else
        return function()
            error("Unsupported framework for GetIdentifier.")
        end
    end
end

--- Creates framework-specific function for getting player full name
---@return function Function to get player's full name
local CreateGetNameFunction = function()
    if Framework == 'esx' then
        return function(player)
            return player.get('firstName') .. ' ' .. player.get('lastName')
        end
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(player)
            if player.PlayerData and player.PlayerData.charinfo then
                return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
            end
            return 'Unknown Player'
        end
    else
        return function()
            error("Unsupported framework for GetFullName.")
        end
    end
end

--- Creates framework-specific function for getting a player from an identifier
---@return function Function to get player's full name
local CreateIdentifierPlayerFunction = function()
    if Framework == 'qb' then
        return function(identifier)
            return GetPlayer(QBCore.Functions.GetPlayerByCitizenId(identifier)?.PlayerData?.source)
        end
    elseif Framework == 'esx' then
        return function(identifier)
            return GetPlayer(ESX.GetPlayerFromIdentifier(identifier)?.source)
        end
    else
        return function(identifier)
            error(string.format("Unsupported framework: %s", Framework))
        end
    end
end

-- Initialize player management functions
GetPlayer = CreateGetPlayerFunction()
local GetIdentifierFromPlayer = CreateGetIdentifierFunction()
local GetFullNameFromPlayer = CreateGetNameFunction()
local GetPlayerByIdentifier = CreateIdentifierPlayerFunction()

--- Gets a player's identifier
---@param source number The player's server ID
---@return string|nil The player's identifier
GetIdentifier = function(source)
    local player = GetPlayer(source)
    return player and GetIdentifierFromPlayer(player) or nil
end

--- Gets a player's full name
---@param source number The player's server ID
---@return string The player's full name
GetFullName = function(source)
    local player = GetPlayer(source)
    return player and GetFullNameFromPlayer(player) or 'Unknown Player'
end

-- This function assigns the ability to retrieve a player by identifie
---@param source string The player's server identifier
---@returns a players object for the given identifier
GetPlayerFromIdentifier = function(identifier)
    return GetPlayerByIdentifier(identifier)
end

Logger = {}

-- Configuration
local cfg = {
    service = 'none',
    screenshots = false,
    events = {},
    discord = {},
    loki = {},
    grafana = {},
    fmsdk = {}
}

-- Internal buffers
local logBuffers = {}
local flushScheduled = false
local discordLogBuffer = {}
local discordFlushScheduled = false

--- Base64-encodes a string
---@param data string The string to encode
---@return string The base64-encoded result
local Base64Encode = function(data)
    local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local bits, byte = '', x:byte()
        for i = 8, 1, -1 do
            bits = bits .. ((byte % 2^i >= 2^(i-1)) and '1' or '0')
        end
        return bits
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if #x < 6 then return '' end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i,i) == '1' and 2^(6-i) or 0)
        end
        return b64chars:sub(c+1, c+1)
    end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

--- Builds HTTP Basic Authorization header
---@param user string Username
---@param pass string Password
---@return string The 'Basic ...' header value
local GetAuthHeader = function(user, pass)
    return 'Basic ' .. Base64Encode(user .. ':' .. pass)
end

--- Schedules a flush of buffered logs to Loki/Grafana
local ScheduleFlush = function()
    if flushScheduled then return end
    flushScheduled = true
    
    SetTimeout(500, function()
        local services = { loki = cfg.loki, grafana = cfg.grafana }
        
        for name, conf in pairs(services) do
            local buffer = logBuffers[name]
            if buffer and next(buffer) and conf.endpoint and conf.headers then
                local streams = {}
                for _, stream in pairs(buffer) do
                    streams[#streams + 1] = stream
                end
                
                local body = json.encode({ streams = streams })
                PerformHttpRequest(conf.endpoint, function(status)
                    local isSuccess = (name == 'loki' and status == 204) or 
                                    (name == 'grafana' and status >= 200 and status < 300)
                    if not isSuccess then
                        print(('Logger: %s push failed (status %d)'):format(name, status))
                    end
                end, 'POST', body, conf.headers)
            end
        end
        
        logBuffers = {}
        flushScheduled = false
    end)
end

--- Sends a log entry via Discord webhook
---@param title string The title of the log message
---@param message string The log message content
local SendDiscordLog = function(title, message)
    local d = cfg.discord
    assert(d.link and d.link ~= '', 'Logger: discord.link must be set')
    
    local resourceName = GetCurrentResourceName()
    local fullTitle = string.format('%s - %s', resourceName, title)
    
    local embed = {{
        color = d.color or 14423100,
        title = '**' .. fullTitle .. '**',
        description = message,
        footer = { text = os.date('%a %b %d, %I:%M %p'), icon_url = d.footer }
    }}
    
    local payload = {
        username = d.name,
        avatar_url = d.image,
        embeds = embed
    }
    
    if d.tagEveryone then 
        payload.content = '@everyone' 
    end
    
    PerformHttpRequest(d.link, function() end, 'POST', json.encode(payload), {
        ['Content-Type'] = 'application/json'
    })
end

--- Schedules Discord log flush
local ScheduleDiscordFlush = function()
    if discordFlushScheduled then return end
    discordFlushScheduled = true
    
    local interval = (cfg.discord.flushInterval and cfg.discord.flushInterval * 1000) or 60000
    
    SetTimeout(interval, function()
        for _, entry in ipairs(discordLogBuffer) do
            SendDiscordLog(entry.title, entry.message)
        end
        discordLogBuffer = {}
        discordFlushScheduled = false
    end)
end

--- Buffers a Discord log entry
---@param title string The title of the log message
---@param message string The log message content
local BufferDiscordLog = function(title, message)
    discordLogBuffer[#discordLogBuffer + 1] = {
        title = title,
        message = message
    }
    ScheduleDiscordFlush()
end

--- Buffers a log stream for Loki/Grafana
---@param serviceName string 'loki' or 'grafana'
---@param source number The player's server ID
---@param event string The event name
---@param message string The log message content
local BufferStream = function(serviceName, source, event, message)
    local conf = cfg[serviceName]
    if not conf.endpoint or conf.endpoint == '' then return end
    
    if not logBuffers[serviceName] then 
        logBuffers[serviceName] = {} 
    end
    
    local ts = tostring(os.time() * 1e9)
    
    if not logBuffers[serviceName][event] then
        logBuffers[serviceName][event] = {
            stream = {
                server = conf.server or GetConvar('sv_projectName', 'fxserver'),
                resource = cfg.resource or GetCurrentResourceName(),
                event = event
            },
            values = {}
        }
        table.insert(logBuffers[serviceName], logBuffers[serviceName][event])
    end
    
    table.insert(logBuffers[serviceName][event].values, {
        ts,
        json.encode({ message = message, source = source })
    })
    
    ScheduleFlush()
end

--- Sends a log entry via FiveM-Manage
---@param source number The player's server ID
---@param title string The title of the log message
---@param message string The log message content
local SendFiveMManageLog = function(source, title, message)
    local sdk = exports.fmsdk
    if not sdk then return end

    local datasetId = cfg.fmsdk.dataset or 'default'
    local logMetadata = {}

    if source then
        logMetadata.playerSource = source
    end

    if cfg.screenshots then
        sdk:takeServerImage(source, { name = title, description = message })
    else
        sdk:Log(datasetId, 'info', message, logMetadata)
    end
end

--- Sends a log entry via FiveM-Err
---@param source number The player's server ID
---@param title string The title of the log message
---@param message string The log message content
local SendFiveMErrLog = function(source, title, message)
    local errlog = cfg.fmlogs or exports['fm-logs']
    if not errlog then return end
    
    errlog:createLog({
        LogType = 'Generic',
        Message = message,
        Resource = cfg.resource or GetCurrentResourceName(),
        Source = source,
    }, { Screenshot = cfg.screenshots })
end

--- Initializes the logger with configuration
---@param logsConfig table The logs configuration table
Logger.Setup = function(logsConfig)
    cfg.service = logsConfig.service or cfg.service
    cfg.screenshots = logsConfig.screenshots or cfg.screenshots
    cfg.events = logsConfig.events or cfg.events
    cfg.discord = logsConfig.discord or cfg.discord
    
    if logsConfig.discord and logsConfig.discord.flushInterval then
        cfg.discord.flushInterval = logsConfig.discord.flushInterval
    end
    
    -- Setup Loki configuration
    if logsConfig.loki then
        local l = logsConfig.loki
        cfg.loki.endpoint = l.endpoint or ''
        
        if not cfg.loki.endpoint:match('^https?://') then
            cfg.loki.endpoint = 'https://' .. cfg.loki.endpoint
        end
        
        cfg.loki.endpoint = cfg.loki.endpoint:gsub('/+$', '') .. '/loki/api/v1/push'
        cfg.loki.headers = { ['Content-Type'] = 'application/json' }
        
        if l.user and l.password then
            cfg.loki.headers['Authorization'] = GetAuthHeader(l.user, l.password)
        end
        
        if l.tenant then
            cfg.loki.headers['X-Scope-OrgID'] = l.tenant
        end
    end
    
    -- Setup Grafana configuration
    if logsConfig.grafana then
        local g = logsConfig.grafana
        cfg.grafana.endpoint = g.endpoint or ''

        if not cfg.grafana.endpoint:match('^https?://') then
            cfg.grafana.endpoint = 'https://' .. cfg.grafana.endpoint
        end

        cfg.grafana.endpoint = cfg.grafana.endpoint:gsub('/+$', '') .. '/loki/api/v1/push'
        cfg.grafana.headers = { ['Content-Type'] = 'application/json' }

        if g.apiKey then
            cfg.grafana.headers['Authorization'] = 'Bearer ' .. g.apiKey
        end

        if g.tenant then
            cfg.grafana.headers['X-Scope-OrgID'] = g.tenant
        end
    end

    -- Setup Fivemanage dataset
    if logsConfig.dataset then
        cfg.fmsdk.dataset = logsConfig.dataset
    end
end

--- Logs an event using the configured service
---@param source number? The player's server ID (nil for Discord-only logs)
---@param title string The title or event name of the log
---@param message string The log message content
Logger.Log = function(source, title, message)
    local serviceHandlers = {
        none = function() end,
        discord = function() BufferDiscordLog(title, message) end,
        fivemanage = function() SendFiveMManageLog(source, title, message) end,
        fivemerr = function() SendFiveMErrLog(source, title, message) end,
        loki = function() BufferStream('loki', source, title, message) end,
        grafana = function() BufferStream('grafana', source, title, message) end
    }
    
    local handler = serviceHandlers[cfg.service]
    if handler then
        handler()
    else
        error("Logger: unsupported service '" .. tostring(cfg.service) .. "'")
    end
end


--- Checks for updates by comparing local version with GitHub releases
---@param repo string The GitHub repository in format 'owner/repository'
CheckVersion = function(repo)
    local resource = GetInvokingResource() or GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resource, 'Version', 0)
    
    if currentVersion then
        currentVersion = currentVersion:match('%d+%.%d+%.%d+')
    end
    
    if not currentVersion then
        return print("^1Unable to determine current resource version for '^2" .. resource .. "^1'^0")
    end
    
    print('^3Checking for updates for ^2' .. resource .. '^3...^0')
    
    SetTimeout(1000, function()
        local url = ('https://api.github.com/repos/%s/releases/latest'):format(repo)
        PerformHttpRequest(url, function(status, response)
            if status ~= 200 then
                print('^1Failed to fetch release information for ^2' .. resource .. '^1. HTTP status: ' .. status .. '^0')
                return
            end
            
            local data = json.decode(response)
            if not data then
                print('^1Failed to parse release information for ^2' .. resource .. '^1.^0')
                return
            end
            
            if data.prerelease then
                print('^3Skipping prerelease for ^2' .. resource .. '^3.^0')
                return
            end
            
            local latestVersion = data.tag_name and data.tag_name:match('%d+%.%d+%.%d+')
            if not latestVersion then
                print('^1Failed to get valid latest version for ^2' .. resource .. '^1.^0')
                return
            end
            
            if latestVersion == currentVersion then
                print('^2' .. resource .. ' ^3is up-to-date with version ^2' .. currentVersion .. '^3.^0')
                return
            end
            
            -- Compare versions
            local parseVersion = function(version)
                local parts = {}
                for part in version:gmatch('%d+') do
                    table.insert(parts, tonumber(part))
                end
                return parts
            end
            
            local cv = parseVersion(currentVersion)
            local lv = parseVersion(latestVersion)
            
            for i = 1, math.max(#cv, #lv) do
                local current = cv[i] or 0
                local latest = lv[i] or 0
                
                if current < latest then
                    local releaseNotes = data.body or "No release notes available."
                    local message = releaseNotes:find("\n") and 
                        "Check release page or changelog channel on Discord for more information!" or 
                        releaseNotes
                    
                    print(string.format(
                        '^3An update is available for ^2%s^3 (current: ^2%s^3)\r\nLatest: ^2%s^3\r\nRelease Notes: ^7%s',
                        resource, currentVersion, latestVersion, message
                    ))
                    break
                elseif current > latest then
                    print(string.format(
                        '^2%s ^3has newer local version (^2%s^3) than latest public release (^2%s^3).^0',
                        resource, currentVersion, latestVersion
                    ))
                    break
                end
            end
        end, 'GET', '')
    end)
end

Money = {}

--- Converts money type to framework-specific variant
---@param moneyType string The original money type
---@return string The converted money type
local ConvertMoneyType = function(moneyType)
    if moneyType == 'money' and (Framework == 'qb' or Framework == 'qbx') then
        return 'cash'
    elseif moneyType == 'cash' and Framework == 'esx' then
        return 'money'
    else
        return moneyType
    end
end

--- Creates framework-specific function for adding money
---@return function Function to add money to player
local CreateAddMoneyFunction = function()
    if Framework == 'esx' then
        return function(player, moneyType, amount)
            player.addAccountMoney(ConvertMoneyType(moneyType), amount)
        end
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(player, moneyType, amount)
            player.Functions.AddMoney(ConvertMoneyType(moneyType), amount)
        end
    else
        return function()
            error("Unsupported framework for AddMoney.")
        end
    end
end

--- Creates framework-specific function for removing money
---@return function Function to remove money from player
local CreateRemoveMoneyFunction = function()
    if Framework == 'esx' then
        return function(player, moneyType, amount)
            player.removeAccountMoney(ConvertMoneyType(moneyType), amount)
        end
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(player, moneyType, amount)
            player.Functions.RemoveMoney(ConvertMoneyType(moneyType), amount)
        end
    else
        return function()
            error("Unsupported framework for RemoveMoney.")
        end
    end
end

--- Creates framework-specific function for getting player funds
---@return function Function to get player's account funds
local CreateGetFundsFunction = function()
    if Framework == 'esx' then
        return function(player, moneyType)
            local account = player.getAccount(ConvertMoneyType(moneyType))
            return account and account.money or 0
        end
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(player, moneyType)
            return player.PlayerData.money[ConvertMoneyType(moneyType)] or 0
        end
    else
        return function()
            error("Unsupported framework for GetPlayerFunds.")
        end
    end
end

-- Initialize money management functions
local AddMoneyToPlayer = CreateAddMoneyFunction()
local RemoveMoneyFromPlayer = CreateRemoveMoneyFunction()
local GetPlayerAccountFunds = CreateGetFundsFunction()

--- Adds money to a player's account
---@param source number The player's server ID
---@param moneyType string The type of money to add
---@param amount number The amount of money to add
Money.AddMoney = function(source, moneyType, amount)
    local player = GetPlayer(source)
    if player then 
        AddMoneyToPlayer(player, moneyType, amount) 
    end
end

--- Removes money from a player's account
---@param source number The player's server ID
---@param moneyType string The type of money to remove
---@param amount number The amount of money to remove
Money.RemoveMoney = function(source, moneyType, amount)
    local player = GetPlayer(source)
    if player then 
        RemoveMoneyFromPlayer(player, moneyType, amount) 
    end
end

--- Gets the amount of money in a player's account
---@param source number The player's server ID
---@param moneyType string The type of money to check
---@return number The amount of money
Money.GetPlayerAccountFunds = function(source, moneyType)
    local player = GetPlayer(source)
    return player and GetPlayerAccountFunds(player, moneyType) or 0
end

--- Checks if player is on duty (for frameworks that support duty system)
---@param onduty boolean PlayerData.job.onduty flag
---@param ignoreDuty boolean? If true, bypasses the requirement
---@return boolean
local IsOnDutyAllowed = function(onduty, ignoreDuty)
    if ignoreDuty then
        return true
    end
    return onduty
end

--- Creates framework-specific function for checking player groups
---@return function Function to check if player has specific group
local CreateHasGroupFunction = function()
    if Framework == 'esx' then
        return function(player, filter, ignoreDuty)
            local filterType = type(filter)
            
            if filterType == 'string' then
                if player.job.name == filter then
                    return player.job.name, player.job.grade
                end
                
            elseif filterType == 'table' then
                if table.type(filter) == 'hash' then
                    local grade = filter[player.job.name]
                    if grade and grade <= player.job.grade then
                        return player.job.name, player.job.grade
                    end
                    
                elseif table.type(filter) == 'array' then
                    for _, jobName in ipairs(filter) do
                        if player.job.name == jobName then
                            return player.job.name, player.job.grade
                        end
                    end
                end
            end
            
            return nil
        end
        
    elseif Framework == 'qb' or Framework == 'qbx' then
        return function(player, filter, ignoreDuty)
            local filterType = type(filter)
            local groups = { 'job', 'gang' }
            
            if filterType == 'string' then
                for _, group in ipairs(groups) do
                    local data = player.PlayerData[group]
                    if data and data.name == filter then
                        if group == 'job' and not IsOnDutyAllowed(data.onduty, ignoreDuty) then
                            return nil
                        end
                        return data.name, data.grade.level
                    end
                end
                
            elseif filterType == 'table' then
                if table.type(filter) == 'hash' then
                    for _, group in ipairs(groups) do
                        local data = player.PlayerData[group]
                        local grade = data and filter[data.name]
                        if data and grade and data.grade.level >= grade then
                            if group == 'job' and not IsOnDutyAllowed(data.onduty, ignoreDuty) then
                                return nil
                            end
                            return data.name, data.grade.level
                        end
                    end
                    
                elseif table.type(filter) == 'array' then
                    for _, wanted in ipairs(filter) do
                        for _, group in ipairs(groups) do
                            local data = player.PlayerData[group]
                            if data and data.name == wanted then
                                if group == 'job' and not IsOnDutyAllowed(data.onduty, ignoreDuty) then
                                    return nil
                                end
                                return data.name, data.grade.level
                            end
                        end
                    end
                end
            end
            
            return nil
        end
        
    else
        return function()
            return false
        end
    end
end

-- Initialize group checking function
local PlayerHasGroup = CreateHasGroupFunction()

--- Check if the player belongs to a specific group
---@param source any The identifier for the player
---@param filter string|table The group name or filter table
---@param ignoreDuty boolean? If true, skips the onduty check
---@return string|nil, number|nil The matched group name and grade if any
HasGroup = function(source, filter, ignoreDuty)
    local player = GetPlayer(source)
    if not player then return nil end
    return PlayerHasGroup(player, filter, ignoreDuty)
end

--- Removes a player from a job at the framework level (for Qbox multi-job support)
--- This ensures the job is properly removed from the player's jobs table, not just the primary job
---@param identifier string The player's citizenid (QB/QBX) or identifier (ESX)
---@param jobName string The job to remove
---@return boolean success Whether the removal was successful
RemovePlayerFromFrameworkJob = function(identifier, jobName)
    if Framework == 'qbx' then
        -- Qbox has a built-in multi-job system that needs to be updated
        local success, err = exports.qbx_core:RemovePlayerFromJob(identifier, jobName)
        if not success then
            print(('[sd-multijob] Warning: Failed to remove job %s from framework for %s: %s'):format(jobName, identifier, err and err.message or 'unknown error'))
        end
        return success or false
    elseif Framework == 'qb' then
        -- QB-Core doesn't have the same multi-job system, SetJob handles it
        return true
    elseif Framework == 'esx' then
        -- ESX doesn't have the same multi-job system, SetJob handles it
        return true
    end
    return false
end
