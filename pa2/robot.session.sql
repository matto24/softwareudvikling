
--Exercise 1: Opret database til opgaven
CREATE DATABASE robot_worker;
SHOW DATABASES;

--Opret task tabel
CREATE TABLE task(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

--Exercise 5: Tilføj table af robotter, der har attributter "Name" og "Current Task"
CREATE TABLE robot(
    name VARCHAR(255) NOT NULL,
    current_task VARCHAR(255),
    PRIMARY KEY(name)
);

--Exercise 7: Tilføjer her en Available parameter til at tjekke om en robot er i gang med opgaven
ALTER TABLE task ADD available BOOLEAN DEFAULT TRUE;
