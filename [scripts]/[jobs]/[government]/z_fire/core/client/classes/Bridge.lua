---@script core/client/classes/Bridge.lua

---@class Bridge
Bridge = Bridge or {}

local frameworkCache = {
    isESX = false,
    isQBCore = false,
    isQBX = false,
    isTMC = false,
    Core = nil
}
local function detectFramework()
    local isESX = cfg.permissions['particle_creation']['ESX'].enabled or
        cfg.permissions['particle_deletion']['ESX'].enabled or
        cfg.permissions['book_duty']['ESX'].enabled
    local isQBCore = cfg.permissions['particle_creation']['QBCore'].enabled or
        cfg.permissions['particle_deletion']['QBCore'].enabled or cfg.permissions['book_duty']['QBCore'].enabled
    local IsQBX = cfg.permissions['particle_creation']['QBX'].enabled or
        cfg.permissions['particle_deletion']['QBX'].enabled or
        cfg.permissions['book_duty']['QBX'].enabled
    local isTMC = cfg.permissions['particle_creation']['TMC'].enabled or
        cfg.permissions['particle_deletion']['TMC'].enabled or
        cfg.permissions['book_duty']['TMC'].enabled

    if isESX and GetResourceState('es_extended') == 'started' then
        frameworkCache.isESX = true
        frameworkCache.Core = exports['es_extended']:getSharedObject()
        Bridge.IsESX = true
        Bridge.Core = frameworkCache.Core
    elseif isQBCore and GetResourceState('qb-core') == 'started' then
        frameworkCache.isQBCore = true
        frameworkCache.Core = exports['qb-core']:GetCoreObject()
        Bridge.IsQBCore = true
        Bridge.Core = frameworkCache.Core
    elseif IsQBX and GetResourceState('qbx_core') == 'started' then
        frameworkCache.IsQBX = true
        Bridge.IsQBX = true
    elseif isTMC and GetResourceState('core') == 'started' then
        frameworkCache.isTMC = true
        frameworkCache.Core = exports['core']:getCoreObject()
        Bridge.IsTMC = true
        Bridge.Core = frameworkCache.Core
    end
end

detectFramework()

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param set_type string
---@param set_data table
Bridge.notification = function(set_type, set_data)
    if Bridge.IsESX then
        Bridge.Core.ShowNotification(set_data.set_description, 'info')
        return
    end
    if Bridge.IsQBCore then
        Bridge.Core.Functions.Notify(set_data.set_description, 'info')
        return
    end
    if Bridge.IsQBX then
        exports['qbx_core']:Notify(set_data.set_description, 'inform')
        return
    end
    if Bridge.IsTMC then
        Bridge.Core.Functions.SimpleNotify(set_data.set_description, 'success')
        return
    end

    Interface.createNotification(set_data.set_timeout or 1000, {
        set_title = set_data.set_title,
        set_description = set_data.set_description,
        set_type = set_type or 'info',
    })
end

---@param _ any
---@param action string
---@return boolean
Bridge.hasPermissionAsync = function(_, action, callback)
    local permissions = cfg.permissions[action]
    if permissions == nil then return false end

    local QBCore = permissions.QBCore
    local ESX = permissions.ESX
    local QBX = permissions.QBX
    local Ace = permissions.Ace
    local TMC = permissions.TMC

    local hasPermission = false
    local shouldCheck = false
    local checksCompleted = 0
    local totalChecks = 0

    local function completeCheck(result)
        checksCompleted = checksCompleted + 1
        if result then
            hasPermission = true
        end

        if checksCompleted >= totalChecks or hasPermission then
            if callback then
                callback(hasPermission)
            end
        end
    end

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
            if Bridge.Core.Functions.IsOnDuty(job) then
                return true
            end
        end

        return false
    end

    if Ace and Ace.enabled then
        totalChecks = totalChecks + 1
    end
    if QBCore and QBCore.enabled and Bridge.IsQBCore and QBCore.usePermissions.permissionCheck then
        totalChecks = totalChecks + 1
    end
    if QBX and QBX.enabled and Bridge.IsQBX and QBX.usePermissions.jobCheck then
        totalChecks = totalChecks + 1
    end
    if totalChecks == 0 then
        shouldCheck = false
        if ESX and ESX.enabled and Bridge.IsESX then
            local player_data = Bridge.Core.GetPlayerData()

            if player_data and player_data.job and ESX.usePermissions.jobCheck then
                shouldCheck = true
                if checkJobs(player_data.job.name, ESX.usePermissions.jobs) then
                    hasPermission = true
                end
            end

            if player_data and ESX.usePermissions.permissionCheck then
                shouldCheck = true
                for _, group in ipairs(ESX.usePermissions.groups) do
                    if player_data.group == group then
                        hasPermission = true
                    end
                end
            end
        end
        if QBCore and QBCore.enabled and Bridge.IsQBCore then
            local player_data = Bridge.Core.Functions.GetPlayerData()

            if player_data and player_data.job and QBCore.usePermissions.jobCheck then
                shouldCheck = true
                if checkJobs(player_data.job.name, QBCore.usePermissions.jobs) then
                    hasPermission = true
                end
            end
        end
        if TMC and TMC.enabled and Bridge.IsTMC then
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

        if callback then callback(hasPermission) end
        return hasPermission
    end
    if Ace and Ace.enabled then
        cl_Callback.request('z_fire:hasUserGotPermission', {
            framework = 'ace-perms',
            permission = Ace.usePermission
        }, function(response)
            completeCheck(response and response.IsAllowed)
        end)
    end

    if QBCore and QBCore.enabled and Bridge.IsQBCore and QBCore.usePermissions.permissionCheck then
        cl_Callback.request('z_fire:hasUserGotPermission', {
            framework = 'qb-core',
            permission = QBCore.usePermissions.permissions
        }, function(response)
            completeCheck(response and response.IsAllowed)
        end)
    end

    if QBX and QBX.enabled and Bridge.IsQBX and QBX.usePermissions.jobCheck then
        cl_Callback.request('z_fire:hasUserGotPermission', {
            framework = 'qbx_core',
            permission = QBX.usePermissions.jobs
        }, function(response)
            completeCheck(response and response.IsAllowed)
        end)
    end

    if ESX and ESX.enabled and Bridge.IsESX then
        local player_data = Bridge.Core.GetPlayerData()

        if player_data and player_data.job and ESX.usePermissions.jobCheck then
            if checkJobs(player_data.job.name, ESX.usePermissions.jobs) then
                hasPermission = true
                if callback then callback(hasPermission) end
                return hasPermission
            end
        end

        if player_data and ESX.usePermissions.permissionCheck then
            for _, group in ipairs(ESX.usePermissions.groups) do
                if player_data.group == group then
                    hasPermission = true
                    if callback then callback(hasPermission) end
                    return hasPermission
                end
            end
        end
    end

    if QBCore and QBCore.enabled and Bridge.IsQBCore then
        local player_data = Bridge.Core.Functions.GetPlayerData()

        if player_data and player_data.job and QBCore.usePermissions.jobCheck then
            if checkJobs(player_data.job.name, QBCore.usePermissions.jobs) then
                hasPermission = true
                if callback then callback(hasPermission) end
                return hasPermission
            end
        end
    end

    if TMC and TMC.enabled and Bridge.IsTMC then
        if TMC.usePermissions.jobCheck then
            if checkJobsTMC(TMC.usePermissions.jobs) then
                hasPermission = true
                if callback then callback(hasPermission) end
                return hasPermission
            end
        end
    end

    return hasPermission
end

Bridge.hasPermission = function(_, action)
    local result = false
    local completed = false

    Bridge.hasPermissionAsync(_, action, function(hasPerms)
        result = hasPerms
        completed = true
    end)

    local timeout = 0
    while not completed and timeout < 100 do
        Wait(50)
        timeout = timeout + 1
    end

    return result
end

Bridge.refreshFrameworkData = function()
    detectFramework()
end

---@param extinguished_fire_data table
Bridge.processExtinguishPayout = function(extinguished_fire_data)
    return false -- PLACEHOLDER TODO NOTHING.

    --[[
    local playerDepartment = nil
    local playerId = GetPlayerServerId(PlayerId())

    if Init.departments then
        for shortCode, deptData in pairs(Init.departments) do
            if Init.dutyTable and Init.dutyTable[shortCode] and
                Init.dutyTable[shortCode].members and
                Init.dutyTable[shortCode].members[playerId] then
                playerDepartment = shortCode
                break
            end
        end
    end

    if not playerDepartment then return end

    --[[
        Implement your own payout logic here, using the playerDepartment if appropriate.
        extinguished_fire_data contains a table of extinguishedFires containing the data:

        id = fire.id,
        behaviourType = fireData.behaviourType,
        scale = ptfxData.scale,
        type = ptfxData.type,
        weapon = playerWeapon,
        position = worldPos,
        origin = fireData.origin
    ]] --
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
