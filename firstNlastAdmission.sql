-- Sql-practice
-- MEDIUM


-- admission table
-- patient_id	INT
-- admission_date	DATE
-- discharge_date	DATE
-- diagnosis	TEXT
-- attending_doctor_id	INT

-- doctor table
-- doctor_id      INT
-- first_name	TEXT
-- last_name	TEXT
-- specialty	TEXT


-- Q.
-- For each doctor, display their id, full name, and the first and last admission date they attended.


-- solution:-
select
    doctor_id,
    concat (first_name, ' ', last_name) as full_name,
    min(admission_date) as first_admission_date,
    max(admission_date) as last_admission_date
from
    doctors d
    join admissions a on d.doctor_id = a.attending_doctor_id
group by
    attending_doctor_id;

-- other solution 
select
    doctor_id,
    first_name || ' ' || last_name as full_name,
    min(admission_date) as first_admission_date,
    max(admission_date) as last_admission_date
from
    admissions a
    join doctors ph on a.attending_doctor_id = ph.doctor_id
group by
    doctor_id;