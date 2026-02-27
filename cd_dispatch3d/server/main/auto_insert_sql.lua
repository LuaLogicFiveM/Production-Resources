if not Config.AutoInsertSQL then return end

local function ensureTable(name, query)
    if not DB.tableExists(name) then
        DB.exec(query)
        Citizen.Trace(('^3[cd_dispatch]^0 Table ^5%s^0 was ^1missing^0 — created automatically.\n'):format(name))
        return true
    end
    return false
end

function AutoInsertSQL()
    local created = {}

    -- cd_dispatch
    local tableQuery = [[
        CREATE TABLE `cd_dispatch` (
            `identifier` VARCHAR(50) NULL DEFAULT NULL,
            `callsign` VARCHAR(100) NULL DEFAULT NULL
        )
        COLLATE='utf8mb4_unicode_ci'
        ENGINE=InnoDB;
    ]]
    if ensureTable("cd_dispatch", tableQuery) then
        table.insert(created, "cd_dispatch")
    end

    -- cd_dispatch_planner
    local tableQuery = [[
        CREATE TABLE `cd_dispatch_planner` (
            `id` VARCHAR(50) NULL DEFAULT NULL,
            `plan` LONGTEXT NULL DEFAULT NULL
        )
        COLLATE='utf8mb4_unicode_ci'
        ENGINE=InnoDB;
    ]]
    if ensureTable("cd_dispatch_planner", tableQuery) then
        table.insert(created, "cd_dispatch_planner")
    end

    -- cd_dispatch_heatmap
    local tableQuery = [[
        CREATE TABLE `cd_dispatch_heatmap` (
            `heatmap` LONGTEXT NULL DEFAULT NULL
        )
        COLLATE='utf8mb4_unicode_ci'
        ENGINE=InnoDB;
    ]]
    if ensureTable("cd_dispatch_heatmap", tableQuery) then
        table.insert(created, "cd_dispatch_heatmap")
    end

    if #created > 0 then
        Citizen.Trace('^5--------------------------^0\n')
        Citizen.Trace('^5[cd_dispatch]^0 Created SQL structures:\n')
        for _, name in ipairs(created) do
            Citizen.Trace('  - ^3'..name..'^0\n')
        end
        Citizen.Trace('^5--------------------------^0\n')
    else
        Citizen.Trace('^2[cd_dispatch]^0 All SQL tables already exist.\n')
    end

    SQLCheckDone = true
end