-- Leetcode 
-- 1965 problem number 
-- EASY  
-- table: Employees
+-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | name        | varchar |
-- +-------------+---------+
-- employee_id is the column with unique values for this table.
-- Each row of this table indicates the name of the employee whose ID is employee_id.
 

-- Table: Salaries
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | salary      | int     |
-- +-------------+---------+
-- employee_id is the column with unique values for this table.
-- Each row of this table indicates the salary of the employee whose ID is employee_id.
 

-- Q.
-- Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:
-- The employee's name is missing, or
-- The employee's salary is missing.
-- Return the result table ordered by employee_id in ascending order.
-- The result format is in the following example.

-- solution
SELECT e.employee_id
FROM Employees e
LEFT JOIN Salaries s ON e.employee_id = s.employee_id
WHERE s.salary IS NULL

UNION ALL

SELECT s.employee_id
FROM Salaries s
LEFT JOIN Employees e ON s.employee_id = e.employee_id
WHERE e.name IS NULL
order by employee_id;

-- other solution
SELECT employee_id
FROM (
    SELECT e.employee_id, e.name, s.salary
    FROM Employees e
    LEFT JOIN Salaries s ON e.employee_id = s.employee_id

    UNION ALL

    SELECT s.employee_id, e.name, s.salary
    FROM Salaries s
    LEFT JOIN Employees e ON s.employee_id = e.employee_id
) AS all_data
WHERE name IS NULL OR salary IS NULL
ORDER BY employee_id;

-- other solution]
select employee_id from employees where employee_id not in(Select employee_id from salaries)
union
select employee_id from salaries where employee_id not in(select employee_id from employees)
order by employee_id; 