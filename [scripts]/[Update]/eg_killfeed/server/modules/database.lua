Database = {}

function Database.GetPreferences(identifier)
    local result = MySQL.query.await(
        'SELECT * FROM eg_killfeed_preferences WHERE identifier = ? LIMIT 1',
        { identifier }
    )
    if result and result[1] then return result[1] end
    return nil
end

function Database.SavePreferences(identifier, prefs)
    local query = [[
        INSERT INTO eg_killfeed_preferences
        (identifier, killfeed_enabled, killfeed_x, killfeed_y, killfeed_scale,
         killfeed_max_entries, killfeed_duration, kd_enabled, kd_x, kd_y, kd_scale, clan_tag)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
            killfeed_enabled = VALUES(killfeed_enabled),
            killfeed_x = VALUES(killfeed_x),
            killfeed_y = VALUES(killfeed_y),
            killfeed_scale = VALUES(killfeed_scale),
            killfeed_max_entries = VALUES(killfeed_max_entries),
            killfeed_duration = VALUES(killfeed_duration),
            kd_enabled = VALUES(kd_enabled),
            kd_x = VALUES(kd_x),
            kd_y = VALUES(kd_y),
            kd_scale = VALUES(kd_scale),
            clan_tag = VALUES(clan_tag)
    ]]
    local result = MySQL.insert.await(query, {
        identifier,
        prefs.killfeedEnabled and 1 or 0,
        prefs.killfeedX or 70.0,
        prefs.killfeedY or 2.0,
        prefs.killfeedScale or 100,
        prefs.killfeedMaxEntries or 5,
        prefs.killfeedDuration or 5,
        prefs.kdEnabled and 1 or 0,
        prefs.kdX or 85.0,
        prefs.kdY or 90.0,
        prefs.kdScale or 100,
        prefs.clanTag
    })
    return result ~= nil
end

function Database.GetStats(identifier)
    local result = MySQL.query.await(
        'SELECT * FROM eg_killfeed_stats WHERE identifier = ? LIMIT 1',
        { identifier }
    )
    if result and result[1] then
        return { kills = result[1].kills or 0, deaths = result[1].deaths or 0 }
    end
    return { kills = 0, deaths = 0 }
end

function Database.IncrementKills(identifier, name)
    MySQL.insert.await([[
        INSERT INTO eg_killfeed_stats (identifier, player_name, kills, deaths)
        VALUES (?, ?, 1, 0)
        ON DUPLICATE KEY UPDATE kills = kills + 1, player_name = ?
    ]], { identifier, name, name })
end

function Database.IncrementDeaths(identifier, name)
    MySQL.insert.await([[
        INSERT INTO eg_killfeed_stats (identifier, player_name, kills, deaths)
        VALUES (?, ?, 0, 1)
        ON DUPLICATE KEY UPDATE deaths = deaths + 1, player_name = ?
    ]], { identifier, name, name })
end

function Database.ResetStats(identifier)
    MySQL.update.await(
        'UPDATE eg_killfeed_stats SET kills = 0, deaths = 0 WHERE identifier = ?',
        { identifier }
    )
end

function Database.GetClanTag(identifier)
    local result = MySQL.query.await(
        'SELECT clan_tag FROM eg_killfeed_preferences WHERE identifier = ? LIMIT 1',
        { identifier }
    )
    if result and result[1] then return result[1].clan_tag end
    return nil
end

function Database.CreateClan(tag, name, ownerIdentifier, icon, color, isPrivate)
    local result = MySQL.insert.await([[
        INSERT INTO eg_killfeed_clans (tag, name, owner_identifier, icon, color, is_private)
        VALUES (?, ?, ?, ?, ?, ?)
    ]], { tag, name, ownerIdentifier, icon or 'pi-users', color or '#57B657', isPrivate and 1 or 0 })
    return result
end

function Database.GetClan(tag)
    local result = MySQL.query.await(
        'SELECT * FROM eg_killfeed_clans WHERE tag = ? LIMIT 1',
        { tag }
    )
    if result and result[1] then return result[1] end
    return nil
end

function Database.GetClanById(clanId)
    local result = MySQL.query.await(
        'SELECT * FROM eg_killfeed_clans WHERE id = ? LIMIT 1',
        { clanId }
    )
    if result and result[1] then return result[1] end
    return nil
end

function Database.GetPlayerClan(identifier)
    local result = MySQL.query.await([[
        SELECT c.* FROM eg_killfeed_clans c
        INNER JOIN eg_killfeed_clan_members m ON c.id = m.clan_id
        WHERE m.identifier = ? LIMIT 1
    ]], { identifier })
    if result and result[1] then return result[1] end
    return nil
end

function Database.GetAllClans()
    local result = MySQL.query.await([[
        SELECT c.*, COUNT(m.identifier) as member_count
        FROM eg_killfeed_clans c
        LEFT JOIN eg_killfeed_clan_members m ON c.id = m.clan_id
        WHERE c.is_private = 0
        GROUP BY c.id
        ORDER BY member_count DESC
    ]])
    return result or {}
end

function Database.GetClanMembers(clanId)
    local result = MySQL.query.await([[
        SELECT m.identifier, m.player_name, m.joined_at,
               CASE WHEN c.owner_identifier = m.identifier THEN 1 ELSE 0 END as is_owner
        FROM eg_killfeed_clan_members m
        INNER JOIN eg_killfeed_clans c ON m.clan_id = c.id
        WHERE m.clan_id = ?
        ORDER BY is_owner DESC, m.joined_at ASC
    ]], { clanId })
    return result or {}
end

function Database.JoinClan(clanId, identifier, playerName)
    local result = MySQL.insert.await([[
        INSERT INTO eg_killfeed_clan_members (clan_id, identifier, player_name)
        VALUES (?, ?, ?)
    ]], { clanId, identifier, playerName })
    return result ~= nil
end

function Database.LeaveClan(identifier)
    local result = MySQL.update.await(
        'DELETE FROM eg_killfeed_clan_members WHERE identifier = ?',
        { identifier }
    )
    return result and result > 0
end

function Database.RemoveMember(clanId, targetIdentifier)
    local result = MySQL.update.await(
        'DELETE FROM eg_killfeed_clan_members WHERE clan_id = ? AND identifier = ?',
        { clanId, targetIdentifier }
    )
    return result and result > 0
end

function Database.UpdateClan(clanId, data)
    local result = MySQL.update.await([[
        UPDATE eg_killfeed_clans
        SET icon = ?, color = ?, is_private = ?
        WHERE id = ?
    ]], { data.icon, data.color, data.is_private and 1 or 0, clanId })
    return result and result > 0
end

function Database.DeleteClan(clanId)
    local result = MySQL.update.await(
        'DELETE FROM eg_killfeed_clans WHERE id = ?',
        { clanId }
    )
    return result and result > 0
end

-- Clan Invitations
function Database.CreateInvitation(clanId, targetIdentifier, invitedBy)
    local result = MySQL.insert.await([[
        INSERT IGNORE INTO eg_killfeed_clan_invitations (clan_id, target_identifier, invited_by)
        VALUES (?, ?, ?)
    ]], { clanId, targetIdentifier, invitedBy })
    return result
end

function Database.GetPlayerInvitations(identifier)
    local result = MySQL.query.await([[
        SELECT i.id, i.clan_id, i.created_at, c.tag, c.name, c.icon, c.color
        FROM eg_killfeed_clan_invitations i
        INNER JOIN eg_killfeed_clans c ON i.clan_id = c.id
        WHERE i.target_identifier = ?
        ORDER BY i.created_at DESC
    ]], { identifier })
    return result or {}
end

function Database.DeleteInvitation(invitationId, targetIdentifier)
    local result = MySQL.update.await(
        'DELETE FROM eg_killfeed_clan_invitations WHERE id = ? AND target_identifier = ?',
        { invitationId, targetIdentifier }
    )
    return result and result > 0
end

function Database.DeletePlayerInvitations(identifier)
    MySQL.update.await(
        'DELETE FROM eg_killfeed_clan_invitations WHERE target_identifier = ?',
        { identifier }
    )
end

function Database.GetInvitationById(invitationId)
    local result = MySQL.query.await(
        'SELECT * FROM eg_killfeed_clan_invitations WHERE id = ? LIMIT 1',
        { invitationId }
    )
    if result and result[1] then return result[1] end
    return nil
end

return Database
