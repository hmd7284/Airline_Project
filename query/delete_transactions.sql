-- Already set on delete cascade so when delete a record in transactions 
-- then all the records related in transactions_order will be delted too
--Create function update when delete
CREATE OR REPLACE FUNCTION update_on_deletion_trans_func() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE transactions SET total_amount = total_amount - OLD.total
    WHERE transaction_id = OLD.transaction_id;
    IF (OLD.type = 'Economy')
    THEN
        UPDATE flight_schedule SET economy_seat = economy_seat + OLD.quantity
        WHERE flight_code = OLD.flight_code;
    ELSE
        UPDATE flight_schedule SET business_seat = business_seat + OLD.quantity
        WHERE flight_code = OLD.flight_code;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
-- Create trigger to update value
CREATE OR REPLACE TRIGGER update_on_deletion_trans
AFTER DELETE ON transactions_order
FOR EACH ROW
EXECUTE PROCEDURE update_on_deletion_trans_func();