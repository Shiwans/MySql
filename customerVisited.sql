-- LeetCode
-- 1581 question number
-- Easy


-- Questions:-
-- Table: Visits
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | visit_id    | int     |
-- | customer_id | int     |
-- +-------------+---------+
-- visit_id is the column with unique values for this table.
-- This table contains information about the customers who visited the mall.

-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | transaction_id | int     |
-- | visit_id       | int     |
-- | amount         | int     |
-- +----------------+---------+
-- transaction_id is column with unique values for this table.
-- This table contains information about the transactions made during the visit_id.


-- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
-- Return the result table sorted in any order.
-- The result format is in the following example.


-- Solution:-
select
    customer_id,
    count(customer_id) as count_no_trans
from
    Visits v
    left join Transactions t on v.visit_id = t.visit_id
where
    t.visit_id is null
group by
    customer_id;