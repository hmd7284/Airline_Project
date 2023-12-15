const express = require("express");
const router = express.Router();
const db = require("../database");
const bcrypt = require("bcrypt");

function isLoggedOut(req, res, next) {
    if (req.session.userId)
        res.redirect('/booking');
    else next();
}

function isLoggedIn(req, res, next) {
    if (req.session.userId)
        next();
    else res.redirect('/loginform');
}

router.post('/signup', async (req, res) => {
    const { email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const client = await pool.connect();

    try {
        await client.query('BEGIN');

        // Check if email already exists
        const result = await client.query('SELECT * FROM account WHERE email = $1', [email]);

        if (result.rows.length > 0) {
            // Email already registered
            req.flash('error', 'Email already registered');
            res.redirect('/signupform');
            await client.query('ROLLBACK');
        } else {
            // Insert new account
            await client.query('INSERT INTO account (email, password) VALUES ($1, $2)', [email, hashedPassword]);

            // Get the inserted account's ID
            const idResult = await client.query('SELECT account_code FROM account WHERE email = $1', [email]);
            const id = idResult.rows[0].id;

            // Insert into customer
            const { name, address, dob, country, phone } = req.body;
            await client.query('INSERT INTO customer VALUES ($1, $2, $3, $4, $5)', [account_code, fname, lname, dob, phone]);

            // Commit the transaction
            await client.query('COMMIT');
            res.redirect('/index');
        }
    } catch (error) {
        // Rollback on error
        await client.query('ROLLBACK');
        throw error;
    } finally {
        // Release the client back to the pool
        client.release();
    }
});

// Replace placeholder values with your actual database connection details

