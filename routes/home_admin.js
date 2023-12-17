const express = require("express");
const router = express.Router();
const path = require("path");
const db = require("../database");
const bcrypt = require("bcrypt");

router.get("/home_admin", (req, res) => {
  res.render("home_admin.ejs");
});

router.get("/admin_login", (req, res) => {
  res.render("admin_login.ejs");
});
router.get("/airplane", (req, res) => {
  res.render("airplane.ejs");
});

router.get("/airport", (req, res) => {
  res.render("airport.ejs");
});

router.get("/flight_time", (req, res) => {
  res.render("flight_time.ejs");
});

router.get("/maintenance", (req, res) => {
  res.render("maintenance.ejs");
});

router.get("/revenue", (req, res) => {
  res.render("revenue.ejs");
});

router.get("/route", (req, res) => {
  res.render("route.ejs");
});

router.get("/sales", (req, res) => {
  res.render("sales.ejs");
});

router.get("/schedule", (req, res) => {
  res.render("schedule.ejs");
});

router.get("/staff", (req, res) => {
  res.render("staff.ejs");
});

router.get("/status", (req, res) => {
  res.render("status.ejs");
});

module.exports = router;
