const express = require("express");
const router = express.Router();
const db = require("../database");

router.post("/admin/login", (req, res) => {
  const { username, password } = req.body;
  if (!username | !password) {
    res.status(404).json({ message: "Please enter all fields" });
  } else {
    db.query(
      `select * from account where username='admin' and type = 'admin'`,
      (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
          const admin = results[0];
          if (admin.password === password) {
            session = req.session;
            session.adminID = admin.id;
            res.redirect("/admin/dashboard");
          } else {
            req.flash("error", "Password is not correct");
            res.redirect("/admin/login");
          }
        } else {
          req.flash("error", "Email is not registered");
          res.redirect("/admin/login");
        }
      },
    );
  }
});
