-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
-- You don’t need to run this SQL manually; the system will automatically import it.
CREATE TABLE
  IF NOT EXISTS `g_bossmenu_society_transactions` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `society_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `type` ENUM ('deposit', 'withdraw') NOT NULL COLLATE 'utf8mb4_general_ci',
    `amount` INT (11) NOT NULL,
    `identifier` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
    `performed_by` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
    `createdAt` DATETIME NULL DEFAULT current_timestamp(),
    `notes` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_society_transactions_society_identifier_date` (`society_name`, `identifier`, `createdAt`) USING BTREE,
    INDEX `idx_society_transactions_society_date` (`society_name`, `createdAt`) USING BTREE,
    INDEX `idx_society_transactions_date` (`createdAt`) USING BTREE,
    INDEX `idx_society_transactions_type` (`type`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

-- in config make this optional like server owners can set inbuilt society or other banking sociry like qb-management/esx_society
CREATE TABLE
  IF NOT EXISTS g_bossmenu_society (
    id INT AUTO_INCREMENT PRIMARY KEY,
    society_name VARCHAR(50) NOT NULL UNIQUE, -- Name of the society/job/gang
    balance INT DEFAULT 0, -- Current balance of the society
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP -- Last updated time
  );

CREATE TABLE
  IF NOT EXISTS g_bossmenu_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(64) NOT NULL, -- Reported player
    job VARCHAR(50) NOT NULL, -- Job (police, ems, taxi, etc.)
    report_text TEXT, -- The actual report
    status ENUM ('open', 'in_progress', 'resolved') DEFAULT 'open', -- Report status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reply JSON DEFAULT '[]' -- Array of replies stored as JSON
  );

-- Player Reports Table - Enhanced version with more features
CREATE TABLE
  IF NOT EXISTS `g_bossmenu_player_reports` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(100) NULL DEFAULT NULL, -- Player identifier who created the report
    `name` VARCHAR(50) NULL DEFAULT NULL, -- Player name
    `job` VARCHAR(50) NULL DEFAULT NULL, -- Job name
    `grade_label` VARCHAR(50) NULL DEFAULT NULL, -- Grade label at time of report
    `report_text` LONGTEXT NULL DEFAULT NULL, -- Report content
    `status` ENUM ('pending', 'in_progress', 'resolved') NULL DEFAULT 'pending', -- Report status
    `boss_notes` LONGTEXT NULL DEFAULT NULL, -- Boss/supervisor notes
    `evidence` LONGTEXT NULL DEFAULT NULL, -- Evidence URLs stored as JSON array
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Created timestamp
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Updated timestamp
    PRIMARY KEY (`id`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;

CREATE TABLE
  `g_bossmenu_job_applications` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `job` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `application_data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `status` ENUM (
      'pending',
      'pending_review',
      'approved',
      'rejected'
    ) NULL DEFAULT 'pending' COLLATE 'utf8mb4_general_ci',
    `reviewed_by` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `reviewed_at` DATETIME NULL DEFAULT NULL,
    `notes` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `created_at` DATETIME NOT NULL DEFAULT current_timestamp(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE
  IF NOT EXISTS `g_bossmenu_employee_leave` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
    `name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `job` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `grade_label` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `leave_type` ENUM (
      'sick_leave',
      'casual_leave',
      'vacation',
      'maternity_paternity_leave',
      'unpaid_leave',
      'other'
    ) NOT NULL COLLATE 'utf8mb4_general_ci',
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_days` INT (11) NOT NULL,
    `reason` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `status` ENUM ('pending', 'approved', 'rejected') NULL DEFAULT 'pending' COLLATE 'utf8mb4_general_ci',
    `notes` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `reviewed_by` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `reviewed_at` DATETIME NULL DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT current_timestamp(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_employee_leave_identifier` (`identifier`) USING BTREE,
    INDEX `idx_employee_leave_job` (`job`) USING BTREE,
    INDEX `idx_employee_leave_status` (`status`) USING BTREE,
    INDEX `idx_employee_leave_dates` (`start_date`, `end_date`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE
  `g_bossmenu_settings` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `job` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `enable_job_application` TINYINT (1) NOT NULL DEFAULT '0',
    `enable_reports` TINYINT (1) NOT NULL DEFAULT '0',
    `enable_leave_management` TINYINT (1) NOT NULL DEFAULT '0',
    `enable_vehicle_management` TINYINT (1) NOT NULL DEFAULT '0',
    `logo_url` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `created_at` DATETIME NOT NULL DEFAULT current_timestamp(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `job` (`job`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 31;

CREATE TABLE
  `g_bossmenu_faction_cooldowns` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `job` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `identifier` VARCHAR(60) NOT NULL COLLATE 'utf8mb4_general_ci',
    `cooldown_until` INT (11) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uniq_job_identifier` (`job`, `identifier`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 11;

CREATE TABLE
  `g_bossmenu_job_ownable_vehicles` (
    `id` INT (11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `userName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `vehPlate` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `job` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `grade` INT (11) NULL DEFAULT NULL,
    `vehicle_code` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `vehicle_label` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `createdAt` TIMESTAMP NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `vehPlate` (`vehPlate`) USING BTREE
  ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 2;