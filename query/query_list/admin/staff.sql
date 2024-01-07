-- 1. Fetch flight staff data
SELECT
    *
FROM
    flight_staff f
    JOIN employee e ON f.employee_id = e.employee_id;

-- 2. Add flight staff
-- 2.1 Check if employee exists
SELECT
    name
FROM
    employee
WHERE
    employee_id = $1;

-- 2.2 Check if flight exists and flight status
SELECT
    status
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 2.3 Insert flight staff
INSERT INTO flight_staff
    VALUES ($1, $2);

-- 3. Delete flight staff
-- 3.1 Check if employee exists
SELECT
    name
FROM
    employee
WHERE
    employee_id = $1;

-- 3.2 Check if flight exists
SELECT
    status
FROM
    flight_schedule
WHERE
    flight_code = $1;

--3.3 Delete flight staff
DELETE FROM flight_staff
WHERE flight_code = $1
    AND employee_id = $2;
