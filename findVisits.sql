-- sql-practice
-- MEDIUM

-- table:
-- primary key patient_id	INT
-- admission_date	DATE
-- discharge_date	DATE
-- diagnosis	TEXT
-- attending_doctor_id	INT foreign key


-- question:
-- Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and 
-- average number of admissions per day is calculated. Average is rounded to 2 decimal places.


-- solution:
select
    max(cnt_value) as max_visits,
    min(cnt_value) as min_visits,
    round(avg(cnt_value), 2) as average_visits
from
    (
        select
            count(day (admission_date)) as cnt_value
        from
            admissions
        group by
            admission_date
    );


-- other solution:-
select
    max(number_of_visits) as max_visits,
    min(number_of_visits) as min_visits,
    round(avg(number_of_visits), 2) as average_visits
from
    (
        select
            admission_date,
            count(*) as number_of_visits
        from
            admissions
        group by
            admission_date
    )