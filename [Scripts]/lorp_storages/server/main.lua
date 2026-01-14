local ox_inventory = exports.ox_inventory

local function GenerateStashId(identifier)
    local shortId = string.sub(identifier:gsub(":", "_"), -10)
    local randomNum = math.random(1000, 9999)
    return Config.Stash.prefix .. shortId .. "_" .. randomNum
end

local function RegisterFrameworkCallbacks()
    Framework.RegisterCallback('lorp_storage:server:checkOwnership', function(source, cb)
        local player = Framework.GetPlayer(source)
        local identifier = Framework.GetPlayerIdentifier(player)

        if not identifier then
            cb(false, nil)
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `owner` = ?', {
            identifier
        }, function(result)
            if result and #result > 0 then
                cb(true, result[1])
            else
                cb(false, nil)
            end
        end)
    end)

    Framework.RegisterCallback('lorp_storage:server:getStorageUnits', function(source, cb)
        local player = Framework.GetPlayer(source)
        local identifier = Framework.GetPlayerIdentifier(player)

        if not player or not identifier then
            cb({}, "Player not found")
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `owner` = ?', {
            identifier
        }, function(result)
            if result and #result > 0 then
                for i, unit in ipairs(result) do
                    if not unit.stash_id or unit.stash_id == "" then
                        local stashId = GenerateStashId(identifier)
                        MySQL.Async.execute('UPDATE `'..Config.TableName..'` SET `stash_id` = ? WHERE `id` = ?', {
                            stashId,
                            unit.id
                        })
                        result[i].stash_id = stashId
                    end
                    result[i].stashId = result[i].stash_id
                end
                cb(result)
            else
                cb({})
            end
        end)
    end)
end

CreateThread(function()
    RegisterFrameworkCallbacks()
end)

local function GetNextUpgradeLevel(currentLevel)
    for i, level in ipairs(Config.UpgradeLevels) do
        if level.level == currentLevel + 1 then
            return level
        end
    end

    return nil
end

RegisterNetEvent('lorp_storage:server:upgradeStorage')
AddEventHandler('lorp_storage:server:upgradeStorage', function(stashId)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `stash_id` = ? AND `owner` = ?', {
        stashId,
        identifier
    }, function(result)
        if result and #result > 0 then
            local storageData = result[1]
            local currentLevel = storageData.level or 1
            local nextLevel = GetNextUpgradeLevel(currentLevel)
            if nextLevel then
                local cash = ox_inventory:Search(src, 'count', 'money')

                if cash >= nextLevel.price then
                    ox_inventory:RemoveItem(src, 'money', nextLevel.price)
                    MySQL.Async.execute('UPDATE `'..Config.TableName..'` SET `capacity` = ?, `weight` = ?, `level` = ? WHERE `stash_id` = ?', {
                        nextLevel.slots,
                        nextLevel.weight,
                        nextLevel.level,
                        stashId
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            ox_inventory:RegisterStash(stashId, storageData.label, nextLevel.slots, nextLevel.weight * 1000, identifier)
                            Framework.Notify(src, 'Storage Upgraded', 'Storage upgraded to level ' .. nextLevel.level .. ' (' .. nextLevel.slots .. ' slots, ' .. nextLevel.weight .. 'kg)', 'success')
                            TriggerClientEvent('lorp_storage:client:refreshStorageUI', src)
                        end
                    end)
                else
                    Framework.Notify(src, 'Insufficient Funds', 'You need $' .. nextLevel.price .. ' to upgrade your storage', 'error')
                end
            else
                Framework.Notify(src, 'Maximum Level', 'Your storage is already at maximum level', 'error')
            end
        else
            Framework.Notify(src, 'Error', 'You do not own this storage unit', 'error')
        end
    end)
end)

RegisterNetEvent('lorp_storage:server:purchaseStorage')
AddEventHandler('lorp_storage:server:purchaseStorage', function(label, icon, locationIndex)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    local price = Config.StorageUnit.price
    if Config.LocationSettings.enableLocationSpecificPricing and locationIndex and Config.LocationSettings.locationPriceMultipliers[locationIndex] then
        price = math.floor(Config.StorageUnit.price * Config.LocationSettings.locationPriceMultipliers[locationIndex])
    end

    local cash = ox_inventory:Search(src, 'count', 'money')

    if cash >= price then
        ox_inventory:RemoveItem(src, 'money', price)
        local stashId = GenerateStashId(identifier)
        local initialLevel = Config.UpgradeLevels[1]
        MySQL.Async.execute('INSERT INTO `'..Config.TableName..'` (`owner`, `stash_id`, `label`, `capacity`, `weight`, `level`, `icon`, `shared_access`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            identifier,
            stashId,
            label or Config.StorageUnit.label,
            initialLevel.slots,
            initialLevel.weight,
            initialLevel.level,
            icon or Config.StorageUnit.icon,
            json.encode({})
        }, function(rowsChanged)
            if rowsChanged > 0 then
                ox_inventory:RegisterStash(stashId, label or Config.StorageUnit.label, initialLevel.slots, initialLevel.weight * 1000, identifier)
                Framework.Notify(src, 'Storage Purchased', 'You purchased a new storage unit for $' .. price, 'success')
                TriggerClientEvent('lorp_storage:client:refreshStorageUI', src)
            end
        end)
    else
        Framework.Notify(src, 'Insufficient Funds', 'You need $' .. price .. ' to purchase a storage unit', 'error')
    end
end)

RegisterNetEvent('lorp_storage:server:openStorage')
AddEventHandler('lorp_storage:server:openStorage', function(stashId)
    local src = source

    if not stashId then
        Framework.Notify(src, 'Error', 'Storage ID not found', 'error')
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `stash_id` = ?', {stashId}, function(result)
        if result and #result > 0 then
            local storage = result[1]
            local label = storage.label or "Storage Unit"
            local slots = storage.capacity or Config.StorageUnit.capacity
            local weight = storage.weight or Config.StorageUnit.weight
            ox_inventory:RegisterStash(stashId, label, slots, weight * 1000, nil)
            ox_inventory:forceOpenInventory(src, 'stash', stashId)
        else
            Framework.Notify(src, 'Error', 'Storage not found in database', 'error')
        end
    end)
end)


RegisterNetEvent('lorp_storage:server:openStorageManagement')
AddEventHandler('lorp_storage:server:openStorageManagement', function(stashId)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `stash_id` = ? AND `owner` = ?', {
        stashId,
        identifier
    }, function(result)
        if result and #result > 0 then
            local storageData = result[1]
            local currentLevel = storageData.level or 1
            local nextLevel = GetNextUpgradeLevel(currentLevel)

            TriggerClientEvent('lorp_storage:client:openStorageManagement', src, {
                stashId = stashId,
                label = storageData.label,
                icon = storageData.icon,
                capacity = storageData.capacity,
                weight = storageData.weight,
                level = currentLevel,
                nextLevel = nextLevel,
                sharedAccess = json.decode(storageData.shared_access or '[]')
            })
        else
            Framework.Notify(src, 'Error', 'You do not own this storage unit', 'error')
        end
    end)
end)

RegisterNetEvent('lorp_storage:server:renameStorage')
AddEventHandler('lorp_storage:server:renameStorage', function(stashId, newLabel)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    MySQL.Async.execute('UPDATE `'..Config.TableName..'` SET `label` = ? WHERE `stash_id` = ? AND `owner` = ?', {
        newLabel,
        stashId,
        identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            Framework.Notify(src, 'Storage Unit', 'Storage unit renamed to ' .. newLabel, 'success')
            TriggerClientEvent('lorp_storage:client:refreshStorageUI', src)
        else
            Framework.Notify(src, 'Error', 'Failed to rename storage unit', 'error')
        end
    end)
end)


RegisterNetEvent('lorp_storage:server:changeIcon')
AddEventHandler('lorp_storage:server:changeIcon', function(stashId, icon)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    MySQL.Async.execute('UPDATE `'..Config.TableName..'` SET `icon` = ? WHERE `stash_id` = ? AND `owner` = ?', {
        icon,
        stashId,
        identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            Framework.Notify(src, 'Storage Unit', 'Storage icon updated successfully', 'success')
            TriggerClientEvent('lorp_storage:client:refreshStorageUI', src)
        else
            Framework.Notify(src, 'Error', 'Failed to update storage icon', 'error')
        end
    end)
end)

RegisterNetEvent('lorp_storage:server:shareAccess')
AddEventHandler('lorp_storage:server:shareAccess', function(stashId, playerId)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)
    local targetPlayer = Framework.GetPlayer(playerId)
    local targetIdentifier = Framework.GetPlayerIdentifier(targetPlayer)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    if not targetPlayer or not targetIdentifier then
        Framework.Notify(src, 'Error', 'Target player not found', 'error')
        TriggerClientEvent('lorp_storage:client:shareAccessResponse', src, {
            success = false,
            message = 'Target player not found'
        })
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `stash_id` = ? AND `owner` = ?', {
        stashId,
        identifier
    }, function(result)
        if result and #result > 0 then
            local storageData = result[1]
            local sharedAccess = json.decode(storageData.shared_access or '{}')

            local hasAccess = false
            for _, access in pairs(sharedAccess) do
                if access.identifier == targetIdentifier then
                    hasAccess = true
                    break
                end
            end

            if not hasAccess then
                table.insert(sharedAccess, {
                    identifier = targetIdentifier,
                    name = Framework.GetPlayerName(playerId)
                })

                MySQL.Async.execute('UPDATE `'..Config.TableName..'` SET `shared_access` = ? WHERE `stash_id` = ?', {
                    json.encode(sharedAccess),
                    stashId
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        Framework.Notify(src, 'Storage', 'Access granted to player ' .. Framework.GetPlayerName(playerId), 'success')
                        TriggerClientEvent('lorp_storage:client:shareAccessResponse', src, {
                            success = true,
                            message = 'Access granted to player ' .. Framework.GetPlayerName(playerId)
                        })
                        TriggerClientEvent('lorp_storage:client:updateSharedAccess', src, stashId, sharedAccess)
                    else
                        Framework.Notify(src, 'Error', 'Failed to share access', 'error')
                    end
                end)
            else
                Framework.Notify(src, 'Error', 'Player already has access to this storage', 'error')
            end
        else
            Framework.Notify(src, 'Error', 'You do not own this storage unit', 'error')
        end
    end)
end)

RegisterNetEvent('lorp_storage:server:removeAccess')
AddEventHandler('lorp_storage:server:removeAccess', function(stashId, targetIdentifier)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `stash_id` = ? AND `owner` = ?', {
        stashId,
        identifier
    }, function(result)
        if result and #result > 0 then
            local storageData = result[1]
            local sharedAccess = json.decode(storageData.shared_access or '{}')
            local newSharedAccess = {}
            local removed = false

            for _, access in pairs(sharedAccess) do
                if access.identifier ~= targetIdentifier then
                    table.insert(newSharedAccess, access)
                else
                    removed = true
                end
            end

            if removed then
                MySQL.Async.execute('UPDATE `'..Config.TableName..'` SET `shared_access` = ? WHERE `stash_id` = ?', {
                    json.encode(newSharedAccess),
                    stashId
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        Framework.Notify(src, 'Storage Unit', 'Access removed successfully', 'success')
                        TriggerClientEvent('lorp_storage:client:updateSharedAccess', src, stashId, newSharedAccess)
                    else
                        Framework.Notify(src, 'Error', 'Failed to remove access', 'error')
                    end
                end)
            else
                Framework.Notify(src, 'Error', 'Player does not have access to this storage', 'error')
            end
        else
            Framework.Notify(src, 'Error', 'You do not own this storage unit', 'error')
        end
    end)
end)

RegisterNetEvent('lorp_storage:server:getSharedAccess')
AddEventHandler('lorp_storage:server:getSharedAccess', function(stashId)
    local src = source
    local player = Framework.GetPlayer(src)
    local identifier = Framework.GetPlayerIdentifier(player)

    if not player or not identifier then
        Framework.Notify(src, 'Error', 'Player not found', 'error')
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM `'..Config.TableName..'` WHERE `stash_id` = ? AND `owner` = ?', {
        stashId,
        identifier
    }, function(result)
        if result and #result > 0 then
            local storageData = result[1]
            local sharedAccess = json.decode(storageData.shared_access or '{}')
            TriggerClientEvent('lorp_storage:client:updateSharedAccess', src, stashId, sharedAccess)
        else
            Framework.Notify(src, 'Error', 'You do not own this storage unit', 'error')
        end
    end)
end)