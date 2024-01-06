-- Fetch Aircraft data
SELECT
    *
FROM
    aircraft;

-- I. Insert a new Aircraft
-- 1. Check if the aircraft already exists
SELECT
    aircraft_name
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
-- 1. Activate an aircraft
-- 1.1. Check if the aircraft exists and check its status
SELECT
    aircraft_name,
    status
FROM
    aircraft
WHERE
    aircraft_code = $1;

-- 1.2 Update the status of the aircraft
UPDATE
    aircraft
SET
    status = 'Active'
WHERE
    aircraft_code = $2
RETURNING
    aircraft_code;

-- 2. Deactivate an aircraft
-- 2.1. Check if the aircraft exists and check its status
SELECT
    aircraft_name,
    status
FROM
    aircraft
WHERE
    aircraft_code = $1;

-- 2.2 Check if the aircraft has any scheduled flights at the moment
SELECT
    flight_code
FROM
    flight_schedule
WHERE
    aircraft = $1
    AND (current_timestamp(0) BETWEEN CAST(departure_date || ' ' || departure_time AS timestamp)
        AND CAST(arrival_date || ' ' || arrival_time AS timestamp));

-- 2.3 Trigger to cancel all upcoming flights
CREATE OR REPLACE FUNCTION cancel_flights_trigger ()
    RETURNS TRIGGER
    AS $$
BEGIN
    IF NEW.status = 'Inactive' THEN
        UPDATE
            flight_schedule
        SET
            status = 'Canceled'
        WHERE
            aircraft = NEW.aircraft_code
            AND CAST(departure_date || ' ' || departure_time AS timestamp) > current_timestamp(0);
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER cancel_flights_trigger
    AFTER UPDATE ON aircraft
    FOR EACH ROW
    EXECUTE FUNCTION cancel_flights_trigger ();

-- 2.4 Set the status to 'Inactive'
UPDATE
    aircraft
SET
    status = 'Inactive'
WHERE
    aircraft_code = $1
RETURNING
    aircraft_code;
