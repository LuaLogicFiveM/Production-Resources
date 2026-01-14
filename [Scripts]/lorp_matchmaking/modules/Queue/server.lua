---@class Queue
---@field players table<number, Player>
local Queue = lib.class('Queue')

function Queue:constructor()
    self.players = {} -- List of players in the queue
end

function Queue:addPlayer(player)
    table.insert(self.players, player)
end

function Queue:removePlayer(player)
    for i, p in ipairs(self.players) do
        if p.id == player.id then
            table.remove(self.players, i)
            break
        end
    end
end

function Queue:findMatch()
    -- For simplicity, match players in pairs
    if #self.players >= 2 then
        local players = {table.remove(self.players, 1), table.remove(self.players, 1)}
        for _, player in ipairs(players) do
            player:setStatus('matched')
        end
        return Match:new(players)
    end

    return nil -- Not enough players
end
