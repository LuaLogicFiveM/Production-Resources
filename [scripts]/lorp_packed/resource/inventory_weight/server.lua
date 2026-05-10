local Inventory = exports.ox_inventory
local sv_utils = require 'utils.server'

local function GetWeight(identifier)
    local data = MySQL.rawExecute.await('SELECT `weight` FROM `lualogic_inventory` WHERE `identifier` = ?', { identifier })
    return json.encode(data) == '[]' and tonumber(50*1000) or tonumber(data[1].weight)
end

local function SetWeight(source, identifier, amount)
    local weight = GetWeight(identifier)
    local total = tonumber(amount)

    if weight == 50000 then
        MySQL.insert('INSERT INTO `lualogic_inventory` (identifier, weight) VALUES (?, ?)', { identifier, total }, false)
        Inventory:SetMaxWeight(source, total)
    else
        MySQL.update('UPDATE lualogic_inventory SET weight = ? WHERE identifier = ?', { total, identifier }, false)
        Inventory:SetMaxWeight(source, total)
    end
end

RegisterCommand('addinventoryweight', function(source, args, rawCommand)
    local src = source
    local tgt = tonumber(args[1])
    local weight = tonumber(args[2]*1000)
    if src ~= 0 then return end

    local identifier = sv_utils.getPlayerIdentifier(tgt)
    if not identifier then return end

    local currentweight = GetWeight(identifier)
    local totalweight = (currentweight + weight)
    SetWeight(tgt, identifier, totalweight)
    print('[SUCCESS] - Added '..sv_utils.formatNumber(tonumber(args[2]))..' kg inventory weight to make a total of '..sv_utils.formatNumber(totalweight)..' kg for '..GetPlayerName(tgt)..'\'s inventory.')
end, true)

RegisterCommand('setinventoryweight', function(source, args, rawCommand)
    local src = source
    local tgt = tonumber(args[1])
    local weight = tonumber(args[2])
    local totalweight = weight*1000
    if src ~= 0 then return end

    local identifier = sv_utils.getPlayerIdentifier(tgt)
    if not identifier then return end

    SetWeight(tgt, identifier, totalweight)
    print('[SUCCESS] - Set '..GetPlayerName(tgt)..'\'s inventory weight to '..sv_utils.formatNumber(totalweight)..' kg.')
end, true)

RegisterNetEvent('esx:playerLoaded', function(source, xPlayer, isNew)
    if not xPlayer then return end
    local weight = GetWeight(xPlayer.identifier)
    if not weight then return end
    Inventory:SetMaxWeight(source, weight)
end)
