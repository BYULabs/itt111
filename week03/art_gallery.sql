-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `art_gallery` ;

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `art_gallery` DEFAULT CHARACTER SET utf8 ;
USE `art_gallery` ;

-- -----------------------------------------------------
-- Table `art_gallery`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`role` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`user` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password_hash` VARCHAR(225) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `user_col` VARCHAR(45) NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_user_role_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `art_gallery`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artist` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` INT(4) NOT NULL,
  `dod` INT(4) NULL,
  `country` VARCHAR(25) NOT NULL,
  `is_local` ENUM('y', 'n') NULL DEFAULT 'n',
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artwork` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork` (
  `artwork_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(225) NOT NULL,
  `creation_year` INT(4) NOT NULL,
  `period_style` VARCHAR(100) NOT NULL,
  `medium_type` VARCHAR(100) NOT NULL,
  `image_filename` VARCHAR(225) NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`),
  INDEX `fk_artwork_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `art_gallery`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`keyword` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`keyword` (
  `keyword_id` INT NOT NULL AUTO_INCREMENT,
  `word` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  UNIQUE INDEX `word_UNIQUE` (`word` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork_keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artwork_keyword` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork_keyword` (
  `keyword_id` INT NOT NULL,
  `artwork_id` INT NOT NULL,
  PRIMARY KEY (`keyword_id`, `artwork_id`),
  INDEX `fk_keyword_has_artwork_artwork1_idx` (`artwork_id` ASC) VISIBLE,
  INDEX `fk_keyword_has_artwork_keyword1_idx` (`keyword_id` ASC) VISIBLE,
  CONSTRAINT `fk_keyword_has_artwork_keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `art_gallery`.`keyword` (`keyword_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_keyword_has_artwork_artwork1`
    FOREIGN KEY (`artwork_id`)
    REFERENCES `art_gallery`.`artwork` (`artwork_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE art_gallery;

-- -----------------------------------------------------
-- Artist Table
-- -----------------------------------------------------
INSERT INTO artist VALUES 
    (1, 'Vincent', NULL, 'van Gogh', '1853', '1890', 'France', 'n'),
    (2, 'Rembrandt', 'Harmenszoon', 'van Rijn', '1606', '1669', 'Netherlands', 'n'),
    (3, 'Leonardo', NULL, 'da Vinci', '1452', '1519', 'Italy', 'n'),
    (4, 'Venture', 'Lonzo', 'Coy', '1965', NULL, 'United States', 'y'),
    (5, 'Deborah', NULL, 'Gill', '1970', NULL, 'United States', 'y'),
    (6, 'Claude', NULL, 'Monet', '1840', '1926', 'France', 'n'),
    (7, 'Pablo', NULL, 'Picasso', '1904', '1973', 'Spain', 'n'),
    (8, 'Michelangelo', 'di Lodovico', 'Simoni', '1475', '1564', 'Italy', 'n');

-- SELECT * FROM artist;

-- -----------------------------------------------------
-- Keword Table
-- -----------------------------------------------------
INSERT INTO keyword VALUES
    (1, 'flowers'),
    (2, 'blue'),
    (3, 'landscape'),
    (4, 'girl'),
    (5, 'people'),
    (6, 'battle'),
    (7, 'boat'),
    (8, 'water'),
    (9, 'Christ'),
    (10, 'food'),
    (11, 'baby'),
    (12, 'guitarist');

-- SELECT * FROM keyword;

-- -----------------------------------------------------
-- 3. Artwork Table
-- -----------------------------------------------------
INSERT INTO artwork VALUES
    (1, 'Irises', '1889', 'Impressionism', 'Oil', 'irises.jpg', 1),
    (2, 'The Starry Night', '1889', 'Post-Impressionism', 'Oil', 'starrynight.jpg', 1),
    (3, 'Sunflowers', '1888', 'Post-impressionism', 'Oil', 'sunflowers.jpg', 1),
    (4, 'Night Watch', '1642', 'Baroque', 'Oil', 'nightwatch.jpg', 2),
    (5, 'Storm on the Sea of Galilee', '1633', 'Dutch Golden Age', 'Oil', 'stormgalilee.jpg', 2),
    (6, 'Head of a Woman', '1508', 'High Renaissance', 'Oil', 'headwoman.jpg', 3),
    (7, 'Last Supper', '1498', 'Renaissance', 'Tempra', 'lastsupper.jpg', 3),
    (8, 'Mona Lisa', '1517', 'Renaissance', 'Oil', 'monalisa.jpg', 3),
    (9, 'Hillside Stream', '2005', 'Modern', 'Oil', 'hillsidestream.jpg', 4),
    (10, 'Old Barn', '1992', 'Modern', 'Oil', 'oldbarn.jpg', 4),
    (11, 'Beach Baby', '1999', 'Modern', 'Watercolor', 'beachbaby.jpg', 5),
    (12, 'Women in the Garden', '1866', 'Impressionism', 'Oil', 'womengarden.jpg', 6),
    (13, 'Old Guitarist', '1904', 'Modern', 'Oil', 'guitarist.jpg', 7);

-- SELECT * FROM artwork;

-- -----------------------------------------------------
-- 4. Artwork Keyword Relations
-- -----------------------------------------------------
INSERT INTO artwork_keyword VALUES
    -- Van Gogh (Artworks 1, 2, 3)
    (1, 1),   -- flowers -> Irises
    (2, 2),   -- blue -> The Starry Night
    (3, 2),   -- landscape -> The Starry Night
    (1, 3),   -- flowers -> Sunflowers
    
    -- Rembrandt (Artworks 4, 5)
    (4, 4),   -- girl -> Night Watch
    (5, 4),   -- people -> Night Watch
    (6, 4),   -- battle -> Night Watch
    (7, 5),   -- boat -> Storm...
    (8, 5),   -- water -> Storm...
    (5, 5),   -- people -> Storm...
    (9, 5),   -- Christ -> Storm...
    
    -- Da Vinci (Artworks 6, 7, 8)
    (4, 6),   -- girl -> Head of a Woman
    (5, 6),   -- people -> Head of a Woman
    (10, 7),  -- food -> Last Supper
    (5, 7),   -- people -> Last Supper
    (9, 7),   -- Christ -> Last Supper
    (4, 8),   -- girl -> Mona Lisa
    (5, 8),   -- people -> Mona Lisa
    
    -- Venture Lonzo Coy (Artworks 9, 10)
    (8, 9),   -- water -> Hillside Stream
    (3, 9),   -- landscape -> Hillside Stream
    (3, 10),  -- landscape -> Old Barn
    
    -- Deborah Gill (Artwork 11)
    (8, 11),  -- water -> Beach Baby
    (5, 11),  -- people -> Beach Baby
    (11, 11), -- baby -> Beach Baby
    
    -- Claude Monet (Artwork 12)
    (3, 12),  -- landscape -> Women in the Garden
    (5, 12),  -- people -> Women in the Garden
    (1, 12),  -- flowers -> Women in the Garden
    
    -- Pablo Picasso (Artwork 13)
    (2, 13),  -- blue -> Old Guitarist
    (5, 13);  -- people -> Old Guitarist
    
-- SELECT * FROM artwork_keyword;