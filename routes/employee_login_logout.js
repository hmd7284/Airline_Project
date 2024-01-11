const express = require("express");
const router = express.Router();
const db = require("../database");

router.post("/employee_login", async (req, res) => {
  const { email, password } = req.body;
  const client = await db.connect();
  try {
    const results = await client.query(
      "SELECT employee_id, password FROM employee WHERE email = $1",
      [email],
    );

    if (results.rows.length > 0) {
      const employee = results.rows[0];
      if (employee.password === password) {
        req.session.employeeID = employee.employee_id;
        res.redirect("/home_employee");
      } else {
        req.session.userInput = req.body;
        req.flash("error", "Password is not correct");
        res.redirect("/employee_login");
        return;
      }
    } else {
      req.session.userInput = req.body;
      req.flash("error", "Email is not registered");
      res.redirect("/employee_login");
      return;
    }
  } catch (error) {
    console.error("Error during employee login:", error);
    return res.status(500).json({ message: "Internal server error" });
  } finally {
    client.release();
  }
});

const { isLoggedInEmployee, isLoggedOutEmployee } = require("./middleware");
router.get("/employee_login", isLoggedOutEmployee, (req, res) => {
  res.render("employee_login.ejs", { message: req.flash("error") });
}); //if already logged in, redirect to dashboard

router.get("/employee_logout", isLoggedInEmployee, (req, res) => {
  req.session.destroy();
  res.redirect("/home");
});

module.exports = router;
