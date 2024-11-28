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
midfielder_condition AS (
    SELECT
        mpc.player_name,
        mpc.position,
        mpc.minutes_played,
        atte.total_attempts,
        def.balls_recoverd,
        disc.red,
        disc.yellow,
        dist.pass_accuracy,
        dist.cross_accuracy
    FROM minutes_played_condition AS mpc
    JOIN ucl21_22.distributon AS dist ON mpc.id_player = dist.id_player
    JOIN ucl21_22.attempts AS atte ON mpc.id_player = atte.id_player
    JOIN ucl21_22.defending AS def ON mpc.id_player = def.id_player
    JOIN ucl21_22.disciplinary AS disc ON mpc.id_player = disc.id_player
    WHERE disc.red = 0
        AND disc.yellow <= 4
        AND (def.balls_recoverd >= 4 OR atte.total_attempts >= 4)
        AND dist.pass_accuracy > 60
        AND dist.cross_accuracy > 50
)
SELECT
    player_name,
    position,
    minutes_played,
    yellow,
    red,
    total_attempts,
    balls_recoverd,
    pass_accuracy,
    cross_accuracy
FROM midfielder_condition
WHERE position = 'Midfielder'
ORDER BY player_name;
