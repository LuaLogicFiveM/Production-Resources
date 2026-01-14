--exports['lorp_packed']:SendLog(title, message, webhook)

function SendLog(title, message, webhook)
    local embedData = {
        {
            ["title"] = title,
            ["color"] = 16711680,
            ["footer"] = {
                ["text"] = os.date('%Y-%m-%d %H:%M:%S'),
            },
            ["description"] = message,
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = "Leaned Out RP",embeds = embedData}), { ['Content-Type'] = 'application/json' })
end exports('SendLog', SendLog)

AddEventHandler('playerConnecting', function(t,t2,t3)
    local source = source
    local name = GetPlayerName(source)
    local identifiers = GetPlayerIdentifiers(source)
    local did = GetPlayerIdentifierByType(source, 'discord')
    if did then
        local discord = string.gsub(did, 'discord:', '') or 'N/A'
        SendLog('__**Connection Logs**__', "### Name \n**"..name.. "**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**", 'https://ptb.discord.com/api/webhooks/1173404494411878440/cW-T0XXoKaxglcblnXg7urTfKUYFTd2kyX8E4JmE44DSTXCng3gxWGtVs9R76ox1RnCu')
    end
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local name = GetPlayerName(source)
    local discord = string.gsub(GetPlayerIdentifierByType(source, 'discord'), 'discord:', '') or 'N/A'
    local identifiers = GetPlayerIdentifiers(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local identifier = xPlayer.identifier
        local job = xPlayer.getJob()
        local charName = xPlayer.getName()
        local bank = xPlayer.getAccount('bank').money
        local cash = xPlayer.getInventoryItem('money').count
        local dirty = xPlayer.getInventoryItem('black_money').count
        local ped = GetPlayerPed(source)
        local coords = ped and GetEntityCoords(ped) or 'N/A'

        SendLog('__**Leave Logs**__', "### Reason\n**"..reason.. "**\n### Identifier\n**"..identifier.. "**\n### Name \n**"..name.. " ("..source..")**\n### Character Name\n**"..charName.."**\n### Character Job\n**"..job.label.."**\n### Character Job Rank\n**"..job.grade_label.." ("..job.grade..")**\n### Cash\n**"..cash.."**\n### Bank\n**"..bank.."**\n### Dirty Cash\n**"..dirty.."**\n### Coords\n**"..coords.."**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**", 'https://ptb.discord.com/api/webhooks/1173404494411878440/cW-T0XXoKaxglcblnXg7urTfKUYFTd2kyX8E4JmE44DSTXCng3gxWGtVs9R76ox1RnCu')
    else
        SendLog('__**Leave Logs**__', "### Reason \n**"..reason.. "**\n### Name \n**"..name.. " ("..source..")**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**", 'https://ptb.discord.com/api/webhooks/1173404494411878440/cW-T0XXoKaxglcblnXg7urTfKUYFTd2kyX8E4JmE44DSTXCng3gxWGtVs9R76ox1RnCu')
    end
end)

AddEventHandler('esx:playerLoaded', function (playerId, xPlayer, isNew)
    local target = playerId
    local name = GetPlayerName(target)
    local playerPing = GetPlayerPing(target)
    local discord = string.gsub(GetPlayerIdentifierByType(target, 'discord'), 'discord:', '') or 'N/A'
    local identifiers = GetPlayerIdentifiers(target)
    local job = xPlayer.getJob()
    local charName = xPlayer.getName()
    local bank = xPlayer.getAccount('bank').money
    local cash = xPlayer.getInventoryItem('money').count
    local dirty = xPlayer.getInventoryItem('black_money').count

    SendLog('__**Join Logs**__', "### Identifier\n**"..xPlayer.identifier.. "**\n### Name \n**"..name.. " ("..target..")**\n### Character Name\n**"..charName.."**\n### Character Job\n**"..job.label.."**\n### Character Job Rank\n**"..job.grade_label.." ("..job.grade..")**\n### Cash\n**"..cash.."**\n### Bank\n**"..bank.."**\n### Dirty Cash\n**"..dirty.."**"..bank.."**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**\n### Ping\n**"..playerPing.. "**", 'https://ptb.discord.com/api/webhooks/1173404494411878440/cW-T0XXoKaxglcblnXg7urTfKUYFTd2kyX8E4JmE44DSTXCng3gxWGtVs9R76ox1RnCu')
end)

RegisterNetEvent('lorp_packed:server:handling', function(data)
    if data then
        SendLog('__**Handling Logs**__', '### Data: ' ..json.encode(data), 'https://discord.com/api/webhooks/1247321910946168842/7KTLs5M4x3vBppj7YNP1BjfeU3CmCV_7DpiNX4R-i51ulvPTdn1__wt0_uf8d0PIQZR1')
    end
end)

local timer
RegisterNetEvent('lorp_packed:server:noclip', function(data)
    local src = source
    if data then
        if data.type == 'Enabled' then
            timer = os.time()
            SendLog('__**No-Clip Logs**__', '### Name: '..GetPlayerName(src)..'\n ### Coords: ' ..json.encode(data.coords)..'\n ### Type: ' ..data.type, 'https://discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
        else
            SendLog('__**No-Clip Logs**__', '### Name: '..GetPlayerName(src)..'\n ### Coords: ' ..json.encode(data.coords)..'\n ### Time: '..(os.time()-timer)..' Seconds', 'https://discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
        end
    end
end)