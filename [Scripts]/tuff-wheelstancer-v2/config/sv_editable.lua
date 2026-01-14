Config.HasItem = function(src, item, count)
    local _item = nil
    if Config.Framework == 'standalone' then return true end -- Skip Item checks for standalone framework
    if Config.Inventory.Enable_Inventory then
        if Config.Inventory.Inventory_Name == "ox_inventory" then
            _item = exports.ox_inventory:GetItem(src, item)
            if _item and _item.count then return _item.count >= count end
        elseif Config.Inventory.Inventory_Name == "qb-inventory" or Config.Inventory.Inventory_Name == "ps-inventory" then
            local Player = QBCore.Functions.GetPlayer(src)
            local foundItem = Player.Functions.GetItemByName(item)
            if foundItem then
                _item = foundItem.amount
                return _item >= count
            end
        elseif Config.Inventory.Inventory_Name == "codem-inventory" then
            _item = exports["codem-inventory"]:GetItemData(src, item)
            if _item then
                local _count = type(_item) == 'number' and _item or (_item.amount or 0)
                return _count >= count
            end
        elseif Config.Inventory.Inventory_Name == "qs-inventory" then
            _item = exports['qs-inventory']:GetItemTotalAmount(src, item)
            return _item >= count
        elseif Config.Inventory.Inventory_Name == "esx" then
            _item = ESX.GetPlayerFromId(src).getInventoryItem(item).count
            return _item >= count
        elseif Config.Inventory.Inventory_Name == "custom" then
            -- Add your custom inventory check here
        end
        return false
    end
    return true
end


Config.DoItemCheck = function(player, items)
    for item, _ in pairs(items) do if Config.HasItem(player, item, 1) then return true end end
    return false
end
Config.RemoveItemCheck = function(player, items)
    for item, _ in pairs(items) do
        if Config.HasItem(player, item) then
            Config.RemoveItem(player, item, 1)
            break
        end
    end
end
function Config.RemoveItem(source, item, count)
    if Config.Inventory.Enable_Inventory then
        local hasItem = Config.HasItem(source, item, count)
        if hasItem then
            if Config.Inventory.Inventory_Name == "ox_inventory" then
                exports.ox_inventory:RemoveItem(source, item, count)
            elseif Config.Inventory.Inventory_Name == "qb-inventory" or Config.Inventory.Inventory_Name == "ps-inventory" then
                local Player = QBCore.Functions.GetPlayer(source)
                Player.Functions.RemoveItem(item, count)
            elseif Config.Inventory.Inventory_Name == "codem-inventory" then
                exports["codem-inventory"]:RemoveItem(source, item, count)
            elseif Config.Inventory.Inventory_Name == "qs-inventory" then
                exports['qs-inventory']:RemoveItem(source, item, count)
            elseif Config.Inventory.Inventory_Name == "esx" then
                ESX.GetPlayerFromId(source).removeInventoryItem(item, count)
            elseif Config.Inventory.Inventory_Name == "custom" then
                -- Add your custom inventory remove item here
            end
        end
    end
end

function Config.GetPlayerMoney(source, type)
    if not source then return end
    if Config.Framework == 'standalone' then return 1000 * 100 end
    local money = 0
    if QBCore or Config.Framework == 'qb' then
        if not QBCore then
            QBCore = exports['qb-core']:GetCoreObject()
        end
        local Player = QBCore.Functions.GetPlayer(source)
        money = Player.Functions.GetMoney(type) or 0
    elseif ESX or Config.Framework == 'esx' then
        if not ESX then
            ESX = exports['es_extended']:getSharedObject()
        end
        local xPlayer = ESX.GetPlayerFromId(source)
        if type ~= 'bank' then
            money = xPlayer.getAccount('money').money or 0
        else
            money = xPlayer.getAccount('bank').money or 0
        end
    else
        -- STANDALONE, Implement your money system!!!
    end
    return money
end

function Config.RemovePlayerMoney(source, type, amount, societyName)
    if not source or not amount then return false end
    if QBCore or Config.Framework == 'qb' then
        if not QBCore then
            QBCore = exports['qb-core']:GetCoreObject()
        end
        local Player = QBCore.Functions.GetPlayer(source)

        Player.Functions.RemoveMoney(type, amount, 'Wheel Stancer')
    elseif ESX or Config.Framework == 'esx' then
        if not ESX then
            ESX = exports['es_extended']:getSharedObject()
        end
        local xPlayer = ESX.GetPlayerFromId(source)

        if type ~= 'bank' then
            xPlayer.removeAccountMoney("cash", amount, "Wheel Stancer Payment.")
        else
            xPlayer.removeAccountMoney("bank", amount, "Wheel Stancer Payment.")
        end
    else
        -- STANDALONE, Implement your money system!!!
    end
end

function Config.GetPlayerInGameName(source)
    local firstname, lastname = 'TestName', 'TestLastName'
    if QBCore or Config.Framework == 'qb' then
        if not QBCore then
            QBCore = exports['qb-core']:GetCoreObject()
        end
        local Player = QBCore.Functions.GetPlayer(source)

        firstname, lastname = Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname
    elseif ESX or Config.Framework == 'esx' then
        if not ESX then
            ESX = exports['es_extended']:getSharedObject()
        end
        local xPlayer = ESX.GetPlayerFromId(source)

        firstname, lastname = xPlayer.getName(), '#'
    else
        firstname, lastname = GetPlayerName(source), '#'
    end
    return firstname, lastname
end

function Config.GetPlayerJob(source)
    local job, grade = "Tuff Stancer", 0
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        job = Player.PlayerData.job.name
        grade = Player.PlayerData.job.grade.level
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        local jobtbl = xPlayer.getJob()
        job = jobtbl.name
        grade = jobtbl.grade
    else
        -- STANDALONE, Implement your job system!!!
    end
    return job, grade
end

Config.DoJobCheck = function(player, jobs)
    local job, grade = Config.GetPlayerJob(player)
    if Config.Framework == 'standalone' then return true end -- Skip Job Checks for standalone
    if jobs[job] then
        if type(jobs[job]) == "table" then
            for _, gr in pairs(jobs[job]) do -- Check Grade
                if gr == grade then return true end
            end
        else
            return true
        end
    end
    return false
end

Config.IsVehicleOwned = function(player, plateNum)
    local result = false
    if not plateNum then return false end
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then -- Qb/QBX ownership
        local retrievedLicense = exports.oxmysql:scalar_async(
            'SELECT `license` FROM `player_vehicles` WHERE `plate` = ? LIMIT 1', {
                plateNum
            })

        if retrievedLicense then result = retrievedLicense ~= nil end
    elseif GetResourceState('es_extended') == 'started' then -- ESX ownership
        local retrievedOwner = exports.oxmysql:scalar_async(
            'SELECT `owner` FROM `owned_vehicles` WHERE `plate` = ? LIMIT 1', {
                plateNum
            })
        local trimmedOwner = retrievedOwner:sub(retrievedOwner:find(":") + 1)
        if trimmedOwner then result = trimmedOwner ~= nil end
    else
        -- STANDALONE, Implement your money system!!!
    end
    return result
end

Config.GetPlayerIdentifier = function(player)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(player)
        return Player.PlayerData.citizenid
    elseif ESX then
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.getIdentifier()
    else -- STANDALONE, Implement your money system!!!
        return GetPlayerIdentifierByType(player, 'license')
    end
end

Config.IsPlayerAnAdmin = function(player)
    if IsPlayerAceAllowed(player, 'stancer') or IsPlayerAceAllowed(player, 'command') then
        return true
    end
    if QBCore and Config.Framework == 'qb' and QBCore.Functions.HasPermission(player, 'admin') then
        return true
    end
    if ESX and Config.Framework == 'esx' and ESX.GetPlayerFromId then
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.group == 'admin'
    end
    return false
end

if GetResourceState('brazzers-fakeplates') == 'started' and exports['brazzers-fakeplates'] then
    lib.callback.register('wheelstancer:brazzersFakePlate', function(source, plate)
        local hasFakePlate = exports['brazzers-fakeplates']:getPlateFromFakePlate(plate)
        if hasFakePlate then return hasFakePlate end
    end)
end
