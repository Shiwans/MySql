-- Sql-practice
-- MEDIUM

-- Q:-
-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.

-- doctor table:-
-- doctor_id	INT
-- first_name	TEXT
-- last_name	TEXT
-- specialty	TEXT

-- admission table:-
-- patient_id	INT
-- admission_date	DATE
-- discharge_date	DATE
-- diagnosis	TEXT
-- attending_doctor_id	INT

-- solution:-
SELECT first_name, last_name,
count(*) as admissions_total
from admissions a
join doctors ph on 
ph.doctor_id = a.attending_doctor_id
group by attending_doctor_id;



-- another way:-
SELECT first_name, last_name, count(*)
from doctors p, admissions a
where
a.attending_doctor_id = p.doctor_id
group by p.doctor_id;