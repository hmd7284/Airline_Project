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

--10 Auto create email for employee
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

CREATE OR REPLACE TRIGGER create_emp_email
    AFTER INSERT ON employee
    FOR EACH ROW
    EXECUTE PROCEDURE create_emp_email_func ();
