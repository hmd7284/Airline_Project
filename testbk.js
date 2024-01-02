const express = require('express');
const { Client } = require('pg');

const testbk = express();
const port = 5500;

const client = new Client({
  user: 'postgres',
  host: 'localhost',
  database: 'airline',
  password: '181004',
  port: 5432,
});

client.connect();

testbk.use(express.static('public')); // Serve static files from the "public" directory

async function getFlightInfo(flightCode, ticketType) {
  try {
    const result = await client.query(
      'SELECT fs.flight_code, fs.departure_date, fs.departure_time, fs.arrival_date, fs.arrival_time, fs.aircraft, fs.route, fs.business_seat, fs.economy_seat, r.origin, r.destination, af.price, af.type ' +
      'FROM flight_schedule fs ' +
      'INNER JOIN route r ON fs.route = r.route_code ' +
      'INNER JOIN airfare af ON fs.route = af.route AND af.type = $1 ' +
      'WHERE fs.flight_code = $2 AND af.type = $3',
      [ticketType, flightCode, ticketType]
    );
    return result.rows[0];
  } catch (error) {
    console.error('Error executing SQL query:', error);
    throw error;
  }
}




// Handle GET request for /getFlightInfo
testbk.get('/getFlightInfo', async (req, res) => {
  const { flight_code, type } = req.query;

  try {
    const flightInfo = await getFlightInfo(flight_code, type);
    res.json(flightInfo);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Handle other routes (e.g., root route)
testbk.get('*', (req, res) => {
  res.sendFile(__dirname + '/public/user_booking.html'); // Adjust the path based on your file structure
});

testbk.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
