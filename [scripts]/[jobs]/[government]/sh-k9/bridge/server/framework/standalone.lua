-- ================== STANDALONE INTEGRATION ==================
if 
    GetResourceState('es_extended') == 'started' or 
    GetResourceState('qb-core') == 'started' or
    GetResourceState('qbx_core') == 'started' or
    GetResourceState('ND_Core') == 'started' 
then 
    return 
end

Debug("Framework wasn't detected.", 'inform')

-- ================== PLAYER FUNCTIONS ==================
function GetPlayer(playerId)
    return true
end

function GetJob(playerId)
    return 'police'
end

function GetMoney(playerId)
    return 0
end

function RemoveMoney(playerId, amount)
    return true
end

function GetIdentifier(playerId)
    return GetPlayerIdentifierByType(playerId, 'license')
end