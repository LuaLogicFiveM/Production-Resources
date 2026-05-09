---@param src number
---@return number players current route bucket on the server
function GetCurrentPlayerRoute(src)
    return GetPlayerRoutingBucket(src --[[ @as string ]]) or 0
end
