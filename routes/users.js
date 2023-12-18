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
  // Check if password is provided
  if (!password) {
    req.flash("error", "Password is required");
    console.error("Error during sign up: Password is required");
    return res.redirect("/user_signup");
  }
  const hashedPassword = await bcrypt.hash(password, 10);
  const client = await db.connect();
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
      console.error("Error during sign up: Email already registered");
      res.redirect("/user_signup");
      await client.query("ROLLBACK");
    } else {
      // Insert new account
      await client.query(
        "INSERT INTO account (email, password, type) VALUES ($1, $2, $3)",
        [email, hashedPassword, "customer"],
      );
      const idResult = await client.query(
        "SELECT id FROM account WHERE email = $1",
        [email],
      );
      const id = idResult.rows[0].id;
      console.log(id);
      // Insert into customer
      const { name, dob, address, phone_number } = req.body;
      console.log(req.body.dob);
      await client.query(
        "INSERT INTO customers (id, name, address, dob, phone_number) VALUES ($1, $2, $3, $4, $5)",
        [
          id,
          name,
          address,
          dob,
          phone_number,
        ],
      );

      // Commit the transaction
      await client.query("COMMIT");
      console.log("User signed up");
      res.redirect("/user_login");
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

router.post("/user_login", async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    res.status(404).json({ message: "Please enter all fields" });
  } else {
    const login_client = await db.connect();

    try {
      // Select user from the database
      const result = await login_client.query(
        "SELECT * FROM account WHERE email = $1 AND type = $2",
        [email, "customer"],
      );

      if (result.rows.length > 0) {
        const user = result.rows[0];

        // Compare the password using bcrypt
        bcrypt.compare(password, user.password, (err, isMatch) => {
          if (err) throw err;

          if (isMatch) {
            // Set session userId
            req.session.userId = user.id;
            res.redirect("/home_user");
            console.log("User logged in");
          } else {
            req.flash("error", "Password is not correct");
            console.error("Error during sign in: Password is not correct");
            res.redirect("/user_login");
          }
        });
      } else {
        console.error("Error during sign in: Email is not registered");
        req.flash("error", "Email is not registered");
        res.redirect("/user_login");
      }
    } catch (error) {
      console.error("Error during sign in:", error);
      res.status(500).json({ message: "Internal server error" });
    } finally {
      // Release the client back to the pool
      login_client.release();
    }
  }
});

router.get("/user_login", isLoggedOut, (req, res) => {
  res.render("user_login.ejs", { message: req.flash("error") });
}); //if already logged in, redirect to /booking

router.get("/logout", isLoggedIn, (req, res) => {
  req.session.destroy();
  res.redirect("/user_login");
});

router.get("/user_signup", (req, res) => {
  res.render("user_signup.ejs", { message: req.flash("error") });
});

module.exports = router;
