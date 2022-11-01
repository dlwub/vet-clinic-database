/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', DATE '2020-02-03', 0, true, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', DATE '2018-11-15', 2, true, 8);
INSERT INTO animals VALUES (3, 'Pikachu', DATE '2021-01-07', 1, false, 15.04);
INSERT INTO animals VALUES (4, 'Devimone', DATE '2017-03-12', 5, true, 11);
/* New entries */
INSERT INTO animals VALUES (5, 'Charmander', DATE '2020-02-08', 0, false, -11);
INSERT INTO animals VALUES (6, 'Plantmon', DATE '2021-11-15', 2, true, -5.7);
INSERT INTO animals VALUES (7, 'Squirtle', DATE '1993-04-02', 3, false, -12.13);
INSERT INTO animals VALUES (8, 'Angemon', DATE '2005-06-12', 1, true, -45);
INSERT INTO animals VALUES (9, 'Boarmon', DATE '2005-06-07', 7, true, 20.4);
INSERT INTO animals VALUES (10, 'Blossom', DATE '1998-10-13', 3, true, 17);
INSERT INTO animals VALUES (11, 'Ditto', DATE '2022-05-14', 4, true, 22);

/* Insert values into owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* Insert values into species table */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/* Modify animals table so it includes the species_id value */
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id = '';

/* Modify animals table so it includes the owner_id value */
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';

/* Insert data to vets table */
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, DATE '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, DATE '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, DATE '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, DATE '2008-06-08');

/* Insert data to specializations table */
INSERT INTO specializations (vet_id, species_id) 
	VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),
	(SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) 
	VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	(SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO specializations (vet_id, species_id) 
	VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	(SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) 
	VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
	(SELECT id FROM species WHERE name = 'Digimon'));

/* Insert data to visits table */
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Agumon'),
	(SELECT id FROM vets WHERE name = 'William Tatcher'), 
	DATE '2020-05-24');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Agumon'),
	(SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
	DATE '2020-07-22');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Gabumon'),
	(SELECT id FROM vets WHERE name = 'Jack Harkness'), 
	DATE '2021-02-02');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2020-01-05');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2020-03-08');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2020-05-14');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Devimon'),
	(SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
	DATE '2021-05-04');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Charmander'),
	(SELECT id FROM vets WHERE name = 'Jack Harkness'), 
	DATE '2021-02-24');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2019-12-21');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'),
	(SELECT id FROM vets WHERE name = 'William Tatcher'), 
	DATE '2020-08-10');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2021-04-07');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Squirtle'),
	(SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
	DATE '2019-09-29');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Angemon'),
	(SELECT id FROM vets WHERE name = 'Jack Harkness'), 
	DATE '2020-10-03');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Angemon'),
	(SELECT id FROM vets WHERE name = 'Jack Harkness'), 
	DATE '2020-11-04');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2019-01-24');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2019-05-15');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2020-02-27');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'),
	(SELECT id FROM vets WHERE name = 'Maisy Smith'), 
	DATE '2020-08-03');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Blossom'),
	(SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
	DATE '2020-05-24');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
	VALUES ((SELECT id FROM animals WHERE name = 'Blossom'),
	(SELECT id FROM vets WHERE name = 'William Tatcher'), 
	DATE '2021-01-11');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
    SELECT * FROM (SELECT id FROM animals) animal_ids, 
    (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

insert into owners (full_name, email) select 'Owner ' 
|| generate_series(1,2500000), 'owner_' || generate_series(1,2500000) 
|| '@mail.com';
