const express = require('express');
const { Pool } = require('pg');
const ejs = require('ejs');
const path = require('path');
const bodyParser = require('body-parser');

const home = express();
const port = 5500;

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'airline',
  password: '181004',
  port: 5432,
});

// Sử dụng body-parser
home.use(bodyParser.urlencoded({ extended: true }));
home.set('views', path.join(__dirname, '../public')); 
home.use(express.static(path.join(__dirname, '../public')));

home.get('/', (req, res) => {
  res.render('home_user.ejs'); // Render view 'new.ejs'
});

home.post('/search', async (req, res) => {
  try {
    const { origin, destination, departureDate, numberOfTickets } = req.body;

    // Thực hiện query đến PostgreSQL
    const result = await pool.query(
        'SELECT fs.* FROM flight_schedule fs ' +
        'JOIN route r ON fs.route = r.route_code ' +
        'JOIN cities c1 ON r.origin = c1.city_code ' +
        'JOIN countries co1 ON c1.country = co1.country_code ' +
        'JOIN cities c2 ON r.destination = c2.city_code ' +
        'JOIN countries co2 ON c2.country = co2.country_code ' +
        'WHERE fs.departure_date >= $3 ' +
        'AND LOWER(co1.country_name) LIKE LOWER($1) ' +
        'AND LOWER(co2.country_name) LIKE LOWER($2) ',
      [origin, destination, departureDate]
    );

    console.log(result.rows);
    res.render('home_user.ejs', { results: result.rows });
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).send('Internal Server Error');
  }
});


home.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
