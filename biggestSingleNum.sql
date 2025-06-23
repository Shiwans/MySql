-- Leetcode
-- 619 problem number
-- EASY

-- Table: MyNumbers
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | num         | int  |
-- +-------------+------+
-- This table may contain duplicates (In other words, there is no primary key for this table in SQL).
-- Each row of this table contains an integer.
 

-- A single number is a number that appeared only once in the MyNumbers table.
-- Find the largest single number. If there is no single number, report null.
-- The result format is in the following example.

-- solution
select max(num) as num from (select num from mynumbers group by num having count(*)=1) as uv;