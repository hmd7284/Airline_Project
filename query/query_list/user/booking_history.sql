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
    customer_id = $1;

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
    t.customer_id = $1
    AND t.booking_date BETWEEN $2 AND $3;

-- 3. Cancel a transaction
-- 3.1 Check if transaction is cancellable by checking the time difference between departure timestamp and current_timestamp
SELECT
    o.order_id,
    (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) - current_timestamp(0)) AS time_difference
FROM
    flight_schedule fs
    JOIN transactions_order o ON fs.flight_code = o.flight_code
WHERE
    o.transaction_id = $1;

-- 3.2 Cancel transaction
DELETE FROM transactions_order
WHERE transaction_id = $1
RETURNING
    transaction_id;

-- 4. Cancel order
-- 4.1 Check if order is cancellable by checking the time difference between departure timestamp and current_timestamp
SELECT
    (CAST(fs.departure_date || ' ' || fs.departure_time AS timestamp) - current_timestamp(0)) AS time_difference
FROM
    flight_schedule fs
    JOIN transactions_order o ON fs.flight_code = o.flight_code
WHERE
    o.transaction_id = $1
    AND o.order_id = $2;

-- 4.2 Cancel order
DELETE FROM transactions_order
WHERE transaction_id = $1
    AND order_id = $2
RETURNING
    order_id;
