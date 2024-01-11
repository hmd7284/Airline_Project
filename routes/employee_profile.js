const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedInEmployee(req, res, next) {
  if (req.session.employeeID) {
    next();
  } else res.redirect("/home");
}

function isLoggedOutEmployee(req, res, next) {
  if (req.session.employeeID) {
    res.redirect("/home_employee");
  } else next();
}

async function fetchProfile(employeeID) {
  const client = await db.connect();
  try {
    const employee = await db.query(
      "SELECT first_name, last_name, gender, address, phone_number, ssn, email FROM employee WHERE employee_id = $1",
      [employeeID],
    );
    console.log("Employee profile:", employee.rows);
    return employee.rows;
  } finally {
    client.release();
  }
}

router.get("/employee_profile", isLoggedInEmployee, async (req, res) => {
  const employeeID = req.session.employeeID;
  const profile = await fetchProfile(employeeID);
  const userInput = req.session.userInput || {};
  res.render("employee_profile", { profile, userInput });
});

router.post("/employee_profile/edit", isLoggedInEmployee, async (req, res) => {
  const { first_name, last_name, gender, address, phone_number, ssn } =
    req.body;
  const employeeID = req.session.employeeID;
  const employee = await fetchProfile(employeeID);
  const firstnameValue = first_name !== ""
    ? first_name
    : employee[0].first_name;
  const lastnameValue = last_name !== "" ? last_name : employee[0].last_name;
  const genderValue = gender !== "" ? gender : employee[0].gender;
  const addressValue = address !== "" ? address : employee[0].address;
  const phoneValue = phone_number !== ""
    ? phone_number
    : employee[0].phone_number;
  const ssnValue = ssn !== "" ? ssn : employee[0].ssn;
  try {
    const result = await db.query(
      "UPDATE employee SET first_name = $1, last_name = $2, gender = $3, phone_number = $4, ssn = $5, address = $6 WHERE employee_id = $7 RETURNING employee_id",
      [
        firstnameValue,
        lastnameValue,
        genderValue,
        phoneValue,
        ssnValue,
        addressValue,
        employeeID,
      ],
    );
    if (result.rows.length === 0) {
      req.session.userInput = req.body;
      req.flash("error", "Error updating profile");
      res.redirect("/employee_profile");
      return;
    }
    req.flash("success", "Profile updated");
    res.redirect("/employee_profile");
  } catch (error) {
    console.error("Error udpating profile:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.post(
  "/employee_profile/password",
  isLoggedInEmployee,
  async (req, res) => {
    const { old_password, new_password, confirm_password } = req.body;
    const employeeID = req.session.employeeID;
    try {
      const result = await db.query(
        "SELECT password FROM employee WHERE employee_id = $1",
        [employeeID],
      );
      if (result.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error updating password");
        res.redirect("/employee_profile");
        return;
      }
      const dbPassword = result.rows[0].password;
      if (old_password !== dbPassword) {
        req.session.userInput = req.body;
        req.flash("error", "Old password is incorrect");
        res.redirect("/employee_profile");
        return;
      }
      if (new_password !== confirm_password) {
        req.session.userInput = req.body;
        req.flash("error", "Passwords do not match");
        res.redirect("/employee_profile");
        return;
      }
      if (new_password === old_password) {
        req.session.userInput = req.body;
        req.flash("error", "New password must be different from old password");
        res.redirect("/employee_profile");
        return;
      }
      const updateResult = await db.query(
        "UPDATE employee SET password = $1 WHERE employee_id = $2 RETURNING employee_id",
        [new_password, employeeID],
      );
      if (updateResult.rows.length === 0) {
        req.session.userInput = req.body;
        req.flash("error", "Error updating password");
        res.redirect("/employee_profile");
        return;
      }
      req.flash("success", "Password updated");
      res.redirect("/employee_profile");
    } catch (error) {
      console.error("Error updating password:", error);
      res.status(500).send("Internal Server Error");
    }
  },
);
module.exports = router;
