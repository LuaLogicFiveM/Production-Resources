---@diagnostic disable: duplicate-set-field
if GetResourceState('wasabi_banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local wasabi_banking = exports['wasabi_banking']

GRP_Banking.GetSystemName = function()
    return 'wasabi_banking'
end

GRP_Banking.GetResourceName = function()
    return 'wasabi_banking'
end

GRP_Banking.GetAccountBalance = function(account)
    local balance = wasabi_banking:GetAccountBalance(account, 'society')
    return balance or 0
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return wasabi_banking:AddMoney('society', account, amount)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return wasabi_banking:RemoveMoney('society', account, amount)
end

return GRP_Banking
