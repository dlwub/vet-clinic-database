/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_part('year', date_of_birth) 
	BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered='t' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered='t';
SELECT * from animals WHERE name NOT IN('Gabumon');
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Update the animals table by setting the species column to unspecified */
BEGIN;
	Update animals SET species = 'unspecified';	
	/* Shows the change */
	SELECT * FROM animals;
	ROLLBACK;	
COMMIT;
/* Shows it reverts the changes */
SELECT * FROM animals;

/* Update animals table inside a transaction */
BEGIN;
	UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
	UPDATE animals SET species = 'pokemon' WHERE species = '';
COMMIT;
/* Show the change */
SELECT * FROM animals;

/*Delete all animals and roll back */
BEGIN;
	DELETE FROM animals;
	/* Shows the changes */
	SELECT * FROM animals;
	ROLLBACK;
COMMIT;
/* Shows it reverts the changes */
SELECT * FROM animals;

/*Rollback with Savepoint */
BEGIN;
	DELETE FROM animals WHERE date_of_birth > '2022-01-01';
	/* Shows the changes */
	SELECT * FROM animals;
	SAVEPOINT sp1;
	UPDATE animals SET weight_kg = -1*weight_kg;
	/* Shows the changes */
	SELECT * FROM animals;
	ROLLBACK TO sp1;
	/* Reverts the change */
	SELECT * FROM animals;
	UPDATE animals SET weight_kg = -1*weight_kg WHERE weight_kg < 0;
	/* Shows the changes */
	SELECT * FROM animals;
COMMIT;

/* Filtering */
/* Total number of animals */
SELECT COUNT(*) FROM animals;

/*Number of animals which never tried to escape */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* Average weight of animals */
SELECT AVG(weight_kg) FROM animals;

/* Frequency of escape attempts grouped by neutered */
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered; 

/*Minimum and maximum weight grouped by species */
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/* Average number of escape attempts per species of those born between 1990 and 2000 */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_part('year', date_of_birth) 
	BETWEEN 1990 AND 2000 GROUP BY species;

/* What animals belong to Melody Pond? */
SELECT name FROM animals 
	INNER JOIN owners ON animals.owner_id = owners.id 
	WHERE owners.id = 4; 

/* List of all Pokemon animals */
SELECT animals.name FROM animals 
	INNER JOIN species ON animals.species_id = species.id 
	WHERE species.id = 1; 

/* List of all owners and their animals */
SELECT owners.full_name, animals.name FROM owners 
	LEFT JOIN animals ON owners.id = animals.owner_id;

/*How many animals are there per species? */
SELECT species.name, COUNT(animals.name) FROM animals 
	INNER JOIN species ON animals.species_id = species.id 
	GROUP BY species.name;

/* List of all Digimon owned by Jennifer Orwell */
SELECT animals.name FROM animals 
	JOIN owners ON animals.owner_id = owners.id
	JOIN species ON animals.species_id = species.id
	WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* All animals owned by Dean Winchester that haven't tried to escape */
SELECT animals.name FROM animals
	INNER JOIN owners ON animals.owner_id = owners.id
	WHERE animals.escape_attempts = 0 AND owners.full_name ='Dean Winchester';

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.name) FROM animals
	INNER JOIN owners ON animals.owner_id = owners.id
	GROUP BY owners.full_name;

/* The last animal seen by William Tatcher */
SELECT animals.name, date_of_visit FROM visits
	JOIN animals ON visits.animal_id = animals.id  
	JOIN vets ON visits.vet_id = vets.id
	WHERE vets.name = 'William Tatcher'
	ORDER BY visits.date_of_visit DESC;

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT ( DISTINCT animals.id) FROM visits
	JOIN animals ON visits.animal_id = animals.id  
	JOIN vets ON visits.vet_id = vets.id
	WHERE vets.name = 'Stephanie Mendez';

/* All vets and their specialties, including vets with no specialties */
SELECT vets.name as vet_name, species.name as species_name FROM vets
	LEFT JOIN specializations ON vets.id = specializations.vet_id
	LEFT JOIN species ON species.id = specializations.species_id;

/* All animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
SELECT animals.name, date_of_visit FROM visits
	JOIN animals ON visits.animal_id = animals.id  
	JOIN vets ON visits.vet_id = vets.id
	WHERE vets.name = 'Stephanie Mendez' 
	AND date_of_visit BETWEEN '2020-04-01' AND '2020-04-30';

/* The animal with the most visits to vets */
SELECT animals.name, COUNT(*) FROM visits
	JOIN animals ON visits.animal_id = animals.id	
	GROUP BY animals.name
	ORDER BY COUNT(*) DESC LIMIT 1;

/* Maisy Smith's first visit */
SELECT animals.name, date_of_visit FROM visits
	JOIN animals ON visits.animal_id = animals.id  
	JOIN vets ON visits.vet_id = vets.id
	WHERE vets.name = 'Maisy Smith'
	ORDER BY visits.date_of_visit LIMIT 1;

	/* Details for most recent visit: animal information, vet information, and date of visit */
	SELECT animals.name, date_of_birth, escape_attempts, neutered,
    weight_kg, vets.name AS vet_name, age, date_of_graduation, date_of_visit FROM visits
	JOIN animals ON visits.animal_id = animals.id  
	JOIN vets ON visits.vet_id = vets.id	
	ORDER BY visits.date_of_visit DESC LIMIT 1;

	/* Number of visits with a vet that did not specialize in that animal's species */
SELECT animals.name, animals.species_id, vets.id as vet_id, specializations.species_id as specialization_in, date_of_visit, COUNT(*) FROM visits
		LEFT JOIN vets ON vets.id = visits.vet_id
		LEFT JOIN specializations ON visits.vet_id = specializations.vet_id
		LEFT JOIN animals ON visits.animal_id = animals.id		
		GROUP BY animals.name, animals.species_id, vets.id, specializations.species_id, date_of_visit
		HAVING NOT (animals.species_id = ANY (ARRAY_AGG(specializations.species_id)))
		OR specializations.species_id IS NULL;


	/* Specialty Maisy Smith should consider getting */
	SELECT species.name as species_name, COUNT(species.name) FROM visits
		JOIN vets ON vets.id = visits.vet_id		
		JOIN animals ON visits.animal_id = animals.id	
		JOIN species ON animals.species_id = species.id
		WHERE vets.name = 'Maisy Smith'
		GROUP BY species.name, vets.name;	

