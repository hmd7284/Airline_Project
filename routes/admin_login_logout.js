const express = require("express");
const router = express.Router();
const db = require("../database");

router.post("/admin_login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const client = await db.connect();
    const results = await client.query(
      "SELECT * FROM account WHERE email = $1 AND type = $2",
      [email, "admin"],
    );

    if (results.rows.length > 0) {
      const admin = results.rows[0];
      if (admin.password === password) {
        req.session.adminID = admin.id;
        res.redirect("/home_admin");
      } else {
        req.flash("error", "Password is not correct");
        res.redirect("/admin_login");
      }
    } else {
      req.flash("error", "Email is not registered");
      res.redirect("/admin_login");
    }
  } catch (error) {
    console.error("Error during admin login:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
});

const { isLoggedInAdmin, isLoggedOutAdmin } = require("./middleware");
router.get("/admin_login", isLoggedOutAdmin, (req, res) => {
  res.render("admin_login.ejs", { message: req.flash("error") });
}); //if already logged in, redirect to /adminDashboard

router.get("/admin_logout", isLoggedInAdmin, (req, res) => {
  req.session.destroy();
  res.redirect("/home");
});

module.exports = router;
