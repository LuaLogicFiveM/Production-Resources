ESX = exports.es_extended:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'hookahloungev2', 'hookahloungev2', 'society_hookahloungev2', 'society_hookahloungev2', 'society_hookahloungev2', {type = 'private'})
TriggerEvent('society:registerSociety', 'hookahloungev2', 'hookahloungev2', 'society_hookahloungev2', 'society_hookahloungev2', 'society_hookahloungev2', {type = 'private'})

function getSocietyMoney()
	local money = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_hookahloungev2', function(account)
       money = account.money
    end)
    while money == nil do Citizen.Wait(0) end
    return money
end

function addSocietyMoney(money)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_hookahloungev2', function(account)
       account.addMoney(money)
    end)
end

function removeSocietyMoney(money)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_hookahloungev2', function(account)
       account.removeMoney(money)
    end)
end

function CanCarryItem(xPlayer, item, count)
	if Config.CheckCanCarryItem then
		if type(xPlayer.canCarryItem) == "table" or type(xPlayer.canCarryItem) == "function" then
	        return xPlayer.canCarryItem(item, count)
	    else
	    	local xItem = xPlayer.getInventoryItem(item)
	        if xItem.limit ~= -1 and (xItem.count + count) > xItem.limit then
	            return false
	        else
	            return true
	        end
	    end
	else
		return true
	end
end

RegisterServerEvent('ak47_hookahloungev2:PlayWithinDistance')
AddEventHandler('ak47_hookahloungev2:PlayWithinDistance', function(coords , maxDistance, soundFile)
    TriggerClientEvent('ak47_hookahloungev2:PlayWithinDistance', -1, coords, maxDistance, soundFile)
end)

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

function hasEnoughItem(source, item, quantity)
    local quantity = quantity or 1
    local xPlayer = ESX.GetPlayerFromId(source)
    local inv = xPlayer.getInventoryItem(item)
    if inv and ((inv.amount and inv.amount >= quantity) or (inv.count and inv.count >= quantity)) then
        return true
    end
    return false
end
