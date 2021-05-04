# Subqueries
SELECT d.department
FROM departments d, employees e;

# Departments do not exist using subquery (simple example)
SELECT DISTINCT(e.department)
FROM employees e
WHERE department NOT IN (SELECT department FROM departments);

# Importance of using alias for subquery
SELECT *
FROM (SELECT * 
      FROM employees
      WHERE salary > 150000) as tab;
      
# Exercises
# Return all employees work in electronic division (revisited to ensure it removes NULL under the sub-query)
# Important to note that the data values are NOT case sensitive in mySQL
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE department IN (SELECT department
					 FROM departments
					 WHERE division = 'electronics'
                     AND department IS NOT NULL);

# Employees work in Asia or Canada and make over $130,000 	
SELECT * 
FROM employees
WHERE region_id IN (SELECT region_id 
				    FROM regions
				    WHERE country IN ('Asia', 'Canada'))
AND salary > 130000;

# Show first name and the department of an employee, along with how much less they are paid than the highest paid employee in the company
# and the employees either work in Asia or Canada
SELECT first_name, department, (SELECT MAX(salary) FROM employees) - salary less_than_max_salary
FROM employees
WHERE region_id IN (SELECT region_id 
				    FROM regions
				    WHERE country IN ('Asia', 'Canada'));
                    
# for region_id greather than 3 (use of ANY)
SELECT * 
FROM employees
WHERE region_id > ANY(SELECT region_id
				      FROM regions 
                      WHERE country = 'united states');
                      
# query to return all employees that work in kids division and dates higher than who work in maintenance department
SELECT * 
FROM employees
WHERE department IN (SELECT department
					 FROM departments
                     WHERE division = 'kids')
AND hire_date > ALL(SELECT hire_date
				    FROM employees
                    WHERE department = 'maintenance');
                    
# Salary that appears the most frequently (MODE), highest if multiple modes are found
# Important: for postgres, the following query will be in a subquery 
SELECT salary
FROM employees
GROUP BY salary
ORDER BY COUNT(*) DESC, salary DESC
LIMIT 1;
# Alternative Solution:
SELECT salary
FROM employees
GROUP BY salary
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM employees
                       GROUP BY salary)
ORDER BY salary DESC
LIMIT 1;

# taking care of outliers (average example)


SELECT AVG(salary)
FROM employees
WHERE salary NOT IN (SELECT MAX(salary)
					 FROM employees)
AND salary NOT IN (SELECT MIN(salary)
				   FROM employees);

# Assignment 5
# name of students who are taking US history and Physics
SELECT student_name
FROM students 
WHERE student_no IN (SELECT student_no
					 FROM student_enrollment
					 WHERE course_no IN (SELECT course_no
					 					 FROM courses
				  						 WHERE course_title = 'physics' OR course_title = 'US History'));

# find student name who took highest number of courses
SELECT student_name 
FROM students
WHERE student_no = (SELECT student_no
					FROM student_enrollment
					GROUP BY student_no
					ORDER BY COUNT(*) DESC
					LIMIT 1);
                    
# without using order by and limit, find the oldest student
SELECT *
FROM students
WHERE age = (SELECT MAX(age) FROM students);