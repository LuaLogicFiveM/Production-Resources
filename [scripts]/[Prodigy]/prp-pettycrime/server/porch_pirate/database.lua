local SELECT_PORCH_PIRATE_LOCATION_QUERY <const> = "SELECT * FROM porch_pirate_locations WHERE id = ?"
local SELECT_PORCH_PIRATE_LOCATIONS_QUERY <const> = "SELECT * FROM porch_pirate_locations"
local INSERT_PORCH_PIRATE_LOCATION_QUERY <const> = "INSERT INTO porch_pirate_locations (x, y, z, loot_tables) VALUES (?, ?, ?, ?)"
local UPDATE_PORCH_PIRATE_LOCATION_LOOT_TABLES_QUERY <const> = "UPDATE porch_pirate_locations SET loot_tables = ? WHERE id = ?"
local DELETE_PORCH_PIRATE_LOCATION_QUERY <const> = "DELETE FROM porch_pirate_locations WHERE id = ?"

---@param id number
---@return table
function GetPorchPirateLocation(id)
    return MySQL.single.await(SELECT_PORCH_PIRATE_LOCATION_QUERY, {id})
end

---@return table
function GetPorchPirateLocations()
    return MySQL.query.await(SELECT_PORCH_PIRATE_LOCATIONS_QUERY)
end

---@param x number
---@param y number
---@param z number
---@param lootTables table
function InsertPorchPirateLocation(x, y, z, lootTables)
    return MySQL.insert.await(INSERT_PORCH_PIRATE_LOCATION_QUERY, {x, y, z, json.encode(lootTables)})
end

---@param id number
---@param lootTables table
function UpdatePorchPirateLocationLootTables(id, lootTables)
    return MySQL.insert.await(UPDATE_PORCH_PIRATE_LOCATION_LOOT_TABLES_QUERY, {json.encode(lootTables), id})
end

---@param id number
function DeletePorchPirateLocation(id)
    return MySQL.insert.await(DELETE_PORCH_PIRATE_LOCATION_QUERY, {id})
end

function CreatePPTable()
    return MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `porch_pirate_locations` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `x` float(7,2) NOT NULL DEFAULT 0.00,
            `y` float(7,2) NOT NULL DEFAULT 0.00,
            `z` float(7,2) NOT NULL DEFAULT 0.00,
            `loot_tables` varchar(512) NOT NULL DEFAULT '{}',
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])
end