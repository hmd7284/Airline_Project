# Airline_Project Database-LAB(20231)

# Airline Management Website

In response to the highly competitive and dynamic nature of the airline
industry, KDD Airline has introduced a website and an associated airline
management database system. The primary objective is to facilitate efficient
management for both administrators and customers in accessing and handling
information pertaining to the airline's operations and services.

## Overview

### Datbase Schema

![Architecture](https://github.com/hmd7284/Airline_Project/blob/main/query/Relational_Model.png)

### Technical Specifications

- Frontend: EJS, CSS, Javascript
- Backend: ExpressJS
- Database: PostgreSQL

### Features

- Authentication: Login, signup, update password
- Authorization:
  - Restrict users, admin, guides what they can do
- Admin:
  - An admin account is provided
  - Airport, Airplane, Schedule, Route, Discount, Revenue, Employee, Staff
    management
- Employee:
  - An employee account is provided
  - Check working chedule
  - Update profile, change password
- Users:
  - Search for flights
  - Booking, cancel booking
  - Check booking history
  - Update profile, change password

## Setup

1. Clone the project from Github git clone
   https://github.com/hmd7284/Airline_Project.git
2. Install some essential libraries: `npm install`
3. Import & execute the SQL queries from the Database folder to the PostgreSQL
   database. Data needs to be inserted to countries and cities table first for
   the system to work properly.
4. Import the project in any IDE that support the aforementioned programming
   languages.
5. Deploy & Run the application with `npm run dev`

## Project Structure

    ├── pages               #EJS files # tables and queries used for this project
    ├── public
    ├── query               # tables and queries used for this project
    ├── routes              #JS files
    ├── .gitignore
    ├── README.md
    ├── database.js
    ├── index.js
    ├── package-lock.json
    └── package.json

## Collaborators

<table>
    <tbody>
        <tr>
            <th align="center">Member name</th>
            <th align="center">Student ID</th>
        </tr>
        <tr>
            <td>Nguyễn Trung Kiên</td>
            <td align="center"> 20226052&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td>Phùng Đức Đạt</td>
            <td align="center"> 20226025&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td>Hà Minh Đức</td>
            <td align="center"> 20226027&nbsp;&nbsp;&nbsp;</td>
        </tr>
    </tbody>
</table>
