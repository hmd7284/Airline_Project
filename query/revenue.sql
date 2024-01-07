-- CREATE OR REPLACE VIEW airline_insights AS
-- SELECT
--     SUM(total_amount) AS total_revenue,
--     COUNT(DISTINCT flight_code) AS number_of_flights,
--     SUM(quantity) AS number_of_tickets,
--     (
--         SELECT
--             route_code
--         FROM (
--             SELECT
--                 route_code,
--                 COUNT(*) AS route_count
--             FROM
--                 transactions_order
--                 INNER JOIN flight_schedule ON transactions_order.flight_code = flight_schedule.flight_code
--                 INNER JOIN route ON flight_schedule.route = route.route_code
--             WHERE
--                 booking_date >= CURRENT_DATE - interval '12 months'
--             GROUP BY
--                 route_code
--             ORDER BY
--                 route_count DESC
--             LIMIT 1) AS subquery) AS most_popular_route,
--     (
--         SELECT
--             route_code
--         FROM (
--             SELECT
--                 route_code,
--                 COUNT(*) AS route_count
--             FROM
--                 transactions_order
--                 INNER JOIN flight_schedule ON transactions_order.flight_code = flight_schedule.flight_code
--                 INNER JOIN route ON flight_schedule.route = route.route_code
--             WHERE
--                 booking_date >= CURRENT_DATE - interval '12 months'
--             GROUP BY
--                 route_code
--             ORDER BY
--                 route_count ASC
--             LIMIT 1) AS subquery) AS least_popular_route
-- FROM
--     transactions_order
--     INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
-- WHERE
--     booking_date >= CURRENT_DATE - interval '12 months'
--     AND status = 'Success';
CREATE OR REPLACE VIEW statistics_view AS
WITH last_year AS (
    SELECT
        EXTRACT(MONTH FROM CURRENT_DATE) AS current_month,
        EXTRACT(YEAR FROM CURRENT_DATE) AS current_year,
        CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 1
            AND EXTRACT(MONTH FROM CURRENT_DATE) <= 12 THEN
            TO_DATE((EXTRACT(YEAR FROM CURRENT_DATE) - 1)::text || '-' || EXTRACT(MONTH FROM CURRENT_DATE)::text, 'YYYY-MM')
        ELSE
            TO_DATE((EXTRACT(YEAR FROM CURRENT_DATE) - 1)::text || '-01', 'YYYY-MM')
        END AS start_date,
        CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 1
            AND EXTRACT(MONTH FROM CURRENT_DATE) <= 12 THEN
            TO_DATE((EXTRACT(YEAR FROM CURRENT_DATE) - 1)::text || '-' || EXTRACT(MONTH FROM CURRENT_DATE)::text, 'YYYY-MM') + INTERVAL '1 month' - INTERVAL '1 day'
        ELSE
            TO_DATE((EXTRACT(YEAR FROM CURRENT_DATE) - 1)::text || '-12-31', 'YYYY-MM')
        END AS end_date
)
SELECT
    -- Total Revenue
    COALESCE(SUM(
            CASE WHEN t.status = 'Success' THEN
                t.total_amount
            ELSE
                0
            END), 0) AS total_revenue,
    -- Number of Flights
    COALESCE(COUNT(fs.flight_code), 0) AS number_of_flights,
    -- Number of Tickets
    COALESCE(SUM(o.quantity), 0) AS number_of_tickets,
    -- Most Popular Routes
    r.route_code AS most_popular_route,
    COALESCE(COUNT(o.flight_code), 0) AS most_popular_route_tickets,
    -- Lowest Popular Routes
    r.route_code AS lowest_popular_route,
    COALESCE(COUNT(o.flight_code), 0) AS lowest_popular_route_tickets
FROM
    flight_schedule fs
    LEFT JOIN transactions_order o ON fs.flight_code = o.flight_code
    LEFT JOIN route r ON fs.route = r.route_code
    LEFT JOIN transactions t ON o.transaction_id = t.transaction_id
    CROSS JOIN last_year l
WHERE
    fs.departure_date BETWEEN l.start_date AND l.end_date
GROUP BY
    r.route_code
ORDER BY
    total_revenue DESC;
