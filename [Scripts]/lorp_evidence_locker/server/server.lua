lib.locale()

local ESX = exports.es_extended:getSharedObject()

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    MySQL.query('SELECT stash_name, name, locker FROM police_lockers', {}, function(results)
        if results and #results > 0 then
            for _, stash in ipairs(results) do
                local locker = Config.EvidenceLockers[stash.locker]
                local slots = locker and locker.stashSlots or 20
                local weight = locker and locker.stashWeight or 500000
                exports.ox_inventory:RegisterStash(stash.stash_name, stash.name, slots, weight, false)
            end
            print('^2[Evidence] Loaded ' .. #results .. ' evidence lockers from database.^0')
        else
            print('^3[Evidence] No evidence lockers found in database.^0')
        end
    end)
end)

local function generateStashName(name)
    local cleanedName = name:gsub("%s+", "_"):gsub("[^%w_]", ""):lower()
    return 'police_locker_' .. cleanedName
end

local function getPlayerJobAndGrade(source)
    local player = ESX.GetPlayerFromId(source)

    if not player or not player.job then
        return nil, 0
    end

    local job = player.job.name or nil
    local grade = job and player.job.grade or 0

    return job, grade
end

local playerCooldowns = {}

RegisterNetEvent('lorp_evidence_locker:create')
AddEventHandler('lorp_evidence_locker:create', function(lockerName, name)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    local stashName = generateStashName(name)

    if playerCooldowns[src] and (os.time() - playerCooldowns[src]) < 10 then
        lib.notify(src, { type = 'error', description = locale('stash_wait') })
        return
    end

    playerCooldowns[src] = os.time()

    if #stashName < 5 or #stashName > 50 then
        lib.notify(src, { type = 'error', description = locale('invalid_stash_name') })
        return
    end

    MySQL.scalar('SELECT stash_name FROM police_lockers WHERE stash_name = ?', { stashName }, function(result)
        if result then
            lib.notify(src, { type = 'error', description = locale('stash_exists') })
        else
            MySQL.insert('INSERT INTO police_lockers (name, stash_name, locker) VALUES (?, ?, ?)', { name, stashName, lockerName }, function()
                exports.ox_inventory:RegisterStash(stashName, name, locker.stashSlots, locker.stashWeight, false)
                lib.notify(src, { type = 'success', description = locale('stash_created') .. ' ' .. name })
                exports.fmsdk:Log("Inventory", "info", "Evidence Created", {
                    playerSource = src,
                    playerName = GetPlayerName(src),
                    playerJob = job,
                    playerJobGrade = grade,
                    stashName = stashName,
                })
            end)
        end
    end)
end)

RegisterNetEvent('lorp_evidence_locker:search')
AddEventHandler('lorp_evidence_locker:search', function(lockerName, name)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    local stashName = generateStashName(name)

    MySQL.scalar('SELECT stash_name FROM police_lockers WHERE stash_name = ? AND locker = ?', { stashName, lockerName }, function(result)
        if result then
            TriggerClientEvent('ox_inventory:openInventory', src, 'stash', stashName)
            exports.fmsdk:Log("Inventory", "info", "Evidence Searched", {
                playerSource = src,
                playerName = GetPlayerName(src),
                playerJob = job,
                playerJobGrade = grade,
                stashName = stashName,
            })
        else
            lib.notify(src, { type = 'error', description = locale('stash_not_found') })
        end
    end)
end)

RegisterNetEvent('lorp_evidence_locker:showAll')
AddEventHandler('lorp_evidence_locker:showAll', function(lockerName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    MySQL.query('SELECT name, stash_name FROM police_lockers WHERE locker = ?', { lockerName }, function(results)
        if #results > 0 then
            TriggerClientEvent('lorp_evidence_locker:openMenu', src, lockerName, results)
        else
            lib.notify(src, { type = 'info', description = locale('no_stashes') })
        end
    end)
end)

RegisterNetEvent('lorp_evidence_locker:clearMenu')
AddEventHandler('lorp_evidence_locker:clearMenu', function(lockerName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    if grade < locker.clearRank then
        lib.notify(src, { type = 'error', description = locale('no_access_clear') })
        return
    end

    MySQL.query('SELECT name, stash_name FROM police_lockers WHERE locker = ?', { lockerName }, function(results)
        if #results > 0 then
            TriggerClientEvent('lorp_evidence_locker:openClearMenu', src, lockerName, results)
        else
            lib.notify(src, { type = 'info', description = locale('no_stashes') })
        end
    end)
end)

RegisterNetEvent('lorp_evidence_locker:confirmClear')
AddEventHandler('lorp_evidence_locker:confirmClear', function(lockerName, stashName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    if grade < locker.clearRank then
        lib.notify(src, { type = 'error', description = locale('no_access_clear') })
        return
    end

    TriggerClientEvent('lorp_evidence_locker:confirmClear', src, lockerName, stashName)
end)

RegisterNetEvent('lorp_evidence_locker:clear')
AddEventHandler('lorp_evidence_locker:clear', function(lockerName, stashName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    if grade < locker.clearRank then
        lib.notify(src, { type = 'error', description = locale('no_access_clear') })
        return
    end

    local items = exports.ox_inventory:GetInventoryItems(stashName)
    exports.ox_inventory:ClearInventory(stashName)
    lib.notify(src, { type = 'success', description = locale('stash_cleared') })
    exports.fmsdk:Log("Inventory", "info", "Evidence Cleared", {
        playerSource = src,
        playerName = GetPlayerName(src),
        playerJob = job,
        playerJobGrade = grade,
        stashName = stashName,
        stashItems = items,
    })
end)


RegisterNetEvent('lorp_evidence_locker:deleteMenu')
AddEventHandler('lorp_evidence_locker:deleteMenu', function(lockerName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    if grade < locker.deleteRank then
        lib.notify(src, { type = 'error', description = locale('no_access_delete') })
        return
    end

    MySQL.query('SELECT name, stash_name FROM police_lockers WHERE locker = ?', { lockerName }, function(results)
        if #results > 0 then
            TriggerClientEvent('lorp_evidence_locker:openDeleteMenu', src, lockerName, results)
        else
            lib.notify(src, { type = 'info', description = locale('no_stashes') })
        end
    end)
end)

RegisterNetEvent('lorp_evidence_locker:confirmDelete')
AddEventHandler('lorp_evidence_locker:confirmDelete', function(lockerName, stashName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    if grade < locker.deleteRank then
        lib.notify(src, { type = 'error', description = locale('no_access_delete') })
        return
    end

    TriggerClientEvent('lorp_evidence_locker:confirmDelete', src, lockerName, stashName)
end)

RegisterNetEvent('lorp_evidence_locker:delete')
AddEventHandler('lorp_evidence_locker:delete', function(lockerName, stashName)
    local src = source
    local job, grade = getPlayerJobAndGrade(src)
    local locker = Config.EvidenceLockers[lockerName]

    if not locker or job ~= lockerName then
        lib.notify(src, { type = 'error', description = locale('no_access_job') })
        return
    end

    if grade < locker.deleteRank then
        lib.notify(src, { type = 'error', description = locale('no_access_delete') })
        return
    end

    MySQL.execute('DELETE FROM police_lockers WHERE stash_name = ? AND locker = ?', { stashName, lockerName }, function(data)
        if data.affectedRows > 0 then
            local items = exports.ox_inventory:GetInventoryItems(stashName)
            exports.ox_inventory:ClearInventory(stashName)
            lib.notify(src, { type = 'success', description = locale('stash_deleted') })
            exports.fmsdk:Log("Inventory", "info", "Evidence Deleted", {
                playerSource = src,
                playerName = GetPlayerName(src),
                playerJob = job,
                playerJobGrade = grade,
                stashName = stashName,
                stashItems = items,
            })
        else
            lib.notify(src, { type = 'error', description = locale('stash_not_found') })
        end
    end)
end)

local function IsPlayerLawEnforcement(source)
    local job, grade = getPlayerJobAndGrade(source)
    local lockerData = Config.EvidenceLockers[job]

    return lockerData and lockerData.takeRank <= grade or false
end

local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    if payload.action == 'move' and payload.toInventory == payload.source then
        return IsPlayerLawEnforcement(payload.source)
    elseif payload.action == 'swap' then
        return IsPlayerLawEnforcement(payload.source)
    end
end, {
    print = true,
    --[[itemFilter = {
        example_item = true,
    },]]
    inventoryFilter = {
        '^police_locker_[%w]+',
    }
})