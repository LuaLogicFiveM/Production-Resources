-- These functions are specific to framework used in config.
-- If you want to use custom implementation or own framework,
-- set Config.framework to 'Standalone'

function PlayerHasJobGrade(source, requiredJob, requiredGrade)
    if Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(source)

        if Player then
            local job = Player.PlayerData.job

            if job.name == requiredJob and job.grade.level >= requiredGrade then
                return true
            end
        end

        return false
    elseif Framework == 'Qbox' then
        local Player = exports.qbx_core:GetPlayer(source)

        if Player then
            local job = Player.PlayerData.job

            if job.name == requiredJob and job.grade.level >= requiredGrade then
                return true
            end
        end

        return false
    elseif Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer then
            local job = xPlayer.getJob()

            if job.name == requiredJob and job.grade >= requiredGrade then
                return true
            end
        end

        return false
    elseif Framework == "ND_Core" then
        local player = exports["ND_Core"]:getPlayer(source)

        if player then
            local group = player?.groups?[requiredJob]
            if group and group.rank >= requiredGrade then
                return true
            end
        end

        return false
    elseif Framework == "Standalone" then
        print("Not implemented")
        return false
    end
end

function GetSourceIdentifier(source)
    if Framework == "QBCore" then
        local player = QBCore.Functions.GetPlayer(source)
        if player then
            return player.PlayerData.citizenid
        else
            return nil
        end
    elseif Framework == "Qbox" then
        local player = exports.qbx_core:GetPlayer(source)
        if player then
            return player.PlayerData.citizenid
        else
            return nil
        end
    elseif Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer then
            return xPlayer.identifier
        end

        return nil
    elseif Framework == "ND_Core" then
        local player = exports["ND_Core"]:getPlayer(source)

        if player then
            return player.identifier
        end

        return nil
    elseif Framework == "Standalone" then
        print("Unsupported framework: " .. Framework)
        return nil
    end
end

function AddBoombox()
    if Framework == "QBCore" then
        QBCore.Functions.AddItem(Config.boombox.itemData.name, Config.boombox.itemData)
    elseif Framework == "Qbox" then
        -- QBCore.Functions.AddItem(Config.boombox.itemData.name, Config.boombox.itemData)
    elseif Framework == "ESX" then
        -- ESX Item must be inserted into 'items' table: INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('boombox', 'Boombox', '1', '0', '1');
    elseif Framework == "ND_Core" then
        -- Item must be added to ox_inventory items.lua file.
    elseif Framework == "Standalone" then
        print("Not implemented")
    end
end

function RegisterBoombox()
    if Framework == "QBCore" then
        QBCore.Functions.CreateUseableItem(Config.boombox.itemData.name, function(source, item)
            local Player = QBCore.Functions.GetPlayer(source)
            Player.Functions.RemoveItem(Config.boombox.itemData.name, 1)
            TriggerClientEvent('EVO:evo_sound_player:client:boomboxCreate', source)
        end)
    elseif Framework == "Qbox" then
        exports.qbx_core:CreateUseableItem(Config.boombox.itemData.name, function(source, item)
            exports.ox_inventory:RemoveItem(source, Config.boombox.itemData.name, 1)
            TriggerClientEvent('EVO:evo_sound_player:client:boomboxCreate', source)
        end)
    elseif Framework == "ESX" then
        ESX.RegisterUsableItem(Config.boombox.itemData.name, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            
            if xPlayer then
                xPlayer.removeInventoryItem(Config.boombox.itemData.name, 1)
                TriggerClientEvent('EVO:evo_sound_player:client:boomboxCreate', source)
            end
        end)
    elseif Framework == "ND_Core" then
        exports('boombox', function(event, item, inventory, slot, data)
            if event == 'usedItem' then
                return TriggerClientEvent('EVO:evo_sound_player:client:boomboxCreate', inventory.id)
            end
        end)
    elseif Framework == "Standalone" then
        print("Not implemented")
    end
end

function OnBoomboxRemoved(source)
    if Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(source)

        if Player then
            Player.Functions.AddItem(Config.boombox.itemData.name, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["boombox"], "add")
        end
    elseif Framework == "Qbox" then
        if source then
            exports.ox_inventory:AddItem(source, Config.boombox.itemData.name, 1)
        end
    elseif Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer then
            xPlayer.addInventoryItem(Config.boombox.itemData.name, 1)
        end
    elseif Framework == "ND_Core" then
        if source then
            exports.ox_inventory:AddItem(source, Config.boombox.itemData.name, 1)
        end
    elseif Framework == "Standalone" then
        print("Not implemented")
    end
end


function GetCoreObject()
    return exports['qb-core']:GetCoreObject()
end

function GetSharedObject()
    return exports["es_extended"]:getSharedObject()
end