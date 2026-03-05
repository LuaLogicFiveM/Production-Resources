---@script core/server/classes/bridge.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Variable Declarations

---@class bridge
bridge = bridge or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Bridge Functions

---@param sourceId integer
---@param data table
---@return boolean
local function check_permissions(sourceId, data)
    local IsAllowed = false
    if not data then return IsAllowed end

    if data.framework == 'qb-core' then
        local QBCore = exports['qb-core']:GetCoreObject()
        if QBCore and QBCore.Functions.GetPlayer(sourceId) then
            return QBCore.Functions.HasPermission(sourceId, data.permission)
        end
    end

    if data.framework == 'ace-perms' then
        return IsPlayerAceAllowed(source, data.permission)
    end

    if data.framework == 'qbx_core' then
        local user = exports['qbx_core']:GetPlayer(sourceId)
        if user == nil then return false end

        for _, job in pairs(data.permission) do
            if user.PlayerData.job.name == job then
                IsAllowed = true
                break
            end
        end
    end

    return IsAllowed
end

bridge.check = check_permissions

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
