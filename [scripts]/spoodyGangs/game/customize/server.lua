---@class svBridge
svBridge = {
    deathEvent = 'esx:onPlayerDeath', --- If you are on a custom framework, ensure the data passed is 1:1 as ESX is.
}

--- If you use your own permission, you can use this to implement compatability
---@param permType string: the ACE permission, you can intercept this and change it based on how you want.
function svBridge.hasPermissions(source, permType)
    return IsPlayerAceAllowed(source, permType)
end

---@param account 'money' | 'bank' | 'dirty'
function svBridge.getMoney(source, account)
    local xPlayer = ESX.GetPlayerFromId(source)

    if account == 'money' then
        return xPlayer.getAccount('money').money
    elseif account == 'bank' then
        return xPlayer.getAccount('bank').money
    elseif account == 'dirty' then
        return xPlayer.getAccount('black_money').money
    end
end

---@param item string
---@param amount number
function svBridge.addItem(source, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if item and amount then
        xPlayer.addInventoryItem(item, amount)
    end
end

---@param item string
---@param amount number
function svBridge.removeItem(source, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if item and amount then
        xPlayer.removeInventoryItem(item, amount)
    end
end

---@param account 'money' | 'bank' | 'dirty'
function svBridge.addMoney(source, amount, account)
    local xPlayer = ESX.GetPlayerFromId(source)

    if account == 'money' then
        xPlayer.addMoney(amount)
    elseif account == 'bank' then
        xPlayer.addAccountMoney('bank', amount)
    elseif account == 'dirty' then
        xPlayer.addAccountMoney('black_money', amount)
    end
end

---@param account 'money' | 'bank' | 'dirty'
function svBridge.removeMoney(source, amount, account)
    local xPlayer = ESX.GetPlayerFromId(source)

    if account == 'money' then
        xPlayer.removeMoney(amount)
    elseif account == 'bank' then
        xPlayer.removeAccountMoney('bank', amount)
    elseif account == 'dirty' then
        xPlayer.removeAccountMoney('black_money', amount)
    end
end

function svBridge.getIdentifier(source)
    return Player(source).state.identifier
end

function svBridge.getName(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return GetPlayerName(source)
    end

    return xPlayer.getName()
end

-- Get the amount of items a player has
---@return boolean, number
function svBridge.getItem(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = xPlayer.getInventoryItem(item)

    if not item then
        return false, 0
    end

    return true, data.count
end

-- Returns a player's inventory
---@return table<{ name: string, label: string, count: number}>
function svBridge.getItems(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inv = xPlayer.getInventory()

    if not inv then
        return {}
    end

    return inv
end

function svBridge.getItemLabel(item)
    return ESX.GetItemLabel(item)
end

lib.callback.register('spoodyGangs:getItemLabel', function(source, item)
    return svBridge.getItemLabel(item)
end)