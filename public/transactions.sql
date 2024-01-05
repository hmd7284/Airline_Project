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
    (currval('transactions_transaction_id_seq'), 'FL0003', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Business', 2);

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
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Business', 3);

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
    (currval('transactions_transaction_id_seq'), 'FL0003', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Business', 2);

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
    (currval('transactions_transaction_id_seq'), 'FL0004', 'Business', 3);

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
    (currval('transactions_transaction_id_seq'), 'FL0009', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0010', 'Business', 2);

-- Transaction 23
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 23, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0011', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0012', 'Business', 2);

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
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Business', 3),
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
    (currval('transactions_transaction_id_seq'), 'FL0009', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0010', 'Business', 2);

-- Transaction 31
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 31, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0011', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0012', 'Business', 2);

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
    (currval('transactions_transaction_id_seq'), 'FL0069', 'Business', 3),
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
    (currval('transactions_transaction_id_seq'), 'FL0009', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0010', 'Business', 2);

-- Transaction 39
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-19', 39, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0011', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0012', 'Business', 2);

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
VALUES ('2023-12-04', 44, 'Success', 'DIS30');

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
VALUES ('2023-12-06', 46, 'Failed', 'DIS50');

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
VALUES ('2023-12-08', 48, 'Success', 'DIS70');

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
VALUES ('2023-12-12', 52, 'Failed', 'DIS30');

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
VALUES ('2023-12-14', 54, 'Success', 'DIS50');

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
VALUES ('2023-12-16', 56, 'Success', 'DIS70');

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
VALUES ('2023-12-20', 60, 'Success', 'DIS30');

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
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Economy', 1);

-- Transaction 63
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-03', 63, 'Failed', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Business', 4),
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 3),
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Business', 2);

-- Transaction 64
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-04', 64, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Economy', 3);

-- Transaction 65
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-05', 65, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Business', 4);

-- Transaction 66
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-06', 66, 'Failed', 'DIS50');

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
VALUES ('2023-12-08', 68, 'Success', 'DIS70');

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
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Business', 3),
    (currval('transactions_transaction_id_seq'), 'FL0030', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0031', 'Economy', 1);

-- Transaction 71
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-11', 71, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0032', 'Economy', 4),
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Business', 2);

-- Transaction 72
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-12', 72, 'Failed', 'DIS30');

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
VALUES ('2023-12-14', 74, 'Success', 'DIS50');

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
VALUES ('2023-12-16', 76, 'Success', 'DIS70');

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
    (currval('transactions_transaction_id_seq'), 'FL0029', 'Business', 3),
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
VALUES ('2023-12-20', 80, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0033', 'Business', 1),
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
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Business', 2),
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
VALUES ('2023-12-24', 84, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0035', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0036', 'Economy', 3);

-- Thêm dữ liệu cho customer_id 85
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-25', 85, 'Success', NULL);

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0037', 'Business', 2),
    (currval('transactions_transaction_id_seq'), 'FL0038', 'Economy', 1),
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Business', 4);

-- Tiếp tục thêm dữ liệu cho các customer_id từ 86 đến 100
-- Copy các đoạn lệnh tương tự như trên và điều chỉnh customer_id và ngày đặt vé

-- Thêm dữ liệu cho customer_id 86
INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES ('2023-12-26', 86, 'Failed', 'DIS50');

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
VALUES ('2023-12-28', 88, 'Success', 'DIS70');

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
VALUES ('2024-01-01', 92, 'Failed', 'DIS30');

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
VALUES ('2024-01-03', 94, 'Success', 'DIS50');

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
VALUES ('2024-01-05', 96, 'Success', 'DIS70');

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
VALUES ('2024-01-09', 100, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (currval('transactions_transaction_id_seq'), 'FL0039', 'Business', 1),
    (currval('transactions_transaction_id_seq'), 'FL0040', 'Economy', 3);
