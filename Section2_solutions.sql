-- Solution 1
SELECT student_name 
FROM students
WHERE age BETWEEN 18 and 20;

-- Solution 2
SELECT student_name 
FROM students
WHERE student_name like '%ch%'
OR student_name like '%nd';

-- Solution 3
SELECT student_name 
FROM students
WHERE student_name like '%ae%'
OR student_name like '%ph%'
AND age != 19;

-- Solution 4
SELECT student_name
FROM students
ORDER BY age DESC;

-- Solution 5
SELECT student_name, age
FROM students
ORDER BY age DESC
LIMIT 4;

-- Solution 6
SELECT *
FROM students
WHERE age <= 20
AND (student_no BETWEEN 3 and 5 OR student_no = 7)
OR (student_no >= 4 and age > 20)

