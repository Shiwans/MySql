-- Sql-practice
-- MEDIUM level

-- Q:
-- Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"

-- doctor table:- 
-- doctor_id	INT
-- first_name	TEXT
-- last_name	TEXT
-- specialty	TEXT

-- patient table:-
-- patient_id     INT
-- first_name	TEXT
-- last_name	TEXT
-- gender	CHAR(1)
-- birth_date	DATE
-- city	TEXT
-- primary key icon	province_id	CHAR(2)
-- allergies	TEXT
-- height	INT
-- weight	INT

-- solution:-
SELECT first_name, last_name, 'Patient' as role from patients
union all
select first_name, last_name, 'Doctor' as role from doctors;