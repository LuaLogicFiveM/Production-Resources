CREATE TABLE IF NOT EXISTS `eg_killfeed_preferences` (
    `identifier` VARCHAR(60) NOT NULL,
    `killfeed_enabled` TINYINT(1) DEFAULT 1,
    `killfeed_x` FLOAT DEFAULT 70.0,
    `killfeed_y` FLOAT DEFAULT 2.0,
    `killfeed_scale` INT DEFAULT 100,
    `killfeed_max_entries` INT DEFAULT 5,
    `killfeed_duration` INT DEFAULT 5,
    `kd_enabled` TINYINT(1) DEFAULT 1,
    `kd_x` FLOAT DEFAULT 85.0,
    `kd_y` FLOAT DEFAULT 90.0,
    `kd_scale` INT DEFAULT 100,
    `clan_tag` VARCHAR(8) DEFAULT NULL,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`identifier`)
);

CREATE TABLE IF NOT EXISTS `eg_killfeed_stats` (
    `identifier` VARCHAR(60) NOT NULL,
    `player_name` VARCHAR(100) DEFAULT 'Unknown',
    `kills` INT DEFAULT 0,
    `deaths` INT DEFAULT 0,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`identifier`)
);


CREATE TABLE IF NOT EXISTS `eg_killfeed_clans` (
    `id` INT AUTO_INCREMENT,
    `tag` VARCHAR(8) NOT NULL UNIQUE,
    `name` VARCHAR(50) NOT NULL,
    `owner_identifier` VARCHAR(60) NOT NULL,
    `icon` VARCHAR(50) DEFAULT 'pi-users',
    `color` VARCHAR(7) DEFAULT '#57B657',
    `is_private` TINYINT(1) DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_tag` (`tag`),
    INDEX `idx_owner` (`owner_identifier`)
);

CREATE TABLE IF NOT EXISTS `eg_killfeed_clan_members` (
    `clan_id` INT NOT NULL,
    `identifier` VARCHAR(60) NOT NULL,
    `player_name` VARCHAR(100) DEFAULT 'Unknown',
    `joined_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`clan_id`, `identifier`),
    FOREIGN KEY (`clan_id`) REFERENCES `eg_killfeed_clans`(`id`) ON DELETE CASCADE,
    INDEX `idx_identifier` (`identifier`)
);

CREATE TABLE IF NOT EXISTS `eg_killfeed_clan_invitations` (
    `id` INT AUTO_INCREMENT,
    `clan_id` INT NOT NULL,
    `target_identifier` VARCHAR(60) NOT NULL,
    `invited_by` VARCHAR(60) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_invite` (`clan_id`, `target_identifier`),
    FOREIGN KEY (`clan_id`) REFERENCES `eg_killfeed_clans`(`id`) ON DELETE CASCADE,
    INDEX `idx_target` (`target_identifier`)
);
