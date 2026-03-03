-- ================== QBOX FRAMEWORK INTEGRATION ==================
if GetResourceState('qbx_core') ~= 'started' then return end

Debug("QBOX Framework was loaded.", 'success')

-- ================== PLAYER FUNCTIONS ==================
function GetPlayer(playerId)
    return exports.qbx_core:GetPlayer(playerId)
end

function GetJob(playerId)
    local player = GetPlayer(playerId)
    return player and player.PlayerData.job.name or nil
end

function GetMoney(playerId)
    local player = GetPlayer(playerId)
    return player and player.Functions.GetMoney('cash') or 0
end

function RemoveMoney(playerId, amount)
    return exports.qbx_core:RemoveMoney(playerId, 'bank', amount)
end

function GetIdentifier(playerId)
    local player = GetPlayer(playerId)
    return player and player.PlayerData.citizenid or nil
end