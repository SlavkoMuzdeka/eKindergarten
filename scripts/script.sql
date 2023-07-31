-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eKindergarten
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eKindergarten
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eKindergarten` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `eKindergarten` ;

-- -----------------------------------------------------
-- Table `eKindergarten`.`ADDRESS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`ADDRESS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `number` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`PERSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`PERSON` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `imbd` CHAR(13) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `dateOfBirth` DATE NOT NULL,
  `ADDRESS_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `JMB_UNIQUE` (`imbd` ASC) VISIBLE,
  INDEX `fk_PERSON_ADDRESS1_idx` (`ADDRESS_id` ASC) VISIBLE,
  CONSTRAINT `fk_PERSON_ADDRESS1`
    FOREIGN KEY (`ADDRESS_id`)
    REFERENCES `eKindergarten`.`ADDRESS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`EDUCATOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`EDUCATOR` (
  `salary` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `PERSON_id` INT NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  INDEX `fk_VASPITAC_PERSON1_idx` (`PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_VASPITAC_PERSON1`
    FOREIGN KEY (`PERSON_id`)
    REFERENCES `eKindergarten`.`PERSON` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`ADMIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`ADMIN` (
  `salary` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `PERSON_id` INT NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  CONSTRAINT `fk_ADMIN_PERSON1`
    FOREIGN KEY (`PERSON_id`)
    REFERENCES `eKindergarten`.`PERSON` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`CHILD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`CHILD` (
  `height` INT NOT NULL,
  `weight` INT NOT NULL,
  `PERSON_id` INT NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  INDEX `fk_DIJETE_PERSON1_idx` (`PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_DIJETE_PERSON1`
    FOREIGN KEY (`PERSON_id`)
    REFERENCES `eKindergarten`.`PERSON` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`GROUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`GROUP` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `numberOfMembers` INT NOT NULL,
  `isActive` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `NazivGrupe_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`KINDERGARTEN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`KINDERGARTEN` (
  `name` VARCHAR(50) NOT NULL,
  `phoneNumber` VARCHAR(50) NOT NULL,
  `ADDRESS_id` INT NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_KINDERGARTEN_ADDRESS1_idx` (`ADDRESS_id` ASC) VISIBLE,
  CONSTRAINT `fk_KINDERGARTEN_ADDRESS1`
    FOREIGN KEY (`ADDRESS_id`)
    REFERENCES `eKindergarten`.`ADDRESS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`HYGIENE_TEST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`HYGIENE_TEST` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  `date` DATE NOT NULL,
  `period` TINYINT NOT NULL,
  `EDUCATOR_PERSON_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_HYGIENE_TEST_EDUCATOR1_idx` (`EDUCATOR_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_HYGIENE_TEST_EDUCATOR1`
    FOREIGN KEY (`EDUCATOR_PERSON_id`)
    REFERENCES `eKindergarten`.`EDUCATOR` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`MEDICAL_CLEARANCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`MEDICAL_CLEARANCE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  `date` DATE NOT NULL,
  `period` TINYINT NOT NULL,
  `EDUCATOR_PERSON_id` INT NULL,
  `CHILD_PERSON_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_MEDICAL_CLEARANCE_EDUCATOR1_idx` (`EDUCATOR_PERSON_id` ASC) VISIBLE,
  INDEX `fk_MEDICAL_CLEARANCE_CHILD1_idx` (`CHILD_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_MEDICAL_CLEARANCE_EDUCATOR1`
    FOREIGN KEY (`EDUCATOR_PERSON_id`)
    REFERENCES `eKindergarten`.`EDUCATOR` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEDICAL_CLEARANCE_CHILD1`
    FOREIGN KEY (`CHILD_PERSON_id`)
    REFERENCES `eKindergarten`.`CHILD` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`NOTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`NOTE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `CHILD_PERSON_id` INT NOT NULL,
  PRIMARY KEY (`id`, `CHILD_PERSON_id`),
  INDEX `fk_NOTE_CHILD1_idx` (`CHILD_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_NOTE_CHILD1`
    FOREIGN KEY (`CHILD_PERSON_id`)
    REFERENCES `eKindergarten`.`CHILD` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`ARRIVAL_DEPARTURE_TIME`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`ARRIVAL_DEPARTURE_TIME` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dateTime` DATETIME NOT NULL,
  `CHILD_PERSON_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ARRIVAL_DEPARTURE_TIME_CHILD1_idx` (`CHILD_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_ARRIVAL_DEPARTURE_TIME_CHILD1`
    FOREIGN KEY (`CHILD_PERSON_id`)
    REFERENCES `eKindergarten`.`CHILD` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`ACTIVITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`ACTIVITY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`MEMBERSHIP_FEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`MEMBERSHIP_FEE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(100) NOT NULL,
  `amoun` INT NOT NULL,
  `isPaid` TINYINT NULL,
  `date` DATE NOT NULL,
  `dateOfPaymant` DATE NULL,
  `CHILD_PERSON_id` INT NOT NULL,
  PRIMARY KEY (`id`, `CHILD_PERSON_id`),
  INDEX `fk_MEMBERSHIP_FEE_CHILD1_idx` (`CHILD_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_MEMBERSHIP_FEE_CHILD1`
    FOREIGN KEY (`CHILD_PERSON_id`)
    REFERENCES `eKindergarten`.`CHILD` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`ACCOUNT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`ACCOUNT` (
  `number` CHAR(16) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `amount` INT NOT NULL,
  `date` DATE NOT NULL,
  `isPaid` TINYINT NOT NULL,
  `KINDERGARTEN_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`number`),
  INDEX `fk_ACCOUNT_KINDERGARTEN1_idx` (`KINDERGARTEN_name` ASC) VISIBLE,
  CONSTRAINT `fk_ACCOUNT_KINDERGARTEN1`
    FOREIGN KEY (`KINDERGARTEN_name`)
    REFERENCES `eKindergarten`.`KINDERGARTEN` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`ACTIVITY_has_GROUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`ACTIVITY_has_GROUP` (
  `ACTIVITY_id` INT NOT NULL,
  `GROUP_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `period` INT NOT NULL,
  PRIMARY KEY (`ACTIVITY_id`, `GROUP_id`, `date`),
  INDEX `fk_ACTIVITY_has_GROUP_GROUP1_idx` (`GROUP_id` ASC) VISIBLE,
  INDEX `fk_ACTIVITY_has_GROUP_ACTIVITY1_idx` (`ACTIVITY_id` ASC) VISIBLE,
  CONSTRAINT `fk_ACTIVITY_has_GROUP_ACTIVITY1`
    FOREIGN KEY (`ACTIVITY_id`)
    REFERENCES `eKindergarten`.`ACTIVITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTIVITY_has_GROUP_GROUP1`
    FOREIGN KEY (`GROUP_id`)
    REFERENCES `eKindergarten`.`GROUP` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`EDUCATOR_has_GROUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`EDUCATOR_has_GROUP` (
  `EDUCATOR_PERSON_id` INT NOT NULL,
  `GROUP_id` INT NOT NULL,
  `electionDate` DATE NOT NULL,
  `period` INT NOT NULL,
  PRIMARY KEY (`EDUCATOR_PERSON_id`, `GROUP_id`, `electionDate`),
  INDEX `fk_EDUCATOR_has_GROUP_GROUP1_idx` (`GROUP_id` ASC) VISIBLE,
  INDEX `fk_EDUCATOR_has_GROUP_EDUCATOR1_idx` (`EDUCATOR_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_EDUCATOR_has_GROUP_EDUCATOR1`
    FOREIGN KEY (`EDUCATOR_PERSON_id`)
    REFERENCES `eKindergarten`.`EDUCATOR` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EDUCATOR_has_GROUP_GROUP1`
    FOREIGN KEY (`GROUP_id`)
    REFERENCES `eKindergarten`.`GROUP` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eKindergarten`.`CHILD_has_GROUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eKindergarten`.`CHILD_has_GROUP` (
  `CHILD_PERSON_id` INT NOT NULL,
  `GROUP_id` INT NOT NULL,
  `period` INT NOT NULL,
  `electionDate` DATE NOT NULL,
  PRIMARY KEY (`CHILD_PERSON_id`, `electionDate`),
  INDEX `fk_CHILD_has_GROUP_GROUP1_idx` (`GROUP_id` ASC) VISIBLE,
  INDEX `fk_CHILD_has_GROUP_CHILD1_idx` (`CHILD_PERSON_id` ASC) VISIBLE,
  CONSTRAINT `fk_CHILD_has_GROUP_CHILD1`
    FOREIGN KEY (`CHILD_PERSON_id`)
    REFERENCES `eKindergarten`.`CHILD` (`PERSON_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHILD_has_GROUP_GROUP1`
    FOREIGN KEY (`GROUP_id`)
    REFERENCES `eKindergarten`.`GROUP` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
