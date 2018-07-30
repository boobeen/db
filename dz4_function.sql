DELIMITER //

CREATE FUNCTION get_man(first_name VARCHAR(30), last_name VARCHAR(30))
  RETURNS INT DETERMINISTIC
  BEGIN
    DECLARE GET_MAN_NO INT;
    SELECT dept_manager.emp_no INTO GET_MAN_NO
    FROM employees
      LEFT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
    WHERE employees.first_name = first_name AND employees.last_name = last_name;
    RETURN GET_MAN_NO;
  END //

DELIMITER ;

SELECT get_man('Krassimir', 'Wegerle') AS GET_MAN_NO;

-- mysql> SELECT get_man('Krassimir', 'Wegerle') AS GET_MAN_NO;
-- +------------+
-- | GET_MAN_NO |
-- +------------+
-- |     110303 |   --Есть менеджер
-- +------------+
-- 1 row in set (0.15 sec)

SELECT get_man('Yuriy', 'Buley') AS GET_MAN_NO;

-- mysql> SELECT get_man('Yuriy', 'Buley') AS GET_MAN_NO;
-- +------------+
-- | GET_MAN_NO |
-- +------------+
-- |       NULL |   -- Нет менеджера
-- +------------+
-- 1 row in set (0.15 sec)