CREATE OR REPLACE VIEW airline_insights AS
SELECT
    EXTRACT(YEAR FROM booking_date) AS year,
    EXTRACT(MONTH FROM booking_date) AS month,
    SUM(total_amount) AS total_revenue,
    COUNT(DISTINCT flight_code) AS number_of_flights,
    SUM(quantity) AS number_of_tickets,
    (
        SELECT
            route_code
        FROM (
            SELECT
                route_code,
                COUNT(*) AS route_count
            FROM
                transactions_order
                INNER JOIN flight_schedule ON transactions_order.flight_code = flight_schedule.flight_code
                INNER JOIN route ON flight_schedule.route = route.route_code
                INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
            WHERE
                EXTRACT(YEAR FROM booking_date) = EXTRACT(YEAR FROM CURRENT_DATE)
                AND EXTRACT(MONTH FROM booking_date) = EXTRACT(MONTH FROM CURRENT_DATE)
            GROUP BY
                route_code
            ORDER BY
                route_count DESC
            LIMIT 1) AS subquery) AS most_popular_route,
    (
        SELECT
            route_code
        FROM (
            SELECT
                route_code,
                COUNT(*) AS route_count
            FROM
                transactions_order
                INNER JOIN flight_schedule ON transactions_order.flight_code = flight_schedule.flight_code
                INNER JOIN route ON flight_schedule.route = route.route_code
                INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
            WHERE
                EXTRACT(YEAR FROM booking_date) = EXTRACT(YEAR FROM CURRENT_DATE)
                AND EXTRACT(MONTH FROM booking_date) = EXTRACT(MONTH FROM CURRENT_DATE)
            GROUP BY
                route_code
            ORDER BY
                route_count ASC
            LIMIT 1) AS subquery) AS least_popular_route
FROM
    transactions_order
    INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
WHERE
    booking_date >= CURRENT_DATE - interval '12 months'
    AND status = 'Success'
GROUP BY
    EXTRACT(YEAR FROM booking_date),
EXTRACT(MONTH FROM booking_date);
