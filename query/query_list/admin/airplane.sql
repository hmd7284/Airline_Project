-- Fetch Aircraft data
SELECT
    *
FROM
    aircraft;

-- I. Insert a new Aircraft
-- 1. Check if the aircraft already exists
SELECT
    *
FROM
    aircraft
WHERE
    aircraft_code = $1;

-- $1: aircraft_code from user input
-- 2. Insert the new aircraft
INSERT INTO aircraft (aircraft_code, aircraft_name, capacity, status, mfd_com, mfd_date)
    VALUES ($1, $2, $3, $4, $5, $6)
RETURNING
    aircraft_code;

-- II. Update the status of an aircraft
-- 1. Check if the aircraft exists
SELECT
    *
FROM
    aircraft
WHERE
    aircraft_code = $1;

-- 2. Check if there are any flights scheduled for the aircraft
SELECT
    *
FROM
    flight_schedule
WHERE
    aircraft = $1;

-- 3. Update the status of the aircraft
-- 3.1 Set the status to 'Active'
UPDATE
    aircraft
SET
    status = 'Active'
WHERE
    aircraft_code = $1
RETURNING
    aircraft_code;

-- 3.2.1 Set the status to 'Inactive'
UPDATE
    aircraft
SET
    status = 'Inactive'
WHERE
    aircraft_code = $1
RETURNING
    aircraft_code;

-- 3.2.2 Cancel all the flights scheduled for the aircraft
DELETE FROM transactions_order
WHERE flight_code = ANY (
        SELECT
            flight_code
        FROM
            flight_schedule
        WHERE
            aircraft = $1);
