const express = require("express");
const router = express.Router();
const db = require("../database");

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
  const client = await db.connect();
  try {
    await client.query("BEGIN");
    const result = await client.query(
      "SELECT * FROM account WHERE email = $1 AND type = 'customer'",
      [email],
    );
    if (result.rows.length > 0) {
      req.flash("error", "Email already registered");
      res.redirect("/user_signup");
      await client.query("ROLLBACK");
    } else {
      const insertResult = await client.query(
        "INSERT INTO account (email, password) VALUES ($1, $2) RETURNING id",
        [email, password],
      );
      const id = insertResult.rows[0].id;
      const { name, dob, address, phone_number } = req.body;
      await client.query(
        "INSERT INTO customers (id, name, dob, address, phone_number) VALUES ($1, $2, $3, $4, $5)",
        [
          id,
          name,
          dob,
          address,
          phone_number,
        ],
      );
      await client.query("COMMIT");
      res.redirect("/user_login");
    }
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
});

router.post("/user_login", async (req, res) => {
  const { email, password } = req.body;
  const login_client = await db.connect();

  try {
    // Select user from the database
    const result = await login_client.query(
      "SELECT * FROM account WHERE email = $1",
      [email],
    );

    if (result.rows.length > 0) {
      const user = result.rows[0];

      if (user.password === password) {
        // Set session userId
        req.session.userId = user.id;
        req.flash("success", "You have successfully logged in");
        res.redirect("/home_user");
        console.log("User logged in");
      } else {
        req.flash("error", "Password is not correct");
        console.error("Error during sign in: Password is not correct");
        res.redirect("/user_login");
      }
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
});

router.get("/user_login", isLoggedOut, (req, res) => {
  res.render("user_login.ejs", { message: req.flash("error") });
}); //if already logged in, redirect to /booking

router.get("/user_logout", isLoggedIn, (req, res) => {
  req.session.destroy();
  res.redirect("/home");
});

router.get("/user_signup", (req, res) => {
  res.render("user_signup.ejs", { message: req.flash("error") });
});

const userProfile = require("./user_profile");
router.use("/", userProfile);
module.exports = router;
