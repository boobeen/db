-- Создаем дамп

d:\Learning_Prog\learn_db\less7\backup>mysqldump -u root -p geodata > geo_dump.sql
Enter password:

-- Запускаем 

d:\Learning_Prog\learn_db\less7\backup>mysql -u root -p
Enter password:

mysql> SHOW DATABASES; -- посмотрели базы

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
-- 6 rows in set (0.00 sec)

mysql> DROP DATABASE geodata; -- удалили geodata

-- Query OK, 4 rows affected (0.52 sec)

mysql> SHOW DATABASES; -- посмотрели, geodata нет

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | employees          |
-- | mysql              |
-- | performance_schema |
-- | sys                |
-- +--------------------+
-- 5 rows in set (0.00 sec)

mysql> CREATE DATABASE geodata_new; -- создали geodata_new

-- Query OK, 1 row affected (0.03 sec)

mysql> SHOW DATABASES; -- посмотрели, база есть

-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | employees          |
-- | geodata_new        |
-- | mysql              |
-- | performance_schema |
-- | sys                |
-- +--------------------+
-- 6 rows in set (0.00 sec)

mysql> EXIT
-- Bye


-- запустили восстановление

d:\Learning_Prog\learn_db\less7\backup>mysql -u root -p geodata_new < geo_dump.sql
Enter password:
  
d:\Learning_Prog\learn_db\less7\backup>mysql -u root -p
Enter password:

mysql> USE geodata_new; -- выбрали базу

-- Database changed

mysql> SHOW TABLES; -- смотрим таблицы, база восстановлена

-- +-----------------------+
-- | Tables_in_geodata_new |
-- +-----------------------+
-- | _cities               |
-- | _countries            |
-- | _regions              |
-- | city_reg              |
-- +-----------------------+
-- 4 rows in set (0.00 sec)

mysql>