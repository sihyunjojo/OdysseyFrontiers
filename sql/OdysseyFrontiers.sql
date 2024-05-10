-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema enjoytrip
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema enjoytrip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `enjoytrip` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `enjoytrip` ;

-- -----------------------------------------------------
-- Table `enjoytrip`.`sido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`sido` (
  `sido_code` INT NOT NULL,
  `sido_name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`sido_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `enjoytrip`.`gugun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`gugun` (
  `gugun_code` INT NOT NULL,
  `gugun_name` VARCHAR(30) NULL DEFAULT NULL,
  `sido_code` INT NOT NULL,
  PRIMARY KEY (`gugun_code`, `sido_code`),
  INDEX `gugun_to_sido_sido_code_fk_idx` (`sido_code` ASC) VISIBLE,
  CONSTRAINT `gugun_to_sido_sido_code_fk`
    FOREIGN KEY (`sido_code`)
    REFERENCES `enjoytrip`.`sido` (`sido_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_info` (
  `content_id` INT NOT NULL,
  `content_type_id` INT NULL DEFAULT NULL,
  `title` VARCHAR(100) NULL DEFAULT NULL,
  `addr1` VARCHAR(100) NULL DEFAULT NULL,
  `addr2` VARCHAR(50) NULL DEFAULT NULL,
  `zipcode` VARCHAR(50) NULL DEFAULT NULL,
  `tel` VARCHAR(50) NULL DEFAULT NULL,
  `first_image` VARCHAR(200) NULL DEFAULT NULL,
  `first_image2` VARCHAR(200) NULL DEFAULT NULL,
  `readcount` INT NULL DEFAULT NULL,
  `sido_code` INT NULL DEFAULT NULL,
  `gugun_code` INT NULL DEFAULT NULL,
  `latitude` DECIMAL(20,17) NULL DEFAULT NULL,
  `longitude` DECIMAL(20,17) NULL DEFAULT NULL,
  `mlevel` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  INDEX `attraction_to_content_type_id_fk_idx` (`content_type_id` ASC) VISIBLE,
  INDEX `attraction_to_sido_code_fk_idx` (`sido_code` ASC) VISIBLE,
  INDEX `attraction_to_gugun_code_fk_idx` (`gugun_code` ASC) VISIBLE,
  CONSTRAINT `attraction_to_content_type_id_fk`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `enjoytrip`.`content_type` (`content_type_id`),
  CONSTRAINT `attraction_to_gugun_code_fk`
    FOREIGN KEY (`gugun_code`)
    REFERENCES `enjoytrip`.`gugun` (`gugun_code`),
  CONSTRAINT `attraction_to_sido_code_fk`
    FOREIGN KEY (`sido_code`)
    REFERENCES `enjoytrip`.`sido` (`sido_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attachments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attachments` (
  `attachment_id` BIGINT NOT NULL AUTO_INCREMENT,
  `content_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'undifine',
  `path` VARCHAR(200) NOT NULL,
  `type` ENUM('IMAGE', 'ZIP', 'ETC') NOT NULL,
  PRIMARY KEY (`attachment_id`),
  INDEX `fk_attachments_attraction_info1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_attachments_attraction_info1`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`attraction_info` (`content_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_description`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_description` (
  `content_id` INT NOT NULL,
  `homepage` VARCHAR(100) NULL DEFAULT NULL,
  `overview` VARCHAR(10000) NULL DEFAULT NULL,
  `telname` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  CONSTRAINT `attraction_detail_to_attraciton_id_fk`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`attraction_info` (`content_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_detail` (
  `content_id` INT NOT NULL,
  `cat1` VARCHAR(3) NULL DEFAULT NULL,
  `cat2` VARCHAR(5) NULL DEFAULT NULL,
  `cat3` VARCHAR(9) NULL DEFAULT NULL,
  `created_time` VARCHAR(14) NULL DEFAULT NULL,
  `modified_time` VARCHAR(14) NULL DEFAULT NULL,
  `booktour` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  CONSTRAINT `attraction_detail_to_basic_content_id_fk`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`attraction_info` (`content_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `enjoytrip`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`members` (
  `member_id` BIGINT NOT NULL,
  `member_name` VARCHAR(20) NOT NULL,
  `member_password` VARCHAR(16) NOT NULL,
  `email_id` VARCHAR(20) NOT NULL,
  `email_domain` VARCHAR(45) NOT NULL,
  `member_phone` VARCHAR(20) NOT NULL,
  `member_address` TEXT NULL DEFAULT NULL,
  `join_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('ACTIVE', 'INACTIVE', 'ADMIN') NOT NULL DEFAULT 'ACTIVE',
  `image` VARCHAR(45) NULL,
  `birthday` DATETIME NOT NULL,
  PRIMARY KEY (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_hit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_hit` (
  `member_id` BIGINT NOT NULL,
  `content_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`, `content_id`),
  INDEX `fk_hit_copy1_attraction_info1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_hit_copy1_attraction_info1`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`attraction_info` (`content_id`),
  CONSTRAINT `fk_hit_members10`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_like` (
  `member_id` BIGINT NOT NULL,
  `content_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`, `content_id`),
  INDEX `fk_like_attraction_info1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_attraction_info1`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`attraction_info` (`content_id`),
  CONSTRAINT `fk_like_members1`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`board` (
  `board_no` BIGINT NOT NULL AUTO_INCREMENT,
  `member_id` BIGINT NOT NULL,
  `subject` VARCHAR(100) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `register_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` ENUM('notice', 'community') NOT NULL,
  PRIMARY KEY (`board_no`),
  INDEX `board_to_members_member_id_fk` (`member_id` ASC) VISIBLE,
  CONSTRAINT `board_to_members_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`board_hit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`board_hit` (
  `board_hit_id` BIGINT NOT NULL AUTO_INCREMENT,
  `member_id` BIGINT NOT NULL,
  `board_no` BIGINT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_hit_id`),
  INDEX `fk_hit_board1_idx` (`board_no` ASC) VISIBLE,
  INDEX `fk_hit_members1` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_hit_board1`
    FOREIGN KEY (`board_no`)
    REFERENCES `enjoytrip`.`board` (`board_no`),
  CONSTRAINT `fk_hit_members1`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`board_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`board_like` (
  `member_id` BIGINT NOT NULL,
  `board_no` BIGINT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`, `board_no`),
  INDEX `fk_plan_like_copy1_board1_idx` (`board_no` ASC) VISIBLE,
  CONSTRAINT `fk_like_members100`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`),
  CONSTRAINT `fk_plan_like_copy1_board1`
    FOREIGN KEY (`board_no`)
    REFERENCES `enjoytrip`.`board` (`board_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`comments` (
  `comment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` BIGINT NOT NULL,
  `board_no` BIGINT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `register_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comments_board1_idx` (`board_no` ASC) VISIBLE,
  INDEX `fk_comments_members1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_board1`
    FOREIGN KEY (`board_no`)
    REFERENCES `enjoytrip`.`board` (`board_no`),
  CONSTRAINT `fk_comments_members1`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`followers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`followers` (
  `follower_id` VARCHAR(16) NOT NULL,
  `following_id` VARCHAR(16) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follower_id`, `following_id`),
  INDEX `fk_followers_members1_idx` (`follower_id` ASC) VISIBLE,
  INDEX `fk_followers_members2_idx` (`following_id` ASC) VISIBLE,
  CONSTRAINT `fk_followers_members1`
    FOREIGN KEY (`follower_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`),
  CONSTRAINT `fk_followers_members2`
    FOREIGN KEY (`following_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`plan` (
  `plan_id` BIGINT NOT NULL AUTO_INCREMENT,
  `member_id` BIGINT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  `season` ENUM('SPRING', 'SUMMER', 'FALL', 'WINTER', 'ETC') NOT NULL DEFAULT 'ETC',
  `start_time` DATETIME NULL DEFAULT NULL,
  `access_type` ENUM('PUBLIC', 'PRIVATE') NULL DEFAULT NULL,
  `recent_update_time` DATETIME NOT NULL,
  PRIMARY KEY (`plan_id`),
  INDEX `fk_plan_members1` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_plan_members1`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`plan_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`plan_detail` (
  `plan_detail_id` BIGINT NOT NULL AUTO_INCREMENT,
  `plan_id` BIGINT NOT NULL,
  `day` VARCHAR(45) NOT NULL,
  `content_id` INT NOT NULL,
  `plan_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`plan_detail_id`),
  INDEX `fk_plan_detail_attraction_info1_idx` (`content_id` ASC) VISIBLE,
  INDEX `fk_plan_detail_plan1_idx` (`plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_plan_detail_attraction_info1`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`attraction_info` (`content_id`),
  CONSTRAINT `fk_plan_detail_plan1`
    FOREIGN KEY (`plan_id`)
    REFERENCES `enjoytrip`.`plan` (`plan_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`plan_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`plan_like` (
  `member_id` BIGINT NOT NULL,
  `plan_id` BIGINT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`, `plan_id`),
  INDEX `fk_plan_like_plan1_idx` (`plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_members10`
    FOREIGN KEY (`member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`),
  CONSTRAINT `fk_plan_like_plan1`
    FOREIGN KEY (`plan_id`)
    REFERENCES `enjoytrip`.`plan` (`plan_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`member_search_hit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`member_search_hit` (
  `member_search_hit_id` BIGINT NOT NULL AUTO_INCREMENT,
  `searching_member_id` VARCHAR(16) NOT NULL,
  `searched_member_id` VARCHAR(16) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_followers_members1_idx` (`searching_member_id` ASC) VISIBLE,
  INDEX `fk_followers_members2_idx` (`searched_member_id` ASC) VISIBLE,
  PRIMARY KEY (`member_search_hit_id`),
  CONSTRAINT `fk_followers_members10`
    FOREIGN KEY (`searching_member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`),
  CONSTRAINT `fk_followers_members20`
    FOREIGN KEY (`searched_member_id`)
    REFERENCES `enjoytrip`.`members` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
