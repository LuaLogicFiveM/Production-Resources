RegisterNetEvent('prp-horde:server:voteForPerk', function(optionId)
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:voteForPerk(playerId, optionId)
end)