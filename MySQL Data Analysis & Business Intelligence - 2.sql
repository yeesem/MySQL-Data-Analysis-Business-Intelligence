SELECT first_name,last_name
FROM employees;

SELECT * FROM employees;

SELECT * FROM departments;

SELECT dept_no FROM departments;

USE employees;

SELECT * FROM employees;

SELECT * FROM employees
WHERE first_name = 'Denis';

SELECT * FROM employees
WHERE first_name = 'DENIS' AND gender = 'M';

SELECT * FROM employees
WHERE first_name = 'Kellie' AND gender = 'F';

SELECT * FROM employees
WHERE first_name = 'Denis' OR first_name = 'Elvis';

SELECT * FROM employees
WHERE (first_name = 'Kellie' OR first_name = 'Aruna') AND gender = 'F';

SELECT * FROM employees
WHERE first_name IN ('Cathie','Mark','Nathan');

SELECT * FROM employees
WHERE first_name IN('ELVIS','DENIS');

SELECT * FROM employees
WHERE first_name IN('JOHN','MARK','JACOB');

# % is for sequence of characters
SELECT * FROM employees
WHERE first_name LIKE ('Mar%');

SELECT * FROM employees
WHERE first_name LIKE ('%ar');

SELECT * FROM employees
WHERE first_name LIKE('%ar%');

# _ indicates single character
SELECT * FROM employees
WHERE first_name LIKE('MAR_');

SELECT * FROM employees
WHERE first_name NOT LIKE('%MAR%');

USE employees;
SELECT * FROM employees;

SELECT * FROM employees
WHERE first_name LIKE('MARK%');

SELECT * FROM employees
WHERE hire_date LIKE('%2000%');

SELECT * FROM employees
WHERE emp_no LIKE('1000_');

SELECT * FROM employees
WHERE first_name LIKE('%JACK%');

SELECT * FROM employees
WHERE first_name NOT LIKE('%JACK%');

#Included both date 1990-01-01 AND 2000-01-01
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';

#hire_date before 1990-01-01 and after 2000-01-01
 SELECT * FROM employees
 WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';
 
 SELECT * FROM salaries;
 
 SELECT * FROM salaries
 WHERE salary BETWEEN '66000' AND '70000';
 
 SELECT * FROM salaries
 WHERE salary NOT BETWEEN '10004' AND '10012';
 
 SELECT * FROM departments;
 
 SELECT * FROM departments
 WHERE dept_no BETWEEN 'd003' AND 'd006';
 
 SELECT * FROM employees
 WHERE first_name IS NOT NULL;
 
 SELECT * FROM employees
 WHERE first_name IS NULL;	
 
 SELECT * FROM departments;
 
 SELECT dept_name FROM departments
 WHERE dept_no IS NOT NULL;
 
 SELECT * FROM employees
 WHERE first_name != 'MARK';
 
 SELECT * FROM employees
 WHERE hire_date > '2000-01-01';
 
 SELECT * FROM employees
 WHERE gender = 'F' AND hire_date LIKE ('2000%');
 
 SELECT * FROM salaries
 WHERE salary > '150000';
 
 SELECT DISTINCT gender FROM employees;
 
 SELECT DISTINCT hire_date FROM employees; 

 SELECT * FROM employees;

 SELECT COUNT(emp_no) FROM employees;
 
 SELECT COUNT(first_name) FROM employees;
 
 SELECT COUNT(DISTINCT first_name) FROM employees;
 
 #This code is incorrect
 SELECT COUNT(salary>=100000) FROM salaries;
 
 SELECT COUNT(*) FROM salaries
 WHERE salary>=100000;
 
 SELECT COUNT(*) FROM dept_manager;
 
 SELECT * FROM employees
 ORDER BY first_name ASC;
 
 SELECT * FROM employees
 ORDER BY emp_no DESC;
 
 SELECT * FROM employees
 ORDER BY first_name,last_name ASC;
 
 SELECT * FROM employees
 ORDER BY hire_date DESC;
 
 SELECT COUNT(first_name) FROM employees;
 
 SELECT DISTINCT first_name FROM employees;
 
 SELECT first_name FROM employees
 GROUP BY first_name;
 
 SELECT COUNT(first_name) FROM employees
 GROUP BY first_name; 
 
 SELECT first_name,COUNT(first_name) FROM employees
 GROUP BY first_name
 ORDER BY count(first_name) ASC;
 
 #AS indicates Alias is used to rename the column of your query 
 SELECT first_name,COUNT(first_name) as name_count FROM employees
 GROUP BY first_name
 ORDER BY first_name ASC;
 
 SELECT salary,COUNT(emp_no) as emps_with_same_salary FROM salaries
 WHERE salary > 80000
 GROUP BY salary
 ORDER BY salary ASC;
 
 SELECT first_name,COUNT(first_name) as name_count FROM employees
 GROUP By first_name
 HAVING COUNT(first_name) > 250
 ORDER BY first_name ASC;
 
 SELECT emp_no,AVG(salary) as avg_salary FROM salaries
 GROUP BY emp_no
 HAVING AVG(salary) > 120000
 ORDER BY emp_no;
 
 SELECT first_name,COUNT(first_name) as count_name FROM employees
 WHERE hire_date > '1999-01-01'
 GROUP BY first_name
 HAVING COUNT(first_name) < 200
 ORDER BY first_name DESC;
 
 SELECT * FROM dept_emp;
 
 SELECT emp_no, COUNT(dept_no) as count_dept FROM dept_emp
 WHERE from_date > '2000-01-01'
 GROUP BY emp_no
 HAVING COUNT(dept_no) > 1
 ORDER BY emp_no;
 
 SELECT * FROM salaries
 WHERE salary > 100000
 ORDER BY salary DESC
 LIMIT 10;
 
 USE employees;
 SELECT * FROM employees;
 INSERT INTO employees(
     emp_no,
     birth_date,
     first_name,
     last_name,
     gender,
     hire_date
 )
 VALUES(
    999901,
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
 );

 INSERT INTO employees(
      birth_date,
      emp_no,
      first_name,
      last_name,
      gender,
      hire_date
 )
 VALUES(
      '1977-09-14',
       999903,
      'Johnathan',
      'Creek',
      'M',
      '1999-01-01'
 );
 
 SELECT * FROM employees
 ORDER BY emp_no DESC
 LIMIT 10; 
 
 SELECT * FROM titles
 LIMIT 10;
 
 INSERT INTO titles(
     emp_no,
     title,
     from_date
 )
 VALUES(
     999903,
     'Senior Engineer',
     '1997-01-01'
 );
 
 SELECT * FROM titles
 ORDER BY emp_no DESC
 LIMIT 10;
 
 SELECT * FROM dept_emp;
 
 INSERT INTO dept_emp(
     emp_no,
     dept_no,
     from_date,
     to_date
 )
 VALUES(
     999903,
     'd005',
     '1997-10-01',
     '9999-01-01'
 );
 
 SELECT * FROM dept_emp
 ORDER BY emp_no DESC
 LIMIT 10;
 
 CREATE TABLE departments_dup(
     dept_no CHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL
 );
 
 SElECT * FROM departments_dup;	
 
 INSERT INTO departments_dup(
    dept_no,
    dept_name
 )
 SELECT * FROM departments;
 
 SELECT * FROM departments_dup
 ORDER BY dept_no DESC;
 
 INSERT INTO departments
 VALUES('d010','Business Analysis');
 
 SELECT*FROM departments;
 
 USE employees;
 UPDATE employees
 SET
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = '999901';
    
SELECT * FROM departments;

UPDATE departments
SET 
   dept_name = 'Data Analysis'
WHERE
   dept_name = 'Business Analysis';
   
SELECT * FROM departments;

DELETE FROM departments
WHERE dept_no = 'd010';

SELECT COUNT(DISTINCT dept_no) FROM departments;

SELECT SUM(salary) FROM salaries
WHERE from_date > '1997-01-01';

SELECT emp_no,MAX(salary) as max_salary,MIN(salary) as min_salary FROM salaries;

SELECT MAX(emp_no) as MAX_emp_no, MIN(emp_no) as MIN_emp_no FROM salaries;

SELECT AVG(salary) FROM salaries;

SELECT AVG(salary) FROM salaries
WHERE from_date > '1997-01-01';

SELECT ROUND(AVG(salary),2) FROM salaries;

SELECT ROUND(AVG(salary),2) FROM salaries
WHERE from_date > '1997-01-01';

SELECT dept_no, IFNULL(dept_name,'Department name not provided') as dept_name 
FROM departments_dup;

SELECT dept_no,dept_name,IFNULL(dept_no,dept_name) as dept_info
FROM departments_dup
ORDER BY dept_no;

SELECT IFNULL(dept_no,'N/A'),IFNULL(dept_name,'Department name not provided'),COALESCE(dept_no,dept_name) as dept_info
FROM departments_dup
ORDER BY dept_no;

CREATE TABLE departments_dup(dept_no VARCHAR(4),dept_name VARCHAR(64));

INSERT INTO departments_dup(
    dept_no,
    dept_name
)
SELECT * FROM departments; 

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no VARCHAR(4) NULL;

SELECT * FROM departments_dup;

INSERT INTO departments_dup(dept_name)
VALUES('Public Relations');

INSERT INTO departments_dup(dept_no)
VALUES('d010'),('d011');

CREATE TABLE dept_manager_dup(
     emp_no INT(11) NOT NULL,
	 dept_no CHAR(4) NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL
);

ALTER TABLE dept_manager_dup
CHANGE COLUMN to_date to_date DATE NULL;	

ALTER TABLE dept_manager_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

INSERT INTO dept_manager_dup(emp_no,from_date)
VALUES(999904,'2071-01-01'),(999905,'2017-01-01'),
      (999906,'2017-01-01'),(999907,'2017-01-01');
      
DELETE FROM dept_manager_dup
WHERE dept_no = 'd002';

SELECT m.dept_no,m.emp_no,n.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup n ON m.dept_no = n.dept_no
ORDER BY m.dept_no;

SELECT * FROM employees;
SELECT * FROM dept_manager_dup;

SELECT m.emp_no,m.first_name,m.last_name,m.hire_date,n.dept_no
FROM employees m
INNER JOIN dept_manager_dup n ON m.emp_no = n.emp_no
ORDER BY emp_no; 
		   
INSERT INTO dept_manager_dup
VALUES('110228','d003','1992-03-21','9999-01-01');

INSERT INTO departments_dup
VALUES('d009','Customer Service');

SELECT * FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no = 'd009';

INSERT INTO dept_manager_dup
VALUES('110228','d003','1992-02-21','9999-01-01');

INSERT INTO departments_dup
VALUES('d009','Customer Service'); 

#LEFT JOIN
SELECT m.dept_no,m.emp_no,n.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup n ON m.dept_no = n.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

SELECT a.emp_no,a.first_name,a.last_name,b.dept_no,b.from_date
FROM employees a
LEFT JOIN dept_manager b ON a.emp_no = b.emp_no
WHERE a.last_name = 'Markovitch'
ORDER BY b.dept_no DESC,a.emp_no;

SELECT e.emp_no,e.first_name,e.last_name,e.hire_date,d.dept_no
FROM employees e,dept_manager d
WHERE e.emp_no = d.emp_no;

SELECT e.emp_no,e.first_name,e.last_name,s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > 145000
ORDER BY e.emp_no;

SELECT e.first_name,e.last_name,e.hire_date,t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta' AND last_name = 'Markovitch'
ORDER BY first_name;

SELECT dm.*,d.*
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY emp_no,d.dept_no;

SELECT e.*,d.*
FROM departments d
CROSS JOIN dept_manager dm
JOIN employees e
WHERE d.dept_no != dm.dept_no;

SELECT * FROM dept_manager;

USE employees;

SELECT dm.*,d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no = 'd009'
ORDER BY dm.dept_no;

SELECT e.*,d.*
FROM employees e
CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no,d.dept_no;

SELECT e.gender,AVG(s.salary) as average_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;

SELECT e.first_name,e.last_name,e.hire_date,dm.from_date,d.dept_name
FROM employees e
     JOIN
dept_manager dm ON e.emp_no = dm.emp_no
     JOIN
departments d ON dm.dept_no = d.dept_no;

SELECT e.first_name,e.last_name,e.hire_date,t.title,t.from_date,d.dept_name
FROM employees e
   JOIN
titles t ON e.emp_no = t.emp_no
   JOIN
dept_manager dm ON dm.emp_no = e.emp_no
   JOIN
departments d ON d.dept_no = dm.dept_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

SELECT d.dept_name,AVG(salary)
FROM dept_manager dm
     JOIN
departments d ON dm.dept_no = d.dept_no
     JOIN
salaries s ON s.emp_no = dm.emp_no
GROUP BY d.dept_name
HAVING AVG(salary) > 60000
ORDER BY d.dept_no;

SELECT e.gender,COUNT(e.gender) as num_gender
FROM employees e
    JOIN
dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

CREATE TABLE employees_dup(
   emp_no INT(11),
   birth_date DATE,
   first_name VARCHAR(14),
   last_name VARCHAR(11),
   gender ENUM('M','F'),
   hire_date DATE
);

INSERT INTO employees_dup
SELECT e.*
FROM employees e
LIMIT 20;

INSERT INTO employees_dup 
VALUES('10001','1953-09-02','Georgi','Facello','M','1986-06-26');

SELECT * FROM employees_dup
WHERE emp_no = '10001';

#Combine tables vertically
#Union dont include duplicated values
SELECT 
   e.emp_no,
   e.first_name,
   e.last_name,
   NULL AS dept_no,
   NULL AS from_date
FROM
   employees_dup e
WHERE
   emp_no = '10001'
UNION ALL SELECT 
   NULL AS emp_no,
   NULL AS first_name,
   NULL AS last_name,
   m.dept_no,
   m.from_date
FROM 
   dept_manager m;

SELECT e.first_name,e.last_name
FROM employees e
WHERE e.emp_no IN (SELECT dm.emp_no FROM dept_manager dm);

SELECT * FROM dept_manager dm
WHERE dm.emp_no 
IN (SELECT e.emp_no FROM employees e 
    WHERE  hire_date BETWEEN '1990-01-01' AND '1995-01-01');

SELECT e.first_name,e.last_name
FROM employees e
WHERE EXISTS (SELECT emp_no FROM dept_manager)
ORDER BY first_name,last_name;

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            title
        FROM
            titles t
        WHERE
            (t.title = 'Assistant Engineer' AND t.emp_no = e.emp_no));
            
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager(
   emp_no INT(11) NOT NULL,
   dept_no CHAR(4) NULL,
   manager_no INT(11) NOT NULL
);




      