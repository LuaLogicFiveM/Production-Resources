RegisterNetEvent('prp-horde:server:headShot', function(netId)
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:pedHeadshotted(playerId, netId)
end)
