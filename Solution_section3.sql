-- Course exercises:
-- get email domain
SELECT SUBSTRING(email, POSITION('@' IN email)+1)
FROM employees;

-- Solution 1 (mysql)
SELECT CONCAT(last_name, ' works in ', department, ' department')
FROM professors;

-- Solution 1 (postgres)
SELECT last_name || ' works in ' || department || ' department'
FROM professors;

-- Solution 2 (mysql)
SELECT CONCAT('It is ', IF(salary > 95000, 'true', 'false'), ' that professor ', last_name, ' is highly paid')
FROM professors;
-- Similar to solution 1 in postgres

-- Solution 3
SELECT last_name, UPPER(LEFT(department, 3)), salary, hire_date
FROM professors;

-- Solution 4
SELECT MAX(salary), MIN(salary)
FROM professors
WHERE last_name != 'Wilson';

