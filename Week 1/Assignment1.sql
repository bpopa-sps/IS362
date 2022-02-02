-- Assignment 1 by Bogdan Popa

SELECT 
    COUNT(DISTINCT tailnum)
FROM
    flights.planes
WHERE
    speed IS NOT NULL;
    
-- 1b. What is the minimum speed?
-- Answer: 90
SELECT 
    MIN(speed)
FROM
    flights.planes
WHERE
    speed IS NOT NULL;

-- 1c. What is the max speed? 
-- Answer: 432
SELECT 
    MAX(speed)
FROM
    flights.planes
WHERE
    speed IS NOT NULL;
    
-- 2a, What is the total distance flown by all the planes in January 2013?
-- Answer: 27,188,805 miles
SELECT 
    SUM(distance)
FROM
    flights.flights
WHERE
    year = 2013 AND month = 1;

-- 2b, What is the total distance flown by all the planes in January 2013 where the tailnum is missing?
-- Answer: 81,763 miles
SELECT 
    SUM(distance)
FROM
    flights.flights
WHERE
    year = 2013 AND month = 1
        AND tailnum = ''
        OR tailnum = NULL;

-- 3a. What is the total distance flown for all planes on July 5,2013 grouped by aircraft manufacturer?
-- Left Inner Join
SELECT 
    p.manufacturer, SUM(distance)
FROM
    flights.flights f
        INNER JOIN
    flights.planes p ON f.tailnum = p.tailnum
WHERE
    f.year = 2013 AND f.month = 7
        AND f.day = 5
GROUP BY p.manufacturer;


-- 3b. Left Outer Join
SELECT 
    p.manufacturer, SUM(distance)
FROM
    flights.flights f
        LEFT OUTER JOIN
    flights.planes p ON f.tailnum = p.tailnum
WHERE
    f.year = 2013 AND f.month = 7
        AND f.day = 5
GROUP BY p.manufacturer;

-- The outer join includes null entries while the inner join does not.

SELECT 
    f.dest, a.name, AVG(f.arr_delay), p.manufacturer
FROM
    flights.flights f
        INNER JOIN
    flights.planes p ON f.tailnum = p.tailnum
        INNER JOIN
    flights.airports a ON f.dest = a.faa
WHERE
    f.year = 2013 AND f.month = 10
        AND f.origin = 'JFK'
GROUP BY a.name , p.manufacturer
ORDER BY AVG(f.arr_delay) DESC;

-- Query for data export for Tableau
SELECT 
    f.year,
    f.month,
    f.day,
    f.dep_delay,
    f.arr_delay,
    f.carrier,
    c.name,
    f.tailnum,
    f.flight,
    f.origin,
    f.dest,
    f.air_time,
    f.distance,
    p.manufacturer as "Aircraft Manufacturer",
    p.model,
    p.engines,
    p.seats,
    p.speed,
    p.engine
FROM
    flights.flights f
        INNER JOIN
    flights.planes p ON f.tailnum = p.tailnum
        INNER JOIN
    flights.airlines c ON f.carrier = c.carrier; 