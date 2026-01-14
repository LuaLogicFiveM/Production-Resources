local lorp_packed = exports.lorp_packed
local ox_inventory = exports.ox_inventory
local ranks = {
    ['Emerald'] = 1000000,
    ['Diamond'] = 750000,
    --['Platinum'] = 500000,
    --['Gold'] = 300000,
    --['Silver'] = 200000,
    --['Bronze'] = 100000,
}

lib.callback.register('lorp_packed:server:requestStorageData', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end
    local playerRank = lorp_packed:getPlayerRank(src)
    if not playerRank then return false end
    ox_inventory:RegisterStash('paid', 'Paid Storage', 100, ranks[playerRank], xPlayer.identifier)
    lorp_packed:SendLog('__**Personal Storage Logs**__', "### Name \n"..GetPlayerName(src).. " ("..src..")**\n### Location \n"..GetEntityCoords(GetPlayerPed(src)).. " ("..src..")**\n### Discord \n<@"..string.gsub(GetPlayerIdentifierByType(src, 'discord'), 'discord:', '').. ">\n### Identifiers \n**"..json.encode(GetPlayerIdentifiers(src)).. "**", 'https://discord.com/api/webhooks/1407201238684139561/lcVzLUHQjEodpqghvO58zJsscVccbPXVs-5qOsfuIHL0ZwsALYn5yMF-yFxBE9hTDOqK')
    return xPlayer.identifier
end)