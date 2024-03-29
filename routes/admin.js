const express = require("express");
const router = express.Router();
const db = require("../database");

function isLoggedInAdmin(req, res, next) {
  if (req.session.adminID) {
    next();
  } else res.redirect("/home");
}

function isLoggedOutAdmin(req, res, next) {
  if (req.session.adminID) {
    res.redirect("/home_admin");
  } else next();
}

router.get("/home_admin", (req, res) => {
  res.render("home_admin.ejs");
});

const loginlogoutRouter = require("./admin_login_logout");
const airportRouter = require("./airport");
const airplaneRouter = require("./airplane");
const scheduleRouter = require("./schedule");
const flightRouteRouter = require("./flight_route");
const staffRouter = require("./staff_admin");
const discountRouter = require("./sales");
const revenueRouter = require("./revenue");
const employeeRouter = require("./employee_list");
router.use("/", loginlogoutRouter);
router.use("/", airportRouter);
router.use("/", airplaneRouter);
router.use("/", scheduleRouter);
router.use("/", flightRouteRouter);
router.use("/", staffRouter);
router.use("/", discountRouter);
router.use("/", revenueRouter);
router.use("/", employeeRouter);
module.exports = router;
