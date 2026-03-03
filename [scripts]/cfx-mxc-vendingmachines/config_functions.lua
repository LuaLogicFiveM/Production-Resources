Config.Functions = {
    --#region Server
    StartFramework = function()
        if GetResourceState("es_extended") ~= "missing" then
            ESX = exports["es_extended"]:getSharedObject()
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore = exports["qb-core"]:GetCoreObject()
        end
    end,

    GiveItem = function(source, itemName, count)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/AddItem/
        AddItem(source, itemName, count)
    end,
    HaveMoney = function(source, type, amount)
        if amount == 0 then return true end

        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/HaveMoney/
        return HaveMoney(source, type, amount)
    end,
    RemoveMoney = function(source, type, amount)
        if amount <= 0 then return end

        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/RemoveMoney/
        RemoveMoney(source, type, amount)
    end,
    --#endregion


    --#region Client
    TryToBuy = function(self, selection, dbId, success)
        if Server.CanBuySnackFromVending(self.name, selection) then
            Server.SetVendingUsed(dbId, true)
            success()
            Server.SetVendingUsed(dbId, false)

            if not Config.NoFramework then
                Server.BuySnackFromVending(self.name, selection)
            end
        else
            ButtonFor(Config.Translations["not_enough_money"], 2000)
            Server.SetVendingUsed(dbId, false)
        end
    end,

    --[[
        TargetAddModel = function(models, options)
    
        end,
        TargetAddLocalEntity = function(entity, options)
    
        end,
        TargetRemoveLocalEntity = function(entity)
    
        end,
    ]]
    --#endregion
}