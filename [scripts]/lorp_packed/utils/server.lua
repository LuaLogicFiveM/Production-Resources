local utils = {}
local ox_inventory = exports.ox_inventory
local lorp_discord_api = exports.lorp_discord_api

utils.getPlayerIdentifier = function(source)
    local player = ESX.GetPlayerFromId(source)
    return player and player.identifier or false
end

utils.getPlayerJob = function(source)
    local player = ESX.GetPlayerFromId(source)
    return player and player.job or false
end

utils.hasJobGrade = function(source, jobs)
    local playerJob = utils.getPlayerJob(source)
    return playerJob and jobs[playerJob.name] and playerJob.grade >= jobs[playerJob.name] or false
end

utils.getPlayerGroup = function(source)
    local player = ESX.GetPlayerFromId(source)
    return player and player.getGroup() or false
end

utils.hasGroup = function(source, group)
    local playerGroup = utils.getPlayerGroup(source)
    return playerGroup and playerGroup == group or false
end

utils.hasDiscordRole = function(source, role)
    local playerGroup = lorp_discord_api:HasDiscordRole(source, role)
    return playerGroup or false
end

utils.addItem = function(source, item, amount)
    return ox_inventory:AddItem(source, item, amount)
end

utils.removeItem = function(source, item, amount)
    local itemCount = ox_inventory:Search(source, 'count', item)
    return itemCount and itemCount >= amount and ox_inventory:RemoveItem(source, item, amount) or false
end

utils.removeBank = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer and xPlayer.getAccount('bank').money >= amount and xPlayer.removeAccountMoney('bank', amount) or false
end

utils.addBank = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer and xPlayer.addAccountMoney('bank', amount) or false
end

utils.bankTransaction = function(source, amount, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    if type == 'deposit' then
        utils.addBank(source, amount)
        utils.removeItem(source, 'money', amount)
    elseif type == 'withdraw' then
        utils.addItem(source, 'money', amount)
        utils.removeBank(source, amount)
    end

    return true
end

utils.formatNumber = function(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return(minus..int:reverse():gsub("^,", "")..fraction)
end

utils.notify = function(target, title, message, type, duration)
    return lib.notify(target, {
        title = title,
        description = message,
        type = type,
        position = 'top',
        duration = duration or 5000,
        style = {
            backgroundColor = '#00000',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        }
    })
end

utils.groups = {
    ['owner'] = true,
    ['manager'] = true,
    ['admin'] = true,
    ['mod'] = true,
    ['tmod'] = true
}

utils.hasStaff = function(source)
    local playerGroup = utils.getPlayerGroup(source)
    return playerGroup and utils.groups[playerGroup] or false
end

lib.callback.register('lorp_packed:server:hasPerms', function(source)
    return utils.hasStaff(source)
end)

return utils