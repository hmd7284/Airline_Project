CREATE INDEX cus_email_idx
ON account
USING HASH(email);

EXPLAIN ANALYZE SELECT * FROM account WHERE email = 'admin@gmail.com' AND type = 'admin';