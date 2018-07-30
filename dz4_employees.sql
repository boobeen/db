-------------------------
----- ПРЕДСТАВЛЕНИЯ -----
-------------------------

CREATE VIEW depts AS SELECT departments.dept_name AS 'Department', AVG(salaries.salary) AS 'Average_salary' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no GROUP BY departments.dept_no;

SELECT * FROM depts;

-- mysql> SELECT * FROM depts;
-- +--------------------+----------------+
-- | Department         | Average_salary |
-- +--------------------+----------------+
-- | Marketing          |     71913.2000 |
-- | Finance            |     70489.3649 |
-- | Human Resources    |     55574.8794 |
-- | Production         |     59605.4825 |
-- | Development        |     59478.9012 |
-- | Quality Management |     57251.2719 |
-- | Sales              |     80665.5082 |
-- | Research           |     59665.1817 |
-- | Customer Service   |     58770.3665 |
-- +--------------------+----------------+
-- 9 rows in set (0.00 sec)

CREATE VIEW emp_with_max_sal AS SELECT employees.emp_no AS 'ID', CONCAT(employees.first_name, ' ', employees.last_name) AS 'FIO', salaries.salary AS 'Salary' FROM employees LEFT JOIN salaries ON employees.emp_no = salaries.emp_no ORDER BY salaries.salary DESC LIMIT 10;

SELECT * FROM emp_with_max_sal;

-- mysql> SELECT * FROM emp_with_max_sal;
-- +--------+-------------------+--------+
-- | ID     | FIO               | Salary |
-- +--------+-------------------+--------+
-- | 254466 | Honesty Mukaidono | 156286 |
-- |  47978 | Xiahua Whitcomb   | 155709 |
-- | 253939 | Sanjai Luders     | 155513 |
-- | 109334 | Tsutomu Alameldin | 155377 |
-- | 109334 | Tsutomu Alameldin | 155190 |
-- | 109334 | Tsutomu Alameldin | 154888 |
-- | 109334 | Tsutomu Alameldin | 154885 |
-- |  80823 | Willard Baca      | 154459 |
-- | 493158 | Lidong Meriste    | 154376 |
-- | 253939 | Sanjai Luders     | 154227 |
-- +--------+-------------------+--------+
-- 10 rows in set (0.00 sec)


--------------------
----- ТРИГГЕРЫ -----
--------------------

#1. Создаем триггер

DELIMITER $$ ;

CREATE TRIGGER bonus_for_new_emp AFTER INSERT ON employees
  FOR EACH ROW
  BEGIN
    INSERT INTO salaries SET emp_no = NEW.emp_no, salary = 5000, from_date = NEW.hire_date, to_date = NEW.hire_date;
  END $$;

DELIMITER ; $$

#2. Добавляем сотрудника

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date) VALUES ('666', '1980-04-11', 'Yuriy', 'Buley', 'M', CURDATA());

--#3. Проверяем таблицы `employees` и `salaries`--
SELECT * FROM employees LIMIT 5;
SELECT * FROM salaries LIMIT 5;

-- mysql> INSERT INTO employees (`emp_no`, `birth_date`, `first_name`, `last_name`, `gender`, `hire_date`) VALUES ('666', '1980-04-11', 'Yuriy', 'Buley', 'M', '2018-06-29'); SELECT * FROM employees LIMIT 5; SELECT * FROM salaries LIMIT 5;
-- Query OK, 1 row affected (0.00 sec)

-- +--------+------------+------------+-----------+--------+------------+
-- | emp_no | birth_date | first_name | last_name | gender | hire_date  |
-- +--------+------------+------------+-----------+--------+------------+
-- |    666 | 1980-04-11 | Yuriy      | Buley     | M      | 2018-06-29 |
-- |  10001 | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |
-- |  10002 | 1964-06-02 | Bezalel    | Simmel    | F      | 1985-11-21 |
-- |  10003 | 1959-12-03 | Parto      | Bamford   | M      | 1986-08-28 |
-- |  10004 | 1954-05-01 | Chirstian  | Koblick   | M      | 1986-12-01 |
-- +--------+------------+------------+-----------+--------+------------+
-- 5 rows in set (0.00 sec)

-- +--------+--------+------------+------------+
-- | emp_no | salary | from_date  | to_date    |
-- +--------+--------+------------+------------+
-- |    666 |   5000 | 2018-06-29 | 2018-06-29 |
-- |  10001 |  60117 | 1986-06-26 | 1987-06-26 |
-- |  10001 |  62102 | 1987-06-26 | 1988-06-25 |
-- |  10001 |  66074 | 1988-06-25 | 1989-06-25 |
-- |  10001 |  66596 | 1989-06-25 | 1990-06-25 |
-- +--------+--------+------------+------------+
-- 5 rows in set (0.00 sec)







