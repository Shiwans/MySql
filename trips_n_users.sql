-- Leetcode
-- 262 problem number
-- Hard

-- Table: Trips
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | id          | int      |
-- | client_id   | int      |
-- | driver_id   | int      |
-- | city_id     | int      |
-- | status      | enum     |
-- | request_at  | varchar  |     
-- +-------------+----------+
-- id is the primary key (column with unique values) for this table.
-- The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
-- Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').

-- Table: Users
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | users_id    | int      |
-- | banned      | enum     |
-- | role        | enum     |
-- +-------------+----------+
-- users_id is the primary key (column with unique values) for this table.
-- The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
-- banned is an ENUM (category) type of ('Yes', 'No').

-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
-- Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03" with at least one trip. Round Cancellation Rate to two decimal points.
-- Return the result table in any order.
-- The result format is in the following example.


-- solution
SELECT 
  t.request_at as Day,
  ROUND(
    SUM(CASE WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END) 
    / COUNT(*), 
    2
  ) AS 'Cancellation Rate'
FROM Trips t
JOIN Users u1 ON t.client_id = u1.users_id
JOIN Users u2 ON t.driver_id = u2.users_id
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
  AND u1.banned = 'No'
  AND u2.banned = 'No'
GROUP BY t.request_at
order By request_at asc;

-- other answer
select 
    request_at as "Day",
    round(
        (sum(case when status = "cancelled_by_driver" or status = "cancelled_by_client" then 1 else 0 end) / count(status)), 2
    ) as "Cancellation Rate"
from
    Trips
where 
    client_id not in (select users_id from Users where role = 'client' and banned ='Yes') 
and 
    driver_id not in (select users_id from Users where role = 'driver' and banned ='Yes') 
and 
    request_at >= "2013-10-01" and request_at <= "2013-10-03"
group by 
    request_at;