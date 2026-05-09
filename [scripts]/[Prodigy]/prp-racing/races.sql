CREATE TABLE IF NOT EXISTS `racing_seasons` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL DEFAULT '',
    `startDate` datetime NOT NULL DEFAULT current_timestamp(),
    `endDate` datetime NOT NULL,
    `isCurrent` tinyint(4) NOT NULL DEFAULT 0,
    `isFinished` tinyint(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `isCurrent` (`isCurrent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `racing_crews` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL DEFAULT '',
    `tag` varchar(50) NOT NULL DEFAULT '',
    `color` varchar(50) NOT NULL DEFAULT '',
    `members` longtext NOT NULL DEFAULT '{}',
    `roles` LONGTEXT NOT NULL DEFAULT '{}',
    `owner` VARCHAR(255) NULL,
    `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
    `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `name` (`name`),
    KEY `tag` (`tag`),
    KEY `isDeleted` (`isDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `racing_users` (
    `stateId` varchar(255) NOT NULL,
    `nickname` varchar(50) NOT NULL DEFAULT '',
    `incognito` tinyint(1) NOT NULL DEFAULT 0,
    `profilePicture` text DEFAULT NULL,
    `crew` int(11) DEFAULT NULL,
    `euTimezone` tinyint(4) NOT NULL DEFAULT 0,
    `dailyEnd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `gotDaily` tinyint(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`stateId`),
    KEY `nickname` (`nickname`),
    KEY `crew` (`crew`),
    CONSTRAINT `racing_users_ibfk_1` FOREIGN KEY (`crew`) REFERENCES `racing_crews` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
    
CREATE TABLE IF NOT EXISTS `racing_tracks` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL DEFAULT 'Invalid name',
    `creatorStateId` varchar(255) NOT NULL DEFAULT 0,
    `checkpoints` longtext NOT NULL DEFAULT '{}',
    `props` LONGTEXT NOT NULL DEFAULT '[]',
    `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
    `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
    `isPublished` tinyint(1) NOT NULL DEFAULT 0,
    `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
    `isOfficial` tinyint(1) NOT NULL DEFAULT 0,
    `isVerified` tinyint(1) NOT NULL DEFAULT 0,
    `isFeatured` tinyint(1) NOT NULL DEFAULT 0,
    `isSprint` tinyint(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `name` (`name`),
    KEY `creatorStateId` (`creatorStateId`),
    KEY `isDeleted` (`isDeleted`),
    KEY `isOfficial` (`isOfficial`),
    KEY `isVerified` (`isVerified`),
    KEY `isFeatured` (`isFeatured`),
    KEY `createdAt` (`createdAt`),
    KEY `isPublished` (`isPublished`),
    KEY `isSprint` (`isSprint`),
    CONSTRAINT `racing_tracks_ibfk_1` FOREIGN KEY (`creatorStateId`) REFERENCES `racing_users` (`stateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `racing_tournaments` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `creatorStateId` varchar(255) NOT NULL,
    `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
    `isPublished` tinyint(4) NOT NULL DEFAULT 0,
    `isDeleted` tinyint(4) NOT NULL DEFAULT 0,
    `isFeatured` tinyint(4) NOT NULL DEFAULT 0,
    `tournamentType` tinyint(4) NOT NULL DEFAULT 0,
    `races` longtext NOT NULL DEFAULT '[]',
    `battleBo` tinyint(4) NOT NULL DEFAULT 0,
    `players` longtext NOT NULL DEFAULT '[]',
    `status` tinyint(4) NOT NULL DEFAULT 0,
    `battles` longtext DEFAULT '{}',
    PRIMARY KEY (`id`),
    KEY `creatorStateId` (`creatorStateId`),
    KEY `createdAt` (`createdAt`),
    KEY `isDeleted` (`isDeleted`),
    KEY `isFeatured` (`isFeatured`),
    KEY `tournamentType` (`tournamentType`),
    KEY `status` (`status`),
    CONSTRAINT `racing_tournaments_ibfk_1` FOREIGN KEY (`creatorStateId`) REFERENCES `racing_users` (`stateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `racing_tracks_favourites` (
    `stateId` varchar(255) NOT NULL,
    `trackId` int(11) NOT NULL,
    UNIQUE KEY `stateId_trackId` (`stateId`,`trackId`),
    KEY `trackId` (`trackId`),
    KEY `stateId` (`stateId`),
    CONSTRAINT `racing_tracks_favourites_ibfk_1` FOREIGN KEY (`trackId`) REFERENCES `racing_tracks` (`id`),
    CONSTRAINT `racing_tracks_favourites_ibfk_2` FOREIGN KEY (`stateId`) REFERENCES `racing_users` (`stateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `racing_elo` (
    `stateId` varchar(255) DEFAULT NULL,
    `crewId` int(11) DEFAULT NULL,
    `season` int(11) DEFAULT NULL,
    `tournament` int(11) DEFAULT NULL,
    `elo` int(11) unsigned DEFAULT NULL,
    UNIQUE KEY `stateId_season` (`stateId`,`season`),
    UNIQUE KEY `stateId_tournament` (`stateId`,`tournament`),
    UNIQUE KEY `crewId_season` (`crewId`,`season`),
    UNIQUE KEY `crewId_tournament` (`crewId`,`tournament`),
    KEY `season` (`season`),
    KEY `tournament` (`tournament`),
    KEY `stateId` (`stateId`),
    KEY `crewId` (`crewId`),
    KEY `elo` (`elo`),
    CONSTRAINT `racing_elo_ibfk_1` FOREIGN KEY (`stateId`) REFERENCES `racing_users` (`stateId`),
    CONSTRAINT `racing_elo_ibfk_2` FOREIGN KEY (`season`) REFERENCES `racing_seasons` (`id`),
    CONSTRAINT `racing_elo_ibfk_3` FOREIGN KEY (`tournament`) REFERENCES `racing_tournaments` (`id`),
    CONSTRAINT `racing_elo_ibfk_4` FOREIGN KEY (`crewId`) REFERENCES `racing_crews` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS racing_crew_battles (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `crew1` INT,
    `crew2` INT,
    `crew1Members` LONGTEXT,
    `crew2Members` LONGTEXT,
    `status` INT,
    `type` INT,
    `classes` LONGTEXT,
    `bet` INT,
    `currency` VARCHAR(255),
    `winner` VARCHAR(255),
    `eloChange` INT,
    `battles` LONGTEXT,
    `season` INT,
    `startTime` timestamp NOT NULL,
    FOREIGN KEY (crew1) REFERENCES racing_crews(id),
    FOREIGN KEY (crew2) REFERENCES racing_crews(id),
    FOREIGN KEY (season) REFERENCES racing_seasons(id)
);

CREATE TABLE IF NOT EXISTS `racing_races` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `raceName` varchar(50) NOT NULL DEFAULT '',
    `raceMode` VARCHAR(255) NOT NULL DEFAULT 'pre-patch',
    `vehicleClass` longtext NOT NULL,
    `trackId` int(11) NOT NULL DEFAULT 0,
    `ownerStateId` varchar(255) NOT NULL DEFAULT 0,
    `startTime` timestamp NOT NULL,
    `status` tinyint(4) NOT NULL DEFAULT 0,
    `maxPlayers` int(11) unsigned NOT NULL DEFAULT 0,
    `minPlayers` int(11) unsigned NOT NULL DEFAULT 0,
    `maxLaps` tinyint(4) unsigned NOT NULL DEFAULT 0,
    `maxTimeAfterFirstFinish` int(11) unsigned NOT NULL DEFAULT 0,
    `season` int(11) DEFAULT 0,
    `tournament` int(11) DEFAULT 0,
    `ghostEnabled` tinyint(4) NOT NULL DEFAULT 0,
    `reverseRoute` tinyint(4) NOT NULL DEFAULT 0,
    `requiredBid` DOUBLE NOT NULL DEFAULT 0,
    `isFirstPerson` tinyint(4) NOT NULL DEFAULT 0,
    `crewBattle` INT NULL,
    `isPrivate` tinyint(4) NOT NULL DEFAULT 1,
    `password` varchar(255),
    `euTimezone` tinyint(4) NOT NULL DEFAULT 0,
    `additionalReward` DOUBLE NOT NULL DEFAULT 0,
    `positionRewards` LONGTEXT NOT NULL DEFAULT '[]',
    `currency` VARCHAR(255) DEFAULT 'BANK' NOT NULL,
    PRIMARY KEY (`id`),
    KEY `raceName` (`raceName`),
    KEY `trackId` (`trackId`),
    KEY `startTime` (`startTime`),
    KEY `ownerStateId` (`ownerStateId`),
    KEY `status` (`status`),
    KEY `season` (`season`),
    KEY `tournament` (`tournament`),
    CONSTRAINT `racing_races_ibfk_1` FOREIGN KEY (`trackId`) REFERENCES `racing_tracks` (`id`),
    CONSTRAINT `racing_races_ibfk_2` FOREIGN KEY (`ownerStateId`) REFERENCES `racing_users` (`stateId`),
    CONSTRAINT `racing_races_ibfk_3` FOREIGN KEY (`tournament`) REFERENCES `racing_tournaments` (`id`),
    CONSTRAINT `racing_races_ibfk_4` FOREIGN KEY (`season`) REFERENCES `racing_seasons` (`id`),
    CONSTRAINT `racing_races_ibfk_5` FOREIGN KEY (`crewBattle`) REFERENCES `racing_crew_battles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `racing_player_races` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `stateId` varchar(255) NOT NULL,
    `raceId` int(11) NOT NULL,
    `vehiclePlate` varchar(255) NOT NULL DEFAULT '',
    `state` tinyint(4) NOT NULL DEFAULT 0,
    `eloChange` int(11) NOT NULL DEFAULT 0,
    `time` int(11) unsigned DEFAULT 0,
    `vehicleClass` varchar(50) NOT NULL DEFAULT 'A',
    `lapTimes` longtext NOT NULL DEFAULT '[]',
    `fastestLap` int(10) unsigned DEFAULT NULL,
    `position` int(11) unsigned DEFAULT NULL,
    `reward` DOUBLE NOT NULL DEFAULT 0,
    `currency` VARCHAR(255) DEFAULT 'BANK' NOT NULL,
    `anonymousName` varchar(255) NULL,
    PRIMARY KEY (`id`),
    KEY `stateId` (`stateId`),
    KEY `raceId` (`raceId`),
    KEY `vehiclePlate` (`vehiclePlate`),
    KEY `time` (`time`),
    KEY `position` (`position`),
    KEY `state` (`state`),
    KEY `vehicleClass` (`vehicleClass`),
    KEY `fastestLap` (`fastestLap`),
    CONSTRAINT `racing_player_races_ibfk_1` FOREIGN KEY (`raceId`) REFERENCES `racing_races` (`id`),
    CONSTRAINT `racing_player_races_ibfk_2` FOREIGN KEY (`stateId`) REFERENCES `racing_users` (`stateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS racing_season_rewards (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `stateId` VARCHAR(255),
    `season` INT,
    `description` VARCHAR(255) NOT NULL,
    `items` JSON,
    `claimed` TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (`stateId`) REFERENCES `racing_users`(`stateId`),
    FOREIGN KEY (`season`) REFERENCES `racing_seasons`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `vehicles_pink_claims` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `status` tinyint(4) NOT NULL,
    `plate` varchar(250) NOT NULL,
    `claimed_by` varchar(255) DEFAULT NULL,
    `claim_created` timestamp NOT NULL DEFAULT current_timestamp(),
    `claimed_at` timestamp NULL DEFAULT NULL,
    `notified_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;