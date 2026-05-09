RegisterNetEvent('prp-horde:server:openCrate', function(pointId)
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:openCrate(playerId, pointId)
end)