local lorp_discord_api = exports.lorp_discord_api
local ranks = {
    ['1261189800950628383'] = 'Emerald',
    ['1249230974986747914'] = 'Diamond',
    ['1249230929252057118'] = 'Platinum',
    ['1249230896868102195'] = 'Gold',
    ['1249230828622581873'] = 'Silver',
    ['1249230750893473792'] = 'Bronze',
}

local function getPlayerRank(source)
    local playerRoles = lorp_discord_api:GetUserRoles(source)
    for roleid, rank in pairs(ranks) do
        if playerRoles[roleid] then
            return rank
        end
    end

    return false
end exports('getPlayerRank', getPlayerRank)

lib.callback.register('lorp_packed:server:getPlayerRank', function(source)
    return getPlayerRank(source)
end)