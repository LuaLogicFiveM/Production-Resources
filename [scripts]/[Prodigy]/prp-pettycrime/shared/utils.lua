--- Format vector3 into string table key
---@param coords vector3
---@return string
function GetLocationKey(coords)
    return ("%.1f|%.1f|%.1f"):format(coords.x, coords.y, coords.z)
end
