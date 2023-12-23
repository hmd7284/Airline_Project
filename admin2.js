const express = require('express');
const bodyParser = require('body-parser');
const pool = require('./db');

const admin2 = express();
const port = 5500;

admin2.use(bodyParser.urlencoded({ extended: true }));
admin2.use(bodyParser.json());

// Xử lý form
admin2.post('/addAirport', (req, res) => {
    const { airportCode, airportName, address, city } = req.body;
    pool.query('INSERT INTO airport (airport_code, airport_name, address, city) VALUES ($1, $2, $3, $4)', [airportCode, airportName, address, city], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(201).json({ message: 'Airport added successfully' });
    });
});

// Xử lý chức năng quản lý sân bay
admin2.post('/manageAirport', (req, res) => {
    const { actionType, airportCode, airportName, address, city } = req.body;

    if (actionType === 'add') {
        // Thực hiện truy vấn SQL để thêm dữ liệu vào bảng airport
        pool.query('INSERT INTO airport (airport_code, airport_name, address, city) VALUES ($1, $2, $3, $4)', [airportCode, airportName, address, city], (error, results) => {
            if (error) {
                throw error;
            }
            res.status(201).json({ message: 'Airport added successfully' });
        });
    } else if (actionType === 'delete') {
        // Thực hiện truy vấn SQL để xóa dữ liệu từ bảng airport
        pool.query('DELETE FROM airport WHERE airport_code = $1', [airportCode], (error, results) => {
            if (error) {
                throw error;
            }
            res.status(200).json({ message: 'Airport deleted successfully' });
        });
    }
});

// Lắng nghe các yêu cầu
admin2.listen(port, () => console.log(`Server is running on port ${port}`));
