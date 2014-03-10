SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Frecuencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Frecuencia` (
  `fre_id` INT NOT NULL AUTO_INCREMENT,
  `fre_descripcion` VARCHAR(45) NULL,
  `fre_tiempo` VARCHAR(45) NULL COMMENT 'Frecuencias en formato cron job \nMIN HOUR DOM MON DOW\n',
  PRIMARY KEY (`fre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Variables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Variables` (
  `var_id` INT NOT NULL AUTO_INCREMENT,
  `var_nombre` VARCHAR(45) NULL,
  `var_descripcion` TEXT NULL,
  `var_tipo` VARCHAR(45) NULL,
  `var_status` VARCHAR(45) NULL,
  `var_fecha_registro` TIMESTAMP NULL,
  `Frecuencia_fre_id` INT NOT NULL,
  PRIMARY KEY (`var_id`),
  INDEX `fk_variables_Frecuencia1_idx` (`Frecuencia_fre_id` ASC),
  CONSTRAINT `fk_variables_Frecuencia1`
    FOREIGN KEY (`Frecuencia_fre_id`)
    REFERENCES `mydb`.`Frecuencia` (`fre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Indicadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Indicadores` (
  `ind_id` INT NOT NULL AUTO_INCREMENT,
  `Ind_nombre` VARCHAR(45) NULL,
  `ind_descripcion` TEXT NULL,
  `ind_tipo` VARCHAR(20) NULL,
  `ind_unidad` VARCHAR(20) NULL,
  `ind_status` VARCHAR(10) NULL,
  `ind_limite superior` VARCHAR(45) NULL,
  `ind_limite_inferior` VARCHAR(45) NULL,
  `ind_limite_maximo` VARCHAR(45) NULL,
  `ind_limite_minimo` VARCHAR(45) NULL,
  `Frecuencia_fre_id` INT NOT NULL,
  `ind_fecha_registro` TIMESTAMP NULL,
  `ind_formula` TEXT NULL,
  `ind_variable_sn` CHAR NULL,
  `Variables_var_id` INT NULL,
  `ind_fecha_inicio` DATETIME NULL,
  `ind_fecha_fin` DATETIME NULL,
  PRIMARY KEY (`ind_id`),
  INDEX `fk_Indicadores_Frecuencia_idx` (`Frecuencia_fre_id` ASC),
  INDEX `fk_Indicadores_Variables1_idx` (`Variables_var_id` ASC),
  CONSTRAINT `fk_Indicadores_Frecuencia`
    FOREIGN KEY (`Frecuencia_fre_id`)
    REFERENCES `mydb`.`Frecuencia` (`fre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Indicadores_Variables1`
    FOREIGN KEY (`Variables_var_id`)
    REFERENCES `mydb`.`Variables` (`var_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`formulasxvariables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`formulasxvariables` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Procesos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Procesos` (
  `pro_id` INT NOT NULL AUTO_INCREMENT,
  `Procesos_pro_id` INT NOT NULL,
  `pro_nombre` VARCHAR(45) NULL,
  `pro_descripcion` VARCHAR(45) NULL,
  `pro_proposito` VARCHAR(45) NULL,
  `pro_alcance` VARCHAR(45) NULL,
  `pro_fecha_creacion` TIMESTAMP NULL,
  `pro_fecha_modificacion` TIMESTAMP NULL,
  `pro_fecha_finalizacion` TIMESTAMP NULL,
  PRIMARY KEY (`pro_id`),
  INDEX `fk_Procesos_Procesos1_idx` (`Procesos_pro_id` ASC),
  CONSTRAINT `fk_Procesos_Procesos1`
    FOREIGN KEY (`Procesos_pro_id`)
    REFERENCES `mydb`.`Procesos` (`pro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Procesos_x_Indicadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Procesos_x_Indicadores` (
  `Procesos_pro_id` INT NOT NULL,
  `Indicadores_ind_id` INT NOT NULL,
  PRIMARY KEY (`Procesos_pro_id`, `Indicadores_ind_id`),
  INDEX `fk_Procesos_has_Indicadores_Indicadores1_idx` (`Indicadores_ind_id` ASC),
  INDEX `fk_Procesos_has_Indicadores_Procesos1_idx` (`Procesos_pro_id` ASC),
  CONSTRAINT `fk_Procesos_has_Indicadores_Procesos1`
    FOREIGN KEY (`Procesos_pro_id`)
    REFERENCES `mydb`.`Procesos` (`pro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Procesos_has_Indicadores_Indicadores1`
    FOREIGN KEY (`Indicadores_ind_id`)
    REFERENCES `mydb`.`Indicadores` (`ind_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Resultados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Resultados` (
  `res_id` INT NOT NULL,
  `res_valor` VARCHAR(45) NULL,
  `res_fecha_resultado` VARCHAR(45) NULL,
  `Indicadores_ind_id` INT NOT NULL,
  PRIMARY KEY (`res_id`),
  INDEX `fk_Resultados_Indicadores1_idx` (`Indicadores_ind_id` ASC),
  CONSTRAINT `fk_Resultados_Indicadores1`
    FOREIGN KEY (`Indicadores_ind_id`)
    REFERENCES `mydb`.`Indicadores` (`ind_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Resultados_variables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Resultados_variables` (
  `res_var_id` INT NOT NULL AUTO_INCREMENT,
  `res_var_valor` VARCHAR(45) NULL,
  `res_var_fecha_registro` VARCHAR(45) NULL,
  `res_var_fecha_valor` VARCHAR(45) NULL,
  `Variables_var_id` INT NOT NULL,
  INDEX `fk_Resultados_variables_Variables1_idx` (`Variables_var_id` ASC),
  PRIMARY KEY (`res_var_id`),
  CONSTRAINT `fk_Resultados_variables_Variables1`
    FOREIGN KEY (`Variables_var_id`)
    REFERENCES `mydb`.`Variables` (`var_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
