-- LeetCode
-- EASY ~ feels like medium
-- 1280 question number

-- Table: Students
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | student_id    | int     |
-- | student_name  | varchar |
-- +---------------+---------+
-- student_id is the primary key (column with unique values) for this table.
-- Each row of this table contains the ID and the name of one student in the school.

-- Table: Subjects
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | subject_name | varchar |
-- +--------------+---------+
-- subject_name is the primary key (column with unique values) for this table.
-- Each row of this table contains the name of one subject in the school.

-- Table: Examinations
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | student_id   | int     |
-- | subject_name | varchar |
-- +--------------+---------+
-- There is no primary key (column with unique values) for this table. It may contain duplicates.
-- Each student from the Students table takes every course from the Subjects table.
-- Each row of this table indicates that a student with ID student_id attended the exam of subject_name.


-- question:
-- Write a solution to find the number of times each student attended each exam.
-- Return the result table ordered by student_id and subject_name.
-- The result format is in the following example.


-- solution:
-- initial thought
-- broken down in small part 
select
    *
from
    students
    join subjects;


-- then eventually to this still not working
select
    s.student_id, student_name, subject_name,
    count(subject_name) as attended_exams
from
    students s
    full outer join examinations e on s.student_id = e.student_id
group by
    student_id, subject_name
order by
    student_id, subject_name;


-- then tried again with left join but still didn't work 
select
    s.student_id, s.student_name, e.subject_name,
    count(e.subject_name) as attended_exams
from
    students s
    left join examinations e on s.student_id = e.student_id
    left join subjects sub on e.subject_name = sub.subject_name
group by
    student_id, student_name, subject_name
order by
    student_id, subject_name; 


-- then after help i got the answer
SELECT
    s.student_id, s.student_name, sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    students s
    CROSS JOIN subjects sub
    LEFT JOIN examinations e ON s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY
    s.student_id, s.student_name, sub.subject_name
ORDER BY
    s.student_id, sub.subject_name;