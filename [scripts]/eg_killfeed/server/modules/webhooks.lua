Webhooks = {}

function Webhooks.SendKillLog(killData)
    if not ServerConfig.Webhooks.Enabled or not ServerConfig.Webhooks.KillLog or ServerConfig.Webhooks.KillLog == '' then return end
    local fields = {}
    if killData.killerName then
        fields[#fields + 1] = { name = 'Killer', value = killData.killerName, inline = true }
    end
    fields[#fields + 1] = { name = 'Victim', value = killData.victimName or 'Unknown', inline = true }
    fields[#fields + 1] = { name = 'Weapon', value = killData.weapon or 'Unknown', inline = true }
    local color = killData.killerName and 15158332 or 9936031
    local title = killData.killerName and killData.killerName .. ' killed ' .. (killData.victimName or 'Unknown') or (killData.victimName or 'Unknown') .. ' died (' .. (killData.weapon or 'Unknown') .. ')'
    local embed = {
        embeds = {
            {
                title = title,
                color = color,
                fields = fields,
                timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                footer = { text = 'eg_killfeed' }
            }
        }
    }
    PerformHttpRequest(ServerConfig.Webhooks.KillLog, function() end, 'POST', json.encode(embed), { ['Content-Type'] = 'application/json' })
end

function Webhooks.SendStrikeLog(data)
    if not ServerConfig.Webhooks.Enabled or not ServerConfig.Webhooks.StrikeLog or ServerConfig.Webhooks.StrikeLog == '' then return end
    local embed = {
        embeds = {
            {
                title = 'Strike Given',
                color = 15105570,
                fields = {
                    { name = 'Player', value = data.playerName or 'Unknown', inline = true },
                    { name = 'Reason', value = data.reason or 'N/A', inline = true },
                    { name = 'Given By', value = data.givenByName or 'Unknown', inline = true },
                },
                timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                footer = { text = 'eg_killfeed' }
            }
        }
    }
    PerformHttpRequest(ServerConfig.Webhooks.StrikeLog, function() end, 'POST', json.encode(embed), { ['Content-Type'] = 'application/json' })
end

return Webhooks
