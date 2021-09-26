-- Excercise 1

CREATE TABLE employee 
(id INTEGER NOT NULL,
 employee_name VARCHAR(255) NOT NULL,
 primary key (id)
 );
 
 -- Exercise 2
 
 SELECT * FROM birdstrikes limit 144,1; 
 -- Answer: Tennessee
 
 -- Exercise 3
 
 SELECT flight_date from birdstrikes order by flight_date desc;
 -- Answer: 2000-04-18 
 
 -- Exercise 4
 
 SELECT distinct cost from birdstrikes order by cost desc limit 49,1 ;
 -- Answer: 5345
 
-- Exercise 5

SELECT DISTINCT state from birdstrikes where state IS NOT NULL and state != '' AND bird_size IS NOT NULL and bird_size !=''; 
-- Answer: Colorado 

-- Exercise 6

select weekofyear (flight_date) week_ , flight_date from birdstrikes where state = 'Colorado' and flight_date is not null;
select DATEDIFF(now(), '2000-01-01');

-- -- Answer: 7939
-- 1st Jan falls on the 52nd week of the prev year 
-- Took help from: geeksforgeeks.org/weekofyear-function-in-mysql/
