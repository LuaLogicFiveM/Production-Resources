if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports.es_extended:getSharedObject()
local config = require 'config'

function GetIdentifier(src)
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return DebugPrint('[GetIdentifier] - xPlayer was unable to be found for id '..src, 'error')
    end

    return xPlayer.identifier
end

function GetJob(src)
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return DebugPrint('[GetJob] - xPlayer was unable to be found for id '..src, 'error')
    end

    return xPlayer.getJob()
end

if config.cache.names then
    RegisterNetEvent('esx:playerLoaded', function(player, xPlayer)
        local data = MySQL.query.await('SELECT `name` FROM `lualogic_trust` WHERE `identifier` = ? LIMIT 1', { xPlayer.identifier })

        if not data then return end

        local playerName = GetPlayerName(player)
        local forbiddenNames = { "%^1", "%^2", "%^3", "%^4", "%^5", "%^6", "%^7", "%^8", "%^9", "%^%*", "%^_", "%^=", "%^%~" }

        for name in pairs(forbiddenNames) do
            if (string.gsub(string.gsub(string.gsub(string.gsub(playerName:lower(), "-", ""), ",", ""), "%.", ""), " ", ""):find(forbiddenNames[name])) then
                print(playerName .. " has a filtered name!")
            end
        end

        MySQL.update('UPDATE lualogic_trust SET name = ? WHERE identifier = ?', { playerName, GetIdentifier(player) }, false)
    end)
end

lib.callback.register('lualogic_trust:server:requestPermission', function(source, permission)
    return IsPlayerAceAllowed(source, permission) == 1
end)