const express = require("express");
const router = express.Router();
const db = require("../database");

const { isLoggedInEmployee, isLoggedOutEmployee } = require("./middleware");
// router.get("/home_employee", isLoggedInEmployee, (req, res) => {
//   res.render("home_employee.ejs");
// });

const loginLogoutRouter = require("./employee_login_logout");
const homeEmployeeRouter = require("./home_employee");
router.use("/", loginLogoutRouter);
router.use("/", homeEmployeeRouter);
module.exports = router;
