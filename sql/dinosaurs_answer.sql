/*
Sites:
id |        name
----+--------------------
 0 | Kem Kem Beds
 1 | Orapa
 2 | Seymour Island
 3 | Vega Island
 4 | Cerro del Pueblo


Finds:
id | site_id | bone_id | date_found
----+---------+---------+------------
 8 |       3 |      36 | 2016-02-11
 9 |       9 |      18 | 2015-05-21
10 |       8 |       1 | 2014-05-19

Dino_Bones:
id |     name     |  anatomy
----+--------------+------------
30 | Velociraptor | rib
31 | Velociraptor | femur
32 | Velociraptor | metacarpal
33 | Velociraptor | metatarsal
34 | Velociraptor | pelvis

QUESTION 1:
Find names of the top 3 sites for Velociraptor Bones for 2014

ANSWER:
       name        | num
--------------------+-----
Hilda mega-bonebed |   6
Como Bluff         |   5
Orapa              |   4       # These three sites tie for third
Seymour Island     |   4       # Answers may vary depending
Ellisdale          |   4       # on how duplicates are handled

QUESTION 2: (advanced: requires window functions)
Find names of the top 3 sites each year for Velociraptor Bones

       site        | year | find_rank | find_count
--------------------+------+-----------+------------
Hilda mega-bonebed | 2014 |         1 |          6
Como Bluff         | 2014 |         2 |          5
Seymour Island     | 2014 |         3 |          4
Ellisdale          | 2014 |         3 |          4
Orapa              | 2014 |         3 |          4
Orapa              | 2015 |         1 |          6
Seymour Island     | 2015 |         1 |          6
Cantwell Formation | 2015 |         3 |          4
Cantwell Formation | 2016 |         1 |          7
Hilda mega-bonebed | 2016 |         2 |          6
Orapa              | 2016 |         3 |          4
Cerro del Pueblo   | 2016 |         3 |          4
*/


-- QUESTION 1:
SELECT S.name as site, COUNT(D.name) as num
FROM Finds as F
JOIN Sites as S
ON F.site_id = S.id
JOIN Dino_Bones as D
ON F.bone_id = D.id
WHERE D.name = 'Velociraptor' and date_part('year', F.date_found) = 2014
GROUP BY S.name, D.name
ORDER BY num DESC
LIMIT 5
;


-- QUESTION 2:
-- Version 2: neater/more readable, but could it be more concise?
WITH RECURSIVE
  T1 AS (
    SELECT S.name as site
         , date_part('year', F.date_found) as year
         , COUNT(D.name) as find_count
    FROM Finds as F
    JOIN Sites as S
    ON F.site_id = S.id
    JOIN Dino_Bones as D
    ON F.bone_id = D.id
    WHERE D.name = 'Velociraptor'
    GROUP BY year, S.name, D.name
    ORDER BY year, find_count DESC
    )
, T2 AS (
    SELECT site
         , year
         , rank() OVER(PARTITION BY year ORDER BY find_count DESC)
           AS find_rank
         , find_count
    FROM T1
    )

SELECT * FROM T2
WHERE find_rank < 4
;


-- QUESTION 2:
-- Version 3: more concise . . . less readbale?
-- WITH RECURSIVE
--   T AS (
--     SELECT S.name as site
--          , date_part('year', F.date_found) as year
--          , rank() OVER(PARTITION BY date_part('year', F.date_found)
--             ORDER BY COUNT(D.name) DESC) AS find_rank
--          , COUNT(D.name) as find_count
--     FROM Finds as F
--     JOIN Sites as S
--     ON F.site_id = S.id
--     JOIN Dino_Bones as D
--     ON F.bone_id = D.id
--     WHERE D.name = 'Velociraptor'
--     GROUP BY year, S.name, D.name
--     ORDER BY year, find_count DESC
--     )
--
-- SELECT * FROM T
-- WHERE find_rank < 4
-- ;
