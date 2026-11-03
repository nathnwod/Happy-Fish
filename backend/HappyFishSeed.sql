CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  scientific_name TEXT,
  adult_size_inches NUMERIC,
  min_tank_gallons INTEGER,
  temperament TEXT,
  skill_level TEXT
);

INSERT INTO species (name, scientific_name, adult_size_inches, min_tank_gallons, temperament, skill_level) VALUES
('Neon Tetra', 'Paracheirodon innesi', 0.98, 10, 'peaceful', 'Beginner'),
('Guppy', 'Poecilia reticulata', 2, 5, 'peaceful', 'Beginner'),
('Betta', 'Betta splendens', 3, 5, 'semi-aggressive', 'Beginner'),
('Discus', 'Symphysodon aequifasciatus', 6, 55, 'peaceful', 'Advanced'),
('Angelfish', 'Pterophyllum scalare', 4.1, 30, 'semi-aggressive', 'Intermediate');

ALTER TABLE species ADD COLUMN weight_a NUMERIC;
ALTER TABLE species ADD COLUMN weight_b NUMERIC;

UPDATE species SET adult_size_inches = 5 WHERE name = 'Angelfish';
UPDATE species SET adult_size_inches = 6 WHERE name = 'Discus';
UPDATE species SET adult_size_inches = 2.6 WHERE name = 'Betta';
UPDATE species SET adult_size_inches = 1.5 WHERE name = 'Guppy';
UPDATE species SET adult_size_inches = 1.5 WHERE name = 'Salt And Pepper Cory';

UPDATE species SET weight_a = 0.01122, weight_b = 3.08 WHERE name = 'Neon Tetra';
UPDATE species SET weight_a = 0.01288, weight_b = 3.14 WHERE name = 'Guppy';
UPDATE species SET weight_a = 0.00977, weight_b = 2.97 WHERE name = 'Betta';
UPDATE species SET weight_a = 0.02692, weight_b = 3.03 WHERE name = 'Discus';
UPDATE species SET weight_a = 0.03236, weight_b = 2.98 WHERE name = 'Angelfish';
UPDATE species SET adult_size_inches = 12 WHERE name = 'Common Goldfish';


INSERT INTO species (name, scientific_name, adult_size_inches, min_tank_gallons, temperament, skill_level, weight_a, weight_b) VALUES
('Salt And Pepper Cory', 'Hoplisoma habrosum', 0.79, 10, 'peaceful', 'Intermediate', 0.00741, 3.14);

INSERT INTO species (name, scientific_name, adult_size_inches, min_tank_gallons, temperament, skill_level, weight_a, weight_b) VALUES
('Ember Tetra', 'Hyphessobrycon amandae', 0.8, 10, 'peaceful', 'Intermediate', 0.01202, 3.09),
('Celestial Pearl Danio', 'Danio margaritatus', 0.8, 10, 'peaceful', 'Beginner', 0.00603, 3.13),
('Common Goldfish', 'Carassius auratus', 18.9, 35, 'peaceful', 'Intermediate', 0.01148, 3.04);

CREATE TABLE tank_sizes (
	id SERIAL PRIMARY KEY,
	label TEXT NOT NULL,
	gallons NUMERIC NOT NULL
);

UPDATE species SET adult_size_inches = 1.0 WHERE name = 'Ember Tetra';
UPDATE species SET adult_size_inches = 1.0 WHERE name = 'Celestial Pearl Danio';

SELECT name, adult_size_inches, weight_a, weight_b FROM species WHERE name = 'Discus';
INSERT INTO tank_sizes (label, gallons) VALUES
('10 gallon', 10),
('20 gallon long', 20),
('20 gallong tall', 20),
('29 gallon', 29),
('55 gallon', 55);

INSERT INTO tank_sizes (label, gallons) VALUES
('5.5 gallon', 5.5),
('5 gallon', 5),
('125 gallon', 125);

SELECT * FROM species;
SELECT * FROM tank_sizes;