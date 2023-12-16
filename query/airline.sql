-- Create Database
DROP DATABASE IF EXISTS airline;
CREATE DATABASE airline;
\ c airline;
-- Create Tables
CREATE TABLE aircraft (
    aircraft_code PRIMARY KEY,
    aircraft_name varchar(255),
    capacity bigint,
    status varchar(255),
    mfd_com varchar(255),
    mfd_date date
);
CREATE TABLE countries (
    country_code int PRIMARY KEY,
    country_name varchar(255)
);
CREATE TABLE cities (
    city_code varchar(10) PRIMARY KEY,
    city_name varchar(255),
    country varchar(10) NOT NULL,
    CONSTRAINT cit_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code)
);
CREATE TABLE airport (
    airport_code varchar(10) PRIMARY KEY,
    airport_name varchar(255),
    address varchar(255),
    city varchar(10) NOT NULL,
    CONSTRAINT ap_ct_fk FOREIGN KEY (city) REFERENCES cities (city_code)
);
CREATE TABLE account (
    account_code varchar(10) PRIMARY KEY,
    email varchar(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    type varchar(255) NOT NULL
);
CREATE TABLE customers (
    customer_code varchar(10) PRIMARY KEY,
    name varchar(255),
    address varchar(255),
    dob date,
    country varchar(10) NOT NULL,
    email varchar(255),
    phone_number varchar(20),
    CONSTRAINT cus_coun_fk FOREIGN KEY (country) REFERENCES countries (country_code),
    CONSTRAINT cus_acc_fk FOREIGN KEY (customer_code) REFERENCES account (account_code)
);
CREATE TABLE route (
    route_code varchar(10) PRIMARY KEY,
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
    employee_code varchar(10) PRIMARY KEY,
    name varchar(255),
    branch varchar(10),
    email varchar(255),
    phone_number varchar(20)
);
CREATE TABLE flight_schedule (
    flight_code varchar(10) PRIMARY KEY,
    flight_date date,
    departure time,
    arrival time,
    aircraft varchar(10) NOT NULL,
    route varchar(20) NOT NULL,
    CONSTRAINT fsch_acr_fk FOREIGN KEY (aircraft) REFERENCES aircraft (aircraft_code),
    CONSTRAINT fsch_rt_fk FOREIGN KEY (route) REFERENCES route (route_code)
);
CREATE TABLE flight_staff (
    flight_code varchar(10),
    employee_code varchar(10),
    PRIMARY KEY (flight_code, employee_code),
    CONSTRAINT staff_sch_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT staff_em_fk FOREIGN KEY (employee_code) REFERENCES employee (employee_code)
);
CREATE TABLE discount (
    discount_code varchar(10) PRIMARY KEY,
    title varchar(255),
    amount bigint,
    description text
);
CREATE TABLE transactions (
    transaction_code varchar(10) PRIMARY KEY,
    booking_date date,
    departure_date date,
    flight_code varchar(10) NOT NULL,
    status char,
    charges varchar(255),
    customer varchar(10) NOT NULL,
    airfare varchar(10) NOT NULL,
    num_of_airfare bigint,
    discount varchar(10) NOT NULL,
    total double precision,
    CONSTRAINT trans_flight_fk FOREIGN KEY (flight_code) REFERENCES flight_schedule (flight_code),
    CONSTRAINT trans_cus_fk FOREIGN KEY (customer) REFERENCES customers (customer_code),
    CONSTRAINT trans_fare_fk FOREIGN KEY (airfare) REFERENCES airfare (airfare_code),
    CONSTRAINT trans_dis_fk FOREIGN KEY (discount) REFERENCES discount (discount_code)
);
-- Insert Data