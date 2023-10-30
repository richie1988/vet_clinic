/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM "animals" LIMIT 1000;
SELECT * from animals WHERE name = 'Gabumon';
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE YEAR(date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

