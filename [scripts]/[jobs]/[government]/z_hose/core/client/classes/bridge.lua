---@script core/client/classes/bridge.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Variable Declarations

---@class bridge
bridge = bridge or {}

if cfg.framework == 'ESX' and GetResourceState('es_extended') == 'started' then
    bridge.IsESX = true
    bridge.Core = exports['es_extended']:getSharedObject()
elseif cfg.framework == 'QBCore' and GetResourceState('qb-core') == 'started' then
    bridge.IsQBCore = true
    bridge.Core = exports['qb-core']:GetCoreObject()
elseif cfg.framework == 'TMC' and GetResourceState('core') == 'started' then
    bridge.IsTMC = true
    bridge.Core = exports['core']:getCoreObject()
elseif cfg.framework == 'QBX' and GetResourceState('qbx_core') == 'started' then
    bridge.IsQBX = true
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Bridge Functions

---@param setType string
---@param setData table
local function build_notification(setType, setData)
    if bridge.IsESX then
        bridge.Core.ShowNotification(setData.setDescription, 'info')
        return
    end
    if bridge.IsQBCore then
        bridge.Core.Functions.Notify(setData.setDescription, 'info')
        return
    end
    if bridge.IsQBX then
        exports['qbx_core']:Notify(setData.setDescription, 'inform')
        return
    end
    if bridge.IsTMC then
        bridge.Core.Functions.SimpleNotify(setData.setDescription, 'success')
        return
    end

    interface.createNotification(setData.setTimeout or 1000, {
        setTitle = setData.setTitle,
        setDescription = setData.setDescription,
        setType = setType or 'info',
    })
end

bridge.notification = build_notification

---@param action string
---@return boolean
local function has_permission(action)
    local permissions = cfg.permissions[action]
    if not permissions then return false end

    local QBCore = permissions.QBCore
    local ESX = permissions.ESX
    local QBX = permissions.QBX
    local TMC = permissions.TMC
    local Ace = permissions.Ace

    local hasPermission = false
    local shouldCheck = false

    local function checkJobs(framework, playerJob, jobs)
        for _, job in ipairs(jobs) do
            if (framework ~= 'TMC' and playerJob == job) or (framework == 'TMC' and bridge.Core.Functions.IsOnDuty(job)) then return true end
        end
        return false
    end

    if Ace and Ace.enabled then
        shouldCheck = true

        callbacks.request('z_hose:hasUserGotPermission', {
            framework = 'ace-perms',
            permission = Ace.usePermission
        }, function(response)
            if response and response.IsAllowed then
                hasPermission = true
            end
        end)
    end

    if ESX and ESX.enabled and bridge.IsESX then
        local player_data = bridge.Core.GetPlayerData()

        if player_data and player_data.job and ESX.usePermissions.jobCheck then
            shouldCheck = true
            if checkJobs('ESX', player_data.job.name, ESX.usePermissions.jobs) then
                hasPermission = true
            end
        end

        if ESX.usePermissions.permissionCheck then
            shouldCheck = true
            for _, group in ipairs(ESX.usePermissions.groups) do
                if player_data.group == group then
                    hasPermission = true
                end
            end
        end
    end

    if QBCore and QBCore.enabled and bridge.IsQBCore then
        local player_data = bridge.Core.Functions.GetPlayerData()

        if player_data and player_data.job and QBCore.usePermissions.jobCheck then
            shouldCheck = true
            if checkJobs('QB', player_data.job.name, QBCore.usePermissions.jobs) then
                hasPermission = true
            end
        end

        if QBCore.usePermissions.permissionCheck then
            shouldCheck = true

            callbacks.request('z_hose:hasUserGotPermission', {
                framework = 'qb-core',
                permission = QBCore.usePermissions.permissions
            }, function(response)
                if response and response.IsAllowed then
                    hasPermission = true
                end
            end)
        end
    end

    if QBX and QBX.enabled and bridge.IsQBX then
        if QBX.usePermissions.jobCheck then
            shouldCheck = true

            callbacks.request('z_hose:hasUserGotPermission', {
                framework = 'qbx_core',
                permission = QBX.usePermissions.jobs
            }, function(response)
                if response and response.IsAllowed then
                    hasPermission = true
                end
            end)
        end
    end

    if TMC and TMC.enabled and bridge.IsTMC then
        if TMC.usePermissions.jobCheck then
            shouldCheck = true

            if checkJobs('TMC', nil, TMC.usePermissions.jobs) then hasPermission = true end
        end
    end

    if not shouldCheck then
        hasPermission = true
    end

    return hasPermission
end

bridge.hasPermission = has_permission

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Target Integration

local interactions = {
    pumpPanel = {
        label = Init.cache['locale'].interactions.view_pump,
        select = function()
            Init.exports.openPumpPanel()
        end
    },
    relayOn = {
        label = Init.cache['locale'].interactions.connect_relay,
        select = function()
            Init.exports.createRelay()
        end,
        canUse = function(vehicleHandle)
            return not Init.exports.hasSupply(vehicleHandle)
        end
    },
    relayOff = {
        label = Init.cache['locale'].interactions.disconnect_relay,
        select = function()
            Init.exports.removeRelay()
        end,
        canUse = function(vehicleHandle)
            return Init.exports.hasSupply(vehicleHandle)
        end
    },
    supplyOn = {
        label = Init.cache['locale'].interactions.connect_supply,
        select = function()
            Init.exports.createSupply()
        end,
        canUse = function(vehicleHandle)
            return not Init.exports.hasSupply(vehicleHandle)
        end
    },
    supplyOff = {
        label = Init.cache['locale'].interactions.disconnect_supply,
        select = function()
            Init.exports.removeSupply()
        end,
        canUse = function(vehicleHandle)
            return Init.exports.hasSupply(vehicleHandle)
        end
    },
    hoseOff = {
        label = Init.cache['locale'].interactions.return_reel,
        select = function()
            Init.exports.returnHose()
        end,
        canUse = function()
            return (cl_globals.currentHose ~= 0)
        end
    },
    waterHoseOn = {
        label = Init.cache['locale'].interactions.use_hosebranch,
        select = function()
            Init.exports.createHose('water')
        end,
        canUse = function()
            return (cl_globals.currentHose == 0)
        end
    },
    foamHoseOn = {
        label = Init.cache['locale'].interactions.use_foambranch,
        select = function()
            Init.exports.createHose('foam')
        end,
        canUse = function()
            return (cl_globals.currentHose == 0)
        end
    }
}

---@param targets table
local function build_target(targets)
    for vehicleName, vehicleData in pairs(targets) do
        local targetOptions = {}
        local vehicleModel = joaat(vehicleName)

        for _, data in pairs(vehicleData) do
            for interaction, offset in pairs(data) do
                local targetOption = {
                    onSelect = interactions[interaction].select,
                    offset = offset,
                    icon = 'fas fa-hand',
                    label = interactions[interaction].label,
                    distance = 1.2,
                    offsetSize = 1.0,
                    canInteract = interactions[interaction].canUse
                }
                table.insert(targetOptions, targetOption)
            end
        end

        exports['ox_target']:addModel(vehicleModel, targetOptions)
    end
end

bridge.buildTargets = build_target
