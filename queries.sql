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
