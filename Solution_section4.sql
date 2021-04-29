-- Comprehensive group by query
SELECT department, count(*) as number_of_employees, 
ROUND(AVG(salary)) as average_salary, 
MAX(salary) as max_salary, MIN(salary) as min_salary
FROM employees
WHERE salary > 70000
GROUP BY department
ORDER BY number_of_employees DESC;

-- Use having clause
SELECT department, count(*)
FROM employees
GROUP BY department
HAVING count(*) >= 35
ORDER BY department;

-- Exercise 1 (employees with same first name in the company, along with count)
SELECT first_name, count(*)
FROM employees
GROUP BY first_name
HAVING count(*) > 1;

SELECT SUBSTRING(email, POSITION('@' IN email) + 1) as domain, count(*)
FROM employees
WHERE email IS NOT NULL
GROUP BY domain;

SELECT gender, region_id, 
MIN(salary) as min_salary, MAX(salary) as max_salary,
ROUND(AVG(salary)) as avg_salary
FROM employees
GROUP BY gender, region_id
ORDER BY gender;

SELECT * FROM fruit_imports;
-- Solution 1
-- Write a query that displays only the state with the largest amount of fruit supply
SELECT state
FROM fruit_imports
GROUP BY state
ORDER BY SUM(supply) DESC
LIMIT 1;

-- Solution 2
-- Write a query that returns the most expensive cost_per_unit of every season. 
SELECT season, MAX(cost_per_unit)
FROM fruit_imports
GROUP BY season;

-- Solution 3
-- Write a query that returns the state that has more than 1 import of the same fruit
SELECT state
FROM fruit_imports
GROUP BY name, state
HAVING count(*) > 1

-- Solution 4
-- Write a query that returns the seasons that produce either 3 fruits or 4 fruits
SELECT season
FROM fruit_imports
GROUP BY season
HAVING count(name) = 3 OR count(name) = 4;

-- Solution 5
-- Write a query that takes into consideration the supply and cost_per_unit columns for determining the total cost 
-- and returns the most expensive state with the total cost
SELECT state, SUM(cost_per_unit*supply)
FROM fruit_imports
GROUP BY state
ORDER BY SUM(cost_per_unit*supply) DESC
LIMIT 1;

-- Solution 6
SELECT COUNT(IF(fruit_name IS NULL,1,1)) 
FROM fruits;
-- Alternative Solution
SELECT COUNT(COALESCE(fruit_name, 'SOMEVALUE'))
FROM fruits;

