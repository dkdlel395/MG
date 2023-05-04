CREATE DATABASE dog_db;

USE dog_db;

CREATE TABLE `auth` (
	`no` VARCHAR(2) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`auth` VARCHAR(2) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`no`) USING BTREE
);

CREATE TABLE `species_information` (
	`no` INT(11) NOT NULL,
	`species_name` CHAR(10) NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`no`) USING BTREE
);

CREATE TABLE `user` (
	`user_id` CHAR(15) NOT NULL COLLATE 'utf8mb4_general_ci',
	`user_pw` CHAR(64) NOT NULL COLLATE 'utf8mb4_general_ci',
	`user_name` CHAR(6) NOT NULL COLLATE 'utf8mb4_general_ci',
	`user_nickname` CHAR(15) NOT NULL COLLATE 'utf8mb4_general_ci',
	`identity_number` CHAR(13) NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` CHAR(11) NOT NULL COLLATE 'utf8mb4_general_ci',
	`address` CHAR(64) NOT NULL COLLATE 'utf8mb4_general_ci',
	`business_number` CHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`auth` VARCHAR(2) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`user_id`) USING BTREE,
	INDEX `auth` (`auth`) USING BTREE,
	CONSTRAINT `fk_user_auth` FOREIGN KEY (`auth`) REFERENCES `dog_db`.`auth` (`no`) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE `abandoned_animal` (
	`animal_id` CHAR(15) NOT NULL COLLATE 'utf8mb4_general_ci',
	`animal_name` CHAR(10) NOT NULL COLLATE 'utf8mb4_general_ci',
	`species` INT(11) NOT NULL,
	`gender` CHAR(2) NOT NULL COLLATE 'utf8mb4_general_ci',
	`age` INT(11) NOT NULL,
	`weight` FLOAT NOT NULL,
	`personality` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`reason_for_abandonment` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`potty_training` BIT(1) NULL DEFAULT b'0',
	`abuse` BIT(1) NULL DEFAULT b'0',
	`disease` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`shyness` INT(11) NULL DEFAULT NULL,
	`loneliness` INT(11) NULL DEFAULT NULL,
	`introduction` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`location` CHAR(64) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`shelter_name` CHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`increased_friends` INT(11) NULL DEFAULT NULL,
	`total_friends` INT(11) NULL DEFAULT NULL,
	`upload_status` CHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`registration_date` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`animal_id`) USING BTREE,
	INDEX `fk_abandoned_animal_species_information` (`species`) USING BTREE,
	CONSTRAINT `fk_abandoned_animal_species_information` FOREIGN KEY (`species`) REFERENCES `dog_db`.`species_information` (`no`) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE `species_for_mbti` (
	`mbti` CHAR(4) NOT NULL COLLATE 'utf8mb4_general_ci',
	`species_one` INT(11) NOT NULL,
	`species_two` INT(11) NOT NULL,
	PRIMARY KEY (`mbti`) USING BTREE,
	INDEX `fk_species_for_mbti_species_one` (`species_one`) USING BTREE,
	INDEX `fk_species_for_mbti_species_two` (`species_two`) USING BTREE,
	CONSTRAINT `fk_species_for_mbti_species_one` FOREIGN KEY (`species_one`) REFERENCES `dog_db`.`abandoned_animal` (`species`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_species_for_mbti_species_two` FOREIGN KEY (`species_two`) REFERENCES `dog_db`.`abandoned_animal` (`species`) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE `mbti_information` (
	`user_id` CHAR(15) NOT NULL COLLATE 'utf8mb4_general_ci',
	`size` CHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`age` CHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`personality` CHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`disease` CHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`shyness` CHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`loneliness` CHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`mbti_type` CHAR(4) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	INDEX `fk_mbti_information_user_id` (`user_id`) USING BTREE,
	CONSTRAINT `fk_mbti_information_user_id` FOREIGN KEY (`user_id`) REFERENCES `dog_db`.`user` (`user_id`) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE `friend_list` (
	`no` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` CHAR(15) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`animal_id` CHAR(15) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`no`) USING BTREE,
	INDEX `fk_friend_list_user_id` (`user_id`) USING BTREE,
	INDEX `fk_friend_list_animal_id` (`animal_id`) USING BTREE,
	CONSTRAINT `fk_friend_list_animal_id` FOREIGN KEY (`animal_id`) REFERENCES `dog_db`.`abandoned_animal` (`animal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_friend_list_user_id` FOREIGN KEY (`user_id`) REFERENCES `dog_db`.`user` (`user_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE `chat` (
	`no` INT(11) NOT NULL AUTO_INCREMENT,
	`friend_list_no` INT(11) NULL DEFAULT NULL,
	`chat_content` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`sent_or_received` BIT(1) NULL DEFAULT b'0',
	`chat_date` DATE NULL DEFAULT NULL,
	`suitability_type` CHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`suitability` BIT(1) NULL DEFAULT b'0',
	PRIMARY KEY (`no`) USING BTREE,
	INDEX `fk_chat_friend_list_no` (`friend_list_no`) USING BTREE,
	CONSTRAINT `fk_chat_friend_list_no` FOREIGN KEY (`friend_list_no`) REFERENCES `dog_db`.`friend_list` (`no`) ON UPDATE NO ACTION ON DELETE NO ACTION
);