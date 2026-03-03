
-- ===========================
-- SQL Tablo Yönetim Sistemi - Düzeltilmiş Versiyon
-- ===========================

-- Konfigürasyon
local Config = {
    SQLName = base.SQLName or 'tw_transportv2',
    SQL = "oxmysql", -- oxmysql, ghmattimysql, mysql-async
    DefaultCharset = "utf8mb4",
    DefaultCollation = "utf8mb4_unicode_ci",
    LogPrefix = "[ TW TRANSPORT V2 ]",
    Debug = false,      -- SQL sorgularını göstermek için true yapın
    LogLevel = "INFO",  -- ERROR, WARNING, INFO, SUCCESS, DEBUG
    SilentMode = false, -- true yaparsanız sadece ERROR ve SUCCESS logları görünür
    CompactLogs = true  -- Daha az yer kaplayan log formatı
}

-- ===========================
-- Tablo Şemaları
-- ===========================
local TableSchemas = {
    -- Profil Verileri Tablosu
    {
        name = Config.SQLName,
        columns = {
            { name = "identifier",   type = "char(50)", nullable = true, unique = true },
            { name = "profiledata",  type = "longtext", nullable = true },
            { name = "dailymission", type = "longtext", nullable = true, default = "{\"remainingtime\":24,\"jobtask_two\":{\"count\":0,\"complete\":false},\"jobtask_five\":{\"count\":0,\"complete\":false},\"jobtask_four\":{\"count\":0,\"complete\":false},\"jobtask_one\":{\"count\":0,\"complete\":false},\"timestamp\":1753272569,\"jobtask_three\":{\"count\":0,\"complete\":false}}" },
            { name = "tutorial",     type = "longtext", nullable = true, default = "{\"tutorial_three\":false,\"tutorial_five\":false,\"tutorial_two\":false,\"tutorial_one\":false,\"tutorial_six\":false,\"tutorial_four\":false}" },
            { name = "history",      type = "longtext", nullable = true, default = "[]" },
            { name = "uisettings",   type = "longtext", nullable = true, default = "{\"soundEffect\":true,\"locale\":\"en\",\"uiPositions\":{\"teamList\":{\"left\":\"85.94vw\",\"top\":\"77.22vh\"},\"scoreList\":{\"left\":\"1.61vw\",\"top\":\"2.64vh\"},\"inviteSide\":{\"left\":\"73.07vw\",\"top\":\"2.85vh\"},\"notificationDiv\":{\"left\":\"81.54vw\",\"top\":\"40.48vh\"}}}" },
        }
    },
}

-- ===========================
-- Yardımcı Fonksiyonlar
-- ===========================
local Utils = {}

-- Veri tipi sayısal mı kontrolü
function Utils.isNumericType(dataType)
    local numericTypes = {
        "int", "tinyint", "smallint", "mediumint", "bigint",
        "float", "double", "decimal", "numeric", "bit"
    }

    local lowerType = dataType:lower()
    for _, numType in ipairs(numericTypes) do
        if lowerType:match("^" .. numType) then
            return true
        end
    end
    return false
end

-- Veri tiplerini normalize et
function Utils.normalizeDataType(dataType)
    local typeMap = {
        ["int"] = "int(11)",
        ["bigint"] = "bigint(20)",
        ["varchar"] = function(size) return "varchar(" .. (size or 255) .. ")" end,
        ["char"] = function(size) return "char(" .. (size or 50) .. ")" end
    }

    local baseType = dataType:match("^(%w+)")
    local size = dataType:match("%((%d+)%)")

    if typeMap[baseType] then
        if type(typeMap[baseType]) == "function" then
            return typeMap[baseType](size)
        else
            return typeMap[baseType]
        end
    end

    return dataType
end

-- ===========================
-- Logger Modülü
-- ===========================
local Logger = {
    levels = {
        ERROR = { color = "^1", icon = "❌", priority = 1 },
        WARNING = { color = "^3", icon = "⚠️", priority = 2 },
        SUCCESS = { color = "^2", icon = "✅", priority = 3 },
        INFO = { color = "^5", icon = "ℹ️", priority = 4 },
        DEBUG = { color = "^7", icon = "🔍", priority = 5 }
    }
}

function Logger:shouldLog(level)
    -- SilentMode'da sadece ERROR ve SUCCESS logları
    if Config.SilentMode and level ~= "ERROR" and level ~= "SUCCESS" then
        return false
    end

    local configPriority = self.levels[Config.LogLevel].priority
    local messagePriority = self.levels[level].priority

    return messagePriority <= configPriority
end

function Logger:log(level, message, details)
    if not self:shouldLog(level) then return end

    local levelConfig = self.levels[level] or self.levels.INFO

    if Config.CompactLogs then
        -- Kompakt format - tek satır
        local detailsStr = ""
        if details then
            if details.table then
                detailsStr = " [" .. details.table .. "]"
            elseif details.total then
                detailsStr = " [Total: " ..
                    details.total .. (details.updated and ", Updated: " .. details.updated or "") .. "]"
            end
        end
        print(levelConfig.color .. levelConfig.icon .. " " .. Config.LogPrefix .. " " .. message .. detailsStr .. "^7")
    else
        -- Detaylı format
        local timestamp = os.date("%H:%M:%S")
        print(levelConfig.color ..
            "[" .. timestamp .. "] " .. Config.LogPrefix .. " - " .. level .. ": " .. message .. "^7")
        if details then
            print(levelConfig.color .. "   └─ " .. json.encode(details) .. "^7")
        end
    end
end

-- ===========================
-- SQL Yürütücü
-- ===========================
local SQLExecutor = {}

function SQLExecutor:execute(query, params, callback)
    params = params or {}

    -- Sadece Debug modda SQL sorgularını göster
    if Config.Debug then
        local shortQuery = query:gsub("\n", " "):sub(1, 80)
        if #query > 80 then shortQuery = shortQuery .. "..." end
        print("^3[SQL] " .. shortQuery .. "^7")
    end

    local function handleResult(result)
        if callback then callback(result) end
    end

    if Config.SQL == "oxmysql" then
        exports.oxmysql:execute(query, params, handleResult)
    elseif Config.SQL == "ghmattimysql" then
        exports.ghmattimysql:execute(query, params, handleResult)
    elseif Config.SQL == "mysql-async" then
        if query:lower():find("select") or query:lower():find("show") then
            MySQL.Async.fetchAll(query, params, handleResult)
        else
            MySQL.Async.execute(query, params, handleResult)
        end
    else
        Logger:log("ERROR", "Invalid SQL configuration: " .. Config.SQL)
        return false
    end
end

-- ===========================
-- Tablo Yöneticisi
-- ===========================
local TableManager = {
    processedTables = {},
    pendingOperations = {},
    statistics = {
        tablesChecked = 0,
        columnsAdded = 0,
        columnsModified = 0,
        errors = 0
    }
}

-- CREATE TABLE sorgusu oluştur
function TableManager:buildCreateTableQuery(schema)
    local parts = { "CREATE TABLE IF NOT EXISTS `" .. schema.name .. "` (" }
    local columnDefs = {}
    local uniqueKeys = {}
    local primaryKey = nil

    for _, column in ipairs(schema.columns) do
        local def = "`" .. column.name .. "` " .. column.type

        if column.nullable == false then
            def = def .. " NOT NULL"
        else
            def = def .. " DEFAULT NULL"
        end

        if column.default ~= nil then
            if type(column.default) == "string" then
                def = def:gsub("DEFAULT NULL", "DEFAULT '" .. column.default .. "'")
            else
                def = def:gsub("DEFAULT NULL", "DEFAULT " .. tostring(column.default))
            end
        end

        if column.autoIncrement then
            def = def .. " AUTO_INCREMENT"
        end

        table.insert(columnDefs, def)

        -- Primary key kontrolü
        if column.primary then
            primaryKey = column.name
        end

        -- Unique key kontrolü
        if column.unique then
            table.insert(uniqueKeys, "UNIQUE KEY `uk_" .. column.name .. "` (`" .. column.name .. "`)")
        end
    end

    -- Tüm satırları birleştir (kolonlar + keys)
    local allDefinitions = {}

    -- Önce kolonları ekle
    for _, def in ipairs(columnDefs) do
        table.insert(allDefinitions, def)
    end

    -- Primary key varsa ekle
    if primaryKey then
        table.insert(allDefinitions, "PRIMARY KEY (`" .. primaryKey .. "`)")
    end

    -- Sonra unique key'leri ekle
    for _, key in ipairs(uniqueKeys) do
        table.insert(allDefinitions, key)
    end

    -- Her satırı virgülle ayırarak ekle (son satır hariç)
    for i, def in ipairs(allDefinitions) do
        local suffix = (i == #allDefinitions) and "" or ","
        table.insert(parts, "    " .. def .. suffix)
    end

    table.insert(parts, ") ENGINE=InnoDB DEFAULT CHARSET=" .. Config.DefaultCharset ..
        " COLLATE=" .. Config.DefaultCollation .. ";")

    return table.concat(parts, "\n")
end

-- Kolon varlığını kontrol et
function TableManager:checkColumnExists(tableName, columnName, callback)
    local query = "SHOW COLUMNS FROM `" .. tableName .. "` LIKE '" .. columnName .. "';"

    SQLExecutor:execute(query, {}, function(result)
        callback(result and #result > 0)
    end)
end

-- Unique constraint kontrolü
function TableManager:checkUniqueConstraint(tableName, columnName, callback)
    local query = string.format([[
        SELECT COUNT(*) as count
        FROM information_schema.statistics
        WHERE table_schema = DATABASE()
        AND table_name = '%s'
        AND column_name = '%s'
        AND non_unique = 0
    ]], tableName, columnName)

    SQLExecutor:execute(query, {}, function(result)
        local hasUnique = result and result[1] and result[1].count > 0
        callback(hasUnique)
    end)
end

-- Unique constraint ekle
function TableManager:addUniqueConstraint(tableName, columnName, callback)
    local constraintName = "uk_" .. columnName
    local query = string.format(
        "ALTER TABLE `%s` ADD CONSTRAINT `%s` UNIQUE (`%s`);",
        tableName, constraintName, columnName
    )

    SQLExecutor:execute(query, {}, function(result)
        if result then
            Logger:log("SUCCESS", "Unique constraint added: " .. columnName .. " (" .. tableName .. ")")
            callback(true)
        else
            Logger:log("ERROR", "Failed to add unique constraint", {
                table = tableName,
                column = columnName
            })
            callback(false)
        end
    end)
end

-- Unique constraint kaldır
function TableManager:removeUniqueConstraint(tableName, columnName, callback)
    -- Önce constraint adını bul
    local findQuery = string.format([[
        SELECT CONSTRAINT_NAME
        FROM information_schema.table_constraints
        WHERE table_schema = DATABASE()
        AND table_name = '%s'
        AND constraint_type = 'UNIQUE'
        AND constraint_name IN (
            SELECT constraint_name
            FROM information_schema.key_column_usage
            WHERE table_schema = DATABASE()
            AND table_name = '%s'
            AND column_name = '%s'
        )
    ]], tableName, tableName, columnName)

    SQLExecutor:execute(findQuery, {}, function(result)
        if result and #result > 0 then
            local constraintName = result[1].CONSTRAINT_NAME
            local dropQuery = string.format(
                "ALTER TABLE `%s` DROP INDEX `%s`;",
                tableName, constraintName
            )

            SQLExecutor:execute(dropQuery, {}, function(dropResult)
                if dropResult then
                    Logger:log("SUCCESS", "Unique constraint removed: " .. columnName .. " (" .. tableName .. ")")
                    callback(true)
                else
                    Logger:log("ERROR", "Failed to remove unique constraint", {
                        table = tableName,
                        column = columnName,
                        constraint = constraintName
                    })
                    callback(false)
                end
            end)
        else
            -- Constraint bulunamadı, muhtemelen zaten yok
            callback(true)
        end
    end)
end

-- Kolon tipini ve collation'ı kontrol et ve düzelt
function TableManager:validateColumnType(tableName, column, callback)
    local query = "SHOW FULL COLUMNS FROM `" .. tableName .. "` LIKE '" .. column.name .. "';"

    SQLExecutor:execute(query, {}, function(result)
        if not result or #result == 0 then
            callback(false, "Column not found")
            return
        end

        local currentType = result[1].Type:lower()
        local expectedType = Utils.normalizeDataType(column.type):lower()
        local currentCollation = result[1].Collation
        local needsTypeUpdate = false
        local needsCollationUpdate = false

        -- Tip kontrolü
        if currentType:match("^int") and expectedType:match("^int") then
            -- Int tipleri uyumlu
        elseif currentType ~= expectedType then
            needsTypeUpdate = true
        end

        -- Collation kontrolü (sadece string tiplerinde)
        if not Utils.isNumericType(currentType) and currentCollation and currentCollation ~= Config.DefaultCollation then
            needsCollationUpdate = true
        end

        -- Güncellemeler gerekiyorsa yap
        if needsTypeUpdate or needsCollationUpdate then
            local collationPart = ""
            if not Utils.isNumericType(column.type) then
                collationPart = " COLLATE " .. Config.DefaultCollation
            end

            local alterQuery = string.format(
                "ALTER TABLE `%s` MODIFY `%s` %s%s%s;",
                tableName,
                column.name,
                column.type,
                column.nullable ~= false and " DEFAULT NULL" or " NOT NULL",
                collationPart
            )

            if needsTypeUpdate then
                Logger:log("WARNING", "Column type mismatch detected", {
                    table = tableName,
                    column = column.name,
                    current = currentType,
                    expected = expectedType
                })
            end

            if needsCollationUpdate then
                Logger:log("WARNING", "Column collation mismatch detected", {
                    table = tableName,
                    column = column.name,
                    current = currentCollation,
                    expected = Config.DefaultCollation
                })
            end

            SQLExecutor:execute(alterQuery, {}, function(alterResult)
                if alterResult then
                    self.statistics.columnsModified = self.statistics.columnsModified + 1
                    local updateMsg = "Column updated: " .. column.name .. " (" .. tableName .. ")"
                    if needsTypeUpdate and needsCollationUpdate then
                        updateMsg = updateMsg .. " [type + collation]"
                    elseif needsTypeUpdate then
                        updateMsg = updateMsg .. " [type]"
                    elseif needsCollationUpdate then
                        updateMsg = updateMsg .. " [collation]"
                    end
                    Logger:log("SUCCESS", updateMsg)

                    -- Güncellemeden sonra unique constraint'i kontrol et
                    self:validateUniqueConstraint(tableName, column, callback)
                else
                    self.statistics.errors = self.statistics.errors + 1
                    Logger:log("ERROR", "Failed to update column", {
                        table = tableName,
                        column = column.name
                    })
                    callback(false, "Failed to alter column")
                end
            end)
        else
            -- Tip ve collation doğru, unique constraint'i kontrol et
            self:validateUniqueConstraint(tableName, column, callback)
        end
    end)
end

-- Unique constraint doğrulaması
function TableManager:validateUniqueConstraint(tableName, column, callback)
    self:checkUniqueConstraint(tableName, column.name, function(hasUnique)
        if column.unique and not hasUnique then
            -- Unique olmalı ama değil - ekle
            self:addUniqueConstraint(tableName, column.name, function(success)
                callback(true, success)
            end)
        elseif not column.unique and hasUnique then
            -- Unique olmamalı ama var - kaldır
            self:removeUniqueConstraint(tableName, column.name, function(success)
                callback(true, success)
            end)
        else
            -- Her şey doğru
            callback(true)
        end
    end)
end

-- Kolon ekle
function TableManager:addColumn(tableName, column, callback)
    local def = string.format("`%s` %s", column.name, column.type)

    if column.nullable == false then
        def = def .. " NOT NULL"
    else
        def = def .. " DEFAULT NULL"
    end

    if column.default ~= nil then
        if column.default == "CURRENT_TIMESTAMP" then
            def = def:gsub("DEFAULT NULL", "DEFAULT CURRENT_TIMESTAMP")
        elseif type(column.default) == "string" then
            def = def:gsub("DEFAULT NULL", "DEFAULT '" .. column.default .. "'")
        else
            def = def:gsub("DEFAULT NULL", "DEFAULT " .. tostring(column.default))
        end
    end

    -- String tiplerinde collation ekle
    if not Utils.isNumericType(column.type) and not column.type:lower():match("timestamp") and not column.type:lower():match("datetime") then
        def = def .. " COLLATE " .. Config.DefaultCollation
    end


    local query = string.format("ALTER TABLE `%s` ADD COLUMN %s;", tableName, def)

    SQLExecutor:execute(query, {}, function(result)
        if result then
            self.statistics.columnsAdded = self.statistics.columnsAdded + 1
            Logger:log("SUCCESS", "New column added: " .. column.name .. " (" .. tableName .. ")")

            -- Kolon eklendikten sonra unique constraint ekle
            if column.unique then
                self:addUniqueConstraint(tableName, column.name, function(success)
                    callback(success)
                end)
            else
                callback(true)
            end
        else
            self.statistics.errors = self.statistics.errors + 1
            Logger:log("ERROR", "Failed to add column", {
                table = tableName,
                column = column.name
            })
            callback(false)
        end
    end)
end

-- Tabloyu işle
function TableManager:processTable(schema, callback)
    local tableName = schema.name
    self.statistics.tablesChecked = self.statistics.tablesChecked + 1

    -- Önce tabloyu oluştur
    local createQuery = self:buildCreateTableQuery(schema)

    SQLExecutor:execute(createQuery, {}, function(createResult)
        if not createResult then
            self.statistics.errors = self.statistics.errors + 1
            Logger:log("ERROR", "Failed to create table: " .. tableName)
            if callback then callback(false) end
            return
        end

        -- Her kolonu kontrol et
        local totalColumns = #schema.columns
        local processedColumns = 0
        local hasChanges = false
        local addedColumns = {}
        local modifiedColumns = {}

        for _, column in ipairs(schema.columns) do
            self:checkColumnExists(tableName, column.name, function(exists)
                if not exists then
                    -- Kolon yoksa ekle
                    self:addColumn(tableName, column, function(success)
                        if success then
                            hasChanges = true
                            table.insert(addedColumns, column.name)
                        end
                        processedColumns = processedColumns + 1

                        if processedColumns == totalColumns then
                            -- Özet rapor
                            if hasChanges then
                                local changes = {}
                                if #addedColumns > 0 then
                                    table.insert(changes, #addedColumns .. " columns added")
                                end
                                if #modifiedColumns > 0 then
                                    table.insert(changes, #modifiedColumns .. " columns updated")
                                end
                                Logger:log("INFO", "Table " .. tableName .. " updated: " .. table.concat(changes, ", "))
                            end
                            if callback then callback(true, hasChanges) end
                        end
                    end)
                else
                    -- Kolon varsa tipini kontrol et
                    self:validateColumnType(tableName, column, function(success, wasModified)
                        if wasModified then
                            hasChanges = true
                            table.insert(modifiedColumns, column.name)
                        end
                        processedColumns = processedColumns + 1

                        if processedColumns == totalColumns then
                            -- Özet rapor
                            if hasChanges then
                                local changes = {}
                                if #addedColumns > 0 then
                                    table.insert(changes, #addedColumns .. " columns added")
                                end
                                if #modifiedColumns > 0 then
                                    table.insert(changes, #modifiedColumns .. " columns updated")
                                end
                                Logger:log("INFO", "Table " .. tableName .. " updated: " .. table.concat(changes, ", "))
                            end
                            if callback then callback(true, hasChanges) end
                        end
                    end)
                end
            end)
        end
    end)
end

-- Tüm tabloları işle
function TableManager:processAllTables()
    Logger:log("INFO", "Starting database validation...")

    -- İstatistikleri sıfırla
    self.statistics = {
        tablesChecked = 0,
        columnsAdded = 0,
        columnsModified = 0,
        errors = 0
    }

    local totalTables = #TableSchemas
    local processedTables = 0
    local tablesWithChanges = 0

    for _, schema in ipairs(TableSchemas) do
        self:processTable(schema, function(success, hasChanges)
            processedTables = processedTables + 1
            if hasChanges then tablesWithChanges = tablesWithChanges + 1 end

            if processedTables == totalTables then
                -- Final rapor
                Wait(100) -- Tüm logların düzgün görünmesi için

                if self.statistics.errors > 0 then
                    Logger:log("WARNING", "Database validation completed with errors", self.statistics)
                elseif self.statistics.columnsAdded > 0 or self.statistics.columnsModified > 0 then
                    Logger:log("SUCCESS", "Database updated", {
                        tables = totalTables,
                        columns_added = self.statistics.columnsAdded,
                        columns_modified = self.statistics.columnsModified
                    })
                else
                    Logger:log("SUCCESS", "Database is up to date", {
                        tables_checked = totalTables
                    })
                end
            end
        end)
    end
end

-- ===========================
-- Başlatma
-- ===========================
Citizen.CreateThread(function()
    SQLExecutor:execute("SELECT 1 as test", {}, function(result)
        if result then
            TableManager:processAllTables()
        else
            Logger:log("ERROR", "Failed to establish SQL connection! Make sure " .. Config.SQL .. " resource is loaded.")
        end
    end)
end)

-- ===========================
-- Export Fonksiyonları
-- ===========================
exports("addTableSchema", function(schema)
    table.insert(TableSchemas, schema)
    Logger:log("INFO", "New table schema added: " .. schema.name)
end)

exports("processTable", function(tableName)
    for _, schema in ipairs(TableSchemas) do
        if schema.name == tableName then
            TableManager:processTable(schema)
            return true
        end
    end
    Logger:log("ERROR", "Table schema not found: " .. tableName)
    return false
end)

exports("getStatistics", function()
    return TableManager.statistics
end)
