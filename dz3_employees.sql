#1. Выбрать среднюю зарплату по отделам

-- Определенный отдел по dept_no
SELECT departments.dept_name AS 'Отдел', AVG(salaries.salary) AS 'Средняя_зарплата' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE departments.dept_no = 'd002';

-- +---------+------------------+
-- | Отдел   | Средняя_зарплата |
-- +---------+------------------+
-- | Finance |       70489.3649 |
-- +---------+------------------+
-- 1 row in set (0.00 sec)

-- С группировкой по всем отделам
SELECT departments.dept_name AS 'Отдел', AVG(salaries.salary) AS 'Средняя_зарплата' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no GROUP BY departments.dept_no;

-- +--------------------+------------------+
-- | Отдел              | Средняя_зарплата |
-- +--------------------+------------------+
-- | Marketing          |       71913.2000 |
-- | Finance            |       70489.3649 |
-- | Human Resources    |       55574.8794 |
-- | Production         |       59605.4825 |
-- | Development        |       59478.9012 |
-- | Quality Management |       57251.2719 |
-- | Sales              |       80665.5082 |
-- | Research           |       59665.1817 |
-- | Customer Service   |       58770.3665 |
-- +--------------------+------------------+
-- 9 rows in set (0.03 sec)


#2. Выбрать максимальную зарплату у сотрудника

-- По emp_no
SELECT employees.emp_no AS 'Таб.No', CONCAT(employees.first_name, ' ', employees.last_name) AS 'ФИО', MAX(salaries.salary) AS 'Макс. зарплата' FROM salaries LEFT JOIN employees ON  salaries.emp_no = employees.emp_no WHERE employees.emp_no = '55555';

-- +--------+----------------+----------------+
-- | Таб.No | ФИО            | Макс. зарплата |
-- +--------+----------------+----------------+
-- |  55555 | Sachin Kandlur |          82660 |
-- +--------+----------------+----------------+
-- 1 row in set (0.00 sec)

-- Если знаем имя и фамилию
SELECT employees.emp_no AS 'Таб.No', CONCAT(employees.first_name, ' ', employees.last_name) AS 'ФИО', MAX(salaries.salary) AS 'Макс. зарплата' FROM salaries LEFT JOIN employees ON  salaries.emp_no = employees.emp_no WHERE employees.first_name = 'Ramzi' AND employees.last_name = 'Erde' GROUP BY employees.emp_no;

-- +--------+------------+----------------+
-- | Таб.No | ФИО        | Макс. зарплата |
-- +--------+------------+----------------+
-- |  10021 | Ramzi Erde |          84169 |
-- +--------+------------+----------------+
-- 1 row in set (0.03 sec)


# 3. Удаление сотрудника с максимальной зарплатой
-- Найти сотрудника с максимальной зарплатой

SELECT employees.emp_no AS 'Таб.No', CONCAT(employees.first_name, ' ', employees.last_name) AS 'ФИО', salaries.salary AS 'Зарплата' FROM employees LEFT JOIN salaries ON employees.emp_no = salaries.emp_no ORDER BY salaries.salary DESC LIMIT 10;

-- +--------+-------------------+----------+
-- | Таб.No | ФИО               | Зарплата |
-- +--------+-------------------+----------+
-- |  43624 | Tokuyasu Pesch    |   158220 |
-- |  43624 | Tokuyasu Pesch    |   157821 |
-- | 254466 | Honesty Mukaidono |   156286 |
-- |  47978 | Xiahua Whitcomb   |   155709 |
-- | 253939 | Sanjai Luders     |   155513 |
-- | 109334 | Tsutomu Alameldin |   155377 |
-- | 109334 | Tsutomu Alameldin |   155190 |
-- | 109334 | Tsutomu Alameldin |   154888 |
-- | 109334 | Tsutomu Alameldin |   154885 |
-- |  80823 | Willard Baca      |   154459 |
-- +--------+-------------------+----------+
-- 10 rows in set (0.00 sec)


-- Удалить сотрудника по emp_no

DELETE FROM employees WHERE emp_no = '43624';

-- Query OK, 1 row affected (0.55 sec)

-- Проверим максимальные зарплаты

SELECT employees.emp_no AS 'Таб.No', CONCAT(employees.first_name, ' ', employees.last_name) AS 'ФИО', salaries.salary AS 'Зарплата' FROM employees LEFT JOIN salaries ON employees.emp_no = salaries.emp_no ORDER BY salaries.salary DESC LIMIT 10;

-- +--------+-------------------+----------+
-- | Таб.No | ФИО               | Зарплата |
-- +--------+-------------------+----------+
-- | 254466 | Honesty Mukaidono |   156286 |
-- |  47978 | Xiahua Whitcomb   |   155709 |
-- | 253939 | Sanjai Luders     |   155513 |
-- | 109334 | Tsutomu Alameldin |   155377 |
-- | 109334 | Tsutomu Alameldin |   155190 |
-- | 109334 | Tsutomu Alameldin |   154888 |
-- | 109334 | Tsutomu Alameldin |   154885 |
-- |  80823 | Willard Baca      |   154459 |
-- | 493158 | Lidong Meriste    |   154376 |
-- | 253939 | Sanjai Luders     |   154227 |
-- +--------+-------------------+----------+
-- 10 rows in set (0.00 sec)

-- Сотрудника с emp_no = 43624 теперь в базе нету


# 4. Подсчет сотрудников
-- Во всех отделах (все сотрудники, у которых нет даты увольнения)
SELECT count(*) AS 'Количество сотрудников' FROM dept_emp WHERE to_date = '9999-01-01';

-- +------------------------+
-- | Количество сотрудников |
-- +------------------------+
-- |                 240123 |
-- +------------------------+
-- 1 row in set (0.00 sec)

-- Определенный отдел по dept_no
SELECT departments.dept_name AS 'Отдел', count(*) AS 'Количество сотрудников' FROM dept_emp LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE dept_emp.dept_no = 'd005' AND to_date = '9999-01-01';

-- +-------------+------------------------+
-- | Отдел       | Количество сотрудников |
-- +-------------+------------------------+
-- | Development |                  61386 |
-- +-------------+------------------------+
-- 1 row in set (0.00 sec)

-- С группировкой по всем отделам
SELECT departments.dept_name AS 'Отдел', count(*) AS 'Количество сотрудников' FROM dept_emp LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE to_date = '9999-01-01' GROUP BY departments.dept_no;

-- +--------------------+------------------------+
-- | Отдел              | Количество сотрудников |
-- +--------------------+------------------------+
-- | Marketing          |                  14842 |
-- | Finance            |                  12437 |
-- | Human Resources    |                  12898 |
-- | Production         |                  53304 |
-- | Development        |                  61386 |
-- | Quality Management |                  14546 |
-- | Sales              |                  37700 |
-- | Research           |                  15441 |
-- | Customer Service   |                  17569 |
-- +--------------------+------------------------+
-- 9 rows in set (0.03 sec)
 

# 5. Количество сотрудников в отделе (см. задание 4) и общий фонд ЗП

-- Определенный отдел по dept_no (from_date - выбор периода)
SELECT departments.dept_name AS 'Отдел', count(*) AS 'Количество сотрудников', SUM(salaries.salary) AS 'Фонд ЗП' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE salaries.from_date = '1999-11-28' AND departments.dept_no = 'd005';

-- +-------------+------------------------+----------+
-- | Отдел       | Количество сотрудников | Фонд ЗП  |
-- +-------------+------------------------+----------+
-- | Development |                    208 | 12955211 |
-- +-------------+------------------------+----------+
-- 1 row in set (0.00 sec)

-- С группировкой по всем отделам (from_date - выбор периода)
SELECT departments.dept_name AS 'Отдел', count(*) AS 'Количество сотрудников', SUM(salaries.salary) AS 'Фонд ЗП' FROM salaries LEFT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no WHERE salaries.from_date = '1999-11-28' GROUP BY departments.dept_no;

-- +--------------------+------------------------+----------+
-- | Отдел              | Количество сотрудников | Фонд ЗП  |
-- +--------------------+------------------------+----------+
-- | Marketing          |                     44 |  3661479 |
-- | Finance            |                     36 |  2681334 |
-- | Human Resources    |                     43 |  2405771 |
-- | Production         |                    187 | 11869901 |
-- | Development        |                    208 | 12955211 |
-- | Quality Management |                     49 |  2880400 |
-- | Sales              |                    114 |  9741267 |
-- | Research           |                     44 |  2747385 |
-- | Customer Service   |                     56 |  3486523 |
-- +--------------------+------------------------+----------+
-- 9 rows in set (0.00 sec)