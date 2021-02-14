-- Sample CASE statement
SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'
	WHEN salary > 100000 THEN 'PAID WELL'
END
FROM employees
ORDER BY salary DESC;

-- with ELSE (categorize the data using values)
SELECT pay_category, COUNT(*)
FROM (SELECT first_name, salary,
	  CASE
		  WHEN salary < 50000 THEN 'LOW PAY'
		  WHEN salary > 50000 AND salary < 125000 THEN 'GOOD PAY'
		  WHEN salary > 100000 AND salary < 160000 THEN 'HIGH PAY'
		  ELSE 'EXECUTIVE' -- Return NULL if commented
	  END as pay_category
	  FROM employees) sub
GROUP BY pay_category

-- Exercise 1: above query with category as column name
-- transpose the table
SELECT SUM(CASE WHEN salary < 50000 THEN 1 ELSE 0 END) as LOW_PAY,
       SUM(CASE WHEN salary > 50000 AND salary < 125000 THEN 1 ELSE 0 END) as GOOD_PAY,
	   SUM(CASE WHEN salary > 100000 AND salary < 160000 THEN 1 ELSE 0 END) as HIGH_PAY,
	   SUM(CASE WHEN salary > 160000 THEN 1 ELSE 0 END) as EXECUTIVE
FROM employees;

-- Exercise 2
SELECT department, COUNT(*)
FROM employees
WHERE department IN ('Sports', 'Tools', 'Clothing', 'Computers')
GROUP BY department;

-- if require to transpose, USE like
SELECT SUM(CASE WHEN department = 'Sports' THEN 1 ELSE 0 END) as sports_employee
FROM employees;

-- Exercise 3, hard coded (bad)
SELECT first_name, CASE WHEN region_id = 1 THEN 'United States' ELSE NULL END as region_1
FROM employees

-- using regions table (dynamic)
SELECT first_name,
CASE WHEN region_id = 1 THEN (SELECT country 
							  FROM regions WHERE region_id = 1) 
							  ELSE NULL END as region_1,
CASE WHEN region_id = 2 THEN (SELECT country 
							  FROM regions WHERE region_id = 2) 
							  ELSE NULL END as region_2,
CASE WHEN region_id = 3 THEN (SELECT country 
							  FROM regions WHERE region_id = 3) 
							  ELSE NULL END as region_3,
CASE WHEN region_id = 4 THEN (SELECT country 
							  FROM regions WHERE region_id = 4) 
							  ELSE NULL END as region_4,
CASE WHEN region_id = 5 THEN (SELECT country 
							  FROM regions WHERE region_id = 5) 
							  ELSE NULL END as region_5,
CASE WHEN region_id = 6 THEN (SELECT country 
							  FROM regions WHERE region_id = 6) 
							  ELSE NULL END as region_6,
CASE WHEN region_id = 7 THEN (SELECT country 
							  FROM regions WHERE region_id = 7) 
							  ELSE NULL END as region_7
FROM employees

-- Exercise 4
SELECT COUNT(sub.region_1) + COUNT(sub.region_2) + COUNT(sub.region_3) as United_States,
COUNT(sub.region_4) + COUNT(sub.region_5) as Asia,
COUNT(sub.region_6) + COUNT(sub.region_7) as Canada
FROM (SELECT first_name,
		CASE WHEN region_id = 1 THEN (SELECT country 
									  FROM regions WHERE region_id = 1) 
									  ELSE NULL END as region_1,
		CASE WHEN region_id = 2 THEN (SELECT country 
									  FROM regions WHERE region_id = 2) 
									  ELSE NULL END as region_2,
		CASE WHEN region_id = 3 THEN (SELECT country 
									  FROM regions WHERE region_id = 3) 
									  ELSE NULL END as region_3,
		CASE WHEN region_id = 4 THEN (SELECT country 
									  FROM regions WHERE region_id = 4) 
									  ELSE NULL END as region_4,
		CASE WHEN region_id = 5 THEN (SELECT country 
									  FROM regions WHERE region_id = 5) 
									  ELSE NULL END as region_5,
		CASE WHEN region_id = 6 THEN (SELECT country 
									  FROM regions WHERE region_id = 6) 
									  ELSE NULL END as region_6,
		CASE WHEN region_id = 7 THEN (SELECT country 
									  FROM regions WHERE region_id = 7) 
									  ELSE NULL END as region_7
		FROM employees) sub
	



