SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

local duplicateTimeout = {}
local playerProps = {}

AddEventHandler('playerDropped', function()
    duplicateTimeout[tostring(source)] = nil
end)

local function updateNotebookPageContent(bookId, bookPageNumber, bookKeyToSave, dataToSave)
    local query = ""

    if bookKeyToSave == "content" then
        query = "UPDATE notebook_pages SET content = ? WHERE notebook_id = ? AND page_number = ?"
        dataToSave = json.encode(dataToSave)
    elseif bookKeyToSave == "images" then
        query = "UPDATE notebook_pages SET images = ? WHERE notebook_id = ? AND page_number = ?"
        dataToSave = json.encode(dataToSave)
    elseif bookKeyToSave == "drawing" then
        query = "UPDATE notebook_pages SET drawing = ? WHERE notebook_id = ? AND page_number = ?"
    end

    if not query then
        return false, "Invalid key to save"
    end

    return MySQL.update.await(query, { dataToSave, bookId, bookPageNumber })
end

lib.callback.register("prp-notebook:server:saveNotebookMetadata", function(source, data)
    local bookId = data.id
    local bookTitle = data.title
    local bookColor = data.color
    local itemId = data.itemId

    lib.print.debug("Saving notebook metadata", bookId, bookTitle, bookColor, itemId)
    if not bookId or not bookTitle or not bookColor then
        lib.print.debug("Failed to save notebook metadata due to missing parameters", bookId, bookTitle, bookColor, itemId)
        return false
    end

    local success = exports.oxmysql:update_async(
        "UPDATE notebooks SET title = ?, color = ? WHERE id = ?",
        { bookTitle, bookColor, bookId }
    )

    if not success then
        lib.print.debug("Failed to save notebook metadata", bookId, bookTitle, bookColor, itemId)
        return false
    end

    if itemId then
        bridge.inv.setItemMetaDataKey(
            source,
            itemId,
            "label",
            bookTitle
        )
    end

    return true
end)

lib.callback.register("prp-notebook:server:saveNotebookPageContent", function(source, data)
    local bookId = data.id
    local bookPageNumber = data.pageNumber
    local keyToSave = data.keyToSave
    local dataToSave = data.dataToSave

    if not bookId or not bookPageNumber or not keyToSave then
        return false
    end

    local success = updateNotebookPageContent(bookId, bookPageNumber, keyToSave, dataToSave)

    return success
end)

lib.callback.register("prp-notebook:server:saveNotebookPage", function(source, data)
    local bookId = data.id
    local bookPageNumber = data.pageNumber
    local bookPageContent = data.content
    local bookPageImages = data.images
    local bookPageDrawing = data.drawing

    if not bookId or not bookPageNumber then
        return false
    end

    local success = MySQL.insert.await(
        "INSERT INTO notebook_pages (notebook_id, page_number, content, images, drawing) VALUES (?, ?, ?, ?, ?)",
        { bookId, bookPageNumber, json.encode(bookPageContent), json.encode(bookPageImages), bookPageDrawing }
    )

    return success
end)

lib.callback.register("prp-notebook:server:loadNotebookPages", function(source, data)
    local bookId = data.id
    local pagesLength = data.pages

    local notebookPages = MySQL.query.await(
        "SELECT page_number as number, content, images, drawing FROM notebook_pages WHERE notebook_id = ? LIMIT 10 OFFSET ?",
        { bookId, pagesLength }
    )

    for i = 1, #notebookPages do
        notebookPages[i].content = json.decode(notebookPages[i].content)
        notebookPages[i].images = json.decode(notebookPages[i].images)
    end

    return notebookPages
end)

lib.callback.register("prp-notebook:server:addPage", function(source, data)
    local bookId = data.bookId

    if not bookId then
        return false, "No book id"
    end

    local lastPageNumber = MySQL.scalar.await(
        "SELECT MAX(page_number) FROM notebook_pages WHERE notebook_id = ?",
        { bookId }
    )

    if not lastPageNumber then
        return false, "Failed to add a page"
    end

    local success = MySQL.insert.await(
        "INSERT INTO notebook_pages (notebook_id, page_number, content, images, drawing) VALUES (?, ?, ?, ?, ?)",
        { bookId, lastPageNumber + 1, json.encode({}), json.encode({}), "" }
    )

    if not success then
        return false, "Failed to add a page"
    end

    return true
end)

lib.callback.register("prp-notebook:server:removePage", function(source, data)
    local bookId = data.bookId
    local pageNumber = data.pageNumber

    if not bookId or not pageNumber then
        return false
    end

    local success = MySQL.query.await(
        "DELETE FROM notebook_pages WHERE notebook_id = ? AND page_number = ?",
        { bookId, pageNumber }
    )

    return success
end)

---@param url string
---@return boolean
local function isValidImageUrl(url)
    if type(url) ~= "string" or url == "" then
        return false
    end

    local host, path = url:match("^https://([^/]+)(/.*)$")
    if not host or not path then
        return false
    end

    local extension = path:match("%.(%w+)%s*$")
    if not extension then
        extension = ""
    else
        extension = extension:lower()
    end

    local validExtensions = { png = true, jpg = true, jpeg = true, gif = true, webp = true, svg = true, bmp = true }
    if extension ~= "" and not validExtensions[extension] then
        return false
    end

    local allowedDomains = Config.AllowedImageDomains
    if not allowedDomains or #allowedDomains == 0 then
        return true
    end

    host = host:lower()
    for i = 1, #allowedDomains do
        local domain = allowedDomains[i]:lower()
        if host == domain or host:sub(-#domain - 1) == "." .. domain then
            return true
        end
    end

    return false
end

lib.callback.register("prp-notebook:server:checkImageUrl", function(source, data)
    return isValidImageUrl(data)
end)

function DuplicateNotebook(source, data)
    if duplicateTimeout[tostring(source)] and os.time() - duplicateTimeout[tostring(source)] < 5 then
        return false, "Slow down, please"
    end

    duplicateTimeout[tostring(source)] = os.time()

    local itemId = data.itemId

    local owner = bridge.fw.getIdentifier(source)

    local notebook = MySQL.single.await("SELECT id, title, color FROM notebooks WHERE id = ?", { itemId })

    if not notebook then
        return false, "Notebook not found"
    end

    local notebookPages = MySQL.query.await(
        "SELECT page_number, content, images, drawing FROM notebook_pages WHERE notebook_id = ?", { notebook.id })


    local id = MySQL.insert.await(
        "INSERT INTO notebooks (title, color, owner) VALUES (?, ?, ?)",
        { notebook.title, notebook.color, owner })

    if not id then
        return false, "Failed to duplicate notebook"
    end

    local transactionQuery = {}
    for i = 1, #notebookPages do
        local page = notebookPages[i]

        table.insert(transactionQuery,
            { 'INSERT INTO notebook_pages (notebook_id, page_number, content, images, drawing) VALUES (?, ?, ?, ?, ?)', { id, page.page_number, page.content, page.images, page.drawing } })
    end


    local result = MySQL.transaction.await(transactionQuery)

    if not result then
        return false, "Failed to duplicate notebook"
    end

    local success = bridge.inv.giveItem(source, Config.Item, 1,
        { id = id, label = notebook.title })

    if not success then
        return false, "Failed to duplicate notebook"
    end

    return id
end
exports("DuplicateNotebook", DuplicateNotebook)

local function handleNotebookDuplication(slot)
    local src = source
    lib.print.debug('trying to duplicate notebook with slot', slot)

    local item = bridge.inv.getSlot(src, slot)
    if not item or not item.metadata or not item.metadata.id then
        lib.print.debug("Invalid notebook item for duplication", item)
        return false, "Invalid notebook item"
    end

    local success, result = DuplicateNotebook(src, { itemId = item.metadata.id })
    if not success then
        lib.print.debug("Failed to duplicate notebook", result)
        bridge.fw.notify(src, 'error', result)
        return false, result
    end

    return true
end
RegisterNetEvent("prp-notebook:server:duplicateNotebook", handleNotebookDuplication)

function RegisterNotebook()
    bridge.fw.registerItemUse(Config.Item, function(source, data)
        lib.print.debug("Using notebook item with data", json.encode(data, { indent = true }))
        if data.metaData.id then
            local isCached = lib.callback.await("prp-notebook:client:checkNotebookCache", source, data.metaData.id)

            local notebookData = {}

            if isCached then
                notebookData = data.metaData.id
                goto skip
            end

            notebookData = MySQL.single.await(
                "SELECT id, title, color FROM notebooks WHERE id = ? LIMIT 1",
                { data.metaData.id })
            if notebookData and notebookData.id then
                local pages = MySQL.query.await(
                    "SELECT page_number as `number`, content, images, drawing FROM notebook_pages WHERE notebook_id = ? LIMIT 10",
                    { notebookData.id })
                for i = 1, #pages do
                    pages[i].content = json.decode(pages[i].content)
                    pages[i].images = json.decode(pages[i].images)
                end
                notebookData.pages = pages
            end

            :: skip ::

            TriggerClientEvent("prp-notebook:client:setNotebookData", source, notebookData, isCached)
            TriggerClientEvent("prp-notebook:client:setNotebookItemId", source, data.slot)
        end
    end)

    bridge.inv.registerCreateItemHook(function(payload)
        lib.print.debug('Creating a notebook item', json.encode(payload, { indent = true }))

        if payload.metadata?.id then
            lib.print.debug("Not creating a notebook item because it already has an id", payload.metadata.id)
            return payload.metadata
        end

        lib.print.debug("Creating a new notebook item in the database")
        local identifier = bridge.fw.getIdentifier(payload.inventoryId)

        local notebookData = {
            title = locale('NOTEBOOK_DEFAULT_LABEL'),
            pages = {
                { number = 1, content = {}, images = {} },
                { number = 2, content = {}, images = {} },
            },
            color = "#410101",
        }

        lib.print.debug("Inserting notebook into the database for identifier", identifier)
        local id = MySQL.insert.await(
            "INSERT INTO notebooks (title, color, owner) VALUES (?, ?, ?)",
            { notebookData.title, notebookData.color, identifier }
        )

        lib.print.debug("Inserted notebook into the database with id", id)
        if not id then
            lib.print.debug("Failed to create a notebook in the database")
            return false
        end

        for i = 1, #notebookData.pages do
            local bookPage = notebookData.pages[i]
            local bookPageNumber = bookPage.number
            local bookPageContent = bookPage.content
            local bookPageImages = bookPage.images

            lib.print.debug("Inserting notebook page into the database", bookPageNumber)
            local pageId = exports.oxmysql:insert_async(
                "INSERT INTO notebook_pages (notebook_id, page_number, content, images, drawing) VALUES (?, ?, ?, ?, ?)",
                { id, bookPageNumber, json.encode(bookPageContent), json.encode(bookPageImages), "" }
            )

            lib.print.debug("Inserted notebook page into the database", pageId)
        end

        payload.metadata.id = id
        payload.metadata.label = locale('NOTEBOOK_DEFAULT_LABEL')
        payload.metadata.owner = identifier

        lib.print.debug("Created a notebook with id", id, "for identifier", identifier)
        lib.print.debug("Metadata", json.encode(payload.metadata, { indent = true }))

        return payload.metadata
    end, {
        itemFilter = {
            [Config.Item] = true
        },
        inventoryFilter = {
            '^%d+$', 
        }
    })

    bridge.inv.registerSwapItemsHook(function(payload)
        if payload.fromInventory ~= payload.toInventory then
            TriggerClientEvent("prp-notebook:client:invalidateNotebookCache", payload.source, payload.fromSlot.metadata.id)
        end

        return true
    end, {
        itemFilter = {
            [Config.Item] = true
        }
    })

    exports['prp-bridge']:RegisterObject(Config.AttachProp)
end
SetTimeout(0, RegisterNotebook)

RegisterNetEvent("prp-notebook:server:notebookProp", function(state)
    local src = source

    if state then
        exports['prp-bridge']:CreateAttachObject(src, Config.AttachProp.objectName)
    else
        exports['prp-bridge']:ClearPlayerObjects(src, Config.AttachProp.objectName)
    end
end)

Citizen.CreateThread(function()
    while GetResourceState("oxmysql") ~= "started" do
        Wait(50)
    end

    exports.oxmysql.awaitConnection()

    local queries = {
        [[
            CREATE TABLE IF NOT EXISTS notebooks (
                id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(80) NOT NULL,
                color VARCHAR(7),
                owner VARCHAR(255) NOT NULL,
                is_original BOOLEAN DEFAULT FALSE,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP() NULL,
                INDEX(owner)
            ) CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
        ]],
        [[
            CREATE TABLE IF NOT EXISTS notebook_pages (
                id INT AUTO_INCREMENT PRIMARY KEY,
                page_number INT NOT NULL,
                notebook_id INT NOT NULL,
                content LONGTEXT NOT NULL,
                images LONGTEXT NOT NULL,
                drawing LONGTEXT NOT NULL,
                updated_at DATETIME DEFAULT CURRENT_TIMESTAMP() NULL,
                INDEX(notebook_id),
                INDEX(page_number),
                FOREIGN KEY (notebook_id) REFERENCES notebooks (id) ON DELETE CASCADE
            ) CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
        ]]
    }

    for i = 1, #queries do
        MySQL.query.await(queries[i])
    end
end)
