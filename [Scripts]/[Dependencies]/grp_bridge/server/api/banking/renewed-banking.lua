---@diagnostic disable: duplicate-set-field
if GetResourceState('renewed-banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local renewed_banking = exports['renewed-banking']

GRP_Banking.GetSystemName = function()
    return 'renewed-banking'
end

GRP_Banking.GetResourceName = function()
    return 'renewed-banking'
end

GRP_Banking.GetAccountBalance = function(account)
    return renewed_banking:GetAccountBalance(account)
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return renewed_banking:AddMoney(account, amount, reason)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return renewed_banking:RemoveMoney(account, amount, reason)
end

return GRP_Banking
