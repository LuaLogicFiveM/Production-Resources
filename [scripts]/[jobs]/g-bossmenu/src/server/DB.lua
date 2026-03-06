local function tableExists(name)
    local result = MySQL.scalar.await("SHOW TABLES LIKE ?", {name})
    return result ~= nil
end

CreateThread(function()
    -- Create g_bossmenu_society only first time
    if Config.AutoImportSQL and Config.BossMenuSettings.society_management == "inbuilt" then
        if not tableExists("g_bossmenu_society") then
            MySQL.query([[
                CREATE TABLE IF NOT EXISTS g_bossmenu_society (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    society_name VARCHAR(50) NOT NULL UNIQUE,
                    balance INT DEFAULT 0,
                    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
            ]])
            print("^2[g-bossmenu] Created table: g_bossmenu_society^0")
        end
    end

    -- Job Ownable Vehicles
    if Config.AutoImportSQL and Config.BossMenuSettings.EnableVehicleSystem then
        if not tableExists("g_bossmenu_job_ownable_vehicles") then
            MySQL.query([[
                CREATE TABLE IF NOT EXISTS `g_bossmenu_job_ownable_vehicles` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `identifier` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                    `userName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                    `vehPlate` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                    `job` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                    `grade` INT(11) NULL DEFAULT NULL,
                    `vehicle_code` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                    `vehicle_label` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`) USING BTREE,
                    UNIQUE INDEX `vehPlate` (`vehPlate`) USING BTREE
                )
                COLLATE='utf8mb4_general_ci'
                ENGINE=InnoDB;
            ]])
            print("^2[g-bossmenu] Created table: g_bossmenu_job_ownable_vehicles^0")
        end
    end

    -- Global AutoImportSQL tables
    if Config.AutoImportSQL then
        -- Society Transactions
        if not tableExists("g_bossmenu_society_transactions") then
            MySQL.query([[
                CREATE TABLE IF NOT EXISTS `g_bossmenu_society_transactions` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `society_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
                    `type` ENUM('deposit', 'withdraw') NOT NULL COLLATE 'utf8mb4_general_ci',
                    `amount` INT(11) NOT NULL,
                    `identifier` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
                    `performed_by` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
                    `createdAt` DATETIME DEFAULT CURRENT_TIMESTAMP,
                    `notes` LONGTEXT NULL COLLATE 'utf8mb4_general_ci',
                    PRIMARY KEY (`id`) USING BTREE,
                    INDEX `idx_society_transactions_society_identifier_date` (`society_name`, `identifier`, `createdAt`) USING BTREE,
                    INDEX `idx_society_transactions_society_date` (`society_name`, `createdAt`) USING BTREE,
                    INDEX `idx_society_transactions_date` (`createdAt`) USING BTREE,
                    INDEX `idx_society_transactions_type` (`type`) USING BTREE
                )
                ENGINE = InnoDB
                AUTO_INCREMENT = 1
                DEFAULT COLLATE = 'utf8mb4_general_ci';
            ]])
            print("^2[g-bossmenu] Created table: g_bossmenu_society_transactions^0")
        end

        -- Reports
        if Config.BossMenuSettings.EnableReportsSystem then
            if not tableExists("g_bossmenu_player_reports") then
                MySQL.query([[
                    CREATE TABLE IF NOT EXISTS `g_bossmenu_player_reports` (
                        `id` INT(11) NOT NULL AUTO_INCREMENT,
                        `identifier` VARCHAR(100) NULL DEFAULT NULL,
                        `name` VARCHAR(50) NULL DEFAULT NULL,
                        `job` VARCHAR(50) NULL DEFAULT NULL,
                        `grade_label` VARCHAR(50) NULL DEFAULT NULL,
                        `report_text` LONGTEXT NULL DEFAULT NULL,
                        `status` ENUM('pending','in_progress','resolved') NULL DEFAULT 'pending',
                        `boss_notes` LONGTEXT NULL DEFAULT NULL,
                        `evidence` LONGTEXT NULL DEFAULT NULL,
                        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`) USING BTREE
                    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
                ]])
                print("^2[g-bossmenu] Created table: g_bossmenu_player_reports^0")
            end
        end

        -- Job Applications
        if Config.BossMenuSettings.EnableJobApplicationSystem then
            if not tableExists("g_bossmenu_job_applications") then
                MySQL.query([[
                    CREATE TABLE IF NOT EXISTS `g_bossmenu_job_applications` (
                        `id` INT(11) NOT NULL AUTO_INCREMENT,
                        `identifier` VARCHAR(100) NULL DEFAULT NULL,
                        `name` VARCHAR(50) NULL DEFAULT NULL,
                        `job` VARCHAR(50) NULL DEFAULT NULL,
                        `application_data` LONGTEXT NULL DEFAULT NULL,
                        `status` ENUM('pending','pending_review','approved','rejected') NULL DEFAULT 'pending',
                        `reviewed_by` VARCHAR(100) NULL DEFAULT NULL,
                        `reviewed_at` DATETIME NULL DEFAULT NULL,
                        `notes` LONGTEXT NULL DEFAULT NULL,
                        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`) USING BTREE
                    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
                ]])
                print("^2[g-bossmenu] Created table: g_bossmenu_job_applications^0")
            end
        end

        -- Leave System
        if Config.BossMenuSettings.EnableLeaveManagementSystem then
            if tableExists("g_bossmenu_employee_leave") then
                local enumCheck = MySQL.scalar.await([[
                    SELECT COLUMN_TYPE 
                    FROM INFORMATION_SCHEMA.COLUMNS 
                    WHERE TABLE_SCHEMA = DATABASE() 
                    AND TABLE_NAME = 'g_bossmenu_employee_leave' 
                    AND COLUMN_NAME = 'leave_type'
                ]])
                
                if enumCheck and not string.find(enumCheck, "'other'") then
                    MySQL.query([[
                        ALTER TABLE `g_bossmenu_employee_leave`
                        MODIFY `leave_type` ENUM(
                            'sick_leave',
                            'casual_leave',
                            'vacation',
                            'maternity_paternity_leave',
                            'unpaid_leave',
                            'other'
                        ) NOT NULL;
                    ]])
                    print("^3[g-bossmenu] Updated leave_type ENUM to include 'other'^0")
                end
            else
                MySQL.query([[
                    CREATE TABLE IF NOT EXISTS `g_bossmenu_employee_leave` (
                        `id` INT(11) NOT NULL AUTO_INCREMENT,
                        `identifier` VARCHAR(100) NOT NULL,
                        `name` VARCHAR(50) NOT NULL,
                        `job` VARCHAR(50) NOT NULL,
                        `grade_label` VARCHAR(50) NOT NULL,
                        `leave_type` ENUM('sick_leave','casual_leave','vacation','maternity_paternity_leave','unpaid_leave','other') NOT NULL,
                        `start_date` DATE NOT NULL,
                        `end_date` DATE NOT NULL,
                        `total_days` INT(11) NOT NULL,
                        `reason` LONGTEXT NOT NULL,
                        `status` ENUM('pending','approved','rejected') DEFAULT 'pending',
                        `notes` LONGTEXT NULL DEFAULT NULL,
                        `reviewed_by` VARCHAR(100) NULL DEFAULT NULL,
                        `reviewed_at` DATETIME NULL DEFAULT NULL,
                        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`) USING BTREE,
                        INDEX `idx_employee_leave_identifier` (`identifier`) USING BTREE,
                        INDEX `idx_employee_leave_job` (`job`) USING BTREE,
                        INDEX `idx_employee_leave_status` (`status`) USING BTREE,
                        INDEX `idx_employee_leave_dates` (`start_date`, `end_date`) USING BTREE
                    ) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;
                ]])

                print("^2[g-bossmenu] Created table: g_bossmenu_employee_leave^0")
            end
        end

        -- Settings
        if not tableExists("g_bossmenu_settings") then
            MySQL.query([[
                CREATE TABLE IF NOT EXISTS g_bossmenu_settings (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    job VARCHAR(50) NOT NULL UNIQUE,
                    enable_job_application BOOLEAN NOT NULL DEFAULT FALSE,
                    enable_reports BOOLEAN NOT NULL DEFAULT FALSE,
                    enable_leave_management BOOLEAN NOT NULL DEFAULT FALSE,
                    enable_vehicle_management BOOLEAN NOT NULL DEFAULT FALSE,
                    logo_url VARCHAR(255) NOT NULL DEFAULT '',
                    created_at DATETIME NOT NULL DEFAULT current_timestamp(),
                    updated_at TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
                ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
            ]])
            print("^2[g-bossmenu] Created table: g_bossmenu_settings^0")
        end

        -- Faction Cooldowns
        if Config.FactionCooldowns.EnableFactionCooldowns then
            if not tableExists("g_bossmenu_faction_cooldowns") then
                MySQL.query([[
                    CREATE TABLE IF NOT EXISTS g_bossmenu_faction_cooldowns (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        job VARCHAR(50) NOT NULL,
                        identifier VARCHAR(60) NOT NULL,
                        cooldown_until INT NOT NULL,
                        created_at DATETIME NOT NULL DEFAULT current_timestamp(),
                        UNIQUE KEY uniq_job_identifier (job, identifier)
                    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
                ]])
                print("^2[g-bossmenu] Created table: g_bossmenu_faction_cooldowns^0")
            end
        end
    end -- AutoImportSQL end
end)
