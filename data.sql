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

/* day 4 join table and visits*/

-- Insert data for vets
INSERT INTO vets (name, age, date_of_graduation) VALUES
    ('Vet William Tatcher', 45, '2000-04-23'),
    ('Vet Maisy Smith', 26, '2019-01-17'),
    ('Vet Stephanie Mendez', 64, '1981-05-04'),
    ('Vet Jack Harkness', 38, '2008-06-08');

-- Insert data for specializations
INSERT INTO specializations (vet_id, species_id) VALUES
    (1, 1),
    (3, 2),
    (3, 1),
    (4, 2);

-- Insert data for visits
-- (Assuming animal IDs exist in your database, adjust as needed)
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
    (21, 1, '2020-05-24'),
    (21, 3, '2020-07-22'),
    (22, 4, '2021-02-02'),
    (23, 2, '2020-01-05'),
    (23, 2, '2020-03-08'),
    (23, 2, '2020-05-14'),
    (24, 3, '2021-05-04'),
    (25, 4, '2021-02-24'),
    (26, 2, '2019-12-21'),
    (26, 1, '2020-08-10'),
    (26, 2, '2021-04-07'),
    (27, 3, '2019-09-29'),
    (28, 4, '2020-10-03'),
    (28, 4, '2020-11-04'),
    (29, 2, '2019-01-24'),
    (29, 2, '2019-05-15'),
    (29, 2, '2020-02-27'),
    (29, 2, '2020-08-03'),
    (30, 3, '2020-05-24'),
    (30, 1, '2021-01-11');


/* database and perfomance week*/

-- This will add 3,594,280 visits considering you have 10 animals, 4 vets, and it will use around ~87,000 timestamps (~4 minutes approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2,500,000 owners with `full_name` = 'Owner <X>' and `email` = 'owner_<X>@email.com' (~2 minutes approx.)
INSERT INTO owners (full_name, email)
SELECT 'Owner ' || generate_series(1, 2500000), 'owner_' || generate_series(1, 2500000) || '@mail.com';

