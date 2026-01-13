---@diagnostic disable: duplicate-set-field
if GetResourceState('kartik-banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local kartik = exports['kartik-banking']

GRP_Banking.GetSystemName = function()
    return 'kartik-banking'
end

GRP_Banking.GetResourceName = function()
    return 'kartik-banking'
end

GRP_Banking.GetAccountBalance = function(account)
    local balance = kartik:GetAccountMoney(account)
    return balance or 0
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return kartik:AddAccountMoney(account, amount, reason)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return kartik:RemoveAccountMoney(account, amount, reason)
end

return GRP_Banking
