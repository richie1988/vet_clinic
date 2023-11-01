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

/* day 4 join table and visits*/

-- Create the vets table
CREATE TABLE vets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);

-- Create the specializations table (join table for vets and species)
CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- Create the visits table (join table for animals and vets)
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);
