CREATE TABLE IF NOT EXISTS `tgiann_core_lang` (
  `identifier` varchar(255) DEFAULT NULL,
  `lang` varchar(50) DEFAULT NULL,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_core_player_ownable` (
  `keyName` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `rentTime` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `tgiann_core_player_ownable_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyName` varchar(50) DEFAULT NULL,
  `citizenId` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
