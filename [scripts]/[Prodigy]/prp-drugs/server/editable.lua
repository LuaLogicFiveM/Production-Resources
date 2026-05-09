---@alias DrugsAllowlistTypes "turf_meth_lab"

---@param potId number
---@param potName string
---@param pos vector3
---@param heading number
---@param locationId number
---@param lastWatered number
AddEventHandler("prp-drugs:server:potCreated", function(potId, potName, pos, heading, locationId, lastWatered)
end)

---@param potId number
AddEventHandler("prp-drugs:server:removePot", function(potId)
end)

---@param potId number
---@param cropIds number[] list of all the crop ids harvested
AddEventHandler("prp-drugs:server:cropsHarvested", function(potId, cropIds)
end)

---@param source number
---@param itemName string
---@param itemType "joint" | "cocaine" | "meth"
function UsingDrugItem(source, itemName, itemType)
    lib.print.debug("Player:", source, "is using drug item:", itemName, " with type:", itemType)
end

---@param source number
---@param itemName string
---@param itemType "joint" | "cocaine" | "meth"
function UsedDrugItem(source, itemName, itemType)
    lib.print.debug("Player:", source, "has used drug item:", itemName, " with type:", itemType)
end

---@param source number
---@param allowlist DrugsAllowlistTypes
---@return boolean
function HasAllowlist(source, allowlist)
    if not Config.UseBridgeAllowlist then
        return true
    end

    local stateId = bridge.fw.getIdentifier(source)
    if not stateId then
        return false
    end

    return exports["prp-bridge"]:HasAllowlist(stateId, allowlist)
end

---@param source number
---@return number
function GetMethExtraYieldModifier(source)
    local modifier = 0.0

    -- put custom logic here

    return modifier
end

---@param doorName string | number
---@param doorState boolean
function ToggleMethLabDoor(doorName, doorState)
    local door = exports.ox_doorlock:getDoorFromName(doorName)
    if not door then return end
    exports.ox_doorlock:setDoorState(door.id, doorState)
end
