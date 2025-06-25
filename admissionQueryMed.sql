-- Sql-practice
-- MEDIUM level

-- Q:-
-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19. 
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

-- admission table:-
-- primary key 	patient_id	INT
-- admission_date	DATE
-- discharge_date	DATE
-- diagnosis	TEXT
-- primary key 	attending_doctor_id	INT

-- solution:-
select patient_id, attending_doctor_id,diagnosis 
from admissions 
where (MOD(patient_id, 2) = 1 and attending_doctor_id in (1, 5, 19))
or (attending_doctor_id like '%2%' and len(patient_id) = 3);