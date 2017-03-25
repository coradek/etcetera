CREATE TABLE content_actions
(action_type text, content_id int, target_id int)
;
INSERT INTO content_actions VALUES
  ('photo', 11, NULL)
, ('comment', 12, 11)
, ('comment', 13, 11)
, ('comment', 14, 11)
, ('photo', 15, NULL)
, ('comment', 16, 15)
, ('comment', 17, 15)
, ('comment', 18, 15)
, ('photo', 19, NULL)
, ('comment', 20, 19)
, ('comment', 21, 19)
, ('share', 22, 11)
, ('comment', 23, 22)
, ('share', 24, 15)
, ('comment', 25, 24)
, ('share', 26, 15)
, ('comment', 27, 26)
, ('comment', 28, 26)
, ('post', 29, NULL)
, ('comment', 30, 29)
, ('comment', 31, 29)
, ('post', 32, NULL)
, ('comment', 33, 32)
, ('comment', 34, 32)
, ('post', 35, NULL)
, ('comment', 36, 35)
, ('comment', 37, 35)
, ('comment', 38, 35)
, ('comment', 39, 35)
, ('share', 40, 29)
, ('comment', 41, 40)
, ('comment', 42, 40)
, ('comment', 43, 40)
, ('share', 44, 29)
, ('comment', 45, 44)
, ('comment', 46, 44)
, ('comment', 47, 44)
, ('share', 48, 35)
, ('comment', 49, 48)
, ('comment', 50, 48)
, ('comment', 51, 48)
, ('share', 52, 35)
, ('comment', 53, 52)
, ('comment', 54, 52)
, ('comment', 55, 52)
, ('share', 56, 35)
, ('comment', 57, 56)
, ('comment', 58, 56)
, ('comment', 59, 56)
;


/*
We use the log content_actions to track a
variety of users activity. It has the following data:


table content_actions:
(date)
(user_id)
content_id - unique id for generated content
action_type - one of the following:
              {'post', 'share', 'photo', 'comment'}
target_id - id of the object that is receiving this content


1) userid = Ben,  content_id = 11, action_type = 'photo',   target_id = null
2) userid = Ben,  content_id = 12, action_type = 'comment', target_id = 11
3) userid = Sam,  content_id = 13, action_type = 'comment', target_id = 11
4) userid = John, content_id = 14, action_type = 'share',   target_id = 11

Compute a distribution of the number comments per number of stories  ('post', 'share', 'photo').

num_comments num_stories
2                  10M
10                 400k
50                 2k
*/

-- Answer to Part 1 from my practice table:
-- num_comments, num_stories
-- 1, 2
-- 2, 4
-- 3, 7
-- 4, 1


WITH comment_count AS
(
SELECT target_id, COUNT(action_type) as num_comments
FROM content_actions
WHERE action_type = 'comment'
GROUP BY target_id
)

SELECT num_comments, COUNT(target_id) as num_stories
FROM comment_count
GROUP BY num_comments
ORDER BY num_comments ASC
;


/*
FOLLOW UP:
What if we now want to separate this distribution by action type?

num_comments num_stories action_type
2                  10M      photo
10                 400k     photo
50                 2k       photo
10                 600k     post
50                 1k       post
*/


-- Answer to second part (practice table)
-- num_comments num_stories, action_type
-- 2, 1, photo
-- 3, 2, photo
-- 2, 2, post
-- 4, 1, post
-- 1, 2, share
-- 2, 1, share
-- 3, 5, share

WITH comment_count AS
(
SELECT A.target_id, COUNT(A.action_type) as num_comments, B.action_type
FROM content_actions as A
WHERE action_type = 'comment'
GROUP BY A.target_id

JOIN content_actions as B
ON A.target_id = B.content_id
)

SELECT num_comments, COUNT(target_id) as num_stories, action_type
FROM comment_count
GROUP BY num_comments, action_type
;

--########################
-- above is my answer in interview

-- here is my reworked answer

WITH comment_count AS
(
SELECT A.target_id, COUNT(A.action_type) as num_comments, B.action_type
FROM content_actions as A
JOIN content_actions as B
ON A.target_id = B.content_id
WHERE A.action_type = 'comment'
GROUP BY A.target_id, B.action_type
)

SELECT num_comments, COUNT(target_id) as num_stories, action_type
FROM comment_count
GROUP BY num_comments, action_type
ORDER BY action_type, num_comments
;
