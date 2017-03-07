-- MYSQL / PSQL

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

DailyCount:
user_id | song_id
---------+---------
      1 |       1
      1 |       2
      1 |       3
      1 |       3
      2 |       2

LifeCount:
user_id | song_id | num
---------+---------+-----
      2 |       1 |   8
      3 |       5 |  11
      4 |       1 |  12
      1 |       3 |   7
      2 |       2 |   9

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


DROP TABLE IF EXISTS DailyCount;
CREATE TABLE DailyCount
(user_id integer, song_id integer)
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


DROP TABLE IF EXISTS LifeCount;
CREATE TABLE LifeCount
 (user_id int, song_id int, num int)
;

INSERT INTO LifeCount VALUES
     (1,1,2), (1,2,5), (1,3,5)
   , (2,1,8), (2,2,5), (3,5,11)
;

-- This bit is very important! (See note in answer file)
CREATE UNIQUE INDEX ind on LifeCount(user_id, song_id)
;
