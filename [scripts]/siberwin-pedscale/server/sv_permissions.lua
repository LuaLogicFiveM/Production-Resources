local ESX, QBCore = nil, nil
local botToken = ''

local function getPlayerDiscordId(source)
    local identifiers = GetPlayerIdentifiers(source)
    for _, identifier in ipairs(identifiers) do
        if string.match(identifier, "discord:") then
            return string.gsub(identifier, "discord:", "")
        end
    end
    return nil
end

local function checkDiscordRole(discordId, callback)
    local url = string.format(
        "https://discord.com/api/guilds/%s/members/%s",
        Config.Discord.rolePermission.guildId,
        discordId
    )
    
    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            if data and data.roles then
                for _, roleId in ipairs(data.roles) do
                    if roleId == Config.Discord.rolePermission.roleId then
                        callback(true)
                        return
                    end
                end
            end
        end
        callback(false)
    end, 'GET', '', {
        ['Authorization'] = 'Bot '..botToken,
        ['Content-Type'] = 'application/json'
    })
end

local function sendAdminDiscordLog(title, description, adminName, adminId, targetInfo)

    local fields = {
        {
            ["name"] = "Admin Info",
            ["value"] = string.format("**Name:** %s\n**Server ID:** %d", adminName, adminId),
            ["inline"] = true
        }
    }

    if targetInfo then
        table.insert(fields, {
            ["name"] = "Target Info",
            ["value"] = targetInfo,
            ["inline"] = true
        })
    end

    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = 15158332,
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = "SiberWin PedScale Admin System",
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
    
    PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
        print('[siberwin-pedscale] ESX Framework loaded for permissions')
    elseif GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        print('[siberwin-pedscale] QBCore Framework loaded for permissions')
    else
        print('[siberwin-pedscale] No framework detected for permissions')
    end
end)

local function hasPermission(source, callback)
    if not Config.Permissions.enabled and not Config.Discord.rolePermission.enabled then
        callback(true, "none")
        return
    end

    local hasFrameworkPermission = false
    local hasDiscordPermission = false
    local checksCompleted = 0
    local totalChecks = 0

    if Config.Permissions.enabled then
        totalChecks = totalChecks + 1

        if ESX then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer then
                for _, group in ipairs(Config.Permissions.groups) do
                    if xPlayer.getGroup() == group then
                        hasFrameworkPermission = true
                        break
                    end
                end
            end
        elseif QBCore then
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                for _, group in ipairs(Config.Permissions.groups) do
                    if Player.PlayerData.job.name == group or
                       Player.PlayerData.gang.name == group or
                       QBCore.Functions.HasPermission(source, group) then
                        hasFrameworkPermission = true
                        break
                    end
                end
            end
        end

        if not hasFrameworkPermission then
            local playerIdentifiers = GetPlayerIdentifiers(source)
            for _, allowedId in ipairs(Config.Permissions.identifiers) do
                for _, playerId in ipairs(playerIdentifiers) do
                    if playerId == allowedId then
                        hasFrameworkPermission = true
                        break
                    end
                end
                if hasFrameworkPermission then break end
            end
        end

        checksCompleted = checksCompleted + 1
    end

    if Config.Discord.rolePermission.enabled then
        totalChecks = totalChecks + 1

        local discordId = getPlayerDiscordId(source)
        if discordId then
            checkDiscordRole(discordId, function(hasRole)
                hasDiscordPermission = hasRole
                checksCompleted = checksCompleted + 1

                if checksCompleted >= totalChecks then
                    local permissionType = "none"
                    if hasFrameworkPermission and hasDiscordPermission then
                        permissionType = "both"
                    elseif hasFrameworkPermission then
                        permissionType = "framework"
                    elseif hasDiscordPermission then
                        permissionType = "discord"
                    end

                    callback(hasFrameworkPermission or hasDiscordPermission, permissionType)
                end
            end)
        else
            checksCompleted = checksCompleted + 1
        end
    end

    if checksCompleted >= totalChecks then
        local permissionType = "none"
        if hasFrameworkPermission then
            permissionType = "framework"
        end
        callback(hasFrameworkPermission or hasDiscordPermission, permissionType)
    end
end

RegisterNetEvent('siberwin-pedscale:server:checkPermission')
AddEventHandler('siberwin-pedscale:server:checkPermission', function()
    local src = source
    hasPermission(src, function(hasAccess, permissionType)
        TriggerClientEvent('siberwin-pedscale:client:permissionResult', src, hasAccess, permissionType)
    end)
end)

local function hasGiveScalePermission(source)
    if not Config.GiveScaleMenu.enabled then
        return false
    end

    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.getGroup() == Config.GiveScaleMenu.group then
            return true
        end
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            if Player.PlayerData.job.name == Config.GiveScaleMenu.group or
               Player.PlayerData.gang.name == Config.GiveScaleMenu.group or
               QBCore.Functions.HasPermission(source, Config.GiveScaleMenu.group) then
                return true
            end
        end
    end

    return false
end

RegisterNetEvent('siberwin-pedscale:server:giveScaleMenu')
AddEventHandler('siberwin-pedscale:server:giveScaleMenu', function(targetId)
    local src = source

    if not hasGiveScalePermission(src) then
        TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
            type = 'error',
            messageKey = 'notification_givescale_permission_denied',
            titleKey = 'notification_permission_denied_title'
        })
        return
    end

    local targetPlayer = GetPlayerPing(targetId)
    if targetPlayer == 0 then
        TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
            type = 'error',
            messageKey = 'notification_givescale_player_not_found',
            titleKey = 'notification_error_title'
        })
        return
    end

    local targetName = GetPlayerName(targetId)

    TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
        type = 'success',
        messageKey = 'notification_givescale_success',
        titleKey = 'notification_givescale_success',
        replacements = {
            playerName = targetName,
            playerId = targetId
        }
    })

    TriggerClientEvent('siberwin-pedscale:client:openMenuByAdmin', targetId)

    TriggerClientEvent('siberwin-pedscale:client:showNotification', targetId, {
        type = 'info',
        messageKey = 'notification_givescale_menu_opened',
        titleKey = 'notification_scale_system_title'
    })

    if Config.Discord.enabled and Config.Discord.logs.adminActions then
        local adminName = GetPlayerName(src)
        local targetInfo = string.format("**Name:** %s\n**Server ID:** %d", targetName, targetId)

        sendAdminDiscordLog(
            "🎛️ Admin Give Scale Menu",
            string.format("Admin **%s** opened scale menu for player **%s**.", adminName, targetName),
            adminName,
            src,
            targetInfo
        )
    end
end)

local function hasCheckScalePermission(source)
    if not Config.CheckScale.enabled then
        return false
    end

    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.getGroup() == Config.CheckScale.group then
            return true
        end
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            if Player.PlayerData.job.name == Config.CheckScale.group or
               Player.PlayerData.gang.name == Config.CheckScale.group or
               QBCore.Functions.HasPermission(source, Config.CheckScale.group) then
                return true
            end
        end
    end

    return false
end

RegisterNetEvent('siberwin-pedscale:server:getScaleRecords')
AddEventHandler('siberwin-pedscale:server:getScaleRecords', function()
    local src = source

    if not hasCheckScalePermission(src) then
        TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
            type = 'error',
            messageKey = 'notification_checkscale_permission_denied',
            titleKey = 'notification_permission_denied_title'
        })
        return
    end

    exports.oxmysql:execute('SELECT * FROM `siberwin-pedscale` ORDER BY updated_at DESC', {}, function(result)
        if result and #result > 0 then
            TriggerClientEvent('siberwin-pedscale:client:scaleRecordsLoaded', src, result)
            TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
                type = 'success',
                messageKey = 'notification_checkscale_records_loaded',
                titleKey = 'checkscale_title',
                replacements = {
                    count = tostring(#result)
                }
            })

            if Config.Discord.enabled and Config.Discord.logs.adminActions then
                local adminName = GetPlayerName(src)

                sendAdminDiscordLog(
                    "📊 Admin Check Scale Records",
                    string.format("Admin **%s** accessed scale database records (%d records found).", adminName, #result),
                    adminName,
                    src,
                    string.format("**Records Found:** %d", #result)
                )
            end
        else
            TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
                type = 'warning',
                messageKey = 'notification_checkscale_no_records',
                titleKey = 'checkscale_title'
            })
        end
    end)
end)

RegisterNetEvent('siberwin-pedscale:server:deleteScaleRecord')
AddEventHandler('siberwin-pedscale:server:deleteScaleRecord', function(identifier)
    local src = source

    if not hasCheckScalePermission(src) then
        TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
            type = 'error',
            messageKey = 'notification_checkscale_permission_denied',
            titleKey = 'notification_permission_denied_title'
        })
        return
    end

    exports.oxmysql:execute('DELETE FROM `siberwin-pedscale` WHERE identifier = ?', {
        identifier
    }, function(result)
        if result.affectedRows > 0 then
            TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
                type = 'success',
                messageKey = 'notification_checkscale_record_deleted',
                titleKey = 'checkscale_title',
                replacements = {
                    identifier = identifier
                }
            })

            if Config.Discord.enabled and Config.Discord.logs.adminActions then
                local adminName = GetPlayerName(src)

                sendAdminDiscordLog(
                    "🗑️ Admin Delete Scale Record",
                    string.format("Admin **%s** deleted a scale record from database.", adminName),
                    adminName,
                    src,
                    string.format("**Deleted Identifier:** %s", identifier)
                )
            end

            exports.oxmysql:execute('SELECT * FROM `siberwin-pedscale` ORDER BY updated_at DESC', {}, function(updatedRecords)
                if updatedRecords then
                    TriggerClientEvent('siberwin-pedscale:client:scaleRecordsLoaded', src, updatedRecords)
                end
            end)
        else
            TriggerClientEvent('siberwin-pedscale:client:showNotification', src, {
                type = 'error',
                messageKey = 'notification_checkscale_delete_failed',
                titleKey = 'checkscale_title'
            })
        end
    end)
end)


