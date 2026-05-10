---@diagnostic disable: duplicate-set-field
if GetResourceState('fd_banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local fd_banking = exports['fd_banking']

GRP_Banking.GetSystemName = function()
    return 'fd_banking'
end

GRP_Banking.GetResourceName = function()
    return 'fd_banking'
end

GRP_Banking.GetAccountBalance = function(account)
    return fd_banking:GetAccount(account)
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return fd_banking:AddMoney(account, amount, reason)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return fd_banking:RemoveMoney(account, amount, reason)
end

return GRP_Banking
