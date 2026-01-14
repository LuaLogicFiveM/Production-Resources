local leaderboard = {}

RegisterNetEvent('matchmaking:updateLeaderboard')
AddEventHandler('matchmaking:updateLeaderboard', function(winner)
    leaderboard[winner] = (leaderboard[winner] or 0) + 1
end)

RegisterCommand('leaderboard', function(source)
    local sorted = {}
    for player, wins in pairs(leaderboard) do
        table.insert(sorted, {player = player, wins = wins})
    end
    table.sort(sorted, function(a, b) return a.wins > b.wins end)
end)
