-- Exercise 1:

SELECT aircraft, airline, speed,
IF (speed <100 or speed is null, 'LOW SPEED', 'HIGH SPEED') AS speed_category
FROM birdstrikes
order by speed_category;

-- --------------------------------------------------------------------------------
-- Exercise 2
SELECT COUNT(distinct aircraft) from birdstrikes;
-- Answer is 3

-- ---------------------------------------------------------------------------------
-- Exercise 3:

Select aircraft, MIN(speed) from birdstrikes where aircraft like'H%'; 
-- helicopter 9
 
-- ----------------------------------------------------------------------------------

-- Exercise 4:

SELECT phase_of_flight, COUNT(id) FROM birdstrikes group by phase_of_flight order by id desc;
-- Answer is Taxi

-- --------------------------------------------------------------------------------------

-- Exercise 5
SELECT phase_of_flight, Round(avg(cost)) as cost1 from birdstrikes group by phase_of_flight order by cost1 desc;
-- Answer is CLIMB

-- ----------------------------------------------------------------------------------------------
-- Exercise 6
 
select AVG(speed) as avgspeed, state FROM birdstrikes group by state having length(state) < 5 order by avgspeed desc limit 1;

-- Answer is IOWA