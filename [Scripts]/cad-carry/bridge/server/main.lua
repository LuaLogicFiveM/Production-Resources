--- Put in seat checks (if true then person will be put in seat succesfully)
---@param targetId number Player source id
---@param vehNetId number Vehicle network id
---@param seatNumber number Vehicle seat number to be put into
---@return boolean
function CanPutInSeat(targetId, vehNetId, seatNumber)
    if (not Config.AllowPutInDriverSeat) and seatNumber == -1 then return false end
    --- add your checks if target player can seat when they are carried by someone
    return true
end

--- Can person be carried (carried person checks) (if true then person can be carried)
---@param targetId number Player source id
---@return boolean
function CanBeCarried(targetId)
    return true
end

--- Put in trunk checks (if true then person will be put in trunk succesfully)
---@param targetId number Player source id
---@param vehNetId number Vehicle network id
---@return boolean
function CanPutInTrunk(targetId, vehNetId)
    return true
end

--- Get player name from server id
---@param serverId number Player source id
---@return string
function GetPlayerNameFromServerId(serverId)
    if Config.AcceptanceGenericName then
        return 'Player '..serverId
    else
        return GetPlayerName(serverId)
    end
end