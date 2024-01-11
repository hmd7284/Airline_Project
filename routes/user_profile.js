const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedOut(req, res, next) {
  if (req.session.userId) {
    res.redirect("/user_profile");
  } else next();
}

function isLoggedIn(req, res, next) {
  if (req.session.userId) {
    next();
  } else res.redirect("/home");
}

async function fetchProfile(userId) {
  const client = await db.connect();
  try {
    const user = await db.query(
      "SELECT a.email, c.name, c.dob, c.address, c.phone_number FROM account a JOIN customers c ON a.id = c.id WHERE a.id = $1 and a.type = 'customer'",
      [userId],
    );
    return user.rows;
  } finally {
    client.release();
  }
}

router.get("/user_profile", isLoggedIn, async (req, res) => {
  const userId = req.session.userId;
  const profile = await fetchProfile(userId);
  const userInput = req.session.userInput || {};
  res.render("user_profile.ejs", { profile, userInput });
});

router.post("/user_profile/edit", isLoggedIn, async (req, res) => {
  const { name, dob, address, phone_number } = req.body;
  const userId = req.session.userId;
  const user = await fetchProfile(userId);
  const nameValue = name !== "" ? name : user[0].name;
  const dobValue = dob !== "" ? dob : user[0].dob;
  const addressValue = address !== "" ? address : user[0].address;
  const phoneValue = phone_number !== "" ? phone_number : user[0].phone_number;
  try {
    const result = await db.query(
      "UPDATE customers SET name = $1, dob = $2, phone_number = $3, address = $4 WHERE id = $5 RETURNING id",
      [
        nameValue,
        dobValue,
        phoneValue,
        addressValue,
        userId,
      ],
    );
    if (result.rows.length === 0) {
      req.session.userInput = req.body;
      req.flash("error", "Error updating profile");
      res.redirect("/user_profile");
      return;
    }
    req.flash("success", "Profile updated");
    res.redirect("/user_profile");
  } catch (error) {
    console.error("Error udpating profile:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post(
  "/user_profile/password",
  isLoggedIn,
  async (req, res) => {
    const { old_password, new_password, confirm_password } = req.body;
    const userId = req.session.userId;
    try {
      const result = await db.query(
        "SELECT password FROM account WHERE id = $1",
        [userId],
      );
      if (result.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error updating password");
        res.redirect("/user_profile");
        return;
      }
      const dbPassword = result.rows[0].password;
      if (old_password !== dbPassword) {
        req.session.userInput = req.body;
        req.flash("error", "Old password is incorrect");
        res.redirect("/user_profile");
        return;
      }
      if (new_password !== confirm_password) {
        req.session.userInput = req.body;
        req.flash("error", "Passwords do not match");
        res.redirect("/user_profile");
        return;
      }
      if (new_password === old_password) {
        req.session.userInput = req.body;
        req.flash("error", "New password cannot be the same as old password");
        res.redirect("/user_profile");
        return;
      }
      const updateResult = await db.query(
        "UPDATE account SET password = $1 WHERE id = $2 RETURNING id",
        [new_password, userId],
      );
      if (updateResult.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error updating password");
        res.redirect("/user_profile");
        return;
      }
      req.flash("success", "Password updated");
      res.redirect("/user_profile");
    } catch (error) {
      console.error("Error updating password:", error);
      res.status(500).send("Internal Server Error");
    }
  },
);
module.exports = router;
