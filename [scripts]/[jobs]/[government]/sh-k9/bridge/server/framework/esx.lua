-- ================== ESX FRAMEWORK INTEGRATION ==================
if GetResourceState('es_extended') ~= 'started' then return end

Debug("ESX Legacy Framework was loaded.", 'success')

local ESX = exports['es_extended']:getSharedObject()

-- ================== PLAYER FUNCTIONS ==================
function GetPlayer(playerId)
    return ESX.GetPlayerFromId(playerId)
end

function GetJob(playerId)
    local player = GetPlayer(playerId)
    return player and player.job.name or nil
end

function GetMoney(playerId)
    local player = GetPlayer(playerId)
    return player and player.getMoney() or 0
end

function RemoveMoney(playerId, amount)
    local player = GetPlayer(playerId)
    if not player then return false end

    player.removeMoney(amount, "K9 Purchase")
    return true
end

function GetIdentifier(playerId)
    local player = GetPlayer(playerId)
    if not player then return nil end

    -- Use multichar identifier if enabled, otherwise fallback to legacy method
    if ESX.GetConfig().Multichar then
        return player.identifier
    else
        return ESX.GetIdentifier(playerId)
    end
end