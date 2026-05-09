--exports['lorp_packed']:SendLog(title, message, webhook)
local ox_inventory = exports.ox_inventory

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
        SendLog('__**Connection Logs**__', "### Name \n**"..name.. "**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**", '')
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
        local cash = ox_inventory:GetItemCount(source, 'money')
        local dirty = ox_inventory:GetItemCount(source, 'black_money')
        local ped = GetPlayerPed(source)
        local coords = ped and GetEntityCoords(ped) or 'N/A'

        SendLog('__**Leave Logs**__', "### Reason\n**"..reason.. "**\n### Identifier\n**"..identifier.. "**\n### Name \n**"..name.. " ("..source..")**\n### Character Name\n**"..charName.."**\n### Character Job\n**"..job.label.."**\n### Character Job Rank\n**"..job.grade_label.." ("..job.grade..")**\n### Cash\n**"..cash.."**\n### Bank\n**"..bank.."**\n### Dirty Cash\n**"..dirty.."**\n### Coords\n**"..coords.."**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**", '')
    else
        SendLog('__**Leave Logs**__', "### Reason \n**"..reason.. "**\n### Name \n**"..name.. " ("..source..")**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**", '')
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew)
    local target = playerId
    local name = GetPlayerName(target)
    local playerPing = GetPlayerPing(target)
    local discord = string.gsub(GetPlayerIdentifierByType(target, 'discord'), 'discord:', '') or 'N/A'
    local identifiers = GetPlayerIdentifiers(target)
    local job = xPlayer.getJob()
    local charName = xPlayer.getName()
    local bank = xPlayer.getAccount('bank').money
    local cash = ox_inventory:GetItemCount(target, 'money')
    local dirty = ox_inventory:GetItemCount(target, 'black_money')

    SendLog('__**Join Logs**__', "### Identifier\n**"..xPlayer.identifier.. "**\n### Name \n**"..name.. " ("..target..")**\n### Character Name\n**"..charName.."**\n### Character Job\n**"..job.label.."**\n### Character Job Rank\n**"..job.grade_label.." ("..job.grade..")**\n### Cash\n**"..cash.."**\n### Bank\n**"..bank.."**\n### Dirty Cash\n**"..dirty.."**"..bank.."**\n### Discord \n<@"..discord.. ">\n### Identifiers \n**"..json.encode(identifiers).. "**\n### Ping\n**"..playerPing.. "**", '')
end)

RegisterNetEvent('lorp_packed:server:handling', function(data)
    if data then
        SendLog('__**Handling Logs**__', '### Data: ' ..json.encode(data), '')
    end
end)