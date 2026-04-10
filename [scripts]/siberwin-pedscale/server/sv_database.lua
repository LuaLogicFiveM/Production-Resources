local ESX, QBCore = nil, nil

local activePlayerScales = {}

local function updateActiveScale(source, scale, weight)
    if scale ~= 1.0 or weight ~= 1.0 then
        activePlayerScales[source] = {
            scale = scale,
            weight = weight,
            timestamp = os.time()
        }
    else
        activePlayerScales[source] = nil
    end
end

local function sendAllActiveScalesToPlayer(targetSource)
    for playerId, data in pairs(activePlayerScales) do
        if GetPlayerPing(playerId) > 0 then
            TriggerClientEvent('siberwin-pedscale:client:syncScale', targetSource, playerId, data.scale, data.weight)
        else
            activePlayerScales[playerId] = nil
        end
    end
end

local function sendDiscordLog(title, description, color, fields)
    if not Config.Discord.enabled or not Config.Discord.webhook or Config.Discord.webhook == "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL_HERE" then
        return
    end
    
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = color or 3447003,
            ["fields"] = fields or {},
            ["footer"] = {
                ["text"] = "SiberWin PedScale System",
                ["icon_url"] = Config.Discord.botAvatar
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    
    local payload = {
        ["username"] = Config.Discord.botName,
        ["avatar_url"] = Config.Discord.botAvatar,
        ["embeds"] = embed
    }
    
    PerformHttpRequest(Config.Discord.webhook, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
        print('[siberwin-pedscale] ESX Framework detected - Using license identifier with State Bag + Event sync')

        RegisterNetEvent('esx:playerLoaded', function(xPlayer)
            local src = source
            CreateThread(function()
                Wait(2000)
                sendAllActiveScalesToPlayer(src)
            end)
        end)

    elseif GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        print('[siberwin-pedscale] QBCore Framework detected - Using citizenid identifier with State Bag + Event sync')

        RegisterNetEvent('QBCore:Server:PlayerLoaded', function(Player)
            local src = source
            CreateThread(function()
                Wait(2000)
                sendAllActiveScalesToPlayer(src)
            end)
        end)

    else
        print('[siberwin-pedscale] No framework detected - Using license identifier with State Bag + Event sync')
    end
end)

local function getPlayerIdentifier(source)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.PlayerData and Player.PlayerData.citizenid then
            return Player.PlayerData.citizenid
        else
            return GetPlayerIdentifierByType(source, 'license')
        end
    elseif ESX then
        return GetPlayerIdentifierByType(source, 'license')
    else
        return GetPlayerIdentifierByType(source, 'license')
    end
    return GetPlayerIdentifierByType(source, 'license')
end

local playerScales = {}

CreateThread(function()
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS `siberwin-pedscale` (
            `identifier` varchar(50) NOT NULL,
            `scale_value` float NOT NULL DEFAULT 1.0,
            `weight_value` float NOT NULL DEFAULT 1.0,
            `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`identifier`)
        )
    ]])
end)

local function savePlayerScale(identifier, scale, weight)
    exports.oxmysql:execute('INSERT INTO `siberwin-pedscale` (identifier, scale_value, weight_value) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE scale_value = VALUES(scale_value), weight_value = VALUES(weight_value)', {
        identifier, scale, weight or 1.0
    })
end

local function loadPlayerScale(identifier, callback)
    exports.oxmysql:execute('SELECT scale_value, weight_value FROM `siberwin-pedscale` WHERE identifier = ?', {
        identifier
    }, function(result)
        if result and result[1] then
            callback(result[1].scale_value or 1.0, result[1].weight_value or 1.0)
        else
            callback(1.0, 1.0)
        end
    end)
end

RegisterNetEvent('siberwin-pedscale:server:saveScale')
AddEventHandler('siberwin-pedscale:server:saveScale', function(scale, weight)
    local src = source
    local identifier = getPlayerIdentifier(src)

    if identifier then
        savePlayerScale(identifier, scale, weight or 1.0)

        playerScales[src] = {height = scale, weight = weight or 1.0}
        updateActiveScale(src, scale, weight or 1.0)

        local Player = Player(src)
        if Player and Player.state then
            Player.state:set('pedScale', {
                height = scale,
                weight = weight or 1.0,
                timestamp = GetGameTimer()
            }, true)
        end

        local allPlayers = GetPlayers()
        for _, playerId in ipairs(allPlayers) do
            local targetId = tonumber(playerId)
            if targetId and targetId ~= src then
                TriggerClientEvent('siberwin-pedscale:client:syncScale', targetId, src, scale, weight or 1.0)
            end
        end

        if Config.Discord.enabled and Config.Discord.logs.scaleChange then
            local playerName = GetPlayerName(src)
            local license = GetPlayerIdentifierByType(src, 'license') or 'Unknown'

            local fields = {
                {
                    ["name"] = "Player Info",
                    ["value"] = string.format("**Name:** %s\n**Server ID:** %d", playerName, src),
                    ["inline"] = true
                },
                {
                    ["name"] = "Scale Changes",
                    ["value"] = string.format("**Height:** %.1f\n**Weight:** %.1f\n**Identifier:** %s", scale, weight or 1.0, identifier),
                    ["inline"] = true
                }
            }

            local color = (scale == 1.0 and weight == 1.0) and 3066993 or 3447003
            local action = (scale == 1.0 and weight == 1.0) and "Reset Scale" or "Changed Scale"

            sendDiscordLog(
                "🔧 Player " .. action,
                string.format("Player **%s** has %s their character scale.", playerName, action:lower()),
                color,
                fields
            )
        end

        if not (Player and Player.state) then
            print("[siberwin-pedscale] Player object or state not found for player - using retry mechanism")
            SetTimeout(100, function()
                local RetryPlayer = Player(src)
                if RetryPlayer and RetryPlayer.state then
                    RetryPlayer.state:set('pedScale', {
                        height = scale,
                        weight = weight or 1.0,
                        timestamp = GetGameTimer()
                    }, true)
                end
            end)
        end
    end
end)

RegisterNetEvent('siberwin-pedscale:server:loadScale')
AddEventHandler('siberwin-pedscale:server:loadScale', function()
    local src = source
    local identifier = getPlayerIdentifier(src)

    if identifier then
        loadPlayerScale(identifier, function(scale, weight)
            playerScales[src] = {height = scale, weight = weight}
            updateActiveScale(src, scale, weight)

            TriggerClientEvent('siberwin-pedscale:client:scaleLoaded', src, scale, weight)

            local Player = Player(src)
            if Player and Player.state then
                Player.state:set('pedScale', {
                    height = scale,
                    weight = weight,
                    timestamp = GetGameTimer()
                }, true)
            else
                SetTimeout(100, function()
                    local RetryPlayer = Player(src)
                    if RetryPlayer and RetryPlayer.state then
                        RetryPlayer.state:set('pedScale', {
                            height = scale,
                            weight = weight,
                            timestamp = GetGameTimer()
                        }, true)
                    end
                end)
            end
        end)
    else
        TriggerClientEvent('siberwin-pedscale:client:scaleLoaded', src, 1.0, 1.0)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    if playerScales[src] then
        playerScales[src] = nil
    end

    if activePlayerScales[src] then
        activePlayerScales[src] = nil
    end
end)


RegisterNetEvent('siberwin-pedscale:server:requestInitialSync')
AddEventHandler('siberwin-pedscale:server:requestInitialSync', function()
    local src = source
    sendAllActiveScalesToPlayer(src)
end)


AddStateBagChangeHandler('pedScale', nil, function(bagName, key, value)
    local playerId = tonumber(bagName:match("player:(%d+)"))

    if playerId and value then
        playerScales[playerId] = {height = value.height or 1.0, weight = value.weight or 1.0}

        if GetConvar('siberwin_pedscale_debug', 'false') == 'true' then
            print(string.format('[siberwin-pedscale] Player %d scale updated via state bag: height=%.2f, weight=%.2f',
                playerId, value.height or 1.0, value.weight or 1.0))
        end
    end
end)
