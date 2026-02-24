Bridge = Bridge or {}
local PlayerPermissions = {}
local AvatarCache = {}
local ClanTagCache = {}
local StatsCache = {}
local ESX = exports.es_extended:getSharedObject()

function Bridge.GetPlayerIdentifier(source)
    local playerData = ESX.GetPlayerFromId(source)
    return playerData and playerData.identifier or nil
end

function Bridge.GetSteamName(source)
    return GetPlayerName(source) or 'Unknown'
end

function Bridge.Notify(source, message, type)
    TriggerClientEvent('eg_killfeed:client:notify', source, message, type or 'info')
end

function Bridge.CheckPermission(source)
    if ServerConfig.AdminGroups and #ServerConfig.AdminGroups > 0 then
        for _, ace in ipairs(ServerConfig.AdminGroups) do
            if IsPlayerAceAllowed(tostring(source), ace) then
                return true
            end
        end
    end
    local playerData = ESX.GetPlayerFromId(source)
    if playerData and ServerConfig.FrameworkAdmins and ServerConfig.FrameworkAdmins[playerData.getGroup()] then return true end
    return false
end

function Bridge.HasPermission(source)
    if not source or source == 0 then return false end
    if PlayerPermissions[source] == nil then
        PlayerPermissions[source] = Bridge.CheckPermission(source)
    end
    return PlayerPermissions[source]
end

-- Discord avatar helpers
function Bridge.GetDiscordId(source)
    local playerIdents = GetPlayerIdentifiers(source)
    if not playerIdents then return nil end

    for i = 1, #playerIdents do
        local ident = playerIdents[i]
        if string.sub(ident, 1, 8) == 'discord:' then
            return string.sub(ident, 9)
        end
    end

    return nil
end

function Bridge.FetchAvatar(source, callback)
    local cfg = ServerConfig.DiscordAvatars or {}
    if not cfg.Enabled then
        callback(nil)
        return
    end

    local discordId = Bridge.GetDiscordId(source)
    if not discordId then
        callback(nil)
        return
    end

    if AvatarCache[discordId] then
        callback(AvatarCache[discordId])
        return
    end

    local token = cfg.BotToken or ''
    if token == '' then
        callback(nil)
        return
    end

    local url = 'https://discord.com/api/v10/users/' .. discordId
    PerformHttpRequest(url, function(status, response)
        if status == 200 and response then
            local data = json.decode(response)
            if data and data.avatar then
                local ext = string.sub(data.avatar, 1, 2) == 'a_' and '.gif' or '.png'
                local avatarUrl = 'https://cdn.discordapp.com/avatars/' .. discordId .. '/' .. data.avatar .. ext .. '?size=128'
                AvatarCache[discordId] = avatarUrl
                callback(avatarUrl)
                return
            end
        end
        AvatarCache[discordId] = nil
        callback(nil)
    end, 'GET', '', { ['Authorization'] = 'Bot ' .. token })
end

function Bridge.GetCachedAvatar(source)
    local cfg = ServerConfig.DiscordAvatars or {}
    if not cfg.Enabled then return nil end

    local discordId = Bridge.GetDiscordId(source)
    return (discordId and AvatarCache[discordId]) or nil
end

function Bridge.SetClanTag(identifier, tag)
    ClanTagCache[identifier] = tag
end

function Bridge.GetClanTag(identifier)
    return ClanTagCache[identifier]
end

function Bridge.SetStats(identifier, kills, deaths)
    StatsCache[identifier] = { kills = kills or 0, deaths = deaths or 0 }
end

function Bridge.GetStats(identifier)
    return StatsCache[identifier] or { kills = 0, deaths = 0 }
end

function Bridge.IncrementKills(identifier)
    if not StatsCache[identifier] then
        StatsCache[identifier] = { kills = 0, deaths = 0 }
    end
    StatsCache[identifier].kills = StatsCache[identifier].kills + 1
    return StatsCache[identifier]
end

function Bridge.IncrementDeaths(identifier)
    if not StatsCache[identifier] then
        StatsCache[identifier] = { kills = 0, deaths = 0 }
    end
    StatsCache[identifier].deaths = StatsCache[identifier].deaths + 1
    return StatsCache[identifier]
end

AddEventHandler('playerDropped', function()
    PlayerPermissions[source] = nil
end)
