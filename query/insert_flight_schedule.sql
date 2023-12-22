CREATE OR REPLACE FUNCTION update_remaining_seat_func() RETURNS TRIGGER AS
$$
DECLARE remaining_seat INTEGER;
BEGIN
    remaining_seat := (SELECT capacity FROM aircraft WHERE aircraft_code = NEW.aircraft);
    UPDATE flight_schedule SET business_seat = 20, economy_seat = remaining_seat - 20
    WHERE flight_code = NEW.flight_code;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_remaining_seat
AFTER INSERT ON flight_schedule
FOR EACH ROW
EXECUTE PROCEDURE update_remaining_seat_func();

INSERT INTO flight_schedule VALUES('HNSG12', '2023-12-26', '3:00', '2023-12-26', '5:00', 'AC001', 'HANSGN', '0');

