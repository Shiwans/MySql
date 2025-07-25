-- LeetCode
-- Easy
-- 197 problem number


-- Question:-

-- Table: Weather
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | recordDate    | date    |
-- | temperature   | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- There are no different rows with the same recordDate.
-- This table contains information about the temperature on a certain day.


-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
-- Return the result table in any order.
-- The result format is in the following example.


-- Solution:-
select
    w1.id
from
    weather w1
    join weather w2 on datediff (w1.recordDate, w2.recordDate) = 1
where
    w1.temperature > w2.temperature;


-- other solutions:-
select
    w1.id
from
    Weather w1
    join Weather w2 on w1.recordDate = DATE_ADD (w2.recordDate, INTERVAL 1 DAY)
where
    w1.temperature > w2.temperature