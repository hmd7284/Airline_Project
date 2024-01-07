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
    discount_code = $1;

--2.2 Add discount to database
INSERT INTO discount (discount_code, title, amount, description)
    VALUES ($1, $2, $3, $4)
RETURNING
    discount_code;

-- 3 . Delete discount from database
--3.1 Check if discount exists
SELECT
    title
FROM
    discount
WHERE
    discount_code = $1;

--3.2 Delete discount from database
DELETE FROM discount
WHERE discount_code = $1
RETURNING
    discount_code;
