-- 1. Fetch origin and destination airport data
SELECT
    airport_code,
    address
FROM
    airport;

-- 2. Search for flights
SELECT
    f.flight_code,
    f.departure_date,
    f.departure_time,
    r.origin,
    r.destination,
    a.aircraft_code,
    f.status,
    a.aircraft_name,
    af1.price AS economy_price,
    af2.price AS business_price
FROM
    aircraft a
    JOIN flight_schedule f ON a.aircraft_code = f.aircraft
    JOIN route r ON f.route = r.route_code
    JOIN airfare af1 ON af1.route = r.route_code
        AND af1.TYPE = 'Economy'
    JOIN airfare af2 ON af2.route = r.route_code
        AND af2.TYPE = 'Business'
WHERE
    r.origin = $1
    AND r.destination = $2
    AND f.departure_date = $3
    AND f.status = 'Success'
    AND ((CAST(f.departure_date || ' ' || f.departure_time AS timestamp))::timestamptz >= CURRENT_TIMESTAMP + INTERVAL '4 hours')
    AND (f.business_seat + f.economy_seat >= $4)
ORDER BY
    f.departure_time ASC;

-- $1: origin airport code
-- $2: destination airport code
-- $3: departure date
-- $4: number of tickets

-- 3. Booking
-- 3.1 Create transaction

