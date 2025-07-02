-- LeetCode
-- Easy
-- 1661 problem number

-- Questions:=
-- Table: Activity
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | machine_id     | int     |
-- | process_id     | int     |
-- | activity_type  | enum    |
-- | timestamp      | float   |
-- +----------------+---------+
-- The table shows the user activities for a factory website.
-- (machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
-- machine_id is the ID of a machine.
-- process_id is the ID of a process running on the machine with ID machine_id.
-- activity_type is an ENUM (category) of type ('start', 'end').
-- timestamp is a float representing the current time in seconds.
-- 'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
-- The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
-- It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.

-- There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.
-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

-- Return the result table in any order.
-- The result format is in the following example.


-- solution->
SELECT
    machine_id,
    ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM
    (
        SELECT
            machine_id,
            process_id,
            MAX(
                CASE
                    WHEN activity_type = 'start' THEN timestamp
                END
            ) AS start_time,
            MAX(
                CASE
                    WHEN activity_type = 'end' THEN timestamp
                END
            ) AS end_time
        FROM
            Activity
        GROUP BY
            machine_id,
            process_id
    ) AS process_times
GROUP BY
    machine_id;


-- another:=
SELECT
    machine_id,
    ROUND(AVG(duration), 3) AS processing_time
FROM
    (
        SELECT
            machine_id,
            MAX(
                CASE
                    WHEN activity_type = 'end' THEN timestamp
                END
            ) - MAX(
                CASE
                    WHEN activity_type = 'start' THEN timestamp
                END
            ) AS duration
        FROM
            Activity
        GROUP BY
            machine_id,
            process_id
    ) AS durations
GROUP BY
    machine_id;



-- using cte
WITH
    ProcessTimes AS (
        SELECT
            machine_id,
            process_id,
            MAX(
                CASE
                    WHEN activity_type = 'start' THEN timestamp
                END
            ) AS start_time,
            MAX(
                CASE
                    WHEN activity_type = 'end' THEN timestamp
                END
            ) AS end_time
        FROM
            Activity
        GROUP BY
            machine_id,
            process_id
    )
SELECT
    machine_id,
    ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM
    ProcessTimes
GROUP BY
    machine_id;



-- //another
SELECT
    s.machine_id,
    ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time
FROM
    Activity s
    JOIN Activity e ON s.machine_id = e.machine_id
    AND s.process_id = e.process_id
    AND s.activity_type = 'start'
    AND e.activity_type = 'end'
GROUP BY
    s.machine_id;



-- //another/ way
-- using joins
select
    a.machine_id,
    round(avg(b.timestamp - a.timestamp), 3) as processing_time
from
    Activity a
    join Activity b on a.machine_id = b.machine_id
    and a.process_id = b.process_id
    and a.activity_type = 'start'
    and b.activity_type = 'end'
group by
    machine_id;



-- last
select
    machine_id,
    round(
        (
            select
                avg(a2.timestamp)
            from
                activity a2
            where
                a2.activity_type = 'end'
                and a2.machine_id = a1.machine_id
        ) - (
            select
                avg(a2.timestamp)
            from
                activity a2
            where
                a2.activity_type = 'start'
                and a2.machine_id = a1.machine_id
        ),
        3
    ) as processing_time
from
    activity a1
group by
    a1.machine_id;