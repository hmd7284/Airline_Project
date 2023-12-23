const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'airline',
    password: '181004',
    port: 5432,
});

module.exports = pool;
