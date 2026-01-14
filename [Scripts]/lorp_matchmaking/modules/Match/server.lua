---@class Match : OxClass
---@field id number
---@field players table
---@field type string
---@field weapon string
---@field bucketId number
---@field teamScores table
---@field playerStates table
local object = lib.class('Match')
local ESX <const> = exports.es_extended:getSharedObject()

-- Constructor
function object:constructor(id, players, matchType, weapon)
    self.id = id
    self.players = players
    self.type = matchType
    self.weapon = weapon
    self.bucketId = math.random(100, 200) -- Generate unique routing bucket
    self.teamScores = { Team1 = 0, Team2 = 0 } -- Keep track of scores
    self.playerStates = {} -- Keep track of whether players are alive
    self.rampSet = Config.Ramps[math.random(1, #Config.Ramps)]
end

-- Setup Match
function object:setup()
    local rampSet = self.rampSet
    if not rampSet then
        return
    end

    local teamSize = math.floor(#self.players / 2)
    local teams = { Team1 = {}, Team2 = {} }

    -- Assign players to teams
    for i, playerId in ipairs(self.players) do
        if i <= teamSize then
            table.insert(teams.Team1, playerId)
        else
            table.insert(teams.Team2, playerId)
        end
        self.playerStates[playerId] = true -- Mark players as alive
    end

    self.teams = teams

    -- Teleport players to ramp positions
    for team, players in pairs(teams) do
        local rampPositions = rampSet[team]
        if rampPositions then
            for i, playerId in ipairs(players) do
                local pos = rampPositions[i]
                if pos and GetPlayerPed(playerId) then
                    SetPlayerRoutingBucket(playerId, self.bucketId)
                    SetEntityCoords(GetPlayerPed(playerId), pos.x, pos.y, pos.z, false, false, false, true)
                    SetEntityHeading(GetPlayerPed(playerId), pos.w)

                    -- Notify player
                    TriggerClientEvent('matchmaking:notify', playerId, {
                        type = 'success',
                        title = 'Match Started',
                        description = 'Teleporting to ramp position...'
                    })

                    TriggerClientEvent('matchmaking:setClient', playerId, true)

                    -- Send match data to player
                    TriggerClientEvent('matchmaking:setMatchData', playerId, {
                        matchId = self.id,
                        team = team,
                        weapon = self.weapon
                    })
                else
                end
            end
        else
        end
    end

    -- Freeze all players
    for _, playerId in ipairs(self.players) do
        FreezeEntityPosition(GetPlayerPed(playerId), true)
    end

    -- Countdown logic with notifications
    for i = 3, 1, -1 do
        Wait(1000) -- Wait 1 second
        for _, playerId in ipairs(self.players) do
            TriggerClientEvent('matchmaking:notify', playerId, {
                type = 'info',
                title = 'Match Starting',
                description = ('Starting in %d...'):format(i)
            })
        end
    end

    -- Unfreeze all players
    for _, playerId in ipairs(self.players) do
        FreezeEntityPosition(GetPlayerPed(playerId), false)
        -- Notify match start
        TriggerClientEvent('matchmaking:notify', playerId, {
            type = 'success',
            title = 'Match Started',
            description = 'Good luck!'
        })
    end
end

function object:destroy()
    TriggerEvent('matchmaking:destroyMatch', self.id)
end

-- Handle Player Death
function object:playerDied(playerId)
    self.playerStates[playerId] = false -- Mark player as dead

    FreezeEntityPosition(GetPlayerPed(playerId), true)

    -- Check if all players on a team are dead
    local team1Dead = self:isTeamDead('Team1')
    local team2Dead = self:isTeamDead('Team2')

    if team1Dead or team2Dead then
        local winningTeam = team1Dead and 'Team2' or 'Team1'
        self.teamScores[winningTeam] = self.teamScores[winningTeam] + 1

        -- Notify players of the round result
        for _, playerId in ipairs(self.players) do
            TriggerClientEvent('matchmaking:notify', playerId, {
                type = 'info',
                title = 'Round Over',
                description = ('Team %s wins the round! Current score: %d-%d'):format(winningTeam, self.teamScores.Team1, self.teamScores.Team2)
            })
            -- Update player scores
            TriggerClientEvent('matchmaking:updateScores', playerId, self.teamScores)
        end

        -- Check if WinCondition is met
        if self.teamScores[winningTeam] >= Config.WinCondition then
            self:endMatch(winningTeam)
        else
            for _, targetId in ipairs(self.players) do
                FreezeEntityPosition(GetPlayerPed(targetId), false)
            end
            SetTimeout(Config.ResetDelay, function()
                self:resetPlayers()
            end)
        end
    end
end

-- End Match
function object:endMatch(winningTeam)

    -- Notify players of the match result
    for _, playerId in ipairs(self.players) do
        if winningTeam then
            TriggerClientEvent('matchmaking:notify', playerId, {
                type = 'success',
                title = 'Match Over',
                description = ('Team %s wins the match! Congratulations!'):format(winningTeam)
            })

            -- This is how I pull from leaderboard: SELECT * FROM users ORDER BY matchmaking_wins DESC LIMIT 10
            -- So with that same logic I now need to ADD a win to all winning players

            -- Check if isOnWinning team
            local isOnWinningTeam = false
            for _, player in ipairs(self.teams[winningTeam]) do
                if player == playerId then
                    isOnWinningTeam = true
                    break
                end
            end

            -- If player is on winning team, add a win
            if isOnWinningTeam then
                local xPlayer = ESX.GetPlayerFromId(playerId)
                exports.oxmysql:execute('UPDATE users SET matchmaking_wins = matchmaking_wins + 1 WHERE identifier = ?', { xPlayer.identifier })
            end
        end

        -- Reset routing bucket and revive all players
        SetPlayerRoutingBucket(playerId, Config.RoutingBuckets.Default)
        TriggerEvent('ak47_ambulancejob:revive', playerId)
        TriggerClientEvent('matchmaking:leaveMatch', playerId)
        TriggerClientEvent('matchmaking:notify', playerId, {
            type = 'info',
            title = 'Match Over',
            description = 'Players sent back.'
        })
        TriggerEvent('matchmaking:destroyMatch', self.id)
        TriggerClientEvent('matchmaking:setClient', playerId, false)

        Wait(1500)

        -- Teleport back to default spawn (optional, customize as needed)
        local defaultSpawn = self.rampSet.DefaultSpawn
        SetEntityCoords(GetPlayerPed(playerId), defaultSpawn.x, defaultSpawn.y, defaultSpawn.z, false, false, false, true)
        SetEntityHeading(GetPlayerPed(playerId), defaultSpawn.w)
        FreezeEntityPosition(GetPlayerPed(playerId), false)
    end

    self:destroy()
end

-- Check if a team is dead
function object:isTeamDead(team)
    -- Make sure the team table exists
    if not self.teams or not self.teams[team] then
        return false
    end

    -- Check if *every* player on that team is dead
    for _, playerId in ipairs(self.teams[team]) do
        if self.playerStates[playerId] then
            return false  -- Found a live player on that team
        end
    end
    return true -- All players on that team are dead
end

-- Reset Players (Used for round resets, not full match end)
function object:resetPlayers()
    local rampSet = self.rampSet
    if not rampSet then
        return
    end

    -- Split players into teams
    local teamAssignments = { Team1 = {}, Team2 = {} }
    local teamSize = math.floor(#self.players / 2)

    for i, playerId in ipairs(self.players) do
        if i <= teamSize then
            table.insert(teamAssignments.Team1, playerId)
        else
            table.insert(teamAssignments.Team2, playerId)
        end
    end

    -- Freeze all players
    for _, playerId in ipairs(self.players) do
        FreezeEntityPosition(GetPlayerPed(playerId), true)
    end

    -- Notify countdown for reset
    for i = 3, 1, -1 do
        Wait(1000) -- Wait 1 second
        for _, playerId in ipairs(self.players) do
            TriggerClientEvent('matchmaking:notify', playerId, {
                type = 'info',
                title = 'Resetting Round',
                description = ('Resetting in %d...'):format(i)
            })
        end
    end

    -- Reset players for each team
    for team, players in pairs(teamAssignments) do
        local rampPositions = rampSet[team]
        if rampPositions then
            for i, playerId in ipairs(players) do
                local pos = rampPositions[i] -- Get position for this player
                local ped = GetPlayerPed(playerId)
                if pos and ped then
                    TriggerEvent('ak47_ambulancejob:revive', playerId)
                    Wait(2500) -- Wait to ensure the revive is processed

                    -- Teleport player to their ramp position
                    SetEntityCoords(ped, pos.x, pos.y, pos.z, false, false, false, true)
                    SetEntityHeading(ped, pos.w)

                    -- Mark player as alive
                    self.playerStates[playerId] = true
                else
                    print(('Error: No position or invalid player ID for player %d on team %s'):format(playerId, team))
                end
            end
        else
            print(('Error: No ramp positions configured for team %s in ramp set "%s"'):format(team, self.type))
        end
    end

    -- Unfreeze all players
    for _, playerId in ipairs(self.players) do
        FreezeEntityPosition(GetPlayerPed(playerId), false)
        -- Notify players they are ready
        TriggerClientEvent('matchmaking:notify', playerId, {
            type = 'success',
            title = 'Round Reset',
            description = 'Get ready to play!'
        })
        TriggerClientEvent('matchmaking:setMatchData', playerId, {
            matchId = self.id,
            team = team,
            weapon = self.weapon
        })
    end
end

return object