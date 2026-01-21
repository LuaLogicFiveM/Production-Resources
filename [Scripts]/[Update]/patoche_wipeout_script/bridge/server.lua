local CORE

local framework = (function()
    if GetResourceState('qb-core') == 'started' then return 'qb' end
    if GetResourceState('qbx_core') == 'started' then return 'qb' end
    if GetResourceState('es_extended') == 'started' then return 'esx' end

    return 'custom'
end)()

local function loadFramework()
    if framework == 'qb' then
        CORE = exports['qb-core']:GetCoreObject()
    elseif framework == 'esx' then
        CORE = exports.es_extended:getSharedObject()
        if not CORE then
            CreateThread(function()
                while not CORE do
                    TriggerEvent('esx:getSharedObject', function(obj) CORE = obj end)
                    Wait(0)
                end
            end)
        end
    elseif framework == 'custom' then
        warn('Add your own framework export system in bridge/server.lua at line 25')
    end
end

loadFramework()

---@param src number
function GetPlayerFromId(src)
    if framework == 'qb' then
        return CORE.Functions.GetPlayer(src)
    elseif framework == 'esx' then
        return CORE.GetPlayerFromId(src)
    elseif framework == 'custom' then
        warn('Add your own GetPlayerFromId in bridge/server.lua at line 38')
    end
end

---@param player table
function GetRPPlayerName(player)
    if framework == 'qb' then
        return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
    elseif framework == 'esx' then
        return player.getName()
    elseif framework == 'custom' then
        warn('Add your own GetPlayerName in bridge/server.lua at line 49')
    end
end