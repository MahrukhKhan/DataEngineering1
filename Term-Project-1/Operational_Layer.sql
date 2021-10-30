DROP SCHEMA IF EXISTS wash;
	CREATE SCHEMA wash;
    
USE wash;

SHOW VARIABLES LIKE "secure_file_priv";
SET GLOBAL local_infile = TRUE;
SHOW VARIABLES LIKE "local_infile";

DROP TABLE IF EXISTS handwash;
	CREATE TABLE handwash(
		  country VARCHAR(255),
		  country_code VARCHAR(255),
		  indicator VARCHAR (255),
		  area_divide VARCHAR(255),
		  series_code VARCHAR(255),
		  period YEAR,
		  period_code VARCHAR(255),
		  percent_basic_handwash VARCHAR(255),
		  unique_code VARCHAR(255)
		  );
			
	LOAD DATA infile 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HandWash.csv' 
    INTO TABLE handwash
		FIELDS TERMINATED BY ','
		LINES TERMINATED BY '\r\n'
		IGNORE 1 LINES  
		(country, country_code, indicator,area_divide, series_code, period, period_code, percent_basic_handwash)
		SET percent_basic_handwash = nullif(percent_basic_handwash,'..');

		ALTER TABLE `wash`.`handwash` 
		CHANGE COLUMN `percent_basic_handwash` `percent_basic_handwash` INT NULL;

SELECT * FROM handwash;


DROP TABLE IF EXISTS sanitization;
	CREATE TABLE sanitization(
		  country VARCHAR(255),
		  country_code VARCHAR(255),
		  indicator VARCHAR (255),
		  area_divide VARCHAR(255),
		  series_code VARCHAR(255),
		  period YEAR,
		  period_code VARCHAR(255),
		  percent_basic_sanitization VARCHAR(255),
		  unique_code VARCHAR(255)
		  );

	LOAD DATA infile 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sanitization.csv' INTO TABLE sanitization
		FIELDS TERMINATED BY ','
		LINES TERMINATED BY '\r\n'
		IGNORE 1 LINES 
		(country, country_code, indicator,area_divide, series_code, period, period_code, percent_basic_sanitization)
		SET
		percent_basic_sanitization = nullif(percent_basic_sanitization,'..');

			ALTER TABLE `wash`.`sanitization` 
			CHANGE COLUMN `percent_basic_sanitization` `percent_basic_sanitization` INT NULL;

SELECT*FROM sanitization;

DROP TABLE IF EXISTS drinkingwater;
	CREATE TABLE drinkingwater(
	  country VARCHAR(255),
	  country_code VARCHAR(255),
	  indicator VARCHAR (255),
	  area_divide VARCHAR(255),
	  series_code VARCHAR(255),
	  period YEAR,
	  period_code VARCHAR(255),
	  percent_basic_dwater VARCHAR(255),
	  unique_code VARCHAR(255)
      );

	LOAD DATA infile 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DrinkingWater.csv'
	INTO TABLE drinkingwater
		FIELDS TERMINATED BY ','
		LINES TERMINATED BY '\r\n'
		IGNORE 1 LINES 
		(country, country_code, indicator,area_divide, series_code, period, period_code, percent_basic_dwater)
		SET percent_basic_dwater = nullif(percent_basic_dwater,'..');


		ALTER TABLE `wash`.`drinkingwater` 
		CHANGE COLUMN `percent_basic_dwater` `percent_basic_dwater` INT NULL;

SELECT*FROM drinkingwater;

DROP TABLE IF EXISTS opendefecate;
	CREATE TABLE opendefecate (
	  country VARCHAR(255),
	  country_code VARCHAR(255),
	  indicator VARCHAR (255),
	  area_divide VARCHAR(255),
	  series_code VARCHAR(255),
	  period YEAR,
	  period_code VARCHAR(255),
	  percent_opendef VARCHAR(255),
	  unique_code VARCHAR(255)
      );

	LOAD DATA infile 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Open_Defecation.csv'
	INTO TABLE opendefecate
		FIELDS TERMINATED BY ','
		LINES TERMINATED BY '\r\n'
		IGNORE 1 LINES 
		(country, country_code, indicator,area_divide, series_code, period, period_code, percent_opendef)
		SET
		percent_opendef = nullif(percent_opendef,'..');

		ALTER TABLE `wash`.`opendefecate` 
		CHANGE COLUMN `percent_opendef` `percent_opendef` INT NULL;

SELECT*FROM opendefecate;

SET SQL_SAFE_UPDATES = 0;
	
UPDATE handwash
set unique_code = CONCAT(country_code, period_code, area_divide);

UPDATE drinkingwater
set unique_code = CONCAT(country_code, period_code, area_divide);

UPDATE sanitization
set unique_code = CONCAT(country_code, period_code, area_divide);

UPDATE opendefecate
set  unique_code = CONCAT(country_code, period_code, area_divide);

SET SQL_SAFE_UPDATES = 1;


