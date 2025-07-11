-- sql-practice
-- MEDIUM


-- Q.
-- display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.


-- solution
select
    first_name,
    last_name,
    count(*) as num_of_duplicates
from
    patients
group by
    first_name,
    last_name
having
    count(*) > 1