AddEventHandler('prp-horde:server:startup', function()
    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `horde_actions` (
            `key` varchar(50) NOT NULL,
            PRIMARY KEY (`key`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])

    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `horde_stashes` (
            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
            `interiorKey` varchar(50) NULL DEFAULT NULL,
            `x` decimal(7,2) NOT NULL DEFAULT 0.00,
            `y` decimal(7,2) NOT NULL DEFAULT 0.00,
            `z` decimal(7,2) NOT NULL DEFAULT 0.00,
            PRIMARY KEY (`id`),
            KEY `IX_horde_stashes_interiorKey` (`interiorKey`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])

    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `horde_spawns` (
            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
            `interiorKey` varchar(50) NULL DEFAULT NULL,
            `x` decimal(7,2) NOT NULL DEFAULT 0.00,
            `y` decimal(7,2) NOT NULL DEFAULT 0.00,
            `z` decimal(7,2) NOT NULL DEFAULT 0.00,
            `w` decimal(7,2) NOT NULL DEFAULT 0.00,
            PRIMARY KEY (`id`),
            KEY `IX_horde_stashes_interiorKey` (`interiorKey`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])

    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `horde_objects` (
            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
            `interiorKey` varchar(50) NOT NULL,
            `model` varchar(250) NOT NULL,
            `x` decimal(7,2) NOT NULL DEFAULT 0.00,
            `y` decimal(7,2) NOT NULL DEFAULT 0.00,
            `z` decimal(7,2) NOT NULL DEFAULT 0.00,
            `rx` decimal(7,2) NOT NULL DEFAULT 0.00,
            `ry` decimal(7,2) NOT NULL DEFAULT 0.00,
            `rz` decimal(7,2) NOT NULL DEFAULT 0.00,
            PRIMARY KEY (`id`),
            KEY `IX_horde_objects_interiorKey` (`interiorKey`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])

    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `horde_zones` (
            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
            `interiorKey` varchar(50) NULL DEFAULT NULL,
            `type` varchar(50) NOT NULL DEFAULT 'FIRE',
            `x` decimal(7,2) NOT NULL DEFAULT 0.00,
            `y` decimal(7,2) NOT NULL DEFAULT 0.00,
            `z` decimal(7,2) NOT NULL DEFAULT 0.00,
            `w` decimal(7,2) NOT NULL DEFAULT 0.00,
            PRIMARY KEY (`id`),
            KEY `IX_horde_zones_interiorKey` (`interiorKey`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])

    MySQL.query.await('DELETE FROM horde_actions')
    
    TriggerEvent('prp-horde:server:migrationsFinished')
end)