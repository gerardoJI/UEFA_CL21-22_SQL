-- -----------------------------------------------------
-- Schema ucl21_22
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ucl21_22` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ucl21_22` ;

-- -----------------------------------------------------
-- Table `ucl21_22`.`main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`main` (
  `id_player` VARCHAR(10) NOT NULL,
  `player_name` VARCHAR(100) NULL DEFAULT NULL,
  `club` VARCHAR(45) NULL DEFAULT NULL,
  `position` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_player`),
  UNIQUE INDEX `id_player_UNIQUE` (`id_player` ASC) VISIBLE)



-- -----------------------------------------------------
-- Table `ucl21_22`.`attacking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`attacking` (
  `id_player` VARCHAR(10) NOT NULL,
  `serial` INT NULL DEFAULT NULL,
  `assists` INT NULL DEFAULT NULL,
  `corner_taken` INT NULL DEFAULT NULL,
  `offsides` INT NULL DEFAULT NULL,
  `dribbles` INT NULL DEFAULT NULL,
  `id_attacking` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_attacking`),
  INDEX `id_player_constraint6` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint6`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`attempts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`attempts` (
  `id_player` VARCHAR(10) NULL DEFAULT NULL,
  `serial` INT NULL DEFAULT NULL,
  `total_attempts` INT NULL DEFAULT NULL,
  `on_target` INT NULL DEFAULT NULL,
  `off_target` INT NULL DEFAULT NULL,
  `blocked` INT NULL DEFAULT NULL,
  `id_attempts` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_attempts`),
  INDEX `id_player_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint5`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`defending`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`defending` (
  `id_player` VARCHAR(10) NULL DEFAULT NULL,
  `serial` INT NULL DEFAULT NULL,
  `balls_recoverd` INT NULL DEFAULT NULL,
  `tackles` INT NULL DEFAULT NULL,
  `t_won` INT NULL DEFAULT NULL,
  `t_lost` INT NULL DEFAULT NULL,
  `clearance_attempted` INT NULL DEFAULT NULL,
  `id_defending` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_defending`),
  INDEX `id_player_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint4`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`disciplinary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`disciplinary` (
  `id_player` VARCHAR(10) NOT NULL,
  `serial` INT NULL DEFAULT NULL,
  `fouls_committed` INT NULL DEFAULT NULL,
  `fouls_suffered` INT NULL DEFAULT NULL,
  `red` INT NULL DEFAULT NULL,
  `yellow` INT NULL DEFAULT NULL,
  `minutes_played` INT NULL DEFAULT NULL,
  `id_disciplinary` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_disciplinary`),
  INDEX `id_player_constraint3` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint3`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`distributon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`distributon` (
  `id_player` VARCHAR(10) NULL DEFAULT NULL,
  `serial` INT NULL DEFAULT NULL,
  `pass_accuracy` DECIMAL(10,2) NULL DEFAULT NULL,
  `pass_attempted` INT NULL DEFAULT NULL,
  `pass_completed` INT NULL DEFAULT NULL,
  `cross_accuracy` INT NULL DEFAULT NULL,
  `cross_attempted` INT NULL DEFAULT NULL,
  `cross_complted` INT NULL DEFAULT NULL,
  `freekicks_taken` INT NULL DEFAULT NULL,
  `id_distributon` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_distributon`),
  INDEX `id_player_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint2`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`goalkeeping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`goalkeeping` (
  `id_player` VARCHAR(10) NOT NULL,
  `serial` INT NULL DEFAULT NULL,
  `saved` INT NULL DEFAULT NULL,
  `conceded` INT NULL DEFAULT NULL,
  `saved_penal` INT NULL DEFAULT NULL,
  `cleansheets` INT NULL DEFAULT NULL,
  `punches made` INT NULL DEFAULT NULL,
  `id_goalkeeping` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_goalkeeping`),
  INDEX `id_player_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint1`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`goals` (
  `id_player` VARCHAR(10) NOT NULL,
  `serial` INT NULL DEFAULT NULL,
  `goals` INT NULL DEFAULT NULL,
  `right_foot` INT NULL DEFAULT NULL,
  `left_foot` INT NULL DEFAULT NULL,
  `headers` INT NULL DEFAULT NULL,
  `others` INT NULL DEFAULT NULL,
  `inside_area` INT NULL DEFAULT NULL,
  `ouside_area` INT NULL DEFAULT NULL,
  `penaltis` INT NULL DEFAULT NULL,
  `id_goals` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_goals`),
  INDEX `id_player_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player_constraint`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))



-- -----------------------------------------------------
-- Table `ucl21_22`.`key_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ucl21_22`.`key_stats` (
  `id_player` VARCHAR(10) NOT NULL,
  `minutes_played` INT NULL DEFAULT NULL,
  `match_played` INT NULL DEFAULT NULL,
  `goals` INT NULL DEFAULT NULL,
  `assists` INT NULL DEFAULT NULL,
  `distance_covered` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_key_stats` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_key_stats`),
  INDEX `id_player_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `id_player`
    FOREIGN KEY (`id_player`)
    REFERENCES `ucl21_22`.`main` (`id_player`))
