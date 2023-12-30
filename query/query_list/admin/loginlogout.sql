-- Search for admin account in the database
SELECT
    *
FROM
    account
WHERE
    email = $1
    AND type = 'admin';
