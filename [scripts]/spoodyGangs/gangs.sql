CREATE TABLE IF NOT EXISTS `gangs` (
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `stats` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT '{}',
  `ranks` longtext DEFAULT '{}',
  `base` text DEFAULT NULL,
  `maxroles` tinyint(4) DEFAULT NULL,
  `strikes` tinyint(4) DEFAULT NULL,
  `warData` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `gangs_turfseason` (
  `lock` char(1) NOT NULL DEFAULT 'X',
  `label` varchar(255) NOT NULL,
  `endsAt` date NOT NULL,
  `stats` longtext DEFAULT NULL,
  PRIMARY KEY (`lock`),
  CONSTRAINT `chk_turfSeason_lock` CHECK (`lock` = 'X')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `users`
    ADD COLUMN `gang_name` VARCHAR(50) NULL DEFAULT NULL,
    ADD COLUMN `gang_rank` VARCHAR(50) NULL DEFAULT NULL;