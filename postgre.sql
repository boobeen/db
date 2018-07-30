CREATE DATABASE my_base;
CREATE USER yur WITH PASSWORD 'yur';
GRANT ALL PRIVILEGES ON DATABASE my_base TO yur;

CREATE TABLE brand (id SERIAL PRIMARY KEY, name VARCHAR(50));

INSERT INTO brand (name)
  VALUES ('AUDI'), ('BMW'), ('MERCEDES-BENZ');

CREATE TABLE model (
  id SERIAL PRIMARY KEY,
  name VARCHAR(70) NOT NULL,
  id_brand INT NOT NULL,
  FOREIGN KEY (id_brand) REFERENCES brand(id)
);

INSERT INTO model (name, id_brand)
  VALUES ('A4', 1), ('A6', 1), ('A7', 1), ('A8', 1), ('Q7', 1), 
    ('3-series', 2), ('5-series', 2), ('7-series', 2), ('X5', 2), ('X6', 2),
    ('C-class', 3), ('E-class', 3), ('S-class', 3), ('GL', 3);


    SELECT model.name, brand.name FROM model
      LEFT JOIN brand ON brand.id = model.id_brand ORDER BY model.name;