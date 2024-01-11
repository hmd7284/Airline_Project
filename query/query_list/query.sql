-- PART 1: USER QUERIES
-- I. Signup, Login queries
-- 1. Signup
-- 1.1 Check if email exists
SELECT
    *
FROM
    account
WHERE
    email = 'abcd@gmail.com'
    AND type = 'customer';

-- 1.2 Insert new account\
INSERT INTO account (email, PASSWORD)
    VALUES ('abcd@gmail.com', 'abcd')
RETURNING
    id;

-- 1.3 Insert new customer
INSERT INTO customers (id, name, dob, address, phone_number)
    VALUES ($1, 'abcd', '2004-01-01', 'HUST', '0123-456-789');

-- 2. Login
SELECT
    *
FROM
    account
WHERE
    email = 'abcd@gmail.com'
    AND type = 'customer';

-- II. Bookings queries
-- 1. Fetch origin and destination airport data
SELECT
    airport_code,
    address
FROM
    airport;

-- 2. Search for flights with given origin, destination, departure date, number of tickets
-- SELECT
--     f.flight_code,
--     f.departure_date,
--     f.departure_time,
--     r.origin,
--     r.destination,
--     a.aircraft_code,
--     f.status,
--     a.aircraft_name,
--     af1.price AS economy_price,
--     af2.price AS business_price
-- FROM
--     aircraft a
--     JOIN flight_schedule f ON a.aircraft_code = f.aircraft
--     JOIN route r ON f.route = r.route_code
--     JOIN airfare af1 ON af1.route = r.route_code
--         AND af1.TYPE = 'Economy'
--     JOIN airfare af2 ON af2.route = r.route_code
--         AND af2.TYPE = 'Business'
-- WHERE
--     r.origin = 'HAN'
--     AND r.destination = 'SGN'
--     AND f.departure_date = '2024-08-01'
--     AND f.status = 'Success'
--     AND ((CAST(f.departure_date || ' ' || f.departure_time AS timestamp))::timestamptz >= CURRENT_TIMESTAMP + INTERVAL '4 hours')
--     AND (f.business_seat + f.economy_seat >= 1)
-- ORDER BY
--     f.departure_time ASC;
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
    r.origin = 'WHP'
    AND r.destination = 'HAN'
    AND f.departure_date = '2024-01-13'
    AND f.status = 'Success'
    AND (f.business_seat + f.economy_seat >= 1)
ORDER BY
    f.departure_time ASC;

-- 3. Booking
-- 3.1 Check if flight exists and get remaining seats
SELECT
    business_seat,
    economy_seat,
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp
FROM
    flight_schedule
WHERE
    flight_code = 'FL00062';

-- 3.2 Check if discount exists
SELECT
    title
FROM
    discount
WHERE
    discount_code = 'DIS10';

--3.3 Create transaction
INSERT INTO transactions (booking_date, customer_id, discount)
    VALUES (CURRENT_DATE, 2, 'DIS10')
RETURNING
    transaction_id;

-- 3.4 Create order:
INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
    VALUES (1, 'FL00047', 'Economy', 1);

-- 3.5 Display transaction details
SELECT
    t.transaction_id,
    t.booking_date,
    t.status,
    t.discount,
    t.total_amount,
    o.order_id,
    o.flight_code,
    r.origin,
    r.destination,
    o.type,
    o.price,
    o.quantity,
    o.total
FROM
    transactions t
    LEFT JOIN transactions_order o ON t.transaction_id = o.transaction_id
    JOIN flight_schedule fs ON o.flight_code = fs.flight_code
    JOIN route r ON fs.route = r.route_code
WHERE
    t.customer_id = 2
    AND t.transaction_id = 246;

-- 3.6 Delete order
DELETE FROM transactions_order
WHERE transaction_id = 1
    AND order_id = 1
RETURNING
    order_id;

-- 3.7 Cancle transaction
UPDATE
    transactions
SET
    status = 'Failed'
WHERE
    transaction_id = 1
RETURNING
    transaction_id;

-- 3.8 Check transaction status
SELECT
    status
FROM
    transactions
WHERE
    transaction_id = 1;

-- III. Booking history queries
-- 1. Fetch Transaction History
SELECT
    t.transaction_id,
    t.booking_date,
    t.status,
    t.discount,
    t.total_amount,
    o.order_id,
    o.flight_code,
    o.type,
    o.price,
    o.quantity,
    o.total
FROM
    transactions t
    LEFT JOIN transactions_order o ON t.transaction_id = o.transaction_id
WHERE
    customer_id = 2;

-- 2.Fetch Transaction History in a date range
SELECT
    t.transaction_id,
    t.booking_date,
    t.status,
    t.discount,
    t.total_amount,
    o.order_id,
    o.flight_code,
    o.type,
    o.price,
    o.quantity,
    o.total
FROM
    transactions t
    LEFT JOIN transactions_order o ON t.transaction_id = o.transaction_id
WHERE
    t.customer_id = 2
    AND t.booking_date BETWEEN '2023-01-01' AND '2024-01-01';

-- 3. Delete a transaction
-- 3.1 Check if transaction is cancellable by checking the time difference between departure timestamp and current_timestamp
-- SELECT
--     o.order_id,
--     (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) - current_timestamp(0)) AS time_difference
-- FROM
--     flight_schedule fs
--     JOIN transactions_order o ON fs.flight_code = o.flight_code
-- WHERE
--     o.transaction_id = 1;
SELECT
    o.order_id,
    (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp)) AS departure_timestamp
FROM
    flight_schedule fs
    JOIN transactions_order o ON fs.flight_code = o.flight_code
WHERE
    o.transaction_id = 1;

-- 3.2 Cancel transaction
UPDATE
    transactions_order
SET
    status = 'Failed'
WHERE
    transaction_id = 1
RETURNING
    transaction_id;

-- 4. Delete order
-- 4.1 Check if order is cancellable by checking the time difference between departure timestamp and current_timestamp
-- SELECT
--     (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) - current_timestamp(0)) AS time_difference
-- FROM
--     flight_schedule fs
--     JOIN transactions_order o ON fs.flight_code = o.flight_code
-- WHERE
--     o.transaction_id = 1
--     AND o.order_id = 1;
SELECT
    (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp)) AS departure_timestamp
FROM
    flight_schedule fs
    JOIN transactions_order o ON fs.flight_code = o.flight_code
WHERE
    o.transaction_id = 1
    AND o.order_id = 1;

-- 4.2 Cancel order
DELETE FROM transactions_order
WHERE transaction_id = 1
    AND order_id = 1
RETURNING
    order_id;

-- IV. Edit Information
-- 1. Edit Profile
-- 1.1 Fetch Information
SELECT
    name,
    dob,
    address,
    phone_number
FROM
    customers
WHERE
    id = 2;

-- 1.2 Update Profile
UPDATE
    customers
SET
    name = 'Harry Maguire',
    dob = '1993-03-05',
    phone_number = '012-345-6789',
    address = 'HUST'
WHERE
    id = 2
RETURNING
    id;

-- 2. Change Password
-- 2.1 Check if old password is correct
SELECT
    PASSWORD
FROM
    account
WHERE
    id = 2
    AND type = 'customer';

-- 2.2 Update password
UPDATE
    account
SET
    PASSWORD = '123456'
WHERE
    id = 2
    AND type = 'customer';

-- PART 2: ADMIN QUERIES
-- I. Airport queries
-- 1. Fetch airport data - Kien
SELECT
    ap.*,
    c.city_name
FROM
    airport ap
    JOIN cities c ON ap.city = c.city_code;

-- 2. Add airport
-- 2.1 Check if airport exists
SELECT
    airport_code
FROM
    airport
WHERE
    airport_code = 'HAN';

-- 2.2 Add airport
INSERT INTO airport (airport_code, airport_name, city)
    VALUES ('ABC', 'ABC Airport', 'HAN')
RETURNING
    airport_code;

-- 3. Delete airport
-- 3.1 Check if airport exists
SELECT
    airport_code
FROM
    airport
WHERE
    airport_code = 'ABC';

-- 3.2 Delete airport
DELETE FROM airport
WHERE airport_code = 'ABC'
RETURNING
    airport_code;

-- II. Aircraft queries
-- 1. Fetch aircraft data
SELECT
    *
FROM
    aircraft;

-- 2. Add aircraft
-- 2.1. Check if the aircraft already exists
SELECT
    aircraft_name
FROM
    aircraft
WHERE
    aircraft_code = 'AC007';

-- 2.2 Insert the new aircraft
INSERT INTO aircraft (aircraft_code, aircraft_name, capacity, status, mfd_com, mfd_date)
    VALUES ('AC007', 'Boeing 777', 300, 'Active', 'Boeing', '2020-01-01')
RETURNING
    aircraft_code;

-- 3. Update the status of an aircraft
-- 3.1. Activate an aircraft
-- 3.1.1 Check if the aircraft exists and check its status
SELECT
    aircraft_name,
    status
FROM
    aircraft
WHERE
    aircraft_code = 'AC007';

-- 3.1.2 Update the status of the aircraft
UPDATE
    aircraft
SET
    status = 'Active'
WHERE
    aircraft_code = 'AC007'
RETURNING
    aircraft_code;

-- 3.2. Deactivate an aircraft
-- 3.2.1. Check if the aircraft exists and check its status
SELECT
    aircraft_name,
    status
FROM
    aircraft
WHERE
    aircraft_code = 'AC007';

-- 3.2.2 Check if the aircraft has any scheduled flights at the moment
SELECT
    flight_code
FROM
    flight_schedule
WHERE
    aircraft = 'AC007'
    AND (current_timestamp(0) BETWEEN CAST(departure_date || ' ' || departure_time AS timestamp)
        AND CAST(arrival_date || ' ' || arrival_time AS timestamp));

-- 3.2.3 Set the status to 'Inactive'
UPDATE
    aircraft
SET
    status = 'Inactive'
WHERE
    aircraft_code = 'AC007'
RETURNING
    aircraft_code;

-- III. Route queries
-- 1. Fetch route data
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

-- 2. Add route:
-- 2.1 Check if route already exists
SELECT
    origin
FROM
    route
WHERE
    route_code = 'ABCDEF';

-- 2.2 Check if origin exists
SELECT
    airport_name
FROM
    airport
WHERE
    airport_code = 'ABC';

-- 2.3 Check if destination exists
SELECT
    airport_name
FROM
    airport
WHERE
    airport_code = 'DEF';

-- 2.4 Add route
INSERT INTO route (route_code, origin, destination)
    VALUES ('ABCDEF', 'ABC', 'DEF')
RETURNING
    route_code;

-- 3. Delete route:
-- 3.1 Check if route exists
SELECT
    origin
FROM
    route
WHERE
    route_code = 'ABCDEF';

-- 3.2 Delete route
DELETE FROM route
WHERE route_code = 'ABCDEF'
RETURNING
    route_code;

-- IV. Flight schedule queries
-- 1. Fetch schedule data from the database - Kien
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

-- 2. Fetch route data from the database
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

-- 3.Add flight
-- 3.1 Check if flight exists and get departure,arrival timestamp
SELECT
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp,
    (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp
FROM
    flight_schedule
WHERE
    flight_code = 'FL00047';

-- 3.2 Check aircraft availability
SELECT
    status
FROM
    aircraft
WHERE
    aircraft_code = 'AC007';

-- 3.3 Check if aircraft has schedule conflict - Kien
SELECT
    flight_code
FROM
    flight_schedule
WHERE
    aircraft = $1
    AND (CAST('2024-01-08' || ' ' || '06:45:00' AS timestamp),
        CAST('2024-01-08' || ' ' || '10:05:00' AS timestamp))
    OVERLAPS(CAST(departure_date || ' ' || departure_time AS timestamp), CAST(arrival_date || ' ' || arrival_time AS timestamp));

-- 3.4 Insert new flight
INSERT INTO flight_schedule (flight_code, departure_date, departure_time, arrival_date, arrival_time, aircraft, route)
    VALUES ('FL00047', '2024-01-08', '06:45:00', '2024-01-08', '10:05:00', 'AC007', 'HANSGN')
RETURNING
    flight_code;

-- 4. Cancel flight
--.4.1 Check if flight exists and get departure,arrival timestamp
SELECT
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp,
    (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp
FROM
    flight_schedule
WHERE
    flight_code = 'FL00047';

-- 4.2. Check if flight is cancelled
SELECT
    status
FROM
    flight_schedule
WHERE
    flight_code = $1;

-- 4.3. Cancel flight
UPDATE
    flight_schedule
SET
    status = 'Canceled'
WHERE
    flight_code = 'FL00047'
RETURNING
    flight_code;

-- 5. Update flight time
-- 5.1 Check if flight exists and get departure,arrival timestamp
SELECT
    (CAST(departure_date || ' ' || departure_time AS timestamp)) AS departure_timestamp,
    (CAST(arrival_date || ' ' || arrival_time AS timestamp)) AS arrival_timestamp
FROM
    flight_schedule
WHERE
    flight_code = 'FL00047';

-- 5.2. Check if flight is cancelled
SELECT
    status
FROM
    flight_schedule
WHERE
    flight_code = 'FL00047';

-- 5.3 Update flight time
UPDATE
    flight_schedule
SET
    departure_date = '06:45:00',
    departure_time = '2024-01-08',
    arrival_date = '10:05:00',
    arrival_time = '2024-01-08'
WHERE
    flight_code = 'FL00047'
RETURNING
    flight_code;

-- 6. Delete flight
-- 6.1 Check if flight exists
SELECT
    departure_date
FROM
    flight_schedule
WHERE
    flight_code = 'FL00047';

-- 6.2 Delete flight
DELETE FROM flight_schedule
WHERE flight_code = 'FL00047';

-- V. Flight staff queries
-- 1. Search flight staff
SELECT
    e.name,
    s.*,
    fs.departure_date,
    fs.departure_time,
    fs.status
FROM
    employee e
    JOIN flight_staff s ON e.employee_id = s.employee_id
    JOIN flight_schedule fs ON s.flight_code = fs.flight_code
WHERE
    s.flight_code = 'FL00063';

-- 2. Add flight staff
-- 2.1 Check if employee exists
SELECT
    name
FROM
    employee
WHERE
    employee_id = 1;

-- 2.2 Check if flight exists and get flight status, departure timestamp
SELECT
    status,
    (CAST(departure_date || ' ' | departure_time AS timestamp)) AS departure_timestamp
FROM
    flight_schedule
WHERE
    flight_code = 'FL00047';

-- 2.3 Check if staff has already been asigned to the flight
SELECT
    flight_code
FROM
    flight_staff
WHERE
    employee_id = 1
    AND flight_code = 'FL00063';

-- 2.4 Check for schedule conflict
SELECT
    fst2.flight_code
FROM
    flight_staff fst1
    JOIN flight_staff fst2 ON fst1.employee_id = fst2.employee_id
    JOIN flight_schedule fs1 ON fst1.flight_code = fs1.flight_code
    JOIN flight_schedule fs2 ON fst2.flight_code = fs2.flight_code
WHERE
    fs1.flight_code = 'FL00063'
    AND fst1.employee_id = 1
    AND fst1.flight_code != fst2.flight_code
    AND tsrange(fs1.departure_date + fs1.departure_time, fs1.arrival_date + fs1.arrival_time, '[]') && tsrange(fs2.departure_date + fs2.departure_time, fs2.arrival_date + fs2.arrival_time, '[]');

-- 2.5 Insert flight staff
INSERT INTO flight_staff
    VALUES ('FL00063', 1);

-- 3. Delete flight staff
-- 3.1 Check if employee exists
2.1;

-- 3.2 Check if flight exists
2.2;

-- 3.3 Check if staff has been assigned to the flight
2.3;

--3.4 Delete flight staff
DELETE FROM flight_staff
WHERE flight_code = 'FL00063'
    AND employee_id = 1;

-- VI. discount queries
-- 1. Fetch discount from database
SELECT
    *
FROM
    discount;

--2 . Add discount to database
--2.1 Check if discount exists
SELECT
    title
FROM
    discount
WHERE
    discount_code = 'DIS40';

--2.2 Add discount to database
INSERT INTO discount (discount_code, title, amount, description)
    VALUES ('DIS40', DISCOUNT 40 PERCENT, 40, '40 percent')
RETURNING
    discount_code;

-- 3 . Delete discount from database
--3.1 Check if discount exists
SELECT
    title
FROM
    discount
WHERE
    discount_code = 'DIS40';

--3.2 Delete discount from database
DELETE FROM discount
WHERE discount_code = 'DIS40'
RETURNING
    discount_code;

-- VII. Admin account queries
-- Search for admin account in the database
SELECT
    *
FROM
    account
WHERE
    email = 'admin@gmail.com'
    AND type = 'admin';

-- PART 3: Employee QUERIES
-- I. Login queries
-- 1. Check if email is registered
SELECT
    employee_id,
    PASSWORD
FROM
    employee
WHERE
    email = 'duchaminh1@kdd.airline.com';

-- II. Fetch working schedule
SELECT
    fs.*,
    o.airport_code AS origin_code,
    o.airport_name AS origin_name,
    o.address AS origin_address,
    d.airport_code AS destination_code,
    d.airport_name AS destination_name,
    d.address AS destination_address
FROM
    flight_staff fst
    JOIN flight_schedule fs ON fs.flight_code = fst.flight_code
    JOIN route r ON fs.route = r.route_code
    JOIN airport o ON r.origin = o.airport_code
    JOIN airport d ON r.destination = d.airport_code
WHERE
    fst.employee_id = 1
ORDER BY
    fs.departure_date ASC,
    fs.departure_time ASC;

-- III. Search working schedule
SELECT
    fs.*,
    o.airport_code AS origin_code,
    o.airport_name AS origin_name,
    o.address AS origin_address,
    d.airport_code AS destination_code,
    d.airport_name AS destination_name,
    d.address AS destination_address
FROM
    flight_staff fst
    JOIN flight_schedule fs ON fs.flight_code = fst.flight_code
    JOIN route r ON fs.route = r.route_code
    JOIN airport o ON r.origin = o.airport_code
    JOIN airport d ON r.destination = d.airport_code
WHERE
    fst.employee_id = 1
    AND fs.departure_date BETWEEN '2024-01-01' AND '2024-01-13'
ORDER BY
    fs.departure_date ASC,
    fs.departure_time ASC;

-- IV. Edit Information
-- 1. Edit Profile
-- 1.1 Fetch Information
SELECT
    first_name,
    last_name,
    gender,
    address,
    phone_number,
    ssn
FROM
    employee
WHERE
    employee_id = 1;

-- 1.2 Update Profile
UPDATE
    employee
SET
    first_name = 'A',
    last_name = 'Nguyen Van',
    gender = 'Male',
    phone_number = '012-345-6789',
    ssn = '0123456789',
    address = 'HUST'
WHERE
    employee_id = 1
RETURNING
    employee_id;

-- 2. Change Password
-- 2.1 Check if old password is correct
SELECT
    PASSWORD
FROM
    employee
WHERE
    employee_id = 1;

-- 2.2 Update password
UPDATE
    employee
SET
    PASSWORD = '123456'
WHERE
    employee_id = 1;
