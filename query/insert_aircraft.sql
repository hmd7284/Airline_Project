CREATE OR REPLACE FUNCTION cancel_flights_trigger ()
    RETURNS TRIGGER
    AS $$
BEGIN
    IF NEW.status = 'Inactive' THEN
        UPDATE
            flight_schedule
        SET
            status = 'Canceled'
        WHERE
            aircraft = NEW.aircraft_code
            AND CAST(departure_date || ' ' || departure_time AS timestamp) > current_timestamp(0);
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER cancel_flights_trigger
    AFTER UPDATE ON aircraft
    FOR EACH ROW
    EXECUTE FUNCTION cancel_flights_trigger ();

-- Insert some aircrafts
INSERT INTO aircraft
    VALUES ('AC001', 'Airbus A320', 150, 'Active', 'Airbus', '2020-01-15'),
    ('AC002', 'Boeing 737', 130, 'Active', 'Boeing', '2019-11-22'),
    ('AC003', 'Embraer E190', 110, 'Active', 'Embraer', '2018-08-10'),
    ('AC004', 'Bombardier CRJ900', 90, 'Active', 'Bombardier', '2021-03-05'),
    ('AC005', 'Airbus A350', 300, 'Active', 'Airbus', '2022-05-18'),
    ('AC006', 'Boeing 777', 250, 'Active', 'Boeing', '2017-12-30'),
    ('AC007', 'Airbus A330', 200, 'Active', 'Airbus', '2019-02-14'),
    ('AC008', 'Embraer E145', 50, 'Active', 'Embraer', '2020-08-03'),
    ('AC009', 'Bombardier Q400', 80, 'Active', 'Bombardier', '2016-06-25'),
    ('AC010', 'Boeing 747', 400, 'Active', 'Boeing', '2021-10-12'),
    ('AC011', 'Airbus A380', 500, 'Active', 'Airbus', '2018-04-09'),
    ('AC012', 'Embraer E170', 80, 'Active', 'Embraer', '2017-09-28'),
    ('AC013', 'Bombardier CRJ700', 70, 'Active', 'Bombardier', '2019-01-07'),
    ('AC014', 'Boeing 767', 180, 'Active', 'Boeing', '2022-08-20'),
    ('AC015', 'Airbus A319', 140, 'Active', 'Airbus', '2015-11-14'),
    ('AC016', 'Embraer E175', 90, 'Active', 'Embraer', '2020-04-30'),
    ('AC017', 'Bombardier Q300', 60, 'Active', 'Bombardier', '2018-02-12'),
    ('AC018', 'Boeing 787', 220, 'Active', 'Boeing', '2016-07-03'),
    ('AC019', 'Airbus A321', 200, 'Active', 'Airbus', '2019-05-25'),
    ('AC020', 'Embraer E195', 120, 'Active', 'Embraer', '2021-01-17'),
    ('AC021', 'Bombardier CRJ1000', 110, 'Active', 'Bombardier', '2017-10-08'),
    ('AC022', 'Boeing 737 MAX', 160, 'Active', 'Boeing', '2018-06-12'),
    ('AC023', 'Airbus A330neo', 250, 'Active', 'Airbus', '2022-02-28'),
    ('AC024', 'Embraer E140', 50, 'Active', 'Embraer', '2016-04-15'),
    ('AC025', 'Bombardier Q200', 40, 'Active', 'Bombardier', '2019-09-03'),
    ('AC026', 'Boeing 757', 160, 'Active', 'Boeing', '2020-11-09'),
    ('AC027', 'Airbus A300', 230, 'Active', 'Airbus', '2017-01-22'),
    ('AC028', 'Embraer E135', 40, 'Active', 'Embraer', '2018-03-05'),
    ('AC029', 'Bombardier CRJ200', 50, 'Active', 'Bombardier', '2021-07-14'),
    ('AC030', 'Boeing 737NG', 170, 'Active', 'Boeing', '2016-09-28'),
    ('AC031', 'Airbus A340', 280, 'Active', 'Airbus', '2019-04-10'),
    ('AC032', 'Embraer E150', 60, 'Active', 'Embraer', '2020-05-02'),
    ('AC033', 'Bombardier Q100', 30, 'Active', 'Bombardier', '2017-11-18'),
    ('AC034', 'Boeing 777X', 300, 'Active', 'Boeing', '2018-08-01'),
    ('AC035', 'Airbus A310', 180, 'Active', 'Airbus', '2022-01-05'),
    ('AC036', 'Embraer E155', 70, 'Active', 'Embraer', '2016-05-12'),
    ('AC037', 'Bombardier CRJ500', 40, 'Active', 'Bombardier', '2019-10-28'),
    ('AC038', 'Boeing 737 Classic', 150, 'Active', 'Boeing', '2020-12-15'),
    ('AC039', 'Airbus A330-200', 220, 'Active', 'Airbus', '2017-04-08'),
    ('AC040', 'Embraer E165', 80, 'Active', 'Embraer', '2018-06-30'),
    ('AC041', 'Bombardier CRJ800', 60, 'Active', 'Bombardier', '2021-02-14'),
    ('AC042', 'Boeing 767-300', 210, 'Active', 'Boeing', '2016-10-22'),
    ('AC043', 'Airbus A321neo', 220, 'Active', 'Airbus', '2019-03-15'),
    ('AC044', 'Embraer E180', 100, 'Active', 'Embraer', '2020-04-07'),
    ('AC045', 'Bombardier Q700', 70, 'Active', 'Bombardier', '2017-07-01'),
    ('AC046', 'Boeing 787-9', 240, 'Active', 'Boeing', '2018-09-14'),
    ('AC047', 'Airbus A319neo', 160, 'Active', 'Airbus', '2022-03-28'),
    ('AC048', 'Embraer E190-E2', 120, 'Active', 'Embraer', '2016-12-10'),
    ('AC049', 'Bombardier CRJ900 NextGen', 90, 'Active', 'Bombardier', '2019-05-02'),
    ('AC050', 'Boeing 737 MAX 8', 170, 'Active', 'Boeing', '2020-06-15'),
    ('AC051', 'Airbus A330-300', 260, 'Active', 'Airbus', '2017-09-08'),
    ('AC052', 'Embraer E195-E2', 140, 'Active', 'Embraer', '2018-10-30'),
    ('AC053', 'Bombardier Q400 NextGen', 100, 'Active', 'Bombardier', '2021-04-14'),
    ('AC054', 'Boeing 777-200', 250, 'Active', 'Boeing', '2016-01-22'),
    ('AC055', 'Airbus A350-900', 350, 'Active', 'Airbus', '2019-04-05'),
    ('AC056', 'Embraer E170-E2', 80, 'Active', 'Embraer', '2020-07-17'),
    ('AC057', 'Bombardier CRJ700 NextGen', 70, 'Active', 'Bombardier', '2017-08-30'),
    ('AC058', 'Boeing 747-400', 420, 'Active', 'Boeing', '2018-11-12'),
    ('AC059', 'Airbus A380-800', 550, 'Active', 'Airbus', '2022-04-25'),
    ('AC060', 'Embraer E175-E2', 100, 'Active', 'Embraer', '2016-03-08');
