-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Quiz
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Quiz` ;

-- -----------------------------------------------------
-- Schema Quiz
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Quiz` DEFAULT CHARACTER SET utf8 ;
USE `Quiz` ;

-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users` ;

CREATE TABLE IF NOT EXISTS `Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(250) NULL,
  PRIMARY KEY (`idUsers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users` ;

CREATE TABLE IF NOT EXISTS `Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(250) NULL,
  PRIMARY KEY (`idUsers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizes` ;

CREATE TABLE IF NOT EXISTS `Quizes` (
  `idQuizes` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idQuizes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Scores` ;

CREATE TABLE IF NOT EXISTS `Scores` (
  `idScores` INT NOT NULL AUTO_INCREMENT,
  `id_Users` INT NOT NULL,
  `id_Quizes` INT NOT NULL,
  `value` DECIMAL(5,2) NULL,
  PRIMARY KEY (`idScores`),
  INDEX `fk_Scores_Users_idx` (`id_Users` ASC),
  INDEX `fk_Scores_Quizes1_idx` (`id_Quizes` ASC),
  CONSTRAINT `fk_Scores_Users`
    FOREIGN KEY (`id_Users`)
    REFERENCES `Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Scores_Quizes1`
    FOREIGN KEY (`id_Quizes`)
    REFERENCES `Quizes` (`idQuizes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Questions` ;

CREATE TABLE IF NOT EXISTS `Questions` (
  `id_Questions` INT NOT NULL AUTO_INCREMENT,
  `quiz_id` INT NOT NULL,
  `questionsText` VARCHAR(250) NULL,
  PRIMARY KEY (`id_Questions`),
  INDEX `fk_Questions_Quizes1_idx` (`quiz_id` ASC),
  CONSTRAINT `fk_Questions_Quizes1`
    FOREIGN KEY (`quiz_id`)
    REFERENCES `Quizes` (`idQuizes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Answers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Answers` ;

CREATE TABLE IF NOT EXISTS `Answers` (
  `id_Answers` INT NOT NULL AUTO_INCREMENT,
  `id_Questions` INT NOT NULL,
  `answerText` VARCHAR(250) NULL,
  `isCorrect` TINYINT(1) NULL,
  PRIMARY KEY (`id_Answers`),
  INDEX `fk_Answers_Questions1_idx` (`id_Questions` ASC),
  CONSTRAINT `fk_Answers_Questions1`
    FOREIGN KEY (`id_Questions`)
    REFERENCES `Questions` (`id_Questions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO quiz1;
 DROP USER quiz1;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'quiz1' IDENTIFIED BY 'quiz';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'quiz1';

-- -----------------------------------------------------
-- Data for table `Users`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quiz`;
INSERT INTO `Users` (`idUsers`, `username`, `password`) VALUES (1, 'fisha26', 'password');
INSERT INTO `Users` (`idUsers`, `username`, `password`) VALUES (2, 'rockstar', 'energy');
INSERT INTO `Users` (`idUsers`, `username`, `password`) VALUES (3, 'java', 'bean');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Quizes`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quiz`;
INSERT INTO `Quizes` (`idQuizes`, `name`) VALUES (1, 'first');
INSERT INTO `Quizes` (`idQuizes`, `name`) VALUES (2, 'second');
INSERT INTO `Quizes` (`idQuizes`, `name`) VALUES (3, 'third');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Scores`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quiz`;
INSERT INTO `Scores` (`idScores`, `id_Users`, `id_Quizes`, `value`) VALUES (1, 2, 3, 90);
INSERT INTO `Scores` (`idScores`, `id_Users`, `id_Quizes`, `value`) VALUES (2, 1, 2, 80);
INSERT INTO `Scores` (`idScores`, `id_Users`, `id_Quizes`, `value`) VALUES (3, 3, 1, 85);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Questions`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quiz`;
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (1, 1, 'How old am I?');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (2, 1, 'what is my first name');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (3, 1, 'what is my favorite energy drink');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (4, 2, 'what city do i live in');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (5, 2, 'what kind of car do i have');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (6, 2, 'what kind of dog do i have');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (7, 3, 'what color is my car');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (8, 3, 'what color is my dog');
INSERT INTO `Questions` (`id_Questions`, `quiz_id`, `questionsText`) VALUES (9, 3, 'what color are my eyes');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Answers`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quiz`;
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (1, 1, '30', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (2, 1, '34', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (3, 1, '35', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (4, 2, 'Annie', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (5, 2, 'Anne', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (6, 2, 'Annie Lynn', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (7, 3, 'Monster', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (8, 3, 'coffee', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (9, 3, 'RockStar', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (10, 4, 'Denver', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (11, 4, 'Sheridan', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (12, 4, 'Lakewood', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (13, 5, 'Nissan', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (14, 5, 'Pontiac', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (15, 5, 'Mazda', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (16, 6, 'Schnauzer', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (17, 6, 'Yorkie', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (18, 6, 'Schnoodle', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (19, 7, 'Red', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (20, 7, 'Black', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (21, 7, 'Blue', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (22, 8, 'Brown', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (23, 8, 'White', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (24, 8, 'Black', true);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (25, 9, 'Green', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (26, 9, 'Hazel', false);
INSERT INTO `Answers` (`id_Answers`, `id_Questions`, `answerText`, `isCorrect`) VALUES (27, 9, 'Blue', true);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
