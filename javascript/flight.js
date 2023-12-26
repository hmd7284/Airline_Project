const express = require('express');
const { Pool } = require('pg');
const ejs = require('ejs');
const path = require('path');

const Flight = express();
const port = 5500;

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'airline',
    password: '181004',
    port: 5432,
});

Flight.set('view engine', 'ejs');
Flight.set('views', path.join(__dirname, '../public')); 
Flight.use(express.static(path.join(__dirname, '../public')));

Flight.get('/', async (req, res) => {
    try {
        // Retrieve flight schedule data from the database
        const { rows } = await pool.query('SELECT * FROM flight_schedule');

        // Paginate the data, 10 records per page
        const pageSize = 20;
        const pageCount = Math.ceil(rows.length / pageSize);

        // Get the current page number from the query parameter, default to 1
        const currentPage = parseInt(req.query.page) || 1;

        // Slice the data to display only the records for the current page
        const startIdx = (currentPage - 1) * pageSize;
        const endIdx = startIdx + pageSize;
        const flightSchedules = rows.slice(startIdx, endIdx);

        // Render the Flight.ejs template directly from the "public" directory
        res.render('Flight', {
            flightSchedules,
            pageCount,
            currentPage,
        });
    } catch (error) {
        console.error('Error retrieving flight schedule data:', error);
        res.status(500).send('Internal Server Error');
    }
});

Flight.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
