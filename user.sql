-- КОНСОЛЬ 1 --
# Заходим под рутом

C:\Users\YUR>mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.20 MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

# Смотрим базы

mysql> SHOW DATABASES;

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | employees          |
-- | geodata            |
-- | mysql              |
-- | performance_schema |
-- | sys                |
-- +--------------------+
-- 6 rows in set (0.09 sec)

# Смотрим пользователей

mysql> SELECT user, host FROM mysql.user;

-- +-----------+-----------+
-- | user      | host      |
-- +-----------+-----------+
-- | mysql     | %         |
-- | root      | %         |
-- | mysql.sys | localhost |
-- +-----------+-----------+
-- 3 rows in set (0.00 sec)

# Создаем пользователя

mysql> CREATE USER 'yur'@'localhost' IDENTIFIED BY 'yur';

-- Query OK, 0 rows affected (0.15 sec)

# Проверяем пользователя - добавился

mysql> SELECT user, host FROM mysql.user;

-- +-----------+-----------+
-- | user      | host      |
-- +-----------+-----------+
-- | mysql     | %         |
-- | root      | %         |
-- | mysql.sys | localhost |
-- | yur       | localhost |
-- +-----------+-----------+
-- 4 rows in set (0.00 sec)


-- КОНСОЛЬ 2 --
# Заходим под пользователем 'yur'

C:\Users\YUR>mysql -u yur -p
Enter password: ***
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.7.20 MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

# Смотрим доступные базы для пользователя 'yur'

mysql> SHOW DATABASES;

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- +--------------------+
-- 1 row in set (0.02 sec)

# Доступных баз нету, потому что нет прав на базы, проверяем имеющиеся права

mysql> SHOW GRANTS;

-- +-----------------------------------------+
-- | Grants for yur@localhost                |
-- +-----------------------------------------+
-- | GRANT USAGE ON *.* TO 'yur'@'localhost' |
-- +-----------------------------------------+
-- 1 row in set (0.00 sec)

-- КОНСОЛЬ 1 --
# Под рутом выдаем все права пользователю 'yur' на базу geodata

mysql> GRANT ALL PRIVILEGES ON geodata.* TO 'yur'@'localhost';

-- Query OK, 0 rows affected (0.07 sec)

# Перегружаем права

mysql> FLUSH PRIVILEGES;

-- Query OK, 0 rows affected (0.01 sec)

-- КОНСОЛЬ 2 --
# Проверяем доступные базы для 'yur'

mysql> SHOW DATABASES;

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | geodata            |
-- +--------------------+
-- 2 rows in set (0.03 sec)

# Доступ к базе geodata получен
# Посмотрим права

mysql> SHOW GRANTS;

-- +----------------------------------------------------------+
-- | Grants for yur@localhost                                 |
-- +----------------------------------------------------------+
-- | GRANT USAGE ON *.* TO 'yur'@'localhost'                  |
-- | GRANT ALL PRIVILEGES ON `geodata`.* TO 'yur'@'localhost' |
-- +----------------------------------------------------------+
-- 2 rows in set (0.00 sec)

# Есть все привилегии

-- КОНСОЛЬ 1 --
# Под рутом отзываем все права у пользователя 'yur' и выдаем права только на вставку,
# выборку и создание представлений. Перегружаем права

mysql> REVOKE ALL PRIVILEGES ON geodata.* FROM 'yur'@'localhost';

-- Query OK, 0 rows affected (0.03 sec)

mysql> GRANT INSERT, SELECT, CREATE VIEW ON geodata.* TO 'yur'@'localhost';

-- Query OK, 0 rows affected (0.03 sec)

mysql> FLUSH PRIVILEGES;

-- Query OK, 0 rows affected (0.00 sec)

mysql>

-- КОНСОЛЬ 2 --
# Смотрим права

mysql> SHOW GRANTS;

-- +-----------------------------------------------------------------------+
-- | Grants for yur@localhost                                              |
-- +-----------------------------------------------------------------------+
-- | GRANT USAGE ON *.* TO 'yur'@'localhost'                               |
-- | GRANT SELECT, INSERT, CREATE VIEW ON `geodata`.* TO 'yur'@'localhost' |
-- +-----------------------------------------------------------------------+
-- 2 rows in set (0.03 sec)

# Есть тоько SELECT, UNSERT и CREATE VIEW

mysql>