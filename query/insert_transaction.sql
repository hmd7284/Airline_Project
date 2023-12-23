-- SET VALUE TO 1
SELECT setval('transactions_transaction_id_seq', 1, false);
-- Create function which update some values
CREATE OR REPLACE FUNCTION update_transaction_func() RETURNS TRIGGER AS
$$
DECLARE temp_route varchar(6); 
        temp_airfare varchar(7); 
        temp_price double precision;
        temp_discount integer;
BEGIN
    -- Define the airfare_code
    temp_route := (SELECT route FROM flight_schedule WHERE flight_code = NEW.flight_code);
    IF (NEW."TYPE" = 'Economy') THEN 
        temp_airfare := 'E' || temp_route; 
    ELSE
        temp_airfare := 'B' || temp_route;
    END IF;
    -- Define the price of the airfare
    temp_price = (SELECT price FROM airfare WHERE airfare_code = temp_airfare);
    -- Define the discount amount (if exist)
    temp_discount = (SELECT amount FROM discount 
                    WHERE discount_code = (SELECT discount FROM transactions
                                        WHERE transaction_id = NEW.transaction_id)); 
    IF (temp_discount IS NULL) 
    THEN 
        temp_discount := 0;
    END IF;
    -- Update the airfare, price, total of the table transactions_order
    UPDATE transactions_order SET airfare = temp_airfare,
                                price = temp_price,
                                total = NEW.quantity * temp_price * (100 - temp_discount) / 100.0
    WHERE order_id = NEW.order_id and transaction_id = NEW.transaction_id;
    -- Update the total_amoun of the table transactions
    UPDATE transactions SET total_amount = total_amount + (NEW.quantity * temp_price * (100 - temp_discount) / 100.0)
    WHERE transaction_id = NEW.transaction_id;
    -- Update the remaning seat of the flight
    IF (NEW."TYPE" = 'Economy') 
    THEN
        UPDATE flight_schedule SET economy_seat = economy_seat - NEW.quantity
        WHERE flight_code = NEW.flight_code;
    ELSE
        UPDATE flight_schedule SET business_seat = business_seat - NEW.quantity
        WHERE flight_code = NEW.flight_code;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
-- Create trigger to update value
CREATE OR REPLACE TRIGGER update_transaction
AFTER INSERT ON transactions_order
FOR EACH ROW
EXECUTE PROCEDURE update_transaction_func();

-- Insert table transactions first (the transactions_id can be automatically increased by 1)
-- NEED to set total = 0 when initializing and if dont have discount then set it to be NULL
INSERT INTO transactions(booking_date, customer_id, total_amount, discount) VALUES(current_date, '1', 0, null);
-- Then insert table transactions_order repectively from 1 ...
INSERT INTO transactions_order(order_id, transaction_id, flight_code, "TYPE", quantity)
VALUES('1', currval('transactions_transaction_id_seq'), 'FL001','Economy', 1);

INSERT INTO transactions_order(order_id, transaction_id, flight_code, "TYPE", quantity)
VALUES('2', currval('transactions_transaction_id_seq'), 'FL001','Business', 2);
