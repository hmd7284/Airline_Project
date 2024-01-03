-- Create Database
DROP DATABASE IF EXISTS airline;

CREATE DATABASE airline;

\c airline
-- Create Tables
CREATE TABLE aircraft (
    aircraft_code varchar(5) PRIMARY KEY,
    aircraft_name varchar(255) NOT NULL,
    capacity int NOT NULL,
    status varchar(30) NOT NULL,
    mfd_com varchar(30) NOT NULL,
    mfd_date date NOT NULL,
    CONSTRAINT ac_stt_check CHECK (status = 'Inactive' OR status = 'Active')
);

CREATE TABLE countries (
    country_code varchar(3) PRIMARY KEY,
    country_name varchar(255) NOT NULL
);

CREATE TABLE cities (
    city_code varchar(3) PRIMARY KEY,
    city_name varchar(255) NOT NULL,
    country varchar(3) NOT NULL,
    CONSTRAINT cit_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code)
);

CREATE TABLE airport (
    airport_code varchar(3) PRIMARY KEY,
    airport_name varchar(255) NOT NULL,
    address varchar(255),
    city varchar(3) NOT NULL,
    CONSTRAINT ap_ct_fk FOREIGN KEY (city) REFERENCES cities (city_code)
);

CREATE TABLE account (
    id serial PRIMARY KEY,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    type varchar(8) DEFAULT 'customer',
    CONSTRAINT chk_type CHECK (type = 'admin' OR type = 'customer')
);

CREATE TABLE customers (
    id int PRIMARY KEY,
    name varchar(255) NOT NULL,
    dob date NOT NULL,
    address varchar(255) NOT NULL,
    phone_number varchar(12),
    CONSTRAINT cus_acc_fk FOREIGN KEY (id) REFERENCES account (id) ON DELETE CASCADE
);

CREATE TABLE route (
    route_code varchar(6) PRIMARY KEY,
    origin varchar(3) NOT NULL,
    destination varchar(3) NOT NULL,
    CONSTRAINT rto_ap_fk FOREIGN KEY (origin) REFERENCES airport (airport_code),
    CONSTRAINT rtd_ap_fk FOREIGN KEY (destination) REFERENCES airport (airport_code)
);

CREATE TABLE airfare (
    airfare_code varchar(7) PRIMARY KEY,
    type VARCHAR(30) NOT NULL,
    route varchar(6) NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT af_rt_fk FOREIGN KEY (route) REFERENCES route (route_code),
    CONSTRAINT af_type_check CHECK (type = 'Economy' OR type = 'Business')
);

CREATE TABLE employee (
    employee_id serial PRIMARY KEY,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    phone_number varchar(12) NOT NULL
);

CREATE TABLE flight_schedule (
    flight_code varchar(6) PRIMARY KEY,
    departure_date date NOT NULL,
    departure_time time NOT NULL,
    arrival_date date NOT NULL,
    arrival_time time NOT NULL,
    status varchar(30),
    aircraft varchar(5) NOT NULL,
    route varchar(6) NOT NULL,
    business_seat integer,
    economy_seat integer,
    CONSTRAINT fsch_acr_fk FOREIGN KEY (aircraft) REFERENCES aircraft (aircraft_code),
    CONSTRAINT fsch_rt_fk FOREIGN KEY (route) REFERENCES route (route_code),
    CONSTRAINT fsch_check_date CHECK (arrival_date >= departure_date),
    CONSTRAINT fsch_check_stt CHECK (status = 'Success' or status = 'Canceled')
);

CREATE TABLE flight_staff (
    flight_code varchar(6) NOT NULL,
    employee_id int NOT NULL,
    PRIMARY KEY (flight_code, employee_id),
    CONSTRAINT staff_sch_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT staff_em_fk FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

CREATE TABLE discount (
    discount_code varchar(5) PRIMARY KEY,
    title varchar(255) NOT NULL,
    amount int NOT NULL,
    description text
);

-- Create the transactions table
CREATE TABLE transactions (
    transaction_id serial PRIMARY KEY,
    booking_date date NOT NULL,
    customer_id int NOT NULL,
    status varchar(10) DEFAULT 'Success',
    discount varchar(5),
    total_amount double precision DEFAULT 0,
    CONSTRAINT check_status CHECK (status = 'Success' OR status = 'Failed'),
    CONSTRAINT trans_dis_fk FOREIGN KEY (discount) REFERENCES discount (discount_code),
    CONSTRAINT trans_cus_fk FOREIGN KEY (customer_id) REFERENCES customers (id)
);

-- Create the transactions_order table
CREATE TABLE transactions_order (
    order_id serial,
    transaction_id integer REFERENCES transactions (transaction_id) ON DELETE CASCADE,
    flight_code varchar(6) NOT NULL,
    type VARCHAR(30),
    airfare varchar(7),
    price double precision,
    quantity integer NOT NULL,
    total double precision,
    CONSTRAINT trans_order_pk PRIMARY KEY (transaction_id, order_id),
    CONSTRAINT order_flight_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT order_airfare_fk FOREIGN KEY (airfare) REFERENCES airfare (airfare_code),
    CONSTRAINT af_type_check CHECK (type = 'Economy' OR type = 'Business')
);

CREATE OR REPLACE FUNCTION reset_order_id_sequence()
    RETURNS TRIGGER
    AS $$
BEGIN
    -- Reset the sequence to 1
    EXECUTE 'ALTER SEQUENCE transactions_order_order_id_seq RESTART WITH 1';
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Create a trigger to call the function after an insert on the transactions table
CREATE TRIGGER reset_order_id_trigger
    AFTER INSERT ON transactions
    FOR EACH STATEMENT
    EXECUTE FUNCTION reset_order_id_sequence ();
