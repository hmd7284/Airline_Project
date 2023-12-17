const express = require("express");
const router = express.Router();
const db = require("../database");
const bcrypt = require("bcrypt");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/home_user");
  } else next();
}

function isLoggedIn(req, res, next) {
  if (req.session.userId) {
    next();
  } else res.redirect("/user_login");
}

router.post("/user_signup", async (req, res) => {
  const { email, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // Check if email already exists
    const result = await client.query(
      "SELECT * FROM account WHERE email = $1",
      [email],
    );

    if (result.rows.length > 0) {
      // Email already registered
      req.flash("error", "Email already registered");
      res.redirect("/user_signup");
      await client.query("ROLLBACK");
    } else {
      // Insert new account
      await client.query(
        "INSERT INTO account (email, password) VALUES ($1, $2)",
        [email, hashedPassword],
      );

      const idResult = await client.query(
        "SELECT id FROM account WHERE email = $1",
        [email],
      );
      const id = idResult.rows[0].id;

      // Insert into customer
      const { name, address, dob, country, phone_number } = req.body;
      await client.query(
        "INSERT INTO customer VALUES ($1, $2, $3, $4, $5, $6)",
        [
          id,
          name,
          address,
          dob,
          country,
          phone_number,
        ],
      );

      // Commit the transaction
      await client.query("COMMIT");
      res.redirect("/home_user");
    }
  } catch (error) {
    // Rollback on error
    await client.query("ROLLBACK");
    throw error;
  } finally {
    // Release the client back to the pool
    client.release();
  }
});

module.exports = router;
