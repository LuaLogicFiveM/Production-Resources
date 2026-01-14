-- ================== QBCORE FRAMEWORK INTEGRATION ==================
if GetResourceState('qb-core') ~= 'started' then return end

Debug("QBCore Framework was loaded.", 'success')

local QBCore = exports['qb-core']:GetCoreObject()

-- ================== PLAYER FUNCTIONS ==================
function GetPlayer(playerId)
    return QBCore.Functions.GetPlayer(playerId)
end

function GetJob(playerId)
    local player = GetPlayer(playerId)
    return player and player.PlayerData.job.name or nil
end

function GetMoney(playerId)
    local player = GetPlayer(playerId)
    return player and player.PlayerData.money.bank or 0
end

function RemoveMoney(playerId, amount)
    local player = GetPlayer(playerId)
    if not player then return false end
    
    return player.Functions.RemoveMoney('bank', amount)
end

function GetIdentifier(playerId)
    local player = GetPlayer(playerId)
    return player and player.PlayerData.citizenid or nil
end