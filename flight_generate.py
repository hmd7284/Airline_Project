import psycopg2
from datetime import datetime, timedelta
import random


db_params = {
    'host': 'localhost',
    'database': 'airline',
    'user': 'postgres',
    'password': '181004',
}


def seconds_to_hhmm(seconds):
    return str(timedelta(seconds=seconds))


connection = psycopg2.connect(**db_params)
cursor = connection.cursor()


cursor.execute('SELECT route FROM airfare')
routes = cursor.fetchall()


current_date = datetime.strptime('2024-01-01', '%Y-%m-%d')
flight_count = 0
departure_time = 3600

for i in range(15000):
    flight_code = 'FL{:05d}'.format(i + 1)
    route_code = random.choice(routes)[0]
    departure_time = (flight_count % 5) * 14400  
    duration = 2 * 3600 if i % 2 == 0 else 2.5 * 3600
    arrival_time = departure_time + duration


    aircraft_code = 'AC{:03d}'.format(random.randint(1, 999))


    cursor.execute('INSERT INTO flight_schedule (flight_code, departure_date, departure_time, arrival_date, arrival_time, aircraft, route) VALUES (%s, %s, %s, %s, %s, %s, %s)',
                   (flight_code, current_date.strftime('%Y-%m-%d'), seconds_to_hhmm(departure_time), current_date.strftime('%Y-%m-%d'), seconds_to_hhmm(arrival_time), aircraft_code, route_code))

    flight_count += 1
    if flight_count % 5 == 0:
        current_date += timedelta(days=1) 


connection.commit()
connection.close()
