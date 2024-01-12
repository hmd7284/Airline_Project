--DATABASE DEFINTION
-- Create Database
DROP DATABASE IF EXISTS airline;

CREATE DATABASE airline;

\c airline
-- Create Tables
CREATE TABLE aircraft (
    aircraft_code varchar(5) PRIMARY KEY,
    aircraft_name varchar(255) NOT NULL,
    capacity int NOT NULL,
    status varchar(30) NOT NULL,
    mfd_com varchar(30) NOT NULL,
    mfd_date date NOT NULL,
    CONSTRAINT ac_stt_check CHECK (status = 'Inactive' OR status = 'Active')
);

CREATE TABLE countries (
    country_code varchar(3) PRIMARY KEY,
    country_name varchar(255) NOT NULL
);

CREATE TABLE cities (
    city_code varchar(3) PRIMARY KEY,
    city_name varchar(255) NOT NULL,
    country varchar(3) NOT NULL,
    CONSTRAINT cit_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE airport (
    airport_code varchar(3) PRIMARY KEY,
    airport_name varchar(255) NOT NULL,
    address varchar(255),
    city varchar(3) NOT NULL,
    CONSTRAINT ap_ct_fk FOREIGN KEY (city) REFERENCES cities (city_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE account (
    id serial PRIMARY KEY,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    type varchar(8) DEFAULT 'customer',
    CONSTRAINT chk_type CHECK (type = 'admin' OR type = 'customer')
);

CREATE TABLE customers (
    id int PRIMARY KEY,
    name varchar(255) NOT NULL,
    dob date NOT NULL,
    address varchar(255) NOT NULL,
    phone_number varchar(12),
    CONSTRAINT cus_acc_fk FOREIGN KEY (id) REFERENCES account (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE route(
    route_code varchar(6) PRIMARY KEY,
    origin varchar(3) NOT NULL,
    destination varchar(3) NOT NULL,
    CONSTRAINT rto_ap_fk FOREIGN KEY (origin) REFERENCES airport (airport_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT rtd_ap_fk FOREIGN KEY (destination) REFERENCES airport (airport_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE airfare (
    airfare_code varchar(7) PRIMARY KEY,
    type VARCHAR(30) NOT NULL,
    route varchar(6) NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT af_rt_fk FOREIGN KEY (route) REFERENCES route (route_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT af_type_check CHECK (type = 'Economy' OR type = 'Business')
);

CREATE TABLE employee (
    employee_id integer PRIMARY KEY NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL, 
    gender character varying(7) NOT NULL,
    address character varying(255) NOT NULL,
    phone_number character varying(12) NOT NULL,
    ssn character varying(255) NOT NULL,
    email character varying(255),
    password character varying(255) DEFAULT '1'::character varying,
    CONSTRAINT gender_check CHECK(gender = 'Female' or gender = 'Male')
);

CREATE TABLE flight_schedule (
    flight_code varchar(7) PRIMARY KEY,
    departure_date date NOT NULL,
    departure_time time NOT NULL,
    arrival_date date NOT NULL,
    arrival_time time NOT NULL,
    status varchar(30) DEFAULT 'Success',
    aircraft varchar(5) NOT NULL,
    route varchar(6) NOT NULL,
    business_seat integer,
    economy_seat integer,
    CONSTRAINT fsch_acr_fk FOREIGN KEY (aircraft) REFERENCES aircraft (aircraft_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fsch_rt_fk FOREIGN KEY (route) REFERENCES route (route_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fsch_check CHECK (arrival_date >= departure_date),
    CONSTRAINT fsch_check_stt CHECK (status = 'Success' OR status = 'Canceled')
);

CREATE TABLE flight_staff (
    flight_code varchar(7) NOT NULL,
    employee_id int NOT NULL,
    PRIMARY KEY (flight_code, employee_id),
    CONSTRAINT staff_sch_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT staff_em_fk FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE discount (
    discount_code varchar(5) PRIMARY KEY,
    title varchar(255) NOT NULL,
    amount int NOT NULL,
    description text
);

-- Create the transactions table
CREATE TABLE transactions (
    transaction_id serial PRIMARY KEY,
    booking_date date NOT NULL,
    customer_id int NOT NULL,
    status varchar(10) DEFAULT 'Success',
    discount varchar(5),
    total_amount double precision DEFAULT 0,
    CONSTRAINT check_status CHECK (status = 'Success' OR status = 'Failed'),
    CONSTRAINT trans_dis_fk FOREIGN KEY (discount) REFERENCES discount (discount_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT trans_cus_fk FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the transactions_order table
CREATE TABLE transactions_order (
    order_id serial,
    transaction_id integer REFERENCES transactions (transaction_id) ON DELETE CASCADE ON UPDATE CASCADE,
    flight_code varchar(7) NOT NULL,
    type VARCHAR(30),
    airfare varchar(7),
    price double precision,
    quantity integer NOT NULL,
    total double precision,
    CONSTRAINT trans_order_pk PRIMARY KEY (transaction_id, order_id),
    CONSTRAINT order_flight_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT order_airfare_fk FOREIGN KEY (airfare) REFERENCES airfare (airfare_code) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT af_type_check CHECK (type = 'Economy' OR type = 'Business')
);
--Admin account
INSERT INTO account VALUES(1, 'admin@gmail.com', 'admin', 'admin');

--TRIGGER AND VIEWS
--1. Auto update address of the airport after insert a new flight
--Create trigger function
CREATE OR REPLACE FUNCTION update_address ()
    RETURNS TRIGGER
    AS $$
BEGIN
    UPDATE
        airport
    SET
        address = (
            SELECT
                city_name || ', ' || country_name
            FROM
                cities
                JOIN countries ON cities.country = countries.country_code
            WHERE
                cities.city_code = NEW.city)
    WHERE
        airport.city = NEW.city;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

--Create trigger
CREATE OR REPLACE TRIGGER update_address
    AFTER INSERT ON airport
    FOR EACH ROW
    EXECUTE FUNCTION update_address ();

--2. Auto cancel flight when aircraft becomes ‘Inactive’
--Create trigger function
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

--Create trigger
CREATE OR REPLACE TRIGGER cancel_flights_trigger
    AFTER UPDATE ON aircraft
    FOR EACH ROW
    EXECUTE FUNCTION cancel_flights_trigger ();

--3. Auto update original remaining seat when insert a new flight
--Create trigger function
CREATE OR REPLACE FUNCTION update_remaining_seat_func ()
    RETURNS TRIGGER
    AS $$
DECLARE
    remaining_seat integer;
BEGIN
    remaining_seat := (
        SELECT
            capacity
        FROM
            aircraft
        WHERE
            aircraft_code = NEW.aircraft);
    UPDATE
        flight_schedule
    SET
        business_seat = (remaining_seat * 30 / 100),
        economy_seat = remaining_seat - (remaining_seat * 30 / 100)
    WHERE
        flight_code = NEW.flight_code;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

--Create trigger
CREATE OR REPLACE TRIGGER update_remaining_seat
    AFTER INSERT ON flight_schedule
    FOR EACH ROW
    EXECUTE PROCEDURE update_remaining_seat_func ();

--4. Trigger to check if the new aircraft is ‘Inactive’ or not
--when insert/update new aircraft of a flight
--Create trigger function
CREATE OR REPLACE FUNCTION check_insert_update_ac_func ()
    RETURNS TRIGGER
    AS $$
BEGIN
    IF ((
        SELECT
            status
        FROM
            aircraft
        WHERE
            aircraft_code = NEW.aircraft) = 'Inactive') THEN
        RETURN NULL;
    ELSE
        RETURN NEW;
    END IF;
END;
$$
LANGUAGE plpgsql;

--Create trigger
CREATE OR REPLACE TRIGGER check_insert_ac
    BEFORE INSERT ON flight_schedule
    FOR EACH ROW
    EXECUTE PROCEDURE check_insert_update_ac_func ();

--Create trigger
CREATE OR REPLACE TRIGGER check_update_ac
    BEFORE UPDATE ON flight_schedule
    FOR EACH ROW
    WHEN (OLD.aircraft IS DISTINCT FROM NEW.aircraft)
    EXECUTE PROCEDURE check_insert_update_ac_func ();

--5.Auto delete orders of customers which have the status of the flight is ‘Canceled’
--Create trigger function
CREATE OR REPLACE FUNCTION delete_order_trigger ()
    RETURNS TRIGGER
    AS $$
BEGIN
    -- Check if the flight status is being set to 'Canceled'
    IF NEW.status = 'Canceled' AND OLD.status != 'Canceled' THEN
        -- Delete all orders related to the canceled flight
        DELETE FROM transactions_order
        WHERE flight_code = NEW.flight_code;
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

--Create trigger
CREATE OR REPLACE TRIGGER delete_order_trigger
    AFTER UPDATE ON flight_schedule
    FOR EACH ROW
    EXECUTE FUNCTION delete_order_trigger ();

--6. Auto set order_id becomes 1 when a new transaction is added
--Create trigger function
CREATE OR REPLACE FUNCTION reset_order_id_sequence ()
    RETURNS TRIGGER
    AS $$
BEGIN
    -- Reset the sequence to 1
    EXECUTE 'ALTER SEQUENCE transactions_order_order_id_seq RESTART WITH 1';
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

--Create trigger
CREATE TRIGGER reset_order_id_trigger
    AFTER INSERT ON transactions
    FOR EACH STATEMENT
    EXECUTE FUNCTION reset_order_id_sequence ();

--7. Auto update airfare and total in the order of a transaction
--then add the total to the total amount, and update the remaining seat
--Create trigger function
CREATE OR REPLACE FUNCTION update_transaction_func ()
    RETURNS TRIGGER
    AS $$
DECLARE
    temp_route varchar(6);
    temp_airfare varchar(7);
    temp_price double precision;
    temp_discount integer;
BEGIN
    -- Define the airfare_code
    temp_route := (
        SELECT
            route
        FROM
            flight_schedule
        WHERE
            flight_code = NEW.flight_code);
    IF (NEW.type = 'Economy') THEN
        temp_airfare := 'E' || temp_route;
    ELSE
        temp_airfare := 'B' || temp_route;
    END IF;
    -- Define the price of the airfare
    temp_price = (
        SELECT
            price
        FROM
            airfare
        WHERE
            airfare_code = temp_airfare);
    -- Define the discount amount (if exist)
    temp_discount = (
        SELECT
            amount
        FROM
            discount
        WHERE
            discount_code = (
                SELECT
                    discount
                FROM
                    transactions
                WHERE
                    transaction_id = NEW.transaction_id));
    IF (temp_discount IS NULL) THEN
        temp_discount := 0;
    END IF;
    -- Update the airfare, price, total of the table transactions_order
    UPDATE
        transactions_order
    SET
        airfare = temp_airfare,
        price = temp_price,
        total = NEW.quantity * temp_price * (100 - temp_discount) / 100.0
    WHERE
        order_id = NEW.order_id
        AND transaction_id = NEW.transaction_id;
    -- Update the total_amoun of the table transactions
    UPDATE
        transactions
    SET
        total_amount = total_amount + (NEW.quantity * temp_price * (100 - temp_discount) / 100.0)
    WHERE
        transaction_id = NEW.transaction_id;
    -- Update the remaning seat of the flight
    IF (NEW.type = 'Economy') THEN
        UPDATE
            flight_schedule
        SET
            economy_seat = economy_seat - NEW.quantity
        WHERE
            flight_code = NEW.flight_code;
    ELSE
        UPDATE
            flight_schedule
        SET
            business_seat = business_seat - NEW.quantity
        WHERE
            flight_code = NEW.flight_code;
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- Create trigger to update value
CREATE OR REPLACE TRIGGER update_transaction
    AFTER INSERT ON transactions_order
    FOR EACH ROW
    EXECUTE PROCEDURE update_transaction_func ();

--8. Auto return total amount, the remaining seat when delete a order of a transaction and
--if there’s no order in the transaction, that transaction will become ‘Failed’
--Create trigger function
CREATE OR REPLACE FUNCTION update_on_deletion_trans_func ()
    RETURNS TRIGGER
    AS $$
DECLARE
    total_orders int;
BEGIN
    SELECT
        COUNT(order_id) INTO total_orders
    FROM
        transactions_order
    WHERE
        transaction_id = OLD.transaction_id;
    UPDATE
        transactions
    SET
        total_amount = total_amount - OLD.total
    WHERE
        transaction_id = OLD.transaction_id;
    IF (OLD.type = 'Economy') THEN
        UPDATE
            flight_schedule
        SET
            economy_seat = economy_seat + OLD.quantity
        WHERE
            flight_code = OLD.flight_code;
    ELSE
        UPDATE
            flight_schedule
        SET
            business_seat = business_seat + OLD.quantity
        WHERE
            flight_code = OLD.flight_code;
    END IF;
    IF (total_orders = 0) THEN
        UPDATE
            transactions
        SET
            status = 'Failed'
        WHERE
            transaction_id = OLD.transaction_id;
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- Create trigger to update value
CREATE OR REPLACE TRIGGER update_on_deletion_trans
    AFTER DELETE ON transactions_order
    FOR EACH ROW
    EXECUTE PROCEDURE update_on_deletion_trans_func ();
--9.The airline_insights view analyzes the airline's transactions over the past 12 months, 
--providing key metrics such as total revenue, the number of flights, tickets booked, the most and least popular routes. 
CREATE OR REPLACE VIEW airline_insights AS
SELECT
    EXTRACT(YEAR FROM booking_date) AS year,
    EXTRACT(MONTH FROM booking_date) AS month,
    SUM(total_amount) AS total_revenue,
    COUNT(DISTINCT flight_code) AS number_of_flights,
    SUM(quantity) AS number_of_tickets,
    (
        SELECT
            route_code
        FROM (
            SELECT
                route_code,
                COUNT(*) AS route_count
            FROM
                transactions_order
                INNER JOIN flight_schedule ON transactions_order.flight_code = flight_schedule.flight_code
                INNER JOIN route ON flight_schedule.route = route.route_code
                INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
            WHERE
                EXTRACT(YEAR FROM booking_date) = EXTRACT(YEAR FROM CURRENT_DATE)
                AND EXTRACT(MONTH FROM booking_date) = EXTRACT(MONTH FROM CURRENT_DATE)
            GROUP BY
                route_code
            ORDER BY
                route_count DESC
            LIMIT 1) AS subquery) AS most_popular_route,
    (
        SELECT
            route_code
        FROM (
            SELECT
                route_code,
                COUNT(*) AS route_count
            FROM
                transactions_order
                INNER JOIN flight_schedule ON transactions_order.flight_code = flight_schedule.flight_code
                INNER JOIN route ON flight_schedule.route = route.route_code
                INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
            WHERE
                EXTRACT(YEAR FROM booking_date) = EXTRACT(YEAR FROM CURRENT_DATE)
                AND EXTRACT(MONTH FROM booking_date) = EXTRACT(MONTH FROM CURRENT_DATE)
            GROUP BY
                route_code
            ORDER BY
                route_count ASC
            LIMIT 1) AS subquery) AS least_popular_route
FROM
    transactions_order
    INNER JOIN transactions ON transactions_order.transaction_id = transactions.transaction_id
WHERE
    booking_date >= CURRENT_DATE - interval '12 months'
    AND status = 'Success'
GROUP BY
    EXTRACT(YEAR FROM booking_date),
EXTRACT(MONTH FROM booking_date);

--10 Auto create email for employee
--Create trigger function
CREATE OR REPLACE FUNCTION create_emp_email_func ()
    RETURNS TRIGGER
    AS $$
BEGIN
    UPDATE employee 
    SET email = REPLACE(lower(NEW.first_name) || lower(NEW.last_name) || employee_id || '@kdd.airline.com', ' ', '')
    WHERE employee_id = NEW.employee_id;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--Create trigger
CREATE OR REPLACE TRIGGER create_emp_email
    AFTER INSERT ON employee
    FOR EACH ROW
    EXECUTE PROCEDURE create_emp_email_func ();