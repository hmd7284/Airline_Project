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

const loginlogoutRouter = require("./admin_login_logout");
const airportRouter = require("./airport");
const airplaneRouter = require("./airplane");
const scheduleRouter = require("./schedule");
const flightRouteRouter = require("./flight_route");
const staffRouter = require("./staff_admin");
const discountRouter = require("./sales");
const revenueRouter = require("./revenue");
router.use("/", loginlogoutRouter);
router.use("/", airportRouter);
router.use("/", airplaneRouter);
router.use("/", scheduleRouter);
router.use("/", flightRouteRouter);
router.use("/", staffRouter);
router.use("/", discountRouter);
router.use("/", revenueRouter);

module.exports = router;
