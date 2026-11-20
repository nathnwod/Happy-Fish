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

-- CICHLIDS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  ('Bolivian Ram', 'Mikrogeophagus altispinosus', 'Beginner', 3.5, 0.01445, 3.08, 30, NULL, NULL, false, 'peaceful',
    'Bolivian rams are peaceful dwarf cichlids, but males claim territory. In a group, give each male his own cave or space.',
    75, 80, 6.0, 7.5, NULL, 1),

  ('Angelfish', 'Pterophyllum scalare', 'Intermediate', 5, 0.03236, 2.98, 30, NULL, NULL, false, 'semi-aggressive',
    'Angelfish grow tall, so a tall tank works best. Their long fins attract fin nippers, and pairs get territorial when breeding.',
    75, 86, 6.0, 7.5, 2, 1),

  ('Discus', 'Symphysodon aequifasciatus', 'Advanced', 6, 0.02692, 3.03, 75, 6, NULL, NULL, 'peaceful',
    'Discus need very clean water. Keepers do large, frequent water changes.',
    82, 86, 6.0, 7.0, NULL, 0.75);


-- GOLDFISH --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  ('Common Goldfish', 'Carassius auratus', 'Intermediate', 12, 0.01148, 3.04, 75, 2, NULL, NULL, 'peaceful',
    'Goldfish are a messy fish. Need heavy filtration and weekly water changes.',
    60, 75, 6.0, 8.0, 3, 1.45),

  ('Oranda Goldfish', 'Carassius auratus (Oranda)', 'Intermediate', 8.0, 0.01148, 3.04, 40, 2, NULL, false, 'peaceful',
    'Orandas are messy and need strong filtration. They are slow swimmers, so keep them with other fancy goldfish, not fast common goldfish.',
    65, 78, 6.5, 8.0, 2, 1.5);


-- RAINBOWFISH --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  ('Australian Rainbowfish', 'Melanotaenia fluviatilis', 'Beginner', 3.5, 0.01122, 3.04, 30, 6, NULL, false, 'peaceful',
    'Australian rainbowfish are fast swimmers that do best in a long tank with open space. They can stress slow or long-finned fish.',
    68, 77, 6.5, 8.0, NULL, 1),

  ('Western Rainbowfish', 'Melanotaenia australis', 'Beginner', 4, 0.01122, 3.04, 30, 6, NULL, false, 'peaceful',
    'Rainbowfish are fast swimmers that do best in a long tank. They are known to jump, and their colors develop as they grow.',
    72, 81, 6.5, 8, NULL, 0.85);


-- LOACHES AND OTOCINCLUS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  ('Kuhli Loach', 'Pangio kuhlii', 'Beginner', 3.5, 0.00501, 3.08, 20, 5, NULL, false, 'peaceful',
    'Kuhli loaches are shy and mostly come out at night. Give them soft sand to dig in and plenty of hiding spots.',
    74, 80, 5.5, 7.0, NULL, 1),

  ('Otocinclus', 'Otocinclus vittatus', 'Intermediate', 1.75, 0.01122, 3.11, 20, 6, NULL, false, 'peaceful',
    'Otocinclus do best in a mature tank with algae to graze on. Feed algae wafers or blanched veggies so they don’t go hungry.',
    72, 79, 6, 7.5, NULL, 1);



-- PLECOS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Bristlenose
  ('Bristlenose Pleco', 'Ancistrus sp.', 'Beginner', 5, 0.01479, 2.98, 25, 1, NULL, false, 'peaceful',
    'Plecos need driftwood to graze on and spots/caves to hide in. Males fight over hiding spots, so keeping just one male is better.',
    73, 81, 6.5, 7.5, NULL, 1.5),

  ('Albino Bristlenose Pleco', 'Ancistrus cf. cirrhosus (Albino)', 'Beginner', 5, 0.01479, 2.98, 25, NULL, NULL, false, 'peaceful',
    'Albino bristlenose plecos are sensitive to bright light, so they like caves and shady spots.',
    73, 81, 6.5, 7.5, NULL, 1.5),

  ('Super Red Bristlenose Pleco', 'Ancistrus cf. cirrhosus (Super Red)', 'Beginner', 5, 0.01479, 2.98, 25, NULL, NULL, false, 'peaceful',
    'Super red bristlenose plecos eat mostly plants, like algae wafers and blanched vegetables, and graze on driftwood.',
    73, 81, 6.5, 7.5, NULL, 1.5),

  ('Calico Bristlenose Pleco', 'Ancistrus cf. cirrhosus (Calico)', 'Beginner', 5, 0.01479, 2.98, 25, NULL, NULL, false, 'peaceful',
    'Calico bristlenose plecos like driftwood to graze on. Males can get territorial with each other in smaller tanks.',
    73, 81, 6.5, 7.5, NULL, 1.5),

  ('Starlight Bristlenose Pleco', 'Ancistrus dolichopterus', 'Intermediate', 5.0, 0.01622, 3.04, 20, NULL, NULL, false, 'peaceful',
    'Starlight bristlenose plecos like warm, soft water and are quick to suffer when oxygen runs low.',
    75, 86, 6.0, 7.0, NULL, 1.5),

  -- Small plecos (under 6")
  ('Pitbull Pleco', 'Parotocinclus jumbo', 'Intermediate', 2.25, 0.00977, 3.06, 20, 3, NULL, false, 'peaceful',
    'Pitbull plecos like company of their own kind and burrow into sand when startled. A group of up to 6 needs about 30 gallons.',
    68, 79, 6.5, 7.5, NULL, 1.4),

  ('Zebra Pleco', 'Hypancistrus zebra', 'Advanced', 3.5, 0.01259, 2.93, 20, NULL, NULL, false, 'peaceful',
    'Zebra plecos need very warm, well-oxygenated water with strong flow. They eat meaty foods, not algae.',
    79, 86, 6.0, 7.2, NULL, 1.2),

  ('Queen Arabesque Pleco', 'Hypancistrus sp. L260', 'Intermediate', 4.0, 0.01259, 2.93, 30, NULL, NULL, false, 'peaceful',
    'Queen arabesque plecos eat meaty foods, not algae. They can crossbreed with other Hypancistrus plecos like the zebra pleco.',
    77, 84, 6.5, 7.0, NULL, 1.2),

  ('Snowball Pleco', 'Hypancistrus inspector', 'Intermediate', 4.5, 0.01549, 2.96, 30, NULL, NULL, false, 'peaceful',
    'Snowball plecos eat meaty foods, not algae. They can crossbreed with other Hypancistrus plecos like the zebra pleco.',
    77, 84, 6.0, 7.0, NULL, 1.2),

  ('King Tiger Pleco', 'Hypancistrus seideli', 'Intermediate', 5.75, 0.01549, 2.96, 65, NULL, NULL, false, 'peaceful',
    'King tiger plecos eat meaty foods, not algae. They can crossbreed with other Hypancistrus plecos like the zebra pleco.',
    79, 84, 5.8, 7.0, NULL, 1.2),

  ('Clown Pleco', 'Panaqolus maccus', 'Beginner', 4.0, 0.01549, 2.96, 20, NULL, NULL, false, 'peaceful',
    'Clown plecos need driftwood in the tank at all times, since wood is part of their diet. They defend caves, so give each extra clown pleco about 10 more gallons.',
    73, 82, 6.8, 7.6, NULL, 1.3),

  ('Tiger Pleco', 'Panaqolus sp. L002', 'Intermediate', 4.5, 0.01549, 2.96, 20, NULL, NULL, false, 'peaceful',
    'Tiger plecos need driftwood in the tank at all times, since wood is part of their diet. They defend caves, so give each extra tiger pleco about 10 more gallons.',
    75, 81, 6.5, 7.5, NULL, 1.3),

  ('Leopard Frog Pleco', 'Peckoltia compta', 'Intermediate', 4.25, 0.01549, 2.96, 30, NULL, NULL, false, 'peaceful',
    'Leopard frog plecos like warm, well-oxygenated water and prefer meaty foods over algae.',
    77, 86, 6.5, 7.2, NULL, 1),

  ('Candy Striped Pleco', 'Peckoltia vittata', 'Intermediate', 4.5, 0.01778, 2.96, 20, NULL, NULL, false, 'peaceful',
    'Candy striped plecos eat meaty foods, not algae, and like warm water with good flow.',
    75, 82, 6.0, 7.0, NULL, 1),

  ('Butterfly Pleco', 'Dekeyseria picta', 'Intermediate', 5.25, 0.01549, 2.96, 30, NULL, NULL, false, 'peaceful',
    'Butterfly plecos like soft, well-oxygenated water and graze on driftwood.',
    77, 82, 5.8, 7.0, NULL, 1),

  ('Rubber Lip Pleco', 'Chaetostoma milesi', 'Beginner', 5.5, 0.02138, 3.01, 25, NULL, NULL, false, 'peaceful',
    'Rubber lip plecos need well-oxygenated water with good flow. They are territorial with other plecos, so 2 need about 55 gallons or more.',
    72, 78, 6.5, 7.5, NULL, 1),

  -- Medium plecos (8-10")
  ('Green Phantom Pleco', 'Hemiancistrus subviridis', 'Intermediate', 8.0, 0.01549, 2.96, 65, NULL, NULL, false, 'peaceful',
    'Green phantom plecos need very warm, well-oxygenated water with strong flow. They can be territorial with other plecos.',
    77, 86, 6.0, 7.5, NULL, 1.3),

  ('Blue Phantom Pleco', 'Hemiancistrus sp. L128', 'Intermediate', 8.0, 0.01549, 2.96, 55, NULL, NULL, false, 'peaceful',
    'Blue phantom plecos need very warm, well-oxygenated water with strong flow. They can be territorial with other plecos.',
    79, 86, 6.0, 7.2, NULL, 1.3),

  ('Gold Nugget Pleco', 'Baryancistrus xanthellus', 'Advanced', 8.5, 0.01585, 3.00, 65, NULL, 1, false, 'semi-aggressive',
    'Gold nugget plecos need very warm, well-oxygenated water with strong flow. Adults get territorial with other bottom dwellers.',
    81, 86, 6.0, 8.0, NULL, 1.35),

  ('Vampire Pleco', 'Leporacanthicus galaxias', 'Intermediate', 9.5, 0.02692, 2.96, 55, NULL, 1, false, 'peaceful',
    'Vampire plecos are meat eaters that also eat snails. They get territorial with other bottom dwellers.',
    72, 79, 5.6, 7.0, 1, 1.1),

  -- Huge plecos (11"+)
  ('Sunshine Pleco', 'Scobinancistrus aureatus', 'Intermediate', 11.0, 0.01413, 2.96, 90, NULL, 1, false, 'peaceful',
    'Sunshine plecos grow close to a foot long and eat meaty foods as well as vegetables.',
    75, 84, 6.0, 7.2, NULL, 1.6),

  ('Gold Spot Pleco', 'Pterygoplichthys joselimaianus', 'Intermediate', 12.0, 0.02042, 2.95, 75, NULL, NULL, false, 'peaceful',
    'Gold spot plecos grow about a foot long and make a lot of waste.',
    74, 84, 6.5, 7.5, NULL, 1.7),

  ('Common Pleco', 'Pterygoplichthys pardalis', 'Intermediate', 15.0, 0.01862, 2.93, 125, NULL, NULL, false, 'peaceful',
    'Common plecos grow huge, often over a foot long, and make a lot of waste. Most beginners are better off with a bristlenose pleco.',
    72, 79, 6.5, 7.5, NULL, 2),

  ('Sailfin Pleco', 'Pterygoplichthys gibbiceps', 'Intermediate', 16.0, 0.02042, 2.95, 100, NULL, NULL, false, 'peaceful',
    'Sailfin plecos grow huge, often over a foot long, and make a lot of waste. They may suck on the slime coat of slow, flat fish like angelfish and discus.',
    73, 80, 6.5, 7.8, NULL, 1.95),

  ('Royal Pleco', 'Panaque nigrolineatus', 'Intermediate', 17.0, 0.02884, 2.98, 125, NULL, NULL, false, 'peaceful',
    'Royal plecos eat wood, so they need large driftwood at all times. They grow huge and make a lot of waste.',
    72, 78, 6.5, 7.5, NULL, 1.6);



-- CORYS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Dwarf corys (under 2")
  ('Pygmy Cory', 'Gastrodermus pygmaeus', 'Intermediate', 1.25, 0.00741, 3.14, 10, 8, NULL, false, 'peaceful',
    'Pygmy corys often swim in midwater, unlike most corys. They are easily bullied by bigger tankmates.',
    72, 79, 6.5, 7.2, NULL, 1.6),

  ('Hastatus Cory', 'Gastrodermus hastatus', 'Intermediate', 1.4, 0.00741, 3.14, 10, 8, NULL, false, 'peaceful',
    'Hastatus corys swim in midwater like pygmy corys and are easily bullied by bigger tankmates.',
    72, 79, 6.0, 7.5, NULL, 1.4),

  ('Salt and Pepper Cory', 'Hoplisoma habrosum', 'Intermediate', 1.5, 0.00741, 3.14, 10, 6, NULL, NULL, 'peaceful',
    NULL,
    72, 79, 6.0, 7.5, NULL, 1.4),

  ('Gracilis Cory', 'Gastrodermus gracilis', 'Intermediate', 1.5, 0.00741, 3.14, 15, 8, NULL, false, 'peaceful',
    'Gracilis corys are shy and do best with tiny, calm tankmates.',
    72, 79, 6.0, 7.5, NULL, 1.6),

  ('Nanus Cory', 'Gastrodermus nanus', 'Beginner', 1.75, 0.00741, 3.14, 15, 6, NULL, false, 'peaceful',
    'Nanus corys are often mixed up with look-alike species in stores.',
    72, 79, 6.0, 7.5, NULL, 1.6),

  -- Bronze cory and its forms
  ('Bronze Cory', 'Osteogaster aenea', 'Beginner', 3.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Bronze corys are one of the hardiest corys. Albino corys are the same species.',
    72, 78, 6.0, 8.0, NULL, 1.2),

  ('Albino Cory', 'Osteogaster aenea (Albino)', 'Beginner', 3.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Albino corys are a color form of the bronze cory and need the same care.',
    72, 78, 6.0, 8.0, NULL, 1.2),

  ('Green Laser Cory', 'Osteogaster sp. CW009', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Green laser corys may be a color form of the bronze cory and are cared for the same way.',
    72, 79, 6.5, 7.0, NULL, 1.2),

  ('Orange Laser Cory', 'Osteogaster sp. CW010', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Orange laser corys are close relatives of the bronze cory. Some stores call them gold laser corys.',
    75, 79, 6.5, 7.2, NULL, 1.2),

  ('Black Venezuela Cory', 'Osteogaster schultzei', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Black Venezuela corys are a bred color strain related to the bronze cory and adapt to most water.',
    72, 79, 6.5, 7.2, NULL, 1.2),

  -- Regular corys (2-2.75")
  ('Bandit Cory', 'Hoplisoma metae', 'Beginner', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Bandit corys do best on sand, since rough gravel can wear down their whiskers.',
    72, 79, 6.0, 7.5, NULL, 1.4),

  ('Eques Cory', 'Osteogaster eques', 'Beginner', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Eques corys are also sold as horseman''s corys.',
    68, 77, 6.0, 7.5, NULL, 1.4),

  ('Fairy Cory', 'Hoplisoma atropersonatum', 'Intermediate', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Fairy corys do best in soft water and a mature tank, since they are sensitive to nitrate.',
    72, 79, 5.5, 7.0, NULL, 1.4),

  ('Julii Cory', 'Hoplisoma julii', 'Intermediate', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'True julii corys are rarely sold. Most fish labeled julii are three stripe corys.',
    72, 79, 5.5, 7.0, NULL, 1.4),

  ('Loxozonus Cory', 'Hoplisoma loxozonum', 'Beginner', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Loxozonus corys do not do well in warm water.',
    70, 77, 6.0, 7.5, NULL, 1.4),

  ('Napo Cory', 'Gastrodermus napoensis', 'Beginner', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Napo corys often swim in midwater, like elegans corys.',
    72, 78, 6.0, 7.5, NULL, 1.4),

  ('Panda Cory', 'Hoplisoma panda', 'Beginner', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Panda corys prefer cooler water than most corys. They need sand or smooth gravel to protect their whiskers.',
    72, 77, 6.0, 7.5, NULL, 1.4),

  ('Similis Cory', 'Hoplisoma simile', 'Intermediate', 2.0, 0.00741, 3.14, 15, 6, NULL, false, 'peaceful',
    'Similis corys are sensitive to dirty water, so they do best in a well-kept tank.',
    72, 79, 5.5, 7.0, NULL, 1.4),

  ('Skunk Cory', 'Brochis arcuatus', 'Beginner', 2.0, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Skunk corys are easy to care for and do well in most community tanks.',
    72, 78, 6.5, 7.5, NULL, 1.4),

  ('Adolfoi Cory', 'Hoplisoma adolfoi', 'Intermediate', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Adolfoi corys do best in soft, slightly acidic water and are sensitive to nitrate.',
    72, 79, 5.5, 7.0, NULL, 1.4),

  ('Bannertail Cory', 'Brochis robineae', 'Beginner', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Bannertail corys get their name from their striped tail and do best with small, peaceful tankmates.',
    72, 79, 6.0, 7.5, NULL, 1.4),

  ('Blackfin Cory', 'Hoplisoma leucomelas', 'Intermediate', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Blackfin corys come from blackwater rivers and do best in soft, slightly acidic water.',
    72, 79, 5.5, 7.0, NULL, 1.4),

  ('Duplicareus Cory', 'Hoplisoma duplicareum', 'Intermediate', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Duplicareus corys look almost identical to adolfoi corys and like the same soft, slightly acidic water.',
    72, 79, 6.0, 7.0, NULL, 1.4),

  ('Elegans Cory', 'Gastrodermus elegans', 'Beginner', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Elegans corys often swim in midwater instead of staying on the bottom.',
    72, 79, 6.0, 7.2, NULL, 1.4),

  ('False Bandit Cory', 'Hoplisoma melini', 'Intermediate', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'False bandit corys look like bandit corys, but their back stripe runs at a slant.',
    72, 79, 5.5, 7.0, NULL, 1.4),

  ('Three Stripe Cory', 'Hoplisoma trilineatum', 'Beginner', 2.25, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Three stripe corys are usually what stores sell as julii corys.',
    72, 79, 6.0, 7.2, NULL, 1.4),

  ('Concolor Cory', 'Hoplisoma concolor', 'Beginner', 2.5, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Concolor corys, also called slate corys, adapt to a wide range of water.',
    73, 79, 6.0, 7.2, NULL, 1.3),

  ('Gossei Cory', 'Hoplisoma gossei', 'Intermediate', 2.5, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Gossei corys are sensitive to nitrate, so they do best in a mature tank.',
    75, 79, 5.5, 7.0, NULL, 1.3),

  ('Green Gold Cory', 'Osteogaster melanotaenia', 'Intermediate', 2.5, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Green gold corys prefer slightly cooler water than most corys.',
    72, 77, 6.0, 7.2, NULL, 1.3),

  ('Rusty Cory', 'Osteogaster rabauti', 'Beginner', 2.5, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Rusty corys need their own sinking food and can''t live on leftovers from other fish.',
    72, 79, 6.0, 7.2, NULL, 1.3),

  ('Schwartzi Cory', 'Hoplisoma schwartzi', 'Beginner', 2.5, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Schwartzi corys swim up to gulp air at the surface, so leave a small gap under the lid.',
    72, 79, 6.0, 7.5, NULL, 1.3),

  ('Sodalis Cory', 'Brochis sodalis', 'Intermediate', 2.5, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Sodalis corys, also called false network corys, are sensitive to dirty water.',
    72, 79, 6.0, 7.0, NULL, 1.3),

  ('Sterbas Cory', 'Hoplisoma sterbai', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Corys need sand or smooth gravel to protect their whiskers. Feed sinking food.',
    75, 82, 6, 7.5, NULL, 1.2),

  ('Agassizii Cory', 'Brochis agassizii', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Agassizii corys are a little bigger than most corys and do best with plenty of open sand.',
    72, 81, 6.0, 8.0, NULL, 1.2),

  ('Peppered Cory', 'Hoplisoma paleatum', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Peppered corys handle cooler water than most corys.',
    68, 77, 6.0, 7.0, NULL, 1.2),

  ('Spotted Cory', 'Brochis ambiacus', 'Beginner', 2.75, 0.00741, 3.14, 20, 6, NULL, false, 'peaceful',
    'Spotted corys adapt to a wide range of water conditions.',
    70, 77, 6.0, 7.8, NULL, 1.2),

  -- Large corys (3"+)
  ('Emerald Green Cory', 'Brochis splendens', 'Beginner', 3.0, 0.00741, 3.14, 30, 6, NULL, false, 'peaceful',
    'Emerald green corys grow bigger than most corys, so they use more floor space.',
    72, 78, 6.5, 7.5, NULL, 1.2),

  ('Bearded Cory', 'Scleromystax barbatus', 'Intermediate', 4.0, 0.00741, 3.14, 40, 6, NULL, false, 'peaceful',
    'Bearded corys like cool water. Males fight each other, so keep one male with several females.',
    64, 75, 5.5, 7.2, NULL, 1.2);


-- TETRAS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Small tetras (under 2")
  ('Ruby Tetra', 'Axelrodia riesei', 'Intermediate', 1.0, 0.01122, 3.08, 10, 8, NULL, false, 'peaceful',
    'Ruby tetras need very soft, acidic water and are sensitive to changes, so add them only to a mature tank.',
    68, 80, 4.5, 6.5, NULL, 1.5),

  ('Ember Tetra', 'Hyphessobrycon amandae', 'Intermediate', 1.0, 0.01202, 3.09, 10, 6, NULL, NULL, 'peaceful',
    NULL,
    73, 82, 5.5, 7.5, NULL, 1.5),

  ('Green Neon Tetra', 'Paracheirodon simulans', 'Intermediate', 1.25, 0.01122, 3.08, 10, 6, NULL, false, 'peaceful',
    'Green neon tetras need soft, acidic water and are usually wild caught, so they do best in a mature tank.',
    75, 81, 5.5, 6.5, NULL, 1.1),

  ('Flame Tetra', 'Hyphessobrycon flammeus', 'Beginner', 1.25, 0.01202, 3.09, 15, 6, NULL, false, 'peaceful',
    'Flame tetras show their deepest red in a planted tank with dim lighting.',
    68, 82, 5.5, 7.5, NULL, 1),

  ('Black Neon Tetra', 'Hyphessobrycon herbertaxelrodi', 'Beginner', 1.5, 0.01202, 3.09, 20, 6, NULL, false, 'peaceful',
    'Black neon tetras are a separate species from the neon tetra and are hardier.',
    68, 82, 5.5, 7.5, NULL, 1),

  ('Black Phantom Tetra', 'Megalamphodus megalopterus', 'Beginner', 1.5, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful',
    'Black phantom tetra males flare their fins at each other to show off, which is harmless.',
    72, 82, 5.0, 7.5, NULL, 1),

  ('Glowlight Tetra', 'Hemigrammus erythrozonus', 'Beginner', 1.5, 0.01259, 3.05, 20, 6, NULL, false, 'peaceful',
    'Glowlight tetras are hardy and show their best color in soft, slightly acidic water.',
    74, 82, 5.5, 7.5, NULL, 1),

  ('Neon Tetra', 'Paracheirodon innesi', 'Beginner', 1.5, 0.01122, 3.08, 10, 6, NULL, NULL, 'peaceful',
    NULL,
    72, 78, 5.0, 7.5, NULL, 1),

  ('Red Phantom Tetra', 'Megalamphodus sweglesi', 'Intermediate', 1.5, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful',
    'Red phantom tetras prefer cooler water than most tetras and do best in a mature tank.',
    68, 78, 5.5, 7.5, NULL, 1),

  ('Royal Tetra', 'Inpaichthys kerri', 'Beginner', 1.5, 0.01698, 3.05, 15, 6, NULL, false, 'peaceful',
    'Royal tetras, also sold as blue or purple emperor tetras, do poorly in hard, alkaline water.',
    75, 81, 5.5, 7.0, NULL, 1),

  ('Cardinal Tetra', 'Paracheirodon axelrodi', 'Intermediate', 1.75, 0.01122, 3.08, 20, 6, NULL, false, 'peaceful',
    'Cardinal tetras are sensitive to water changes and are often wild caught. Best added to an established tank.',
    74, 82, 4, 7, NULL, 1),

  ('Head and Tail Light Tetra', 'Holopristis ocellifera', 'Beginner', 1.75, 0.01096, 3.08, 20, 6, NULL, false, 'peaceful',
    'Head and tail light tetras are hardy and a good choice for a first community tank.',
    72, 79, 6.0, 7.5, NULL, 1),

  ('Rosy Tetra', 'Megalamphodus rosaceus', 'Beginner', 1.75, 0.01995, 3.01, 15, 6, NULL, false, 'peaceful',
    'Rosy tetras are easily frightened and do poorly with boisterous tankmates.',
    75, 82, 5.5, 7.5, NULL, 1),

  ('Serpae Tetra', 'Hyphessobrycon eques', 'Beginner', 1.75, 0.01349, 3.14, 20, 8, NULL, false, 'semi-aggressive',
    'Serpae tetras are known fin nippers. Keep 8 or more, and avoid slow, long-finned tankmates like bettas and angelfish.',
    72, 79, 5.0, 7.5, NULL, 1.15),

  ('Silvertip Tetra', 'Hasemania nana', 'Beginner', 1.75, 0.01259, 3.11, 20, 8, NULL, false, 'semi-aggressive',
    'Silvertip tetras nip fins more than most tetras. Keep 8 or more, and avoid long-finned tankmates.',
    72, 82, 6.0, 8.0, NULL, 1),

  ('X-Ray Tetra', 'Pristella maxillaris', 'Beginner', 1.75, 0.01202, 3.05, 15, 6, NULL, false, 'peaceful',
    'X-ray tetras are hardy and peaceful, but they get stressed by boisterous tankmates.',
    72, 82, 6.0, 7.5, NULL, 1),

  -- Medium tetras (2-2.75")
  ('Bloodfin Tetra', 'Aphyocharax anisitsi', 'Beginner', 2.0, 0.01122, 3.04, 20, 6, NULL, false, 'peaceful',
    'Bloodfin tetras are expert jumpers, so a tight lid matters. They may nip long-finned fish.',
    64, 82, 6.0, 8.0, NULL, 1),

  ('Cochu''s Blue Tetra', 'Boehlkea fredcochui', 'Beginner', 2.0, 0.01230, 3.04, 20, 6, NULL, false, 'peaceful',
    'Cochu''s blue tetras are very active and may nip long fins in a cramped tank.',
    72, 82, 5.5, 7.5, NULL, 1),

  ('Emperor Tetra', 'Nematobrycon palmeri', 'Beginner', 2.0, 0.01122, 3.04, 20, 6, NULL, false, 'peaceful',
    'Emperor tetra males spar with each other, so keep more females than males.',
    73, 81, 5.0, 7.8, NULL, 1),

  ('Gold Tetra', 'Hemigrammus rodwayi', 'Beginner', 2.0, 0.01259, 3.05, 20, 6, NULL, false, 'peaceful',
    'Gold tetras from breeders are usually silver. The gold shine only comes from a skin reaction in some wild fish.',
    75, 82, 6.0, 7.0, NULL, 1),

  ('Green Fire Tetra', 'Aphyocharax rathbuni', 'Beginner', 2.0, 0.00832, 3.10, 15, 6, NULL, false, 'peaceful',
    'Green fire tetras have a reputation for nipping, so avoid long-finned tankmates.',
    68, 79, 6.5, 7.5, NULL, 1),

  ('Lemon Tetra', 'Hyphessobrycon pulchripinnis', 'Beginner', 2.0, 0.01047, 3.05, 20, 6, NULL, false, 'peaceful',
    'Lemon tetra males spar with each other, which is normal and brings out their color.',
    72, 82, 5.5, 7.5, NULL, 1.15),

  ('Rummynose Tetra', 'Petitella bleheri', 'Intermediate', 2.0, 0.01122, 3.08, 20, 10, NULL, false, 'peaceful',
    'Rummynose tetras are sensitive to water quality, and their red noses fade when they are stressed. Best added to an established tank.',
    73, 80, 5.5, 7.0, NULL, 0.9),

  ('Glass Bloodfin Tetra', 'Prionobrama filigera', 'Beginner', 2.4, 0.01122, 3.04, 20, 6, NULL, false, 'peaceful',
    'Glass bloodfin tetras swim near the surface and like open space with some floating plants.',
    73, 81, 6.0, 7.5, NULL, 1),

  ('Penguin Tetra', 'Thayeria boehlkei', 'Beginner', 2.4, 0.01096, 3.08, 20, 6, NULL, false, 'peaceful',
    'Penguin tetras stay near the top of the tank and can be a little nippy in small groups.',
    72, 82, 5.5, 8.0, NULL, 1),

  ('Diamond Tetra', 'Makunaima pittieri', 'Beginner', 2.5, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful',
    'Diamond tetras look plain when young and develop their sparkle as adults. Avoid long-finned tankmates.',
    75, 82, 5.5, 7.0, NULL, 1),

  ('Bleeding Heart Tetra', 'Megalamphodus erythrostigma', 'Intermediate', 2.75, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful',
    'Bleeding heart tetras need a mature tank with very clean water. They may nip long-finned fish like guppies.',
    72, 82, 5.5, 7.0, NULL, 1),

  ('Buenos Aires Tetra', 'Psalidodon anisitsi', 'Beginner', 2.75, 0.01349, 3.09, 30, 8, NULL, false, 'semi-aggressive',
    'Buenos Aires tetras eat soft plants and can nip fins in small groups. Tough plants like anubias and java fern hold up best.',
    64, 79, 5.5, 7.5, NULL, 1),

  ('Colombian Tetra', 'Hyphessobrycon columbianus', 'Beginner', 2.75, 0.01202, 3.09, 30, 8, NULL, false, 'semi-aggressive',
    'Colombian tetras are energetic and can nip long-finned tankmates. A bigger group spreads out the nipping.',
    75, 81, 5.5, 7.0, NULL, 1),

  ('Red Eye Tetra', 'Moenkhausia sanctaefilomenae', 'Beginner', 2.75, 0.01479, 3.03, 29, 8, NULL, false, 'peaceful',
    'Red eye tetras are active swimmers that can nip fins and stress calm fish like gouramis.',
    72, 82, 6.0, 8.0, NULL, 1.15),

  -- Black skirt tetra and its forms
  ('Black Skirt Tetra', 'Gymnocorymbus ternetzi', 'Beginner', 2.5, 0.01950, 2.97, 20, 8, NULL, false, 'peaceful',
    'Black skirt tetras can nip long fins in small groups. A bigger group keeps the squabbling among themselves.',
    68, 79, 6.0, 7.5, NULL, 0.85),

  ('GloFish Tetra', 'Gymnocorymbus ternetzi (GloFish)', 'Beginner', 2.5, 0.01950, 2.97, 20, 8, NULL, false, 'peaceful',
    'GloFish tetras are born with their color, not dyed. They glow brightest under blue light.',
    68, 79, 6.0, 7.5, NULL, 0.85),

  ('White Skirt Tetra', 'Gymnocorymbus ternetzi (White Skirt)', 'Beginner', 2.5, 0.01950, 2.97, 20, 8, NULL, false, 'peaceful',
    'Avoid white skirt tetras sold dyed in bright colors, since the dyeing process harms them.',
    68, 79, 6.0, 7.5, NULL, 0.85),

  -- Large tetras (3"+)
  ('Congo Tetra', 'Phenacogrammus interruptus', 'Intermediate', 3.25, 0.01072, 3.02, 30, 6, NULL, false, 'peaceful',
    'Congo tetras are shy, active swimmers that need a long tank. Fin nippers will ruin the males'' long fins.',
    73, 82, 6.0, 7.5, NULL, 1.3),

  ('African Red-Eye Tetra', 'Arnoldichthys spilopterus', 'Intermediate', 3.75, 0.01122, 3.04, 30, 6, NULL, false, 'peaceful',
    'African red-eye tetras are big, very active swimmers that need open space and can stress shy tankmates.',
    73, 82, 6.0, 8.0, NULL, 1.2),

  ('Blind Cave Tetra', 'Astyanax mexicanus', 'Beginner', 4.0, 0.00912, 3.05, 30, 6, NULL, false, 'peaceful',
    'Blind cave tetras find food by smell and feel, and can bump or nip slow, shy tankmates at feeding time.',
    68, 77, 6.5, 8.0, NULL, 1);



-- RASBORAS, DANIOS AND MINNOWS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Tiny rasboras (under 1")
  ('Exclamation Point Rasbora', 'Boraras urophthalmoides', 'Intermediate', 0.6, 0.00575, 3.09, 10, 10, NULL, false, 'peaceful',
    'Exclamation point rasboras can crossbreed with chili and phoenix rasboras, so keep only one of these species per tank.',
    73, 82, 6.0, 7.0, NULL, 1.25),

  ('Chili Rasbora', 'Boraras brigittae', 'Intermediate', 0.75, 0.00891, 3.02, 5, 6, NULL, false, 'peaceful',
    NULL,
    74, 80, 5.5, 7, NULL, 1),

  ('Kubotai Rasbora', 'Microdevario kubotai', 'Intermediate', 0.8, 0.00977, 3.04, 10, 10, NULL, false, 'peaceful',
    'Kubotai rasboras, also sold as neon green rasboras, are timid and do best with other tiny, calm fish.',
    72, 81, 6.0, 7.5, NULL, 1.45),

  ('Phoenix Rasbora', 'Boraras merah', 'Intermediate', 0.8, 0.00575, 3.09, 10, 10, NULL, false, 'peaceful',
    'Phoenix rasboras are timid and do best in a dim, densely planted tank with other tiny fish.',
    68, 82, 4.0, 7.0, NULL, 1.25),

  ('Strawberry Rasbora', 'Boraras naevus', 'Intermediate', 0.8, 0.00891, 3.02, 10, 10, NULL, false, 'peaceful',
    'Strawberry rasboras can crossbreed with chili, phoenix, and other Boraras rasboras, so keep only one of these species per tank.',
    68, 82, 4.5, 7.0, NULL, 1.25),

  ('Dwarf Spotted Rasbora', 'Boraras maculatus', 'Intermediate', 1.0, 0.00891, 3.02, 10, 8, NULL, false, 'peaceful',
    'Dwarf spotted rasboras need soft, acidic water and do best in a dim, densely planted tank.',
    72, 82, 4.5, 6.8, NULL, 1.25),

  -- Small rasboras (1-2")
  ('Glowlight Rasbora', 'Trigonostigma hengeli', 'Beginner', 1.25, 0.01995, 3.01, 10, 8, NULL, false, 'peaceful',
    'Glowlight rasboras, also sold as hengeli rasboras, show their best color in a dim tank with a dark substrate.',
    73, 82, 5.5, 7.0, NULL, 1),

  ('Eyespot Rasbora', 'Brevibora dorsiocellata', 'Beginner', 1.5, 0.00891, 3.02, 15, 10, NULL, false, 'peaceful',
    'Eyespot rasboras, also called emerald eye rasboras, are timid and sensitive to high nitrate.',
    68, 77, 5.0, 7.0, NULL, 1),

  ('Lambchop Rasbora', 'Trigonostigma espei', 'Beginner', 1.5, 0.01995, 3.01, 15, 8, NULL, false, 'peaceful',
    'Lambchop rasboras look like small harlequin rasboras and show their best color in a dim, planted tank.',
    73, 82, 5.5, 7.0, NULL, 1),

  ('Harlequin Rasbora', 'Trigonostigma heteromorpha', 'Beginner', 1.75, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful',
    NULL,
    72, 84, 6, 7.5, NULL, 1),

  -- Medium rasboras (2-3")
  ('Red Tail Rasbora', 'Rasbora borapetensis', 'Beginner', 2.4, 0.00692, 3.09, 20, 8, NULL, false, 'peaceful',
    'Red tail rasboras, also sold as blackline rasboras, struggle in strong current and like a planted tank with gentle flow.',
    72, 79, 6.0, 7.5, NULL, 1),

  ('Brilliant Rasbora', 'Rasbora einthovenii', 'Beginner', 3, 0.00776, 3.01, 30, 6, NULL, false, 'peaceful',
    'Brilliant rasboras show their best color in dim light with floating plants, and do best in a mature tank.',
    72, 79, 5.5, 7.5, NULL, 1),

  ('Redline Rasbora', 'Trigonopoma pauciperforatum', 'Beginner', 2.75, 0.00575, 3.09, 15, 6, NULL, false, 'peaceful',
    'Redline rasboras are peaceful but can be outcompeted for food by boisterous tankmates.',
    73, 79, 5.0, 7.0, NULL, 1),

  -- Large rasboras (3"+)
  ('Clown Rasbora', 'Rasbora kalochroma', 'Intermediate', 3.9, 0.00776, 3.01, 55, 10, NULL, false, 'peaceful',
    'Clown rasboras are sensitive to water changes, so add them only to a mature tank. They are jumpers, so a tight lid matters.',
    73, 82, 5.0, 7.0, NULL, 1),

  ('Scissortail Rasbora', 'Rasbora trilineata', 'Beginner', 4.0, 0.00708, 3.08, 30, 6, NULL, false, 'peaceful',
    'Scissortail rasboras are strong jumpers, so a tight lid matters. They need a long tank with open swimming space.',
    72, 79, 6.5, 7.5, NULL, 1),

  ('Greater Scissortail Rasbora', 'Rasbora caudimaculata', 'Intermediate', 6.0, 0.00646, 3.08, 75, 6, NULL, false, 'peaceful',
    'Greater scissortail rasboras grow about 6 inches, jump well, and need very clean water and lots of open swimming space.',
    68, 79, 6.0, 7.0, NULL, 1),

  -- Zebra danio and its forms
  ('Zebra Danio', 'Danio rerio', 'Beginner', 2, 0.00977, 3.04, 20, 6, NULL, false, 'peaceful',
    'Zebra danios are fast, active swimmers. They may nip the fins of slow, long-finned fish like bettas and angelfish.',
    65, 77, 6.5, 8.0, NULL, 1.3),

  ('GloFish Danio', 'Danio rerio (GloFish)', 'Beginner', 2.0, 0.00977, 3.04, 20, 6, NULL, false, 'peaceful',
    'GloFish danios are born with their color, not dyed. They are fast swimmers that may nip slow, long-finned fish.',
    65, 77, 6.5, 8.0, NULL, 1.3),

  ('Leopard Danio', 'Danio rerio (Leopard)', 'Beginner', 2.0, 0.00977, 3.04, 20, 6, NULL, false, 'peaceful',
    'Leopard danios are a spotted form of the zebra danio. They are fast swimmers that may nip slow, long-finned fish.',
    65, 77, 6.5, 8.0, NULL, 1.3),

  -- Small danios (under 2")
  ('Celestial Pearl Danio', 'Danio margaritatus', 'Beginner', 1.0, 0.00603, 3.13, 10, 6, NULL, NULL, 'peaceful',
    NULL,
    72, 79, 6.5, 7.5, NULL, 1.75),

  ('Emerald Dwarf Rasbora', 'Danio erythromicron', 'Intermediate', 1.0, 0.00603, 3.13, 15, 10, NULL, false, 'peaceful',
    'Emerald dwarf rasboras need hard, alkaline water and can crossbreed with celestial pearl danios, so keep them apart.',
    68, 75, 7.0, 8.0, NULL, 1.75),

  ('Gold Ring Danio', 'Danio tinwini', 'Beginner', 1.25, 0.00603, 3.13, 10, 8, NULL, false, 'peaceful',
    'Gold ring danios are small, so keep them with other tiny, peaceful fish. They jump, so a tight lid matters.',
    64, 79, 6.5, 7.5, NULL, 1.4),

  ('Glowlight Danio', 'Danio choprae', 'Beginner', 1.4, 0.00977, 3.04, 20, 8, NULL, false, 'peaceful',
    'Glowlight danio males spar with each other, and they jump, so a tight lid matters.',
    68, 77, 6.0, 7.5, NULL, 1.5),

  ('Orange Finned Danio', 'Danio kyathit', 'Beginner', 1.75, 0.00977, 3.04, 20, 8, NULL, false, 'peaceful',
    'Orange finned danios are known jumpers, so a tight lid matters. They handle cooler water well.',
    61, 79, 6.5, 7.5, NULL, 1.45),

  ('Rosy Danio', 'Danio roseus', 'Beginner', 1.75, 0.00603, 3.13, 20, 6, NULL, false, 'peaceful',
    'Rosy danios are skilled jumpers, so a tight lid matters. Their colors show best over a dark substrate.',
    68, 79, 6.0, 7.5, NULL, 1.75),

  ('Spotted Danio', 'Danio nigrofasciatus', 'Beginner', 1.75, 0.00977, 3.04, 15, 6, NULL, false, 'peaceful',
    'Spotted danios are shyer than zebra danios and do best with similar-sized, calm tankmates.',
    68, 79, 6.4, 7.5, NULL, 1.45),

  -- Medium danios (2-3")
  ('Blue Danio', 'Danio kerri', 'Beginner', 2.0, 0.00977, 3.04, 20, 6, NULL, false, 'peaceful',
    'Blue danios are known jumpers, so a tight lid matters. They do best in a long tank with gentle current.',
    73, 78, 6.5, 7.0, NULL, 1.3),

  ('Pearl Danio', 'Danio albolineatus', 'Beginner', 2.5, 0.00661, 3.13, 20, 6, NULL, false, 'peaceful',
    'Pearl danios are known jumpers, so a tight lid matters. They prefer slightly cooler water.',
    64, 77, 6.0, 8.0, NULL, 1),

  -- Large danios (3"+)
  ('Queen Danio', 'Devario regina', 'Intermediate', 3.1, 0.00851, 3.03, 55, 8, NULL, false, 'peaceful',
    'Queen danios are fast, vigorous eaters that can outcompete or stress slow, timid tankmates.',
    73, 79, 6.1, 7.5, NULL, 1),

  ('Bengal Danio', 'Devario devario', 'Beginner', 3.4, 0.00912, 3.04, 55, 8, NULL, false, 'peaceful',
    'Bengal danios are very active jumpers that need a long tank with a tight lid and good water flow.',
    59, 79, 6.0, 8.0, NULL, 1),

  ('Giant Danio', 'Devario aequipinnatus', 'Beginner', 4.0, 0.00759, 3.17, 55, 6, NULL, false, 'peaceful',
    'Giant danios are fast, boisterous swimmers that need a long tank with open space. They can stress slow or long-finned fish.',
    72, 77, 6.0, 8.0, NULL, 1),

  -- Minnows
  ('White Cloud Mountain Minnow', 'Tanichthys albonubes', 'Beginner', 1.5, 0.01023, 3.08, 10, 6, NULL, false, 'peaceful',
    'White cloud mountain minnows prefer cool water and usually do not need a heater.',
    60, 72, 6.0, 8.0, NULL, 1.3),

  ('Gold White Cloud Mountain Minnow', 'Tanichthys albonubes (Gold)', 'Beginner', 1.5, 0.01023, 3.08, 10, 6, NULL, false, 'peaceful',
    'Gold white clouds are just as hardy as regular white clouds and usually do not need a heater.',
    60, 72, 6.0, 8.0, NULL, 1.3),

  ('Rainbow Shiner', 'Hydrophlox chrosomus', 'Intermediate', 3.0, 0.00525, 3.10, 29, 6, NULL, false, 'peaceful',
    'Rainbow shiners prefer cool, well-oxygenated water with some current, and usually do not need a heater.',
    60, 72, 6.8, 7.8, NULL, 1);


-- BARBS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Small barbs (under 2.5")
  ('Golden Dwarf Barb', 'Pethia gelius', 'Intermediate', 1.75, 0.01023, 2.99, 10, 6, NULL, false, 'peaceful',
    'Golden dwarf barbs are timid, prefer cooler water, and do best with other tiny, calm fish.',
    64, 75, 6.0, 7.0, NULL, 1),

  ('Checkerboard Barb', 'Oliotius oligolepis', 'Beginner', 1.9, 0.01072, 3.02, 20, 6, NULL, false, 'peaceful',
    'Checkerboard barbs do not handle very warm water well, and keeping more females than males cuts down on male sparring.',
    68, 77, 6.0, 7.0, NULL, 1.4),

  ('Cherry Barb', 'Puntius titteya', 'Beginner', 2, 0.01259, 3.02, 20, 6, NULL, false, 'peaceful',
    'Keep about 1 male cherry barb to every 2 females. Lots of plants help them feel safe.',
    73, 80, 6.5, 7.5, NULL, 1),

  ('Five Banded Barb', 'Desmopuntius pentazona', 'Intermediate', 2.0, 0.01072, 3.02, 20, 6, NULL, false, 'peaceful',
    'Five banded barbs need soft, acidic water and get timid around boisterous tankmates.',
    75, 82, 4.5, 7.0, NULL, 1.3),

  ('Snakeskin Barb', 'Desmopuntius rhomboocellatus', 'Intermediate', 2.0, 0.01072, 3.02, 20, 8, NULL, false, 'peaceful',
    'Snakeskin barbs need soft, acidic water and are shy around boisterous tankmates.',
    73, 82, 5.5, 7.0, NULL, 1.3),

  ('Black Ruby Barb', 'Pethia nigrofasciata', 'Beginner', 2.25, 0.01072, 3.00, 20, 6, NULL, false, 'peaceful',
    'Black ruby barb males turn deep red and black when they mature or are ready to breed. They may nibble fine-leaved plants.',
    68, 79, 5.5, 7.0, NULL, 1.4),

  -- Tiger barb and its forms
  ('Tiger Barb', 'Puntigrus tetrazona', 'Beginner', 2.75, 0.01585, 2.94, 29, 8, NULL, false, 'semi-aggressive',
    'Tiger barbs nip fins, especially in small groups. Keep 8 or more, and avoid slow, long-finned tankmates like bettas, angelfish, and guppies.',
    70, 79, 6.0, 8.0, NULL, 1),

  ('Albino Tiger Barb', 'Puntigrus tetrazona (Albino)', 'Beginner', 2.75, 0.01585, 2.94, 29, 8, NULL, false, 'semi-aggressive',
    'Albino tiger barbs are a color form of the tiger barb and nip fins just as much. Keep 8 or more, and avoid slow, long-finned tankmates.',
    70, 79, 6.0, 8.0, NULL, 1),

  ('GloFish Barb', 'Puntigrus tetrazona (GloFish)', 'Beginner', 2.75, 0.01585, 2.94, 29, 8, NULL, false, 'semi-aggressive',
    'GloFish barbs are tiger barbs born with their color, not dyed. They nip fins like regular tiger barbs, so avoid long-finned tankmates.',
    70, 79, 6.0, 8.0, NULL, 1),

  ('Green Tiger Barb', 'Puntigrus tetrazona (Green)', 'Beginner', 2.75, 0.01585, 2.94, 29, 8, NULL, false, 'semi-aggressive',
    'Green tiger barbs are a color form of the tiger barb and nip fins just as much. Keep 8 or more, and avoid slow, long-finned tankmates.',
    70, 79, 6.0, 8.0, NULL, 1),

  -- Medium barbs (2.5-3.5")
  ('Melon Barb', 'Haludaria fasciata', 'Beginner', 2.75, 0.01072, 3.02, 30, 8, NULL, false, 'peaceful',
    'Melon barbs, also sold as red panda barbs, look washed out in stores but color up after a few weeks. They are fast, greedy eaters.',
    72, 79, 6.0, 7.5, NULL, 1.4),

  ('Odessa Barb', 'Pethia padamya', 'Beginner', 2.75, 0.01585, 2.94, 29, 6, NULL, false, 'peaceful',
    'Odessa barb males get their bright red color as they mature, and spar with each other without real harm.',
    70, 79, 6.0, 7.5, NULL, 1),

  ('Gold Barb', 'Barbodes semifasciolatus', 'Beginner', 3.0, 0.01349, 3.10, 20, 6, NULL, false, 'peaceful',
    'Gold barbs are hardy and like cooler water. Check for bent spines or stubby fins when buying, since many are inbred.',
    61, 75, 6.0, 8.0, NULL, 1),

  ('Ticto Barb', 'Pethia ticto', 'Beginner', 3.0, 0.01096, 3.00, 29, 6, NULL, false, 'peaceful',
    'Ticto barbs like cool water and usually do not need a heater. They are often confused with odessa barbs.',
    57, 72, 6.0, 7.0, NULL, 1),

  -- Rosy barb and its forms
  ('Rosy Barb', 'Pethia conchonius', 'Beginner', 3.5, 0.00891, 2.96, 29, 6, NULL, false, 'peaceful',
    'Rosy barbs are hardy and active, but small groups can get nippy with long-finned fish.',
    61, 75, 6.0, 8.0, NULL, 1.5),

  ('Neon Rosy Barb', 'Pethia conchonius (Neon)', 'Beginner', 3.5, 0.00891, 2.96, 29, 6, NULL, false, 'peaceful',
    'Neon rosy barbs are a brighter bred form of the rosy barb and prefer cooler water than most tropical fish.',
    61, 75, 6.0, 8.0, NULL, 1.5),

  -- Big barbs (4-7")
  ('Arulius Barb', 'Dawkinsia arulius', 'Intermediate', 4.75, 0.01072, 3.02, 55, 6, NULL, false, 'peaceful',
    'Arulius barbs prefer cooler water and need very clean, well-oxygenated water with some current.',
    66, 77, 6.0, 7.5, NULL, 1.2),

  ('Clown Barb', 'Barbodes everetti', 'Intermediate', 5.25, 0.01072, 3.02, 40, 6, NULL, false, 'peaceful',
    'Clown barbs need very clean, warm water and may nibble soft plants. They are best kept with fish their own size.',
    75, 86, 6.0, 7.0, NULL, 1),

  ('Denison Barb', 'Dawkinsia denisonii', 'Intermediate', 5.5, 0.01047, 3.02, 55, 6, NULL, false, 'peaceful',
    'Denison barbs, also sold as roseline sharks, need very clean, well-oxygenated water and a long tank.',
    59, 77, 6.5, 7.8, NULL, 1.15),

  ('Filament Barb', 'Dawkinsia filamentosa', 'Intermediate', 6.0, 0.00912, 2.98, 55, 6, NULL, false, 'peaceful',
    'Filament barb males grow long trailing fins on their back. They need very clean, well-oxygenated water and a long tank.',
    68, 77, 6.0, 7.0, NULL, 1.3),

  ('Spanner Barb', 'Striuntius lateristriga', 'Intermediate', 6.5, 0.00933, 2.99, 55, 6, NULL, false, 'semi-aggressive',
    'Spanner barbs get boisterous and pushy as they grow, and may eat very small fish. Keep them with robust tankmates their own size.',
    77, 82, 6.0, 7.5, 1, 1.15),

  -- Tinfoil barbs (9"+)
  ('Red Tailed Tinfoil Barb', 'Barbonymus altus', 'Intermediate', 9.0, 0.01047, 3.04, 150, 6, NULL, false, 'peaceful',
    'Red tailed tinfoil barbs are sold small but grow to about 9 inches and eat small fish. They need a very large tank as adults.',
    70, 81, 6.0, 7.5, 2, 1.6),

  ('Tinfoil Barb', 'Barbonymus schwanefeldii', 'Intermediate', 14.0, 0.01047, 3.01, 180, 5, NULL, false, 'peaceful',
    'Tinfoil barbs are sold small but grow over a foot long and eat small fish. They need a very large tank as adults.',
    72, 82, 6.0, 7.5, 2, 1.2),

  ('Gold Tinfoil Barb', 'Barbonymus schwanefeldii (Gold)', 'Intermediate', 14.0, 0.01047, 3.01, 180, 5, NULL, false, 'peaceful',
    'Gold tinfoil barbs are a color form of the tinfoil barb. They are sold small but grow over a foot long and eat small fish.',
    72, 82, 6.0, 7.5, 2, 1.2);




-- LIVEBEARERS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Guppy and its relatives
  ('Guppy', 'Poecilia reticulata', 'Beginner', 1.5, 0.01288, 3.14, 10, 5, NULL, NULL, 'peaceful',
    'Keep about 1 male guppy to every 2-3 females, or males may harass them.',
    72, 82, 6.8, 7.8, NULL, 1),

  ('Endler''s Livebearer', 'Poecilia wingei', 'Beginner', 1.0, 0.01318, 3.15, 10, 3, NULL, false, 'peaceful',
    'Endler''s livebearers are tiny, but they never stop moving and breed fast, so they need more room than their size suggests. Keep 2-3 females per male, and keep them away from guppies to avoid hybrids.',
    75, 82, 7.0, 8.5, NULL, 1.75),

  ('Swamp Guppy', 'Micropoecilia picta', 'Intermediate', 1.2, 0.01318, 3.15, 10, 3, NULL, false, 'peaceful',
    'Swamp guppies are tiny, but males court nonstop and they breed readily, so they need more room than their size suggests. Keep 2 or more females per male. They do best in slightly brackish water.',
    79, 82, 7.5, 8.2, NULL, 1.6),

  -- Platies
  ('Southern Platyfish', 'Xiphophorus maculatus', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful',
    'Platys prefer hard, mineral-rich water. Keep about 1 male to every 2-3 females so males don’t harass them.',
    68, 79, 7, 8, NULL, 1.35),

  ('Mickey Mouse Platy', 'Xiphophorus maculatus (Mickey Mouse)', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful',
    'Mickey mouse platies are hardy, but they eat a lot and breed often, so they need more room than their size suggests. Keep 2-3 females per male so the males do not wear the females out.',
    68, 79, 7.0, 8.0, NULL, 1.35),

  ('Red Wag Platy', 'Xiphophorus maculatus (Red Wag)', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful',
    'Red wag platies have a red body with black fins. They are hardy algae grazers, but they eat a lot and breed often, so they need more room than their size suggests.',
    68, 79, 7.0, 8.0, NULL, 1.35),

  ('Tuxedo Platy', 'Xiphophorus maculatus (Tuxedo)', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful',
    'Tuxedo platies have a black back half and stay healthiest in hard, alkaline water. Like all platies, they eat a lot and breed often, so they need more room than their size suggests.',
    68, 79, 7.0, 8.0, NULL, 1.35),

  ('Sunburst Platy', 'Xiphophorus maculatus (Sunburst)', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful',
    'Sunburst platies are bright yellow-orange and color up best with veggie foods in their diet. Like all platies, they eat a lot and breed often, so they need more room than their size suggests.',
    68, 79, 7.0, 8.0, NULL, 1.35),

  ('Hifin Platy', 'Xiphophorus maculatus (Hifin)', 'Beginner', 2, 0.01047, 3.14, 15, 5, NULL, false, 'peaceful',
    'Hifin platies have a tall back fin that fin nippers like tiger barbs target, so pick calm tankmates. Like all platies, they eat a lot and breed often, so they need more room than their size suggests.',
    68, 79, 7.0, 8.0, NULL, 1.35),

  ('Variatus Platy', 'Xiphophorus variatus', 'Beginner', 2.5, 0.01047, 3.14, 15, 3, NULL, false, 'peaceful',
    'Variatus platies are active, hungry fish that breed often, so they need more room than their size suggests. They handle cooler water than most livebearers and can live in unheated rooms.',
    68, 79, 7.0, 8.2, NULL, 1.35),

  -- Shortfin mollies
  ('Shortfin Molly', 'Poecilia sphenops', 'Intermediate', 4.0, 0.01514, 3.12, 20, 3, NULL, false, 'peaceful',
    'Mollies need hard, mineral-rich water. Keep about 1 male to every 2-3 females so males do not harass them.',
    75, 80, 7.0, 8.0, NULL, 0.7),

  ('Black Molly', 'Poecilia sphenops (Black)', 'Intermediate', 4.0, 0.01514, 3.12, 20, 3, NULL, false, 'peaceful',
    'Black mollies are sensitive to soft or acidic water. Shimmying or clamped fins is often a sign the water needs more minerals.',
    75, 80, 7.0, 8.0, NULL, 0.7),

  ('Gold Dust Molly', 'Poecilia sphenops (Gold Dust)', 'Intermediate', 4.0, 0.01514, 3.12, 20, 3, NULL, false, 'peaceful',
    'Gold dust mollies are a shortfin molly with gold and black coloring. They do best in hard, mineral-rich water and graze on algae between meals.',
    75, 80, 7.0, 8.0, NULL, 0.7),

  ('Platinum Molly', 'Poecilia sphenops (Platinum)', 'Intermediate', 4.0, 0.01514, 3.12, 20, 3, NULL, false, 'peaceful',
    'Platinum mollies are pale silver-white, so white spots from ich are harder to notice. Flashing or rubbing against decor is often an early sign.',
    75, 80, 7.0, 8.0, NULL, 0.7),

  ('Balloon Molly', 'Poecilia sphenops (Balloon)', 'Intermediate', 2.75, 0.01514, 3.12, 20, 3, NULL, false, 'peaceful',
    'Balloon mollies are short, but they eat and make waste like a full-size molly, so they need more room than their size suggests. Their shortened spine causes digestion problems, so feed small meals.',
    75, 80, 7.0, 8.0, NULL, 1.3),

  -- Sailfin mollies
  ('Sailfin Molly', 'Poecilia latipinna', 'Intermediate', 4.75, 0.01288, 3.06, 29, 3, NULL, false, 'peaceful',
    'Sailfin molly males need plenty of plant matter in their diet to grow full sails. They do best in hard, mineral-rich water and can also handle brackish water.',
    72, 82, 7.5, 8.5, NULL, 0.75),

  ('Dalmatian Molly', 'Poecilia latipinna (Dalmatian)', 'Intermediate', 4.75, 0.01288, 3.06, 29, 3, NULL, false, 'peaceful',
    'Dalmatian mollies are a spotted sailfin molly. They grow large, like hard, mineral-rich water, and do better with algae or veggie foods in their diet.',
    72, 82, 7.5, 8.5, NULL, 0.75),

  ('Lyretail Molly', 'Poecilia latipinna (Lyretail)', 'Intermediate', 4.75, 0.01288, 3.06, 29, 3, NULL, false, 'peaceful',
    'Lyretail mollies are a sailfin molly bred with a forked tail. Their long tail tips are a target for fin nippers and can fray in dirty water.',
    72, 82, 7.5, 8.5, NULL, 0.75),

  ('Creamsicle Molly', 'Poecilia latipinna (Creamsicle)', 'Intermediate', 4.75, 0.01288, 3.06, 29, 3, NULL, false, 'peaceful',
    'Creamsicle mollies are an orange and white lyretail sailfin. Males chase females a lot, so more females than males and some hiding spots help.',
    72, 82, 7.5, 8.5, NULL, 0.75),

  ('Giant Sailfin Molly', 'Poecilia velifera', 'Advanced', 6.0, 0.01318, 3.15, 40, 3, NULL, false, 'peaceful',
    'Giant sailfin mollies are more sensitive than other mollies and need very clean, hard water. Males only grow full sails in roomy tanks that are not overcrowded.',
    72, 82, 7.0, 8.5, NULL, 0.8),

  -- Swordtail and its forms
  ('Swordtail', 'Xiphophorus hellerii', 'Beginner', 4.5, 0.01000, 3.06, 29, 3, NULL, false, 'peaceful',
    'Swordtails prefer hard water. Keep only one male with several females, since males fight each other.',
    70, 80, 7.0, 8.0, NULL, 0.8),

  ('Red Swordtail', 'Xiphophorus hellerii (Red)', 'Beginner', 4.5, 0.01000, 3.06, 29, 3, NULL, false, 'peaceful',
    'Red swordtail males spar over females, and the losing male gets picked on. 1 male with 2 or more females works best.',
    70, 80, 7.0, 8.0, NULL, 0.8),

  ('Red Wag Swordtail', 'Xiphophorus hellerii (Red Wag)', 'Beginner', 4.5, 0.01000, 3.06, 29, 3, NULL, false, 'peaceful',
    'Red wag swordtails are active swimmers that enjoy some water flow. They can jump, so a lid helps.',
    70, 80, 7.0, 8.0, NULL, 0.8),

  ('Pineapple Swordtail', 'Xiphophorus hellerii (Pineapple)', 'Beginner', 4.5, 0.01000, 3.06, 29, 3, NULL, false, 'peaceful',
    'Pineapple swordtails are a bright bred color, and bright strains can be inbred. Look for full-bodied, active fish when buying.',
    70, 80, 7.0, 8.0, NULL, 0.8),

  ('Lyretail Swordtail', 'Xiphophorus hellerii (Lyretail)', 'Beginner', 4.5, 0.01000, 3.06, 29, 3, NULL, false, 'peaceful',
    'Lyretail swordtail males often cannot breed because their mating fin grows too long. Their long fins are also a target for fin nippers.',
    70, 80, 7.0, 8.0, NULL, 0.8),

  -- Limias
  ('Black Bellied Limia', 'Limia melanogaster', 'Beginner', 1.75, 0.00851, 3.15, 20, 6, NULL, false, 'peaceful',
    'Black bellied limias are active, and males chase females nonstop, so they need more room than their size suggests. Keep 1 male to 3 females. They like hard, alkaline water and veggie foods.',
    72, 82, 7.5, 8.5, NULL, 2),

  ('Humpback Limia', 'Limia nigrofasciata', 'Beginner', 2.5, 0.01995, 3.01, 20, 4, NULL, false, 'peaceful',
    'Humpback limias need hard, alkaline water and graze on algae, so an established tank helps. They jump when startled, so a lid is a good idea.',
    75, 82, 7.0, 8.4, NULL, 0.75),

  -- Halfbeaks
  ('Wrestling Halfbeak', 'Dermogenys pusilla', 'Intermediate', 2.5, 0.00398, 2.89, 20, 5, NULL, false, 'peaceful',
    'Wrestling halfbeaks all stay at the surface, and males fight over space there, so they need more room than their slim size suggests. Keep 2 females per male, and use a tight lid since they jump.',
    75, 82, 6.8, 8.0, NULL, 2.6),

  ('Celebes Halfbeak', 'Nomorhamphus liemi', 'Intermediate', 3.5, 0.00457, 3.03, 29, 4, NULL, false, 'peaceful',
    'Celebes halfbeaks all stay at the surface, and males fight each other, so they need more room than their size suggests. Keep 1 male with 2-3 females in a long tank with a tight lid, since they jump.',
    70, 79, 6.5, 8.0, 1, 2),

  -- Other livebearers
  ('Least Killifish', 'Heterandria formosa', 'Beginner', 1.2, 0.01000, 3.09, 10, 6, NULL, false, 'peaceful',
    'Least killifish are one of the smallest livebearers and easy prey for most fish, so they do best in a nano or species tank with gentle flow. Despite the name, they are not a true killifish.',
    68, 79, 7.0, 8.0, NULL, 0.83),

  ('Metallic Livebearer', 'Girardinus metallicus', 'Beginner', 2.25, 0.00851, 3.15, 10, 3, NULL, false, 'peaceful',
    'Metallic livebearers are sensitive to waste buildup, so regular water changes matter. Adults eat their fry, so dense plants help fry survive.',
    72, 79, 7.0, 8.0, NULL, 1),

  ('Mosquitofish', 'Gambusia affinis', 'Beginner', 2.75, 0.00851, 3.13, 10, 3, NULL, false, 'aggressive',
    'Mosquitofish are tough but nip fins and harass other small fish, so a species tank or pond works best. They are invasive and banned in some areas.',
    60, 80, 6.0, 8.0, NULL, 0.65),

  ('Merry Widow Livebearer', 'Phallichthys amates', 'Beginner', 3.0, 0.01000, 3.20, 20, 6, NULL, false, 'peaceful',
    'Merry widows are hardy and peaceful, and females can drop dozens of fry. Dense plants give fry a place to hide and cut down on males chasing females.',
    75, 80, 6.0, 8.0, NULL, 0.65),

  -- Goodeids
  ('Butterfly Goodeid', 'Ameca splendens', 'Intermediate', 3.5, 0.01202, 3.01, 25, 4, NULL, false, 'semi-aggressive',
    'Butterfly goodeid males can be aggressive and may nip slow fish like mollies. They eat hair algae and need some plant matter in their diet.',
    70, 80, 7.0, 8.0, NULL, 0.8);


-- GOURAMIS, BETTAS AND PARADISE FISH --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- Small gouramis (under 3")
  ('Sparkling Gourami', 'Trichopsis pumila', 'Intermediate', 1.5, 0.00977, 2.97, 10, 2, NULL, false, 'peaceful',
    'Sparkling gouramis are tiny, but males claim small territories and spar, so they need more room than their size suggests. They eat baby shrimp and need a lid to keep the air above the water warm.',
    72, 82, 5.5, 7.5, NULL, 2.5),

  ('Honey Gourami', 'Trichogaster chuna', 'Beginner', 2.0, 0.01479, 2.94, 10, NULL, NULL, false, 'peaceful',
    'Honey gouramis are shy, but males claim a spot near the surface and chase rivals, so they need more room than their size suggests. In a group, keep more females than males.',
    72, 82, 6.0, 7.5, NULL, 2.75),

  ('Sunset Honey Gourami', 'Trichogaster chuna (Sunset)', 'Beginner', 2.0, 0.01479, 2.94, 10, NULL, NULL, false, 'peaceful',
    'Sunset honey gouramis are a bright orange honey gourami. Males claim surface territory, so they need more room than their size suggests. "Red honey gouramis" are sometimes thick lipped gouramis, which grow bigger.',
    72, 82, 6.0, 7.5, NULL, 2.75),

  ('Chocolate Gourami', 'Sphaerichthys osphromenoides', 'Advanced', 2.5, 0.01995, 3.01, 20, 6, NULL, false, 'peaceful',
    'Chocolate gouramis need soft, acidic blackwater and are very sensitive to nitrates and sudden water changes. They often refuse dry food at first, so live or frozen food helps.',
    77, 86, 4.0, 6.5, NULL, 1),

  ('Croaking Gourami', 'Trichopsis vittata', 'Beginner', 2.75, 0.00977, 2.97, 10, NULL, NULL, false, 'peaceful',
    'Croaking gouramis croak at rivals, and males claim territories, so they need more room than their size suggests. They are timid and do best with calm tankmates and floating plants.',
    72, 82, 6.5, 7.5, NULL, 2),

  -- Dwarf gourami and its forms
  ('Dwarf Gourami', 'Trichogaster lalius', 'Intermediate', 3, 0.01445, 2.99, 10, NULL, NULL, false, 'peaceful',
    'Dwarf gouramis are prone to disease, so buy from a trusted store. Males are very territorial, so they need more room than their size suggests. Keep only one male per tank.',
    72, 81, 6, 7.5, NULL, 2),

  ('Powder Blue Dwarf Gourami', 'Trichogaster lalius (Powder Blue)', 'Intermediate', 3, 0.01445, 2.99, 10, NULL, NULL, false, 'peaceful',
    'Powder blue dwarf gouramis can carry an incurable virus, so quarantine new fish. Males are very territorial, so they need more room than their size suggests. Keep only one male per tank.',
    72, 81, 6, 7.5, NULL, 2),

  ('Flame Dwarf Gourami', 'Trichogaster lalius (Flame)', 'Intermediate', 3, 0.01445, 2.99, 10, NULL, NULL, false, 'peaceful',
    'Flame dwarf gouramis are a bred red dwarf gourami. Males are very territorial, so they need more room than their size suggests. Keep only one male per tank.',
    72, 81, 6, 7.5, NULL, 2),

  ('Neon Blue Dwarf Gourami', 'Trichogaster lalius (Neon Blue)', 'Intermediate', 3, 0.01445, 2.99, 10, NULL, NULL, false, 'peaceful',
    'Neon blue dwarf gouramis are a bright blue dwarf gourami. Males are very territorial, so they need more room than their size suggests. Keep only one male per tank, away from fin nippers.',
    72, 81, 6, 7.5, NULL, 2),

  -- Thick lipped and banded gouramis
  ('Thick Lipped Gourami', 'Trichogaster labiosa', 'Beginner', 3.5, 0.01622, 3.00, 20, NULL, NULL, false, 'peaceful',
    'Thick lipped gouramis are hardy and much less prone to the virus that kills many dwarf gouramis. Males claim territory when breeding, so they need more room than their size suggests.',
    72, 82, 6.0, 7.5, NULL, 2),

  ('Sunset Thick Lipped Gourami', 'Trichogaster labiosa (Sunset)', 'Beginner', 3.5, 0.01622, 3.00, 20, NULL, NULL, false, 'peaceful',
    'Sunset thick lipped gouramis, also sold as red robin gouramis, are often mislabeled as red honey gouramis but grow bigger. Males claim territory when breeding, so they need more room than their size suggests.',
    72, 82, 6.0, 7.5, NULL, 2),

  ('Banded Gourami', 'Trichogaster fasciata', 'Beginner', 4.0, 0.01549, 2.97, 20, NULL, NULL, false, 'peaceful',
    'Banded gouramis are hardy and calm, but males fight each other. A pair fits a 20 gallon, and a group needs 40 gallons or more. Keep them away from thick lipped gouramis to avoid hybrids.',
    70, 82, 6.0, 7.5, NULL, 1.44),

  -- Blue gourami and its forms
  ('Blue Gourami', 'Trichopodus trichopterus', 'Beginner', 5.0, 0.02089, 3.02, 30, NULL, NULL, false, 'semi-aggressive',
    'Blue gouramis, also sold as three spot gouramis, bully other gouramis and look-alike fish. Keep only 1 male per tank. Under 55 gallons, 1 fish is best. Bigger tanks can add several females.',
    72, 82, 6.0, 8.0, NULL, 1.44),

  ('Gold Gourami', 'Trichopodus trichopterus (Gold)', 'Beginner', 5.0, 0.02089, 3.02, 30, NULL, NULL, false, 'semi-aggressive',
    'Gold gouramis are a color form of the blue gourami and just as territorial. Keep only 1 male per tank, and just 1 fish under 55 gallons. They eat hydra and small snails, which helps with pests.',
    72, 82, 6.0, 8.0, NULL, 1.44),

  ('Opaline Gourami', 'Trichopodus trichopterus (Opaline)', 'Beginner', 5.0, 0.02089, 3.02, 30, NULL, NULL, false, 'semi-aggressive',
    'Opaline gouramis are a marbled blue gourami, and color-bred fish are often more aggressive. Keep only 1 male per tank. Under 55 gallons, 1 fish is best. Bigger tanks can add several females.',
    72, 82, 6.0, 8.0, NULL, 1.44),

  ('Platinum Gourami', 'Trichopodus trichopterus (Platinum)', 'Beginner', 5.0, 0.02089, 3.02, 30, NULL, NULL, false, 'semi-aggressive',
    'Platinum gouramis are a silver-white blue gourami and bully other gouramis and look-alike fish. Keep only 1 male per tank. Under 55 gallons, 1 fish is best. Bigger tanks can add several females.',
    72, 82, 6.0, 8.0, NULL, 1.44),

  -- Large gouramis (5-10")
  ('Pearl Gourami', 'Trichopodus leerii', 'Beginner', 5.0, 0.01622, 3.00, 29, NULL, NULL, false, 'peaceful',
    'Pearl gouramis are calm, but males fight each other, so keep only 1 male per tank. One or a pair fits a 30 gallon. A male with several females needs 55 gallons or more.',
    75, 86, 5.5, 7.5, NULL, 1.44),

  ('Moonlight Gourami', 'Trichopodus microlepis', 'Intermediate', 6.0, 0.01413, 3.00, 29, NULL, NULL, false, 'peaceful',
    'Moonlight gouramis grow about 6 inches and are peaceful but shy, so avoid fast tankmates and fin nippers. In a group, keep more females than males. They jump, may eat very small fish, and nibble soft plants.',
    77, 86, 6.0, 7.5, 1, 1),

  ('Snakeskin Gourami', 'Trichopodus pectoralis', 'Beginner', 10.0, 0.01413, 3.01, 55, NULL, NULL, false, 'peaceful',
    'Snakeskin gouramis grow 8 to 10 inches but are very peaceful and hardy. Bullies stress them, so keep calm tankmates. Groups need a big tank, and very small fish or shrimp may get eaten.',
    73, 84, 6.0, 8.4, 1, 1),

  ('Kissing Gourami', 'Helostoma temminckii', 'Intermediate', 10.0, 0.01995, 3.01, 75, NULL, NULL, false, 'semi-aggressive',
    'Kissing gouramis grow to about 10 inches, and their "kissing" is males fighting, not affection. They make a lot of waste and eat or uproot most live plants.',
    72, 82, 6.8, 8.5, NULL, 1.5),

  -- Giant gouramis (20"+)
  ('Giant Red Tail Gourami', 'Osphronemus laticlavius', 'Intermediate', 20.0, 0.01698, 3.01, 180, NULL, NULL, false, 'peaceful',
    'Giant red tail gouramis grow about 20 inches and are mostly plant eaters that need lots of vegetables. They are very messy and will eat small fish.',
    70, 84, 6.5, 7.8, 3, 1.5),

  ('Giant Gourami', 'Osphronemus goramy', 'Intermediate', 24.0, 0.01698, 3.01, 265, NULL, NULL, false, 'peaceful',
    'Giant gouramis are sold small but grow about 2 feet long and live over 20 years. They are very messy and will eat smaller fish.',
    68, 86, 6.5, 8.0, 3, 1.5),

  -- Bettas
  ('Betta', 'Betta splendens', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Bettas prefer gentle water flow. Bettas jump, so a lid is required.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Halfmoon Betta', 'Betta splendens (Halfmoon)', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Halfmoon bettas have heavy fins that tear easily and are more prone to fin rot and tail biting. Gentle flow and smooth decor help.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Plakat Betta', 'Betta splendens (Plakat)', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Plakat bettas have short fins, so they swim faster and rarely get fin rot or tail biting. They handle some water flow better than long-finned bettas.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Crowntail Betta', 'Betta splendens (Crowntail)', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Crowntail bettas have spiky fin rays that can curl in poor water, so regular water changes keep their fins looking sharp.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Veiltail Betta', 'Betta splendens (Veiltail)', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Veiltail bettas are one of the oldest and sturdiest betta types. Their long, trailing fins can get fin rot or snag on rough decor, so clean water and soft plants help.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Double Tail Betta', 'Betta splendens (Double Tail)', 'Intermediate', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Double tail bettas have a shortened body that squeezes their organs, so they are prone to bloating and swim bladder problems. Small meals help.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Dumbo Betta', 'Betta splendens (Dumbo)', 'Beginner', 2.6, 0.00977, 2.97, 5, NULL, 1, false, 'semi-aggressive',
    'Dumbo bettas, also called elephant ear bettas, have huge side fins that make them slow swimmers. Gentle flow and resting spots near the surface help.',
    72, 86, 6.0, 7.5, NULL, 1),

  ('Peaceful Betta', 'Betta imbellis', 'Intermediate', 2.25, 0.00977, 2.97, 10, NULL, NULL, false, 'peaceful',
    'Peaceful bettas are calmer than regular bettas, but males still fight each other in small tanks. They prefer soft, acidic water and need a gap under the lid to breathe air.',
    75, 82, 6.0, 7.0, NULL, 2),

  -- Paradise fish
  ('Paradise Fish', 'Macropodus opercularis', 'Beginner', 3.0, 0.01288, 2.97, 20, NULL, NULL, false, 'aggressive',
    'Paradise fish handle cool water and can live in unheated tanks. Males fight each other and can attack small or slow fish, so tankmates should be sturdy.',
    61, 82, 6.0, 8.0, 1, 3),

  ('Albino Paradise Fish', 'Macropodus opercularis (Albino)', 'Beginner', 3.0, 0.01288, 2.97, 20, NULL, NULL, false, 'aggressive',
    'Albino paradise fish are a pink-white form with red eyes. They are just as hardy and cold tolerant, and males fight each other.',
    61, 82, 6.0, 8.0, 1, 3),

  ('Blue Paradise Fish', 'Macropodus opercularis (Blue)', 'Beginner', 3.0, 0.01288, 2.97, 20, NULL, NULL, false, 'aggressive',
    'Blue paradise fish are a color form of the paradise fish. They are strong jumpers, so a tight-fitting lid matters.',
    61, 82, 6.0, 8.0, 1, 3),

  ('Round Tail Paradise Fish', 'Macropodus ocellatus', 'Beginner', 3.0, 0.01479, 2.91, 20, NULL, NULL, false, 'semi-aggressive',
    'Round tail paradise fish are true cold water fish that do best unheated, with a cooler winter period. Males get territorial when breeding.',
    50, 72, 6.0, 8.0, NULL, 1.75),

  ('Black Paradise Fish', 'Macropodus spechti', 'Beginner', 3.5, 0.01622, 2.97, 20, NULL, NULL, false, 'semi-aggressive',
    'Black paradise fish are hardy and handle a wide range of temperatures. Males fight each other, so a pair or 1 male with females works best.',
    68, 83, 6.0, 8.0, NULL, 1.75),

  -- Gourami relatives
  ('Climbing Perch', 'Anabas testudineus', 'Intermediate', 8.0, 0.02344, 2.93, 55, NULL, NULL, false, 'aggressive',
    'Climbing perch can crawl out of the water and travel over land, so a tight lid with a small air gap matters. They are predators that eat smaller fish.',
    72, 86, 5.5, 8.0, 2, 1);






-- DWARF CICHLIDS --

INSERT INTO species (name, scientific_name, skill_level, adult_size_inches, weight_a, weight_b, min_tank_gallons, min_group_size, max_group_size, avoid_pair, temperament, care_note, min_temp, max_temp, min_ph, max_ph, eats_fish_under_inches, waste_multiplier)
VALUES
  -- German blue ram and its forms
  ('German Blue Ram', 'Mikrogeophagus ramirezi', 'Intermediate', 2.25, 0.01445, 3.08, 20, NULL, NULL, false, 'peaceful',
    'German blue rams pair up for life, so keep a single pair rather than a trio, since the pair will chase the extra fish. They need warm water around 80-86°F, so most corys and cool water fish cannot share their tank. Only add them to a tank that has been running for a few months, since they are sensitive to dirty or changing water.',
    80, 86, 5.0, 7.0, NULL, 2.75),

  ('Electric Blue Ram', 'Mikrogeophagus ramirezi (Electric Blue)', 'Intermediate', 2.25, 0.01445, 3.08, 20, NULL, NULL, false, 'peaceful',
    'Electric blue rams are a bred form of the German blue ram, and they are more delicate, with weaker immune systems and shorter lives. Keep a single pair in warm water around 80-86°F, and only add them to a tank that has been running for a few months. Buy from a store that has had them for a while, since new arrivals often die in the first few weeks.',
    80, 86, 5.0, 7.0, NULL, 2.75),

  ('Gold Ram', 'Mikrogeophagus ramirezi (Gold)', 'Intermediate', 2.25, 0.01445, 3.08, 20, NULL, NULL, false, 'peaceful',
    'Gold rams are a yellow-gold form of the German blue ram and need the same warm water around 80-86°F. Keep a single pair rather than a trio, since the pair will chase the extra fish. Bred forms are weaker than regular rams, so clean, stable water matters even more.',
    80, 86, 5.0, 7.0, NULL, 2.75),

  ('Balloon Ram', 'Mikrogeophagus ramirezi (Balloon)', 'Intermediate', 1.75, 0.01445, 3.08, 20, NULL, NULL, false, 'peaceful',
    'Balloon rams are short, but they eat and make waste like a full-size ram. Their shortened spine squeezes their organs and causes swim bladder and digestion problems, so feed small meals. They swim slowly and lose out on food to fast tankmates, and they usually live shorter lives than regular rams.',
    80, 86, 5.0, 7.0, NULL, 4.1),

  -- Cockatoo dwarf cichlid and its forms
  ('Cockatoo Dwarf Cichlid', 'Apistogramma cacatuoides', 'Beginner', 3.0, 0.01820, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Cockatoo cichlids are one of the hardiest apistos and handle a wider pH range than most. Keep 1 male with 1-3 females and give each female her own cave, since she defends it hard while raising fry. Do not mix them with other apisto species.',
    72, 84, 6.0, 8.0, NULL, 1.5),

  ('Double Red Cockatoo Dwarf Cichlid', 'Apistogramma cacatuoides (Double Red)', 'Beginner', 3.0, 0.01820, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Double red cockatoos are a bred form with red-orange fins. Tank-bred strains like this adapt to a wider range of water than wild fish. Keep 1 male with 1-3 females and give each female her own cave, and feed a varied diet to keep the red color strong.',
    72, 84, 6.0, 8.0, NULL, 1.5),

  ('Orange Flash Cockatoo Dwarf Cichlid', 'Apistogramma cacatuoides (Orange Flash)', 'Beginner', 3.0, 0.01820, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Orange flash cockatoos are a bred form with orange fin tips and face stripes. Keep 1 male with 1-3 females, give each female her own cave, and do not mix them with other apisto species. Females turn bright yellow and black when guarding eggs, which is normal.',
    72, 84, 6.0, 8.0, NULL, 1.5),

  -- Agassiz's dwarf cichlid and its forms
  ('Agassiz''s Dwarf Cichlid', 'Apistogramma agassizii', 'Intermediate', 2.75, 0.01778, 2.98, 20, NULL, NULL, false, 'peaceful',
    'Agassiz''s dwarf cichlids need soft, acidic water and a cave for each female, and leaf litter helps them feel safe. Keep 1 male with 2-3 females, since males fight each other. Colors vary a lot between strains.',
    75, 84, 5.0, 7.0, NULL, 1.6),

  ('Fire Red Agassiz''s Dwarf Cichlid', 'Apistogramma agassizii (Fire Red)', 'Intermediate', 2.75, 0.01778, 2.98, 20, NULL, NULL, false, 'peaceful',
    'Fire red agassizii are a bred form where males get bright red-orange tails, while females stay yellow and much plainer. They still need soft, acidic water and a cave for each female. Keep 1 male with 2-3 females, since males fight each other.',
    75, 84, 5.0, 7.0, NULL, 1.6),

  ('Double Red Agassiz''s Dwarf Cichlid', 'Apistogramma agassizii (Double Red)', 'Intermediate', 2.75, 0.01778, 2.98, 20, NULL, NULL, false, 'peaceful',
    'Double red agassizii are a bred form with red in both the tail and the top fin. Like other agassizii, they need soft, acidic water, leaf litter, and a cave for each female. Keep 1 male with 2-3 females, since males fight each other.',
    75, 84, 5.0, 7.0, NULL, 1.6),

  -- Borelli's dwarf cichlid and its forms
  ('Borelli''s Dwarf Cichlid', 'Apistogramma borellii', 'Beginner', 2.25, 0.02138, 2.99, 15, NULL, NULL, false, 'peaceful',
    'Borelli''s dwarf cichlids are one of the calmest apistos and like cooler water than most, so they fit well with corys. A pair or 1 male with 2 females works best, each with a small cave.',
    68, 79, 6.0, 8.0, NULL, 2),

  ('Opal Borelli''s Dwarf Cichlid', 'Apistogramma borellii (Opal)', 'Beginner', 2.25, 0.02138, 2.99, 15, NULL, NULL, false, 'peaceful',
    'Opal borelli''s are the common store form, with shiny blue males and yellow heads. They like cooler water than most apistos, so they fit well with corys. A pair or 1 male with 2 females works best, each with a small cave.',
    68, 79, 6.0, 8.0, NULL, 2),

  -- Other apistogramma
  ('Macmaster''s Dwarf Cichlid', 'Apistogramma macmasteri', 'Intermediate', 2.5, 0.01820, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Macmaster''s dwarf cichlids need soft water and a steady temperature. Keep 1 male with 2-3 females and a cave for each female. Wild caught fish are fussier than tank raised ones.',
    75, 82, 5.5, 7.0, NULL, 1.75),

  ('Viejita Dwarf Cichlid', 'Apistogramma viejita', 'Intermediate', 2.5, 0.01820, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Many fish sold as viejita are really macmaster''s dwarf cichlids, so check that males have a dark edge along the top of the back fin. They need soft water and a mature tank, since they are sensitive to waste buildup. Keep 1 male with 2-3 females and a cave for each female.',
    72, 82, 5.0, 7.0, NULL, 1.75),

  ('Hongsloi Dwarf Cichlid', 'Apistogramma hongsloi', 'Beginner', 2.75, 0.01820, 2.99, 15, NULL, NULL, false, 'peaceful',
    'Hongsloi dwarf cichlids pair up and raise their fry together, so keep a single pair rather than a male with several females. They like soft, slightly acidic water, leaf litter, and gentle filter flow. A female guarding fry can get very aggressive in a small tank.',
    73, 84, 5.5, 7.0, NULL, 1.75),

  ('Three-Striped Dwarf Cichlid', 'Apistogramma trifasciata', 'Intermediate', 2.25, 0.01820, 2.99, 15, NULL, NULL, false, 'peaceful',
    'Three-striped dwarf cichlids are one of the smaller apistos, named for the extra stripe that runs along the belly. Keep 1 male with 2-3 females and a cave for each female. Tank-bred fish handle neutral water, but wild ones need very soft, acidic water.',
    72, 81, 5.0, 7.0, NULL, 2.2),

  ('Panda Dwarf Cichlid', 'Apistogramma nijsseni', 'Intermediate', 2.75, 0.01820, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Panda dwarf cichlids do best as a pair, or as 1 male with 2-3 females in a bigger tank, since males fight each other. They need very soft, acidic water and a steady temperature, plus caves and plants that block lines of sight so each fish can claim its own spot. Females are bright yellow with black spots, while males are bluish with a red edge on the tail.',
    75, 82, 5.0, 6.5, NULL, 2.5),

  ('Inca Dwarf Cichlid', 'Apistogramma baenschi', 'Intermediate', 2.5, 0.01820, 2.99, 30, NULL, NULL, false, 'peaceful',
    'Inca dwarf cichlids, often sold as Inka 50, need soft, acidic water, and their eggs only develop in very soft water. Keep 1 male with 2-3 females and a cave for each, since males claim large territories and chase other males. Only add them to a well-established tank, since they are sensitive to waste buildup.',
    72, 79, 5.0, 6.5, NULL, 1.75),

  -- Kribensis
  ('Kribensis', 'Pelvicachromis pulcher', 'Beginner', 3.5, 0.01445, 2.99, 30, NULL, NULL, false, 'semi-aggressive',
    'Kribensis pair up, so keep a single pair rather than a trio, since the pair will chase the extra fish. A breeding pair gets very territorial with other fish too, especially bottom dwellers like corys. They dig pits in sand and may uproot plants, so give them a cave.',
    75, 81, 6.0, 8.0, NULL, 2.25),

  ('Albino Kribensis', 'Pelvicachromis pulcher (Albino)', 'Beginner', 3.5, 0.01445, 2.99, 30, NULL, NULL, false, 'semi-aggressive',
    'Albino kribensis are a white form with red eyes, and their weaker eyesight makes them prefer dimmer light and plenty of cover. Keep a single pair rather than a trio, since the pair will chase the extra fish. A breeding pair gets very territorial, especially with bottom dwellers like corys.',
    75, 81, 6.0, 8.0, NULL, 2.25),

  ('Striped Kribensis', 'Pelvicachromis taeniatus', 'Beginner', 3.0, 0.01445, 2.99, 20, NULL, NULL, false, 'peaceful',
    'Keep striped kribensis as a single pair with a cave like a clay pot, since more than one pair needs a big tank. They are shy, so avoid big or pushy tankmates, and keep corys and other bottom dwellers out while they breed. Named forms like Nigeria Red and Moliwe should not be mixed, so buy a male and female of the same form.',
    72, 79, 6.0, 7.5, NULL, 2.3),

  -- Other South American dwarf cichlids
  ('Keyhole Cichlid', 'Cleithracara maronii', 'Beginner', 3.5, 0.03548, 3.11, 30, NULL, NULL, false, 'peaceful',
    'Keyhole cichlids pair up as adults, so keep a single pair rather than a trio. They are very shy and do best with calm schooling fish like tetras, since boisterous tankmates stress them. They rarely dig and leave plants alone, but need a mature tank with clean water.',
    72, 80, 6.0, 7.5, NULL, 1),

  ('Checkerboard Cichlid', 'Dicrossus filamentosus', 'Advanced', 2.75, 0.01995, 3.01, 20, NULL, NULL, false, 'peaceful',
    'Checkerboard cichlids need warm, very soft, acidic water, and their eggs will not hatch above about pH 5.8. They are shy and do best in a dim, heavily planted tank with calm tankmates. Keep 1 male with 2-3 females.',
    77, 84, 5.0, 6.5, NULL, 1.45),

  ('Golden Dwarf Cichlid', 'Nannacara anomala', 'Beginner', 2.5, 0.01445, 3.08, 20, NULL, NULL, false, 'peaceful',
    'Golden dwarf cichlids are peaceful, but a female guarding fry will attack fish much bigger than her. Keep 1 male with 2 or more females, giving each female about 16 by 16 inches of floor space. Males grow much bigger than females.',
    72, 81, 6.0, 7.5, NULL, 2.4),

  ('Flag Cichlid', 'Laetacara curviceps', 'Beginner', 2.75, 0.02138, 3.05, 20, NULL, NULL, false, 'peaceful',
    'Flag cichlids do best as a single male and female pair, so buy a pair that has already formed if you can. Growing up a group to let a pair form only works in a big tank, since the pair can turn on the others. Both parents guard the eggs and fry and get territorial while breeding, and they like plants, leaf litter, and gentle flow.',
    72, 79, 5.5, 7.5, NULL, 2),

  ('Red Breasted Acara', 'Laetacara dorsigera', 'Beginner', 3.0, 0.03020, 3.05, 30, NULL, NULL, false, 'peaceful',
    'Red breasted acaras do best as a single pair, but males can be rough with females, so give plenty of plants and wood where she can hide. Both sexes only show the red breast and cheeks when breeding, and they are often sold mislabeled as flag cichlids. They are known to jump, so a lid helps.',
    68, 79, 5.0, 7.5, NULL, 1.5),

  -- West African dwarf cichlids
  ('African Butterfly Cichlid', 'Anomalochromis thomasi', 'Beginner', 2.75, 0.01445, 2.99, 30, NULL, NULL, false, 'peaceful',
    'African butterfly cichlids are shy and peaceful, and do well as a pair or a small group in a 30 gallon or bigger. Avoid fast, pushy tankmates, since they are shy. They need flat stones or broad leaves to spawn on, and a breeding pair digs small pits in the sand and guards the area around it.',
    73, 81, 6.0, 7.5, NULL, 1.95),

  -- Shell dwellers
  ('Multie Shell Dweller', 'Neolamprologus multifasciatus', 'Beginner', 1.5, 0.01862, 3.02, 10, NULL, NULL, false, 'semi-aggressive',
    'Multies live in empty snail shells, so give them at least 2-3 shells per fish on at least 2 inches of sand. They need hard, alkaline water, which rules out most community fish. They defend their shells against much bigger fish, and floor space matters more than gallons.',
    75, 81, 7.5, 9.0, NULL, 1.3),

  ('Similis Shell Dweller', 'Neolamprologus similis', 'Beginner', 1.75, 0.00389, 3.12, 10, NULL, NULL, false, 'semi-aggressive',
    'Similis live in empty snail shells, so give them at least 2-3 shells per fish on open, fine sand. They need hard, alkaline water, which rules out most soft-water fish. They defend their shell hard enough to nip hands, so keep more females than males to cut down on fighting.',
    75, 81, 7.5, 9.0, NULL, 2.2),

  ('Ocellatus Shell Dweller', 'Neolamprologus ocellatus', 'Beginner', 2.0, 0.01862, 3.02, 20, NULL, NULL, false, 'semi-aggressive',
    'Ocellatus live in empty snail shells and bury them, so give them at least 2-3 shells per fish on at least 2 inches of sand. They are more aggressive than other common shell dwellers and may attack them, so keep them as the only kind of shell dweller in the tank. They need hard, alkaline water and more females than males.',
    73, 81, 7.5, 9.0, NULL, 1.6),

  ('Gold Ocellatus Shell Dweller', 'Neolamprologus ocellatus (Gold)', 'Beginner', 2.0, 0.01862, 3.02, 20, NULL, NULL, false, 'semi-aggressive',
    'Gold ocellatus are a popular gold form of the ocellatus shell dweller and just as feisty, so keep them as the only kind of shell dweller in the tank. Give them at least 2-3 shells per fish on at least 2 inches of sand, and hard, alkaline water. Males grow much bigger than females, so keep more females than males.',
    73, 81, 7.5, 9.0, NULL, 1.6);


	

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
  -- Nano
  ('2.5 gallon', 2.5),
  ('5 gallon', 5),
  ('5.5 gallon', 5.5),

  -- Small
  ('10 gallon', 10),
  ('15 gallon', 15),
  ('15 gallon tall', 15),
  ('20 gallon long', 20),
  ('20 gallon tall', 20),
  ('20 gallon extra tall', 20),
  ('25 gallon', 25),
  ('29 gallon', 29),

  -- Bowfront
  ('16 gallon bowfront', 16),
  ('26 gallon bowfront', 26),
  ('36 gallon bowfront', 36),
  ('46 gallon bowfront', 46),
  ('72 gallon bowfront', 72),

  -- Hexagon and Corner
  ('10 gallon hexagon', 10),
  ('20 gallon hexagon', 20),
  ('35 gallon hexagon', 35),
  ('60 gallon hexagon', 60),
  ('54 gallon corner', 54),
  ('92 gallon corner', 92),

  -- Medium
  ('30 gallon', 30),
  ('30 gallon breeder', 30),
  ('33 gallon long', 33),
  ('37 gallon', 37),
  ('38 gallon', 38),
  ('40 gallon breeder', 40),
  ('40 gallon long', 40),
  ('45 gallon', 45),
  ('50 gallon', 50),
  ('55 gallon', 55),
  ('60 gallon', 60),
  ('60 gallon breeder', 60),
  ('65 gallon', 65),

  -- Large
  ('75 gallon', 75),
  ('90 gallon', 90),
  ('100 gallon', 100),
  ('110 gallon', 110),
  ('120 gallon', 120),
  ('125 gallon', 125),
  ('150 gallon', 150),
  ('180 gallon', 180),
  ('210 gallon', 210),
  ('225 gallon', 225),
  ('265 gallon', 265),
  ('300 gallon', 300);


-- ============================================
-- CHECK + RESET
-- ============================================
-- To reset, run only the two DROP lines below by hand.

SELECT * FROM species;
SELECT * FROM tank_sizes;

-- DROP TABLE IF EXISTS species;
-- DROP TABLE IF EXISTS tank_sizes;