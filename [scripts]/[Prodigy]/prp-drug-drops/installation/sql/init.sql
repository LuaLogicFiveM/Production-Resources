CREATE TABLE IF NOT EXISTS `drug_drop_times` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `zone_id` VARCHAR(50) NOT NULL,
    `route_index` INT NOT NULL,
    `completion_time` INT NOT NULL,
    `state_ids` TEXT NOT NULL,
    `completed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_zone_route` (`zone_id`, `route_index`),
    INDEX `idx_completion_time` (`completion_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;