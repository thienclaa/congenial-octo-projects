-- Building database
-- MySQL Workbench Forward Engineering 

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Instacart
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Instacart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Instacart` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Instacart` ;

-- -----------------------------------------------------
-- Table `Instacart`.`aisles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instacart`.`aisles` (
  `aisle_id` INT NOT NULL AUTO_INCREMENT,
  `aisle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`aisle_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 135
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Instacart`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instacart`.`departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Instacart`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instacart`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `eval_set` VARCHAR(45) NOT NULL,
  `order_number` INT NOT NULL,
  `order_dow` INT NOT NULL,
  `order_hour_day` INT NOT NULL,
  `days_since_prior_order` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3421084
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Instacart`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instacart`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(300) CHARACTER SET 'utf8mb3' NOT NULL,
  `aisle_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_products_aisles1_idx` (`aisle_id` ASC) VISIBLE,
  INDEX `fk_products_departments1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_aisles1`
    FOREIGN KEY (`aisle_id`)
    REFERENCES `Instacart`.`aisles` (`aisle_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_departments1`
    FOREIGN KEY (`department_id`)
    REFERENCES `Instacart`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 49689
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Instacart`.`order_products_prior`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instacart`.`order_products_prior`;
CREATE TABLE IF NOT EXISTS `Instacart`.`order_products_prior` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `add_to_cart_order` INT NOT NULL,
  `reordered` INT NOT NULL,
  INDEX `fk_order_products_prior_orders1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_products_prior_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_products_prior_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Instacart`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_products_prior_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Instacart`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `Instacart`.`order_products_train`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instacart`.`order_products_train` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `add_to_cart_order` INT NOT NULL,
  `reordered` INT NOT NULL,
  INDEX `fk_order_products_train_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_products_train_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `Instacart`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_products_train_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Instacart`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Load data files in tables
LOAD DATA LOCAL INFILE '/Users/thienla/Desktop/Portfolio/MySQL/instacart-market-basket-analysis/Datasource/order_products_prior.csv'
INTO TABLE order_products_prior
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
