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

CREATE TABLE `g_dutyv2` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`job_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`total_time` BIGINT(20) NULL DEFAULT NULL,
	`last_clock_in` DATETIME NULL DEFAULT NULL,
	`start_time` DATETIME NULL DEFAULT NULL,
	`is_on_duty` TINYINT(1) NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `unique_identifier_job` (`identifier`, `job_name`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;



CREATE TABLE `g_duty_daily` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(46) NOT NULL COLLATE 'utf8mb4_general_ci',
	`job_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`duty_date` DATE NOT NULL,
	`duty_time` BIGINT(20) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `unique_duty` (`identifier`, `job_name`, `duty_date`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;


CREATE TABLE `g_dutyv2_rewards` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(46) NOT NULL COLLATE 'utf8mb4_general_ci',
	`reward_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `unique_claim` (`identifier`, `reward_id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;
