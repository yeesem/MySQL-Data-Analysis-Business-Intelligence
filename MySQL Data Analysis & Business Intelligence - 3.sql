USE employees;
SELECT A.* FROM
(SELECT 
    e.emp_no AS employee_ID,
    MIN(d.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager 
        WHERE
            emp_no = 110022) as manager_ID
FROM
    employees e
        JOIN
    dept_emp d ON e.emp_no = d.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no) AS A
UNION SELECT B.* FROM
 (SELECT 
   e.emp_no as employee_ID ,
   MIN(d.dept_no) as department_code,
   (SELECT 
           emp_no 
	   FROM 
           dept_manager 
	   WHERE 
            emp_no = 110039) as manager_ID
FROM 
       employees e
         JOIN
       dept_emp d ON e.emp_no = d.emp_no
WHERE 
        e.emp_no > 10020 
GROUP BY e.emp_no
ORDER BY e.emp_no
LIMIT 20) AS B


#Incorrect
INSERT INTO emp_manager
   SELECT U.* FROM
     (SELECT A.* FROM 
        (SELECT e.emp_no as employee_ID,
        MIN(d.dept_no) as department_code,
        (SELECT emp_no FROM dept_manager WHERE emp_no = 110022) AS manager_ID
	  FROM employees e
           JOIN
	  dept_emp d ON e.emp_no = d.emp_no
      WHERE e.emp_no <= 10020
      GROUP BY e.emp_no
      ORDER BY e.emp_no
     ) AS A UNION SELECT
        B.*
	 FROM 
     (SELECT e.emp_no AS employee_ID,
             MIN(d.dept_no) AS department_code,
	         (SELECT emp_no FROM dept_manager WHERE emp_no = 110039) as manager_ID
	  FROM employees e
           JOIN
	  dept_emp d ON e.emp_no = d.emp_no
      WHERE e.emp_no > 10020
      GROUP BY e.emp_no
      ORDER BY e.emp_no
      LIMIT 20) AS B UNION SELECT 
         C.*
	  FROM
         (SELECT e.emp_no AS employee_ID,
                 MIN(d.dept_no) AS department_code,
                 (SELECT emp_no FROM dept_manager WHERE emp_no = 110039) AS manager_ID
		  FROM employees e
               JOIN
		  dept_emp d ON e.emp_no = d.emp_no
          WHERE e.emp_no = 110022
          GROUP BY e.emp_no
          ) AS C UNION SELECT 
		  DE.*
	  FROM 
          (SELECT e.emp_no AS employee_ID,
                  MIN(d.dept_no) AS department_code,
                  (SELECT emp_no FROM dept_manager WHERE emp_no = 110022)
           FROM employees e
                JOIN
		   dept_emp d ON e.emp_no = d.emp_no
           WHERE e.emp_no = 110039
           GROUP BY e.emp_no
		  ) AS DE) AS U;
          
#Correct
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
    
    #Self Join
    SELECT DISTINCT e1.*
    FROM 
        emp_manager e1
            JOIN
		emp_manager e2 ON e1.emp_no = e2.manager_no; 
        
	SELECT
          e1.*
	FROM
          emp_manager e1
             JOIN
		  emp_manager e2 ON e1.emp_no = e2.manager_no
	WHERE e2.emp_no IN 
          (SELECT manager_no FROM emp_manager);
          
	#Views
    SELECT 
       emp_no,from_date,to_date,COUNT(emp_no) AS NUM
	FROM 
       dept_emp
	GROUP BY emp_no
    HAVING NUM > 1;
    
    SELECT 
          emp_no,MAX(from_date) AS from_date,MAX(to_date) AS to_date
	FROM
          dept_emp
    GROUP BY emp_no;
    
    CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT
          emp_no,MAX(from_date) AS from_date,MAX(to_date) AS to_date
	FROM
          dept_emp
	GROUP BY emp_no;
    
    SELECT * FROM salaries;
    SELECT * FROM emp_manager;
    
    USE employees;
    
    #Create a view to extract the average salary of all manager
    CREATE OR REPLACE VIEW v_avg_manager_salary AS 
    SELECT
		 ROUND(AVG(s.salary),2)  
    FROM salaries s
         JOIN
		 dept_manager em ON s.emp_no = em.emp_no;
         
	DROP PROCEDURE IF EXISTS select_employee;
    
    DELIMITER $$
    CREATE PROCEDURE select_employee()
    BEGIN
         SELECT * FROM employees
         LIMIT 1000;
	END$$
    DELIMITER ;
    
    #Call procedure
    CALL employees.select_employee();
    
    #Create a procedure that will show the avg salary of all employees
    DELIMITER $$
    CREATE PROCEDURE employee_avg_salary()
    BEGIN
          SELECT avg(salary) FROM salaries;
    END $$
    DELIMITER ;
    
    CALL employees.employee_avg_salary;
    
    DELIMITER $$
    CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
    BEGIN
         SELECT e.first_name,e.last_name,s.salary,s.from_date,s.to_date
         FROM 
              employees e
			  JOIN
              salaries s ON e.emp_no = s.emp_no
              WHERE
                   p_emp_no = e.emp_no;
    END $$
    DELIMITER ;
    
    DELIMITER $$
    CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
    BEGIN
         SELECT e.first_name,e.last_name,AVG(s.salary)
         FROM 
              employees e
			  JOIN
              salaries s ON e.emp_no = s.emp_no
              WHERE
                   p_emp_no = e.emp_no;
    END $$
    DELIMITER ;
    
    CALL employees.emp_avg_salary(11300);
    
    DROP PROCEDURE emp_avg_salary_out;
    
    DELIMITER $$
    CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER,OUT p_avg_salary DECIMAL(10,2))
    BEGIN
          SELECT AVG(s.salary)
          INTO p_avg_salary 
          FROM employees e
               JOIN
		  salaries s ON e.emp_no = s.emp_no
          WHERE
               e.emp_no = p_emp_no;
    END $$
    DELIMITER ;      
    
    DELIMITER $$
    CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255),IN p_last_name VARCHAR(255),OUT p_emp_no INTEGER)
    BEGIN
          SELECT 
                e.emp_no
		  INTO p_emp_no FROM 
               employees e
          WHERE
               e.first_name = p_first_name AND e.last_name = p_last_name;
    END $$
    DELIMITER ;
    
    SET @p_avg_emp_salary = 0;
    CALL employees.emp_avg_salary_out(11300,@p_avg_salary);
	SELECT @p_avg_salary as employee_average_salary;
    
    SET @v_emp_no = 0;
    CALL employees.emp_info('Aruna','Journel',@v_emp_no);
    SELECT @v_emp_no;
    
    DELIMITER $$
    CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
    DETERMINISTIC
    BEGIN
    DECLARE v_avg_salary DECIMAL(10,2);
         SELECT 
                AVG(s.salary) INTO v_avg_salary
		 FROM 
                employees e
                JOIN
                salaries s ON e.emp_no = s.emp_no
		WHERE e.emp_no = p_emp_no;
	RETURN v_avg_salary;
    END $$
    DELIMITER ;
    
    SELECT f_emp_avg_salary(11300);
    
    DELIMITER $$
    CREATE FUNCTION f_emp_info(p_first_name VARCHAR(255),p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
    DETERMINISTIC
    BEGIN
    DECLARE v_latest_salary DECIMAL(10,2);
    DECLARE v_max_from_date DATE;
    
    SELECT
          MAX(from_date) INTO v_max_from_date
	FROM
          employees e
          JOIN
	      salaries s ON s.emp_no = e.emp_no
    WHERE p_first_name = e.first_name AND p_last_name = e.last_name;
    
    SELECT 
          s.salary INTO v_latest_salary
	FROM
          employees e
		  JOIN
          salaries s ON s.emp_no = e.emp_no
	WHERE 
          p_first_name = e.first_name AND p_last_name = e.last_name 
          AND s.from_date = v_max_from_date;
    RETURN v_latest_salary;
    END $$
    DELIMITER ;
    
    SELECT f_emp_info('Aruna', 'Journel');
    
    
    #Session variable
    SET @session_variable = 3;
    
    SELECT @session_variable;
    
    #Only system variable can set as global such as max_connections
    
    #Trigger
    DELIMITER $$
    CREATE TRIGGER before_salaries_insert
    BEFORE INSERT ON salaries
    FOR EACH ROW
    BEGIN
          IF NEW.salary < 0 THEN
             SET NEW.salary = 0;
		  END IF;
    END $$
    DELIMITER ;
          
    INSERT INTO salaries
	VALUES('10001',-9,'2010-06-22','9999-01-01');
    
    SELECT * FROM salaries
    WHERE emp_no = '10001';
    
    #Format Date
    SELECT DATE_FORMAT(sysdate(),'%y-%m-%d') AS today;
    
    
    DELIMITER $$
    CREATE TRIGGER trig_ins_dept_mng
    AFTER INSERT ON dept_manager
    FOR EACH ROW
    BEGIN
         DECLARE v_curr_salary INT;
         SELECT
               MAX(salary)
               INTO v_curr_salary FROM salaries
		 WHERE emp_no = NEW.emp_no;
         
         IF v_curr_salary IS NOT NULL THEN
         UPDATE salaries
         SET
            to_date = sysdate()
		 WHERE
            emp_no = NEW.emp_no AND to_date = NEW.to_date;
            
		 INSERT INTO salaries 
         VALUES(NEW.emp_no,v_curr_salary + 20000,NEW.from_date,NEW.to_date);
         END IF;
    END $$
    DELIMITER ;
    
    DELIMITER $$
    CREATE TRIGGER update_inppropriate_hire_date
    BEFORE INSERT ON employees
    FOR EACH ROW
    BEGIN 
          IF NEW.hire_date > date_format(sysdate(),'%Y-%M-%D') THEN
		  SET NEW.hire_date = date_format(sysdate(),'%Y-%M-%D');
          END IF; 	
    END $$
    DELIMITER ;	
    
    #MySQL Index
    #INDEX is useful in inproving the machine's searching time
    #Optimise machine searching
    SELECT * FROM employees WHERE hire_date > '2000-01-01';
    CREATE INDEX i_hire_date ON employees(hire_date);
    
    SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';
    CREATE INDEX i_composite_index ON employees(first_name,last_name);
    
    SHOW INDEX FROM employees.employees;
    SHOW INDEX FROM employees.salaries;
    SHOW INDEX FROM employees;
    
    ALTER TABLE employees
    DROP INDEX i_hire_date;
    
    SELECT * FROM salaries
    WHERE salary > 89000;
    
    CREATE INDEX i_salary ON salaries(salary);
    
    #MySQL CASE
    #Method 1
    SELECT
          emp_no,
          first_name,
          last_name,
          CASE gender
               WHEN 'M' THEN 'MALE'
               ELSE 'FEMALE'
          END AS gender
	FROM
        employees;
        
	#Method 2
    SELECT
          emp_no,
          first_name,
          last_name,
          IF(gender = 'M','Male','Female')
	FROM
		employees;
        
	#More than 2 case
    SELECT 
          dm.emp_no, 
          e.first_name,
          e.last_name,
          MAX(s.salary) - MIN(s.salary) AS salary_difference,
          CASE
              WHEN  MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than 30000'
              WHEN  MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 
              'Salary was raised more than 20000 but less than 30000'
              ELSE 'Salary was raised less than 20000'
		  END AS salary_difference_description
	FROM
          employees e
          JOIN
          salaries s ON e.emp_no = s.emp_no
          JOIN
          dept_manager dm ON e.emp_no = dm.emp_no
	GROUP BY dm.emp_no;
    
    SELECT
          e.emp_no,
          e.first_name,
          e.last_name,
          CASE 
              WHEN dm.emp_no IS NOT NULL THEN 'Manager'
              ELSE 'employee'
		  END AS Position
	FROM 
         employees e
         LEFT JOIN
         dept_manager dm ON dm.emp_no = e.emp_no
	WHERE
         e.emp_no > 109990;
         
	
    SELECT
          dm.emp_no,
          e.first_name,
          e.last_name,
          MAX(s.salary) - MIN(s.salary) AS salary_difference,
          CASE
              WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN
              'Salary was raised by more then $30,000'
              ELSE 'Salary was NOT raised by more then $30,000'
              
              #Alternative method
              #IF(MAX(s.salary) - MIN(s.salary) > 30000,'TRUE','FALSE')
              
		  END AS salary_rise
	FROM
          dept_manager dm
	      JOIN
          employees e ON dm.emp_no = e.emp_no
          JOIN
          salaries s ON s.emp_no = e.emp_no
	GROUP BY s.emp_no;
    
    SELECT 
          dm.emp_no,
          e.first_name,
          e.last_name,
          CASE
              WHEN dm.to_date > sysdate() THEN 'current_employee'
              ELSE 'Not an employee anymore'
		  END AS employee_status 
	FROM 
          employees e
          JOIN
          dept_emp dm ON e.emp_no = dm.emp_no
	GROUP BY e.emp_no;
    
    SELECT
       COUNT(*) AS number_of_current_employees
	FROM(
     SELECT 
          dm.emp_no,
          e.first_name,
          e.last_name,
          CASE
              WHEN dm.to_date > sysdate() THEN 'current_employee'
              ELSE 'Not an employee anymore'
		  END AS employee_status 
	FROM 
          employees e
          JOIN
          dept_emp dm ON e.emp_no = dm.emp_no
	GROUP BY e.emp_no) AS subquery
    WHERE subquery.employee_status = 'current_employee';

	SELECT 
    CASE
        WHEN dm.to_date > CURDATE() THEN 'current_employee'
        ELSE 'Not an employee anymore'
	END as employee_status,
    COUNT(*) AS employee_count
    FROM
        employees e
        JOIN
        dept_emp dm ON e.emp_no = dm.emp_no
	GROUP BY employee_status;
    
    #WINDOW FUNCTION
    SELECT
          emp_no,
          salary,
          ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
	FROM
          salaries;
          
	SELECT
          emp_no,
          dept_no,
          ROW_NUMBER()OVER(ORDER BY emp_no) AS row_num
    FROM
         dept_manager;
	
    SELECT
         first_name,
         last_name,
         ROW_NUMBER()OVER(PARTITION BY first_name ORDER BY last_name DESC) AS row_num
	FROM
         employees e;
         
	#Multiple window function
    SELECT 
          emp_no,
          salary,
	      #ROW_NUMBER()OVER() AS row_num1,
          ROW_NUMBER()OVER(PARTITION BY emp_no) AS row_num2,
          ROW_NUMBER()OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num3
          #ROW_NUMBER()OVER(ORDER BY salary DESC) AS row_num4
	FROM
         salaries;
	#ORDER BY emp_no,salary;
    
    SELECT 
          dm.emp_no,
          salary,
          ROW_NUMBER()OVER(PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,
          ROW_NUMBER()OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
	FROM
        dept_manager dm
        JOIN
        salaries s ON dm.emp_no = s.emp_no;
        
	SELECT
          dm.emp_no,
          salary,
          ROW_NUMBER()OVER()AS row_num1,
          ROW_NUMBER()OVER(PARTITION BY emp_no ORDER BY salary DESC)AS row_num2
          FROM 
              dept_manager dm
              JOIN
              salaries s ON dm.emp_no = s.emp_no
	ORDER BY row_num1,dm.emp_no,salary ASC;
    
    
    SELECT 
          dm.emp_no,
          s.salary,
          ROW_NUMBER()OVER w AS row_num1
	FROM
          dept_manager dm
          JOIN
          salaries s ON dm.emp_no = s.emp_no
	WINDOW w AS (PARTITION BY emp_no);
          
	SELECT 
          emp_no,
          first_name,
          last_name,
          ROW_NUMBER()OVER w AS row_num1
	FROM
          employees
	WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);
          
	SELECT
          a.emp_no,
          MIN(salary)
	FROM(
         SELECT
               emp_no,
               salary,
               ROW_NUMBER()OVER w AS row_num1
		 FROM
		       salaries 
		 WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
	GROUP BY emp_no;
    
    SELECT 
          a.emp_no,
		  MIN(salary) AS min_salary
    FROM(
          SELECT
                emp_no,
                salary,
                ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary)
		  FROM
                salaries) a
	GROUP BY emp_no;
    
      SELECT 
          a.emp_no,
		  MIN(salary) AS min_salary
    FROM(
          SELECT
                emp_no,
                salary
		  FROM
                salaries) a
	GROUP BY emp_no;
         
	SELECT 
          a.emp_no,
          salary
	FROM(
         SELECT
               emp_no,
			   salary,
		       ROW_NUMBER()OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num1
         FROM
             salaries) a
	WHERE a.row_num1 = 1;
               
	#RANK() && DENSE_RANK()
    SELECT
          emp_no,
          salary,
		  RANK()OVER(PARTITION BY emp_no ORDER BY salary) AS rank_num
	FROM 
          salaries;
          
	SELECT
          emp_no,
          salary,
		  DENSE_RANK()OVER w AS rank_num
	FROM 
          salaries
	WHERE emp_no = 11839
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary);
    
    SELECT
          emp_no,
          salary,
          ROW_NUMBER()OVER w AS rank_num1
	FROM
          salaries
	WHERE emp_no = 10560
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
    
    SELECT 
          dm.emp_no,(COUNT(salary)) AS no_of_salary_contracts
	FROM
          dept_manager dm 
          JOIN
          salaries s ON dm.emp_no = s.emp_no
	GROUP BY emp_no
    ORDER BY emp_no;
    
    SELECT 
          emp_no,
          salary,
          RANK()OVER w AS rank_num1
	FROM
          salaries
	WHERE emp_no = 10560
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
    
    SELECT
          emp_no,
          salary,
	      DENSE_RANK()OVER w AS rank_num
	FROM
          salaries
	WHERE emp_no = 10560
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary);
    
    
    #Ranking window function and rank()
    SELECT 
          d.dept_no,
          d.dept_name,
          RANK()OVER w AS department_salary_ranking,
          s.salary,
          s.from_date AS salary_from_date,
          s.to_date AS salary_to_date,
          dm.from_date AS dept_manager_from_date,
          dm.to_date AS dept_manager_to_date
    FROM
          dept_manager dm
          JOIN
          salaries s ON dm.emp_no = s.emp_no
          JOIN
          departments d ON d.dept_no = dm.dept_no
             AND s.from_date BETWEEN dm.from_date AND dm.to_date
             AND s.to_date BETWEEN dm.from_date AND dm.to_date
	WINDOW w AS(PARTITION BY dept_no ORDER BY salary DESC);
   
    SELECT 
         e.emp_no,
         RANK()OVER w AS employee_salary_ranking,
         s.salary
	FROM
         employees e
         JOIN 
         salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no BETWEEN 10500 AND 10600
	WINDOW w AS (PARTITION BY emp_no ORDER BY s.salary DESC);
    
    SELECT
        e.emp_no,
        DENSE_RANK() OVER w AS employee_salary_ranking,
        s.salary,
        e.hire_date,
        s.from_date
    FROM
        employees e
        JOIN
        salaries s ON e.emp_no = s.emp_no
        AND (YEAR(s.from_date) - YEAR(e.hire_date)) >= 5
    WHERE
        e.emp_no BETWEEN 10500 AND 10600
	WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);
    
    #LAG() - returns the value from a specified field of a record that 
    #        precedes the current row
    #LEAD() - returns the value from a specified field of a record that 
    #         follows the current row
    SELECT
          emp_no,
          salary,
          LAG(salary)OVER w AS previous_salary,
          LEAD(salary)OVER w AS next_salary,
          salary - LAG(salary) OVER w AS diff_salary_current_previous,
          LEAD(salary) OVER w - salary AS diff_salary_current_next
	FROM
          salaries
	WHERE emp_no = 10001
    WINDOW w AS (ORDER BY salary);

    SELECT
          emp_no,
          salary,
          LAG(salary) OVER w AS previous_salary,
          LEAD(salary) OVER w AS next_salary,
          salary - LAG(salary) OVER w AS diff_salary_current_previous,
          LEAD(salary) OVER w  - salary AS diff_salary_next_current
	FROM
          salaries
	WHERE
          salary > 80000 AND emp_no BETWEEN 10500 AND 10600
	WINDOW w AS (ORDER BY salary);
    
    SELECT 
          emp_no,
          salary,
          LAG(salary) OVER w AS previous_salary,
          LAG(salary,2) OVER w AS 1_previous_salary,
          LEAD(salary) OVER w AS next_salary,
          LEAD(salary,2) OVER w As 1_after_next_salary
	FROM
          salaries
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
    LIMIT 1000;
    
    SELECT
          emp_no,
          salary
	FROM
          salaries
	WHERE to_date > SYSDATE();
    
    SELECT 
          s1.emp_no,s.salary,s.from_date,s.to_date
	FROM
          salaries s
          JOIN
          (SELECT
                 emp_no,MAX(from_date) AS from_date
		   FROM salaries
           GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
	WHERE
		 s.to_date > SYSDATE()
          AND s.from_date = s1.from_date;
	
    SELECT
          s1.emp_no,
          s.salary,
          s.from_date,
          s.to_date
	FROM
          salaries s
          JOIN
          (SELECT 
                 emp_no,MIN(from_date) AS from_date
		   FROM 
                 salaries
		   GROUP BY emp_no) s1 ON s1.emp_no = s.emp_no
	WHERE s1.from_date = s.from_date;	
    
    SELECT 
          de2.emp_no,d.dept_name,s2.salary,AVG(s2.salary) OVER w
          AS average_salary_per_department
	FROM
         (SELECT
                de.emp_no,de.dept_no,de.from_date,de.to_date
		  FROM
				dept_emp de
		  JOIN
		 (SELECT
                emp_no,MAX(from_date) AS from_date
		  FROM 
                dept_emp
		  GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
	WHERE 
          de.to_date < '2002-01-01' AND de.from_date > '2000-01-01') de2
          JOIN
          (SELECT 
                 s1.emp_no,s.salary,s.from_date,s.to_date
		   FROM
                 salaries s
		   JOIN
           (SELECT 
                  emp_no,MAX(from_date) AS from_date
			FROM 
                  salaries
			GROUP BY emp_no)s1 ON s.emp_no = s1.emp_no
	WHERE
		s.to_date < '2002-01-01'AND s.from_date > '2000-01-01'
        AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
	JOIN

    departments d ON d.dept_no = de2.dept_no
    GROUP BY de2.emp_no, d.dept_name
    WINDOW w AS (PARTITION BY de2.dept_no)
    ORDER BY de2.emp_no, salary;
    
    #Common Table Expression
    WITH cts AS(
        SELECT AVG(salary) AS avg_salary FROM salaries)
	SELECT
        SUM(
            CASE
            WHEN s.salary > c.avg_salary THEN 1
            ELSE 0
		END) AS no_f_salaries_above_avg,
        COUNT(s.salary) AS total_no_salary_contracts
	FROM
        salaries s
        JOIN
        employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
		CROSS JOIN
        cts c;
	
    WITH cts AS(
		SELECT avg(salary) AS average_salary FROM salaries)
	SELECT 
        SUM(CASE 
            WHEN s.salary < c.average_salary
			THEN 1 
            ELSE 0
		 END) AS no_m_salary_abv_avg
	FROM
         salaries s
         JOIN
         employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
         CROSS JOIN
         cts c;
         
	WITH cts AS(
        SELECT AVG(salary) AS avg_salary FROM salaries
    )
    SELECT	
         COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END)
         AS no_salaries_below_avg_count
	FROM
         salaries s
         JOIN
         employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
	     CROSS JOIN
         cts c;
                
	SELECT 
          SUM(CASE WHEN s.salary<a.avg_salary 
              THEN 1 ELSE 0
              END) AS no_salaries_below_avg
	FROM
		(SELECT
               AVG(salary) AS avg_salary
		 FROM 
               salaries) a
		JOIN
        salaries s 
        JOIN
        employees e ON e.emp_no = s.emp_no AND e.gender = 'M';
        
	WITH cte AS(
        SELECT AVG(salary) AS avg_salary FROM salaries 
    )
    SELECT
        SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END)
        AS no_salaries_below_avg
	FROM
		salaries s 
		JOIN
        employees e	ON e.emp_no = s.emp_no 
        AND e.gender = 'M'
        CROSS JOIN
        cte c;
        
	
    #More than 1 cte 
    WITH cte1 AS(
         SELECT AVG(salary) AS avg_salary FROM salaries),
         cte2 AS(
         SELECT s.emp_no,MAX(s.salary) AS f_highest_salary
         FROM salaries s
         JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
         GROUP BY s.emp_no)
	SELECT 
         SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END)
         AS f_highest_salary_abv_avg,
         COUNT(e.emp_no) AS total_female_contracts
         FROM employees e
         JOIN cte2 c2 ON c2.emp_no = e.emp_no
         CROSS JOIN
         cte1 c1;
         
	WITH cte_avg_salary AS(
         SELECT AVG(salary) AS avg_salary FROM salaries),
	cte_f_highest_salary AS(
         SELECT s.emp_no,
				MAX(salary) AS f_highest_salary
		 FROM
                salaries s
                JOIN
                employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
		GROUP BY emp_no)
    SELECT
        SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END)
        AS f_highest_salary_above_avg,
        COUNT(e.emp_no) AS total_no_female_contract,
        CONCAT(ROUND(SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END) / COUNT(e.emp_no) * 100,2),'%') AS 'Percentage %'
	FROM
       employees e
       JOIN
       cte_avg_salary c1
       JOIN
       cte_f_highest_salary c2 ON c2.emp_no = e.emp_no; 
       
	WITH cte1 AS(
	   SELECT AVG(salary) AS avg_salary FROM salaries),
	cte2 AS(
       SELECT
             e.emp_no,MAX(salary) AS max_salary
	   FROM
             salaries s
			 JOIN
             employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
	   GROUP BY s.emp_no)
	SELECT 
          SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) 
          AS highest_salary_below_avg
          FROM
              employees e
              JOIN
              cte1 c1
              JOIN
              cte2 c2 ON c2.emp_no = e.emp_no;
	
    WITH cte1 AS(
	   SELECT AVG(salary) AS avg_salary FROM salaries),
	cte2 AS(
       SELECT
             e.emp_no,MAX(salary) AS max_salary
	   FROM
             salaries s
			 JOIN
             employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
	   GROUP BY s.emp_no)
	SELECT 
          COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) 
          AS highest_salary_below_avg
          FROM
              employees e
              JOIN
              cte1 c1
              JOIN
              cte2 c2 ON c2.emp_no = e.emp_no;
	
    WITH cte1 AS(
         SELECT AVG(salary) AS avg_salary FROM salaries),
	cte2 AS(
		 SELECT
               s.emp_no,MAX(salary) AS max_salary
		 FROM
               salaries s
               JOIN 
               employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
		GROUP BY s.emp_no)
	SELECT
        SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END)
        AS m_highest_salary_below_avg
        FROM 
            cte1 c1
			JOIN
            cte2 c2;

    WITH emp_hired_from_jan AS(
         SELECT * FROM employees WHERE hire_date > '2000-01-01'),
	highest_contract_salary_values AS(
         SELECT
               e.emp_no,
			   MAX(s.salary)
		 FROM
               emp_hired_from_jan e
               JOIN
               salaries s ON e.emp_no = s.emp_no
		 GROUP BY e.emp_no)
	SELECT * FROM highest_contract_salary_values;
    
    #MySQL Temporary Table
    CREATE TEMPORARY TABLE f_highest_salary
    SELECT 
          s.emp_no,MAX(salary) AS f_highest_salary
	FROM
          salaries s
          JOIN 
          employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
	GROUP BY emp_no
    LIMIT 10;
    
    SELECT 
          *
	FROM
         f_highest_salary;
	
    SELECT 
          *
	FROM
          f_highest_salary
	WHERE 
          emp_no > 10100;
          
    DROP TEMPORARY TABLE IF EXISTS f_highest_salary;
    
    CREATE TEMPORARY TABLE male_max_salaries
    SELECT 
		  s.emp_no,
          s.salary
	FROM
          salaries s
          JOIN
          employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
	GROUP BY e.emp_no;
   
    SELECT
          *
	FROM
          male_max_salaries;
    
	CREATE TEMPORARY TABLE dates
    SELECT
          NOW() AS current_year,
          DATE_SUB(NOW(),INTERVAL 1 MONTH) AS month_earlier,
          DATE_SUB(NOW(),INTERVAL -1 YEAR) AS year_after;

    SELECT 
          *
	FROM
          dates;
	
    #Exercise Temporary Table
    CREATE TEMPORARY TABLE dates_exercise
    SELECT
          NOW(),
          SUBDATE(NOW(),INTERVAL 2 MONTH) AS two_year_before,
          SUBDATE(NOW(),INTERVAL -2 YEAR) AS two_year_after;
          
	SELECT
          *
	FROM
         dates_exercise;
         
	WITH cte AS(
         SELECT 
               NOW() AS current_year,
               SUBDATE(NOW(),INTERVAL 2 MONTH ) AS cte_a_month_earlier,
               SUBDATE(NOW(),INTERVAL -2 YEAR) AS cte_a_year_later)
	SELECT
          *
	FROM
          dates JOIN cte;
          
    WITH cte AS (
         SELECT 
               NOW() AS current_year,
               SUBDATE(NOW(),INTERVAL 1 MONTH) AS cte_a_month_before,
               SUBDATE(NOW(),INTERVAL -1 YEAR) AS cte_a_year_after)
	SELECT * FROM dates UNION SELECT * FROM cte;
    
    DROP TEMPORARY TABLE male_max_salaries;
    DROP TEMPORARY TABLE IF EXISTS dates;
               
          
     
      
                
		
    