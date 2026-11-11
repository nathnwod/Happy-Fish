-- ============================================
-- HAPPY FISH DATABASE
-- ============================================

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  scientific_name TEXT UNIQUE,
  skill_level TEXT,
  adult_size_inches NUMERIC,
  weight_a NUMERIC,
  weight_b NUMERIC,
  min_tank_gallons INTEGER,
  min_group_size NUMERIC,
  max_group_size NUMERIC,
  avoid_pair BOOLEAN,
  temperament TEXT,
  care_note TEXT,
  min_temp NUMERIC,
  max_temp NUMERIC,
  min_ph NUMERIC,
  max_ph NUMERIC,
  eats_fish_under_inches NUMERIC,
  waste_multiplier NUMERIC DEFAULT 1
);

INSERT INTO species
  (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  ('Neon Tetra', 'Paracheirodon innesi', 'Beginner', 1.5, 0.01122, 3.08, 10, 6, NULL, NULL, 'peaceful', NULL, 72, 78, 5.0, 7.5, NULL, 1),
  ('Guppy', 'Poecilia reticulata', 'Beginner', 1.5, 0.01288, 3.14, 5, 5, NULL, NULL, 'peaceful', 'Keep about 1 male guppy to every 2-3 females, or males may harass them.', 72, 82, 6.8, 7.8, NULL, 1),
  ('Betta', 'Betta splendens', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, NULL, 'semi-aggressive', 'Bettas prefer gentle water flow. Bettas jump, so a lid is required.', 72, 86, 6.0, 7.5, NULL, 1),
  ('Discus', 'Symphysodon aequifasciatus', 'Advanced', 6, 0.02692, 3.03, 75, 6, NULL, NULL, 'peaceful', 'Discus need very clean water. Keepers do large, frequent water changes.', 82, 86, 6.0, 7.0, NULL, 1),
  ('Angelfish', 'Pterophyllum scalare', 'Intermediate', 5, 0.03236, 2.98, 30, NULL, NULL, true, 'semi-aggressive', 'Angelfish grow tall, so a tall tank works best. Their long fins attract fin nippers, and pairs get territorial when breeding.', 75, 86, 6.0, 7.5, 2, 1),
  ('Salt and Pepper Cory', 'Hoplisoma habrosum', 'Intermediate', 1.5, 0.00741, 3.14, 10, 6, NULL, NULL, 'peaceful', NULL, 72, 79, 6.0, 7.5, NULL, 1),
  ('Ember Tetra', 'Hyphessobrycon amandae', 'Intermediate', 1.0, 0.01202, 3.09, 10, 6, NULL, NULL, 'peaceful', NULL, 73, 82, 5.5, 7.5, NULL, 1),
  ('Celestial Pearl Danio', 'Danio margaritatus', 'Beginner', 1.0, 0.00603, 3.13, 10, 6, NULL, NULL, 'peaceful', NULL, 72, 79, 6.5, 7.5, NULL, 1),
  ('Common Goldfish', 'Carassius auratus', 'Intermediate', 12, 0.01148, 3.04, 75, 2, NULL, NULL, 'peaceful', 'Goldfish are a messy fish. Need heavy filtration and weekly water changes.', 60, 75, 6.0, 8.0, 3, 1.5),
  ('Bristlenose Pleco', 'Ancistrus sp.', 'Beginner', 5, 0.01479, 2.98, 25, 1, NULL, false, 'peaceful', 'Plecos need driftwood to graze on and spots/caves to hide in. Males fight over hiding spots, so keeping just one male is better.', 73, 81, 6.5, 7.5, NULL, 1),
  ('Cardinal Tetra', 'Paracheirodon axelrodi', 'Intermediate', 1.75, 0.01122, 3.08, 20, 6, NULL, false, 'peaceful', 'Cardinal tetras are sensitive to water changes and are often wild caught. Best added to an established tank.', 74, 82, 4, 7, NULL, 1),
  ('Cherry Barb', 'Puntius titteya', 'Beginner', 2, 0.01259, 3.02, 20, 6, NULL, false, 'peaceful', 'Keep about 1 male cherry barb to every 2 females. Lots of plants help them feel safe.', 73, 80, 6.5, 7.5, NULL, 1),
  ('Harlequin Rasbora', 'Trigonostigma heteromorpha', 'Beginner', 1.75, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful', NULL, 72, 84, 6, 7.5, NULL, 1),
  ('Southern Platyfish', 'Xiphophorus maculatus', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful', 'Platys prefer hard, mineral-rich water. Keep about 1 male to every 2-3 females so males don’t harass them.', 68, 79, 7, 8, NULL, 1.35),
  ('Sterbas Cory', 'Hoplisoma sterbai', 'Beginner', 2.25, 0.02455, 3.0, 20, 6, NULL, false, 'peaceful', 'Corys need sand or smooth gravel to protect their whiskers. Feed sinking food.', 75, 82, 6, 7.5, NULL, 1),
  ('Western Rainbowfish', 'Melanotaenia australis', 'Beginner', 4, 0.01122, 3.04, 30, 6, NULL, false, 'peaceful', 'Rainbowfish are fast swimmers that do best in a long tank. They are known to jump, and their colors develop as they grow.', 72, 81, 6.5, 8, NULL, 1),
  ('Dwarf Gourami', 'Trichogaster lalius', 'Intermediate', 3, 0.01445, 2.99, 10, NULL, NULL, false, 'peaceful', 'Dwarf gouramis are prone to disease, so buy from a trusted store. Males can be territorial, especially with each other.', 72, 81, 6, 7.5, NULL, 1);

UPDATE species SET weight_a = 0.02455, weight_b = 3.0, adult_size_inches = 2.5, waste_multiplier = 0.7 WHERE scientific_name = 'Hoplisoma sterbai';

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES (
  'Otocinclus',          -- name
  'Otocinclus vittatus',      -- scientific_name
  'Intermediate',           -- skill_level: Beginner / Intermediate / Advanced
  1.75,                  -- adult_size_inches
  0.01122,              -- weight_a (from FishBase)
  3.11,                 -- weight_b (from FishBase)
  20,                   -- min_tank_gallons
  6,                    -- min_group_size (NULL if solo is fine)
  NULL,                 -- max_group_size (NULL if no limit)
  false,                -- avoid_pair: true only if 2 of them fight
  'peaceful',           -- temperament: peaceful / semi-aggressive / aggressive
  'Otocinclus do best in a mature tank with algae to graze on. Feed algae wafers or blanched veggies so they don’t go hungry.',                 -- care_note (NULL if none)
  72, 79,               -- min_temp, max_temp (°F)
  6, 7.5,             -- min_ph, max_ph
  NULL,                 -- eats_fish_under_inches (NULL if it doesn't eat fish)
  1                     -- waste_multiplier (1 = normal, higher = messier)
);

UPDATE species SET waste_multiplier = 0.7 WHERE scientific_name = 'Melanotaenia australis';

-- ============================================
-- TEMPLATE: copy this to add a new fish
-- ============================================

-- INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
-- VALUES (
--   'Fish Name',          -- name
--   'Genus species',      -- scientific_name
--   'Beginner',           -- skill_level: Beginner / Intermediate / Advanced
--   2.0,                  -- adult_size_inches
--   0.01000,              -- weight_a (from FishBase)
--   3.00,                 -- weight_b (from FishBase)
--   10,                   -- min_tank_gallons
--   6,                    -- min_group_size (NULL if solo is fine)
--   NULL,                 -- max_group_size (NULL if no limit)
--   false,                -- avoid_pair: true only if 2 of them fight
--   'peaceful',           -- temperament: peaceful / semi-aggressive / aggressive
--   NULL,                 -- care_note (NULL if none)
--   72, 80,               -- min_temp, max_temp (°F)
--   6.5, 7.5,             -- min_ph, max_ph
--   NULL,                 -- eats_fish_under_inches (NULL if it doesn't eat fish)
--   1                     -- waste_multiplier (1 = normal, higher = messier)
-- );


-- ============================================
-- TANK SIZES
-- ============================================

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


-- ============================================
-- CHECK + RESET
-- ============================================

SELECT * FROM species;
SELECT * FROM tank_sizes;

DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS tank_sizes;