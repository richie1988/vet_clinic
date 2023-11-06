/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* day two query and update of the animals table*/

BEGIN;

UPDATE animals SET species = 'Unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = '';

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT update_weights;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO update_weights;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) AS total_animals FROM animals;
SELECT COUNT(*) AS never_tried_to_escape FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE YEAR(date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

/* Day 3 of query multiple tables*/

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, COALESCE(GROUP_CONCAT(a.name), 'None') AS owned_animals
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name;

SELECT s.name, COUNT(*) AS animal_count
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
JOIN species AS s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

/* day 4 join table and visits*/

SELECT a.name AS last_animal_seen
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Vet William Tatcher')
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS total_animals_seen
FROM visits AS v
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez');

SELECT v.name AS vet_name, s.name AS specialization
FROM vets AS v
LEFT JOIN specialisation AS sp ON v.id = sp.vet_id
LEFT JOIN species AS s ON sp.species_id = s.id;

SELECT a.name AS animal_name, v.visit_date
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez')
    AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS most_visited_animal, max_visit_count AS visit_count
FROM (
    SELECT v.animal_id, COUNT(v.animal_id) AS max_visit_count
    FROM visits AS v
    GROUP BY v.animal_id
    ORDER BY max_visit_count DESC
    LIMIT 1
) AS max_visits
JOIN animals AS a ON max_visits.animal_id = a.id;

SELECT a.name AS first_visit_animal, v.visit_date
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Vet Maisy Smith')
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT COUNT(*) AS non_specialized_visits
FROM visits AS v
LEFT JOIN specialisation AS sp ON v.vet_id = sp.vet_id
WHERE sp.species_id IS NULL;

SELECT
    a.name AS animal_name,
    v.visit_date AS date_of_visit,
    ve.name AS vet_name
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS ve ON v.vet_id = ve.id
WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits WHERE animal_id = a.id);

SELECT
    s.name AS specialty_name,
    COUNT(*) AS specialization_count
FROM specialisation AS sp
JOIN vets AS ve ON sp.vet_id = ve.id
JOIN species AS s ON sp.species_id = s.id
JOIN owners AS o ON ve.id = o.id
WHERE o.full_name = 'Maisy Smith'
GROUP BY s.name
ORDER BY specialization_count DESC
LIMIT 1;

/* database and perfomance week*/

SELECT COUNT(*) FROM visits WHERE animal_id = 4;

SELECT * FROM visits WHERE vet_id = 2;

SELECT * FROM owners WHERE email = 'owner_18327@mail.com';
