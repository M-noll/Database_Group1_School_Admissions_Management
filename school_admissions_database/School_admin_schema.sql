-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema meru_uni_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meru_uni_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `meru_uni_db` DEFAULT CHARACTER SET utf8mb4 ;
USE `meru_uni_db` ;

-- -----------------------------------------------------
-- Table `meru_uni_db`.`program_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`program_level` (
  `program_level_id` INT(11) NOT NULL,
  `program_level_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`program_level_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`schools` (
  `school_id` INT(11) NOT NULL,
  `school_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`school_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`department` (
  `department_id` INT(11) NOT NULL,
  `department_name` VARCHAR(50) NOT NULL,
  `school_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `school_id` (`school_id` ASC) VISIBLE,
  CONSTRAINT `department_ibfk_1`
    FOREIGN KEY (`school_id`)
    REFERENCES `meru_uni_db`.`schools` (`school_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`programs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`programs` (
  `program_id` INT(11) NOT NULL,
  `program_name` VARCHAR(50) NOT NULL,
  `department_id` INT(11) NULL DEFAULT NULL,
  `program_level_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  INDEX `department_id` (`department_id` ASC) VISIBLE,
  INDEX `fk_program_program_level` (`program_level_id` ASC) VISIBLE,
  CONSTRAINT `fk_program_program_level`
    FOREIGN KEY (`program_level_id`)
    REFERENCES `meru_uni_db`.`program_level` (`program_level_id`),
  CONSTRAINT `programs_ibfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `meru_uni_db`.`department` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`branches` (
  `branch_id` INT(11) NOT NULL,
  `branch_name` VARCHAR(50) NULL DEFAULT NULL,
  `accepts_undergraduate` TINYINT(1) NULL DEFAULT NULL,
  `accepts_postgraduate` TINYINT(1) NULL DEFAULT NULL,
  `accepts_shortcourse` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`branch_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`program_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`program_branch` (
  `branch_id` INT(11) NOT NULL,
  `program_id` INT(11) NOT NULL,
  `branch_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`program_id`, `branch_id`),
  INDEX `branch_id` (`branch_id` ASC) VISIBLE,
  CONSTRAINT `program_branch_ibfk_1`
    FOREIGN KEY (`program_id`)
    REFERENCES `meru_uni_db`.`programs` (`program_id`),
  CONSTRAINT `program_branch_ibfk_2`
    FOREIGN KEY (`branch_id`)
    REFERENCES `meru_uni_db`.`branches` (`branch_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`intake`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`intake` (
  `intake_id` INT(11) NOT NULL,
  `intake_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`intake_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`study_mode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`study_mode` (
  `mode_id` INT(11) NOT NULL,
  `mode_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`mode_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`application` (
  `application_id` INT(11) NOT NULL,
  `student_id` INT(11) NULL DEFAULT NULL,
  `program_id` INT(11) NULL DEFAULT NULL,
  `branch_id` INT(11) NULL DEFAULT NULL,
  `intake_intake_id` INT(11) NOT NULL,
  `study_mode_mode_id` INT(11) NOT NULL,
  PRIMARY KEY (`application_id`),
  INDEX `program_id` (`program_id` ASC, `branch_id` ASC) VISIBLE,
  INDEX `fk_application_intake1_idx` (`intake_intake_id` ASC) VISIBLE,
  INDEX `fk_application_study_mode1_idx` (`study_mode_mode_id` ASC) VISIBLE,
  CONSTRAINT `application_ibfk_1`
    FOREIGN KEY (`program_id` , `branch_id`)
    REFERENCES `meru_uni_db`.`program_branch` (`program_id` , `branch_id`),
  CONSTRAINT `fk_application_intake1`
    FOREIGN KEY (`intake_intake_id`)
    REFERENCES `meru_uni_db`.`intake` (`intake_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_study_mode1`
    FOREIGN KEY (`study_mode_mode_id`)
    REFERENCES `meru_uni_db`.`study_mode` (`mode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`students` (
  `student_id` INT(11) NOT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `s_email` VARCHAR(50) NULL DEFAULT NULL,
  `s_phone` VARCHAR(20) NULL DEFAULT NULL,
  `D_O_B` DATE NULL DEFAULT NULL,
  `gender` ENUM('male', 'female', 'other') NULL DEFAULT NULL,
  `marital_stats` VARCHAR(50) NULL DEFAULT NULL,
  `address` VARCHAR(50) NULL DEFAULT NULL,
  `parent_name` VARCHAR(50) NULL DEFAULT NULL,
  `parent_phone` VARCHAR(50) NULL DEFAULT NULL,
  `education_background` VARCHAR(100) NULL DEFAULT NULL,
  `ksce_index` INT(11) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `ksce_index` (`ksce_index` ASC) VISIBLE,
  UNIQUE INDEX `s_email` (`s_email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`documents` (
  `doc_id` INT(11) NOT NULL,
  `doc_type` VARCHAR(50) NULL DEFAULT NULL,
  `student_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  CONSTRAINT `documents_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `meru_uni_db`.`students` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`module` (
  `module_id` INT(11) NOT NULL,
  `module_name` VARCHAR(50) NULL DEFAULT NULL,
  `students_student_id` INT(11) NOT NULL,
  PRIMARY KEY (`module_id`),
  INDEX `fk_module_students1_idx` (`students_student_id` ASC) VISIBLE,
  CONSTRAINT `fk_module_students1`
    FOREIGN KEY (`students_student_id`)
    REFERENCES `meru_uni_db`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`short_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`short_course` (
  `sht_id` INT(11) NOT NULL,
  `sht_name` VARCHAR(50) NULL DEFAULT NULL,
  `school_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`sht_id`),
  INDEX `school_id` (`school_id` ASC) VISIBLE,
  CONSTRAINT `short_course_ibfk_1`
    FOREIGN KEY (`school_id`)
    REFERENCES `meru_uni_db`.`schools` (`school_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`student_program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`student_program` (
  `sp_id` INT(11) NOT NULL,
  `admission_type` VARCHAR(50) NULL DEFAULT NULL,
  `student_id` INT(11) NULL DEFAULT NULL,
  `sp_status` ENUM('pending', 'rejected', 'admitted') NULL DEFAULT NULL,
  `date_admitted` DATE NULL DEFAULT NULL,
  `program_id` INT(11) NULL DEFAULT NULL,
  `intake_intake_id` INT(11) NOT NULL,
  `application_application_id` INT(11) NOT NULL,
  PRIMARY KEY (`sp_id`),
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  INDEX `program_id` (`program_id` ASC) VISIBLE,
  INDEX `fk_student_program_intake1_idx` (`intake_intake_id` ASC) VISIBLE,
  INDEX `fk_student_program_application1_idx` (`application_application_id` ASC) VISIBLE,
  CONSTRAINT `student_program_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `meru_uni_db`.`students` (`student_id`),
  CONSTRAINT `student_program_ibfk_2`
    FOREIGN KEY (`program_id`)
    REFERENCES `meru_uni_db`.`programs` (`program_id`),
  CONSTRAINT `fk_student_program_intake1`
    FOREIGN KEY (`intake_intake_id`)
    REFERENCES `meru_uni_db`.`intake` (`intake_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_program_application1`
    FOREIGN KEY (`application_application_id`)
    REFERENCES `meru_uni_db`.`application` (`application_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`student_short_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`student_short_course` (
  `short_id` INT(11) NOT NULL,
  `admission_type` VARCHAR(50) NULL DEFAULT NULL,
  `student_id` INT(11) NULL DEFAULT NULL,
  `short_status` ENUM('pending', 'rejected', 'admitted') NULL DEFAULT NULL,
  `date_applied` DATE NULL DEFAULT NULL,
  `date_admitted` DATE NULL DEFAULT NULL,
  `sht_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`short_id`),
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  INDEX `sht_id` (`sht_id` ASC) VISIBLE,
  CONSTRAINT `student_short_course_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `meru_uni_db`.`students` (`student_id`),
  CONSTRAINT `student_short_course_ibfk_2`
    FOREIGN KEY (`sht_id`)
    REFERENCES `meru_uni_db`.`short_course` (`sht_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `meru_uni_db`.`student_qualifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meru_uni_db`.`student_qualifications` (
  `qid` INT NOT NULL,
  `inst_name` VARCHAR(45) NULL,
  `q_type` VARCHAR(45) NULL,
  `grade` VARCHAR(45) NULL,
  `yr_done` VARCHAR(45) NULL,
  `students_student_id` INT(11) NOT NULL,
  PRIMARY KEY (`qid`),
  INDEX `fk_student_qualifications_students1_idx` (`students_student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_qualifications_students1`
    FOREIGN KEY (`students_student_id`)
    REFERENCES `meru_uni_db`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
