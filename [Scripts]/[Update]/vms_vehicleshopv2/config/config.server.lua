SV = {}

SV.Database = {
    ['esx-table:owned_vehicles'] = 'owned_vehicles',
    ['qbcore-table:owned_vehicles'] = 'player_vehicles',

    ['table:vehicles'] = 'vehicles',
    ['table:vehicle_categories'] = 'vehicle_categories',
}

SV.Webhooks = {
    ['PHOTOSTOOL'] = "https://discord.com/api/webhooks/1466469500089143378/on6gxpilg6G4W0v0VuqJI8Ve9h-xSualCvNkUDlpGVKhM2wF0kgL-325SNAWrX7DVGSk",

    ['PURCHASE'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['PURCHASE_FROM_PLAYER'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['CREATE_ORDER'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['DELIVERY_ORDER'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['AUTO_DELIVERY_ORDER'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['EMPLOYEE_BONUS'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['EMPLOYEE_CHANGE_GRADE'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['EMPLOYEE_FIRE'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['EMPLOYEE_HIRE'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['WITHDRAW'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['DEPOSIT'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
    ['ANNOUNCEMENT'] = "https://discord.com/api/webhooks/1470142717697855529/f99uDxApfPUO9B442bHLGie5tRxML3vPej_DVZGfTsx72X6g_OHLnNOCjdGPhRSok109",
}

SV.WebhookText = {
    ['TITLE.PURCHASE'] = "🧾 Purchased",
    ['DESCRIPTION.PURCHASE'] = [[
        Player %s [%s] purchased vehicle %s %s (%s) in the %s - %s (%s) for %s$ by %s.
        Selected colors - Primary: %s, Secondary: %s, Pearlescent: %s.
        Plate: %s
    ]],

    ['TITLE.PURCHASE_FROM_PLAYER'] = "🧾 Purchased from player",
    ['DESCRIPTION.PURCHASE_FROM_PLAYER'] = [[
        Player %s [%s][%s] purchased vehicle %s %s (%s) from %s [%s][%s] in the %s - %s (%s) for %s$ by %s.
        Selected colors - Primary: %s, Secondary: %s, Pearlescent: %s.
        Plate: %s
    ]],
    
    ['TITLE.CREATE_ORDER'] = "📦 Create Order",
    ['DESCRIPTION.CREATE_ORDER'] = [[
        Player %s [%s] created an order for %s for %s$ in %s - %s (%s)
    ]],

    ['TITLE.DELIVERY_ORDER'] = "🏪 Delivery Order",
    ['DESCRIPTION.DELIVERY_ORDER'] = [[
        Player %s [%s] delivered order to %s - %s (%s) and recieved %s$ for deliver:
        %s
    ]],

    ['TITLE.AUTO_DELIVERY_ORDER'] = "🏪 Auto Delivery Order",
    ['DESCRIPTION.AUTO_DELIVERY_ORDER'] = [[
        Delivered order to %s - %s (%s):
        %s
    ]],

    ['TITLE.EMPLOYEE_BONUS'] = "💸 Employee Bonus",
    ['DESCRIPTION.EMPLOYEE_BONUS'] = [[
        Player %s [%s] gave a bonus to employee %s of %s$ in store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_CHANGE_GRADE'] = "👨‍💼 Employee Change Grade",
    ['DESCRIPTION.EMPLOYEE_CHANGE_GRADE'] = [[
        Player %s [%s] changed the job grade of player %s to %s in store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_FIRE'] = "❌ Employee Fire",
    ['DESCRIPTION.EMPLOYEE_FIRE'] = [[
        Player %s [%s] fired an employee %s to store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_HIRE'] = "✅ Employee Hire",
    ['DESCRIPTION.EMPLOYEE_HIRE'] = [[
        Player %s [%s] hired an employee %s (%s) to store %s - %s (%s)
    ]],

    ['TITLE.WITHDRAW'] = "💲 Withdraw",
    ['DESCRIPTION.WITHDRAW'] = [[
        Player %s [%s] withdrew $%s from store %s - %s (%s)
    ]],

    ['TITLE.DEPOSIT'] = "💲 Deposit",
    ['DESCRIPTION.DEPOSIT'] = [[
        Player %s [%s] deposit $%s from store %s - %s (%s)
    ]],
    
    ['TITLE.ANNOUNCEMENT'] = "💲 New Announcement",
    ['DESCRIPTION.ANNOUNCEMENT'] = [[
        Player %s [%s] wrote an announcement in store %s - %s (%s) with the content:
        ```%s```
    ]],
    
}

SV.Webhook = function(webhook_id, title, description, color, footer)
    local DiscordWebHook = SV.Webhooks[webhook_id]
    local embeds = {{
        ["title"] = title,
        ["type"] = "rich",
        ["description"] = description,
        ["color"] = color,
        ["footer"] = {
            ["text"] = footer..' - '..os.date(),
        },
    }}
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
end

SV.getIdentifier = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.identifier
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.citizenid
    end
end

SV.getPlayerByIdentifier = function(identifier)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromIdentifier(identifier)
    elseif Config.Core == "QB-Core" then
        local onlinePlayer = Core.Functions.GetPlayerByCitizenId(identifier)
        if onlinePlayer then
            return onlinePlayer
        end

        local offlinePlayer = Core.Player.GetOfflinePlayer(identifier)
        if offlinePlayer then
            return offlinePlayer
        end
    end
end

SV.getCharacterName = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.getName()
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
    end
end

SV.getPlayer = function(src)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromId(src)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayer(src)
    end
end

SV.isPlayerEmployee = function(xPlayer, jobName)
    if Config.Core == "ESX" then
        return xPlayer.job.name == jobName
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name == jobName
    end
end

SV.isPlayerManager = function(xPlayer, jobName)
    if Config.Core == "ESX" then
        return (xPlayer.job.name == jobName and xPlayer.job.grade_name == 'manager')
    elseif Config.Core == "QB-Core" then
        return (xPlayer.PlayerData.job.name == jobName and xPlayer.PlayerData.job.grade.level == 1)
    end
end

SV.isPlayerBoss = function(xPlayer, jobName, storeId)
    if Config.Core == "ESX" then
        return (xPlayer.job.name == jobName and xPlayer.job.grade_name == 'boss')
    elseif Config.Core == "QB-Core" then
        return (xPlayer.PlayerData.job.name == jobName and xPlayer.PlayerData.job.grade.level == 2)
    end
end

SV.getPlayerJob = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job.name
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name
    end
end

SV.setPlayerJob = function(src, xPlayer, jobName, grade, isOffline)
    if jobName then
        if Config.Core == "ESX" then
            xPlayer.setJob(jobName, grade)
        elseif Config.Core == "QB-Core" then
            if GetResourceState('qbx_core') == 'started' then
                exports['qbx_core']:SetJob(xPlayer.PlayerData.source or xPlayer.PlayerData.citizenid, jobName, grade)
            else
                xPlayer.Functions.SetJob(jobName, grade)
            end
        end
    else
        if not isOffline then
            if Config.Core == "ESX" then
                xPlayer.setJob('unemployed', 0)
            elseif Config.Core == "QB-Core" then
                if GetResourceState('qbx_core') == 'started' then
                    exports['qbx_core']:SetJob(xPlayer.PlayerData.source or xPlayer.PlayerData.citizenid, 'unemployed', 0)
                else
                    xPlayer.Functions.SetJob('unemployed')
                    xPlayer.Functions.Save()
                end
            end
        else
            if Config.Core == "ESX" then
                MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
                    ['@job'] = 'unemployed',
                    ['@job_grade'] = '0'
                })
            end
        end
    end
end

SV.getJobsOnline = function(jobName)
    if Config.Core == "ESX" then
        return #Core.GetExtendedPlayers('job', jobName)

    elseif Config.Core == "QB-Core" then
        local players, count = Core.Functions.GetPlayersOnDuty(jobName)
        return count
        
    end
end

SV.getMoney = function(xPlayer, moneyType)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType
        return xPlayer.getAccount(moneyType).money
    elseif Config.Core == "QB-Core" then
        return xPlayer.Functions.GetMoney(moneyType)
    end
end

SV.addMoney = function(xPlayer, moneyType, count)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType == 'dirty' and 'black_money' or moneyType
        xPlayer.addAccountMoney(moneyType, count)
    elseif Config.Core == "QB-Core" then
        if GetResourceState('qbx_core') == 'started' then
            if xPlayer.PlayerData.source then
                exports['qbx_core']:AddMoney(xPlayer.PlayerData.source, moneyType, count)
                exports['qbx_core']:Save(xPlayer.PlayerData.source)
            else
                xPlayer.PlayerData.money.bank = tonumber(xPlayer.PlayerData.money.bank) + count
                exports['qbx_core']:SaveOffline(xPlayer.PlayerData)
            end
        else
            xPlayer.Functions.AddMoney(moneyType, count)
            xPlayer.Functions.Save()
        end
    end
end

SV.removeMoney = function(xPlayer, moneyType, count)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType
        xPlayer.removeAccountMoney(moneyType, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.RemoveMoney(moneyType, count)
    end
end

SV.getSocietyMoney = function(societyName, cb)
    if Config.Core == "ESX" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            cb(account.money)
        end)
    elseif Config.Core == "QB-Core" then
        local society = exports['qb-banking']:GetAccountBalance(societyName)
        cb(society)
    end
end

SV.addSocietyMoney = function(societyName, amount)
    if Config.Core == "ESX" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            account.addMoney(amount)
        end)
    elseif Config.Core == "QB-Core" then
        exports['qb-banking']:AddMoney(societyName, amount)
    end
end

SV.removeSocietyMoney = function(societyName, amount)
    if Config.Core == "ESX" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            account.removeMoney(amount)
        end)
    elseif Config.Core == "QB-Core" then
        exports['qb-banking']:RemoveMoney(societyName, amount)
    end
end

SV.checkLicense = function(xPlayer, licenseName, cb)
    if not licenseName then
        return cb(true)
    end
    if Config.Core == "ESX" then
        TriggerEvent('esx_license:checkLicense', xPlayer.source, licenseName, function(hasLicense)
            if hasLicense then
                cb(true)
            else
                cb(false)
            end
        end)
        
    elseif Config.Core == "QB-Core" then
        local hasLicense = xPlayer.PlayerData.metadata['licences'][licenseName]
        cb(hasLicense)

    end
end

SV.verifyPlateNotExist = function(src, plate, cb)
    if Config.Core == "ESX" then
        MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE @plate = plate', {
            ['@plate'] = plate
        }, function (result)
            cb(result[1] ~= nil)
        end)
    elseif Config.Core == "QB-Core" then
        MySQL.Async.fetchAll('SELECT plate FROM player_vehicles WHERE @plate = plate', {
            ['@plate'] = plate
        }, function(result)
            cb(result[1] ~= nil)
        end)
    end
end

SV.formatVehicleProperties = function(data)
    return {
        ['model'] = GetHashKey(data.model), 
        ['plate'] = data.licensePlate,
        
        ['color1'] = tonumber(data.primaryColor), 
        ['color2'] = tonumber(data.secondaryColor), 
        ['pearlescentColor'] = tonumber(data.pearlescentColor) or 0, 
        ['dashboardColor'] = data.dashboardColor or 0,
        ['interiorColor'] = data.interiorColor or 0,
        ['wheelColor'] = data.wheelColor or 0,

        ['modLivery'] = data.modLivery or 0,

        ['fuelLevel'] = 100.0,
    }
end

SV.createVIN = function()
    local vmsCityhall = GetResourceState('vms_cityhall') == 'started'
    if vmsCityhall then
        return exports['vms_cityhall']:GenerateVIN()
    else
        local vin = ""
        local chars = "0123456789ABCDEFGHJKLMNPRSTUVWXYZ"
        
        for i = 1, 17 do
            local randIndex = math.random(1, #chars)
            vin = vin .. chars:sub(randIndex, randIndex)
        end
    
        local isExist = MySQL.scalar.await(("SELECT 1 FROM `%s` WHERE vin = ?"):format(
            Config.Core == "ESX" and SV.Database['esx-table:owned_vehicles'] or Config.Core == "QB-Core" and SV.Database['qbcore-table:owned_vehicles']
        ), {vin})
        if isExist then
            return SV.createVIN()
        end
    
        return vin
    end
end

---@param model: vehicle model name
---@param vehicleType: 'car' / 'plane' / 'boat'
---@param licensePlate: generated license plate
SV.addPlayerVehicle = function(xPlayer, price, model, vehicleType, licensePlate, properties, vehId, netId, spawnOnPurchase, cb)
    local myIdentifier = SV.getIdentifier(xPlayer);
    local characterName = SV.getCharacterName(xPlayer);

    -- Garages:
    local vmsGaragesV2 = GetResourceState('vms_garagesv2') == 'started'
    local qsAdvancedGarages = GetResourceState('qs-advancedgarages') == 'started'

    -- Externals:
    local mInsurance = GetResourceState('m-Insurance') == 'started'
    local vmsCityhall = GetResourceState('vms_cityhall') == 'started'

    if Config.Core == "ESX" then
        if vmsGaragesV2 then
            local query = "INSERT INTO owned_vehicles (`owner`, `plate`, `vehicle`, `vin`, `netid`, `type`, `garage`) VALUES (@owner, @plate, @vehicle, @vin, @netid, @type, @garage)"
            if vmsCityhall then
                query = "INSERT INTO owned_vehicles (`owner`, `owner_history`, `plate`, `vehicle`, `vin`, `netid`, `type`, `garage`) VALUES (@owner, @owner_history, @plate, @vehicle, @vin, @netid, @type, @garage)"
            end

            MySQL.Async.execute(query, {
                ['@owner'] = myIdentifier, 
                ['@plate'] = licensePlate, 
                ['@owner_history'] = json.encode({{name=characterName, from=tostring(os.time()), to="current", price = price}}), 
                ['@vin'] = SV.createVIN(),
                ['@netid'] = netId,
                ['@vehicle'] = json.encode(properties), 
                ['@type'] = vehicleType,
                ['@garage'] = not spawnOnPurchase and 'Impound1' or nil,
            })
        elseif qsAdvancedGarages then
            local query = "INSERT INTO owned_vehicles (`owner`, `plate`, `vehicle`, `type`, `garage`, `stored`) VALUES (@owner, @plate, @vehicle, @type, @garage, @stored)"
            if vmsCityhall then
                query = "INSERT INTO owned_vehicles (`owner`, `plate`, `owner_history`, `vin`, `vehicle`, `type`, `garage`, `stored`) VALUES (@owner, @plate, @owner_history, @vin, @vehicle, @type, @garage, @stored)"
            end

            MySQL.Async.execute(query, {
                ['@owner'] = myIdentifier, 
                ['@plate'] = licensePlate, 
                ['@owner_history'] = json.encode({{name=characterName, from=tostring(os.time()), to="current", price = price}}), 
                ['@vin'] = vmsCityhall and SV.createVIN() or nil,
                ['@vehicle'] = json.encode(properties), 
                ['@type'] = vehicleType,
                ['@garage'] = not spawnOnPurchase and 'Impound1' or nil,
                ['@stored'] = not spawnOnPurchase and 1 or 0,
            })
        else
            local query = 'INSERT INTO owned_vehicles (`owner`, `plate`, `vehicle`, `type`, `stored`) VALUES (@owner, @plate, @vehicle, @type, @stored)'
            if vmsCityhall then
                query = "INSERT INTO owned_vehicles (`owner`, `plate`, `owner_history`, `vin`, `vehicle`, `type`, `stored`) VALUES (@owner, @plate, @owner_history, @vin, @vehicle, @type, @stored)"
            end
            
            MySQL.Async.execute(query, {
                ['@owner'] = myIdentifier, 
                ['@plate'] = licensePlate, 
                ['@owner_history'] = json.encode({{name=characterName, from=tostring(os.time()), to="current", price = price}}), 
                ['@vin'] = vmsCityhall and SV.createVIN() or nil,
                ['@vehicle'] = json.encode(properties), 
                ['@type'] = vehicleType,
                ['@stored'] = not spawnOnPurchase and 1 or 0,
            })
        end

        if mInsurance then
            MySQL.Async.execute('INSERT INTO m_insurance_registration (plate, model, registration, identifier) VALUES (?, ?, ?, ?)', {licensePlate, model, 1, myIdentifier})
        end

        cb(true)
    elseif Config.Core == "QB-Core" then
        if vmsGaragesV2 then
            local query = 'INSERT INTO player_vehicles (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `vin`, `netid`, `garage`, `type`) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @vin, @netid, @garage, @type)'
            if vmsCityhall then
                query = "INSERT INTO player_vehicles (`license`, `citizenid`, `owner_history`, `vehicle`, `hash`, `mods`, `plate`, `vin`, `netid`, `garage`, `type`) VALUES (@license, @citizenid, @owner_history, @vehicle, @hash, @mods, @plate, @vin, @netid, @garage, @type)"
            end
            
            MySQL.Async.execute(query, {
                ['@license'] = xPlayer.PlayerData.license,
                ['@citizenid'] = myIdentifier,
                ['@owner_history'] = json.encode({{name=characterName, from=tostring(os.time()), to="current", price = price}}), 
                ['@vehicle'] = model,
                ['@hash'] = properties.model,
                ['@mods'] = json.encode(properties),
                ['@plate'] = licensePlate,
                ['@vin'] = SV.createVIN(),
                ['@netid'] = netId,
                ['@garage'] = not spawnOnPurchase and 'Impound1' or nil,
                ['@type'] = vehicleType,
            })
        elseif qsAdvancedGarages then
            local query = 'INSERT INTO player_vehicles (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`, `type`) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @garage, @type)'
            if vmsCityhall then
                query = "INSERT INTO player_vehicles (`license`, `citizenid`, `owner_history`, `vin`, `vehicle`, `hash`, `mods`, `plate`, `garage`, `type`) VALUES (@license, @citizenid, @owner_history, @vin, @vehicle, @hash, @mods, @plate, @garage, @type)"
            end
            
            MySQL.Async.execute(query, {
                ['@license'] = xPlayer.PlayerData.license,
                ['@citizenid'] = myIdentifier,
                ['@owner_history'] = json.encode({{name=characterName, from=tostring(os.time()), to="current", price = price}}), 
                ['@vin'] = vmsCityhall and SV.createVIN() or nil,
                ['@vehicle'] = model,
                ['@hash'] = properties.model,
                ['@mods'] = json.encode(properties),
                ['@plate'] = licensePlate,
                ['@garage'] = spawnOnPurchase and 'OUT' or '',
                ['@type'] = vehicleType,
            })
        else
            local query = 'INSERT INTO player_vehicles (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`, `state`) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @garage, @state)'
            if vmsCityhall then
                query = "INSERT INTO player_vehicles (`license`, `citizenid`, `owner_history`, `vin`, `vehicle`, `hash`, `mods`, `plate`, `garage`, `state`) VALUES (@license, @citizenid, @owner_history, @vin, @vehicle, @hash, @mods, @plate, @garage, @state)"
            end

            MySQL.Async.execute(query, {
                ['@license'] = xPlayer.PlayerData.license,
                ['@citizenid'] = myIdentifier,
                ['@owner_history'] = json.encode({{name=characterName, from=tostring(os.time()), to="current", price = price}}), 
                ['@vin'] = vmsCityhall and SV.createVIN() or nil,
                ['@vehicle'] = model,
                ['@hash'] = properties.model,
                ['@mods'] = json.encode(properties),
                ['@plate'] = licensePlate,
                ['@garage'] = spawnOnPurchase and 'OUT' or '',
                ['@state'] = not spawnOnPurchase and 1 or 0,
            })
        end

        if mInsurance then
            MySQL.Async.execute('INSERT INTO m_insurance_registration (plate, model, registration, identifier) VALUES (?, ?, ?, ?)', {licensePlate, model, 1, myIdentifier})
        end

        cb(true)
    end
end

SV.onVehicleSpawned = function(xPlayer, networkId)
    local networkId = networkId
    local vehicleId = NetworkGetEntityFromNetworkId(networkId)
    
    if GetResourceState('qs-advancedgarages') == 'started' then
        exports['qs-advancedgarages']:setVehicleToPersistent(networkId)
    end
    if GetResourceState('vms_garagesv2') == 'started' then
        exports["vms_garagesv2"]:vehiclePersistence(vehicleId, true)
    end
end

SV.checkRequiredItem = function(xPlayer, name, count, removeOnUse) -- Soon this function will be useful, stay tuned
    if Config.Core == "ESX" then
        if xPlayer.getInventoryItem(name).count >= count then
            if removeOnUse then
                xPlayer.removeInventoryItem(name, count)
            end
            return true
        end
        return false
    elseif Config.Core == "QB-Core" then
        if xPlayer.Functions.GetItemByName(name) and xPlayer.Functions.GetItemByName(name).amount >= count then
            if removeOnUse then
                xPlayer.Functions.RemoveItem(name, count)
            end
            return true
        end
        return false
    end
end

SV.addAgreementItem = function(xPlayer, playerId, name, metadata) -- Soon this function will be useful, stay tuned
    if GetResourceState("qs-inventory") ~= "missing" then
        exports['qs-inventory']:AddItem(playerId, name, 1, nil, metadata)
        
    elseif GetResourceState("ox_inventory") ~= "missing" then
        exports['ox_inventory']:AddItem(playerId, name, 1, metadata, nil)
        
    elseif GetResourceState("qb-inventory") ~= "missing" then
        exports['qb-inventory']:AddItem(playerId, name, 1, nil, metadata)
        
    elseif GetResourceState("core_inventory") ~= "missing" then
        exports['core_inventory']:addItem(('primary-%s'):format((Config.Core == "ESX" and xPlayer.identifier or xPlayer.PlayerData.identifier):gsub(':','')), name, 1, metadata, 'content')
        
    end
end

SV.registerAgreementItem = function(cb) -- Soon this function will be useful, stay tuned
    if GetResourceState("qs-inventory") ~= "missing" then
        exports['qs-inventory']:CreateUsableItem(Config.AgreementItem, function(source, item)
            cb(item.info)
        end)
    elseif GetResourceState("ox_inventory") ~= "missing" then
        
    elseif GetResourceState("qb-inventory") ~= "missing" then
        QBCore.Functions.CreateUseableItem(Config.AgreementItem, function(source, item)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            if Player.Functions.GetItemByName(item.name) then
                cb(item.info)
            end
        end)
    elseif GetResourceState("core_inventory") ~= "missing" then
        
    else
        print("[^1INFORMATION^7] Your inventory is not supported to give agreement item, if you are using inventory with metadata, provide it in SV.addAgreementItem & SV.registerAgreementItem (config.server.lua).")
        print("If you use public paid or free inventory, we will be glad when you let us know so that we can add compatibility.")
    end
end

Citizen.CreateThread(function() -- Registration esx_society
    Citizen.Wait(1000)
    if not Config.UseBuildInCompanyBalance and not Config.RemoveBalanceFromMenu then
        for k, v in pairs(Config.Stores) do
            if v.jobName and v.societyName then
                TriggerEvent('esx_society:registerSociety', v.jobName, v.jobName, v.societyName, v.societyName, v.societyName, {type = 'public'})
            end
        end
    end
end)