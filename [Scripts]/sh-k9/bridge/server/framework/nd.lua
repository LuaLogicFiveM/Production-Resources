-- ================== ND_CORE FRAMEWORK INTEGRATION ==================
if GetResourceState('ND_Core') ~= 'started' then return end

Debug("ND_Core Framework was loaded.", 'success')

-- ================== PLAYER FUNCTIONS ==================
function GetPlayer(playerId)
    return exports.ND_Core:getPlayer(playerId)
end

function GetJob(playerId)
    local player = GetPlayer(playerId)
    return player and player.job or nil
end

function GetMoney(playerId)
    local player = GetPlayer(playerId)
    return player and player.cash or 0
end

function RemoveMoney(playerId, amount)
    local player = GetPlayer(playerId)
    if not player then return false end

    -- Deduct money from player's account
    return player.deductMoney('bank', amount, "K9 Purchase")
end

function GetIdentifier(playerId)
    local player = GetPlayer(playerId)
    return player and player.identifier or nil
end