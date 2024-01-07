CREATE INDEX cus_email_idx
ON account
USING HASH(email);


CREATE INDEX ac_fs_idx
ON flight_schedule
USING HASH(aircraft);