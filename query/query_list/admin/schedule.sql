-- Fetch schedule data from the database
SELECT
    fs.*,
    o.airport_code AS origin_code,
    o.airport_name AS origin_name,
    o.address AS origin_address,
    d.airport_code AS destination_code,
    d.airport_name AS destination_name,
    d.address AS destination_address
FROM
    flight_schedule fs
    JOIN route r ON fs.route = r.route_code
    JOIN airport o ON r.origin = o.airport_code
    JOIN airport d ON r.destination = d.airport_code;

-- Fetch route data from the database
SELECT
    r.route_code,
    o.airport_code AS origin_code,
    o.airport_name AS origin_name,
    o.address AS origin_address,
    d.airport_code AS destination_code,
    d.airport_name AS destination_name,
    d.address AS destination_address
FROM
    route r
    JOIN airport o ON r.origin = o.airport_code
    JOIN airport d ON r.destination = d.airport_code;

-- 1.Add flight
-- 1.1Check if flight exists and get departure,arrival timestamp
SELECT
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp,
    (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 1.2Check aircraft availability
SELECT
    status
FROM
    aircraft
WHERE
    aircraft_code = $1;

-- 1.3Check if aircraft has schedule conflict
SELECT
    flight_code
FROM
    flight_schedule
WHERE
    aircraft = $1
    AND (CAST($2 || ' ' || $3 AS timestamp),
        CAST($4 || ' ' || $5 AS timestamp))
    OVERLAPS(CAST(departure_date || ' ' || departure_time AS timestamp), CAST(arrival_date || ' ' || arrival_time AS timestamp));

-- 1.4.Check if aircraft is at the airport
SELECT
    fs.flight_code
FROM
    flight_schedule fs
    JOIN route r ON fs.route = r.route_code
WHERE
    fs.aircraft = $1
    AND r.destination = $2
    AND (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) < CAST($3 || ' ' || $4 AS timestamp))
ORDER BY
    fs.departure_date DESC
LIMIT 1;

-- 1.5. Insert flight
INSERT INTO flight_schedule (flight_code, departure_date, departure_time, arrival_date, arrival_time, aircraft, route)
    VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING
    flight_code;

-- 2. Cancel flight
--.2.1 Check if flight exists and get departure,arrival timestamp
SELECT
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp,
    (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 2.2. Check if flight is cancelled
SELECT
    status
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 2.3. Cancel flight
UPDATE
    flight_schedule
SET
    status = 'Canceled'
WHERE
    flight_code = $1
RETURNING
    flight_code;

-- 2.4. Trigger to delete all associated tickets
CREATE OR REPLACE FUNCTION delete_order_trigger ()
    RETURNS TRIGGER
    AS $$
BEGIN
    -- Check if the flight status is being set to 'Canceled'
    IF NEW.status = 'Canceled' AND OLD.status != 'Canceled' THEN
        -- Delete all orders related to the canceled flight
        DELETE FROM transactions_order
        WHERE flight_code = NEW.flight_code;
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER delete_order_trigger
    AFTER UPDATE ON flight_schedule
    FOR EACH ROW
    EXECUTE FUNCTION delete_order_trigger ();

-- 3. Update flight time
--.3.1 Check if flight exists and get departure,arrival timestamp
SELECT
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp,
    (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 3.2. Check if flight is cancelled
SELECT
    status
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 3.3 Update flight time
UPDATE
    flight_schedule
SET
    departure_date = $1,
    departure_time = $2,
    arrival_date = $3,
    arrival_time = $4
WHERE
    flight_code = $5
RETURNING
    flight_code;
