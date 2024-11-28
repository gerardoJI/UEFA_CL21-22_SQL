-- -------------------------------------------------------------------------------------------------
-- ---------------------- Choosing fordward:----------------------------------------------------------
-- -------------------------------------------------------------------------------------------------
WITH minutes_played_condition AS (
    -- CTE Query to get all players with at least 450 minutes played
    SELECT  -- columns to get after join (3)
        m.id_player,
        m.player_name,
        m.position,
        k.minutes_played
    FROM ucl21_22.main AS m -- Table 1 to join (1)
    JOIN ucl21_22.key_stats AS k ON m.id_player = k.id_player -- Table 2 to join (inner) (2)
    WHERE k.minutes_played > (SELECT AVG(k.minutes_played) as minutes_played_mean FROM ucl21_22.key_stats AS k)
    -- in WHERE is defined the condition minutes played over the average, using subqueries (4)
),
fordward_condition AS (
    -- CTE Query to get all players with no red cards and up to 3 yellow cards
    SELECT -- columns to get after join (10)
        mpc.player_name,
        mpc.position,
        mpc.minutes_played,
        atte.total_attempts,
        disc.red,
        disc.yellow,
        g.goals
    FROM minutes_played_condition AS mpc --  Select table generated by CTE minutes_played_condition (5)
    JOIN ucl21_22.goals AS g ON mpc.id_player = g.id_player -- Join goals table according to id_player (6)
    JOIN ucl21_22.attempts AS atte ON mpc.id_player = atte.id_player -- Join attempts table according to id_player (7)
    JOIN ucl21_22.attacking AS atta ON mpc.id_player = atta.id_player -- Join attacking table according to id_player (8)
    JOIN ucl21_22.disciplinary AS disc ON mpc.id_player = disc.id_player-- Join disciplinary table according to id_player (9)
    
    -- in WHERE, are defined the conditions applied to data (11)
    WHERE disc.red =0  -- No red cards
		AND disc.yellow <= 4  -- Up to 4 yellow cards
		AND (g.goals>=1 OR atte.total_attempts>10) -- At least one goal or one assisst
)

-- Final query to select players who meet the conditions
SELECT player_name, position, minutes_played, yellow, red, goals, total_attempts -- columns to get (13)
FROM fordward_condition -- From fordward_condition table (12)
WHERE position = 'Forward' -- condition to select fordwards only (14)
ORDER BY player_name; -- sort data by player name(15)