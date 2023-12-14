const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg'); // Import Pool from pg module

const app = express();
const port = 5500;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Sửa tên biến thành 'dbPool' để tránh trùng lặp
const dbPool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'airline',
  password: '181004',
  port: 5432,
});
app.get('/', (req, res) => {
  res.send('Welcome to the GDC Airways Management System');
});

// Endpoint để thêm hoặc xóa máy bay
app.post('/manageAircraft', async (req, res) => {
  const { action, aircraftCode, aircraftName, capacity, status, mfdCom, mfdDate } = req.body;

  try {
    if (action === 'add') {
      // Thêm máy bay mới
      const result = await dbPool.query(
        'INSERT INTO aircraft (aircraft_code, aircraft_name, capacity, status, mfd_com, mfd_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
        [aircraftCode, aircraftName, capacity, status, mfdCom, mfdDate]
      );

      res.json({ success: true, message: 'Aircraft added successfully', aircraft: result.rows[0] });
    } else if (action === 'delete') {
      // Xóa máy bay
      const result = await dbPool.query('DELETE FROM aircraft WHERE aircraft_code = $1 RETURNING *', [aircraftCode]);

      if (result.rows.length > 0) {
        res.json({ success: true, message: 'Aircraft deleted successfully', aircraft: result.rows[0] });
      } else {
        res.json({ success: false, message: 'Aircraft not found' });
      }
    } else {
      // Hành động không hợp lệ
      res.status(400).json({ success: false, message: 'Invalid action' });
    }
  } catch (error) {
    console.error('Error managing aircraft:', error);
    res.status(500).json({ success: false, message: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
