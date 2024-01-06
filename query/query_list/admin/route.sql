-- Fetch route data
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

-- 1. Add route:
-- 1.1 Check if route already exists
SELECT
    origin
FROM
    route
WHERE
    route_code = $1;

-- 1.2 Check if origin exists
SELECT
    airport_name
FROM
    airport
WHERE
    airport_code = $1;

-- 1.3 Check if destination exists
SELECT
    airport_name
FROM
    airport
WHERE
    airport_code = $1;

-- 1.4 Add route
INSERT INTO route (route_code, origin, destination)
    VALUES ($1, $2, $3)
RETURNING
    route_code;

-- 2. Delete route:
-- 2.1 Check if route exists
SELECT
    origin
FROM
    route
WHERE
    route_code = $1;

-- 2.2 Delete route
DELETE FROM route
WHERE route_code = $1
RETURNING
    route_code;
