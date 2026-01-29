CREATE TABLE IF NOT EXISTS `tgiann_stats_kill_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `killer_citizenid` varchar(50) DEFAULT NULL,
  `victim_citizenid` varchar(50) NOT NULL,
  `death_type` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_killer` (`killer_citizenid`),
  KEY `idx_victim` (`victim_citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_money_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `action_type` enum('add','remove') NOT NULL,
  `amount` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `accountType` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_player_hourly_positions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_player_sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `login_at` datetime NOT NULL,
  `logout_at` datetime DEFAULT NULL,
  `afk_seconds` int(11) DEFAULT 0,
  `active_seconds` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_citizenid` (`citizenid`),
  KEY `idx_login` (`login_at`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_server_hourly_online` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `online_count` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_player_disconnects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `disconnect_at` datetime NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `client_drop_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `disconnect_at` (`disconnect_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tgiann_stats_player_identifiers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier_type` varchar(50) NOT NULL,
  `identifier_value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_identifier` (`identifier_type`, `identifier_value`),
  KEY `idx_type` (`identifier_type`),
  KEY `idx_value` (`identifier_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_player_identifier_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `identifier_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_mapping` (`citizenid`, `identifier_id`),
  KEY `idx_citizenid` (`citizenid`),
  KEY `idx_identifier_id` (`identifier_id`),
  FOREIGN KEY (`identifier_id`) REFERENCES `tgiann_stats_player_identifiers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_stats_chat_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `chat_type` varchar(50) DEFAULT 'normal',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_citizenid` (`citizenid`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_chat_type` (`chat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;