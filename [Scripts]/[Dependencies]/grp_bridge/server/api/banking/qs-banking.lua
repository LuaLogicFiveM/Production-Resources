---@diagnostic disable: duplicate-set-field
if GetResourceState('qs-banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local qsBanking = exports['qs-banking']

GRP_Banking.GetSystemName = function()
    return 'qs-banking'
end

GRP_Banking.GetResourceName = function()
    return 'qs-banking'
end

GRP_Banking.GetAccountBalance = function(account)
    return qsBanking:GetAccountBalance(account)
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return qsBanking:AddMoney(account, amount, reason)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return qsBanking:RemoveMoney(account, amount, reason)
end

return GRP_Banking
