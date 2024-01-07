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
    r.origin = 'HAN'
    AND r.destination = 'SGN'
    AND f.departure_date = '2024-01-01'
    AND f.status = 'Success'
    AND ((CAST(f.departure_date || ' ' || f.departure_time AS timestamp))::timestamptz >= CURRENT_TIMESTAMP + INTERVAL '4 hours')
    AND (f.business_seat + f.economy_seat >= 2)
ORDER BY
    f.departure_time ASC;

-- $1: origin airport code
-- $2: destination airport code
-- $3: departure date
-- $4: number of tickets
-- 3. Booking
-- 3.1 Check if flight exists and get remaining seats
SELECT
    business_seat,
    economy_seat
FROM
    flight_schedule
WHERE
    flight_code = $1;

--3.2 Create transaction
INSERT INTO transactions (booking_date, customer_id, discount, total_amount)
    VALUES (CURRENT_DATE, $1, $2, $3)
RETURNING
    transaction_id;

-- 3..3 Create order:
INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
    VALUES ($1, $2, $3, $4);

-- 3.4 Delete order
DELETE FROM transactions_order
WHERE transaction_id = $1
    AND order_id = $2
RETURNING
    order_id;

-- 3.5 Check transaction status
SELECT
    status
FROM
    transactions
WHERE
    transaction_id = $1;
