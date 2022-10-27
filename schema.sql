/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
    name varchar(100),   
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT,    
);

ALTER TABLE animals ADD species varchar(100); 

/*Create owners table */
CREATE SEQUENCE owners_serial AS integer START 1 OWNED BY owners.id;
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100),
    age INT,
);
/*Create species table */
CREATE SEQUENCE species_serial AS integer START 1 OWNED BY species.id;
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(100),    
);

/* Modify animals table */
CREATE SEQUENCE animals_serial AS integer START 1 OWNED BY animals.id;
ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_serial');
/* Drop species column */
ALTER TABLE animals DROP COLUMN species;
/* Add foreign keys */
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);
