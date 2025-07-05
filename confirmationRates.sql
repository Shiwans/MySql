-- LeetCode
-- 1934 question number
-- Medium

-- Question:
-- Table: Signups
-- +----------------+----------+
-- | Column Name    | Type     |
-- +----------------+----------+
-- | user_id        | int      |
-- | time_stamp     | datetime |
-- +----------------+----------+
-- user_id is the column of unique values for this table.
-- Each row contains information about the signup time for the user with ID user_id.

-- Table: Confirmations
-- +----------------+----------+
-- | Column Name    | Type     |
-- +----------------+----------+
-- | user_id        | int      |
-- | time_stamp     | datetime |
-- | action         | ENUM     |
-- +----------------+----------+
-- (user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
-- user_id is a foreign key (reference column) to the Signups table.
-- action is an ENUM (category) of the type ('confirmed', 'timeout')
-- Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
-- The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

-- Write a solution to find the confirmation rate of each user.
-- Return the result table in any order.
-- The result format is in the following example.


-- solution:
select
    s.user_id,
    round(
        coalesce(
            sum(
                case
                    when c.action = 'confirmed' then 1
                    else 0
                end
            ),
            0
        ) * 1.0 / coalesce(count(c.action), 0),
        2
    ) as confirmation_rate
from
    signups s
    left join confirmations c on s.user_id = c.user_id
group by
    s.user_id


-- got stuck here then
-- solution
SELECT
    s.user_id,
    ROUND(
        CASE
            WHEN COUNT(c.action) = 0 THEN 0
            ELSE SUM(
                CASE
                    WHEN c.action = 'confirmed' THEN 1
                    ELSE 0
                END
            ) * 1.0 / COUNT(c.action)
        END,
        2
    ) AS confirmation_rate
FROM
    Signups s
    LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY
    s.user_id;


-- other solutions
SELECT
    s.user_id,
    Round(
        AVG(
            CASE
                WHEN action = 'confirmed' THEN 1.00
                ELSE 0
            END
        ),
        2
    ) AS confirmation_rate
FROM
    Signups s
    LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY
    s.user_id


-- other 
SELECT
    s.user_id,
    ROUND(
        IFNULL (SUM(c.action = 'confirmed') / COUNT(c.action), 0),
        2
    ) AS confirmation_rate
FROM
    Signups s
    LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY
    s.user_id;