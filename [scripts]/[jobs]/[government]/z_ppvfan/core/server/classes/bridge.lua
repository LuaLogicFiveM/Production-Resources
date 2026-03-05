-- @script core/server/classes/bridge.lua

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
end

if bridge.IsESX then 
    if bridge.permissions['QBCore'].item.use then 
        CreateThread(function()
            bridge.Core.Functions.CreateUseableItem(bridge.permissions['QBCore'].item.name, function(src, item)
                bridge.useItem(src)
            end)
        end)
    end
end

if bridge.IsQBCore then 
    if bridge.permissions['ESX'].item.use then 
        CreateThread(function()
            bridge.Core.RegisterUsableItem(bridge.permissions['ESX'].item.name, function(src)
                bridge.useItem(src)
            end)
        end)
    end
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------

local function use_item(sourceId)
    if bridge.IsQBCore and bridge.permissions['QBCore'].item.use then 
        local Player = bridge.Core.Functions.GetPlayer(sourceId)

        if Player.Functions.GetItemByName(bridge.permissions['QBCore'].item.name) then
            Player.Functions.RemoveItem(bridge.permissions['QBCore'].item.name, 1)
            TriggerClientEvent('z_ppvfan:return:use', sourceId)
        else
            TriggerClientEvent('z_ppvfan:return:use', sourceId)
        end
    elseif bridge.IsESX and bridge.permissions['ESX'].item.use then 
        local Player = bridge.Core.GetPlayerFromId(sourceId)

        if bridge.getInventoryItem(bridge.permissions['ESX'].item.name).count >= 1 then 
            bridge.removeInventoryItem(bridge.permissions['ESX'].item.name, 1)
            TriggerClientEvent('z_ppvfan:return:use', sourceId)
        else
            TriggerClientEvent('z_ppvfan:return:use', sourceId)
        end
    else
        TriggerClientEvent('z_ppvfan:return:use', sourceId)
    end
end

bridge.useItem = use_item

local function check_permissions(sourceId, data)
    local IsAllowed = false
    local sourceId = sourceId

    if data then   
        if data.framework == 'qb-core' then 
            local QBCore = exports['qb-core']:GetCoreObject()

            if QBCore and QBCore.Functions.GetPlayer(sourceId) then
                IsAllowed = QBCore.Functions.HasPermission(sourceId, data.permission)
            end
        elseif data.framework == 'ace-perms' then 
            IsAllowed = IsPlayerAceAllowed(sourceId, data.permission)
        elseif data.framework == 'qbx_core'then 
            local user = exports['qbx_core']:GetPlayer(sourceId)

            if user ~= nil then 
                for _, job in pairs(data.permission) do
                    if user.PlayerData.job.name == job then
                        IsAllowed = true
                        break
                    end
                end
            end
        end
    end

    return IsAllowed
end

bridge.check = check_permissions