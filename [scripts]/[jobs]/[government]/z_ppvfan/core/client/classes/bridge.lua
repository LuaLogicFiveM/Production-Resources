-- @script core/client/classes/bridge.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@class section: constants

--- @field bridge: Stores framework functions and data.
bridge = bridge or {}
bridge.permissions = cfg.usePermissions

if bridge.permissions['ESX'].enabled and GetResourceState('es_extended') == 'started' then
    bridge.IsESX = true
    bridge.Core = exports['es_extended']:getSharedObject()
elseif bridge.permissions['QBCore'].enabled and GetResourceState('qb-core') == 'started' then
    bridge.IsQBCore = true
    bridge.Core = exports['qb-core']:GetCoreObject()
elseif bridge.permissions['TMC'].enabled and GetResourceState('core') == 'started' then
    bridge.IsTMC = true
    bridge.Core = exports['core']:getCoreObject()
elseif bridge.permissions['QBX'].enabled and GetResourceState('qbx_core') == 'started' then
    bridge.IsQBX = true
elseif bridge.permissions['Ace'].enabled then
    bridge.IsAce = true
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@class section: functions

---@param setType string
---@param setData table
---@usage bridge.notification('success', {setTimeout = 1000, setTitle = 'Title', setDescription = 'Description'})
local function notification(setType, setData)
    if bridge.IsESX then
        bridge.Core.ShowNotification(setData.setDescription, setType or 'info')
    elseif bridge.IsQBCore then
        bridge.Core.Functions.Notify(setData.setDescription, setType or 'info')
    elseif bridge.IsQBX then
        exports['qbx_core']:Notify(setData.setDescription, 'inform')
    elseif bridge.IsTMC then
        bridge.Core.Functions.SimpleNotify(setData.setDescription, 'success')
    else
        nui.createNotification(setData.setTimeout or 1000, {
            setTitle = setData.setTitle,
            setDescription = setData.setDescription,
            setType = setType or 'info'
        })
    end
end

bridge.notification = notification

---@return table | nil
---@usage local playerData = bridge.getPlayerData()
local function getPlayerData()
    if not bridge.Core then
        return nil
    end

    if bridge.IsESX then
        return bridge.Core.getPlayerData()
    elseif bridge.isTMC then
        return bridge.Core.Functions.GetPlayerData()
    elseif bridge.IsQBCore then
        return bridge.Core.Functions.GetPlayerData()
    end
end

bridge.getPlayerData = getPlayerData

---@param sourceId int
---@return boolean
---@usage local isAllowed = bridge.hasPermission(int)
local function hasPermission(sourceId)
    local QBCore = cfg.usePermissions.QBCore
    local ESX = cfg.usePermissions.ESX
    local QBX = cfg.usePermissions.QBX
    local Ace = cfg.usePermissions.Ace
    local TMC = cfg.usePermissions.TMC

    local hasPermission = false
    local shouldCheck = false

    local function checkJobs(playerJob, jobs)
        for _, job in ipairs(jobs) do
            if playerJob == job then
                return true
            end
        end
        return false
    end

    local function checkJobsTMC(jobs)
        for _, job in ipairs(jobs) do
            if bridge.Core.Functions.IsOnDuty(job) then
                return true
            end
        end

        return false
    end

    if Ace and Ace.enabled then
        shouldCheck = true

        callbacks.cb('z_ppvfan:checkPermissions', {
            framework = 'ace-perms',
            permission = Ace.usePermission
        }, function(response) 
            if response.IsAllowed then 
                hasPermission = true
            end
        end)
    end

    if ESX and ESX.enabled and bridge.IsESX then
        if ESX.usePermissions.jobCheck then
            shouldCheck = true
            if checkJobs(bridge.Core.GetPlayerData().job.name, ESX.usePermissions.jobs) then
                hasPermission = true
            end
        end

        if ESX.usePermissions.permissionCheck then
            shouldCheck = true
            for _, group in ipairs(ESX.usePermissions.groups) do
                if playerData.group == group then
                    hasPermission = true
                end
            end
        end
    end

    if QBCore and QBCore.enabled and bridge.IsQBCore then
        if QBCore.usePermissions.jobCheck then
            shouldCheck = true
            if checkJobs(bridge.Core.Functions.GetPlayerData().job.name, QBCore.usePermissions.jobs) then
                hasPermission = true
            end
        end

        if QBCore.usePermissions.permissionCheck then
            shouldCheck = true

            callbacks.cb('z_ppvfan:checkPermissions', {
                framework = 'qb-core',
                permission = QBCore.usePermissions.permissions
            }, function(response) 
                if response.IsAllowed then 
                    hasPermission = true
                end
            end)
        end
    end

    if QBX and QBX.enabled and bridge.IsQBX then
        if QBX.usePermissions.jobCheck then
            shouldCheck = true

            callbacks.cb('z_ppvfan:checkPermissions', {
                framework = 'qbx_core',
                permission = QBX.usePermissions.jobs
            }, function(response) 
                if response.IsAllowed then 
                    hasPermission = true
                end
            end)
        end
    end

    if TMC and TMC.enabled and bridge.IsTMC then
        if TMC.usePermissions.jobCheck then
            shouldCheck = true

            if checkJobsTMC(TMC.usePermissions.jobs) then
                hasPermission = true
            end
        end
    end
    
    if not shouldCheck then
        hasPermission = true
    end

    return hasPermission
end

bridge.hasPermission = hasPermission

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
