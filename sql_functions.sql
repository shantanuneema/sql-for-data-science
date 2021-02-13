-- Solution to assignment 4

-- 1. state with largest amount
SELECT SUM(supply) 
FROM fruit_imports
GROUP BY state 
ORDER BY sum(supply) DESC
LIMIT 1;

-- 2. most expensive cost_per_unit for every season
SELECT season, MAX(cost_per_unit)
FROM fruit_imports
GROUP BY season;

-- 3. state with more than 1 import of same fruit
SELECT state
FROM fruit_imports
GROUP BY state, name
HAVING COUNT(name) > 1;

-- 4. seasons that produce either 3 or 4 fruits
SELECT season
FROM fruit_imports
GROUP BY season
HAVING COUNT(name) = 3 OR COUNT(name) = 4;

-- 5. supply and cost_per_unit for total_cost (return most expensive)
SELECT state, SUM(supply * cost_per_unit) as total_cost
FROM fruit_imports
GROUP BY state
ORDER BY total_cost DESC
LIMIT 1;

-- 6. create a table and return count of 4 without using COUNT(*)
CREATE TABLE fruits (
fruit_name VARCHAR(10));

-- 6.1 insert items
INSERT INTO fruits VALUES('Orange');
INSERT INTO fruits VALUES('Apple');
INSERT INTO fruits VALUES(NULL);
INSERT INTO fruits VALUES(NULL);

-- 6.2 write query to get count without using COUNT(*)
SELECT COUNT(COALESCE(fruit_name, 'val'))
FROM fruits;