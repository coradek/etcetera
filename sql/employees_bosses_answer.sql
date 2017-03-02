/*
Given the following tables -

Employees:
employee_id |  name   | boss_id | salary | department_id
-------------+---------+---------+--------+---------------
          1 | Alice   |       7 |  30000 |             1
          6 | Frank   |       7 |  55000 |             1
         11 | Kelly   |      10 |  70000 |             3
         16 | Patrick |      18 |  90000 |             3
         21 | Ula     |         | 100000 |             5

Department:
         id |       name
        ----+------------------
          1 | floral
          2 | produce
          3 | accounting
          4 | customer service
          5 | corporate


1) Find names and difference in salaries
   for employees who make more than their bosses.
   (Note: boss_id is the employee_id of the employees boss)

ANSWER:
  name   | boss_name | salary_difference
----------+-----------+-------------------
Emily    | Gertrude  |              5000
Frank    | Gertrude  |              5000
Irene    | Frank     |              5000
Kelly    | Joe       |             10000
Patrick  | Ryan      |             10000
Quinn    | Ryan      |             10000
Sally    | Tom       |                10
Yollanda | Larry     |              5000


QUESTION 2:
List employees whose boss is in a different department
as well as their department, boss and the bosses dept.

  name   | department | boss_name | boss_dept
----------+------------+-----------+------------
Harry    | accounting | Frank     | floral
Irene    | accounting | Frank     | floral
Alice    | floral     | Gertrude  | accounting
Claire   | floral     | Gertrude  | accounting
Bob      | floral     | Gertrude  | accounting
Emily    | floral     | Gertrude  | accounting
Frank    | floral     | Gertrude  | accounting
Doug     | floral     | Gertrude  | accounting
Gertrude | accounting | Joe       | corporate
Kelly    | accounting | Joe       | corporate
Larry    | produce    | Ryan      | accounting
Ryan     | accounting | Tom       | corporate
*/



-- QUESTION 1:

SELECT
  E.name, --E.salary,
  B.name as boss_name, --B.salary as boss_salary,
  E.salary - B.salary as salary_difference
FROM
  Employees E LEFT Join Employees B
  ON E.boss_id = B.employee_id
WHERE E.salary > B.salary
;



-- QUESTION 2:

SELECT
E.name, D.name as department,
B.name as boss_name, BD.name as boss_dept
FROM
Employees E
LEFT JOIN Employees B
  ON E.boss_id = B.employee_id
JOIN Department D
  ON E.department_id = D.id
JOIN Department BD
  ON BD.id = B.department_id
WHERE E.department_id != B.department_id
;
