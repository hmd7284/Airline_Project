-- SET VALUE TO 1
SELECT
    setval('transactions_transaction_id_seq', 1, FALSE);

INSERT INTO transactions (booking_date, customer_id, status, discount)
VALUES
    ('2023-12-01', 1, 'Success', NULL),
    ('2023-12-02', 2, 'Success', NULL),
    ('2023-12-03', 3, 'Success', NULL),
    ('2023-12-04', 4, 'Success', NULL),
    ('2023-12-05', 5, 'Success', NULL),
    ('2023-12-06', 6, 'Success', NULL),
    ('2023-12-07', 7, 'Success', NULL),
    ('2023-12-08', 8, 'Success', NULL),
    ('2023-12-09', 9, 'Success', NULL),
    ('2023-12-10', 10, 'Success', NULL),
    ('2023-12-11', 11, 'Success', NULL),
    ('2023-12-12', 12, 'Success', NULL),
    ('2023-12-13', 13, 'Success', NULL),
    ('2023-12-14', 14, 'Success', NULL),
    ('2023-12-15', 15, 'Success', NULL),
    ('2023-12-16', 16, 'Success', NULL),
    ('2023-12-17', 17, 'Success', NULL),
    ('2023-12-18', 18, 'Success', NULL),
    ('2023-12-19', 19, 'Success', NULL),
    ('2023-12-20', 20, 'Success', NULL),
    ('2023-12-01', 21, 'Success', NULL),
    ('2023-12-02', 22, 'Success', NULL),
    ('2023-12-03', 23, 'Success', NULL),
    ('2023-12-04', 24, 'Success', NULL),
    ('2023-12-05', 25, 'Success', NULL),
    ('2023-12-06', 26, 'Success', NULL),
    ('2023-12-07', 27, 'Success', NULL),
    ('2023-12-08', 28, 'Success', NULL),
    ('2023-12-09', 29, 'Success', NULL),
    ('2023-12-10', 30, 'Success', NULL),
    ('2023-12-11', 31, 'Success', NULL),
    ('2023-12-12', 32, 'Success', NULL),
    ('2023-12-13', 33, 'Success', NULL),
    ('2023-12-14', 34, 'Success', NULL),
    ('2023-12-15', 35, 'Success', NULL),
    ('2023-12-16', 36, 'Success', NULL),
    ('2023-12-17', 37, 'Success', NULL),
    ('2023-12-18', 38, 'Success', NULL),
    ('2023-12-19', 39, 'Success', NULL),
    ('2023-12-20', 40, 'Success', NULL),
    ('2023-12-01', 41, 'Success', NULL),
    ('2023-12-02', 42, 'Success', 'DIS10'),
    ('2023-12-03', 43, 'Failed', NULL),
    ('2023-12-04', 44, 'Success', 'DIS30'),
    ('2023-12-05', 45, 'Success', NULL),
    ('2023-12-06', 46, 'Failed', 'DIS50'),
    ('2023-12-07', 47, 'Success', NULL),
    ('2023-12-08', 48, 'Success', 'DIS70'),
    ('2023-12-09', 49, 'Failed', NULL),
    ('2023-12-10', 50, 'Success', 'DIS10'),
    ('2023-12-11', 51, 'Success', NULL),
    ('2023-12-12', 52, 'Failed', 'DIS30'),
    ('2023-12-13', 53, 'Success', NULL),
    ('2023-12-14', 54, 'Success', 'DIS50'),
    ('2023-12-15', 55, 'Failed', NULL),
    ('2023-12-16', 56, 'Success', 'DIS70'),
    ('2023-12-17', 57, 'Success', NULL),
    ('2023-12-18', 58, 'Failed', 'DIS10'),
    ('2023-12-19', 59, 'Success', NULL),
    ('2023-12-20', 60, 'Success', 'DIS30'),
    ('2023-12-01', 61, 'Success', NULL),
    ('2023-12-02', 62, 'Success', 'DIS10'),
    ('2023-12-03', 63, 'Failed', NULL),
    ('2023-12-04', 64, 'Success', 'DIS30'),
    ('2023-12-05', 65, 'Success', NULL),
    ('2023-12-06', 66, 'Failed', 'DIS50'),
    ('2023-12-07', 67, 'Success', NULL),
    ('2023-12-08', 68, 'Success', 'DIS70'),
    ('2023-12-09', 69, 'Failed', NULL),
    ('2023-12-10', 70, 'Success', 'DIS10'),
    ('2023-12-11', 71, 'Success', NULL),
    ('2023-12-12', 72, 'Failed', 'DIS30'),
    ('2023-12-13', 73, 'Success', NULL),
    ('2023-12-14', 74, 'Success', 'DIS50'),
    ('2023-12-15', 75, 'Failed', NULL),
    ('2023-12-16', 76, 'Success', 'DIS70'),
    ('2023-12-17', 77, 'Success', NULL),
    ('2023-12-18', 78, 'Failed', 'DIS10'),
    ('2023-12-19', 79, 'Success', NULL),
    ('2023-12-20', 80, 'Success', 'DIS30');

INSERT INTO transactions_order (transaction_id, flight_code, type, airfare, price, quantity, total)
VALUES
    (1, 'FL0001', 'Business', 'BHANSGN', 750.0, 2, 1500.0),
    (1, 'FL0002', 'Economy', 'EHANDAD', 450.0, 1, 450.0),
    (2, 'FL0003', 'Business', 'BSGNHAN', 720.0, 3, 2160.0),
    (2, 'FL0004', 'Business', 'BDADHAN', 825.0, 2, 1650.0),
    (3, 'FL0005', 'Economy', 'ESGNDAD', 520.0, 1, 520.0),
    (3, 'FL0006', 'Business', 'BDADSGN', 795.0, 2, 1590.0),
    (4, 'FL0061', 'Business', 'BHANSGN', 750.0, 1, 750.0),
    (4, 'FL0062', 'Economy', 'EHANDAD', 450.0, 2, 900.0),
    (5, 'FL0063', 'Business', 'BSGNHAN', 720.0, 1, 720.0),
    (5, 'FL0064', 'Business', 'BDADHAN', 825.0, 3, 2475.0),
    (6, 'FL0065', 'Economy', 'ESGNDAD', 520.0, 2, 1040.0),
    (6, 'FL0066', 'Business', 'BDADSGN', 795.0, 1, 795.0),
    (7, 'FL0001', 'Economy', 'EHANSGN', 500.0, 3, 1500.0),
    (7, 'FL0002', 'Business', 'BHANDAD', 675.0, 2, 1350.0),
    (8, 'FL0003', 'Economy', 'ESGNHAN', 480.0, 1, 480.0),
    (8, 'FL0004', 'Business', 'BDADHAN', 825.0, 3, 2475.0),
    (9, 'FL0005', 'Business', 'BSGNDAD', 780.0, 2, 1560.0),
    (9, 'FL0006', 'Economy', 'EDADSGN', 530.0, 1, 530.0),
    (10, 'FL0061', 'Economy', 'EHANSGN', 500.0, 2, 1000.0),
    (10, 'FL0062', 'Business', 'BHANDAD', 675.0, 1, 675.0),
    (11, 'FL0001', 'Business', 'BHANSGN', 750.0, 2, 1500.0),
    (11, 'FL0002', 'Economy', 'EHANDAD', 450.0, 1, 450.0),
    (12, 'FL0003', 'Business', 'BSGNHAN', 720.0, 3, 2160.0),
    (12, 'FL0004', 'Business', 'BDADHAN', 825.0, 2, 1650.0),
    (13, 'FL0005', 'Economy', 'ESGNDAD', 520.0, 1, 520.0),
    (13, 'FL0006', 'Business', 'BDADSGN', 795.0, 2, 1590.0),
    (14, 'FL0061', 'Business', 'BHANSGN', 750.0, 1, 750.0),
    (14, 'FL0062', 'Economy', 'EHANDAD', 450.0, 2, 900.0),
    (15, 'FL0063', 'Business', 'BSGNHAN', 720.0, 1, 720.0),
    (15, 'FL0064', 'Business', 'BDADHAN', 825.0, 3, 2475.0),
    (16, 'FL0065', 'Economy', 'ESGNDAD', 520.0, 2, 1040.0),
    (16, 'FL0066', 'Business', 'BDADSGN', 795.0, 1, 795.0),
    (17, 'FL0001', 'Economy', 'EHANSGN', 500.0, 3, 1500.0),
    (17, 'FL0002', 'Business', 'BHANDAD', 675.0, 2, 1350.0),
    (18, 'FL0003', 'Economy', 'ESGNHAN', 480.0, 1, 480.0),
    (18, 'FL0004', 'Business', 'BDADHAN', 825.0, 3, 2475.0),
    (19, 'FL0005', 'Business', 'BSGNDAD', 780.0, 2, 1560.0),
    (19, 'FL0006', 'Economy', 'EDADSGN', 530.0, 1, 530.0),
    (20, 'FL0061', 'Economy', 'EHANSGN', 500.0, 2, 1000.0),
    (20, 'FL0062', 'Business', 'BHANDAD', 675.0, 1, 675.0),
    (21, 'FL0007', 'Business', 'BHANSWF', 900.0, 2, 1800.0),
    (21, 'FL0008', 'Economy', 'ESWFHAN', 620.0, 1, 620.0),
    (22, 'FL0009', 'Business', 'BHANHND', 825.0, 3, 2475.0),
    (22, 'FL0010', 'Business', 'BHNDHAN', 885.0, 2, 1770.0),
    (23, 'FL0011', 'Economy', 'EHANBGH', 700.0, 1, 700.0),
    (23, 'FL0012', 'Business', 'BBGHHAN', 1020.0, 2, 2040.0),
    (24, 'FL0013', 'Economy', 'EHANNAY', 750.0, 1, 750.0),
    (24, 'FL0014', 'Business', 'BNAYHAN', 1080.0, 2, 2160.0),
    (25, 'FL0067', 'Business', 'BHANSWF', 900.0, 2, 1800.0),
    (25, 'FL0068', 'Economy', 'ESWFHAN', 620.0, 1, 620.0),
    (26, 'FL0069', 'Business', 'BHANHND', 825.0, 3, 2475.0),
    (26, 'FL0070', 'Business', 'BHNDHAN', 885.0, 2, 1770.0),
    (27, 'FL0071', 'Economy', 'EHANBGH', 700.0, 1, 700.0),
    (27, 'FL0072', 'Business', 'BBGHHAN', 1020.0, 2, 2040.0),
    (28, 'FL0073', 'Economy', 'EHANNAY', 750.0, 1, 750.0),
    (28, 'FL0074', 'Business', 'BNAYHAN', 1080.0, 2, 2160.0),
    (29, 'FL0007', 'Business', 'BHANSWF', 900.0, 2, 1800.0),
    (29, 'FL0008', 'Economy', 'ESWFHAN', 620.0, 1, 620.0),
    (30, 'FL0009', 'Business', 'BHANHND', 825.0, 3, 2475.0),
    (30, 'FL0010', 'Business', 'BHNDHAN', 885.0, 2, 1770.0),
    (31, 'FL0011', 'Economy', 'EHANBGH', 700.0, 1, 700.0),
    (31, 'FL0012', 'Business', 'BBGHHAN', 1020.0, 2, 2040.0),
    (32, 'FL0013', 'Economy', 'EHANNAY', 750.0, 1, 750.0),
    (32, 'FL0014', 'Business', 'BNAYHAN', 1080.0, 2, 2160.0),
    (33, 'FL0067', 'Business', 'BHANSWF', 900.0, 2, 1800.0),
    (33, 'FL0068', 'Economy', 'ESWFHAN', 620.0, 1, 620.0),
    (34, 'FL0069', 'Business', 'BHANHND', 825.0, 3, 2475.0),
    (34, 'FL0070', 'Business', 'BHNDHAN', 885.0, 2, 1770.0),
    (35, 'FL0071', 'Economy', 'EHANBGH', 700.0, 1, 700.0),
    (35, 'FL0072', 'Business', 'BBGHHAN', 1020.0, 2, 2040.0),
    (36, 'FL0073', 'Economy', 'EHANNAY', 750.0, 1, 750.0),
    (36, 'FL0074', 'Business', 'BNAYHAN', 1080.0, 2, 2160.0),
    (37, 'FL0007', 'Business', 'BHANSWF', 900.0, 2, 1800.0),
    (37, 'FL0008', 'Economy', 'ESWFHAN', 620.0, 1, 620.0),
    (38, 'FL0009', 'Business', 'BHANHND', 825.0, 3, 2475.0),
    (38, 'FL0010', 'Business', 'BHNDHAN', 885.0, 2, 1770.0),
    (39, 'FL0011', 'Economy', 'EHANBGH', 700.0, 1, 700.0),
    (39, 'FL0012', 'Business', 'BBGHHAN', 1020.0, 2, 2040.0),
    (40, 'FL0013', 'Economy', 'EHANNAY', 750.0, 1, 750.0),
    (40, 'FL0014', 'Business', 'BNAYHAN', 1080.0, 2, 2160.0);
    
-- Data for transaction_order
INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
VALUES
    (41, 'FL0015', 'Business', 2),
    (41, 'FL0016', 'Business', 1),
    (41, 'FL0017', 'Economy', 3),
    (41, 'FL0018', 'Economy', 2),
    (42, 'FL0019', 'Business', 1),
    (42, 'FL0020', 'Economy', 2),
    (42, 'FL0021', 'Business', 3),
    (42, 'FL0022', 'Economy', 1),
    (43, 'FL0015', 'Business', 1),
    (43, 'FL0016', 'Economy', 2),
    (44, 'FL0017', 'Business', 2),
    (44, 'FL0018', 'Economy', 1),
    (45, 'FL0019', 'Business', 3),
    (45, 'FL0020', 'Business', 1),
    (45, 'FL0021', 'Economy', 1),
    (46, 'FL0022', 'Business', 2),
    (47, 'FL0015', 'Economy', 1),
    (48, 'FL0016', 'Business', 2),
    (49, 'FL0017', 'Economy', 1),
    (49, 'FL0018', 'Business', 2),
    (50, 'FL0015', 'Business', 2),
    (50, 'FL0016', 'Economy', 1),
    (50, 'FL0017', 'Economy', 3),
    (50, 'FL0018', 'Business', 1),
    (51, 'FL0019', 'Economy', 2),
    (51, 'FL0020', 'Business', 3),
    (51, 'FL0021', 'Economy', 1),
    (51, 'FL0022', 'Business', 2),
    (52, 'FL0015', 'Business', 1),
    (52, 'FL0016', 'Business', 2),
    (53, 'FL0017', 'Economy', 1),
    (53, 'FL0018', 'Business', 2),
    (54, 'FL0019', 'Business', 3),
    (54, 'FL0020', 'Economy', 1),
    (55, 'FL0021', 'Business', 1),
    (55, 'FL0022', 'Economy', 2),
    -- Add more rows if needed
    (56, 'FL0015', 'Economy', 2),
    (56, 'FL0016', 'Business', 1),
    (56, 'FL0017', 'Economy', 1),
    (57, 'FL0018', 'Business', 2),
    (57, 'FL0019', 'Business', 3),
    (57, 'FL0020', 'Economy', 1),
    (58, 'FL0021', 'Business', 2),
    (58, 'FL0022', 'Business', 1),
    (59, 'FL0015', 'Economy', 2),
    (59, 'FL0016', 'Business', 1),
    (59, 'FL0017', 'Economy', 1),
    (59, 'FL0018', 'Business', 2),
    (60, 'FL0019', 'Business', 3),
    (60, 'FL0020', 'Business', 1),
    (60, 'FL0021', 'Economy', 1),
    (60, 'FL0022', 'Business', 2),
    -- Add more rows if needed
    (61, 'FL0026', 'Business', 1),
(61, 'FL0027', 'Economy', 2),
(61, 'FL0028', 'Business', 3),
(62, 'FL0029', 'Business', 2),
(62, 'FL0030', 'Economy', 1),
(63, 'FL0031', 'Business', 4),
(63, 'FL0032', 'Economy', 3),
(63, 'FL0033', 'Business', 2),
(64, 'FL0029', 'Business', 1),
(64, 'FL0030', 'Economy', 3),
(65, 'FL0031', 'Business', 2),
(65, 'FL0032', 'Economy', 1),
(65, 'FL0033', 'Business', 4),
(66, 'FL0026', 'Economy', 2),
(66, 'FL0027', 'Business', 1),
(67, 'FL0028', 'Economy', 4),
(68, 'FL0025', 'Business', 3),
(68, 'FL0026', 'Economy', 2),
(69, 'FL0027', 'Business', 1),
(69, 'FL0028', 'Economy', 3),
(70, 'FL0029', 'Business', 3),
(70, 'FL0030', 'Business', 2),
(70, 'FL0031', 'Economy', 1),
(71, 'FL0032', 'Economy', 4),
(71, 'FL0033', 'Business', 2),
(72, 'FL0026', 'Business', 1),
(72, 'FL0027', 'Economy', 3),
(73, 'FL0028', 'Business', 2),
(73, 'FL0029', 'Economy', 1),
(74, 'FL0030', 'Business', 4),
(75, 'FL0031', 'Economy', 2),
(75, 'FL0032', 'Business', 1),
(76, 'FL0033', 'Economy', 3),
(76, 'FL0026', 'Business', 2),
(77, 'FL0027', 'Business', 1),
(77, 'FL0028', 'Economy', 4),
(78, 'FL0029', 'Business', 3),
(78, 'FL0030', 'Economy', 2),
(79, 'FL0031', 'Business', 1),
(79, 'FL0032', 'Economy', 3),
(80, 'FL0033', 'Business', 1),
(80, 'FL0026', 'Economy', 2);

