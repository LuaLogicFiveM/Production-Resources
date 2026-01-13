---@diagnostic disable: duplicate-set-field
if GetResourceState('okokBanking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local okokBanking = exports['okokBanking']

GRP_Banking.GetSystemName = function()
    return 'okokBanking'
end

GRP_Banking.GetResourceName = function()
    return 'okokBanking'
end

GRP_Banking.GetAccountBalance = function(account)
    return okokBanking:GetAccount(account)
end

GRP_Banking.AddAccountFunds = function(account, amount, _)
    return okokBanking:AddMoney(account, amount)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, _)
    return okokBanking:RemoveMoney(account, amount)
end

return GRP_Banking
