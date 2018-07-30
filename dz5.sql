#1. Вместо триггера из прошлого задания, можно выполнить транзакцию.

    -- 1. Удаляем триггер, чтобы он не создавал строку в salaries и сотрудника
    DROP TRIGGER bonus_for_new_emp;
    DELETE FROM employees WHERE emp_no = '666';

    -- 2. Добавляем сотрудника
    SET AUTOCOMMIT=0;
    START TRANSACTION;
    INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date) VALUES ('666', '1980-04-11', 'Yuriy', 'Buley', 'M', CURDATE());
    INSERT INTO salaries (emp_no, salary, from_date, to_date) VALUES ('666', '5000', CURDATE(), CURDATE());
    COMMIT;

    -- 3. Проверяем таблицы `employees` и `salaries`
    SELECT * FROM employees LIMIT 5;
    SELECT * FROM salaries LIMIT 5;



#2. Оптимизация

EXPLAIN SELECT departments.dept_name AS 'Dep', AVG(salaries.salary) AS 'AVG_Salary' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE departments.dept_no = 'd002';

-- mysql> EXPLAIN SELECT departments.dept_name AS 'Dep', AVG(salaries.salary) AS 'AVG_Salary' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE departments.dept_no = 'd002' \G;
-- *************************** 1. row ***************************
--            id: 1
--   select_type: SIMPLE
--         table: departments
--    partitions: NULL
--          type: const
-- possible_keys: PRIMARY
--           key: PRIMARY
--       key_len: 12
--           ref: const
--          rows: 1
--      filtered: 100.00
--         Extra: NULL
-- *************************** 2. row ***************************
--            id: 1
--   select_type: SIMPLE
--         table: dept_emp
--    partitions: NULL
--          type: ref
-- possible_keys: PRIMARY,emp_no,dept_no
--           key: dept_no
--       key_len: 12
--           ref: const
--          rows: 31892                   -- Много строк
--      filtered: 100.00
--         Extra: Using where; Using index
-- *************************** 3. row ***************************
--            id: 1
--   select_type: SIMPLE
--         table: salaries
--    partitions: NULL
--          type: ref
-- possible_keys: PRIMARY,emp_no
--           key: PRIMARY
--       key_len: 4
--           ref: employees.dept_emp.emp_no
--          rows: 9
--      filtered: 100.00
--         Extra: NULL
-- 3 rows in set, 1 warning (0.00 sec)


EXPLAIN SELECT employees.emp_no AS 'Таб.No', CONCAT(employees.first_name, ' ', employees.last_name) AS 'ФИО', MAX(salaries.salary) AS 'Макс. зарплата' FROM salaries LEFT JOIN employees ON  salaries.emp_no = employees.emp_no WHERE employees.emp_no = '55555';

-- mysql> EXPLAIN SELECT employees.emp_no AS 'Таб.No', CONCAT(employees.first_name, ' ', employees.last_name) AS 'ФИО', MAX(salaries.salary) AS 'Макс. зарплата' FROM salaries LEFT JOIN employees ON
--   salaries.emp_no = employees.emp_no WHERE employees.emp_no = '55555' \G;
-- *************************** 1. row ***************************
--            id: 1
--   select_type: SIMPLE
--         table: employees
--    partitions: NULL
--          type: const
-- possible_keys: PRIMARY
--           key: PRIMARY
--       key_len: 4
--           ref: const
--          rows: 1
--      filtered: 100.00
--         Extra: NULL
-- *************************** 2. row ***************************
--            id: 1
--   select_type: SIMPLE
--         table: salaries
--    partitions: NULL
--          type: ref
-- possible_keys: PRIMARY,emp_no
--           key: PRIMARY
--       key_len: 4
--           ref: const
--          rows: 15
--      filtered: 100.00
--         Extra: Using where
-- 2 rows in set, 1 warning (0.01 sec)