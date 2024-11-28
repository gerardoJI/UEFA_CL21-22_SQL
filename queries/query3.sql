WITH minutes_played_condition AS (
    SELECT
        m.id_player,
        m.player_name,
        m.position,
        k.minutes_played
    FROM ucl21_22.main AS m
    JOIN ucl21_22.key_stats AS k ON m.id_player = k.id_player
    WHERE k.minutes_played > (SELECT AVG(k.minutes_played) FROM ucl21_22.key_stats AS k)
),
defender_condition AS (
    SELECT
        mpc.player_name,
        mpc.position,
        mpc.minutes_played,
        def.balls_recoverd,
        disc.red,
        disc.yellow,
        def.t_won,
        dist.pass_accuracy
    FROM minutes_played_condition AS mpc
    JOIN ucl21_22.defending AS def ON mpc.id_player = def.id_player
    JOIN ucl21_22.distributon AS dist ON mpc.id_player = dist.id_player
    JOIN ucl21_22.disciplinary AS disc ON mpc.id_player = disc.id_player
    WHERE disc.red = 0
        AND disc.yellow <= 4
        AND def.balls_recoverd >= 30
        AND def.t_won >= 5
        AND dist.pass_accuracy > 60
)
SELECT
    player_name,
    position,
    minutes_played,
    yellow,
    red,
    balls_recoverd,
    pass_accuracy,
    t_won
FROM defender_condition
WHERE position = 'Defender'
ORDER BY player_name;
