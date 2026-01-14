RegisterNetEvent('matchmaking:setMatchData', function(data)
    local ped = cache.ped
    RemoveAllPedWeapons(ped, true)
    lib.hideContext(nil)
    exports.ox_inventory:weaponWheel(true)
    local weapon = joaat(data.weapon)
    GiveWeaponToPed(ped, weapon, 9999, false, true)
    SetPedWeaponTintIndex(ped, weapon, 0)
    SetCurrentPedWeapon(ped, weapon, true)
end)

local function showScoreUI(team1Score, team2Score)
    lib.showTextUI(
        string.format("🏆 Team 1: %d | Team 2: %d", team1Score, team2Score),
        {
            position = "top-center",
            icon = 'trophy',
            style = {
                borderRadius = 10,
                backgroundColor = '#1A202C', -- Dark background for contrast
                color = '#F6E05E',           -- Gold text for scores
                padding = '10px',
                fontWeight = 'bold',
                fontSize = '16px',
                boxShadow = '0px 4px 6px rgba(0, 0, 0, 0.1)'
            }
        }
    )
end

-- matchmaking:updateScores
RegisterNetEvent('matchmaking:updateScores', function(scores)
    -- Extract scores
    local team1Score = scores.Team1 or 0
    local team2Score = scores.Team2 or 0

    -- Show the updated score UI
    showScoreUI(team1Score, team2Score)
end)

-- matchmaking:leaveMatch
RegisterNetEvent('matchmaking:leaveMatch', function()
    local ped = cache.ped
    exports.ox_inventory:weaponWheel(false)
    lib.hideTextUI()
    RemoveAllPedWeapons(ped, true)
end)