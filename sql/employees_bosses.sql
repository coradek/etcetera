CREATE TABLE Employees
    (`employeeID` int, `name` varchar(32), `bossID` int, `salary` int, `departmentID` int)
;

INSERT INTO Employees
    (`employeeID`, `name`, `bossID`, `salary`, `departmentID`)
VALUES
    (1, 'Alice', 7, 30000, 1),
    (2, 'Bob', 7, 30000, 1),
    (3, 'Claire', 7, 30000, 1),
    (4, 'Doug', 7, 30000, 1),
    (5, 'Emily', 7, 55000, 1),
    (6, 'Frank', 7, 55000, 1),
    (7, 'Gertrude', 10, 50000, 3),
    (8, 'Harry', 6, 50000, 3),
    (9, 'Irene', 6, 60000, 3),
    (10, 'Joe', 20, 60000, 5),
    (11, 'Kelly', 10, 70000, 3),
    (12, 'Larry', 18, 70000, 2),
    (13, 'Molly', 18, 70000, 3),
    (14, 'Ned', 18, 70000, 3),
    (15, 'Olivia', 18, 70000, 3),
    (16, 'Patrick', 18, 90000, 3),
    (17, 'Quinn', 18, 90000, 3),
    (18, 'Ryan', 20, 80000, 3),
    (19, 'Sally', 20, 100010, 5),
    (20, 'Tom', NULL, 100000, 5),
    (21, 'Ula', NULL, 100000, 5),
    (22, 'Victor', 12, 60000, 2),
    (23, 'Wendy', 12, 60000, 2),
    (24, 'Xavier', 12, 65000, 2),
    (25, 'Yollanda', 12, 75000, 2)
;

CREATE TABLE Department
    (`id` int, `name` varchar(32))
;

INSERT INTO Department
    (`id`, `name`)
VALUES
    (1, 'floral'),
    (2,	'produce'),
    (3, 'accounting'),
    (4, 'customer service'),
    (5, 'corporate')
;


-- 1) Find names and difference in salaries
--    for employees who make more than their bosses

SELECT
  E.name, E.salary,
  B.name as boss_name, B.salary as boss_salary
FROM
  Employees E LEFT Join Employees B
  ON E.bossID = B.employeeID
WHERE E.salary > B.salary



-- 2) List employees whose boss is in different department

SELECT
E.name, D.name,
B.name, BD.name
FROM
Employees E
LEFT JOIN Employees B
  ON E.bossID = B.employeeID
JOIN Department D
  ON E.departmentID = D.id
JOIN Department BD
  ON BD.id = B.departmentID
WHERE E.departmentID != B.departmentID
