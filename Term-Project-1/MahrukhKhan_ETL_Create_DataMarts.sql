-- View Data For A Particular Country  
-- For viewing open defecation data write 'Yes' otherwise leave empty ''. 

DROP PROCEDURE IF EXISTS SelectCountry;

DELIMITER //

	CREATE PROCEDURE SelectCountry(
	IN countryname VARCHAR(255),
	IN Answer VARCHAR(255)
	)

	BEGIN 

		IF Answer = 'Yes' THEN
				
				SELECT *
				FROM wash_table
					WHERE Country = countryname AND Area_Divide = 'Total'
					ORDER BY Period DESC;
				
		ELSE 
				SELECT Country, Period, Area_Divide, Percent_Basic_Handwash_Facilities, 
				Percent_Basic_Drinking_Facilities, Percent_Basic_Sanitation_Facilities
				FROM wash_table
					WHERE Country = countryname AND Area_Divide = 'Total'
					ORDER BY Period DESC;

	  END IF;
    
 END //
DELIMITER ;
 
CALL SelectCountry ('Afghanistan', 'Yes');

 
-- Which countries' urban areas have higher than 50% in all three wash variables? 
-- For viewing a range, add starting and ending year otherwise write 0. 

DROP PROCEDURE IF EXISTS FiftyPercentUrban;

DELIMITER //
CREATE PROCEDURE FiftyPercentUrban(
	IN x int,
	IN y int) 
    
BEGIN
IF Y = 0 THEN
	SELECT 
		Country, Period FROM wash_table 
		WHERE Period = x 
		AND Percent_Basic_Handwash_Facilities >= '50' 
		AND Percent_Basic_Sanitation_Facilities >= '50' 
		AND Percent_Basic_Drinking_Facilities >= '50' 
		AND Percent_OpenDefecation = '0' 
		AND Area_Divide = 'Urban'
		ORDER BY Period DESC;
   
	ELSE
		myloop: LOOP
		SELECT Country, Period FROM wash_table 
		WHERE Period = x 
		AND Percent_Basic_Handwash_Facilities >= '50' 
		AND Percent_Basic_Sanitation_Facilities >= '50' 
		AND Percent_Basic_Drinking_Facilities >= '50' 
		AND Percent_OpenDefecation = '0' 
		AND Area_Divide = 'Urban'
		ORDER BY Period DESC;
		SET x = x + 1;
		IF x > y THEN LEAVE myloop;
		END IF;
	   END LOOP myloop;
	   
	END IF;

END //
DELIMITER ;
 
Call FiftyPercentUrban('2015', '2016');


-- Study the trend in percentage of open defecation in rural areas and number of countries still practicing it
 
DROP VIEW IF EXISTS OpenDefRural;

CREATE VIEW OpenDefRural AS
SELECT Period, Area_Divide, ROUND(AVG(Percent_OpenDefecation)) AS Average_Percentage_OpenDefecation, Count(Country) AS Total_Countries
	FROM wash_table
	WHERE Area_Divide = 'Rural'
	AND Percent_OpenDefecation <> '0'
	GROUP BY Period 
	ORDER BY Period;

SELECT * FROM OpenDefRural;


 
 