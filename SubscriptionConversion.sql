-- Leetcode
-- MEDIUM
-- 3497 problem number

-- Table: UserActivity
-- +------------------+---------+
-- | Column Name      | Type    | 
-- +------------------+---------+
-- | user_id          | int     |
-- | activity_date    | date    |
-- | activity_type    | varchar |
-- | activity_duration| int     |
-- +------------------+---------+
-- (user_id, activity_date, activity_type) is the unique key for this table.
-- activity_type is one of ('free_trial', 'paid', 'cancelled').
-- activity_duration is the number of minutes the user spent on the platform that day.
-- Each row represents a user's activity on a specific date.


-- A subscription service wants to analyze user behavior patterns. The company offers a 7-day free trial, after which users can subscribe to a paid plan or cancel. Write a solution to:
-- Find users who converted from free trial to paid subscription
-- Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
-- Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
-- Return the result table ordered by user_id in ascending order.
-- The result format is in the following example.



-- solution:
select
    user_id,
    round(
        avg(
            case
                when activity_type = 'free_trial' then activity_duration
            end
        ),
        2
    ) as trial_avg_duration,
    round(
        avg(
            case
                when activity_type = "paid" then activity_duration
            end
        ),
        2
    ) as paid_avg_duration
from
    userActivity
where
    activity_type in ('free_trial', 'paid')
group by
    user_id
HAVING
    COUNT(DISTINCT activity_type) = 2;



-- other solution {using subquery}
SELECT 
  user_id,
  ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END), 2) AS trial_avg_duration,
  ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END), 2) AS paid_avg_duration
FROM userActivity
WHERE user_id IN (
  SELECT user_id
  FROM userActivity
  WHERE activity_type IN ('free_trial', 'paid')
  GROUP BY user_id
  HAVING COUNT(DISTINCT activity_type) = 2
)
GROUP BY user_id;


-- //other solution
-- # Write your MySQL query statement below
with cte as(
    select distinct  user_id ,
    round(avg(activity_duration),2) as t
    from 
    useractivity
    where activity_type="free_trial"
    group by user_id
),
 ct as (
    select distinct  user_id ,
    round(avg(activity_duration),2) as t
    from 
    useractivity
    where 
    activity_type='paid'
    group by user_id
    
 ) 
--  select * from ct;
select a.user_id ,
a.t as trial_avg_duration,
b.t as paid_avg_duration 
from cte a
join 
ct b
on a.user_id=b.user_id
order by a.user_id;