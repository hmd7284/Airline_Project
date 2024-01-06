-- Fetch airport data
SELECT
    ap.*,
    c.city_name
FROM
    airport ap
    JOIN cities c ON ap.city = c.city_code;

-- 1. Add airport
-- 1.1 Check if airport exists
SELECT
    airport_code
FROM
    airport
WHERE
    airport_code = $1;

-- 1.2 Add airport
INSERT INTO airport (airport_code, airport_name, city)
    VALUES ($1, $2, $3)
RETURNING
    airport_code;

-- 2. Delete airport
-- 2.1 Check if airport exists
SELECT
    airport_code
FROM
    airport
WHERE
    airport_code = $1;

-- 2.2 Delete airport
DELETE FROM airport
WHERE airport_code = $1
RETURNING
    airport_code;
