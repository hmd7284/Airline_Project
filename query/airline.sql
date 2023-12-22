-- Create Database
DROP DATABASE IF EXISTS airline;

CREATE DATABASE airline;

\c airline;
-- Create Tables
CREATE TABLE aircraft (
    aircraft_code varchar(5) PRIMARY KEY,
    aircraft_name varchar(255),
    capacity int,
    status varchar(30),
    mfd_com varchar(30),
    mfd_date date,
    CONSTRAINT ac_stt_check CHECK(status = 'Inactive' OR status = 'Acticve')
);

CREATE TABLE countries (
    country_code varchar(3) PRIMARY KEY,
    country_name varchar(255)
);

CREATE TABLE cities (
    city_code varchar(3) PRIMARY KEY,
    city_name varchar(255),
    country varchar(3) NOT NULL,
    CONSTRAINT cit_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code)
);

CREATE TABLE airport (
    airport_code varchar(3) PRIMARY KEY,
    airport_name varchar(255),
    address varchar(255),
    city varchar(3) NOT NULL,
    CONSTRAINT ap_ct_fk FOREIGN KEY (city) REFERENCES cities (city_code)
);

CREATE TABLE account (
    id serial PRIMARY KEY,
    email varchar(255),
    password varchar(255),
    type varchar(8),
    CONSTRAINT chk_type CHECK (type = 'admin' OR type = 'customer')
);

CREATE TABLE customers (
    id int PRIMARY KEY,
    name varchar(255),
    address varchar(255),
    dob date,
    --country varchar(3),
    phone_number varchar(10),
    -- CONSTRAINT cus_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code),
    CONSTRAINT cus_acc_fk FOREIGN KEY (id) REFERENCES account (id)
);

CREATE TABLE route (
    route_code varchar(6) PRIMARY KEY,
    origin varchar(3) NOT NULL,
    destination varchar(3) NOT NULL,
    CONSTRAINT rto_ap_fk FOREIGN KEY (origin) REFERENCES airport (airport_code),
    CONSTRAINT rtd_ap_fk FOREIGN KEY (destination) REFERENCES airport (airport_code)
);

CREATE TABLE airfare (
    airfare_code varchar(6) PRIMARY KEY,
    TYPE VARCHAR(30),
    route varchar(6) NOT NULL,
    price double precision,
    CONSTRAINT af_rt_fk FOREIGN KEY (route) REFERENCES route (route_code)
);

CREATE TABLE employee (
    employee_code serial PRIMARY KEY,
    name varchar(255),
    email varchar(255),
    phone_number varchar(10)
);

CREATE TABLE flight_schedule (
    flight_code varchar(6) PRIMARY KEY,
    departure_date date,
    departure_time time,
    arrival_date date,
    arrival_time time,
    aircraft varchar(5) NOT NULL,
    route varchar(6) NOT NULL,
    remaining_seat integer,
    CONSTRAINT fsch_acr_fk FOREIGN KEY (aircraft) REFERENCES aircraft (aircraft_code),
    CONSTRAINT fsch_rt_fk FOREIGN KEY (route) REFERENCES route (route_code)
);

CREATE TABLE flight_staff (
    flight_code varchar(6) NOT NULL,
    employee_code int NOT NULL,
    PRIMARY KEY (flight_code, employee_code),
    CONSTRAINT staff_sch_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT staff_em_fk FOREIGN KEY (employee_code) REFERENCES employee (employee_code)
);

CREATE TABLE discount (
    discount_code varchar(5) PRIMARY KEY,
    title varchar(255),
    amount int,
    description text
);


-- Create the transactions table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    booking_date DATE NOT NULL,
    customer_id INT NOT NULL,
    status VARCHAR(10),
    discount VARCHAR(6),
    total_amount DOUBLE PRECISION,
    CONSTRAINT check_status CHECK(status = 'Success' OR status = 'Failed'),
    CONSTRAINT trans_dis_fk FOREIGN KEY (discount) REFERENCES discount (discount_code),
    CONSTRAINT trans_cus_fk FOREIGN KEY (customer_id) REFERENCES customers (id)
);
-- Create the transactions_order table
CREATE TABLE transactions_order (
    order_id INTEGER,
    transaction_id INTEGER REFERENCES transactions(transaction_id),
    flight_code VARCHAR(6) NOT NULL,
    airfare VARCHAR(6),
    price DOUBLE PRECISION,
    quantity INTEGER,
    total DOUBLE PRECISION,
    CONSTRAINT trans_order_pk PRIMARY KEY (transaction_id, order_id),
    CONSTRAINT order_flight_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule(flight_code),
    CONSTRAINT order_airfare_fk FOREIGN KEY (airfare) REFERENCES airfare(airfare_code)
);


-- Insert Data
INSERT INTO account (email, PASSWORD, type)
    VALUES ('admin@gmail.com', 'admin', 'admin');

