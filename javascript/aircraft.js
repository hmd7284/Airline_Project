const express = require('express');
const { Pool } = require('pg');
const ejs = require('ejs');
const path = require('path');

const aircraft = express();
const port = 5500;

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'airline',
    password: '181004',
    port: 5432,
});

aircraft.set('views', path.join(__dirname, '../public')); 
aircraft.use(express.static(path.join(__dirname, '../public')));

aircraft.get('/', async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT * FROM aircraft');

        const pageSize = 20;
        const pageCount = Math.ceil(rows.length / pageSize);

        const currentPage = parseInt(req.query.page) || 1;

        const startIdx = (currentPage - 1) * pageSize;
        const endIdx = startIdx + pageSize;
        const aircraft = rows.slice(startIdx, endIdx);

        res.render('aircraft.ejs', {
            aircraft,
            pageCount,
            currentPage,
            startIdx,
        });
    } catch (error) {
        console.error('Error retrieving aircraft schedule data:', error);
        res.status(500).send('Internal Server Error');
    }
});

aircraft.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});