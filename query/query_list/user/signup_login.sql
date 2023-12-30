-- I. Signup
-- 1. Check if email already exists
SELECT
    *
FROM
    account
WHERE
    email = $1
    AND type = 'customer'; -- $1 = email from user input

-- 2. Insert new account and retrieve account id
INSERT INTO account (email, password)
    VALUES ($1, $2) RETURNING id; -- $1 = email, $2 = password from user input

-- 4. Insert new customer
INSERT INTO customers (id, name, dob, address, phone_number)
    VALUES ($1, $2, $3, $4, $5);

-- $1 = account id, $2 = name, $3 = dob, $4 = address, $5 = phone number from user input
-- II. Login
-- 1. Check if email exists
SELECT
    *
FROM
    account
WHERE
    email = $1 AND type = 'customer'; -- $1 = email from user input
