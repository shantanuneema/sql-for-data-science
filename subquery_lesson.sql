-- Using aliases for source
SELECT DISTINCT e.department
FROM employees e, departments d;

-- Subqueries
-- Employees with departments not present in departments table
SELECT * FROM  employees
WHERE department NOT IN (SELECT department 
						 FROM departments)
						 
-- use of aliases in subquery
SELECT employee_name, yearly_salary
FROM (SELECT first_name employee_name, salary yearly_salary
	  FROM employees 
	  WHERE salary > 150000) sub;
	  
-- multiple sources (more specific to correct subquery):
SELECT subquery_a.employee_name, yearly_salary
FROM (SELECT first_name employee_name, salary yearly_salary
	  FROM employees 
	  WHERE salary > 150000) subquery_a,
	  -- Converted dept name to employee name (senseless query)
	 (SELECT department employee_name 
	  FROM departments) subquery_b;

-- single record in subquery when used in SELECT
SELECT first_name, last_name, salary, (SELECT first_name 
									   FROM employees 
									   LIMIT 1)
FROM employees;

-- Exercise 1
-- Return all employees those work in electronics division
SELECT * 
FROM employees
WHERE department IN (SELECT department 
					 FROM departments
					 WHERE division = 'Electronics');

-- Exercise 2
-- Employees those work and Asia or Canada and make over 130,000
SELECT * 
FROM employees
WHERE region_id IN (SELECT region_id 
					FROM regions
					WHERE country IN ('Asia', 'Canada'))
AND salary > 130000;

-- Exercise 3 (subquery in SELECT)
-- First name of an employee for a department he/she works for
-- along with how much less they make compared to highest paid employee in the company
-- employees should be working in either asia or canada
SELECT first_name, department, (SELECT MAX(salary)
								FROM employees) - salary less_from_HPE
FROM employees
WHERE region_id IN (SELECT region_id 
					FROM regions
					WHERE country IN ('Asia', 'Canada'));

-- sample query (USE of ANY / ALL)
SELECT * FROM employees
WHERE region_id > ANY (SELECT region_id 
					   FROM regions
					   WHERE country = 'United States');

-- Exercise 4
-- Employess work in Kids division (or employees work in children clothing or toys department) and,
-- the dates at which those employees were hired is greater than all of the hire_dates
-- of the employees who work in maintenance department
-- Solution 1 (without using ALL)
SELECT * 
FROM employees
WHERE department IN (SELECT department
					 FROM departments
					 WHERE division = 'Kids')
AND hire_date > (SELECT sub.max_hire_date
				 FROM (SELECT department, MAX(hire_date) max_hire_date
					   FROM employees
					   GROUP BY department) sub
				 WHERE department = 'Maintenance');
				 
-- Solution 2 (using ALL)
SELECT * 
FROM employees
WHERE department = ANY (SELECT department
						FROM departments
						WHERE division = 'Kids')
AND hire_date > ALL (SELECT hire_date
					 FROM employees
					 WHERE department = 'Maintenance');

-- Exercise 5
-- Most frequent salary (simple)
SELECT salary, COUNT(*) freq 
FROM employees
GROUP BY salary
HAVING COUNT(*) > 1
ORDER BY salary DESC
LIMIT 1;

-- Most frequent salary (using ALL)
SELECT salary, COUNT(*) freq 
FROM employees
GROUP BY salary
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM employees
					   GROUP BY salary)
ORDER BY salary DESC
LIMIT 1;

-- Exercise 6
CREATE TABLE dupes (id INT,
				    name VARCHAR(10));
					
INSERT INTO dupes VALUES (1, 'FRANK');
INSERT INTO dupes VALUES (2, 'FRANK');
INSERT INTO dupes VALUES (3, 'ROBERT');
INSERT INTO dupes VALUES (4, 'ROBERT');
INSERT INTO dupes VALUES (5, 'SAM');
INSERT INTO dupes VALUES (6, 'FRANK');
INSERT INTO dupes VALUES (7, 'PETER');

-- delete
DELETE FROM dupes
WHERE id NOT IN (SELECT min(id)
				 FROM dupes
				 GROUP BY name);

-- drop
DROP TABLE dupes;

-- Exercise 7, compute average but exclude min and max
SELECT ROUND(AVG(salary))
FROM employees
WHERE salary NOT IN ((SELECT MIN(salary) FROM employees), 
					 (SELECT MAX(salary) FROM employees));

-- Assignment (subqueries)
-- Answer 1: related by means of student_enrollment table (not directly related)
-- Answer 2:

SELECT student_name
FROM students
WHERE student_no = ANY (SELECT DISTINCT(student_no) 
						FROM student_enrollment 
						WHERE course_no = ANY (SELECT course_no 
					                      FROM (SELECT * FROM courses
				       					  WHERE course_title IN ('Physics', 'US History')) selected))

-- Answer 3
SELECT student_name
FROM students 
WHERE student_no = (SELECT student_no
					FROM student_enrollment
					GROUP BY student_no
					ORDER BY COUNT(*) DESC
					LIMIT 1)

-- Answer 4: FALSE
-- Answer 5
SELECT * 
FROM students
WHERE age = (SELECT MAX(age) 
	  		 FROM students)













