SELECT *
FROM PokemonData;


-- Standardize column data types
-- Convert string-based boolean fields into proper BIT types (0 = false, 1 = true)
-- This ensures consistent data types for future filtering and analysis
ALTER TABLE PokemonData
ALTER COLUMN Is_Legendary BIT;

ALTER TABLE PokemonData
ALTER COLUMN Is_Mythical BIT;

ALTER TABLE PokemonData
ALTER COLUMN Is_Ultra_Beast BIT;


-- Fix blank secondary types
-- Clean up secondary type data by setting blank or missing Type_2 values to NULL
-- This helps accurately distinguish between single-type and dual-type Pokémon
UPDATE PokemonData
SET Type_2 = NULL
WHERE Type_2 IS NULL
		OR Type_2 = '';


-- Retrieve the top 10 strongest Pokémon based on total base stats
SELECT TOP 10
		ID,
		Name,
		Base_Stats
FROM PokemonData
ORDER BY Base_Stats DESC,
				Name ASC;


-- Find average HP, Attack, and Speed by primary type
-- Calculate the average HP, Attack, and Speed for each primary type
-- This helps identify how different types generally perform in key stats
SELECT Type_1,
		AVG(HP) AS AverageHealth, 
		AVG(Attack) AS AverageAttack,
		AVG(Speed) AS AverageSpeed
FROM PokemonData
GROUP BY Type_1
ORDER BY Type_1


-- Find the most common primary type across all generations
-- Identify the most frequently occurring primary type among all Pokémon
-- Uses COUNT to determine frequency and returns only the top result
SELECT TOP 1
		Type_1,
		COUNT(Type_1) AS NumberOfPokemon
FROM PokemonData
GROUP BY Type_1
ORDER BY NumberOfPokemon DESC


-- Count how many Pokémon are single-type (no secondary type) vs dual-type (has a secondary type)
-- Uses CASE statements to differentiate between NULL and non-NULL values in the Type_2 column
SELECT COUNT(CASE WHEN Type_2 IS NULL THEN 1 END) AS NumSingleType,
		COUNT(CASE WHEN Type_2 IS NOT NULL THEN 1 END) AS NumDualType
FROM PokemonData;


-- List Pokémon that are weak to 3 or more types (i.e., with 2x or higher weakness)
-- Identify Pokémon that have significant type disadvantages
-- Specifically, this selects Pokémon that are weak (2x or more damage) to at least 3 different types
-- Each weakness column is checked, and a count is summed using CASE statements
-- Only those with 3 or more weaknesses at or above 2x effectiveness are returned
SELECT Name,
    normal_weakness,
    fire_weakness,
    water_weakness,
    electric_weakness,
    grass_weakness,
    ice_weakness,
    fighting_weakness,
    poison_weakness,
    ground_weakness,
    flying_weakness,
    psychic_weakness,
    bug_weakness,
    ghost_weakness,
    dragon_weakness,
    dark_weakness,
    steel_weakness,
    fairy_weakness
FROM PokemonData
WHERE (
    CASE WHEN normal_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN fire_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN water_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN electric_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN grass_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN ice_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN fighting_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN poison_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN ground_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN flying_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN psychic_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN bug_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN ghost_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN dragon_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN dark_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN steel_weakness >= 2 THEN 1 ELSE 0 END +
    CASE WHEN fairy_weakness >= 2 THEN 1 ELSE 0 END
) >= 3;


-- Identify Pokémon with strong type resistances
-- This query selects Pokémon that resist at least 5 types (0.5x damage or less)
-- Each weakness column is evaluated, counting how many types deal reduced damage
-- Only Pokémon with 5 or more resistances are included in the result
SELECT Name,
    normal_weakness,
    fire_weakness,
    water_weakness,
    electric_weakness,
    grass_weakness,
    ice_weakness,
    fighting_weakness,
    poison_weakness,
    ground_weakness,
    flying_weakness,
    psychic_weakness,
    bug_weakness,
    ghost_weakness,
    dragon_weakness,
    dark_weakness,
    steel_weakness,
    fairy_weakness
FROM PokemonData
WHERE (
    CASE WHEN normal_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN fire_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN water_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN electric_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN grass_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN ice_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN fighting_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN poison_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN ground_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN flying_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN psychic_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN bug_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN ghost_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN dragon_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN dark_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN steel_weakness <= 0.5 THEN 1 ELSE 0 END +
    CASE WHEN fairy_weakness <= 0.5 THEN 1 ELSE 0 END
) >= 5;


-- Determine which generation of Pokémon has the strongest average stats
-- Calculates the average total base stats (HP + Attack + Defense + etc.) for each generation
-- Orders the result from highest to lowest to highlight the top-performing generation
SELECT gen, 
		AVG(Base_Stats) AverageBaseStats
FROM PokemonData
GROUP BY gen
ORDER BY AverageBaseStats DESC


-- Identify Pokémon that are strong stat-wise (Base_Stats > 500) but have low capture rate (e.g., < 50)
-- Find powerful but hard to catch Pokémon
-- Filters for Pokémon with total base stats greater than 500 (indicating strength)
-- and a capture rate below 50 (indicating they are more difficult to catch)
SELECT ID,
		Name,
		Base_stats,
		capturing_rate
FROM PokemonData
WHERE (Base_stats > 500 and capturing_rate < 50)


-- Retrieve all Legendary or Mythical Pokémon that have "Flying" as one of their types
-- This filters for Pokémon marked as Legendary or Mythical
-- and includes only those where either Type_1 or Type_2 is "Flying"
SELECT ID,
		Name,
		Type_1,
		Type_2,
		Is_Legendary,
		Is_Mythical
FROM PokemonData
WHERE (Is_Legendary = 1 OR Is_Mythical = 1) 
		AND (Type_1 = 'Flying' OR Type_2 = 'Flying')


-- List all Pokémon with Speed greater than 100 that are neither Legendary nor Mythical
-- Filters out special-status Pokémon to highlight fast regular Pokémon only
-- Useful for competitive play, high speed non-legends
SELECT ID,
		NAME,
		Speed,
		Is_Legendary,
		Is_Mythical
FROM PokemonData
WHERE Speed > 100
		AND (Is_Legendary = 0 AND Is_Mythical = 0)


