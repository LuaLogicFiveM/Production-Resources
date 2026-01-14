local Match = require 'modules.Match.client'

local inMatch = false

RegisterNetEvent('matchmaking:setClient', function(bool)
    inMatch = bool
    print('Matchmaking status set to: ' .. tostring(bool))
end)

RegisterCommand('matchmaking', function()
    if not LocalPlayer.state.ramps then return end
    if inMatch then
        lib.registerContext({
            id = 'leave_match_menu',
            title = '🎮 Matchmaking',
            options = {
                {
                    title = '❌ Leave Match',
                    description = 'Exit your current match.',
                    event = 'matchmaking:leaveMatch'
                }
            }
        })
        lib.showContext('leave_match_menu')
    else
        lib.registerContext({
            id = 'matchmaking_menu',
            title = '🎮 Matchmaking',
            options = {
                {
                    title = '🔄 Queue To Match',
                    description = 'Join a random match and test your skills!',
                    event = 'matchmaking:joinRandomLobby'
                },
                {
                    title = '➕ Create Match',
                    description = 'Host a new match and invite players!',
                    event = 'matchmaking:createLobby'
                },
                {
                    title = '👀 View Active Match',
                    description = 'Check details of an ongoing match.',
                    event = 'matchmaking:viewLobbies'
                },
                {
                    title = '🏆 View Leaderboard',
                    description = 'See the top-ranked players!',
                    event = 'matchmaking:viewLeaderboard'
                },
            }
        })
        lib.showContext('matchmaking_menu')
    end
end, false)

-- matchmaking:viewLeaderboard
RegisterNetEvent('matchmaking:viewLeaderboard')
AddEventHandler('matchmaking:viewLeaderboard', function()
    local leaderboard = lib.callback.await('matchmaking:getLeaderboard')
    local options = {}
    for i, player in ipairs(leaderboard) do
        table.insert(options, {
            title = ('#%s %s %s (x%s)'):format(i, player.firstname, player.lastname, player.matchmaking_wins),
            description = 'View player stats',
            event = 'matchmaking:viewPlayerStats',
            args = player.id
        })
    end

    lib.registerContext({
        id = 'leaderboard_menu',
        title = 'Leaderboard',
        options = options
    })
    lib.showContext('leaderboard_menu')
end)

-- Leave Match
RegisterNetEvent('matchmaking:leaveMatch')
AddEventHandler('matchmaking:leaveMatch', function()
    TriggerServerEvent('matchmaking:leaveMatch')
end)


RegisterNetEvent('matchmaking:joinRandomLobby')
AddEventHandler('matchmaking:joinRandomLobby', function()
    local lobbies = lib.callback.await('matchmaking:getLobbies')
    if not lobbies or #lobbies == 0 then
        lib.notify({
            type = 'error',
            title = 'No Matches',
            position = 'top-right',
            description = 'There are currently no open matches to join.'
        })
        return
    end

    -- Filter out lobbies that are full (or not in a "waiting" status if you want)
    local availableLobbies = {}
    for _, lobby in ipairs(lobbies) do
        local requiredPlayers = Config.MatchTypes[lobby.type].requiredPlayers
        -- Only consider lobbies still waiting on enough players
        if #lobby.players < requiredPlayers and lobby.status == 'waiting' then
            table.insert(availableLobbies, lobby)
        end
    end

    -- If no valid lobbies remain, notify the player
    if #availableLobbies == 0 then
        lib.notify({
            type = 'error',
            title = 'No Available Matches',
            position = 'top-right',
            description = 'All matches are full or currently in-game.'
        })
        return
    end

    -- Pick one at random
    local randomLobby = availableLobbies[math.random(1, #availableLobbies)]

    -- Fire your existing server event to join that lobby
    TriggerServerEvent('matchmaking:joinLobby', randomLobby.id)
end)

RegisterNetEvent('matchmaking:createLobby')
AddEventHandler('matchmaking:createLobby', function()
    lib.registerContext({
        id = 'create_lobby_menu',
        title = 'Create Match',
        options = {
            {title = '1v1', description = '1v1 Match', event = 'matchmaking:selectWeapon', args = '1v1'},
            {title = '2v2', description = '2v2 Match', event = 'matchmaking:selectWeapon', args = '2v2'},
        }
    })
    lib.showContext('create_lobby_menu')
end)

RegisterNetEvent('matchmaking:selectWeapon')
AddEventHandler('matchmaking:selectWeapon', function(matchType)
    local options = {}
    for _, weapon in ipairs(Config.Weapons) do
        table.insert(options, {
            title = weapon.label, -- Display the weapon label as the title
            description = 'Select this weapon',
            event = 'matchmaking:finalizeLobby',
            args = { matchType = matchType, weapon = weapon.weapon }
        })
    end

    lib.registerContext({
        id = 'weapon_menu',
        title = 'Select Weapon',
        options = options,
    })
    lib.showContext('weapon_menu')
end)

RegisterNetEvent('matchmaking:finalizeLobby')
AddEventHandler('matchmaking:finalizeLobby', function(data)
    TriggerServerEvent('matchmaking:createLobby', data.matchType, data.weapon)
end)

RegisterNetEvent('matchmaking:viewLobbies')
AddEventHandler('matchmaking:viewLobbies', function()
    local lobbies = lib.callback.await('matchmaking:getLobbies')
    local options = {}
    for _, lobby in pairs(lobbies) do
        local weaponLabel = nil
        for _, weapon in ipairs(Config.Weapons) do
            if weapon.weapon == lobby.weapon then
                weaponLabel = weapon.label -- Find the label for the weapon
                break
            end
        end

        table.insert(options, {
            title = string.format('%s (%s) - Players: %d/%d', lobby.type, weaponLabel or lobby.weapon, #lobby.players, Config.MatchTypes[lobby.type].requiredPlayers),
            description = 'Click to join this match!',
            serverEvent = 'matchmaking:joinLobby',
            args = lobby.id
        })
    end

    lib.registerContext({
        id = 'lobbies_menu',
        title = 'Current Matches',
        options = options
    })
    lib.showContext('lobbies_menu')
end)

RegisterNetEvent('matchmaking:updateLobbies')
AddEventHandler('matchmaking:updateLobbies', function(updatedLobbies)
    local options = {}
    for _, lobby in pairs(updatedLobbies) do
        local weaponLabel = nil
        for _, weapon in ipairs(Config.Weapons) do
            if weapon.weapon == lobby.weapon then
                weaponLabel = weapon.label
                break
            end
        end

        table.insert(options, {
            title = string.format('%s (%s) - Players: %d/%d', lobby.type, weaponLabel or lobby.weapon, #lobby.players, Config.MatchTypes[lobby.type].requiredPlayers),
            description = 'Click to join this lobby',
            serverEvent = 'matchmaking:joinLobby',
            args = lobby.id
        })
    end

    lib.registerContext({
        id = 'lobbies_menu',
        title = 'Current Lobbies',
        options = options
    })
end)

-- matchmaking:notify
RegisterNetEvent('matchmaking:notify')
AddEventHandler('matchmaking:notify', function(data)
    if type(data) ~= 'table' then return end
    if not data then return end
    data.position = 'top-right'
    lib.notify(data)
end)