-- LeetCode
-- MEDIUM
-- 3220 problem number

-- question:
-- Table: transactions
-- +------------------+------+
-- | Column Name      | Type | 
-- +------------------+------+
-- | transaction_id   | int  |
-- | amount           | int  |
-- | transaction_date | date |
-- +------------------+------+
-- The transactions_id column uniquely identifies each row in this table.
-- Each row of this table contains the transaction id, amount and transaction date.

-- Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no 
-- odd or even transactions for a specific date, display as 0.
-- Return the result table ordered by transaction_date in ascending order.
-- The result format is in the following example.

---- solution:
select transaction_date,
    sum(case when (amount % 2 != 0) then amount else 0 end) as odd_sum,
    sum(case when (amount % 2 = 0) then amount else 0 end) as even_sum
from transactions group by transaction_date order by transaction_date; 
    

-- other solution:
with temp as
(
select transaction_date,
sum(case when mod(amount, 2)=1 then amount else 0 end) as odd_sum, 
sum(case when mod(amount, 2)=0 then amount else 0 end) as even_sum
from transactions
group by transaction_date
)
select * from temp
order by transaction_date


-- another solution:
SELECT transaction_date, SUM(IF(amount % 2 = 1,amount,0)) AS odd_sum,
SUM(IF(amount % 2 = 0, amount, 0)) AS even_sum
FROM transactions
GROUP BY 1
ORDER BY 1;
