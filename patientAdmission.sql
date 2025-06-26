-- Sql-practice
-- MEDIUM

-- patient table:-
-- primary key icon	patient_id	INT
-- first_name	TEXT
-- last_name	TEXT
-- gender	CHAR(1)
-- birth_date	DATE
-- city	TEXT
-- primary key icon	province_id	CHAR(2)
-- allergies	TEXT
-- height	INT
-- weight	INT

-- admissions table
-- primary key icon	patient_id	INT
-- admission_date	DATE
-- discharge_date	DATE
-- diagnosis	TEXT
-- primary key icon	attending_doctor_id	INT

-- doctors table;-
-- primary key icon	doctor_id	INT
-- first_name	TEXT
-- last_name	TEXT
-- specialty	TEXT


-- Q-
-- For every admission, display the patient's full name, their admission diagnosis,
-- and their doctor's full name who diagnosed their problem.


-- solution
select
    concat (pa.first_name, ' ', pa.last_name) as patient_name,
    diagnosis,
    concat (d.first_name, ' ', d.last_name) as doctor_name
from
    admissions a
    right join patients pa on a.patient_id = pa.patient_id
    right join doctors d on a.attending_doctor_id = d.doctor_id;