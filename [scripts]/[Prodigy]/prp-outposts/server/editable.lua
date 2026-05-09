---@param doorName string | number
---@param doorState boolean
function ToggleOutpostDoor(doorName, doorState)
    local door = exports.ox_doorlock:getDoorFromName(doorName)
    if not door then return end
    exports.ox_doorlock:setDoorState(door.id, doorState)
end
