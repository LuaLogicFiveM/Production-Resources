---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local qbBanking = exports['qb-banking']

GRP_Banking.GetSystemName = function()
    return 'qb-banking'
end

GRP_Banking.GetResourceName = function()
    return 'qb-banking'
end

GRP_Banking.GetAccountBalance = function(account)
    return qbBanking:GetAccountBalance(account)
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return qbBanking:AddMoney(account, amount, reason)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return qbBanking:RemoveMoney(account, amount, reason)
end

return GRP_Banking
