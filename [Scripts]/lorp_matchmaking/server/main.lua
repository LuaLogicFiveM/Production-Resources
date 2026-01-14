local Match = require 'modules.Match.server'

local matches = {}
local lobbies = {}

-- Create Lobby
RegisterNetEvent('matchmaking:createLobby')
AddEventHandler('matchmaking:createLobby', function(matchType, weapon)
    local src = source
    local lobbyId = #lobbies + 1

    table.insert(lobbies, {
        id = lobbyId,
        host = src,
        type = matchType,
        weapon = weapon,
        players = {src},
        status = 'waiting',
    })

    TriggerClientEvent('matchmaking:notify', src, {
        type = 'success',
        title = 'Lobby Created',
        description = 'Waiting for players...'
    })
end)

-- Join Lobby
RegisterNetEvent('matchmaking:joinLobby')
AddEventHandler('matchmaking:joinLobby', function(lobbyId)
    local src = source

    -- Check if the player's routing bucket is 0
    --[[if GetPlayerRoutingBucket(src) ~= 0 then
        TriggerClientEvent('matchmaking:notify', src, {
            type = 'error',
            title = 'Cannot Join',
            description = 'You are currently in a lobby (leave first).'
        })
        return
    end]]

    for _, lobby in pairs(lobbies) do
        if lobby.id == lobbyId then
            -- Check if player is already in lobby
            for _, player in ipairs(lobby.players) do
                if player == src then
                    TriggerClientEvent('matchmaking:notify', src, {
                        type = 'error',
                        title = 'Already In',
                        description = 'You are already in this lobby.'
                    })
                    return
                end
            end

            -- Check if lobby is full
            if #lobby.players >= Config.MatchTypes[lobby.type].requiredPlayers then
                TriggerClientEvent('matchmaking:notify', src, {
                    type = 'error',
                    title = 'Lobby Full',
                    description = 'This lobby is full.'
                })
                return
            end

            -- Remove player from any other lobbies they are in
            for _, otherLobby in pairs(lobbies) do
                for i, player in ipairs(otherLobby.players) do
                    if player == src then
                        table.remove(otherLobby.players, i)
                        if #otherLobby.players == 0 then
                            table.remove(lobbies, otherLobby.id)
                        end
                        break
                    end
                end
            end

            -- Add player to the new lobby
            table.insert(lobby.players, src)

            -- Check if the required players are met
            if #lobby.players >= Config.MatchTypes[lobby.type].requiredPlayers then
                -- Create a new match instance
                local match = Match:new(tonumber(lobby.id), lobby.players, lobby.type, lobby.weapon)
                if not match or type(match) ~= "table" then
                    return
                end
                matches[match.id] = match
                if not match.setup then
                    return
                end
                match:setup()
            end
            return
        end
    end

    TriggerClientEvent('matchmaking:notify', src, {
        type = 'error',
        title = 'Not Found',
        description = 'Lobby not found.'
    })
end)

RegisterNetEvent('matchmaking:destroyMatch', function(matchId)
    -- 1) Remove the match from the matches table
    if matches[matchId] then
        matches[matchId] = nil
    end

    -- 2) Also remove the lobby with the same ID
    for i, lobby in ipairs(lobbies) do
        if lobby.id == matchId then
            table.remove(lobbies, i)
            break
        end
    end
end)

-- Fetch lobbies
lib.callback.register('matchmaking:getLobbies', function()
    return lobbies
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local playerId = source
    for _, match in pairs(matches) do
        if match.playerStates[playerId] then
            match:playerDied(playerId)
        end
    end
end)

lib.callback.register('matchmaking:getLeaderboard', function(src)
    local result = exports.oxmysql:fetchSync('SELECT * FROM users ORDER BY matchmaking_wins DESC LIMIT 10')
    return result
end)

CreateThread(function()
    while true do
        Wait(60 * 1000) -- Check once per minute (adjust as needed)
        for matchId, match in pairs(matches) do
            local activeCount = 0
            for _, playerId in ipairs(match.players) do
                -- If player ping is 0, likely disconnected
                if GetPlayerPing(playerId) > 0 then
                    activeCount = activeCount + 1
                end
            end

            -- If no active players, destroy match
            if activeCount == 0 then
                print(('[Matchmaking] Destroying match %d because it has no players left.'):format(matchId))
                match:destroy()
            end
        end
    end
end)

-- matchmaking:leaveMatch
RegisterNetEvent('matchmaking:leaveMatch')
AddEventHandler('matchmaking:leaveMatch', function()
    local src = source
    for matchId, match in pairs(matches) do
        for i, playerId in ipairs(match.players) do
            if playerId == src then
                match:endMatch(false)
                Wait(1000) -- Wait 1 second
                match:destroy()
            end
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source

    -- Check if this player was in a match
    for matchId, match in pairs(matches) do
        for _, pId in ipairs(match.players) do
            if pId == src then
                match:endMatch(false)
                Wait(1000) -- Wait 1 second
                match:destroy()
                return
            end
        end
    end
end)