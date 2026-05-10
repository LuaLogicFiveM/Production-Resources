---@diagnostic disable: duplicate-set-field
GRP_Banking = GRP_Banking or {}

GRP_Banking.GetSystemName = function()
    return 'default'
end

GRP_Banking.GetResourceName = function()
    return 'default'
end

GRP_Banking.GetAccountBalance = function(account)
    return 0, print("The resource you are using does not support this function.")
end

GRP_Banking.AddAccountFunds = function(account, amount, reason)
    return false, print("The resource you are using does not support this function.")
end

GRP_Banking.RemoveAccountFunds = function(account, amount, reason)
    return false, print("The resource you are using does not support this function.")
end

return GRP_Banking
