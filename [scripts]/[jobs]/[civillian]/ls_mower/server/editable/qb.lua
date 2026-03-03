if Config.qbSettings.enabled then
    if Config.qbSettings.UseNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end

    function RemovePlayerMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        while xPlayer == nil do Wait(0) end
        if xPlayer.Functions.GetMoney(Config.qbSettings.account) >= amount then
            xPlayer.Functions.RemoveMoney(Config.qbSettings.account, amount)
            return true
        else
            return false
        end
    end

    function AddMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        if not xPlayer then
            return false
        end

        xPlayer.Functions.AddMoney(Config.qbSettings.account, amount)
    end

    function CheckPlayerMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        if xPlayer.Functions.GetMoney(Config.qbSettings.account) >= amount then
            return true
        else
            return false
        end
    end

    function GiveItemOnFinishedJob(player)
        -- local items = 
        -- { 
        --     'ls_emp_blocker', 'ls_entrance_key', 'ls_thermite' -- Example items
        -- }
        -- local chance = math.random(1, 100)
        -- local item = items[math.random(1, #items)]
        -- local amount = math.random(1, 3)

        -- if chance >= 1 then
        --     local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        --     if not xPlayer.Functions.AddItem(item, amount or 1) then
        --         QBCore.Functions.Notify(player, "Inventory is full", 'error')
        --     else
        --         QBCore.Functions.Notify(player, "Acquired: " .. xPlayer.Functions.GetItemByName(item).label .. " x" ..
        --             amount, 'success')
        --     end
        -- end
    end
end
