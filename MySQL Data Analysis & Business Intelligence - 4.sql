USE employees_mod;

#Tableau Task 1
SELECT * FROM t_dept_emp;

SELECT 
      YEAR(d.from_date) AS calender_year,
      e.gender AS gender,
      COUNT(e.emp_no) AS num_of_employees
FROM
      t_employees e
      JOIN
      t_dept_emp d ON e.emp_no = d.emp_no
GROUP BY calender_year,gender
HAVING calender_year >= 1990;

#Tableau Task 2
SELECT
      d.dept_name,
      ee.gender,
      dm.emp_no,
      dm.from_date,
      dm.to_date,
      e.calender_year,
      CASE WHEN YEAR(dm.to_date) >= e.calender_year 
		   AND YEAR(dm.from_date) <= e.calender_year 
           THEN 1
           ELSE 0
	  END AS active1
FROM 
     (SELECT
            YEAR(hire_date) AS calender_year
	  FROM
            t_employees 
	  GROUP BY calender_year) e
      CROSS JOIN
      t_dept_manager dm
      JOIN
      t_departments d ON d.dept_no = dm.dept_no
      JOIN
      t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no,calender_year;

#Task 3
SELECT
      e.gender AS gender,
      d.dept_name AS dept_name,
      ROUND(AVG(s.salary),2) AS salary,
      YEAR(s.from_date) AS calender_year
FROM 
      t_employees e
      JOIN
      t_salaries s ON e.emp_no = s.emp_no
      JOIN
      t_dept_emp de ON de.emp_no = s.emp_no
      JOIN
      t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no,e.gender,calender_year
HAVING calender_year <= 2002
ORDER BY d.dept_no;

#Task 4
DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary(IN p_min_salary FLOAT,IN p_max_salary FLOAT)
BEGIN
SELECT 
      e.gender,
      d.dept_name,
      ROUND(AVG(s.salary),2) AS avg_salary
FROM  
      t_salaries s
      JOIN
      t_employees e ON s.emp_no = e.emp_no
      JOIN
      t_dept_emp de ON de.emp_no = e.emp_no
      JOIN
      t_departments d ON d.dept_no = de.dept_no
WHERE 
      s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY 
      d.dept_no,e.gender;
END $$
DELIMITER ;

CALL filter_salary(50000,90000);
