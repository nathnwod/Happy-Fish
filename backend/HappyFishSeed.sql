CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  scientific_name TEXT UNIQUE,
  adult_size_inches NUMERIC,
  min_tank_gallons INTEGER,
  temperament TEXT,
  skill_level TEXT,
  weight_a NUMERIC,
  weight_b NUMERIC,
  min_group_size NUMERIC,
  max_group_size NUMERIC
);

INSERT INTO species
  (name, 
  scientific_name, 
  adult_size_inches, 
  min_tank_gallons, 
  temperament, 
  skill_level,
  weight_a, 
  weight_b,
  min_group_size,
  max_group_size
  )
VALUES
  ('Neon Tetra', 'Paracheirodon innesi', 1.5, 10, 'peaceful', 'Beginner', 0.01122, 3.08, 6, null),
  ('Guppy', 'Poecilia reticulata', 1.5, 5, 'peaceful', 'Beginner', 0.01288, 3.14, 5, null),
  ('Betta', 'Betta splendens', 2.6, 5, 'semi-aggressive', 'Beginner', 0.00977, 2.97, null, 1),
  ('Discus', 'Symphysodon aequifasciatus', 6, 75, 'peaceful', 'Advanced', 0.02692, 3.03, 6, null),
  ('Angelfish', 'Pterophyllum scalare', 5, 30, 'semi-aggressive', 'Intermediate', 0.03236, 2.98, null, null),
  ('Salt And Pepper Cory', 'Hoplisoma habrosum', 1.5, 10, 'peaceful', 'Intermediate', 0.00741, 3.14, 8, null),
  ('Ember Tetra', 'Hyphessobrycon amandae', 1.0, 10, 'peaceful', 'Intermediate', 0.01202, 3.09, 6, null),
  ('Celestial Pearl Danio', 'Danio margaritatus', 1.0, 10, 'peaceful', 'Beginner', 0.00603, 3.13, 6, null),
  ('Common Goldfish', 'Carassius auratus', 12, 35, 'peaceful', 'Intermediate', 0.01148, 3.04, 2, null);

ALTER TABLE species ADD COLUMN avoid_pair BOOLEAN;
UPDATE species SET avoid_pair = TRUE WHERE name = 'Angelfish';

ALTER TABLE species ADD COLUMN care_note TEXT;

ALTER TABLE species ADD COLUMN min_temp NUMERIC;
ALTER TABLE species ADD COLUMN max_temp NUMERIC;
ALTER TABLE species ADD COLUMN min_ph NUMERIC;
ALTER TABLE species ADD COLUMN max_ph NUMERIC;

UPDATE species SET min_temp = 70, max_temp = 77, min_ph = 5.0, max_ph = 7.5 WHERE name = 'Neon Tetra';
UPDATE species SET min_temp = 72, max_temp = 82, min_ph = 6.8, max_ph = 7.8 WHERE name = 'Guppy';
UPDATE species SET min_temp = 72, max_temp = 86, min_ph = 6.0, max_ph = 7.5 WHERE name = 'Betta';
UPDATE species SET min_temp = 82, max_temp = 86, min_ph = 6.0, max_ph = 7.0 WHERE name = 'Discus';
UPDATE species SET min_temp = 75, max_temp = 86, min_ph = 6.0, max_ph = 7.5 WHERE name = 'Angelfish';
UPDATE species SET min_temp = 72, max_temp = 79, min_ph = 6.0, max_ph = 7.5 WHERE name = 'Salt And Pepper Cory';
UPDATE species SET min_temp = 73, max_temp = 82, min_ph = 5.5, max_ph = 7.5 WHERE name = 'Ember Tetra';
UPDATE species SET min_temp = 72, max_temp = 79, min_ph = 6.5, max_ph = 7.5 WHERE name = 'Celestial Pearl Danio';
UPDATE species SET min_temp = 60, max_temp = 75, min_ph = 6.0, max_ph = 8.0 WHERE name = 'Common Goldfish';

UPDATE species SET care_note = 'Keep about 1 male guppy to every 2-3 females, or males may harass them.' WHERE name = 'Guppy';

UPDATE species SET care_note = 'Goldfish are a messy fish. Need heavy filtration and weekly water changes.' WHERE name = 'Common Goldfish';
UPDATE species SET care_note = 'Discus need very clean water. Keepers do large, frequent water changes.' WHERE name = 'Discus';
UPDATE species SET care_note = 'Bettas prefer gentle water flow. Bettas jump, so a lid is required.' WHERE name = 'Betta';
UPDATE species SET care_note = 'Angelfish grow tall, so a taller tank helps. May eat very small fish.' WHERE name = 'Angelfish';

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph)
VALUES ('Bristlenose Pleco', 'Ancistrus sp.', 'Beginner', 5, 0.01479, 2.98, 25, 1, NULL, false, 'peaceful', 'Plecos need driftwood to graze on and spots/caves to hide in. Males fight over hiding spots, so keeping just one male is better.', 73, 81, 6.5, 7.5);

CREATE TABLE tank_sizes (
  id SERIAL PRIMARY KEY,
  label TEXT NOT NULL UNIQUE,
  gallons NUMERIC NOT NULL
);

INSERT INTO tank_sizes (label, gallons) VALUES
  ('5 gallon', 5),
  ('5.5 gallon', 5.5),
  ('10 gallon', 10),
  ('20 gallon long', 20),
  ('20 gallon tall', 20),
  ('29 gallon', 29),
  ('55 gallon', 55),
  ('75 gallon', 75),
  ('125 gallon', 125);


SELECT * FROM species;
SELECT * FROM tank_sizes;

DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS tank_sizes;