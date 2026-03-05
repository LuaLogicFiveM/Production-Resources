--- @script core/client/classes/exports.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@class section: functions

---@param networkId int: Object entity network Id, Can be found using the ObjToNet native
---@return boolean | nil
---@usage local fanStatus = exports['z_ppvfan']:getFanStatus(networkId)
local function get_fan_status(networkId)
    if networkId == 0 then 
        return nil
    end

    objectPool = init.objectPool[networkId]

    if not objectPool then 
        return nil
    end

    return objectPool.status
end

exports("getFanStatus", get_fan_status)

---@param networkId int: Object entity network Id, Can be found using the ObjToNet native
---@return boolean | nil
---@usage local newFanStatus = exports['z_ppvfan']:setFanStatus(networkId)
local function set_fan_status(networkId, newStatus)
    if networkId == 0 then 
        return nil
    end

    objectPool = init.objectPool[networkId]

    if not objectPool then 
        return nil
    end

    objectPool.status = newStatus

    return objectPool.status
end

exports("setFanStatus", set_fan_status)

---@param fanPos vector3: Position for fan placement
---@param sourcePed int: Player Ped who is placing the fan
---@return boolean | nil
---@usage local success = exports['z_ppvfan']:createFan(fanPos, sourcePed)
local function create_fan(fanPos, sourcePed)
    if not sourcePed or sourcePed == -1 then 
        return nil
    end

    init.functions.create(fanPos, sourcePed)

    return true
end

exports("createFan", create_fan)

---@param objHandle int: Fan object handle to delete
---@return boolean | nil
---@usage local success = exports['z_ppvfan']:deleteFan(objHandle)
local function delete_fan(objHandle)
    if not objHandle or objHandle == 0 then 
        return nil
    end

    init.functions.delete(objHandle)

    return true
end

exports("deleteFan", delete_fan)