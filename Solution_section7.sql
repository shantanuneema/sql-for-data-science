# Section 7 (Advance query using correlated subqueries)
# simple correlated subquery (run for every single record for outer query)
SELECT first_name, salary, (SELECT ROUND(AVG(salary))
						    FROM employees e2 
						    WHERE e2.department = e1.department) avg_department_salary
FROM employees e1
WHERE salary > (SELECT ROUND(AVG(salary))
			    FROM employees e2 
                WHERE e2.department = e1.department)
ORDER BY department;

# obtain names of departments where more than 38 employees are working (make sure to use correlated subquery)
SELECT DISTINCT(department)
FROM employees e1
WHERE (SELECT COUNT(*)
	   FROM employees e2
       GROUP BY e2.department
       HAVING COUNT(*) > 38
       AND e1.department = e2.department)
ORDER BY department;
       
# Alternative solutions (Better solution if one uses department table)
SELECT department
FROM departments d
WHERE 38 < (SELECT COUNT(*)
			FROM employees e
            WHERE e.department = d.department);
            
SELECT department
FROM employees e1
WHERE 38 < (SELECT COUNT(*)
			FROM employees e2
			WHERE e1.department = e2.department)
GROUP BY department;

# Highest employee salary for each department
SELECT department, (SELECT MAX(e.salary)
				    FROM employees e
                    WHERE d.department = e.department) highest_department_salary
FROM departments d
WHERE 38 < (SELECT COUNT(1)
			FROM employees e
            WHERE e.department = d.department);
            
# Assignment 7
# Find a table with all departments exist in employee table with lowest and highest salaries with first name of the employee
SELECT department, first_name, salary,
CASE
	WHEN salary = max_salary THEN 'Highest Paid' 
    WHEN salary = min_salary THEN 'Lowest Paid'
	ELSE ''
    END salary_class
FROM (SELECT department, first_name, salary,
		   (SELECT MAX(salary)
			FROM employees e2
			WHERE e2.department = e1.department) as max_salary,
		   (SELECT MIN(salary)
			FROM employees e2
			WHERE e2.department = e1.department) as min_salary
	 FROM employees e1
	 ORDER BY department) emp
WHERE salary IN (max_salary, min_salary);