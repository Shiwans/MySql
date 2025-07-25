-- LeetCode
-- 1193 question number
-- Medium 


-- Question:-
-- Table: Transactions
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | country       | varchar |
-- | state         | enum    |
-- | amount        | int     |
-- | trans_date    | date    |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].

-- Write an SQL query to find for each month and country, the number of transactions and their total amount, the number 
-- of approved transactions and their total amount.
-- Return the result table in any order.
-- The query result format is in the following example.


-- solution:-
select
    DATE_FORMAT (trans_date, '%Y-%m') as month,
    country,
    count(*) as trans_count,
    sum(
        case
            when state = "approved" then 1
            else 0
        end
    ) as approved_count,
    sum(amount) as trans_total_amount,
    sum(
        CASE
            WHEN state = 'approved' THEN amount
            ELSE 0
        END
    ) as approved_total_amount
from
    transactions
group by
    country,
    DATE_FORMAT (trans_date, '%Y-%m');


-- others:-
SELECT
    DATE_FORMAT (trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(
        CASE
            WHEN state = 'approved' THEN amount
            ELSE 0
        END
    ) AS approved_total_amount
FROM
    Transactions
GROUP BY
    DATE_FORMAT (trans_date, '%Y-%m'),
    country;