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
