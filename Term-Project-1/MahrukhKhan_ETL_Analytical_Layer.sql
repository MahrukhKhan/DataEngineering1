use wash;

DROP PROCEDURE IF EXISTS WASH_DWH;

DELIMITER //

CREATE PROCEDURE WASH_DWH()
	
BEGIN

DROP TABLE IF EXISTS wash_table;
CREATE TABLE wash_table AS

	SELECT 
			h.country AS Country, 
			h.area_divide AS Area_Divide, 
            h.period AS Period,
			h.percent_basic_handwash AS Percent_Basic_Handwash_Facilities, 
			s.percent_basic_sanitization AS Percent_Basic_Sanitation_Facilities,
			dw.percent_basic_dwater AS Percent_Basic_Drinking_Facilities,
			od.percent_opendef AS Percent_OpenDefecation

			FROM handwash h
			INNER JOIN sanitization s
				on h.unique_code = s.unique_code

			INNER JOIN drinkingwater dw
				on h.unique_code = dw.unique_code

			INNER JOIN opendefecate od
				on h.unique_code = od.unique_code
		
			ORDER BY period, country;

		END //
DELIMITER ;

CALL WASH_DWH();

SELECT*FROM wash_table;




#TRIGGER:

DROP TABLE IF EXISTS messages;

CREATE TABLE messages(message VARCHAR(255) NOT NULL);

DROP TRIGGER IF EXISTS insert_new_data;

DELIMITER $$

CREATE TRIGGER insert_new_data
AFTER INSERT 
ON handwash FOR EACH ROW
BEGIN 

	INSERT INTO messages SELECT CONCAT ('New data: ', NEW.unique_code);
    
	INSERT INTO wash_table
	SELECT 
			h.country AS Country, 
			h.period AS Period, 
			h.area_divide AS Area_Divide, 
			h.percent_basic_handwash AS Percent_Basic_Handwash_Facilities, 
			s.percent_basic_sanitization AS Percent_Basic_Sanitation_Facilities,
			dw.percent_basic_dwater AS Percent_Basic_Drinking_Facilities,
			od.percent_opendef AS Percent_OpenDefecation

	FROM handwash h
            
			INNER JOIN sanitization s
				on h.unique_code = s.unique_code

			INNER JOIN drinkingwater dw
				on h.unique_code = dw.unique_code

			INNER JOIN opendefecate od
				on h.unique_code = od.unique_code
                
			#WHERE unique_code = NEW.unique_code
			ORDER BY 
				period, 
				country;
    
END $$
DELIMITER ;


INSERT INTO handwash VALUES('X','XX','People','Rural','SH.STA.HYGN.RU.ZS','2011','YR2021',35,'ZZZYR2021Rural');
INSERT INTO wash_table VALUES('Afghanistan','2011','Total',35,32,41,19);
SELECT*FROM messages;

#Incase of updating same unique code-> DELETE FROM handwash WHERE unique_code = 'ZZZYR2021Rural';


