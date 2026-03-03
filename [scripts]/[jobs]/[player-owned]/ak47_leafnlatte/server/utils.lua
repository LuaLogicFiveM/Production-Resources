TriggerEvent('esx_society:registerSociety', 'leafnlatte', 'leafnlatte', 'society_leafnlatte', 'society_leafnlatte', 'society_leafnlatte', {type = 'private'})
TriggerEvent('society:registerSociety', 'leafnlatte', 'leafnlatte', 'society_leafnlatte', 'society_leafnlatte', 'society_leafnlatte', {type = 'private'})

function getSocietyMoney()
    local money = nil
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_leafnlatte', function(account)
       money = account.money
    end)
    while money == nil do Citizen.Wait(0) end
    return money
end

function addSocietyMoney(money)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_leafnlatte', function(account)
       account.addMoney(money)
    end)
end

function removeSocietyMoney(money)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_leafnlatte', function(account)
       account.removeMoney(money)
    end)
end

function CanCarryItem(xPlayer, item, count)
    if Config.CheckCanCarryItem then
        if type(xPlayer.canCarryItem) == "table" or type(xPlayer.canCarryItem) == "function" then
            return xPlayer.canCarryItem(item, count)
        end
    else
        return true
    end
end

function hasEnoughItem(source, item, quantity)
    local quantity = quantity or 1
    local xPlayer = ESX.GetPlayerFromId(source)
    local inv = xPlayer.getInventoryItem(item)
    if inv and ((inv.amount and inv.amount >= quantity) or (inv.count and inv.count >= quantity)) then
        return true
    end
    return false
end

function GetItemLabel(item)
    local label = ESX.GetItemLabel(item)
    if label then
        return label
    else
        print("^1 Item: ^3["..item.."]^1 is Missing^0")
        return item
    end
end

function GetPlayerFromId(id)
	return ESX.GetPlayerFromId(id)
end

function getMoney(id)
	local xPlayer = GetPlayerFromId(id)
	return xPlayer.getMoney()
end

function PlayerCanPay(xPlayer, price, payment)
    if payment == 'cash' then
        return xPlayer.getAccount('money').money >= price
    else
        return xPlayer.getAccount('bank').money >= price
    end
end

function PayTheBill(xPlayer, payment, price)
    if payment == 'cash' then
        xPlayer.removeMoney(price)
    else
        xPlayer.removeAccountMoney('bank', price)
    end
end

GetName = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    local namedb = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
    local name = namedb[1].firstname or ''
    name = namedb[1].lastname and name..' '..namedb[1].lastname or ''
    return name
end