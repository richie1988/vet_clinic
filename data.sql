/* Populate database with sample data. */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
    (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23),
    (2, 'Gabumon', '2018-11-15', 2, TRUE, 8.00),
    (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04),
    (4, 'Devimon', '2017-05-12', 5, TRUE, 11.00);

    /* day two query and update of the animals data*/
    INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES
    ('Charmander', '2020-02-08', 0, FALSE, -11.00, 'unspecified'),
    ('Plantmon', '2021-11-15', 2, TRUE, -5.7, 'unspecified'),
    ('Squirtle', '1993-04-02', 3, FALSE, -12.13, 'unspecified'),
    ('Angemon', '2005-06-12', 1, TRUE, -45.00, 'unspecified'),
    ('Boarmon', '2005-06-07', 7, TRUE, 20.4, 'unspecified'),
    ('Blossom', '1998-10-13', 3, TRUE, 17.00, 'unspecified'),
    ('Ditto', '2022-05-14', 4, TRUE, 22.00, 'unspecified');

    
/* day 3 of the query multiple tables*/

-- Insert data into the owners table
INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name) VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN 2
    ELSE 1
END;

UPDATE animals
SET owner_id = (
    SELECT id FROM owners
    WHERE full_name = 'Sam Smith'
) WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
    SELECT id FROM owners
    WHERE full_name = 'Jennifer Orwell'
) WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
    SELECT id FROM owners
    WHERE full_name = 'Bob'
) WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
    SELECT id FROM owners
    WHERE full_name = 'Melody Pond'
) WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (
    SELECT id FROM owners
    WHERE full_name = 'Dean Winchester'
) WHERE name IN ('Angemon', 'Boarmon');
