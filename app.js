const express = require('express');
const { Pool } = require('pg');
const path = require('path');


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

// Set up a route to handle requests for My Booking data with optional filtering
app.get('/mybooking', async (req, res) => {
  try {
    const page = req.query.page || 1;
    const perPage = 6;
    const offset = (page - 1) * perPage;

    // Get start and end dates from query parameters
    const startDate = req.query.start_date;
    const endDate = req.query.end_date;

    // Construct the base SQL query
    let queryText = 'SELECT * FROM my_booking';

    // Add WHERE clause for date filtering if start and end dates are provided
    const queryValues = [];
    if (startDate && endDate) {
      queryText += ' WHERE start_date >= $1 AND end_date <= $2';
      queryValues.push(startDate, endDate);
    }

    queryText += ' LIMIT $3 OFFSET $4';

    const result = await pool.query({
      text: queryText,
      values: [...queryValues, perPage, offset],
    });

    const bookings = result.rows;

    // Fetch total records count for pagination
    let totalQueryText = 'SELECT COUNT(*) FROM my_booking';
    if (startDate && endDate) {
      totalQueryText += ' WHERE start_date >= $1 AND end_date <= $2';
    }

    const totalResult = await pool.query(totalQueryText, queryValues);
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
