if Config.standaloneSettings.enabled then

    function RemovePlayerMoney(source, amount)
        local xPlayer = exports.money:getaccount(source)
        exports.money:updateaccount(source, {cash = xPlayer.amount - amount, bank = xPlayer.bank})
    end

    function AddMoney(source, amount)
        local xPlayer = exports.money:getaccount(source)
        exports.money:updateaccount(source, {cash = xPlayer.amount + amount, bank = xPlayer.bank})
    end

    function CheckPlayerMoney(source, amount)
        local xPlayer = exports.money:getaccount(source)        
        if tonumber(xPlayer.amount) >= amount then
            return true
        else
            return false
        end
    end

end
