const express = require('express');
const { Pool } = require('pg');
const ejs = require('ejs');
const path = require('path');
const bodyParser = require('body-parser');

const profile = express();
const port = 5500;

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'airline',
  password: '181004',
  port: 5432,
});

profile.use(bodyParser.urlencoded({ extended: true }));
profile.set('views', path.join(__dirname, '../public')); 
profile.use(express.static(path.join(__dirname, '../public')));

profile.get('/', (req, res) => {
  res.render('my_profile.ejs');
});

profile.post('/my_profile', async (req, res) => {
  try {
    const email = req.body.email;
    const result = await pool.query('SELECT customers.id, customers.name, customers.dob, customers.address, customers.phone_number FROM customers JOIN account ON customers.id = account.id WHERE account.email = $1;', [email]);
    const customer = result.rows[0];
    res.render('my_profile.ejs', { customer });
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).send('Internal Server Error');
  }
});

profile.post('/update_profile', async (req, res) => {
  try {
    const editedName = req.body.editedName;
    const editedDob = req.body.editedDob;
    const editedAddress = req.body.editedAddress;
    const editedPhoneNumber = req.body.editedPhoneNumber;
    const customerId = req.body.customerId;

    await pool.query(
      'UPDATE customers SET name = $1, dob = $2, address = $3, phone_number = $4 WHERE id = $5',
      [editedName, editedDob, editedAddress, editedPhoneNumber, customerId]
    );

    // Redirect back to the profile page after updating
    res.redirect('my_profile.ejs');
  } catch (error) {
    console.error('Error updating profile', error);
    res.status(500).send('Internal Server Error');
  }
});

profile.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

