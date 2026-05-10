---@diagnostic disable: duplicate-set-field
if GetResourceState('tgg-banking') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local tgg = exports['tgg-banking']

GRP_Banking.GetSystemName = function()
    return 'tgg-banking'
end

GRP_Banking.GetResourceName = function()
    return 'tgg-banking'
end

GRP_Banking.GetAccountBalance = function(account)
    return tgg:GetSocietyAccountMoney(account) or 0
end

GRP_Banking.AddAccountFunds = function(account, amount, _)
    return tgg:AddSocietyMoney(account, amount)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, _)
    return tgg:RemoveSocietyMoney(account, amount)
end

return GRP_Banking
