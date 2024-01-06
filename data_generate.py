import psycopg2.extras
from random import randint, random
from datetime import date, timedelta
import numpy as np


db_params = {
    'host': 'localhost',
    'database': 'airline',
    'user': 'postgres',
    'password': '181004',
}


connection = psycopg2.connect(**db_params)
cursor = connection.cursor()


def random_quantity(min_val, max_val):
    return randint(min_val, max_val)


transactions_and_orders_data = [
    (
        date(2023, 1, 1) + timedelta(days=randint(0, 365)),
        randint(1, 1000),
        'Success' if i != 25 else 'Failed',  # Update status for entry 25
        np.random.choice([None, 'DIS10', 'DIS30', 'DIS50', 'DIS70'], p=[0.7, 0.15, 0.07, 0.05, 0.03])
    )
    for i in range(1, 30001)
]


for data in transactions_and_orders_data:
    insert_transactions_and_orders = """
    WITH transaction_data AS (
        INSERT INTO transactions (booking_date, customer_id, status, discount)
        VALUES ('{}', {}, '{}', {})
        RETURNING transaction_id
    )
    INSERT INTO transactions_order (transaction_id, flight_code, type, quantity)
    SELECT
        td.transaction_id,
        'FL' || LPAD(FLOOR(RANDOM() * 15000 + 1)::TEXT, 5, '0'),
        CASE
            WHEN RANDOM() < 0.1 THEN 'Business'  -- 4% probability for Business
            ELSE 'Economy'
        END,
        CASE
            WHEN RANDOM() < 0.1 THEN 1  -- 4% probability for 1 quantity
            ELSE {}
        END
    FROM transaction_data td
    WHERE td.transaction_id IS NOT NULL;
    """.format(data[0], data[1], data[2], 'NULL' if data[3] is None else "'{}'".format(data[3]), random_quantity(1, 2))

    cursor.execute(insert_transactions_and_orders)
    connection.commit()

cursor.close()
connection.close()
