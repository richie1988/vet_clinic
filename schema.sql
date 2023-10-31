CREATE DATABASE vet_clinic;

\c vet_clinic

CREATE TABLE animals (
   id serial PRIMARY KEY,
   name varchar(200),
   date_of_birth date,
   escape_attempts integer,
   neutered boolean,
   weight_kg decimal
);

/* day two query and upadte of the animals table*/

CREATE TABLE owners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

-- Create the species table
CREATE TABLE species (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

ALTER TABLE animals
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY,
DROP COLUMN species,
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT;
