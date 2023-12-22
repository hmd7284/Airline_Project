const express = require('express');
const { Pool } = require('pg');
const path = require('path');
const router = express.router


const app = express();
const port = 5500;

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: '181004',
  port: 5432,
});

pool.connect();

app.get('/my_booking', async (req, res) => {
  try {
    const page = req.query.page || 1;
    const perPage = 6;
    const offset = (page - 1) * perPage;

    let query = 'SELECT * FROM my_booking';
    const params = [perPage, offset];

    // Check if start_date and end_date are present in the request
    if (req.query.start_date && req.query.end_date) {
      query += ' WHERE start_date >= $3 AND end_date <= $4';
      params.push(req.query.start_date, req.query.end_date);
    }

    query += ' LIMIT $1 OFFSET $2';

    const result = await pool.query(query, params);
    const bookings = result.rows;

    const totalResult = await pool.query('SELECT COUNT(*) FROM my_booking');
    const totalRecords = totalResult.rows[0].count;
    const totalPages = Math.ceil(totalRecords / perPage);

    res.json({
      bookings,
      totalPages,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message || 'Internal Server Error' });
  }
});


// Serve your HTML page
app.use(express.static('public'));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'mybooking.html'));
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});