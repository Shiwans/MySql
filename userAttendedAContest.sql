-- LeetCode
-- 1633 question 
-- Easy


-- Question->
-- Table: Users
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | user_name   | varchar |
-- +-------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- Each row of this table contains the name and the id of a user.


-- Table: Register
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | contest_id  | int     |
-- | user_id     | int     |
-- +-------------+---------+
-- (contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table contains the id of a user and the contest they registered into.


-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
-- Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
-- The result format is in the following example.


-- solution-> 
select
    contest_id,
    round(
        (
            count(r.user_id) / (
                select
                    count(*)
                from
                    users
            )
        ) * 100,
        2
    ) as percentage
from
    register r
    left join users u on r.user_id = u.user_id
group by
    contest_id
order by
    percentage desc,
    contest_id asc;


-- others:
SELECT
    r.contest_id,
    ROUND(
        COUNT(r.contest_id) * 100 / (
            SELECT
                COUNT(user_id)
            FROM
                Users
        ),
        2
    ) as "percentage"
FROM
    Users u
    JOIN Register r ON u.user_id = r.user_id
GROUP BY
    r.contest_id
ORDER BY
    percentage DESC,
    r.contest_id