
--Exercise 1: Opret database til opgaven
CREATE DATABASE robot_worker;
SHOW DATABASES;

--Opret task tabel
CREATE TABLE task(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

--Add tasks
INSERT INTO task(name) VALUES('Task 1'), ('Task 2'), ('Task 3'), ('Task 4'), ('Task 5');

