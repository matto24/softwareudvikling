
--Exercise 1: Opret database til opgaven
CREATE DATABASE robot_worker;
SHOW DATABASES;

--Opret task tabel
CREATE TABLE task(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);