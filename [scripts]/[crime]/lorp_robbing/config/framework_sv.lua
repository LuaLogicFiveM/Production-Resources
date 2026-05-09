Framework = {
    Object = exports['es_extended']:getSharedObject(),
    BlacklistedJobs = {['bcso'] = true, ['gsp'] = true, ['safd'] = true, ['gov'] = true},

    Functions = {
        IsPlayerAllowedToSteal = function(playerId)
           -- You can add anything here. 
        end,

        CanPlayerBeStolen = function(playerId)
            local xPlayer = Framework.Object.GetPlayerFromId(playerId)
            local xPlayerJob = xPlayer.job.name

            return Framework.BlacklistedJobs[xPlayerJob] and false or true
        end,

        GetTargetItems = function(playerId)
            local items = {}
            local inventory = exports.ox_inventory:GetInventory(playerId)

            for _,v in pairs(inventory.items) do
                local blacklisted, amount = IsItemBlacklisted(v.name, v.count)
                if not blacklisted and v.count >= 1 then
                    items[#items + 1] = {type = "item", item = v.name, label = v.label, amount = amount, data = v.metadata}
                end
            end

            return items
        end,

        StealItem = function(thiefId, targetId, itemName, itemAmount, itemData)
            local stolen = false
            local targetItem = exports.ox_inventory:GetItemCount(targetId, itemName) >= itemAmount

            if targetItem then
                if exports.ox_inventory:CanCarryItem(thiefId, itemName, itemAmount, itemData) then
                    exports.ox_inventory:RemoveItem(targetId, itemName, itemAmount)
                    exports.ox_inventory:AddItem(thiefId, itemName, itemAmount, itemData)
                    stolen = true
                end
            end

            return stolen
        end,

        ShowNotification = function(playerId, message)
            TriggerClientEvent('esx:showNotification', playerId, message)
        end,

        GetIdentifier = function(playerId)
            local xPlayer = Framework.Object.GetPlayerFromId(playerId)
            return xPlayer.identifier
        end,

        BanPlayer = function(playerId)
            DropPlayer(playerId, 'Stop Cheating!')
        end
    }
}