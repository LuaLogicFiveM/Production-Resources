local function MapPreferences(prefs)
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
    return prefsData
end

lib.callback.register('eg_killfeed:server:getPreferences', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return nil end
    local prefs = Database.GetPreferences(identifier)
    local stats = Bridge.GetStats(identifier)
    local isStaff = Bridge.HasPermission(source)
    return {
        preferences = MapPreferences(prefs),
        stats = stats,
        isStaff = isStaff,
    }
end)

lib.callback.register('eg_killfeed:server:getInitialData', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return nil end
    local prefs = Database.GetPreferences(identifier)
    local stats = Bridge.GetStats(identifier)
    return {
        preferences = MapPreferences(prefs),
        stats = stats,
    }
end)

lib.callback.register('eg_killfeed:server:savePreferences', function(source, prefs)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier or not prefs then return false end
    if prefs.clanTag then
        if #prefs.clanTag > Config.ClanTag.MaxLength then
            Bridge.Notify(source, _('clantag_too_long'), 'error')
            prefs.clanTag = string.sub(prefs.clanTag, 1, Config.ClanTag.MaxLength)
        end
        if not string.match(prefs.clanTag, '^[%w%-%_%.%s]*$') then
            Bridge.Notify(source, _('clantag_invalid'), 'error')
            prefs.clanTag = nil
        end
    end
    Bridge.SetClanTag(identifier, prefs.clanTag)
    return Database.SavePreferences(identifier, prefs)
end)

lib.callback.register('eg_killfeed:server:resetStats', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return false end
    Database.ResetStats(identifier)
    Bridge.SetStats(identifier, 0, 0)
    Bridge.Notify(source, _('stats_reset'), 'success')
    return true
end)

lib.callback.register('eg_killfeed:server:createClan', function(source, tag, name, icon, color, isPrivate)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local existingClan = Database.GetPlayerClan(identifier)
    if existingClan then
        return { success = false, error = 'You are already in a clan' }
    end

    if not tag or #tag < 2 or #tag > 8 then
        return { success = false, error = 'Tag must be 2-8 characters' }
    end

    if not string.match(tag, '^[%w]+$') then
        return { success = false, error = 'Tag can only contain letters and numbers' }
    end

    local clanExists = Database.GetClan(tag)
    if clanExists then
        return { success = false, error = 'Tag already exists' }
    end

    local clanId = Database.CreateClan(tag, name or tag, identifier, icon, color, isPrivate)
    if clanId then
        local playerName = Bridge.GetSteamName(source)
        Database.JoinClan(clanId, identifier, playerName)
        Bridge.SetClanTag(identifier, tag)
        return { success = true, clanId = clanId }
    end

    return { success = false, error = 'Failed to create clan' }
end)

lib.callback.register('eg_killfeed:server:getAllClans', function(source)
    return Database.GetAllClans()
end)

lib.callback.register('eg_killfeed:server:getClanMembers', function(source, clanId)
    return Database.GetClanMembers(clanId)
end)

lib.callback.register('eg_killfeed:server:getPlayerClan', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return nil end
    local clan = Database.GetPlayerClan(identifier)
    if clan then
        clan.isOwner = clan.owner_identifier == identifier
    end
    return clan
end)

lib.callback.register('eg_killfeed:server:joinClan', function(source, clanId)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local existingClan = Database.GetPlayerClan(identifier)
    if existingClan then
        return { success = false, error = 'You are already in a clan' }
    end

    local clan = Database.GetClanById(clanId)
    if not clan then
        return { success = false, error = 'Clan not found' }
    end

    local playerName = Bridge.GetSteamName(source)
    local success = Database.JoinClan(clanId, identifier, playerName)
    if success then
        Bridge.SetClanTag(identifier, clan.tag)
        return { success = true }
    end

    return { success = false, error = 'Failed to join clan' }
end)

lib.callback.register('eg_killfeed:server:leaveClan', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local clan = Database.GetPlayerClan(identifier)
    if not clan then
        return { success = false, error = 'You are not in a clan' }
    end

    if clan.owner_identifier == identifier then
        return { success = false, error = 'Owner cannot leave clan. Delete it instead.' }
    end

    local success = Database.LeaveClan(identifier)
    if success then
        Bridge.SetClanTag(identifier, nil)
        return { success = true }
    end

    return { success = false, error = 'Failed to leave clan' }
end)

lib.callback.register('eg_killfeed:server:removeMember', function(source, targetIdentifier)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local clan = Database.GetPlayerClan(identifier)
    if not clan then
        return { success = false, error = 'You are not in a clan' }
    end

    if clan.owner_identifier ~= identifier then
        return { success = false, error = 'Only the owner can remove members' }
    end

    if targetIdentifier == identifier then
        return { success = false, error = 'Cannot remove yourself' }
    end

    local success = Database.RemoveMember(clan.id, targetIdentifier)
    if success then
        for _, playerId in ipairs(GetPlayers()) do
            local pid = Bridge.GetPlayerIdentifier(playerId)
            if pid == targetIdentifier then
                Bridge.SetClanTag(pid, nil)
                TriggerClientEvent('eg_killfeed:client:clanUpdated', playerId)
                break
            end
        end
        return { success = true }
    end

    return { success = false, error = 'Failed to remove member' }
end)

lib.callback.register('eg_killfeed:server:updateClan', function(source, data)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local clan = Database.GetPlayerClan(identifier)
    if not clan then
        return { success = false, error = 'You are not in a clan' }
    end

    if clan.owner_identifier ~= identifier then
        return { success = false, error = 'Only the owner can update clan settings' }
    end

    local success = Database.UpdateClan(clan.id, data)
    if success then
        return { success = true }
    end

    return { success = false, error = 'Failed to update clan' }
end)

lib.callback.register('eg_killfeed:server:deleteClan', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local clan = Database.GetPlayerClan(identifier)
    if not clan then
        return { success = false, error = 'You are not in a clan' }
    end

    if clan.owner_identifier ~= identifier then
        return { success = false, error = 'Only the owner can delete the clan' }
    end

    local members = Database.GetClanMembers(clan.id)

    local success = Database.DeleteClan(clan.id)
    if success then
        for _, member in ipairs(members) do
            for _, playerId in ipairs(GetPlayers()) do
                local pid = Bridge.GetPlayerIdentifier(playerId)
                if pid == member.identifier then
                    Bridge.SetClanTag(pid, nil)
                    TriggerClientEvent('eg_killfeed:client:clanUpdated', playerId)
                    break
                end
            end
        end
        return { success = true }
    end

    return { success = false, error = 'Failed to delete clan' }
end)

-- Clan Invitations
lib.callback.register('eg_killfeed:server:getOnlinePlayers', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return {} end

    local clan = Database.GetPlayerClan(identifier)
    local clanMembers = {}
    if clan then
        local members = Database.GetClanMembers(clan.id)
        for _, m in ipairs(members) do
            clanMembers[m.identifier] = true
        end
    end

    local players = {}
    for _, playerId in ipairs(GetPlayers()) do
        local pid = tonumber(playerId)
        if pid ~= source then
            local pIdentifier = Bridge.GetPlayerIdentifier(pid)
            if pIdentifier and not clanMembers[pIdentifier] then
                table.insert(players, {
                    serverId = pid,
                    name = GetPlayerName(pid) or 'Unknown',
                    identifier = pIdentifier,
                })
            end
        end
    end

    return players
end)

lib.callback.register('eg_killfeed:server:invitePlayer', function(source, targetServerId)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local clan = Database.GetPlayerClan(identifier)
    if not clan then
        return { success = false, error = 'You are not in a clan' }
    end

    if clan.owner_identifier ~= identifier then
        return { success = false, error = 'Only the owner can invite players' }
    end

    local targetId = tonumber(targetServerId)
    if not targetId or not GetPlayerName(targetId) then
        return { success = false, error = 'Player not found' }
    end

    local targetIdentifier = Bridge.GetPlayerIdentifier(targetId)
    if not targetIdentifier then
        return { success = false, error = 'Player identifier not found' }
    end

    local targetClan = Database.GetPlayerClan(targetIdentifier)
    if targetClan then
        return { success = false, error = 'Player is already in a clan' }
    end

    local result = Database.CreateInvitation(clan.id, targetIdentifier, identifier)
    if result then
        TriggerClientEvent('eg_killfeed:client:clanInvitation', targetId, {
            clanTag = clan.tag,
            clanName = clan.name,
        })
        return { success = true }
    end

    return { success = false, error = 'Player already has a pending invitation' }
end)

lib.callback.register('eg_killfeed:server:getMyInvitations', function(source)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return {} end
    return Database.GetPlayerInvitations(identifier)
end)

lib.callback.register('eg_killfeed:server:acceptInvitation', function(source, invitationId)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local existingClan = Database.GetPlayerClan(identifier)
    if existingClan then
        return { success = false, error = 'You are already in a clan' }
    end

    local invitation = Database.GetInvitationById(invitationId)
    if not invitation or invitation.target_identifier ~= identifier then
        return { success = false, error = 'Invitation not found' }
    end

    local clan = Database.GetClanById(invitation.clan_id)
    if not clan then
        Database.DeleteInvitation(invitationId, identifier)
        return { success = false, error = 'Clan no longer exists' }
    end

    local playerName = Bridge.GetSteamName(source)
    local joined = Database.JoinClan(clan.id, identifier, playerName)
    if joined then
        Bridge.SetClanTag(identifier, clan.tag)
        Database.DeletePlayerInvitations(identifier)
        return { success = true }
    end

    return { success = false, error = 'Failed to join clan' }
end)

lib.callback.register('eg_killfeed:server:declineInvitation', function(source, invitationId)
    local identifier = Bridge.GetPlayerIdentifier(source)
    if not identifier then return { success = false, error = 'Invalid identifier' } end

    local success = Database.DeleteInvitation(invitationId, identifier)
    return { success = success }
end)
