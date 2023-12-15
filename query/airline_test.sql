-- Create Database
DROP DATABASE IF EXISTS airline;

CREATE DATABASE airline;

\c airline;
-- Create Tables
CREATE TABLE aircraft (
    aircraft_code serial PRIMARY KEY,
    aircraft_name varchar(255),
    capacity int,
    status varchar(255),
    mfd_com varchar(255),
    mfd_date date
);

CREATE TABLE countries (
    country_code int PRIMARY KEY,
    country_name varchar(255)
);

CREATE TABLE cities (
    city_code int PRIMARY KEY,
    city_name varchar(255),
    country int NOT NULL,
    CONSTRAINT cit_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code)
);

CREATE TABLE airport (
    airport_code serial PRIMARY KEY,
    airport_name varchar(255),
    address varchar(255),
    city int NOT NULL,
    CONSTRAINT ap_ct_fk FOREIGN KEY (city) REFERENCES cities (city_code)
);

CREATE TABLE account (
    account_code serial PRIMARY KEY,
    email varchar(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    type varchar(255) NOT NULL,
    CONSTRAINT chk_type CHECK (type = "admin" OR type = "customer")
);

CREATE TABLE customers (
    customer_code serial PRIMARY KEY,
    name varchar(255),
    address varchar(255),
    dob date,
    country int NOT NULL,
    email varchar(255),
    phone_number varchar(12),
    CONSTRAINT cus_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code),
    CONSTRAINT cus_acc_fk FOREIGN KEY (customer_code) REFERENCES account (account_code)
);

CREATE TABLE route (
    route_code serial PRIMARY KEY,
    origin varchar(255) NOT NULL,
    destination varchar(255) NOT NULL,
    CONSTRAINT rto_ap_fk FOREIGN KEY (origin) REFERENCES airport (airport_code),
    CONSTRAINT rtd_ap_fk FOREIGN KEY (destination) REFERENCES airport (airport_code)
);

CREATE TABLE airfare (
    airfare_code varchar(10) PRIMARY KEY,
    TYPE VARCHAR(255),
    route varchar(20) NOT NULL,
    price double precision,
    CONSTRAINT af_rt_fk FOREIGN KEY (route) REFERENCES route (route_code)
);

CREATE TABLE employee (
    employee_code serial PRIMARY KEY,
    name varchar(255),
    branch varchar(10),
    email varchar(255),
    phone_number varchar(20)
);

CREATE TABLE flight_schedule (
    flight_code serial PRIMARY KEY,
    flight_date date,
    departure time,
    arrival time,
    aircraft int NOT NULL,
    route varchar(20) NOT NULL,
    CONSTRAINT fsch_acr_fk FOREIGN KEY (aircraft) REFERENCES aircraft (aircraft_code),
    CONSTRAINT fsch_rt_fk FOREIGN KEY (route) REFERENCES route (route_code)
);

CREATE TABLE flight_staff (
    flight_code serial NOT NULL,
    employee_code int NOT NULL,
    PRIMARY KEY (flight_code, employee_code),
    CONSTRAINT staff_sch_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT staff_em_fk FOREIGN KEY (employee_code) REFERENCES employee (employee_code)
);

CREATE TABLE discount (
    discount_code varchar(10) PRIMARY KEY,
    title varchar(255),
    amount int,
    description text
);

CREATE TABLE transactions (
    transaction_code serial PRIMARY KEY,
    booking_date date,
    departure_date date,
    flight_code varchar(10) NOT NULL,
    status char,
    charges varchar(255),
    customer int NOT NULL,
    airfare varchar(10) NOT NULL,
    num_of_airfare int,
    discount varchar(10) NOT NULL,
    total double precision,
    CONSTRAINT trans_flight_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT trans_cus_fk FOREIGN KEY (customer) REFERENCES customers (customer_code),
    CONSTRAINT trans_fare_fk FOREIGN KEY (airfare) REFERENCES airfare (airfare_code),
    CONSTRAINT trans_dis_fk FOREIGN KEY (discount) REFERENCES discount (discount_code)
);

-- Insert Data
INSERT INTO aircraft (aircraft_name, capacity, status, mfd_com, mfd_date)
    VALUES ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Boeing 787', 274, 'available', 'Boeing', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A350', 305, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A330', 269, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01'),
    ('Airbus A321', 184, 'available', 'Airbus', '2023-01-01');
