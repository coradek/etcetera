-- MYSQL
CREATE TABLE DailyCount
(`userID` integer, `songID` integer)
;

INSERT INTO DailyCount values
    (1,1), (1,1), (1,1), (1,2), (1,3), (1,3)
  , (2,2), (2,2), (2,2), (2,2)
  , (2,4) -- person 2 listens to a NEW song (not yet in 'Life' table)
  , (2,4), (2,4), (2,4), (2,4)
  , (2,4), (2,4), (2,4), (2,4), (2,4)
  , (4,1) -- NEW person listens to song
  , (4,1), (4,1), (4,1), (4,1), (4,1), (4,1)
  , (4,1), (4,1), (4,1), (4,1), (4,1)
;

CREATE TABLE LifeCount
 (`userID` int, `songID` int, `num` int)
;

INSERT INTO LifeCount VALUES
     (1,1,2), (1,2,5), (1,3,5)
   , (2,1,8), (2,2,5), (3,5,11)
;

-- This bit is very important! (See note below)
CREATE UNIQUE INDEX ind on LifeCount(userID, songID)
;

-- FINAL LIFE TABLE should be:
  -- (1,1,5)
  -- (1,2,6)
  -- (1,3,7)
  -- (2,1,8)
  -- (2,2,9)
  -- (2,4,10)
  -- (3,5,11)
  -- (4,1,12)

-- QUESTION:
-- You have a table with (date - ignored for now) user_id,
-- song_id and count.

-- It shows at the end of each day how many times in her history a user
-- has listened to a given song. So count is cumulative sum.

-- You have to update this on a daily basis based on a second table that
-- records in real time when a user listens to a given song.
-- Basically, at the end of each day, you go to this second table
-- and pull a count of each user/song combination and then add this count
-- to the first table that has the lifetime count. If it is the first
-- time a user has listened to a given song, you won't have this pair in
-- the lifetime table, so you have to create the pair there and then add
-- the count of the last day


-- SOLUTION (without the date bit)
INSERT OR REPLACE INTO LifeCount
    SELECT D.userID, D.songID
           , IFNULL(L.num,0) +  IFNULL(D.c,0) as num
	FROM
	(
	SELECT userID, songID, COUNT(songID) as c
	FROM DailyCount
	GROUP BY userID, songID
	) as D
	LEFT JOIN -- left join ensures all user/song pairs from D
            -- pairs not yet in L will have null 'num' value
	LifeCount as L
	ON D.userID = L.userID AND D.songID = L.songID

----------------------------------------------------
----------------------------------------------------

-- EXTRAS


-- Run this query for a better view of values being added
SELECT D.userID, D.songID, L.num, D.c
       , IFNULL(L.num,0) +  IFNULL(D.c,0) as tot
FROM
(
SELECT userID, songID, COUNT(songID) as c
FROM DailyCount
GROUP BY userID, songID
) as D
LEFT JOIN -- left join ensures all user/song pairs from D
          -- pairs not yet in L will have null num value
LifeCount as L
ON D.userID = L.userID AND D.songID = L.songID
;


-- SEE RESULTS (GROUP BY VERSION)
SELECT userID, songID, sum(num) as new_total
FROM
(
   SELECT userID, songID, num
   FROM
       LifeCount
   UNION ALL
       SELECT userID, songID, COUNT(songID) as num
       FROM DailyCount
       GROUP BY userID, songID
)
GROUP BY userID, songID
;


-- NOTE:
-- without the unique index, the insert or replace command would
-- create new rows with user/song pairs already in the LifeCount table
