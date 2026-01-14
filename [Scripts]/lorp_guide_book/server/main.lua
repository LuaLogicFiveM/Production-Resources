local ESX = exports.es_extended:getSharedObject()

local function isAdmin(source)
    local Player = ESX.GetPlayerFromId(source)
    return Player and Config.AdminGroups[Player.getGroup()]
end

local function hasEditPermission(Player)
    if not Player then return false end
    if isAdmin(Player.source) then return true end
    local job = Player.job
    local requiredGrade = Config.EditPermissions[job.name]
    return requiredGrade and job.grade.level >= requiredGrade
end

local function openBook(source, bookType, bookTitle, allowedJob)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if not Player then return end

    if allowedJob and Player.job.name ~= allowedJob then
        return lib.notify(src, {title = 'Guide Book', description = 'You do not have permissions', type = 'error', position = 'top'})
    end

    local query = "SELECT id, category, content, priority, deletable FROM guidebook_pages WHERE book_type = ? ORDER BY priority ASC"
    MySQL.Async.fetchAll(query, {bookType}, function(pages)
        if GetPlayerName(src) then
            if not pages or #pages == 0 then pages = {} end
            TriggerClientEvent('ap_guidebook:client:openBook', src, {
                pages = pages,
                canEdit = hasEditPermission(Player),
                bookTitle = bookTitle,
                bookType = bookType
            })
        end
    end)
end

--- config commands and items
if Config.EnableCommands.guidebook then RegisterCommand('guidebook', function(source) openBook(source, 'warga', Config.BookTitles.warga, nil) end, false) end
if Config.EnableCommands.policebook then RegisterCommand('bcso', function(source) openBook(source, 'police', Config.BookTitles.police, 'police') end, false) end
if Config.EnableCommands.ambulancebook then RegisterCommand('ems', function(source) openBook(source, 'ambulance', Config.BookTitles.ambulance, 'ambulance') end, false) end
if Config.EnableCommands.mechbook then RegisterCommand('mechmanual', function(source) openBook(source, 'mechanic', Config.BookTitles.mechanic, 'mechanic') end, false) end
if Config.EnableCommands.pemkotbook then RegisterCommand('pemkotmanual', function(source) openBook(source, 'government', Config.BookTitles.government, 'government') end, false) end

--if Config.EnableItems.guidebook then QBCore.Functions.CreateUseableItem('guidebook', function(source, item) local P = ESX.GetPlayerFromId(source) if P.Functions.GetItemByName(item.name) then openBook(source, 'warga', Config.BookTitles.warga, nil) end end) end
--if Config.EnableItems.police_sop_book then QBCore.Functions.CreateUseableItem('police_sop_book', function(source, item) local P = ESX.GetPlayerFromId(source) if P.Functions.GetItemByName(item.name) then if P.PlayerData.job.name == 'police' then openBook(source, 'police', Config.BookTitles.police, 'police') else TriggerClientEvent('QBCore:Notify', source, "Anda tidak bisa memahami isi buku ini.", "error") end end end) end
--if Config.EnableItems.ambulance_sop_book then QBCore.Functions.CreateUseableItem('ambulance_sop_book', function(source, item) local P = ESX.GetPlayerFromId(source) if P.Functions.GetItemByName(item.name) then if P.PlayerData.job.name == 'ambulance' then openBook(source, 'ambulance', Config.BookTitles.ambulance, 'ambulance') else TriggerClientEvent('QBCore:Notify', source, "Anda tidak bisa memahami isi buku ini.", "error") end end end) end
--if Config.EnableItems.mechanic_manual then QBCore.Functions.CreateUseableItem('mechanic_manual', function(source, item) local P = ESX.GetPlayerFromId(source) if P.Functions.GetItemByName(item.name) then if P.PlayerData.job.name == 'mechanic' then openBook(source, 'mechanic', Config.BookTitles.mechanic, 'mechanic') else TriggerClientEvent('QBCore:Notify', source, "Anda tidak bisa memahami isi buku ini.", "error") end end end) end
--if Config.EnableItems.government_rules then QBCore.Functions.CreateUseableItem('government_rules', function(source, item) local P = ESX.GetPlayerFromId(source) if P.Functions.GetItemByName(item.name) then if P.PlayerData.job.name == 'government' then openBook(source, 'government', Config.BookTitles.government, 'government') else TriggerClientEvent('QBCore:Notify', source, "Anda tidak bisa memahami isi buku ini.", "error") end end end) end

-- --- Server Callbacks ---
ESX.RegisterServerCallback('ap_guidebook:server:savePage', function(source, cb, data)
    local Player = ESX.GetPlayerFromId(source)
    if not Player or not hasEditPermission(Player) then return cb({success = false}) end
    MySQL.Async.execute("UPDATE guidebook_pages SET content = ? WHERE id = ?", {data.newContent, data.pageId}, function(rows) cb({success = rows > 0}) end)
end)
ESX.RegisterServerCallback('ap_guidebook:server:addCategory', function(source, cb, data)
    local Player = ESX.GetPlayerFromId(source)
    if not Player or not hasEditPermission(Player) then return cb({success = false}) end
    local params = {data.bookType, data.categoryName, '<p>Halaman ini masih kosong. Silakan isi.</p>', 99, 1}
    MySQL.Async.insert("INSERT INTO guidebook_pages (book_type, category, content, priority, deletable) VALUES (?, ?, ?, ?, ?)", params, function(id)
        cb({success = id ~= nil, newPageId = id})
    end)
end)
ESX.RegisterServerCallback('ap_guidebook:server:removeCategory', function(source, cb, data)
    local Player = ESX.GetPlayerFromId(source)
    if not Player or not hasEditPermission(Player) then return cb({success = false}) end
    MySQL.Async.execute("DELETE FROM guidebook_pages WHERE id = ?", {data.pageId}, function(rows) cb({success = rows > 0}) end)
end)

--exports----

exports('openBookForPlayer', function(targetSource, bookType, categoryName)
    local Player = ESX.GetPlayerFromId(targetSource)
    if not Player then return end
    if not Config.BookTitles[bookType] then return end
    local bookTitle = Config.BookTitles[bookType]
    MySQL.Async.fetchAll("SELECT id, category, content, priority, deletable FROM guidebook_pages WHERE book_type = ? ORDER BY priority ASC", {bookType}, function(pages)
        if GetPlayerName(targetSource) then
            if not pages or #pages == 0 then pages = {} end
            TriggerClientEvent('ap_guidebook:client:openBook', targetSource, {
                pages = pages, canEdit = hasEditPermission(Player), bookTitle = bookTitle,
                bookType = bookType, startCategory = categoryName
            })
        end
    end)
end)