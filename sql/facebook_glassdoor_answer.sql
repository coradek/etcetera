
/*
QUESTION:
You have a table with (date - ignored for now) user_id,
song_id and count.

It shows at the end of each day how many times in her history a user
has listened to a given song. So count is cumulative sum.

You have to update this on a daily basis based on a second table that
records in real time when a user listens to a given song.
Basically, at the end of each day, you go to this second table
and pull a count of each user/song combination and then add this count
to the first table that has the lifetime count. If it is the first
time a user has listened to a given song, you won't have this pair in
the lifetime table, so you have to create the pair there and then add
the count of the last day


ANSWER:
Final LifeCount Table -

SELECT * FROM lifecount
ORDER BY num ASC;

 user_id | song_id | num
---------+---------+-----
       1 |       1 |   5
       1 |       2 |   6
       1 |       3 |   7
       2 |       1 |   8
       2 |       2 |   9
       2 |       4 |  10
       3 |       5 |  11
       4 |       1 |  12

*/


-- SOLUTIONS (without the date bit)
-- MYSQL
REPLACE INTO LifeCount
  SELECT D.user_id, D.song_id
           , IFNULL(L.num,0) +  IFNULL(D.c,0) as num
	FROM
	(
	SELECT user_id, song_id, COUNT(song_id) as c
	FROM DailyCount
	GROUP BY user_id, song_id
	) as D
	LEFT JOIN -- left join ensures all user/song pairs from D
            -- pairs not yet in L will have null 'num' value
	LifeCount as L
	ON D.user_id = L.user_id AND D.song_id = L.song_id
;


-- PSQL
WITH RECURSIVE
  T AS ( -- get sum of todays entries
    SELECT user_id, song_id, Count(*) as num
    FROM DailyCount
    GROUP BY user_id, song_id
    ORDER BY user_id, song_id
  )
, T2 AS ( -- create table of updated values
    SELECT T.user_id, T.song_id -- , L.user_id, L.song_id,
         , Coalesce(T.num, 0) + Coalesce(L.num, 0) as total_count
    FROM T LEFT JOIN LifeCount L
    ON T.user_id = L.user_id AND T.song_id = L.song_id
  )

INSERT INTO LifeCount
  (SELECT * FROM T2)
ON CONFLICT(user_id, song_id)
DO UPDATE SET
  num = EXCLUDED.num
;


----------------------------------------------------
----------------------------------------------------
-- EXTRAS


-- Run this query for a better view of values being added
-- JOIN solution
SELECT D.user_id, D.song_id, L.num, D.c
       , COALESCE(L.num,0) +  COALESCE(D.c,0) as tot
FROM
(
SELECT user_id, song_id, COUNT(song_id) as c
FROM DailyCount
GROUP BY user_id, song_id
) as D
LEFT JOIN -- left join ensures all user/song pairs from D
          -- pairs not yet in L will have null num value
LifeCount as L
ON D.user_id = L.user_id AND D.song_id = L.song_id
;


-- SEE RESULTS (UNION VERSION)
WITH RECURSIVE
  T AS (
  SELECT user_id, song_id, Count(*) as num
  FROM DailyCount
  GROUP BY user_id, song_id
  -- ORDER BY user_id, song_id
  )
, T2 as (
  SELECT * FROM T
  UNION -- ALL
  SELECT * FROM LifeCount
  )

SELECT user_id, song_id, sum(num)
FROM T2
GROUP BY user_id, song_id
ORDER BY user_id, song_id


-- SELECT user_id, song_id, sum(num) as new_total
-- FROM
-- (
--    SELECT user_id, song_id, num
--    FROM
--        LifeCount
--    UNION ALL
--        SELECT user_id, song_id, COUNT(song_id) as num
--        FROM DailyCount
--        GROUP BY user_id, song_id
-- )
-- GROUP BY user_id, song_id
-- ;


-- NOTE:
-- without the unique index, the insert or replace command would
-- create new rows with user/song pairs already in the LifeCount table

-- QUESTION: Is the unique index needed for PSQL?
-- since the conflict is specified in the 'ON CONFLICT()' clause
