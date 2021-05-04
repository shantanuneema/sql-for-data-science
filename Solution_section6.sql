# define additional column to classify the salary as "under paid" and "well paid"
SELECT first_name, salary, IF(salary > 100000, 'well paid', 'under paid') salary_classification
FROM employees;

SELECT first_name, salary, IF(salary >= 160000, 'executive', 
						      IF(salary < 160000 AND salary >= 100000, 'well paid', 'under paid')) salary_classification
FROM employees
ORDER BY salary DESC;

# Alternative solution (using CASE statement)
SELECT first_name, salary,
CASE 
	WHEN salary < 100000 THEN 'under paid'
    WHEN salary >= 100000 THEN 'well paid'
    ELSE 'unpaid'
END salary_classification
FROM employees;

# Find count of salary_classifications (executive, well paid and under paid)
SELECT class.salary_classification, COUNT(*)
FROM (SELECT 
	  CASE 
		  WHEN salary > 100000 AND salary < 160000 THEN 'well paid'
		  WHEN salary >= 160000 THEN 'executive'
		  WHEN salary < 100000 THEN 'under paid'
		  ELSE 'unpaid'
	  END salary_classification
	  FROM employees) as class
GROUP BY salary_classification;

# Use above example to transpose the table
SELECT SUM(IF(salary > 100000 AND salary < 160000, 1, 0)) as Well_Paid,
       SUM(IF(salary >= 160000, 1, 0)) as Executive,
       SUM(IF(salary < 100000, 1, 0)) as Under_Paid
FROM employees;

# Alternative solution
SELECT SUM(CASE WHEN salary > 100000 AND salary < 160000 THEN 1 ELSE 0 END) as Well_paid,
	   SUM(CASE WHEN salary >= 160000 THEN 1 ELSE 0 END) as Executive,
       SUM(CASE WHEN salary < 100000 THEN 1 ELSE 0 END) as Under_Paid
FROM employees;
           
# Identification of each region as column
SELECT first_name, 
	CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) ELSE NULL END as region_1,
	CASE WHEN region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) ELSE NULL END as region_2,
	CASE WHEN region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) ELSE NULL END as region_3,
	CASE WHEN region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) ELSE NULL END as region_4,
	CASE WHEN region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) ELSE NULL END as region_5,
	CASE WHEN region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) ELSE NULL END as region_6,
	CASE WHEN region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) ELSE NULL END as region_7
FROM employees;

# counts for each countries (based on region_ids
SELECT SUM(CASE WHEN region_id IN (1,2,3) THEN 1 ELSE 0 END) as "United States",
	   SUM(CASE WHEN region_id IN (4,5) THEN 1 ELSE 0 END) as Asia,
       SUM(CASE WHEN region_id IN (6,7) THEN 1 ELSE 0 END) as Canada
FROM employees;

# Alternative (better) solution
SELECT SUM(CASE WHEN region_id IN (SELECT region_id FROM regions WHERE country = 'United States') THEN 1 ELSE 0 END) as "United States",
	   SUM(CASE WHEN region_id IN (SELECT region_id FROM regions WHERE country = 'Asia') THEN 1 ELSE 0 END) as Asia,
       SUM(CASE WHEN region_id IN (SELECT region_id FROM regions WHERE country = 'Canada') THEN 1 ELSE 0 END) as Canada
FROM employees;

# Alternative solution (using the derived table)
SELECT COUNT(loc.region_1) + COUNT(loc.region_2) + COUNT(loc.region_3) as "United States",
	COUNT(loc.region_4) + COUNT(loc.region_5) as Asia,
    COUNT(loc.region_6) + COUNT(loc.region_7) as Canada
	FROM (SELECT first_name, 
		  CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) ELSE NULL END as region_1,
		  CASE WHEN region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) ELSE NULL END as region_2,
		  CASE WHEN region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) ELSE NULL END as region_3,
		  CASE WHEN region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) ELSE NULL END as region_4,
		  CASE WHEN region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) ELSE NULL END as region_5,
		  CASE WHEN region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) ELSE NULL END as region_6,
		  CASE WHEN region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) ELSE NULL END as region_7
	FROM employees) as loc;

# Assignment 6 Solutions
SELECT SUM(IF(supply >= 20000 AND supply < 50000, 1, 0)) as Enough,
       SUM(IF(supply >= 50000, 1, 0)) as Full,
       SUM(IF(supply < 20000, 1, 0)) as Low
FROM fruit_imports;

# total cost to import fruits by each season
SELECT season, SUM(supply * cost_per_unit)
FROM fruit_imports
GROUP BY season;
# Use case statements to transpose the data