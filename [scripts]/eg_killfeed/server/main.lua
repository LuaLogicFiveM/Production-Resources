local DeathCooldowns = {}
local KillStreaks = {}

RegisterNetEvent('eg_killfeed:server:playerDied', function(killerId, weaponHash, distance, isSuicide)
    local src = source
    local now = GetGameTimer()
    if DeathCooldowns[src] and now - DeathCooldowns[src] < Config.Killfeed.DeathCooldown then return end
    DeathCooldowns[src] = now

    local victimIdentifier = Bridge.GetPlayerIdentifier(src)
    local victimName = Bridge.GetSteamName(src)
    local victimAvatar = Bridge.GetCachedAvatar(src)
    local victimClan = victimIdentifier and Database.GetPlayerClan(victimIdentifier)
    local victimTag, victimTagIcon, victimTagColor
    if victimClan then
        victimTag = victimClan.tag
        victimTagIcon = victimClan.icon
        victimTagColor = victimClan.color
    end

    local weaponLabel = GetWeaponLabel(weaponHash)
    local weaponHashName = GetWeaponHashName(weaponHash)

    local killerName = nil
    local killerAvatar = nil
    local killerTag = nil
    local killerTagIcon = nil
    local killerTagColor = nil
    local killerIdentifier = nil
    local killerServerId = nil

    if killerId and killerId > 0 and GetPlayerName(killerId) then
        killerServerId = killerId
        killerIdentifier = Bridge.GetPlayerIdentifier(killerId)
        killerName = Bridge.GetSteamName(killerId)
        killerAvatar = Bridge.GetCachedAvatar(killerId)
        local killerClan = killerIdentifier and Database.GetPlayerClan(killerIdentifier)
        if killerClan then
            killerTag = killerClan.tag
            killerTagIcon = killerClan.icon
            killerTagColor = killerClan.color
        end
        if killerIdentifier then
            local stats = Bridge.IncrementKills(killerIdentifier)
            Database.IncrementKills(killerIdentifier, killerName)
            TriggerClientEvent('eg_killfeed:client:updateStats', killerId, stats.kills, stats.deaths)
            KillStreaks[killerId] = (KillStreaks[killerId] or 0) + 1
            TriggerClientEvent('eg_killfeed:client:updateStreak', killerId, KillStreaks[killerId])
        end
    end
    if KillStreaks[src] and KillStreaks[src] > 0 then
        KillStreaks[src] = 0
        TriggerClientEvent('eg_killfeed:client:updateStreak', src, 0)
    end
    if victimIdentifier then
        local stats = Bridge.IncrementDeaths(victimIdentifier)
        Database.IncrementDeaths(victimIdentifier, victimName)
        TriggerClientEvent('eg_killfeed:client:updateStats', src, stats.kills, stats.deaths)
    end

    local weaponCategory = GetWeaponCategory(weaponHash)

    local killData = {
        id = 'kill_' .. tostring(now) .. '_' .. tostring(src),
        killerId = killerServerId,
        killerName = killerName,
        killerAvatar = killerAvatar,
        killerTag = killerTag,
        killerTagIcon = killerTagIcon,
        killerTagColor = killerTagColor,
        victimId = src,
        victimName = victimName,
        victimAvatar = victimAvatar,
        victimTag = victimTag,
        victimTagIcon = victimTagIcon,
        victimTagColor = victimTagColor,
        weapon = weaponLabel,
        weaponCategory = weaponCategory,
        weaponHash = weaponHash,
        weaponHashName = weaponHashName,
        distance = distance or 0,
        timestamp = now,
        isSuicide = isSuicide or false,
    }

    TriggerClientEvent('eg_killfeed:client:addKill', -1, killData)
    Webhooks.SendKillLog(killData)
end)

RegisterNetEvent('eg_killfeed:server:playerLoaded', function()
    local src = source
    local identifier = Bridge.GetPlayerIdentifier(src)
    if not identifier then return end
    local stats = Database.GetStats(identifier)
    Bridge.SetStats(identifier, stats.kills, stats.deaths)
    local clanTag = Database.GetClanTag(identifier)
    Bridge.SetClanTag(identifier, clanTag)
    Bridge.FetchAvatar(src, function() end)
    local prefs = Database.GetPreferences(identifier)
    local prefsData = {
        killfeedEnabled = true,
        killfeedX = 70.0,
        killfeedY = 2.0,
        killfeedScale = 100,
        killfeedMaxEntries = 5,
        killfeedDuration = 5,
        kdEnabled = true,
        kdX = 85.0,
        kdY = 90.0,
        kdScale = 100,
        clanTag = nil,
    }
    if prefs then
        prefsData.killfeedEnabled = prefs.killfeed_enabled == 1 or prefs.killfeed_enabled == true
        prefsData.killfeedX = prefs.killfeed_x
        prefsData.killfeedY = prefs.killfeed_y
        prefsData.killfeedScale = prefs.killfeed_scale
        prefsData.killfeedMaxEntries = prefs.killfeed_max_entries
        prefsData.killfeedDuration = prefs.killfeed_duration
        prefsData.kdEnabled = prefs.kd_enabled == 1 or prefs.kd_enabled == true
        prefsData.kdX = prefs.kd_x
        prefsData.kdY = prefs.kd_y
        prefsData.kdScale = prefs.kd_scale
        prefsData.clanTag = prefs.clan_tag
    end
    TriggerClientEvent('eg_killfeed:client:loadData', src, prefsData, stats)
end)

RegisterCommand('testkill', function(source)
    local src = source
    if src == 0 then return end
    local name = Bridge.GetSteamName(src)
    local avatar = Bridge.GetCachedAvatar(src)
    local identifier = Bridge.GetPlayerIdentifier(src)
    local clan = identifier and Database.GetPlayerClan(identifier)
    local tag, tagIcon, tagColor
    if clan then
        tag = clan.tag
        tagIcon = clan.icon
        tagColor = clan.color
    end
    local killData = {
        id = 'test_' .. tostring(GetGameTimer()),
        killerId = src,
        killerName = name,
        killerAvatar = avatar,
        killerTag = tag,
        killerTagIcon = tagIcon,
        killerTagColor = tagColor,
        victimId = 999,
        victimName = 'Test Player',
        victimAvatar = nil,
        victimTag = 'TEST',
        victimTagIcon = 'pi-star',
        victimTagColor = '#FFC107',
        weapon = 'Assault Rifle',
        weaponCategory = 'rifle',
        weaponHashName = 'weapon_assaultrifle',
        distance = 24.5,
        timestamp = GetGameTimer(),
    }
    TriggerClientEvent('eg_killfeed:client:addKill', src, killData)
end, false)

AddEventHandler('playerDropped', function()
    DeathCooldowns[source] = nil
    KillStreaks[source] = nil
end)
