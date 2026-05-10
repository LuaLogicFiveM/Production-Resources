---@diagnostic disable: duplicate-set-field
if GetResourceState('tgiann-bank') == 'missing' then return end
GRP_Banking = GRP_Banking or {}

local tgiann = exports["tgiann-bank"]

GRP_Banking.GetSystemName = function()
    return 'tgiann-bank'
end

GRP_Banking.GetResourceName = function()
    return 'tgiann-bank'
end

GRP_Banking.GetAccountBalance = function(account)
    return tgiann:GetJobAccountBalance(account)
end

GRP_Banking.AddAccountFunds = function(account, amount, _)
    return tgiann:AddJobMoney(account, amount)
end

GRP_Banking.RemoveAccountFunds = function(account, amount, _)
    return tgiann:RemoveJobMoney(account, amount)
end

return GRP_Banking
