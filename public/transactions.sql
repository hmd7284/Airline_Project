-- SET VALUE TO 1
SELECT
    setval('transactions_transaction_id_seq', 1, FALSE);
-- Transaction 1
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-01', 1, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0001', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0002', 'Economy', 1);

-- Transaction 2
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-02', 2, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0003', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Economy', 2);

-- Transaction 3
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 3, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0005', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0006', 'Business', 2);

-- Transaction 4
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-04', 4, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0061', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0062', 'Economy', 2);

-- Transaction 5
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-05', 5, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0063', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0064', 'Business', 3);

-- Transaction 6
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-06', 6, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0065', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Business', 1);

-- Transaction 7
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-07', 7, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0001', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0002', 'Business', 2);

-- Transaction 8
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-08', 8, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0003', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Economy', 3);

-- Transaction 9
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-09', 9, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0005', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0006', 'Economy', 1);

-- Transaction 10
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 10, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0061', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0062', 'Business', 1);

-- Transaction 11
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 11, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0001', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0002', 'Economy', 1);

-- Transaction 12
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 12, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0003', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Economy', 2);

-- Transaction 13
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 13, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0005', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0006', 'Business', 2);

-- Transaction 14
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-14', 14, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0061', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0062', 'Economy', 2);

-- Transaction 15
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 15, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0063', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0064', 'Business', 3);

-- Transaction 16
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 16, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0065', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Business', 1);

-- Transaction 17
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 17, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0001', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0002', 'Business', 2);

-- Transaction 18
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 18, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0003', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Economy', 3);

-- Transaction 19
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 19, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0005', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0006', 'Economy', 1);

-- Transaction 20
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 20, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0061', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0062', 'Business', 1);

-- Transaction 21
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-01', 21, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0007', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0008', 'Economy', 1);

-- Transaction 22
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-02', 22, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0009', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0010', 'Business', 2);

-- Transaction 23
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 23, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0011', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0012', 'Economy', 2);

-- Transaction 24
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-04', 24, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0013', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0014', 'Business', 2);

-- Transaction 25
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-05', 25, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0067', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0068', 'Economy', 1);

-- Transaction 26
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-06', 26, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0070', 'Business', 2);

-- Transaction 27
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-07', 27, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0071', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0072', 'Business', 2);

-- Transaction 28
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-08', 28, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0073', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0074', 'Business', 2);

-- Transaction 29
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-09', 29, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0007', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0008', 'Economy', 1);

-- Transaction 30
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 30, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0009', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0010', 'Business', 2);

-- Transaction 31
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 31, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0011', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0012', 'Economy', 2);

-- Transaction 32
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 32, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0013', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0014', 'Business', 2);

-- Transaction 33
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 33, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0067', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0068', 'Economy', 1);

-- Transaction 34
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-14', 34, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0070', 'Business', 2);

-- Transaction 35
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 35, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0071', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0072', 'Business', 2);

-- Transaction 36
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 36, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0073', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0074', 'Business', 2);

-- Transaction 37
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 37, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0007', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0008', 'Economy', 1);

-- Transaction 38
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 38, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0009', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0010', 'Business', 2);

-- Transaction 39
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 39, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0011', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0012', 'Economy', 2);

-- Transaction 40
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 40, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0013', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0014', 'Business', 2);

-- Transaction 41
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-01', 41, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Economy', 2);

-- Transaction 42
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-02', 42, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0019', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0020', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0021', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0022', 'Economy', 1);

-- Transaction 43
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 43, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Economy', 2);

-- Transaction 44
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-04', 44, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Economy', 1);

-- Transaction 45
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-05', 45, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0019', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0020', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0021', 'Economy', 1);

-- Transaction 46
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-06', 46, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0022', 'Business', 2);

-- Transaction 47
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-07', 47, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Economy', 1);

-- Transaction 48
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-08', 48, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Business', 2);

-- Transaction 49
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-09', 49, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Business', 2);

-- Transaction 50
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 50, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Business', 1);

-- Transaction 51
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 51, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0019', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0020', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0021', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0022', 'Business', 2);

-- Transaction 52
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 52, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Business', 2);

-- Transaction 53
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 53, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Business', 2);

-- Transaction 54
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-14', 54, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0019', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0020', 'Economy', 1);

-- Transaction 55
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 55, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0021', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0022', 'Economy', 2);

-- Transaction 56
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 56, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Economy', 1);

-- Transaction 57
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 57, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0019', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0020', 'Economy', 1);

-- Transaction 58
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 58, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0021', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0022', 'Business', 1);

-- Transaction 59
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 59, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0015', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0016', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0017', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0018', 'Business', 2);

-- Transaction 60
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 60, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0019', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0020', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0021', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0022', 'Business', 2);

-- Transaction 61
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-01', 61, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0026', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0027', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0028', 'Business', 3);

-- Transaction 62
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-02', 62, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Economy', 1);

-- Transaction 63
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 63, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Business', 4),
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Economy', 2);

-- Transaction 64
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-04', 64, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Economy', 3);

-- Transaction 65
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-05', 65, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Economy', 4);

-- Transaction 66
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-06', 66, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0026', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0027', 'Business', 1);

-- Transaction 67
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-07', 67, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0028', 'Economy', 4);

-- Transaction 68
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-08', 68, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0025', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0026', 'Economy', 2);

-- Transaction 69
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-09', 69, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0027', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0028', 'Economy', 3);

-- Transaction 70
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 70, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Economy', 1);

-- Transaction 71
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 71, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 4),
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Economy', 2);

-- Transaction 72
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 72, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0026', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0027', 'Economy', 3);

-- Transaction 73
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 73, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0028', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Economy', 1);

-- Transaction 74
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-14', 74, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Business', 4);

-- Transaction 75
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 75, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Business', 1);

-- Transaction 76
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 76, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0026', 'Business', 2);

-- Transaction 77
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 77, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0027', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0028', 'Economy', 4);

-- Transaction 78
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 78, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Economy', 2);

-- Transaction 79
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 79, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 3);

-- Transaction 80
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 80, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0026', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 81
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 81, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0034', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Business', 3);

-- Thêm dữ liệu cho customer_id 82
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 82, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 83 đến 100
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 83
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 83, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Business', 4),
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0034', 'Business', 2);

-- Thêm dữ liệu cho customer_id 84
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 84, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 85
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 85, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Business', 4);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 86 đến 100
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 86
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 86, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0034', 'Business', 1);

-- Thêm dữ liệu cho customer_id 87
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 87, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Economy', 4);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 88 đến 100
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé
-- Thêm dữ liệu cho customer_id 88
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 88, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 89
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 89, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Economy', 3);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 90 đến 100
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 90
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-30', 90, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0034', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 91
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-31', 91, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Economy', 4),
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 92 đến 100
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 92
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-01', 92, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 93
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-02', 93, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0034', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 94
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-03', 94, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 95
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-04', 95, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Business', 4);

-- Thêm dữ liệu cho customer_id 96
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-05', 96, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Business', 1);

-- Thêm dữ liệu cho customer_id 97
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-06', 97, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0034', 'Business', 2);

-- Thêm dữ liệu cho customer_id 98
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-07', 98, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Economy', 4);

-- Thêm dữ liệu cho customer_id 99
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-08', 99, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 100
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-09', 100, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 101
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-01', 101, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0041', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0042', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0043', 'Business', 3);

-- Thêm dữ liệu cho customer_id 102
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-02', 102, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0044', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0045', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 103
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 103, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0046', 'Business', 4),
    (currval('transactions_transaction_id_seq'), 'FL0047', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0048', 'Business', 2);

-- Thêm dữ liệu cho customer_id 104
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-04', 104, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0049', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0050', 'Economy', 3);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 105 đến 120
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 105
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-05', 105, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0041', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0042', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0043', 'Business', 4);

-- Thêm dữ liệu cho customer_id 106
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-06', 106, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0044', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0045', 'Business', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 107 đến 120
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 107
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-07', 107, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0046', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0047', 'Economy', 4);

-- Tiếp tục tương tự cho các customer_id từ 108 đến 120
-- Hãy tự điều chỉnh dữ liệu cho các customer_id còn lại tương ứng
-- Thêm dữ liệu cho customer_id 108
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-08', 108, 'Failed', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0048', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0049', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 109 đến 120
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 109
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-09', 109, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0050', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0041', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 110
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 110, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0042', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0043', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 111 đến 120
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 111
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 111, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0044', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0045', 'Economy', 4);


-- Thêm dữ liệu cho customer_id 112
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 112, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0046', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0047', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 113
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 113, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0048', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0049', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 114
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-14', 114, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0050', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0041', 'Economy', 3);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 115 đến 120
-- Bạn có thể copy các đoạn lệnh trên và điều chỉnh customer_id và thông tin khác tương ứng

-- Thêm dữ liệu cho customer_id 115
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 115, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0042', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0043', 'Economy', 2);

-- Tiếp tục tương tự cho các customer_id từ 116 đến 120
-- Hãy tự điều chỉnh dữ liệu cho các customer_id còn lại tương ứng

-- Thêm dữ liệu cho customer_id 116
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 116, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0044', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0045', 'Economy', 4);

-- Thêm dữ liệu cho customer_id 117
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 117, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0046', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0047', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 118
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 118, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0048', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0049', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 119
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 119, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0050', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0041', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 120
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 120, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0042', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0043', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 121
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 121, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0051', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0052', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 122
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 122, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0053', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0054', 'Economy', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 123, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0055', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0056', 'Economy', 2);

-- Tiếp tục cho các customer_id từ 124 đến 140
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 124, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0057', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0058', 'Economy', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 125, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0051', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0052', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0053', 'Business', 3);

-- Thêm dữ liệu cho customer_id 126
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 126, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0054', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0055', 'Business', 1);

-- Thêm dữ liệu cho customer_id 127
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 127, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0060', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0059', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0058', 'Business', 3);

-- Thêm dữ liệu cho customer_id 128
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 128, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0057', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0056', 'Business', 1);

-- Lặp lại cho các customer_id từ 129 đến 140
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 129, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0055', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0054', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0053', 'Business', 3);

-- ... Lặp lại cho các customer_id khác từ 130 đến 140

-- Thêm dữ liệu cho customer_id 140
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 140, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0052', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0051', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0060', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0059', 'Business', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 141, 'Success', NULL),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0067', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0070', 'Business', 1);

 INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 142, 'Success', DIS30),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0074', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0071', 'Economy', 1);   

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 143, 'Success', NULL),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0073', 'Business', 4);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 144, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Business', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 145, 'Success', DIS10);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0067', 'Economy', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 146, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 147, 'Success', DIS10);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0070', 'Economy', 3);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 148, 'Success', NULL),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0071', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0072', 'Economy', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 149, 'Success', NULL),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0073', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0074', 'Economy', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 150, 'Success', NULL),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0075', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0076', 'Business', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 151, 'Success', DIS70),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0077', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0078', 'Business', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-01', 152, 'Success', DIS70),

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0078', 'Business', 1);

-- Thêm dữ liệu cho customer_id 153
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 153, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0086', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0087', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 154
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 154, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0088', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Economy', 2);

-- Tiếp tục cho các customer_id từ 155 đến 170
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 155
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 155, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 156 đến 170...
-- Thêm dữ liệu cho customer_id 156
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 156, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0067', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 157
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 157, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0068', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 2);

-- Tiếp tục cho các customer_id từ 158 đến 170
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 158
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 158, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0070', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 159 đến 170...
-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 159 đến 170
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 159
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 159, 'Failed', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0076', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0077', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 160 đến 170...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 160
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-30', 160, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0078', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0079', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 161 đến 170...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 161
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-31', 161, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0080', 'Business', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-01', 162, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0066', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0067', 'Business', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-02', 163, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0068', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 164 đến 170
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 164
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-03', 164, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0070', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0071', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 165 đến 170...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 165
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-04', 165, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0072', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0073', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 166 đến 170...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 166
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-05', 166, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0074', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 167 đến 170...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 167
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-06', 167, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0075', 'Economy', 3);

-- Tiếp tục thêm dữ liệu cho customer_id 168, 169, và 170...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 168
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-07', 168, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0076', 'Business', 2);

-- Thêm dữ liệu cho customer_id 169
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-08', 169, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0077', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 170
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-09', 170, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0078', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0079', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 170 đến 180
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 171
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-10', 171, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0081', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0082', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 172 đến 180...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 172
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-11', 172, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0083', 'Business', 2);

-- Thêm dữ liệu cho customer_id 173
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-12', 173, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0084', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 174 đến 180...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 174
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-13', 174, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0085', 'Business', 1);

-- Thêm dữ liệu cho customer_id 175
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-14', 175, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0081', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 176 đến 180...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 176
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-15', 176, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0082', 'Business', 1);

-- Thêm dữ liệu cho customer_id 177
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-16', 177, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0083', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 178 đến 180...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 178
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-17', 178, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0084', 'Business', 2);

-- Thêm dữ liệu cho customer_id 179
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-18', 179, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0085', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 180
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-19', 180, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0081', 'Business', 2);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-20', 181, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0086', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0087', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 182 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 182
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-21', 182, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0088', 'Business', 2);

-- Thêm dữ liệu cho customer_id 183
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-22', 183, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 184 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 184
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-23', 184, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0086', 'Business', 1);

-- Thêm dữ liệu cho customer_id 185
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-24', 185, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0087', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 186 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 186
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-25', 186, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0088', 'Business', 1);

-- Thêm dữ liệu cho customer_id 187
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-26', 187, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 188 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 188
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-27', 188, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0086', 'Business', 2);

-- Thêm dữ liệu cho customer_id 189
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-28', 189, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0087', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 190
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-29', 190, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0088', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 191 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 191
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-30', 191, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 192
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-01-31', 192, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0086', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 193 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 193
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-01', 193, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0087', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 194
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-02', 194, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0088', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 195 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 195
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-03', 195, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Business', 1);

-- Thêm dữ liệu cho customer_id 196
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-04', 196, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0086', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 197 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 197
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-05', 197, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0087', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 198
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-06', 198, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0088', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 199 đến 200...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 199
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-07', 199, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Business', 1);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2024-12-07', 200, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0089', 'Business', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 201 đến 210
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 201
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-10', 201, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 202
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 202, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 203 đến 210...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 203
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 203, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 204
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-13', 204, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Economy', 3);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 205 đến 210...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 205
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-14', 205, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Business', 2);

-- Thêm dữ liệu cho customer_id 206
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-15', 206, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 207
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-16', 207, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Business', 3);

-- Thêm dữ liệu cho customer_id 208
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-17', 208, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 209
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-18', 209, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Business', 1);

-- Thêm dữ liệu cho customer_id 210
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 210, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 211 đến 220
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 211
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 211, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 212
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 212, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 213 đến 220...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 213
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 213, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 214
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 214, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Business', 2);

-- Thêm dữ liệu cho customer_id 215
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 215, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 216
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 216, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Business', 2);

-- Thêm dữ liệu cho customer_id 217
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 217, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 218
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 218, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 3);

-- Thêm dữ liệu cho customer_id 219
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 219, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 220
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 220, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Business', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 221 đến 230
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 221
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-30', 221, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Business', 2);

-- Thêm dữ liệu cho customer_id 222
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-31', 222, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 223 đến 230...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 223
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-30', 223, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 224
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 224, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Business', 2);

-- Thêm dữ liệu cho customer_id 225
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 225, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 226
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 226, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 227
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 227, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Business', 3);

-- Thêm dữ liệu cho customer_id 228
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 228, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 229
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 229, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Business', 1);

-- Thêm dữ liệu cho customer_id 230
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 230, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 231 đến 240
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 231
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-30', 231, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Business', 2);

-- Thêm dữ liệu cho customer_id 232
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-31', 232, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0097', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0098', 'Business', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 233 đến 240...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 233
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-30', 233, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0090', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 234
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 234, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0091', 'Business', 2);

-- Thêm dữ liệu cho customer_id 235
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 235, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0092', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 236
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 236, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0093', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0094', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 237
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 237, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 3);

-- Thêm dữ liệu cho customer_id 238
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 238, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 239
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 239, 'Failed', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0097', 'Business', 1);

-- Thêm dữ liệu cho customer_id 240
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 240, 'Success', null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0098', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 241 đến 250
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 241
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 241, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0099', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0100', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 242
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 242, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0099', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 243
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 243, 'Failed', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0100', 'Business', 2);

-- Thêm dữ liệu cho customer_id 244
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 244, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0099', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0100', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 245
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 245, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0099', 'Business', 1);

-- Thêm dữ liệu cho customer_id 246
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 246, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0100', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 247
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 247, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0099', 'Business', 1);

-- Thêm dữ liệu cho customer_id 248
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 248, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0100', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 249
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 249, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0099', 'Business', 1);

-- Thêm dữ liệu cho customer_id 250
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 250, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0100', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 251 đến 260
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 251
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 251, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 252
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 252, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 253
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 253, 'Failed', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Business', 2);

-- Thêm dữ liệu cho customer_id 254
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 254, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 255
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 255, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 1);

-- Thêm dữ liệu cho customer_id 256
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 256, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 257
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 257, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 1);

-- Thêm dữ liệu cho customer_id 258
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 258, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 259
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 259, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0095', 'Business', 1);

-- Thêm dữ liệu cho customer_id 260
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 260, 'Success', Null);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0096', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 261 đến 270
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 261
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 261, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0101', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0102', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 262
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 262, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0101', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 263
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 263, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0102', 'Business', 2);

-- Thêm dữ liệu cho customer_id 264
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 264, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0101', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0102', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 265
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 265, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0101', 'Business', 1);

-- Thêm dữ liệu cho customer_id 266
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 266, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0102', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 267
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 267, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0101', 'Business', 1);

-- Thêm dữ liệu cho customer_id 268
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 268, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0102', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 269
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 269, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0101', 'Business', 1);

-- Thêm dữ liệu cho customer_id 270
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 270, 'Success', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0102', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 271 đến 280
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 271
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 271, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 272
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 272, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 273
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 273, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0105', 'Business', 2);

-- Thêm dữ liệu cho customer_id 274
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 274, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 275
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 275, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 1);

-- Thêm dữ liệu cho customer_id 276
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 276, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 277
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 277, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 1);

-- Thêm dữ liệu cho customer_id 278
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 278, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 279
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 279, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 1);

-- Thêm dữ liệu cho customer_id 280
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 280, 'Success', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0105', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 281 đến 290
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 281
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-20', 281, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 282
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-21', 282, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 283
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-22', 283, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0105', 'Business', 2);

-- Thêm dữ liệu cho customer_id 284
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-23', 284, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 285
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-24', 285, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 1);

-- Thêm dữ liệu cho customer_id 286
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 286, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 287
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 287, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 1);

-- Thêm dữ liệu cho customer_id 288
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-27', 288, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0104', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 289
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-28', 289, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0103', 'Business', 1);

-- Thêm dữ liệu cho customer_id 290
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-29', 290, 'Success', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0105', 'Economy', 2);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 291 đến 300
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 291
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-01', 291, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0106', 'Business', 2);

-- Thêm dữ liệu cho customer_id 292
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-02', 292, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0107', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 293
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-03', 293, 'Failed', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0106', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0107', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 294
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-04', 294, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0106', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 295
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-05', 295, 'Success', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0107', 'Business', 1);

-- Thêm dữ liệu cho customer_id 296
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-06', 296, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0106', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 297
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-07', 297, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0107', 'Business', 2);

-- Thêm dữ liệu cho customer_id 298
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-08', 298, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0106', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 299
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-09', 299, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0107', 'Business', 2);

-- Thêm dữ liệu cho customer_id 300
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-01-10', 300, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0106', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 301 đến 310
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 301
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-01', 301, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0108', 'Business', 2);

-- Thêm dữ liệu cho customer_id 302
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-02', 302, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0109', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 303
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-03', 303, 'Failed', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0108', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0109', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 304
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-04', 304, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0108', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 305
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-05', 305, 'Success', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0109', 'Business', 1);

-- Thêm dữ liệu cho customer_id 306
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-06', 306, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0108', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 307
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-07', 307, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0109', 'Business', 2);

-- Thêm dữ liệu cho customer_id 308
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-08', 308, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0108', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 309
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-09', 309, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0109', 'Business', 2);

-- Thêm dữ liệu cho customer_id 310
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-10', 310, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0108', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 311 đến 320
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 311
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-11', 311, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0110', 'Business', 2);

-- Thêm dữ liệu cho customer_id 312
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-12', 312, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0111', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 313
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-13', 313, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0112', 'Business', 2);

-- Thêm dữ liệu cho customer_id 314
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-14', 314, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0110', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 315
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-15', 315, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0111', 'Business', 1);

-- Thêm dữ liệu cho customer_id 316
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-16', 316, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0112', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 317
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-17', 317, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0110', 'Business', 2);

-- Thêm dữ liệu cho customer_id 318
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-18', 318, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0111', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 319
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-19', 319, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0112', 'Business', 2);

-- Thêm dữ liệu cho customer_id 320
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-02-20', 320, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0110', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 321 đến 330
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 321
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-01', 321, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0113', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0114', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 322
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-02', 322, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0115', 'Business', 1);

-- Thêm dữ liệu cho customer_id 323
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-03', 323, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0113', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0114', 'Business', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 324 đến 330...
-- (Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id)

-- Thêm dữ liệu cho customer_id 324
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-04', 324, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0115', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 325
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-05', 325, 'Failed', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0113', 'Business', 2);

-- Thêm dữ liệu cho customer_id 326
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-06', 326, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0114', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 327
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-07', 327, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0115', 'Business', 2);

-- Thêm dữ liệu cho customer_id 328
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-08', 328, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0113', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 329
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-09', 329, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0114', 'Business', 2);

-- Thêm dữ liệu cho customer_id 330
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-10', 330, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0115', 'Economy', 1);

-- Tiếp tục thêm dữ liệu cho các customer_id còn lại từ 331 đến 340
-- Đổi giá trị của booking_date và flight_code ngẫu nhiên cho mỗi customer_id
-- Đảm bảo giữ nguyên cấu trúc của các câu lệnh INSERT

-- Thêm dữ liệu cho customer_id 331
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-11', 331, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0110', 'Business', 1);

-- Thêm dữ liệu cho customer_id 332
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-12', 332, 'Failed', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0111', 'Economy', 2),
    (currval('transactions_transaction_id_seq'), 'FL0112', 'Business', 1);

-- Thêm dữ liệu cho customer_id 333
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-13', 333, 'Success', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0113', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0114', 'Business', 2);

-- Thêm dữ liệu cho customer_id 334
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-14', 334, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0115', 'Business', 3);

-- Thêm dữ liệu cho customer_id 335
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-15', 335, 'Failed', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0110', 'Economy', 2);

-- Thêm dữ liệu cho customer_id 336
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-16', 336, 'Success', 'DIS70');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0111', 'Business', 2);

-- Thêm dữ liệu cho customer_id 337
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-17', 337, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0112', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 338
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-18', 338, 'Failed', 'DIS10');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0113', 'Business', 2);

-- Thêm dữ liệu cho customer_id 339
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-19', 339, 'Success', 'DIS50');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0114', 'Economy', 1);

-- Thêm dữ liệu cho customer_id 340
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-03-20', 340, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0115', 'Business', 1);
