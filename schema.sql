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
ALTER TABLE animals
ADD species VARCHAR(255);

