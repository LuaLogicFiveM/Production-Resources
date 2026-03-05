Config.Functions = {
    StartFramework = function()
        if GetResourceState("es_extended") ~= "missing" then
            ESX = exports["es_extended"]:getSharedObject()
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore = exports["qb-core"]:GetCoreObject()
        end
    end,

    --------------------------------- Server ---------------------------------

    RegisterUsableItem = function(item, func)
        -- func: (source, item) => void
        -- source<number> Its the player id that uses the item
        -- item<string>   The name of the item that is being used

        if GetResourceState("es_extended") ~= "missing" then
            ESX.RegisterUsableItem(item, func)
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore.Functions.CreateUseableItem(item, func)
        end
    end,

    HaveItem = function(source, item)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/HasItem/
        return HaveItem(source, item)
    end,

    AddItem = function(source, item, amount)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/AddItem/
        AddItem(source, item, amount)
    end,

    --[[ 
    CustomJobCheck = function(filter)
            
    end, 
    ]]

    --[[
    TargetAddModel = function(models, options)

    end,
    TargetAddLocalEntity = function(entity, options)

    end,
    TargetRemoveLocalEntity = function(entity)

    end,
    ]]

    -- robbery: {
    --     id: number,
    --     coords: vec3,
    --     radius: number
    --}
    CanStartRobbery = function(robbery, source)
        local cops = RobberyManager.GetCops()

        return #cops >= Config.Cops.required
    end,

    StartAlarm = function(storeId)
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = {'bcso', 'sasp', 'gov'},
            coords = { x = -623.6997, y = -234.6382, z = 0.0},
            title = '10-37 - Bank Heist',
            message = 'Person reported robbing a jewlery store',
            flash = 1,
            sound = 1,
            blip = {
                sprite = 674,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = '911 - Jewelry Heist',
                time = 5,
                radius = 25,
            }
        })
        --[[RobberyManager.ExecuteForEachCop(function(cop)
            if ESX then
                cop.showNotification(Config.Translations["robbery_started_notify"])
                TriggerClientAction("SetBlipToStore", cop.source, storeId)
            elseif QBCore then
                TriggerClientEvent('QBCore:Notify', cop.source, Config.Translations["robbery_started_notify"], "primary")
                TriggerClientAction("SetBlipToStore", cop.source, storeId)
            end
        end)]]
    end,

    -- Allow a custom minigame for the vault
    -- Return true if succeeds, false if fails
    --[[ CustomVaultMinigame = function(storeId)
        return true
    end ]]

    ----------------------------------- Client ---------------------------------
    
    OnStandGlassBreak = function(obj, storeId)
         
    end
}